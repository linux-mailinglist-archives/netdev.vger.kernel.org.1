Return-Path: <netdev+bounces-242081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E985CC8C218
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 184ED4E267F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B726433FE2F;
	Wed, 26 Nov 2025 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G4akfM5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFB33F8BB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194261; cv=none; b=Jmkt6dLjTAxdNRF2Z86kE/TGYVEym0sow111xOGIAYszGRyvQx+WkU0WForJZwKQnS/sQ2KVFimOFXLbARzNfBQGodxzAFKIWBwArKVuliBdXTxxUiLL6dwmfTILEVjpvXcnVbIWbuCJT6wkCIqHdM1P8+x7Duxc88c36e2KvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194261; c=relaxed/simple;
	bh=fsQU/lAIRClKQMbanwY+X7LRDVb51TeSEe7XXekwimQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmm2sJywQNJ6yQ7kQFXjDDOKZc+BXkJu4JEC3vCMBYhAx3GhKuQXqDZKIOd84Yv/KUPqexYKOj2LUyyS4O5UnHALa8HZgkEvLhPM4abBMNZRMRCQsK/F7QIJzqz6C2PN7nEkiNtgSD6L5/wLElrUdhrQVOfDlHRwcpItgh431qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G4akfM5K; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so208037b3a.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194259; x=1764799059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GrdLEBQhE3QyPa71AOPS062WdhnOsaFdHPufbh/yNM=;
        b=Fzrba1Y6fq4H5B9RW43Sh+/b7X3u+IkJn4fuXi41k+aUTXcGR6oJOtZrdr1MRluO4K
         IsCZFe3pgZZ4ChNJ61tccp7jv8mPRhRT0JA6U90LcFYszoDhBIsBM9RKWjaGGpGY+zr6
         YT/UP2o7/GyCzI0GYVFZ3NdZJfMK1UjPlXkg5U/UPZYgLHWDGv2JLdTDZZMEFSiio+9o
         qDzbeMT4u5Q++RNCEG3LFCnSvMe1C+HnC8n/vOpJuUfKciFs5jYbFuz0S1adGoznpQ57
         YTuZZSq+j3s5jrBa0v6Gf8JK2RcNNLiGlep8M8YpDJ5vtgopIOmdxTk1EKgK+pdDbHWy
         wBRQ==
X-Gm-Message-State: AOJu0Yw2nsRDy5F83Ll8Z+kfH5Grg4eeCTTeX15bBTgaDMNe2qFQj5A8
	gKT4M01ECCsy1JJzyN/TtWQ4AgMdau7+AzsIRoeZri5oJYvonCDvBu7lrEyVDQPysTiD8vXeW5x
	soGuK2QZUubeCBoZAQ/sdKJsGJcIyaYKtrLO/Nv21SYrZlMRF09ZYmMmivr8jJ7bQYBxonuAuHI
	kWzYrJPwemHeGr7mtm7A4mwEwtgrAgizud2CrgsCWMqtjtRu+9lVFGGNmYve9UImjjMQlG+8u20
	SH+VqVkoaQ=
X-Gm-Gg: ASbGncsh6MrUwcn0hjQK67Dg/q3oub0o/P0Xtat7v3w4SftGU+cXb2CrcNFsJBKpiig
	Ixrrz4dvNDprCo7i9EPfGTtw/FyFjZzEKx9Lwh+NvI3WH3qnNW8Ab1i3PK4yb0frDg4ZPXkbHC+
	uRLsPFZecfQbGIJ/qDEGVQNZ3Ji3XFPRW5hHNJCFIL8BJOVoGwzAQiNXXCU5sft0SmOBSbJcmSk
	HvKdQi0uRksC/WVyuKFUe1fauhwQfWek3XtNyh8kKeKVs0T1DSje6nakxCZbXcCtp/RQzdN47dx
	a7owmVp/zin/f9+tSPUizKhYKIJdpFZGWl6nN6JtjguF+BScUINmGAwvUb8E+XoS487kdZkonOU
	kQ/UxdLCz0lGEYrUjo0950vVyXFqbujf0LtF9tUozBHz07e0rBXNOgjuYlTOaNLMBcOET5Y5XIo
	Tg8b1fs6YkvnnspIZgCGnFLOPi1c5KPwemx/czbmC2q7Zw
X-Google-Smtp-Source: AGHT+IHRa6fmb7zvAAHP1WadRrQOkhYQC3+xLNVBJIWS/df4u0l+WUlPhZwemQExhiLzYhmxYAQknOGEGwj2
X-Received: by 2002:a05:6a00:1820:b0:770:fd32:f365 with SMTP id d2e1a72fcca58-7c58e6088f8mr20041389b3a.25.1764194259507;
        Wed, 26 Nov 2025 13:57:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7c3ea4329d0sm2092077b3a.0.2025.11.26.13.57.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:57:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-882529130acso5644066d6.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764194258; x=1764799058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GrdLEBQhE3QyPa71AOPS062WdhnOsaFdHPufbh/yNM=;
        b=G4akfM5K4hhLPt1kyQ9k3Uxh1hmIXDSPvX+fK5K2xaIERb7bgK3HxHmzBkns09YaOv
         jkXT205oZe45H8JF4C0EyZdE5CTA1KJ6tXN2VFXZi4yOylJFG3bXysKiU6dtjYdeTOvn
         dj0qj7I0M+fsgwj0oPegsYhkaeX+Kif53JlSc=
X-Received: by 2002:a05:620a:46a9:b0:8b2:a485:6645 with SMTP id af79cd13be357-8b33d1d10ffmr2904605985a.34.1764194258127;
        Wed, 26 Nov 2025 13:57:38 -0800 (PST)
X-Received: by 2002:a05:620a:46a9:b0:8b2:a485:6645 with SMTP id af79cd13be357-8b33d1d10ffmr2904602885a.34.1764194257646;
        Wed, 26 Nov 2025 13:57:37 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm1473933185a.37.2025.11.26.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:57:36 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 1/7] bnxt_en: Enhance TX pri counters
Date: Wed, 26 Nov 2025 13:56:42 -0800
Message-ID: <20251126215648.1885936-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251126215648.1885936-1-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The priority packet and byte counters in ethtool -S are returned by
the driver based on the pri2cos mapping.  The assumption is that each
priority is mapped to one and only one hardware CoS queue.  In a
special RoCE configuration, the FW uses combined CoS queue 0 and CoS
queue 1 for the priority mapped to CoS queue 0.  In this special
case, we need to add the CoS queue 0 and CoS queue 1 counters for
the priority packet and byte counters.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 14 ++++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a625e7c311dd..148db3fe8fc2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8506,6 +8506,11 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 
 	if (flags & FUNC_QCFG_RESP_FLAGS_ENABLE_RDMA_SRIOV)
 		bp->fw_cap |= BNXT_FW_CAP_ENABLE_RDMA_SRIOV;
+	if (resp->roce_bidi_opt_mode &
+	    FUNC_QCFG_RESP_ROCE_BIDI_OPT_MODE_DEDICATED)
+		bp->cos0_cos1_shared = 1;
+	else
+		bp->cos0_cos1_shared = 0;
 
 	switch (resp->port_partition_type) {
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3613a172483a..aedb059f4ce5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2424,6 +2424,7 @@ struct bnxt {
 	u8			tc_to_qidx[BNXT_MAX_QUEUE];
 	u8			q_ids[BNXT_MAX_QUEUE];
 	u8			max_q;
+	u8			cos0_cos1_shared;
 	u8			num_tc;
 
 	u16			max_pfcwd_tmo_ms;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 41686a6f84b5..baac639f9c94 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -688,16 +688,22 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 				buf[j] = *(rx_port_stats_ext + n);
 			}
 			for (i = 0; i < 8; i++, j++) {
-				long n = bnxt_tx_bytes_pri_arr[i].base_off +
-					 bp->pri2cos_idx[i];
+				u8 cos_idx = bp->pri2cos_idx[i];
+				long n;
 
+				n = bnxt_tx_bytes_pri_arr[i].base_off + cos_idx;
 				buf[j] = *(tx_port_stats_ext + n);
+				if (bp->cos0_cos1_shared && !cos_idx)
+					buf[j] += *(tx_port_stats_ext + n + 1);
 			}
 			for (i = 0; i < 8; i++, j++) {
-				long n = bnxt_tx_pkts_pri_arr[i].base_off +
-					 bp->pri2cos_idx[i];
+				u8 cos_idx = bp->pri2cos_idx[i];
+				long n;
 
+				n = bnxt_tx_pkts_pri_arr[i].base_off + cos_idx;
 				buf[j] = *(tx_port_stats_ext + n);
+				if (bp->cos0_cos1_shared && !cos_idx)
+					buf[j] += *(tx_port_stats_ext + n + 1);
 			}
 		}
 	}
-- 
2.51.0


