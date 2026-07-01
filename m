Return-Path: <netdev+bounces-303902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 43OSLrCpRWpaDgsAu9opvQ
	(envelope-from <netdev+bounces-303902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:58:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D756F2824
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:58:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=U9EnC6WR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303902-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303902-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79AE2303BDF3
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 23:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D23EDAA6;
	Wed,  1 Jul 2026 23:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C53C9EF0
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 23:58:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950316; cv=none; b=p21cUMgWQl88Ro8WlZG0f3QHXdxDs4/bCrJrvvyohNJXV89w37ixO3Q9I48A3IZGEEG308fzQrbx2HeXP7ULYP0ZmoeuphOOg4viYNDtQlQxI+zeRQLM/sgsN1OJ6EROJggUHO1/W5PcdjZ8ovRNouEVF82gaRz0uns4DrI6k2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950316; c=relaxed/simple;
	bh=++E0U5aWCMtv8XTC4iwlRdxhbI6lt2ULgAfP1yOkzT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJnuQ/W/0ntfmM3C16ZiPfTMp2JlmvAbfBGQfZBuxFu1zsY7deCvLlLglsh0Dfq2fsjMTjv+YB0SwnEQ03seUTAkV5QU/z5G7RRc7t+8Pfa9aG5jBomtkcMRWtb2QKP8YG5TtX8+wUUCBC47IJ2bKK148YjLYf2hSb3AzY4kP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=U9EnC6WR; arc=none smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51bfb91795eso6390701cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782950315; x=1783555115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvF1S3B+dNSeFpU1X93IfKv9JF+ggDHfHPlB1rF6bww=;
        b=U9EnC6WRyWoEvFYJzOilAR0rd1XAwKR/KPds0HEGIsVMKEmzXE1RW5DGbocLudGUv0
         ylAmXZvuzdKoka8FwzDCBEU1QpoTFHzTYwlz1+RsaJy9edBPx9QaDtT8roRmK6efiaYt
         MxPiIxTy7HEPCLiJLRkjiwpcMpF5ejEbNZ2ewHhkOsS1NyNYXji7nipdxP/0SbRmE2Qd
         eCuAV5ek8JIjwm10Hj7uzdXe7tqS+oKjkGXMBIJzsclcdaWaIWjrB/LZcncH8xmgwCGV
         9Il1laysYKim4yPXQyVc4RnpvoruvUmme425dyz41YNG2X6j13vIjcbUhODzUFgsdaKe
         oFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950315; x=1783555115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvF1S3B+dNSeFpU1X93IfKv9JF+ggDHfHPlB1rF6bww=;
        b=HbKf2dhqmbrZaKRADIXqjvBz94xlrOj2bnGnQqNwrbe2C5OiAH2dzyC9RbZI/PFDjt
         stUjtgITqFBB85QmCYNCZhijvWsABmRbvR90MFwc3OVNalED/A5lq2Fnh+kaegk9XyAU
         +aAPbR39TNBZXZvM7ZZbtKUMleMyPRg8X6OP0ullUBtUBvonRwXhsacBaRid8DH+BSHI
         5fD2S4vyeYDO8rtp0x0hfFiufhmt1StbTuHF2HVfScsclKijnq3Lix8GKOqPvKlVMVfl
         pBOoToYrwVhutRO+VtZ0KbGZfBzYCVi1wUDJY4Aoxeu7iFw2xqdv7U2/4G2mlqgenh95
         aq6w==
X-Forwarded-Encrypted: i=1; AFNElJ+7jAHMv4Dq7HIYKjosnCH5x7OALRZqQ18JlpufOD/ubW7jaONhViXHgnRNqTkbboQEtUaC3Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fJgUTQ3cKk9k6Kpq+iH1M7PnQxe85Pu9eX4LA5fX90u7u71c
	GXvfvd85JSolCYRAWH7lXiU65nYjB65jr3IVTCBJghW24L+1KDwzO0ZdbSW+609Uc2Us+4zribL
	Qo854+9M=
X-Gm-Gg: AfdE7ckRM0tCpljPEx9YMJd1OD3dtW3y8u+6aZDq0Du7NFC802pxw4J64uVs72mPRXr
	hAIre0oIlIvO76w1ZP82WOtu3tA/u1kOaFxoY5YHYzlcL9GLfGZXc60ackSdVQ+5rcRHd55FtYR
	xqMhGyvCREWE6o429/jZ64qvx4RUovWOshioxnKFz5caIqAhpv6JwRwPn2E9OjuMlWfd+L0KJNl
	yIiPLyBZYgsrNMYHg+lazsosWta3C26vtVKhK5m/9D7+O6yfJel10A4tEUy+LdWzSkrPpoa++VQ
	y3FtTFNYpB0wu64zcmoXiGarzW4VJW/ZKPeMbF6kz6zMpSj2uAq28wRzIt+MjDW9jiGe810T2bS
	7TWLCBYPlmD7G08k0eAM92PgUbQPb/yY8dIvcT+wb8U75XS3zuQIuFCWDg3bJQA8iodlpKpSLkM
	h5s3osbyBX7rWhTr9H
X-Received: by 2002:a05:622a:1e8c:b0:51c:1ec5:d00 with SMTP id d75a77b69052e-51c26b066admr50911551cf.44.1782950314724;
        Wed, 01 Jul 2026 16:58:34 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51c30c1582esm3231531cf.16.2026.07.01.16.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 16:58:33 -0700 (PDT)
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
Date: Wed,  1 Jul 2026 23:56:57 +0000
Message-ID: <20260701235656.296208.68e320e0746d.cake-overhead-underflow@trailofbits.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303902-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44D756F2824

CAKE accepts signed overhead values and stores them in an s16, but the
adjusted packet length calculation uses unsigned arithmetic.  A negative
effective length can therefore wrap to a large value.

Such configurations make rate accounting depend on integer wraparound
rather than on the packet size userspace intended to model.  A static
netlink lower bound is not enough because packets reaching CAKE can be
smaller than any reasonable manual-overhead allowance.

Fold the signed overhead adjustment into the existing datapath MPU clamp
so negative adjusted lengths are clamped before link-layer framing
adjustments.

Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the rate shaper")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v3:
  - Adjust how check is performed
Changes in v2:
  - Add fixes tag

 net/sched/sch_cake.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a3c185505afc..f78f8e950776 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1389,10 +1389,7 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
 	if (qd->min_netlen > len)
 		WRITE_ONCE(qd->min_netlen, len);
 
-	len += q->rate_overhead;
-
-	if (len < q->rate_mpu)
-		len = q->rate_mpu;
+	len = max((s32)len + q->rate_overhead, (s32)q->rate_mpu);
 
 	if (q->atm_mode == CAKE_ATM_ATM) {
 		len += 47;
-- 
2.43.0


