Return-Path: <netdev+bounces-267614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LD0II5/tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF528A1B4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B77B3270551
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A712382F00;
	Fri, 13 Mar 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="BVUniMs5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F8382F13
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436646; cv=none; b=tU7DqDM2ZMQVevnfO94/MXpxfE++YCwr8PIYrvDubX1w42ZfdYDTaPTR194Ov9Pir+3489yWW7LQSFXd/zD+K74qYZoMiduFWtjcZMNKvwLjWSj+E/hCkVaDk4Y6Z/RJkRUxDN8Bn7UnOByVguCqZ3+IXFLBlsMVwaHTuf0Xwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436646; c=relaxed/simple;
	bh=d0lWWeNHY9f2/AN1mcSElYkXc4NfPs5jgTcjkNiFMtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM6eZQxaPnLEH2qn4xiOKEHuzrfmV02fd8IvIzPVFvXzIZ00kTYSferK6bp4IJ7CpWphNXMyZg2KA/5NFCYw7OPJCJTTPAwMMJZho2eirrhJVxiEho0enbHO31tZsx782q9xyJGZBFPyuLsL7sP4OWMq8ZmTGFPYvx41kEGqi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=BVUniMs5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae4e538abdso29578595ad.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436644; x=1774041444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlCRgbMYIlZyivAO2OT3//lNloN/8c/T4+0mo9SuAcs=;
        b=BVUniMs5lF707maNbC/yIKjJLsAQRLKittfYzpO0wTk8QRbQywn38sAiHWy1Z/9lMS
         sfJfWvjkiTLlt/23ZTQ+pA7bqdbJ1hB8JP/fbVM9nFpTKXIfv5zwUNDDhtDgSlmhcmfE
         dYAQVT0EcgAUefudbr44rq7bD5vg9LmDTAZYyGtdbveIC/0WVk3Bi8mVGfToa2F+r3Ey
         cuaqdEUYKTQS7PCHf5/wT+Gnw3Dc0Ug6QrWRQVnTfYpJhQi5PNrd8mo3CU/u/sBtqd7T
         SGpJR+prbDgUpPDqD3zzdzufIhNH5X5JHchMXTc301H5XAzSIal4VG1NYlwQ+IJCfpB2
         BHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436644; x=1774041444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RlCRgbMYIlZyivAO2OT3//lNloN/8c/T4+0mo9SuAcs=;
        b=cH2MMuhUlVsokvaKpTiyDIWtaIDDr10GX69DHZ6RlCnWbpxmV2lz/d9Ik5bVMKYFaF
         K3nCDJ7cO2krUK6pqxKB5Jbgn313qN/vYkD0d+tPQjwKKGlYcJFtQGodONuAVnZLaors
         B1v0jLC0Wk7Ow6AkaWeGArtwPOGRoIXvY0lsxZSb23jIk9NRmIBxxxLHyLHpF7sfIVA6
         o/BYLsPqJOlyjuCZq3vjvql3SS7s8DJQj5HCbyo5jc28oQy9ZZWEUWpYz3zxRHGbLdPG
         amfKf4AyXoJAge7ZrTAD68xhdBQOt2dBG6X1fUp5XYUQbaL7hl3h8w4KGQM1rUomvzuD
         ThXw==
X-Gm-Message-State: AOJu0Yy80wgTWW+wJkPn4kqx4o0ujW36bod069d5FdpE0btfI9dt6L7C
	Lz7KuZ0+zto6XyH0+cIjd6i2TW5hhfcGax4QeicpVn6vFEnT5soKQHBc98IqH8Oj/tTA0625AjI
	PS5A2C/8=
X-Gm-Gg: ATEYQzwP97v6zdw72Tiu2RDjMqvnsGPsosVNQFd2FFC1r4ae6Pn4Gmpi0y+lXnt2rIT
	ZxeijpOvz37g7rG27KlO1ygXCgAFe7PQvzsa9x6PGKEKvyKO1Hp0X3nrB3xQ0W6UhzMN9nDPcqC
	IysSYyjss0HgwPe3vvVF/RoZ7RhNSP8sHwmxbExlKj0gYcoHXG71A6QLfLW1gSx8h4sDaFeV6FS
	Xk/83EhgaLKZpGOpGvXhgpiKpk3iCduy+9w1+lhzpvUBo/9RzMLMb/tLk5gdTktejAzZtZd+0BJ
	/KXok3au3IajiresB9lik3YDxmr1MHoGl1p7RgCALJK6xzYztX9Uvhgz/k5xoMV1XsYqO84Mj/m
	og53B1DJGCMuD+WMo1fL88bf4OKZokcWQ7TdA16aJ5Yp0LiDbbupsaG78sHIJ3UAED0maXxo9aB
	wt9NTW9hz5zaARCSUoOX6p4QfbYBH3Z/ni
X-Received: by 2002:a17:903:174e:b0:2ae:5223:59ac with SMTP id d9443c01a7336-2aeca9519b2mr42929995ad.13.1773436644226;
        Fri, 13 Mar 2026 14:17:24 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 11/12] net/sched: netem: remove useless VERSION
Date: Fri, 13 Mar 2026 14:15:11 -0700
Message-ID: <20260313211646.12549-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267614-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: DBBF528A1B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The version printed was never updated and kernel version is
better indication of what is fixed or not.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 1957a15f6d1a..9ae09e781166 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -28,8 +28,6 @@
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
 
-#define VERSION "1.3"
-
 /*
  * Limit for recursion from duplication.
  * Duplicated packets are re-enqueued at the root qdisc, which may
@@ -1371,16 +1369,15 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 };
 MODULE_ALIAS_NET_SCH("netem");
 
-
 static int __init netem_module_init(void)
 {
-	pr_info("netem: version " VERSION "\n");
 	return register_qdisc(&netem_qdisc_ops);
 }
 static void __exit netem_module_exit(void)
 {
 	unregister_qdisc(&netem_qdisc_ops);
 }
+
 module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
-- 
2.51.0


