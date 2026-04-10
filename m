Return-Path: <netdev+bounces-277201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W0BsEU9Y2GkvcQgAu9opvQ
	(envelope-from <netdev+bounces-277201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:54:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB033D13D1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F407B30063AC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116F2FF675;
	Fri, 10 Apr 2026 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAWbWJ/G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21B25FA29
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786060; cv=none; b=bQbFpmxkZPncMi3RTgvjVfkclPv7BIJ1yMJv1o020kCLSc8cV0CDhZ0TVy5oRaiZ8CYJgyBQWfZaBiFO71dGunr68TQKJRObZg3qQh3QhzjbxIKM8Vw37sxqWyWnsFGWnAtRdIdU2+Bl/PO9kLQNyRrKfGjFLGRWstSJhlDkisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786060; c=relaxed/simple;
	bh=9n9e7BOpD0JJg+GvMEUM4/CCjFhf8fyYpDSfLRwJ4kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVgWYVw19uLKVP2GMY6fChWx5RuNzCgqmqnX3OS5+idIDyB1kmISfbbb0Iv5rR1bsbEMoSRKIprkyQT5Vw0QvnBDZotNoNssx9Zel7c2IHAZWBgjV1gG9BF89dS6Kqa4v196K/baBp5tEdy51Jfn9P5fTcjLKEIoZy81vG57Rbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAWbWJ/G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso13838475e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 18:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775786057; x=1776390857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFt/ccalP4guf4oXhpfkftFkSiO5srQjmAfQqO3hweU=;
        b=KAWbWJ/G9bphNHHEW+KC3m1EYOjiBgIPeZL+pvMe1LyMojiqUHYesR3ARV7VoHUPQe
         y0yDY9g+XouaX4D0KBaQecmTBX3a1bdWgfwhomLo0wrJTwpQMY6R3TF/kyr9w4sTlidJ
         X/O5/+utIWFRpYTR8CqX9BiS8XzoPAb+b6I30bb/m7c9j66Qf25dOFj039ZHbr9+EKhJ
         wGBmS3eyYFVMHGBaFU6ILkkyJgM0mUhIaHK/cCiL91R/kwY50m4stMcbhMd/o28E/YRY
         mPlaM8/mE+8XUHUP176IJ3wBLYmHPFm5cNsoD9pAsrjLSGCFjWMweMww2dO03wQc6qSm
         Svag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775786057; x=1776390857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFt/ccalP4guf4oXhpfkftFkSiO5srQjmAfQqO3hweU=;
        b=hZZ3LetR11aukD60cbnPEwh5MObidy9uJWzBqBOH+lV9jckHc0H+uDhPWxZ9ne9Tvi
         9nd3GWHd4z+tvx7IWi40TUkkI3FI/enU9ovqRlvjsb92NLjbJ8H69tMBwRvhHVOtrE7N
         /JWrdBhIrZwveYnTLsE/aC0luEqDBWMXCHkKpJZ+zkhkrOZMYXPcGea+OXUXGV4lPlkP
         7GgahIHnBJhTyoqbPbyQKFcJYi5iI61l0yoNZfvpXE2+wNGaVumWn6xnusnaIx+0gDAT
         h3iGZ1pxI7ruXgj2S0DTkz/PK75evuNTI5iUJZYj4AZ71JayapUX6qaGT1DW1pBScJhr
         yy2w==
X-Forwarded-Encrypted: i=1; AJvYcCU2GLqHT/6y1GWjGAn3AMTzEgOm2lRi75ws2uXRyBEpVMMGQ/k8Jo7cAiPXxZerBm4Zsi1JDBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7olWpbclmcjlThIQ/HD5NHpyhF0BtXLGt4PnXT6U64Vh5z3l
	RXyVsNg7HA5tCq8O7h5qEDsrizPzA5kNB54lHdVH3+CqZ3V8kiQFVE9T
X-Gm-Gg: AeBDieuMNMFBADF4TEM8BrYoii8OjsEpRGplaVvJVmriTPCM2v6pRXODE9koAfy+MTJ
	F5LQDGoy7vN8frWiT+94xl2GAmn8r8Bk/omHJkCJW3fMcFSNsbiFIWXM/HnJn88cK+dBCqQMo0S
	SbMWIhROE6a/+qU2VoJqYN8HgoTT2XTRtRM/Ni/MRrsRzg4HuC+3CSn8ULJ4+SZFzbK2yQv2wnO
	bpGkl5MWivKlf2iPIvQuQXZuY3Y3+xuams9dx4yDfRCbmfZDXTdm2ZuliVgPLN/RCuKMVNHQq0P
	4H/0Xsxl5w43Zegac279XBSjWAEYhatiLOfqPSqMg3XGncwPEM1+VwNQL1AI3qD7c9IRs0IGWHA
	2keG6EmNDxcrX5jugYP+F4dHqp9RFIpAdtS28KygV8sqg7v+oU9j9u3uYf500YZ50UvD84zOMGa
	sh/tgIrgIhLdh8ex+ISY5yDobXnWOFMmi7wuWTDxAD+OnM7WIC1AHSXNcSGHnqDtumZl6JC+bbN
	+6GMG5DF1/PaFUzKLyH3ZXObZIECZGcpPb8eFCEUI/nLcv0
X-Received: by 2002:a05:600c:a109:b0:488:af7f:7751 with SMTP id 5b1f17b1804b1-488d6836508mr8227665e9.15.1775786057077;
        Thu, 09 Apr 2026 18:54:17 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d533e596sm39254295e9.6.2026.04.09.18.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:54:16 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Carolina Jubran <cjubran@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v3] net/mlx5: Fix OOB access and stack information leak in PTP event handling
Date: Fri, 10 Apr 2026 02:53:36 +0100
Message-ID: <20260410015336.7353-1-prathameshdeshpande7@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277201-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FB033D13D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_pps_event(), several critical issues were identified during
review by Sashiko:

1. The 'pin' index from the hardware event was used without bounds
   checking to index 'pin_config' and 'pps_info->start', leading to
   potential out-of-bounds memory access.
2. 'ptp_event' was not zero-initialized. Since it contains a union,
   assigning a timestamp partially leaves the 'ts_raw' field with
   uninitialized stack memory, which can leak kernel data or
   corrupt time sync logic in hardpps().
3. A NULL 'pin_config' could be dereferenced if initialization failed.
4. 'clock->ptp' could be NULL if ptp_clock_register() failed.

Fix these by zero-initializing the event struct, adding a bounds
check against n_pins, and adding appropriate NULL guards.

Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
Suggested-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v3:
- Fix union corruption by using a local timestamp variable [Sashiko].
- Validate pin index against n_pins with WARN_ON_ONCE [Carolina].
- Remove redundant pin < 0 check and cleanup TODO comment.
v2:
- Zero-initialize ptp_event to prevent stack information leak [Sashiko].
- Add bounds check for hardware pin index to prevent OOB access [Sashiko].
- Add NULL guard for pin_config to handle initialization failures [Sashiko].
- Add NULL check for clock->ptp as originally intended.

 .../net/ethernet/mellanox/mlx5/core/lib/clock.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index bd4e042077af..674dd048a6b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1164,16 +1164,22 @@ static int mlx5_pps_event(struct notifier_block *nb,
 							       pps_nb);
 	struct mlx5_core_dev *mdev = clock_state->mdev;
 	struct mlx5_clock *clock = mdev->clock;
-	struct ptp_clock_event ptp_event;
+	struct ptp_clock_event ptp_event = {};
 	struct mlx5_eqe *eqe = data;
 	int pin = eqe->data.pps.pin;
 	unsigned long flags;
 	u64 ns;
 
+	if (!clock->ptp_info.pin_config)
+		return NOTIFY_OK;
+
+	if (WARN_ON_ONCE(pin >= clock->ptp_info.n_pins))
+		return NOTIFY_OK;
+
 	switch (clock->ptp_info.pin_config[pin].func) {
 	case PTP_PF_EXTTS:
 		ptp_event.index = pin;
-		ptp_event.timestamp = mlx5_real_time_mode(mdev) ?
+		ns = mlx5_real_time_mode(mdev) ?
 			mlx5_real_time_cyc2time(clock,
 						be64_to_cpu(eqe->data.pps.time_stamp)) :
 			mlx5_timecounter_cyc2time(clock,
@@ -1181,12 +1187,13 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		if (clock->pps_info.enabled) {
 			ptp_event.type = PTP_CLOCK_PPSUSR;
 			ptp_event.pps_times.ts_real =
-					ns_to_timespec64(ptp_event.timestamp);
+					ns_to_timespec64(ns);
 		} else {
 			ptp_event.type = PTP_CLOCK_EXTTS;
+			ptp_event.timestamp = ns;
 		}
-		/* TODOL clock->ptp can be NULL if ptp_clock_register fails */
-		ptp_clock_event(clock->ptp, &ptp_event);
+		if (clock->ptp)
+			ptp_clock_event(clock->ptp, &ptp_event);
 		break;
 	case PTP_PF_PEROUT:
 		if (clock->shared) {
-- 
2.43.0


