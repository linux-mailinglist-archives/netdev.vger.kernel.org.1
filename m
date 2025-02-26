Return-Path: <netdev+bounces-169718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36026A45571
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B10E1886CB8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7430F268C55;
	Wed, 26 Feb 2025 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nis/4rju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E6268C46
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550749; cv=none; b=LZnFPrdi1ZfmnX4gk+bQLHDKBiZvzvdDktJJIbXKLL1zrZH418gmRXuejeywh+yfR8ZZTbT1I+PfjoPZ06VtwpRfxb98EMVrOGS/ENoxoROG5NvZrmXQhs91sF4iob7uVFceYvAzNdHoZiE3aS3vh4/1JJ1MNIQIAqSdlAP9XeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550749; c=relaxed/simple;
	bh=46asehdSg2GU7JJlnu5Pb18hdoyKk5n96mazpKIgCsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goO2Q85NVRL3oLLOfKQclTlGzHe1cKZv4jaBJ0dgYoE7S+a+Dn+hzoORjkI1G2yvdmuKlCL2xSiPoQ/KOog+Neu7+3c+oQgJ8e8RA7U+SKZBJ9ysq7viXWhtvrYq13q1JNlKYLmLoadWjLBjH0O/0YA1yoHsIc4sbn4HfK6spBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nis/4rju; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8f38febso134713435ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740550747; x=1741155547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWPVRxzr7fehL1+SVq6iOEKJk/W/PWJ1tE9idqLYwoA=;
        b=nis/4rjup74LzrP/Q0wqzu3sXEUw1SWiPUu1wNq/5tzYXx4Qgq6J++L/mYmKa7Fh4L
         lxIc5FN7xMvQwXcgJsa0VrdynSe6ed6PaDgDcBfsRz/KGFGV7+3z0xiZzOsBtlowDPHK
         Iznyqn9+UypCd1dXTnDV9On24l1ZOYvPdPuqRDZT63NpIdKvK91CUuIq85SeODYR+QHv
         inJDZtGa15qnF1vbke6WivcD88CiDtAscf1fqpyZDnIc9cPb0ftX+uPTnV1rGjejH4+w
         C9Lk3oNo4+bygv9t/JamIadaKlR7eG1t2dhpTq+qpWeBbSHRtI4mAvfPfyPfjZoit0vy
         Tdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550747; x=1741155547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWPVRxzr7fehL1+SVq6iOEKJk/W/PWJ1tE9idqLYwoA=;
        b=ktNf3A/+xtLILnHzArt+yZHaVQVZvRMyZAFzKkO6w/kk99pHgls3egT65uRyYcqSWg
         pCPMkrfx81qK20/EG+sEaUbgJeKPTO4FX6DDlVbPQ4MINlA1Ao4LuSW+XP45ZEo0Ikjz
         AgCLUnhJtzJhwGagVSiEy0Ym6pvJEMR29r3HG4PKfAPmpeX6+MBPH6kK71o3wCnSlwZc
         etb4pNUgWeWIj3egtX6aOzFl5gafyCqJW1XGZ0cpNob4DgPJPyExf8KgRQQxkaOF+2iI
         3mKA8zvFZPp0XEQEU764wlxXHGFN67AWDIf/jhKTVQMzFUDK5sCW9rVgl+nlekbcw4fU
         RR2w==
X-Forwarded-Encrypted: i=1; AJvYcCXsbq3VHdLGk2X4dohEPoEdxCY5JJQhxdPlkakIOnYGceehAbJeV1l3Rgns8cfk5+B4JWrxdno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcr3esmXknQQ+FtIbP85HrvWv9lDvKRzMTIcfNhcNotl/ZLse
	9EyxwsPQP6TFKL9ItOBiVRFaxtn6/yOJcspssFpSqeugCSZDzUOw
X-Gm-Gg: ASbGncs5RAo6p60oSoyLjgdvHFNQ0+j++saRkSGZp6U0zc5gGfTi+/yBr1JvZe+Ysyr
	vMFXA1bZhv5ObgAogkxwQWm8CPGuW4Ov9HszdKFdrvPeSBWiIgCY3FjvAaKb9yESP+1a0+/GCht
	td1kVbkSRxmRnBOtAXjfpTezRJJrrYTyp9VRfvaQRoG4M1fUjnjYUBTpJpzl7Z2jwsyNuGYckrL
	qS+PPtftxIP0FoVdBIWdjw99MVfJz+RwzIhfhjYbPGRcx+mEyqbv1tgcL3xp8aDDQOJV1msaS33
	Fz208IDTPhMFbQM=
X-Google-Smtp-Source: AGHT+IGnm7RUiVp95jOQs2G5yspomxlHKmDuyAxhDnjCuLDliW3c62LexKQA6dhd2LAKoeAay/D8WA==
X-Received: by 2002:a17:903:22c4:b0:215:a05d:fb05 with SMTP id d9443c01a7336-221a00156b6mr325413975ad.32.1740550747108;
        Tue, 25 Feb 2025 22:19:07 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a61fcsm24575535ad.191.2025.02.25.22.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:19:06 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	horms@kernel.org,
	ap420073@gmail.com
Subject: [PATCH net 3/3] eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue restart logic
Date: Wed, 26 Feb 2025 06:18:37 +0000
Message-Id: <20250226061837.1435731-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226061837.1435731-1-ap420073@gmail.com>
References: <20250226061837.1435731-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a queue is restarted, it sets MRU to 0 for stopping packet flow.
MRU variable is a member of vnic_info[], the first vnic_info is default
and the second is ntuple.
Only when ntuple is enabled(ethtool -K eth0 ntuple on), vnic_info for
ntuple is allocated in init logic.
The bp->nr_vnics indicates how many vnic_info are allocated.
However bnxt_queue_{start | stop}() accesses vnic_info[BNXT_VNIC_NTUPLE]
regardless of ntuple state.

Fixes: b9d2956e869c ("bnxt_en: stop packet flow during bnxt_queue_stop/start")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1f7042248ccc..29849bfeed14 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15635,7 +15635,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	cpr = &rxr->bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
-	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+	for (i = 0; i <= bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
 		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
@@ -15663,7 +15663,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_vnic_info *vnic;
 	int i;
 
-	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+	for (i = 0; i <= bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 		vnic->mru = 0;
 		bnxt_hwrm_vnic_update(bp, vnic,
-- 
2.34.1


