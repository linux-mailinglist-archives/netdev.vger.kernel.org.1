Return-Path: <netdev+bounces-179843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DBEA7EBBB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30E642183E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13AA258CE2;
	Mon,  7 Apr 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy0TUpZh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BD258CC8;
	Mon,  7 Apr 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049999; cv=none; b=FndgknAitvJ2durW7kT8EDCprDD1wuw+5rKq648lDUBXo5kfv0r1bLFg99G1+C612gH3M9qZBWTHj+ZJqtsJJNeMPXqtvw1EcczzH4KW/p0GpdQ95qJZj/2oF4EfJ8XjUV+RUW4n+HojT9eqJHKTgZ0qH46q2lnBB7MtRerfKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049999; c=relaxed/simple;
	bh=/sTxE7cUwNP03JWU0ov5YMmOteddb3foGLKf9h+oqsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p52zkx4VDZCQ7/uCEa3Ur+4IDNgZRblI/EDqCvfZTkqhNwRLQcENDXtv2DC0po2nrSFmc+viUj2vjiYRFpbafJvbulS84GOlu0zGN1dT+5Zonhosr9rWQdv+qyOxYZt2AljG1yFH9nt9ZlcRwXQdwlfpfJ1uLjL+iDFVbDXLyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy0TUpZh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7370a2d1981so3926822b3a.2;
        Mon, 07 Apr 2025 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049997; x=1744654797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbtn07eW9FcgJJbFByfjJRlxec05aBIjcXvAjjhAvsk=;
        b=fy0TUpZhRzbFIQAQpztwuGUzoIJPzbYe7eLlhLgOn0FaYdRpNwKUypTExzrqqSG4qV
         gZWH3gUvyz8Z0o3/fbBHKcFo1EN83pj61cRzX/BxdHADD8frZky5g37dJdZqDmTWcD33
         3gMBtlzEZWTOGAiOZhkHoZW10a6ePlYpmeEii55NsTBQZggsqquUMpvLjaNtFk9TXJ/q
         B5nAuXmBs15nRGeNYGmCKvfDTornLhpCrmkLq6k02E6QgbaUr4F8lPeAF7nBSAmRJmrI
         qlC9w32AD8EQh2eO3BSV4XJSiXByLRdps65aGCzc6tb6ev83Zm/sOwZNjmiWiz1WyAPX
         5ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049997; x=1744654797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rbtn07eW9FcgJJbFByfjJRlxec05aBIjcXvAjjhAvsk=;
        b=DWOpg5OEcLNcFY1tSbB+ehMGl4qxhBVpnSpwcFiNw4v70FGv76X8V5rYKwHWQHpOWG
         oHlv+kfZRfPcOXv9sipAWkDL+TnJs8eDqdkGP3fHOw2ynaUaTUFO39kbTTPMjg08uqEL
         BsKlI6xuj//Z/oYGqQwGHkMJPFm2xGtg2aG2+Wb7EOlCJdicXlDfvElh8fxeajyiZRvp
         nCcoWg0O3nmWMq+IYq23Hr5lKs6Vshn5vb8TU3Jr0OAKoxoc8epy/xWE257sy3AJjiiW
         fRjAn2ApowBvaoi75y11Gl8CZBF3iuYjDcwX5ktTmtmWuXtbo9z8MWAr+X9x+Fbny0Ad
         5OrA==
X-Forwarded-Encrypted: i=1; AJvYcCUIXBryYQZtvMjRDgnYSrw2Gxq4Ovj1Ck0Tb9mVhw5cfhHwREWQ2LBIeiqTs0uKgdIOBELOrmbv@vger.kernel.org, AJvYcCWZW0gIT6HyvMoelG3gkXDWn+aYAe1lvu71BlbfHWoXtZF9x+geW0G/n9GyKtFJVaS+yWyFN5ZZLqdMzH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMtBeDXjdckhGDjI87Prq45pshjXERhetNnLES/RxsyMPtiirb
	kKoEB6/skwkDKyt6b8EOox5hBsv4c2tgekdQAl9+snhkSjMKRrs=
X-Gm-Gg: ASbGnct66HYrTHeCeeWiMt3rBieZxjpkvEddjrohSiu0Sxs7WJb7RUbrq4KLvsPaibh
	eJNRMnV+2cqdWCUS/zxsuxmH8TIqERT8YnQcgieOyxLGDCqYJbA+6Em1ihRmM7R2igixArNbC96
	U4TzdC5CF+1xDXMR0VY9n4p1CxG2NpKLZrMoOpvfdvXrRmjVWJB8NM1sNhs5WP7pwPip5TVE3ap
	1nyRpwIn1vMSC6RfGhHvDDM3iaGqsBISoOHFn4swBiUgLHu3v/dL27lKDvS/IqAkcs7+IeStNhp
	ha+S3jX6IYBKgGKRmcmY/womXRP/8h9/9X44DG+mlr2Se166r7CRABkgp1SYo0Hm/M3YAYxfaLI
	=
X-Google-Smtp-Source: AGHT+IHxWlmdTMzrdpOcsTJINRBdOg8s4X5Z82UlgDY0TXjogz3dae5Hj/vOa1WjWtUd/GwLkoEJaw==
X-Received: by 2002:a05:6a20:7f9e:b0:1f5:97c3:41b9 with SMTP id adf61e73a8af0-2010444e36dmr19370343637.5.1744049997033;
        Mon, 07 Apr 2025 11:19:57 -0700 (PDT)
Received: from L1HF02V04E1.TheFacebook.com ([2620:10d:c090:500::4:6c4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm8809243b3a.156.2025.04.07.11.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:19:56 -0700 (PDT)
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
	Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Subject: [PATCH net-next 2/2] net: ncsi: Fix GCPS 64-bit member variables
Date: Mon,  7 Apr 2025 11:19:49 -0700
Message-Id: <1ee392cf6a639b47cf9aa648fbc1c11393e19748.1744048182.git.kalavakunta.hari.prasad@gmail.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
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

Signed-off-by: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
---
 net/ncsi/internal.h | 21 ++++++++++-----------
 net/ncsi/ncsi-pkt.h | 27 ++++++++++++++++++---------
 net/ncsi/ncsi-rsp.c | 31 ++++++++++++++++++++-----------
 3 files changed, 48 insertions(+), 31 deletions(-)

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
index 6cf3baac99dd..8560e6fe20e6 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -254,14 +254,22 @@ struct ncsi_rsp_gcps_pkt {
 	struct ncsi_rsp_pkt_hdr rsp;               /* Response header            */
 	__be32                  cnt_hi;            /* Counter cleared            */
 	__be32                  cnt_lo;            /* Counter cleared            */
-	__be32                  rx_bytes;          /* Rx bytes                   */
-	__be32                  tx_bytes;          /* Tx bytes                   */
-	__be32                  rx_uc_pkts;        /* Rx UC packets              */
-	__be32                  rx_mc_pkts;        /* Rx MC packets              */
-	__be32                  rx_bc_pkts;        /* Rx BC packets              */
-	__be32                  tx_uc_pkts;        /* Tx UC packets              */
-	__be32                  tx_mc_pkts;        /* Tx MC packets              */
-	__be32                  tx_bc_pkts;        /* Tx BC packets              */
+	__be32                  rx_bytes_hi;       /* Rx bytes                   */
+	__be32                  rx_bytes_lo;       /* Rx bytes                   */
+	__be32                  tx_bytes_hi;       /* Tx bytes                   */
+	__be32                  tx_bytes_lo;       /* Tx bytes                   */
+	__be32                  rx_uc_pkts_hi;     /* Rx UC packets              */
+	__be32                  rx_uc_pkts_lo;     /* Rx UC packets              */
+	__be32                  rx_mc_pkts_hi;     /* Rx MC packets              */
+	__be32                  rx_mc_pkts_lo;     /* Rx MC packets              */
+	__be32                  rx_bc_pkts_hi;     /* Rx BC packets              */
+	__be32                  rx_bc_pkts_lo;     /* Rx BC packets              */
+	__be32                  tx_uc_pkts_hi;     /* Tx UC packets              */
+	__be32                  tx_uc_pkts_lo;     /* Tx UC packets              */
+	__be32                  tx_mc_pkts_hi;     /* Tx MC packets              */
+	__be32                  tx_mc_pkts_lo;     /* Tx MC packets              */
+	__be32                  tx_bc_pkts_hi;     /* Tx BC packets              */
+	__be32                  tx_bc_pkts_lo;     /* Tx BC packets              */
 	__be32                  fcs_err;           /* FCS errors                 */
 	__be32                  align_err;         /* Alignment errors           */
 	__be32                  false_carrier;     /* False carrier detection    */
@@ -290,7 +298,8 @@ struct ncsi_rsp_gcps_pkt {
 	__be32                  tx_1023_frames;    /* Tx 512-1023 bytes frames   */
 	__be32                  tx_1522_frames;    /* Tx 1024-1522 bytes frames  */
 	__be32                  tx_9022_frames;    /* Tx 1523-9022 bytes frames  */
-	__be32                  rx_valid_bytes;    /* Rx valid bytes             */
+	__be32                  rx_valid_bytes_hi; /* Rx valid bytes             */
+	__be32                  rx_valid_bytes_lo; /* Rx valid bytes             */
 	__be32                  rx_runt_pkts;      /* Rx error runt packets      */
 	__be32                  rx_jabber_pkts;    /* Rx error jabber packets    */
 	__be32                  checksum;          /* Checksum                   */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 4a8ce2949fae..50a59f4c021e 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -926,16 +926,24 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 
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
+	ncs->hnc_cnt            = (u64)ntohl(rsp->cnt_hi) << 32 |
+				  (u64)ntohl(rsp->cnt_lo);
+	ncs->hnc_rx_bytes       = (u64)ntohl(rsp->rx_bytes_hi) << 32 |
+				  (u64)ntohl(rsp->rx_bytes_lo);
+	ncs->hnc_tx_bytes       = (u64)ntohl(rsp->tx_bytes_hi) << 32 |
+				  (u64)ntohl(rsp->tx_bytes_lo);
+	ncs->hnc_rx_uc_pkts     = (u64)ntohl(rsp->rx_uc_pkts_hi) << 32 |
+				  (u64)ntohl(rsp->rx_uc_pkts_lo);
+	ncs->hnc_rx_mc_pkts     = (u64)ntohl(rsp->rx_mc_pkts_hi) << 32 |
+				  (u64)ntohl(rsp->rx_mc_pkts_lo);
+	ncs->hnc_rx_bc_pkts     = (u64)ntohl(rsp->rx_bc_pkts_hi) << 32 |
+				  (u64)ntohl(rsp->rx_bc_pkts_lo);
+	ncs->hnc_tx_uc_pkts     = (u64)ntohl(rsp->tx_uc_pkts_hi) << 32 |
+				  (u64)ntohl(rsp->tx_uc_pkts_lo);
+	ncs->hnc_tx_mc_pkts     = (u64)ntohl(rsp->tx_mc_pkts_hi) << 32 |
+				  (u64)ntohl(rsp->tx_mc_pkts_lo);
+	ncs->hnc_tx_bc_pkts     = (u64)ntohl(rsp->tx_bc_pkts_hi) << 32 |
+				  (u64)ntohl(rsp->tx_bc_pkts_lo);
 	ncs->hnc_fcs_err        = ntohl(rsp->fcs_err);
 	ncs->hnc_align_err      = ntohl(rsp->align_err);
 	ncs->hnc_false_carrier  = ntohl(rsp->false_carrier);
@@ -964,7 +972,8 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 	ncs->hnc_tx_1023_frames = ntohl(rsp->tx_1023_frames);
 	ncs->hnc_tx_1522_frames = ntohl(rsp->tx_1522_frames);
 	ncs->hnc_tx_9022_frames = ntohl(rsp->tx_9022_frames);
-	ncs->hnc_rx_valid_bytes = ntohl(rsp->rx_valid_bytes);
+	ncs->hnc_rx_valid_bytes = (u64)ntohl(rsp->rx_valid_bytes_hi) << 32 |
+				  (u64)ntohl(rsp->rx_valid_bytes_lo);
 	ncs->hnc_rx_runt_pkts   = ntohl(rsp->rx_runt_pkts);
 	ncs->hnc_rx_jabber_pkts = ntohl(rsp->rx_jabber_pkts);
 
-- 
2.47.1


