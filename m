Return-Path: <netdev+bounces-180985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9EA835B4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F67460F47
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92C0189906;
	Thu, 10 Apr 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7qJ1bL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428001DA4E;
	Thu, 10 Apr 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744248200; cv=none; b=homRaYa3bkgdJT0wz1Z21G0CwwW5H/3xenONZkX/aaoZNRlrO4MQbEEVayLxCSYj6nlGpi/7nHcxGGLku+q8zJdzX54jVDe0RA5Ew2eAU4OdlzBXrYWZJQ/W2e8Q6ig4q311X2ZfLeP+6TO7NvnE+PzkbI1fvvseWMhwuF0XUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744248200; c=relaxed/simple;
	bh=hxMuH6PpTxJOvERENNu3LXkz6fCGmyU4+RRJdknkSnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fCd8q3sv9V/PQqbg8f7kVExyOCBas4Qe9tzhXoy5tEIIgpvGNO1NifyWP/B/PY0OiNxUvymtczNn2QZEwQ57/l9GsWbbnZ2uwuyohx5aIqsajpnpAAeCbxdlGvpW7hb64zEbC5Fll+uA02JsWbC64XYDh726zZoarW9UlO+XqT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7qJ1bL8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739525d4e12so191791b3a.3;
        Wed, 09 Apr 2025 18:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744248198; x=1744852998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEt59GVNicCAX6/NgHMBeN0OMnfwynAN5gVqXrIaGHE=;
        b=K7qJ1bL85Cwulg3asgrI+/AwXs+XXttYQrgr/pDpocgU/wNQkXY/l6AJALHEJ9b+oK
         wqbaYl0BWJZwWWyrHpPqf1LYAcNbJ57nUnAXSc3dlje3AsI7Lc6WHen9h18539GxRt/D
         B/zXG2/FVtszcYcpD+wWNKFfbGtuV4Muimf3am/ag9MJruWtmvaK2Zo4xrciE0klaky+
         kGEK6H8keEnj0iDLlwjYqLrsKQXdJ72qI9drv8lERcRMt/thrhDB9KQgBUbQVbdWsqUR
         hipn6aQx2IwdBHqjcGENxDvAz8LKCabDyqQeE6XNhz2ZEyPMdWteDuUM8X55ML38UIZI
         45OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744248198; x=1744852998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEt59GVNicCAX6/NgHMBeN0OMnfwynAN5gVqXrIaGHE=;
        b=jwiXFGGoUWngcQXEs9tygizaIDmUx/YtQMJxe58O5Fh7QcShquHp3iDAX0S+gpCmuw
         fltiTas6JsIV7+h1fKUDfFNObnhiRFwL/JJVkqZNR8SSB2MNDrvSABzmGd8tG4vkl6G7
         mM1mnEUxxUONXFM3CEfS6awWGb0c7Y7Vq26sISFFjDR+iYRutdcpkRVEmRxHi2nGs8Wq
         QsMhSr0zKS22PrQxQs8IHsm3VVARrM9v+HCRBhuBTLkmdtwj9CnSb+f5srIBwzP6QtMG
         DiMEO96/1MZKfyOoyItaqMUeRIm9SP1/NndE63WLn/CafUL4/Uapyvn0C62bJ71rHjnO
         dzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1fQYqdiHxDOsorMcliRQ0iiXrfgqOp4aDq6wKRU3EZ+p7Oi0DB2XSnXBIKGybwI4ltTyZlUWN@vger.kernel.org, AJvYcCVTkLoQiKZpTypByRb3awDh9/6Qb79rtDeNkkYYG3DaZzFEPNWFcIue1xFfOAFK9F/sHMsIPvsZjQ/eB4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypm4n5jRQJb65KSHPFYGN2+MKX3ZgSe5icBjezK3gjsT6f5lWC
	+hd0MzGlRwYw83eU3Stk+332bzfVQPe2XikbUfSSmPOyF9lE+zmu7xf9NQvDKjTr
X-Gm-Gg: ASbGncuvcSoWvO9VpEaFqOxV/DwCctKHRuG2jh/l92MqixYHdpmu7Z1+lmwXCBEu8U0
	uTZeavhVGTqJJa9L8eXBjNPg+iaLlloXVdZ1pxkn7oDhVvPLNfX1U5B9i/ZNIsmgBEvCEnKyLdz
	VNjSlSK9ta6iXIOIOsQInOIzSu3qonTP+2V7d9Ya0hUo2+o6MKF0ULroyO50QwAfTQjbLb8FEZz
	dxUoPt4iMOliaKPnNU/XErtyt01Q4CbQcAD4Zj1PvDDehKqt8D7/sGpug8w58BgLArKx4EyolA1
	kRACgk4Kn9ZLI4TiEdvqJxHKek4mJvKbuAr5ej8yw0uc3NJItR8RCoKprOeIWySjWnfVG5c=
X-Google-Smtp-Source: AGHT+IF1YIa+PUOY+w46Fc8ViEWljYI4uNceqWGpaGxPbVXfZtsCuBbZPc8hKko2U2a0rnflz+CByQ==
X-Received: by 2002:a05:6a20:a121:b0:1f5:8678:1820 with SMTP id adf61e73a8af0-2016948c580mr1940653637.12.1744248198251;
        Wed, 09 Apr 2025 18:23:18 -0700 (PDT)
Received: from L1HF02V04E1.TheFacebook.com ([2620:10d:c090:500::5:d128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e38258sm2120075b3a.107.2025.04.09.18.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 18:23:17 -0700 (PDT)
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
Subject: [PATCH net-next v2] net: ncsi: Fix GCPS 64-bit member variables
Date: Wed,  9 Apr 2025 18:23:08 -0700
Message-Id: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>
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
index 4a8ce2949fae..8668888c5a2f 100644
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
+	ncs->hnc_cnt            = be64_to_cpu(rsp->cnt);
+	ncs->hnc_rx_bytes       = be64_to_cpu(rsp->rx_bytes);
+	ncs->hnc_tx_bytes       = be64_to_cpu(rsp->tx_bytes);
+	ncs->hnc_rx_uc_pkts     = be64_to_cpu(rsp->rx_uc_pkts);
+	ncs->hnc_rx_mc_pkts     = be64_to_cpu(rsp->rx_mc_pkts);
+	ncs->hnc_rx_bc_pkts     = be64_to_cpu(rsp->rx_bc_pkts);
+	ncs->hnc_tx_uc_pkts     = be64_to_cpu(rsp->tx_uc_pkts);
+	ncs->hnc_tx_mc_pkts     = be64_to_cpu(rsp->tx_mc_pkts);
+	ncs->hnc_tx_bc_pkts     = be64_to_cpu(rsp->tx_bc_pkts);
 	ncs->hnc_fcs_err        = ntohl(rsp->fcs_err);
 	ncs->hnc_align_err      = ntohl(rsp->align_err);
 	ncs->hnc_false_carrier  = ntohl(rsp->false_carrier);
@@ -964,7 +963,7 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 	ncs->hnc_tx_1023_frames = ntohl(rsp->tx_1023_frames);
 	ncs->hnc_tx_1522_frames = ntohl(rsp->tx_1522_frames);
 	ncs->hnc_tx_9022_frames = ntohl(rsp->tx_9022_frames);
-	ncs->hnc_rx_valid_bytes = ntohl(rsp->rx_valid_bytes);
+	ncs->hnc_rx_valid_bytes = be64_to_cpu(rsp->rx_valid_bytes);
 	ncs->hnc_rx_runt_pkts   = ntohl(rsp->rx_runt_pkts);
 	ncs->hnc_rx_jabber_pkts = ntohl(rsp->rx_jabber_pkts);
 
-- 
2.47.1


