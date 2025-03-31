Return-Path: <netdev+bounces-178278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7239A76516
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410933A8A0E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76B1DF747;
	Mon, 31 Mar 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU+cXKfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE31D86DC
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421194; cv=none; b=lEKLryGUOptkvLx+m0WOfad0g0Xrf1vI7u3c+NUI9oxVMOQOc8PIxuGwJX7jS4TQ0Kk2ATDC9+f137PTwZPswdd9B+L7tK9NEyJsFm7KRANaNQlL6ysP7udQB4PpBU+0YI2JCFFoVZt4Q+4MtU/P9zAS/L47ND69pcf/Tp2blkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421194; c=relaxed/simple;
	bh=YrScmurkxhIyC91Wc+HK3q+RZEPQL0/XS4k5IxVGCJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQSihfmrfp5C3ge6ewS6Ki6hMaKwgnffxmJjz9Hk9QJC0IXCdSHToaaHnR0sRAFWQh2kiS2glP45OMtUh79kRUH1zaVhdAyyY5zMC4QAW4DCNP4iwR0DEG3VRNzUdsQigBPVgJ9y03VwffKZCP/uZjCZyrzMmakAvLgbh8Px9CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU+cXKfZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2254e0b4b79so112769515ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743421192; x=1744025992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClmFHeCI0LW7lbz1gzcY2F1IT+aHu93StavcX/Gl8/c=;
        b=eU+cXKfZ1Ax0UDAnVJiK8kha+Ivolu6AwDYje87XFNhYOrSp6wYLSUGl7X6B55+gxa
         xsTm4AX+ovH7dBqQFB9rAw/A6MxDVzbFRKy9WrHyErBPcaxs+xpLJ1U+/izuerz2wiew
         gGc0QjTxGB6kgM6x5JNzG4+vjOlesZ7SVLU2u8ms1TuG7kK8DEetN0Lt+iApmMKGZlOg
         YCYT+rLUcfZhfvfvV98TcsIipPUawbh/eWlSf54Gjd+zuKpq8bSFVPY7eb2tJW7obMQe
         S6b2vnJU96FX5aWMhXK2vV27ocNFidhnTDl9wbvdSG1vfQ4GaRcJejhy2JdrJeF0qpQq
         MZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421192; x=1744025992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClmFHeCI0LW7lbz1gzcY2F1IT+aHu93StavcX/Gl8/c=;
        b=otqjpmeaZDUIr6CQNuS80eIVxvSnDSa++ODW/Ib5MyArtf5t976c4mEQYbnLDdqQYg
         6By3J0vgh5fsZUBWZ47tQcPsYdQgwQAhqRBBSK1lbBTpBxWCbaLWSRMFG4WDfYg6a3pL
         OOuw5hrTtJvSCOXVDJfmwxBlJg1qaf47P94Ki8U66rj18K7PVpcdXCiN/+RTndOr+uO1
         2n7S+RVp5aJ2ZikqVDmEVCrNWMxZIhsSiRhQIaFNGTs6Oa5eQqL98E18STLkQZ+jdebQ
         NxyrbsdY3k3uOojQskH9TJ4J7z8r84zF2pHT4VWz3c+8z0rxDsbxYzFcRLm6R9H/yEj2
         7aLA==
X-Forwarded-Encrypted: i=1; AJvYcCXrZ+AEAfl8JuhtC6mGLKz9MnvGmqjF8cheIhgH+JlmYd3Bw9DUvpC7R2JugA341bYX9kI/QOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqvWo77ov3h+VFsKm7XYUJmCXT10OrbKyiTlMriWhKmwj192k
	5olNuJarlnTO5PjRIWbyeVn/BfnbD2+nphoxXYIX9GVRwtjD4nrI
X-Gm-Gg: ASbGncuUIK7obfIIi/m8cNCJygGVLAgdl/ZEOJZGB7DBC/qCwps/GdRgGjEcv80bR9G
	hD9pCO6JsM1JWGbmO7NI1n0VgNtFLIZvlgx7SOA+Waq4yA1KdDpqTtdGI/ky4uW/v3DzXgxKf8x
	bsA4bS5t0+eXJt4jtno6eadZd8DQL8f7oaoeMAdoLn6EpLafAmTd6q8YDVw5PxAaqfzB1jyPkIp
	nlEmY9k1HFdUF/EwdWX1QZ5p1tlgRjbDH+VJuGcxjeQXl2EAhhV+MihxLUex889FZm4LwWt2rYK
	JZmgZSAzuhGmv+tqttBvT/AVzvnORzCuWA==
X-Google-Smtp-Source: AGHT+IH3c8/15VfymHIFIiaYsMr00v04vrO1Ee/Lmw5ya6Dhz6Bmz4Nzz6RCM+Lr7IWzV5vU2b/TOQ==
X-Received: by 2002:a17:902:d487:b0:223:5a6e:b16 with SMTP id d9443c01a7336-2292f949419mr151093335ad.5.1743421192324;
        Mon, 31 Mar 2025 04:39:52 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cec3esm66812145ad.122.2025.03.31.04.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 04:39:51 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: mkubecek@suse.cz,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [RFC ethtool-next] ethtool: Add support for configuring hds-thresh
Date: Mon, 31 Mar 2025 11:39:44 +0000
Message-Id: <20250331113944.594152-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDS(Header Data Split) threshold value is used by header-data-split.
If received packet's length is larger than hds-thresh value,
header/data of packet will be splited.

ethtool -g|--get-ring <interface name> hds-thresh
ethtool -G|--set-ring <interface name> hds-thresh <0 - MAX>

The minimum value is 0, which indicates header/data will be splited
for all receive packets.
The maximum value is up to hardware limitation.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

This is an RFC due to merge-window.

 ethtool.8.in           |  4 ++++
 ethtool.c              |  1 +
 netlink/desc-ethtool.c |  2 ++
 netlink/rings.c        | 10 ++++++++++
 4 files changed, 17 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 76a67c8..c910035 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -210,6 +210,7 @@ ethtool \- query or control network driver and hardware settings
 .BN tx
 .BN rx\-buf\-len
 .B3 tcp\-data\-split auto on off
+.BN hds\-thresh
 .BN cqe\-size
 .BN tx\-push
 .BN rx\-push
@@ -692,6 +693,9 @@ Changes the size of a buffer in the Rx ring.
 .BI tcp\-data\-split \ auto|on|off
 Specifies the state of TCP data split.
 .TP
+.BI hds\-thresh \ N
+Specifies the threshold value of tcp data split
+.TP
 .BI cqe\-size \ N
 Changes the size of completion queue event.
 .TP
diff --git a/ethtool.c b/ethtool.c
index c4b49c9..6817baf 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5874,6 +5874,7 @@ static const struct option args[] = {
 			  "		[ tx-push on|off ]\n"
 			  "		[ rx-push on|off ]\n"
 			  "		[ tx-push-buf-len N]\n"
+			  "		[ hds-thresh N ]\n"
 	},
 	{
 		.opts	= "-k|--show-features|--show-offload",
diff --git a/netlink/desc-ethtool.c b/netlink/desc-ethtool.c
index 32a9eb3..e4529d5 100644
--- a/netlink/desc-ethtool.c
+++ b/netlink/desc-ethtool.c
@@ -161,6 +161,8 @@ static const struct pretty_nla_desc __rings_desc[] = {
 	NLATTR_DESC_BOOL(ETHTOOL_A_RINGS_RX_PUSH),
 	NLATTR_DESC_U32(ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN),
 	NLATTR_DESC_U32(ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX),
+	NLATTR_DESC_U32(ETHTOOL_A_RINGS_HDS_THRESH),
+	NLATTR_DESC_U32(ETHTOOL_A_RINGS_HDS_THRESH_MAX),
 };
 
 static const struct pretty_nla_desc __channels_desc[] = {
diff --git a/netlink/rings.c b/netlink/rings.c
index f9eb67a..5c695ab 100644
--- a/netlink/rings.c
+++ b/netlink/rings.c
@@ -51,6 +51,8 @@ int rings_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	show_u32("tx-max", "TX:\t\t\t", tb[ETHTOOL_A_RINGS_TX_MAX]);
 	show_u32("tx-push-buff-max-len", "TX push buff len:\t",
 		 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX]);
+	show_u32("hds-thresh-max", "HDS thresh:\t\t",
+		 tb[ETHTOOL_A_RINGS_HDS_THRESH_MAX]);
 	print_string(PRINT_FP, NULL, "Current hardware settings:\n", NULL);
 	show_u32("rx", "RX:\t\t\t", tb[ETHTOOL_A_RINGS_RX]);
 	show_u32("rx-mini", "RX Mini:\t\t", tb[ETHTOOL_A_RINGS_RX_MINI]);
@@ -83,6 +85,8 @@ int rings_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		print_string(PRINT_ANY, tcp_hds_key, tcp_hds_fmt, tcp_hds_buf);
 		break;
 	}
+	show_u32("hds-thresh", "HDS thresh:\t\t",
+		 tb[ETHTOOL_A_RINGS_HDS_THRESH]);
 
 	close_json_object();
 
@@ -194,6 +198,12 @@ static const struct param_parser sring_params[] = {
 		.handler        = nl_parse_u8bool,
 		.min_argc       = 1,
 	},
+	{
+		.arg		= "hds-thresh",
+		.type		= ETHTOOL_A_RINGS_HDS_THRESH,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 0,
+	},
 	{}
 };
 
-- 
2.43.0


