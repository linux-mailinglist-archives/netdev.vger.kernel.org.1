Return-Path: <netdev+bounces-272240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFFLHH6axWnP/wQAu9opvQ
	(envelope-from <netdev+bounces-272240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:43:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD133B813
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3420303B4E7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B323A5E82;
	Thu, 26 Mar 2026 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="WMOIaxvU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D838C2B7
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557814; cv=none; b=Dl7rsFcC5XMoGUXUErxC8nD77lg3U3zgfTTikCb3/UgN1RodstQeMIcDkfcooQw9K2QIyT2vWxgQdZpV0WXl9UGplHTfOYvRcsEllBsCFl7c0HpzK54K3ZlL8FNjUmDUb0HkQY0SNMPXohT0EamAM9P+CVvRUWE5H/gCS2uCMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557814; c=relaxed/simple;
	bh=MCMVxgmWBQ+qCqBsburhv3sOKXenzAHeLLXRz/WDaKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7c7kdLlAzaRAlNMKmO7YWj/8WvrqKshHZOvqNPrWTqahEGGCW5SPpKAleo+Q/OALatBBEhvIhLWSH22ffMsXfcNxQWsGDI8tlgtX7Yy+OWZCoCR1yt34N8MjgW6BhS9nHAcRanD5nEhNySzSIqoD70BEVXbj68vIivU4LylDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=WMOIaxvU; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12a74039dc6so1203923c88.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774557812; x=1775162612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vD834OSBdLvaEzQb0nB3lOpMRHSsU+1g5952vvRfyJA=;
        b=WMOIaxvUM9IZLwuPwSXv0i01GgHTAuGZ/izOWOxvrOkay0RNx9iGPLrjkn/lBxD2z/
         WJUlR0LjcI172FenlSRWOdlsOs54Qp5fU8B5eDgvOmICL+QfW+YLorT//QlIIRdqXeVp
         +3BRW5ZfOQnh/urjvCbx2goJOkBzD8HDnfzwvHa4UgXF2nq8/5zeGAic+if9G075vcaR
         BeVayAsbXNuDJdr94tgbGuqd/Kf6UzH+DnezKbUfcgmDbWM5eqtK7vbepVRRgIs/vToD
         MUQYk28yke5ShPxN2uoLW2YrQheE3r1krqPmUiW3ehgYYPIUgIfClL2PPR1bGm+cRvd4
         WZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557812; x=1775162612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD834OSBdLvaEzQb0nB3lOpMRHSsU+1g5952vvRfyJA=;
        b=g5ztWTGX5VNLJtofAWxOAcY0uh+JUa6eGzBE1YNFofGTPtEDQCfyy27SlIHAycH/rK
         e15yf+L9UN1PUTLcyxsbUv/zDf2sJusPFDI2SxQnqXt7uLIn9SuPitO1KYcPZiesaYOb
         1RtT5MWSREN5cLM8kXxrYqGPFEfX9B0ynZfBPpiw1Pav4zO34Q18JnMmdVtHjtza7mtU
         bdNzEHseM7TCLrI+1ZuSRO8nDgxYwHSCscSMjC8X/zEgcE+dwxcz0lxC9mID+vMjknho
         GYq0LT1g3U0dwPi7bPJFEP3NTJ+SQMpZFwIbVIbrPttnLIfBQwUoGhNMvtE9gn9pEpLH
         0OmQ==
X-Gm-Message-State: AOJu0YwQtdl/bIY1tpWmgdu7vwUzK50XrKU3xOc6exkdeqocc1wZhKaE
	1j/UM/RbGskL2TX0PDk0MSNLiWqbpVIDfaRZ0sNSwWmu2s7wo8fUAPqvw/DO99Dltg==
X-Gm-Gg: ATEYQzzIWTcyQA2N6JMG9b8S4xf+/O82IdI0ENPAtULzKNVzX3fx7JFTrfms1701sE9
	mIvXluwB0WlHb9WuaK8NgXmXe8wlDLAnQeHn/SHpvF41k2Zde9jGvCi1+XaDLmFUOit0GsauAZI
	u+3Of7wMJKOaWPn/mBDF1DAjVSTHsuvkh4hq4VTMKzBzbo6LVLbag0kIw+QF25Y/EPkwjKJkBwg
	XoFP24HeoLOjz1AsPnlOqOfilaAfn9YqYTSSTbyo6d6Dj+/Lyp+/oK5FCSLV7IEBAdSyIjGDZ05
	fjGW7Y3hKSRrStYWmghHPC+XFIv0ctaOe/mnbQnRYJOkgt5a6nzwJlDjrAt9UlJJ6DTULgBvsFt
	uvaJaY4/ciA/+xRQM8OoJVrUthnR9EIj7MfrbXqDvhngvFqp+fHISTkM3Aa9ULiCsjx/X4dwAjT
	FvAwXS92cK51lCrbEGVevAQMEBEg/n78699F4JR5yCBx+mBQISdrjtXg==
X-Received: by 2002:a05:7022:1e0f:b0:12a:78c8:dd with SMTP id a92af1059eb24-12a96f1b099mr4783684c88.40.1774557812243;
        Thu, 26 Mar 2026 13:43:32 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa78462fesm5479974c88.15.2026.03.26.13.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:43:31 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3 1/2] net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
Date: Thu, 26 Mar 2026 13:43:09 -0700
Message-ID: <20260326204310.1549327-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272240-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: 0EAD133B813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

m2sm() converts a u32 slope to a u64 scaled value.  For large inputs
(e.g. m1=4000000000), the result can reach 2^32.  rtsc_min() stores
the difference of two such u64 values in a u32 variable `dsm` and
uses it as a divisor.  When the difference is exactly 2^32 the
truncation yields zero, causing a divide-by-zero oops in the
concave-curve intersection path:

  Oops: divide error: 0000
  RIP: 0010:rtsc_min (net/sched/sch_hfsc.c:601)
  Call Trace:
   init_ed (net/sched/sch_hfsc.c:629)
   hfsc_enqueue (net/sched/sch_hfsc.c:1569)
   [...]

Widen `dsm` to u64 and replace do_div() with div64_u64() so the full
difference is preserved.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: resend to netdev ML
v3: append selftest in 2/2
 
 net/sched/sch_hfsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index b5657ffbbf84..83b2ca2e37fc 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -555,7 +555,7 @@ static void
 rtsc_min(struct runtime_sc *rtsc, struct internal_sc *isc, u64 x, u64 y)
 {
 	u64 y1, y2, dx, dy;
-	u32 dsm;
+	u64 dsm;
 
 	if (isc->sm1 <= isc->sm2) {
 		/* service curve is convex */
@@ -598,7 +598,7 @@ rtsc_min(struct runtime_sc *rtsc, struct internal_sc *isc, u64 x, u64 y)
 	 */
 	dx = (y1 - y) << SM_SHIFT;
 	dsm = isc->sm1 - isc->sm2;
-	do_div(dx, dsm);
+	dx = div64_u64(dx, dsm);
 	/*
 	 * check if (x, y1) belongs to the 1st segment of rtsc.
 	 * if so, add the offset.
-- 
2.43.0


