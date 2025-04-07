Return-Path: <netdev+bounces-179842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A04A7EB88
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F7A7A2FCB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0814258CC1;
	Mon,  7 Apr 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyQvKCes"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB92586C2;
	Mon,  7 Apr 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049997; cv=none; b=ash0MpioSei05fzvhJ6LdYP77jRP1r0y0wnw2ZYwlNwYpBu/SzoltgclX0G+sPB947pSueVPWWVdlYgXy8W+cTyVIDfMmcxjw4wES6ayq4z0lbgT4ypMkDL5rEvW018MEZ2OKTeo0drudZ0mn+XPw5A8/a2wD/rkqYnroEIaslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049997; c=relaxed/simple;
	bh=nQgtEaoaqkTqRn0y0aKEyT0w0Hb90EtadIuyRLwUSSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wndj+PxIwJh1/DTRY991YC1DknSXeZp6CEuehN2vBMZ9ySsAyzpMtVLNJU8EUcInUPU+GTIUz8QcF6gYgQqfdCOsxoTHhMBUA5Rty2D/yoHhYBHyU9bsetmm9RHKIaKJwkBUwHEPuZDwxTZXKr44jOTl47+PVmeyrjuFnM88Ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyQvKCes; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so4483784b3a.1;
        Mon, 07 Apr 2025 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049995; x=1744654795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx4tYkw6tAZkJWo7zJEN1RlRnCwREVPUGHZX56rizNY=;
        b=lyQvKCesv4aD6riDurLTwi++aS9ucsRK4UCZz1QSbtM6JnvxXCQWaDi4RRPNWpsRUj
         nsnatgU1N5fAmN/aAxyE/LtI88oQvUSfQxyJSwhtvokY8oOfCNK53A1bx98tL8Jl4KED
         7mbndN9GJFVD2mUVUW7RLTkVtv9LdFVAsAV1N495p7MX9RKCaH48xyXZ9t3+IpcoaTim
         7IU17I9TAcR+WFAiMziSGJBFi5AT1yFKyZTvgMFuPhzYmBps8G9kCIMPrQXWC6/3YU/x
         /30HTzkWgT4gVn4YDyT/ZuXqQ3sao/Wq2d1nlGAz0CqjlBaE38OgTzhfDe/Ljltvx/GY
         +p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049995; x=1744654795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx4tYkw6tAZkJWo7zJEN1RlRnCwREVPUGHZX56rizNY=;
        b=lRgmr8TUAC7zpohFXxd9l2gJX19qoQV9MvgCYJvzqnLzi7etDC/Vl6ApqHdvftLiTu
         86/PMrkQVbBYZfo12DcKTDu6VRUSZOM7Mu7TmrE8EQyEgzIyXxmVxCjwjISG4ZC4x8Vc
         3S3E7SwlCz2eZNPtIGzjapJemJg0i2DBVs+tlnvrIG0o7S0e+Iy8ZeWaBz8AYJ0r+tuU
         Om3pFYOokFM4fGBxA+avuG88hAPMxQ0LF42grVRrr8t5FCo5wfLUXNSBcTmSZlYK0Kmu
         1NO8SnSmyc+JkSvja5EpMkrxuZ0UXEATG1F2rXSiAHSHugX6a3UILwfj3Tf4JurZH5Xp
         tc9g==
X-Forwarded-Encrypted: i=1; AJvYcCWWqkuTFJcFZO8zDzDL5NaCPoHiPyG0UxzorrC6V4maARUnJ/493F3dbIjVePIfqCEpIDK2G1EV8nWNE/w=@vger.kernel.org, AJvYcCXQksr3IXfnDJ2C7TRRbOyPeQQaQ04MlFAxRjp7qR8+3bQpY+ZhMcajuTAsvQRHnnj0HdIFZall@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6V1xA/Qr6lSHvAtMAkWg+Sp2+hB+ABVRP++RNpDH4Tl1RSx4
	OOZahO+fcCajm0ePZFgNRnuJH2+OINl0iZhTj4QWv9Y89l7AofQ=
X-Gm-Gg: ASbGnct85rlJLxm+WStA3UqA8Krh+2JT3qbXFzCRS0AYuCKQnws1oI1KboN2uKnolxn
	FZtk5EDdnjZeKRpbjKowTbj9iKYxuuEff0ngsoiJnj5zuM6PEnkU3kDmRG1WGeaCoZYXwgNk1TV
	ko2rdHEmt43mgaq9i9gXV2BYAv0MrcnSq9U36LlEhFSQpsUvV3xJ5UEjhmZ4rbWz8DXlNpm5U5I
	AgFwXuElPObwe+9gSkEysFNa5R3U4cOuDxKXCrt+9WVgoJaDCuw28NvybQ8HTDPQKWHi6rug0RH
	J4X95tQH4INcZW6qpCuHrtozGKsx1Zo1XTobQPmYp2FCL0xJRwdiXc4AWFN8gU5qqHc699tfVG8
	=
X-Google-Smtp-Source: AGHT+IFIC93blI6hWKyM5TDpA0atwK7zhR/pRUL9VNJsow3+AqSmLqpkhUmeHBYijOGigcNtc566Ww==
X-Received: by 2002:a05:6a00:a89:b0:737:e73:f64b with SMTP id d2e1a72fcca58-739e48c6f91mr17206436b3a.1.1744049995077;
        Mon, 07 Apr 2025 11:19:55 -0700 (PDT)
Received: from L1HF02V04E1.TheFacebook.com ([2620:10d:c090:500::4:6c4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm8809243b3a.156.2025.04.07.11.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:19:54 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] net: ncsi: Format structure for longer names
Date: Mon,  7 Apr 2025 11:19:48 -0700
Message-Id: <0c76e0beea5036382a5aebaf9f636ee6e2f74db4.1744048182.git.kalavakunta.hari.prasad@gmail.com>
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

Format struct ncsi_rsp_gcps_pkt to accommodate longer variable
names. Purely whitespace edit, no functional change.

Signed-off-by: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
---
 net/ncsi/ncsi-pkt.h | 86 ++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index f2f3b5c1b941..6cf3baac99dd 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -251,49 +251,49 @@ struct ncsi_rsp_gp_pkt {
 
 /* Get Controller Packet Statistics */
 struct ncsi_rsp_gcps_pkt {
-	struct ncsi_rsp_pkt_hdr rsp;            /* Response header            */
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
-	__be32                  fcs_err;        /* FCS errors                 */
-	__be32                  align_err;      /* Alignment errors           */
-	__be32                  false_carrier;  /* False carrier detection    */
-	__be32                  runt_pkts;      /* Rx runt packets            */
-	__be32                  jabber_pkts;    /* Rx jabber packets          */
-	__be32                  rx_pause_xon;   /* Rx pause XON frames        */
-	__be32                  rx_pause_xoff;  /* Rx XOFF frames             */
-	__be32                  tx_pause_xon;   /* Tx XON frames              */
-	__be32                  tx_pause_xoff;  /* Tx XOFF frames             */
-	__be32                  tx_s_collision; /* Single collision frames    */
-	__be32                  tx_m_collision; /* Multiple collision frames  */
-	__be32                  l_collision;    /* Late collision frames      */
-	__be32                  e_collision;    /* Excessive collision frames */
-	__be32                  rx_ctl_frames;  /* Rx control frames          */
-	__be32                  rx_64_frames;   /* Rx 64-bytes frames         */
-	__be32                  rx_127_frames;  /* Rx 65-127 bytes frames     */
-	__be32                  rx_255_frames;  /* Rx 128-255 bytes frames    */
-	__be32                  rx_511_frames;  /* Rx 256-511 bytes frames    */
-	__be32                  rx_1023_frames; /* Rx 512-1023 bytes frames   */
-	__be32                  rx_1522_frames; /* Rx 1024-1522 bytes frames  */
-	__be32                  rx_9022_frames; /* Rx 1523-9022 bytes frames  */
-	__be32                  tx_64_frames;   /* Tx 64-bytes frames         */
-	__be32                  tx_127_frames;  /* Tx 65-127 bytes frames     */
-	__be32                  tx_255_frames;  /* Tx 128-255 bytes frames    */
-	__be32                  tx_511_frames;  /* Tx 256-511 bytes frames    */
-	__be32                  tx_1023_frames; /* Tx 512-1023 bytes frames   */
-	__be32                  tx_1522_frames; /* Tx 1024-1522 bytes frames  */
-	__be32                  tx_9022_frames; /* Tx 1523-9022 bytes frames  */
-	__be32                  rx_valid_bytes; /* Rx valid bytes             */
-	__be32                  rx_runt_pkts;   /* Rx error runt packets      */
-	__be32                  rx_jabber_pkts; /* Rx error jabber packets    */
-	__be32                  checksum;       /* Checksum                   */
+	struct ncsi_rsp_pkt_hdr rsp;               /* Response header            */
+	__be32                  cnt_hi;            /* Counter cleared            */
+	__be32                  cnt_lo;            /* Counter cleared            */
+	__be32                  rx_bytes;          /* Rx bytes                   */
+	__be32                  tx_bytes;          /* Tx bytes                   */
+	__be32                  rx_uc_pkts;        /* Rx UC packets              */
+	__be32                  rx_mc_pkts;        /* Rx MC packets              */
+	__be32                  rx_bc_pkts;        /* Rx BC packets              */
+	__be32                  tx_uc_pkts;        /* Tx UC packets              */
+	__be32                  tx_mc_pkts;        /* Tx MC packets              */
+	__be32                  tx_bc_pkts;        /* Tx BC packets              */
+	__be32                  fcs_err;           /* FCS errors                 */
+	__be32                  align_err;         /* Alignment errors           */
+	__be32                  false_carrier;     /* False carrier detection    */
+	__be32                  runt_pkts;         /* Rx runt packets            */
+	__be32                  jabber_pkts;       /* Rx jabber packets          */
+	__be32                  rx_pause_xon;      /* Rx pause XON frames        */
+	__be32                  rx_pause_xoff;     /* Rx XOFF frames             */
+	__be32                  tx_pause_xon;      /* Tx XON frames              */
+	__be32                  tx_pause_xoff;     /* Tx XOFF frames             */
+	__be32                  tx_s_collision;    /* Single collision frames    */
+	__be32                  tx_m_collision;    /* Multiple collision frames  */
+	__be32                  l_collision;       /* Late collision frames      */
+	__be32                  e_collision;       /* Excessive collision frames */
+	__be32                  rx_ctl_frames;     /* Rx control frames          */
+	__be32                  rx_64_frames;      /* Rx 64-bytes frames         */
+	__be32                  rx_127_frames;     /* Rx 65-127 bytes frames     */
+	__be32                  rx_255_frames;     /* Rx 128-255 bytes frames    */
+	__be32                  rx_511_frames;     /* Rx 256-511 bytes frames    */
+	__be32                  rx_1023_frames;    /* Rx 512-1023 bytes frames   */
+	__be32                  rx_1522_frames;    /* Rx 1024-1522 bytes frames  */
+	__be32                  rx_9022_frames;    /* Rx 1523-9022 bytes frames  */
+	__be32                  tx_64_frames;      /* Tx 64-bytes frames         */
+	__be32                  tx_127_frames;     /* Tx 65-127 bytes frames     */
+	__be32                  tx_255_frames;     /* Tx 128-255 bytes frames    */
+	__be32                  tx_511_frames;     /* Tx 256-511 bytes frames    */
+	__be32                  tx_1023_frames;    /* Tx 512-1023 bytes frames   */
+	__be32                  tx_1522_frames;    /* Tx 1024-1522 bytes frames  */
+	__be32                  tx_9022_frames;    /* Tx 1523-9022 bytes frames  */
+	__be32                  rx_valid_bytes;    /* Rx valid bytes             */
+	__be32                  rx_runt_pkts;      /* Rx error runt packets      */
+	__be32                  rx_jabber_pkts;    /* Rx error jabber packets    */
+	__be32                  checksum;          /* Checksum                   */
 };
 
 /* Get NCSI Statistics */
-- 
2.47.1


