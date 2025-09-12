Return-Path: <netdev+bounces-222652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F800B55447
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB27AE559B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178F931C582;
	Fri, 12 Sep 2025 15:59:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB63191BF
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692773; cv=none; b=UNazFF5lsdQ49ljAA9FvAaibHJo3jRKdjsfJmycR3VDWH+Xtcwgs4gVSqk0LETw+dZJmj67f1Et7h5QSB7WebOcpePF1uhHvfRNUleSS12dyRh1u+qEvyr4YMDmNSimmq21E1JfCzJ4tP8zw/7c6gpUuWRgs+WuCzy/PK01K70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692773; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8M0ZlYxSDsQh0qIMN3klUwbAFSZQkfTh0iM7VQaB9TiXOO7u3sxfJ1T3mJeaQkftnEgQ8V7CaM5raeNgov/SFZ1IEv2BAjgof+2PWHfI50vn/Flxtaklt8rn0szNvoDBwfjjpJUruXlsHALC9lr3dL9SfwAL2uAf8OOp9lhCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so2352543a12.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692769; x=1758297569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=mddNYSRgSsR8ShgTCzzcXfTwSI41SB2KGc61gFnAiHTfDYUxrunxvfAZXl5E7oV5UT
         iE1oAmDT+yCzKSOnevNxSSNXJpxFqPW+Tl0yrnJaiZvqLgpCqwURbdmLFojxZnheIsZ8
         tErtPlJeMoJnialnVeZulPqv7vykHkn+7RcafgaqWQq09i6CAoJHww4WqK8bkxpr37Vg
         6smXyOgzL7UCQNatejaRNKlm3yCbhTcvt3YHpwV+a8M7LeLlN9iYd7zCT1TcO3koWG2P
         S7WUCv+Ti2P1ZdDevDcoGNyhiuY+wTIo2KKRXkAeIrB5yMFBpU7O4D8ew4VmSkJCOTqz
         R/nw==
X-Gm-Message-State: AOJu0YxUmm/2+gszjTPXStpVCRO614swmiDnHsgRO9Z+hpRervfUxXZz
	G5Fh98rsYMbSI9J9LUnZVDcU3mxXKPkvXZDF+IkyAic46woJxcIak+acj0GR4Q==
X-Gm-Gg: ASbGncsrJUs2VJuXTUMMziV5vMdI3tLt5ZOmzfgcqcMTTFhEZX3meZuPBm+TtVIagOr
	rKt9YSluFAE4ODwlLfs1LXX1PdP6BQyN58GsyxcjhqUkS8n9OM8KazEDb8/5uMTK2OVi1Je/gOu
	tpW76uSbrsEn1BIzV2jU64bTm0JPLS5XTssq7jUbgEpTF5FDo20HVRMe+299pqWAOYhbwqy9/vQ
	dzdwkGrV+WUCcJGCeUIOnYYZdNk1+l1MBF36V0uUPaT0ni1w6OVbESzzEeTA6xUjwMCAZwUjnZv
	MPgLILOhGYUvefkWt7I4NuwzPADrXb9bMoHouAOB7Z6qpYBIQpPgdeujyYJVthOzfsgixoucPdb
	TsNVUn/LkNtMnlwiAZPm4Los=
X-Google-Smtp-Source: AGHT+IGwXf3cEKsabQt7Cpv//i35Dk3tdl2J8AgqN2uAsDXsRwu0qjGwDDuOq0Zb8pJ6XlFCPXpkVg==
X-Received: by 2002:a17:907:970b:b0:afe:85d5:a318 with SMTP id a640c23a62f3a-b07c37fb563mr287369966b.36.1757692769279;
        Fri, 12 Sep 2025 08:59:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da310sm391317766b.20.2025.09.12.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:10 -0700
Subject: [PATCH net-next v2 1/7] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-1-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENdgqKr9Fqt+M3KsL86YnjoIRFj5P6h9BlZB
 uvzTHP8ZW6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXQAKCRA1o5Of/Hh3
 bZWsD/9ifi1mU7JfHUYLeM/FBblDRGtwn1dshElRb3dsckyN4Do12PHTEBk+mROTkHyOiYxqG73
 jiVB3pO0P6M1TGvZqfrwN4AZoCWsD1/U66QJDwQbVBumxJthXRVJfWlrbhqgChCWw2/+cjEaY+H
 KbaZtTHHNrYlCnhExil8uKsHkQnVpKiWPe2yTwAfvq1tCOzyAPNqskm59VHesdt2uVirAFeWyhn
 zr/1rHRRWH+NoEZUxOEpuMG4OFgjMSdtt6yOQlABdsbDP5aigu8eMGCXoA2PrTPDjvaFuFwxKLn
 5luWHIVPRD5F7zOu61nWpEjzC3sRbW1iEpFpt5Xwhs7MF8R3Tr+mNnN0dIdvjYXMK9XYGOl9ghX
 aZk0NpO5ZFq1IVwfFdovmudMo/iWo9DLzG9Hlyriyk45UR3Pp9wzZsjh9s0lCJjRhTsgaRSPqdW
 b3dEyQMf2TgMuoKBEZ43ghrlFVN0l+HA/3TZvsAO1zdphnET2omx04CFVxAV497gcanQNjXnk+0
 Wdh8BZTfE3X8mZvGe4PID3f4aUwUWH/bfkZMtULEMKx5c+b+UCSRtL3vlR6wFlAaKn7fPuI98Jq
 LILPXp8tedMFLh3xUIZEzsDp6tNVydkX/R28E2bVGTbyPE4WfWbUfZ4ln9xEZHnrGKyN0MEHhrg
 CcUQMWg52gv4n+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_copy_validate_indir() and callers to validate indirection
table entries against the number of RX rings as an integer instead of
accessing rx_rings->data.

This will be useful in the future, given that struct ethtool_rxnfc might
not exist for native GRXRINGS call.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b2a4d0573b38..15627afa4424f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1246,8 +1246,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 }
 
 static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
-					struct ethtool_rxnfc *rx_rings,
-					u32 size)
+				       int num_rx_rings,
+				       u32 size)
 {
 	int i;
 
@@ -1256,7 +1256,7 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 
 	/* Validate ring indices */
 	for (i = 0; i < size; i++)
-		if (indir[i] >= rx_rings->data)
+		if (indir[i] >= num_rx_rings)
 			return -EINVAL;
 
 	return 0;
@@ -1366,7 +1366,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;
@@ -1587,7 +1587,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;

-- 
2.47.3


