Return-Path: <netdev+bounces-296791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /qkFCS1ZJ2ojvAIAu9opvQ
	(envelope-from <netdev+bounces-296791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B965B464
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=Qom2a5Es;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296791-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296791-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 691443021732
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1939FD9;
	Tue,  9 Jun 2026 00:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5C35966
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:06:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963565; cv=none; b=DwVN5ajKdI880ugyUU0oxOxDUl5KCLZZuH0xyNwJkbnBvhnf3rYswAeTln+6VeiEYgGwyizX6nrpAiAQxc6BNLSfOtug43SN0k6i3w7yqiZr/EfaHnAmpyzbCpLNBIWKQzSJcx75DD2nUR9Mdtc3OZdYULfb0t8autfzMwh4yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963565; c=relaxed/simple;
	bh=Y/vz4aryvSoTDYHMmTTjcabFKm0NEGNxBx8wFJNiVvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gqk3Cj19cxWfvkPjp46ctESQ0BK54aVg5csXITCXmEw+4CK+XWmH/0Lrm7coFHheL6/9zMnTbl8HVemabLoiXRg1uHvSZtX6DRCdtqEjUzlX04iGFhI4HsMj8d2BO2e4StFrx/H1mmE603zeTYfAGcefqF2hq/gNlomtrnfy6tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Qom2a5Es; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9156b74006aso355332985a.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780963563; x=1781568363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cKIVc3iYY7EOPxTwVj4oTrI6pPe5zXEw+1M3EAqLh/8=;
        b=Qom2a5Esa0Yp7zogNOklV5IDsvy8/CSJHGnqLdFLzDSuEcxSQMx29UPr1bnMMjYj7/
         2ReP7KSvIlg0xex7wNjSNobGurYlxv4SxXitWMK5r3Im1UXcfVIt3sm1Mo2g8x2Relx9
         9+josButKQV2UX61qMH26/BmTxtVoUFvH39yk6hLHNXfc/2+PWTn66j6TxtHY6TmrLVF
         NBizFXUrwXHRoA7Ih+rdMEt7uPK+jmXjMPCAEeMao+1F7BaDkmAiXCvm5QjnLgByPRS1
         OEnUceFYX8mJ6tjMb1H8ekK48IvlmM5RZ792kqeZtiYvRThLEfe0CVI+anRdqR7qGTk1
         zvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963563; x=1781568363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKIVc3iYY7EOPxTwVj4oTrI6pPe5zXEw+1M3EAqLh/8=;
        b=Ww94WLek8zxMT5MTlBWrvpnjgoyvo6BVs/71T5bpsjnX8bcQyyG2o/klkzT2IcQV/c
         4bQhQU25r2P1/ZG/K5PLrzK9wZ5HiWupGzZKn6tjYpdhSSzHNcAQhA6V7En79hATJDdM
         ujRU99PLBpNSkECMy9qXHyZbkeUpzpxkJvux+ixxJqSBpNs4pnBQ+QS4jDoZdvVU/6l1
         Hd9C7rcUge3RepfugmP37kxXHU49idoiXCS3otnQPQepqkCGYi7ConuX9Y/xTMtbysc4
         DyqB/r+wX7Qlo0wbPGhu+ZaL59Gbygen1eaDNhetRZJ0qJ0M1Awqkxwipx3fO8h02VyK
         EcXw==
X-Forwarded-Encrypted: i=1; AFNElJ8r7CWk0uPbUO9uqHalAodq6nra2acR89E4trytYIwOaxKIWQIYYJa2xbMPF8IbGQx/krmg9Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wv+BHaIp3wBMuzSOsg2Kf08kYhUnO83E2OoLnDvC95YK4WAu
	lS1WZEIQurVWvqgrwSjhovRWOS6vFFOVSrgOfry8YBs0u9w+6UaNsrTytgrWiJrPjcWmLIFHJLV
	wsvlZF/c=
X-Gm-Gg: Acq92OHeMmMDW2siQf8EFtEdYQdNQ9qTSIiXuQflZYJQY75ANqO1FNcUHe8mgWKg8Q9
	iYiCw8GBW7WSjdgzHphjRMYLuRVXY6paKwM8I3t4ey8QuXfJ1Zpckjl1c4IUnj/kP2htrZD5/S2
	ERaupQRccfkqpsJHEspDBH0XC3jkt3eVjra0W9ZPjjCnnS/Pn5UQ5vcqk+SXHsrXzC2trvZgU+g
	Nsn1N7dtCoGYJjbdKsIWUjiW7OxK8gYyXw9SKR47V5pbMJ4SHYJWDhlqfR1yO7uGsbCu2D4Rlvp
	IxLhP/fREGQ5DLffmYIPi1T68LlOPdXB+X+zoxpophCU+qEmdijPmU7+vcHHVuyf2McSef+fcWl
	tjlww9HYfBdUpCoW59CTkJ7v3X3Fzx/cNHiHBAUCsiGLxP8b9Fh+AzXNi3TbeDnX0v04hxqJ2Hm
	ROwWw0sBepEtPQ/Pm/etiTiEVi1Unje/QHxzlVjQ==
X-Received: by 2002:a05:620a:4590:b0:915:89d4:df22 with SMTP id af79cd13be357-915a9db5d00mr2823551485a.50.1780963563183;
        Mon, 08 Jun 2026 17:06:03 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a3bf5dasm1896316485a.36.2026.06.08.17.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:06:01 -0700 (PDT)
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
Subject: [PATCH] net/sched: cake: reject overhead values that underflow length
Date: Tue,  9 Jun 2026 00:00:59 +0000
Message-ID: <20260609000059.1234072.bc8844db0200.cake-overhead-underflow@trailofbits.com>
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
	TAGGED_FROM(0.00)[bounces-296791-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 816B965B464

CAKE accepts overhead values that can make adjusted packet length
arithmetic underflow.  A negative effective length can wrap through
unsigned arithmetic and become a large value.

Such configurations make rate accounting depend on integer wraparound
rather than on the packet size userspace intended to model.

Validate overhead settings before using them in adjusted length
calculations.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
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


