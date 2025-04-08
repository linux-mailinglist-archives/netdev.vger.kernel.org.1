Return-Path: <netdev+bounces-180050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F35BA7F499
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 08:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36951188B6B5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E525FA07;
	Tue,  8 Apr 2025 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4m3sMq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF725F97C
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092410; cv=none; b=os3JPWFkvIZ/k2WccjpbDxWlLgxwPbqA0m3jhjxFkkSxKQa7DauPMtf3eAekxCQdkNFX+dsoJuemv+7OcKHBNw1TbiOXrTuHjMN78K8Afmcf/+M6+2vPXNA4jgJ+Sw3fpE9f/bwDmLty3mGWxNtfHYg3Nr19p/QuyQZ0fKcE54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092410; c=relaxed/simple;
	bh=Aox3+Xmg9wuZmnWQdftzB8q4LDSIC/qS2G2THM27hKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JL2PlFYZyvYYuhwm5vW/UdK5+DZaxqXQPsLZY4iLNuZn7ULi1vNznMLrh1qYWDuKQ/RXmr8872coi0+j7DCFVxxYqRi5p9wID8rYN+MNqD3m2l5mAnI4f3no+YpQ6YbE2Gc/mVxznwM6nL/uoG9SPHYKJa+S9IbR0dSZ/D6A+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4m3sMq4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227b650504fso45631915ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 23:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744092408; x=1744697208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBoKJwOj2t61kw/H1gYwHjk6Tol9PSX6vbFvxa+NUA0=;
        b=d4m3sMq4xMj4rWw1oqY/ssL5kRGbG/Yvt/sNjtn7XG4onwn3QXAaHxowuj39OjJcib
         kV6zcly/YAjx6s9LerxIP62Np9Fs9E8aCZL+kNqemSOUvOqcgOQJRVZ2pgm/tloEhlun
         RcdGF0JjuprCpom/BrjPb5wLI4B4OtTWy5hQlss0smRNC/Y8bBgvXv6eJNhQN6VHFJrH
         3QqiHu+7qvV68KGEqbziAVn3F3TytupbpmlciRoAg8dKgVWosaiaQAHI+2lE/+cY38PC
         FEKuOodpIZSlARvH2mQSeygZxbqyDE9+LzeCp/lDNCFmrwBlBOjPa9oP8h0jVnwt9vJF
         Snbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092408; x=1744697208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBoKJwOj2t61kw/H1gYwHjk6Tol9PSX6vbFvxa+NUA0=;
        b=kBPHEViCwcn3t4bWT0jNw7p+LyO8lI3U0pt0v73Z1C0z6c9w73hBmrdMxdPX4OzRuv
         B3mSFi54hlurX+1JoUef3Ymf7rkm9+paZx9ZfBvFcJpCT79HxQ4w55THF/uHTmn9OXx8
         fuVhp7wYUvDugu117w0C2epOOXGigIOaAzGrajTP8Z4fPnZuj/IjDN44MJX070Z8Q8Uv
         OqYYMnVXrgHbR4ck4EpqtOmfgKw7G/x5Q8kEBFFmiDKG1Q4Bd8QNG4y16hwxqdCNrN56
         CEPkJi8XDiNJRCEC6hxeVTJHwkRVhRQzQNmrqwMLchcyM9QHm+e4rjtFdFHYDPXoV0Mv
         r2RA==
X-Forwarded-Encrypted: i=1; AJvYcCUdwi8VocCMSzd42yQQdHHViMz6wSuQB8QLbDuL+f4uQTsDgmHT6RSRH3cHxiz21Ko0Sfh3IzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDpirD3he8r1lwoRgoN0xKPFPa93xxUHHBghfshjCiMm4Qgrg
	eCht8hmi8gFuYbq9bNzq/3+iaibIcs77YsLxe7MBMiAAgG1OZbt3
X-Gm-Gg: ASbGnctJoHep/Oa/lD60VD1kkFEznZyz6nDUU3/o3WUqU+dnqKiTREQn1EwmfI5OeGM
	f+49gIN7Dg6g4R4mioxCkM4ERk73SyEQUnbTfP7BSXE37O7toQhtui5wZaZahX2X9CKccZhD63Z
	yzwPrLYIwSDHEGcB+J2sJQ9x+FVf3U3e8IgqvmcUSf+tT741JDb59flfehsWiR92jyeAlR85kZ0
	rsazhxRViidCPo7qgOq93A4nBvkZW5PASgpFRnQkmmaj9SbjfFJ/hGjtxyVCt/CVox/iaCcTD52
	QfcXrj07ghAURtvPL/6U08cm1nQhPHKjKQ==
X-Google-Smtp-Source: AGHT+IEEK3gl4d5pXzMqOEvc66OPoEguSxC9r1drmvaVmsMPhOzHKBtyNlRNzuLYOu8lt+ghOLvz4g==
X-Received: by 2002:a17:903:906:b0:223:619e:71e9 with SMTP id d9443c01a7336-22a8a04a7fdmr215823735ad.11.1744092406845;
        Mon, 07 Apr 2025 23:06:46 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c0127sm91922605ad.91.2025.04.07.23.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:06:46 -0700 (PDT)
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
Subject: [PATCH ethtool-next] ethtool: Add support for configuring hds-thresh
Date: Tue,  8 Apr 2025 06:06:25 +0000
Message-Id: <20250408060625.2180330-1-ap420073@gmail.com>
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

RFC -> PATCH v1:
 - No changes.

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
2.34.1


