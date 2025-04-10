Return-Path: <netdev+bounces-181370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C2A84AD9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FA34C2294
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF21F098E;
	Thu, 10 Apr 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/jCjagg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655415D5B6;
	Thu, 10 Apr 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305774; cv=none; b=kMW0engPxsF3X2Z9/UdA5KUYsU41eWhgCSGelCr3rXzL6IRINiJHIAH0dVZXyPTVvxyaKK3vLF523dTOuLF+eEFbtTxhdACZDOtOsg8pzhECFLVMmCMLNgUtEgmW1dK9KUgKKxeMghMZqgzjVWyVX2ECZZWNRGhpiuliRttmPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305774; c=relaxed/simple;
	bh=pvn7tXjdG6gfIyfzZr5drPvwWX3wRbgXki7C6daaqYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rlmgWHbFcbjjYIY9/gjda95fY/QLOvh5U5RBp5RAcbLZ3tOIVj/c7/P6sEiZm41/njaP+D2GaavDteJcN9m/mz57D/krbLVEYH48oY4gYNHsnVKemW/u/Vni5whZ/O4WRSoSq5pRY143vsmJqxlGgmdiBlj4qW3/J6s/pIo79T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/jCjagg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-730517040a9so1369979b3a.0;
        Thu, 10 Apr 2025 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744305772; x=1744910572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IgtDWZl2x1QLYm6C7yhUEwcBItI4P6YMt+GwUmEGLw4=;
        b=P/jCjaggRe/Nc43tBHB2X0sjWST/ahT7t9/k+LLBH1zGpOsusULmpXrsFAy6rssQF5
         1OWv1KI25uND/gIZJ28wCafF9h4HogILSy0hh+wwOeahNOxtb6DLrSgJl9dkJWdhLj5r
         lO9jYi0U3GNvBErpHsCUnT8FFpHLSTHryDQ0iKo6YK7V734mwWlZ+7vmZo3IIw0Y8Air
         7jvYm3SmgKpnMEs7q5iuWxJGA48b37on89iQzlL5QDcQdITH7fftFVCJFy0R6HJ7qjmB
         NjFDAVe2AOZGpA0RCh5VZHd76CD5Ce8XVcMvdHY2CiC4Nc//XkSbcBd9jJMJc/SShHBi
         jh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744305772; x=1744910572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgtDWZl2x1QLYm6C7yhUEwcBItI4P6YMt+GwUmEGLw4=;
        b=tvLc/Ed6dnMi7PVAIj36guVMacUJdrRe4arrivVqQF8/xFFGkWivCMzQetW6t+sXov
         iVufa3S2mGKAHRPuJJB6lzwOA0D5GxXmBIHNGNjVykO/5n60Hi/kguBsUQmw2oVPpIS7
         7ajzRqFiVRVDnLzvgqCD4PK/o2vdGiF5er/0FLB8kwLu+RExP+T0rj8xOaUSRpoxD/gr
         HBfVnXLYrU8lL6fchVd8YHLR/IBCImh1hycYe497Xm8FwwWLvPwWpzJqtexML2p8iHYw
         B5I0bU09U8fTTx1uCKLy0q7PIn+lcxTA264vlfMosQKX9v+Bgj2GI55BHcXFF1vZD2sX
         cqdg==
X-Forwarded-Encrypted: i=1; AJvYcCVftkzs30gJEFdwF988ywKkdlJTNFZIzHKVFUh5iT7GyIrZc12yS696wdLkp7YzzLBQBcQ42bw85OHAiGE=@vger.kernel.org, AJvYcCVxhvnVMnNR6C9I5Xqrymyxr/uRSBeAoAQdEu8zlTkr3NkwrMpakX0GQXaF7YVX818gk6ngVb9k@vger.kernel.org
X-Gm-Message-State: AOJu0YzRY88J09tQr1+WpEiD2G/zr+gvoo2MBt7eyEZYablPjKlm0dxX
	yizx2H+i6EQMW4Q+8LwjtQToR7x0k2dzNFIKAc6A8zx1s+yKJDc=
X-Gm-Gg: ASbGncvmY8ntLPIj6vWSUvv5AIMSfJECJFDuVGEMsJfPScR8Z/SFEjyHI0zdQKs/MxE
	mcPBvUNqJgJzgi99v+FpbWocg4X+lbuWeKxapTdygshKaSkgP1OD00/RdWO75+BVsD/785y8AV+
	FCBFAMU2GFKt1qtdG0YCqaJjA+kXluvNtraMi7PhZVsU1QQcc3V7us7+IBG+lwEYM1oHLo6bYIg
	/ZFgroP5/xszAEXlaIE6Oh7iYw9/ATRjpgMjqojeij8dn3QztPgjJXlxBeC7vhe7WoaSaXoZ3Wf
	5kofOkbdEazHOcJm2QxGHmh9qQSZU3HH9t8J6x6U7kY0tJjt7//nwzQ98C+qrDxjFtY+5m4=
X-Google-Smtp-Source: AGHT+IEqhqDXgHC4MZY+OWZh74zHsmVZF1CJ4511JHb4Xsj7rApNyxMJIZ9asTIyeHBktC25oodk9Q==
X-Received: by 2002:a05:6a00:39aa:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-73bbee3f901mr5234719b3a.7.1744305771731;
        Thu, 10 Apr 2025 10:22:51 -0700 (PDT)
Received: from L1HF02V04E1.TheFacebook.com ([2620:10d:c090:500::6:aed5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e51ed7sm3529815b3a.155.2025.04.10.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:22:51 -0700 (PDT)
From: kalavakunta.hari.prasad@gmail.com
To: sam@mendozajonas.com,
	fercerpav@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: npeacock@meta.com,
	akozlov@meta.com,
	hkalavakunta@meta.com,
	Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Subject: [PATCH net-next v3] net: ncsi: Fix GCPS 64-bit member variables
Date: Thu, 10 Apr 2025 10:22:47 -0700
Message-Id: <20250410172247.1932-1-kalavakunta.hari.prasad@gmail.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>

Correct Get Controller Packet Statistics (GCPS) 64-bit wide member
variables, as per DSP0222 v1.0.0 and forward specs. The Driver currently
collects these stats, but they are yet to be exposed to the user.
Therefore, no user impact.

Statistics fixes:
Total Bytes Received (byte range 28..35)
Total Bytes Transmitted (byte range 36..43)
Total Unicast Packets Received (byte range 44..51)
Total Multicast Packets Received (byte range 52..59)
Total Broadcast Packets Received (byte range 60..67)
Total Unicast Packets Transmitted (byte range 68..75)
Total Multicast Packets Transmitted (byte range 76..83)
Total Broadcast Packets Transmitted (byte range 84..91)
Valid Bytes Received (byte range 204..11)

v2:
- __be64 for all 64 bit GCPS counters

v3:
- be64_to_cpup() instead of be64_to_cpu()

Signed-off-by: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
---
 net/ncsi/internal.h | 21 ++++++++++-----------
 net/ncsi/ncsi-pkt.h | 23 +++++++++++------------
 net/ncsi/ncsi-rsp.c | 21 ++++++++++-----------
 3 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 4e0842df5234..2c260f33b55c 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -143,16 +143,15 @@ struct ncsi_channel_vlan_filter {
 };
 
 struct ncsi_channel_stats {
-	u32 hnc_cnt_hi;		/* Counter cleared            */
-	u32 hnc_cnt_lo;		/* Counter cleared            */
-	u32 hnc_rx_bytes;	/* Rx bytes                   */
-	u32 hnc_tx_bytes;	/* Tx bytes                   */
-	u32 hnc_rx_uc_pkts;	/* Rx UC packets              */
-	u32 hnc_rx_mc_pkts;     /* Rx MC packets              */
-	u32 hnc_rx_bc_pkts;	/* Rx BC packets              */
-	u32 hnc_tx_uc_pkts;	/* Tx UC packets              */
-	u32 hnc_tx_mc_pkts;	/* Tx MC packets              */
-	u32 hnc_tx_bc_pkts;	/* Tx BC packets              */
+	u64 hnc_cnt;		/* Counter cleared            */
+	u64 hnc_rx_bytes;	/* Rx bytes                   */
+	u64 hnc_tx_bytes;	/* Tx bytes                   */
+	u64 hnc_rx_uc_pkts;	/* Rx UC packets              */
+	u64 hnc_rx_mc_pkts;     /* Rx MC packets              */
+	u64 hnc_rx_bc_pkts;	/* Rx BC packets              */
+	u64 hnc_tx_uc_pkts;	/* Tx UC packets              */
+	u64 hnc_tx_mc_pkts;	/* Tx MC packets              */
+	u64 hnc_tx_bc_pkts;	/* Tx BC packets              */
 	u32 hnc_fcs_err;	/* FCS errors                 */
 	u32 hnc_align_err;	/* Alignment errors           */
 	u32 hnc_false_carrier;	/* False carrier detection    */
@@ -181,7 +180,7 @@ struct ncsi_channel_stats {
 	u32 hnc_tx_1023_frames;	/* Tx 512-1023 bytes frames   */
 	u32 hnc_tx_1522_frames;	/* Tx 1024-1522 bytes frames  */
 	u32 hnc_tx_9022_frames;	/* Tx 1523-9022 bytes frames  */
-	u32 hnc_rx_valid_bytes;	/* Rx valid bytes             */
+	u64 hnc_rx_valid_bytes;	/* Rx valid bytes             */
 	u32 hnc_rx_runt_pkts;	/* Rx error runt packets      */
 	u32 hnc_rx_jabber_pkts;	/* Rx error jabber packets    */
 	u32 ncsi_rx_cmds;	/* Rx NCSI commands           */
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index f2f3b5c1b941..24edb2737972 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -252,16 +252,15 @@ struct ncsi_rsp_gp_pkt {
 /* Get Controller Packet Statistics */
 struct ncsi_rsp_gcps_pkt {
 	struct ncsi_rsp_pkt_hdr rsp;            /* Response header            */
-	__be32                  cnt_hi;         /* Counter cleared            */
-	__be32                  cnt_lo;         /* Counter cleared            */
-	__be32                  rx_bytes;       /* Rx bytes                   */
-	__be32                  tx_bytes;       /* Tx bytes                   */
-	__be32                  rx_uc_pkts;     /* Rx UC packets              */
-	__be32                  rx_mc_pkts;     /* Rx MC packets              */
-	__be32                  rx_bc_pkts;     /* Rx BC packets              */
-	__be32                  tx_uc_pkts;     /* Tx UC packets              */
-	__be32                  tx_mc_pkts;     /* Tx MC packets              */
-	__be32                  tx_bc_pkts;     /* Tx BC packets              */
+	__be64                  cnt;            /* Counter cleared            */
+	__be64                  rx_bytes;       /* Rx bytes                   */
+	__be64                  tx_bytes;       /* Tx bytes                   */
+	__be64                  rx_uc_pkts;     /* Rx UC packets              */
+	__be64                  rx_mc_pkts;     /* Rx MC packets              */
+	__be64                  rx_bc_pkts;     /* Rx BC packets              */
+	__be64                  tx_uc_pkts;     /* Tx UC packets              */
+	__be64                  tx_mc_pkts;     /* Tx MC packets              */
+	__be64                  tx_bc_pkts;     /* Tx BC packets              */
 	__be32                  fcs_err;        /* FCS errors                 */
 	__be32                  align_err;      /* Alignment errors           */
 	__be32                  false_carrier;  /* False carrier detection    */
@@ -290,11 +289,11 @@ struct ncsi_rsp_gcps_pkt {
 	__be32                  tx_1023_frames; /* Tx 512-1023 bytes frames   */
 	__be32                  tx_1522_frames; /* Tx 1024-1522 bytes frames  */
 	__be32                  tx_9022_frames; /* Tx 1523-9022 bytes frames  */
-	__be32                  rx_valid_bytes; /* Rx valid bytes             */
+	__be64                  rx_valid_bytes; /* Rx valid bytes             */
 	__be32                  rx_runt_pkts;   /* Rx error runt packets      */
 	__be32                  rx_jabber_pkts; /* Rx error jabber packets    */
 	__be32                  checksum;       /* Checksum                   */
-};
+}  __packed __aligned(4);
 
 /* Get NCSI Statistics */
 struct ncsi_rsp_gns_pkt {
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 4a8ce2949fae..d3f902a1c891 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -926,16 +926,15 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 
 	/* Update HNC's statistics */
 	ncs = &nc->stats;
-	ncs->hnc_cnt_hi         = ntohl(rsp->cnt_hi);
-	ncs->hnc_cnt_lo         = ntohl(rsp->cnt_lo);
-	ncs->hnc_rx_bytes       = ntohl(rsp->rx_bytes);
-	ncs->hnc_tx_bytes       = ntohl(rsp->tx_bytes);
-	ncs->hnc_rx_uc_pkts     = ntohl(rsp->rx_uc_pkts);
-	ncs->hnc_rx_mc_pkts     = ntohl(rsp->rx_mc_pkts);
-	ncs->hnc_rx_bc_pkts     = ntohl(rsp->rx_bc_pkts);
-	ncs->hnc_tx_uc_pkts     = ntohl(rsp->tx_uc_pkts);
-	ncs->hnc_tx_mc_pkts     = ntohl(rsp->tx_mc_pkts);
-	ncs->hnc_tx_bc_pkts     = ntohl(rsp->tx_bc_pkts);
+	ncs->hnc_cnt            = be64_to_cpup(&rsp->cnt);
+	ncs->hnc_rx_bytes       = be64_to_cpup(&rsp->rx_bytes);
+	ncs->hnc_tx_bytes       = be64_to_cpup(&rsp->tx_bytes);
+	ncs->hnc_rx_uc_pkts     = be64_to_cpup(&rsp->rx_uc_pkts);
+	ncs->hnc_rx_mc_pkts     = be64_to_cpup(&rsp->rx_mc_pkts);
+	ncs->hnc_rx_bc_pkts     = be64_to_cpup(&rsp->rx_bc_pkts);
+	ncs->hnc_tx_uc_pkts     = be64_to_cpup(&rsp->tx_uc_pkts);
+	ncs->hnc_tx_mc_pkts     = be64_to_cpup(&rsp->tx_mc_pkts);
+	ncs->hnc_tx_bc_pkts     = be64_to_cpup(&rsp->tx_bc_pkts);
 	ncs->hnc_fcs_err        = ntohl(rsp->fcs_err);
 	ncs->hnc_align_err      = ntohl(rsp->align_err);
 	ncs->hnc_false_carrier  = ntohl(rsp->false_carrier);
@@ -964,7 +963,7 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 	ncs->hnc_tx_1023_frames = ntohl(rsp->tx_1023_frames);
 	ncs->hnc_tx_1522_frames = ntohl(rsp->tx_1522_frames);
 	ncs->hnc_tx_9022_frames = ntohl(rsp->tx_9022_frames);
-	ncs->hnc_rx_valid_bytes = ntohl(rsp->rx_valid_bytes);
+	ncs->hnc_rx_valid_bytes = be64_to_cpup(&rsp->rx_valid_bytes);
 	ncs->hnc_rx_runt_pkts   = ntohl(rsp->rx_runt_pkts);
 	ncs->hnc_rx_jabber_pkts = ntohl(rsp->rx_jabber_pkts);
 
-- 
2.47.1


