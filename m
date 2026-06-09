Return-Path: <netdev+bounces-297350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PizbM9WiKGoAHAMAu9opvQ
	(envelope-from <netdev+bounces-297350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE1C664CEB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:33:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=XRcke140;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297350-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297350-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D0A3064E36
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 23:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97F3F0AB3;
	Tue,  9 Jun 2026 23:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B883EFFBA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 23:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047817; cv=none; b=WPNPEZLP4eNkG2DEVpBK43pDZjtFFEzBPMzLNLAZLr9rz9VCvvv+PF1Bnncvh8KvPKPJnHVEMOPTtog5tEa/7MY+UZA3R1Yb2KkfaAd36cgE/f0a+TwFjHMgmmgm3yX5aElOnPAJBFbz/FZll5IczYaYEliqgjdBm1Ghyr7zZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047817; c=relaxed/simple;
	bh=10rYPeh3lysa5wDtoLmtgj3NBxRuVsL+MD4nPwEsK2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fb64vgZ9VvsiO3Ks2T22R7a/ceOS27ZtKhvfzPyJZyRKOMARLlVLdl71rh2UW8TOQHfeZvMowcafoTMu02cqP7QRpOq4pzBjNmXj0RKNol+l6tPLcLw5PqWHsanAzX+l9sHiwlC25A6e9RqALuARMKGr6Awg2k5KeKB9UMZSp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=XRcke140; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91574384cc2so703823985a.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781047815; x=1781652615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj2TTUGE9JGo0G5Kz2j/PUb2+++ltpKUn7Tzej8LBcI=;
        b=XRcke140TRbAxnVD/y9/6WWBAwMiuDFOBiInkoNu2wFLbEeAf/CeUtrcdclW7jqe2+
         Jd9KKVXdGf1qISepTacnj46mptCtiJUrSoZVV5zqo+4nRaoPgHZ8gYYte8VKctKOTByB
         aYxJG12WXFE5gdXDSvEM3XcGVXvXjANLoqs8HTl70zZCmBiK6cLpQocUQ6pXP+rNuomO
         HV5MMshPa68c9gBr6+l7Yjy5RBo5WPKthtpsLkHdqfbirYfHXI065CevtlFsnhE7A5y4
         IHIDf83eASW6FNIn23sNWCAw30qGYrbVODwVVZ0rWyymVr+108KwzXrGuqFI+aHdkaHS
         DwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781047815; x=1781652615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj2TTUGE9JGo0G5Kz2j/PUb2+++ltpKUn7Tzej8LBcI=;
        b=IsYJe8T6TlmaNGtZ8qMxVCMxrHPzTaGAbA+6LSj64fN0BsaVck+LZ7WmfdUsWkJ0L1
         0JqDgJxE4bW/2lwgS+Nf90DhxOLSpmQWGHXvc9dfkDLKhbG8DAkbrCDsQ9cpMVMarHdh
         2D9fiRilclRkXeB3v0ZuoYxH1vDerZIBW3nfz0i/ihBP85SYN6M0e+8WHPUPWn+8a1uq
         jzmvFm+3mvCWIYylL1Bt96CM6mbzQtxNC/5T1iyS1wm5VwgMImwQB3r3S5Yn/JVhKtB6
         QG+k3O7o6TC8AkvIL6uffKeQWDEVYgo1gA+1fPEV+tVLOEq3qszYPGOStQePaTLaasnr
         NhKA==
X-Forwarded-Encrypted: i=1; AFNElJ/SOe1spdHOwmca95o5+KmYtcadwCBlZo0HCCMwLPKTaNiegrwI02ilfpqYxwDvgERzn1v/xLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ahtWlgQTMM88okDFkNkppy2TPVl6YgFovfGntIWl+O1/Gn3T
	y17y0bV7Knav69k6eRAF4dmuBmzWoNri7Rqn+Z1ZgnjMWcmgBT4wgCyHj9X7Zcjz1Tk=
X-Gm-Gg: Acq92OHrOZlSl3nM9qgX/nybLVc7oY1AfYnNPwk1LlQIBIXhBoth2XzA4BvUeQmmX8Q
	Ppbqx58z1P0bNK+323nwUVqifChwmUqk10q/3NGKUoUO/B00NWCm6L0tuTizw4ypAMtyDLNBIh/
	uqBKayW5MjQVH9mI/lXnl0w5sHSJsWIxdGV+pcl7f1XyD6Z3mqhUq3Xrr+D7GbawBmeUYqxhhhP
	3x+/pHfialA0IXcxRFuwRD6UuqRHoc3NNuCU2AQiDQsR2aGewpEjIFA3dq7RZvJvSFVshgx2+QR
	l1b8I8rZSseAXlkV+etTFL1N6sMT/52skHGP0uUZ+AfNGQSfF6XiyNIHJUT3Q5D6pN1IL7hpbO7
	QXPdnvdIJ2Vxd2FDqftn3AL0W7gp8XlIPVAxfbKKTNyXmo7OTpT38CDanJItc43MorJSsJdT7C7
	+J+txxrzgQ1LuXFaU4hVCxnNwWz2c7m+UEptg8h6YlJQotMSdV
X-Received: by 2002:a05:620a:649c:b0:915:9f87:eaaa with SMTP id af79cd13be357-915e8316469mr811336685a.42.1781047815198;
        Tue, 09 Jun 2026 16:30:15 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a37cae4sm2247735485a.29.2026.06.09.16.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 16:30:14 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net (moderated list:CAKE QDISC),
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net/sched: cake: reject overhead values that underflow length
Date: Tue,  9 Jun 2026 23:29:36 +0000
Message-ID: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297350-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DE1C664CEB

CAKE accepts overhead values that can make adjusted packet length
arithmetic underflow.  A negative effective length can wrap through
unsigned arithmetic and become a large value.

Such configurations make rate accounting depend on integer wraparound
rather than on the packet size userspace intended to model.

Validate overhead settings before using them in adjusted length
calculations.

Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the rate shaper")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Add fixes tag

 net/sched/sch_cake.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 5862933be8d7..03972e5525b5 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2308,12 +2308,18 @@ static void cake_reset(struct Qdisc *sch)
 		cake_clear_tin(sch, c);
 }
 
+static const struct netlink_range_validation_signed cake_overhead_range = {
+	.min = -64,
+	.max = 256,
+};
+
 static const struct nla_policy cake_policy[TCA_CAKE_MAX + 1] = {
 	[TCA_CAKE_BASE_RATE64]   = { .type = NLA_U64 },
 	[TCA_CAKE_DIFFSERV_MODE] = { .type = NLA_U32 },
 	[TCA_CAKE_ATM]		 = { .type = NLA_U32 },
 	[TCA_CAKE_FLOW_MODE]     = { .type = NLA_U32 },
-	[TCA_CAKE_OVERHEAD]      = { .type = NLA_S32 },
+	[TCA_CAKE_OVERHEAD]      =
+		NLA_POLICY_FULL_RANGE_SIGNED(NLA_S32, &cake_overhead_range),
 	[TCA_CAKE_RTT]		 = { .type = NLA_U32 },
 	[TCA_CAKE_TARGET]	 = { .type = NLA_U32 },
 	[TCA_CAKE_AUTORATE]      = { .type = NLA_U32 },
-- 
2.43.0


