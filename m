Return-Path: <netdev+bounces-271913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM55FEbnxGkz5AQAu9opvQ
	(envelope-from <netdev+bounces-271913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:59:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28E330C38
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15DF5302513C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E73B19DB;
	Thu, 26 Mar 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="dgJzBGaM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD83B38B5
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511938; cv=none; b=Qr0EKhe2tdM0iYaCW+4yzPBp1vjaOJrST+yIj6zwo4OOw2TKmTAu9Qwk3SUP0KhQ5X0OAZUyLKDkwm4znGTIrXDR46b3M8hshC1JqYZyVmb6zzpj8FymjQcDqQaEvLFy9e9hNTxaW+LvI102tK5d/9MaBPzSMQ34xBfZsuaNO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511938; c=relaxed/simple;
	bh=y/3xI84VCLYflmawk5Pu8co/MJz5fNDSaOTG3iVyyZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlbPV72sG/te0F5g3i7VRkgmqB0M92faYQjvYZkGENtTrNc/NmIXlZ4al+VFccDRdIIMZ/alicML4oUHG04uEIy80cLfsBsDWpy0enfKLG7JPer9ej6SH+fhhh7BXEGrLWa06G1lpAyKhlDy2nZfB3uFv57wWuMTJvjbX6Qb0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dgJzBGaM; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so1013861eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774511935; x=1775116735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgbtaBlFe0eMFqi2w1+VrkfLPFhJkuq/9FGQTTtuF+0=;
        b=dgJzBGaMFkKkIQmjUo9vpWnnCwasiWWQi00knH2AmE+YlegLFm+91qeVLZMfz8PhQx
         xLeQG6/zyiJp9Vd+fWXcILr5xGH5alest8IRwaKJXZpVNFDdKjec05IJ3jur4CVKCEWF
         SWEkwo+1iF4CfZy6xOPZMGrwp0O6jd5XnA/Q6bH8px4A0Ha/mqhnXAclP6HJAYoFZ11Y
         iZrYmaUqmB63p+REVGHnQ+fRS9RaBVME3ROhaexLz2qeWLDAX6TQBfjrvdYOlsjRmScj
         ns4IALVYW0hsTTpTvTDd1as4G5G3IpJXxL9qGSWBqxT+GZ71/3QgviKVQbaYrko6d+WF
         nFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774511935; x=1775116735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgbtaBlFe0eMFqi2w1+VrkfLPFhJkuq/9FGQTTtuF+0=;
        b=ZjdpzGIyzoGj24NdHSFPr9wik77oiNtrBCiI21Yi0wFn+/FzhLHb7Kxi7wSS7UJuCX
         yNFyf5UdDwhmuEqkpjPgsp8IizGFQs909m8t/46M3enDJhRj1dCIkdzo31woxqyLRjfe
         /TrFf+ksZtJl6SDIjCYUkYPN5uSmJB3jsKROirUU5DNn1KxI1kB20G2hhMk7zAuUeMMc
         ylfPBYsuxOLDLtxh/kKcqYj2cDdZymVvi2SSGJY69dGeH0S1YzhYA3tQKmMrHrRDAkot
         lbmNk8Z1eIctrlbAGSYPVDXnm0ECOSJobn77KJwwqoFX04f//TWoccRLNbzcQgX9/LTZ
         8x6Q==
X-Gm-Message-State: AOJu0YxAUMgpSE+1VJxYaMxrJrwRyTqIiFgucXuL6tMqKOXe4riueZOl
	tQkNJQXDb+jTliqETUssB8zVjgCrelcUMaAvWPRZwZPojSoFI8toRXTbWsIWWaRCBQ==
X-Gm-Gg: ATEYQzyShIu0+h1sShpIeQZtmDn86jPpH2loTYQ1/KvKo2iMCeHscN4SK+tMTS4UN+a
	7nQebdzDrIXxiXnFGproi36GQl+zchlgMvYG6NWFGeuf2N1SmPSnAn515cqG1+9y7eZrGQioyPb
	9X9VMQnkoL8uh8IPXGh6uI5h24/W+zpXyKwJLljAgPGtnDDqCOHjMvEE9dFqpA9jbm8QxBf3VIx
	qduxbM+TN0mihB55il2+81G+QLstJQEtSQ+WOYmXCYSmakWLPdQ8hVVZQJm/v96mg8ieHWbMcPx
	RPGrojBNFXlvEE0jM0LfAiivNArwiaAtCuTWdt5wxChBfe5nUHlsay8Ymy6CfBt+/e8tCJ9xZX3
	++3MQuVZ+2CurjmayeGxbkgV6htXOjtiOP9RX+GWNPMQJGyT3HNHgVAM1kLPbGRTJ9NV2ujVh9L
	S9WDGXWvWgI5VRzw3CGRq+rzTFHBcL0V7nmNIvf+a5uhhiQcGCGm6+2w==
X-Received: by 2002:a05:7300:6405:b0:2c1:571f:b824 with SMTP id 5a478bee46e88-2c15d4177eamr4057282eec.30.1774511935075;
        Thu, 26 Mar 2026 00:58:55 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc0436sm1834230eec.22.2026.03.26.00.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 00:58:54 -0700 (PDT)
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
Subject: [PATCH net v2] net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
Date: Thu, 26 Mar 2026 00:58:51 -0700
Message-ID: <20260326075851.3967598-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271913-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC28E330C38
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


