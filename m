Return-Path: <netdev+bounces-221391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5963B506EF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1A85E7272
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05F335CEC3;
	Tue,  9 Sep 2025 20:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0482341655;
	Tue,  9 Sep 2025 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449461; cv=none; b=KlFCZXA4ZkdGUXoBv6O1Z75IpGCwupXO4HFDQTgdfuYvnfbVpic0rixZQk1F3QAMQ3x95qibL8lt1IClChIIyDcnkwapydftfVh/fbQ0pWFCIQWhqzSm897vQ4qJVP5vlL1D8iqU7uIlZso0d8oR8MjY8x+tKOA1oxv6847rLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449461; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNmq+fV6NwMBj4GEW/jS79KbaAvpbiseoZwtSbjuMrKZpxYbg3kJmawdYDEMwlYFNjTZi/xXfuRYivSOiAn/Ja8v3FM+cSJwT5tBmYdhLtJqX/ZvjaWHj7+leTu3ekp8uIpAUpDAcAW0douTQv5gbKZ3GQwZToyr4ztFB8W0/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62221568039so5877373a12.0;
        Tue, 09 Sep 2025 13:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449458; x=1758054258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=NyCgkfxAC+v9vjO4qBpmIj8TZYzpEl+CBzb6+jvVCuU9Z54GBW1T6AVvLw7oYQtmoK
         LPyiDv6KG52o5Xt9ubQRoQ9HpTQqMIuV/KpSGV6To2hTd7wjH2qpTFAygC+zpGkZNAA3
         8IigDm9wV6UMWg+VZD+OUFKnLxrQC/2KOfPa+URmy+ttYeznLQiT4YMrWC88askeuVlV
         +mJjNPfcowJI1rFUF/bTVEYn/sWcD5/tz1YoWzyP0tjmo/Tczjd3dy/yvvpFSLoMUo8d
         qRhDHbCWLUCYwZkXBhAbJo2KF7N1Vka3PAtdNj4g1fZtM1mdh9s1b+nefui9j1GjdRWc
         D8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLt9+leEMyJdIJsyVPL/h1jnGDWL1uAuOcJEcYY+OEyoDe4daIv4f+Kv56xAhr3oeJHqLn0Gkz3Y4PWk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPKFjQQT4UfEi8rcgj0Oy/D6O7l97OhLMPON3UOKhOnycaaBu
	WjKTsxl+KRVULWjW4mYaBEZH/K6Syaiktr0vo6jTmEwgl7TuKrtBrZtL
X-Gm-Gg: ASbGncspg8eptW/qH0Al1gUUwL0/dHWcc8knJzXBUaa444jARqQC8umEXlNYNZcM12P
	Baz7oCzfRUuda6vOCtTR2ZrGGXFGk7KUlYtm3R7BDlMO+KFEF7W2SOmYd0/Nr3tafEE9Xs9Htq7
	m0IzA24p0/Bzx7Wr6v0wqgopKCvjGWAMrzZvCChtUVlHhZQwJ/e1LuYlec6Ob281AP94TFKsYyi
	qsGjP47b1HrfIbuBOKONJ0vygkY6BubSqHPSPnGmCWAqVXi6sBiyNKKIdqvsGXi7vUp/lYnJY2K
	VnrDXuN4tHNbN85ige9qFhwqUEap3r9/b93Qbj3SDBvv08WRMGkVg+qbK6nVfhXYK40sBLtCyhg
	LfiYTe+fsL2cZ
X-Google-Smtp-Source: AGHT+IG8G0E+/fESz8FriBcET9t0B7QGifi2i0GUmg+X9kDZI1HmO3AELIQZW3TPQ93vWVnhr8dQ5Q==
X-Received: by 2002:a17:907:1c93:b0:b04:4625:2372 with SMTP id a640c23a62f3a-b04b1437fe0mr1243169366b.15.1757449458203;
        Tue, 09 Sep 2025 13:24:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ffa5fsm45923766b.94.2025.09.09.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:23:59 -0700
Subject: [PATCH net-next 1/7] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-1-634282f06a54@debian.org>
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
In-Reply-To: <20250909-gxrings-v1-0-634282f06a54@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzuerRDZ8RHFW+5bNt7VkK6dkH9KziDNR3xi
 Mgsq0vZQh+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bTzxD/4nKkd93VMR2pDozwJKwJndOQpHEpM58d+xsJWZnYD9TzUijQNvdUTLw9/Emywiski4vRH
 4BlBx6zvH13HyfFnMjR79zDPrXw8YFLR8YsqtHm2RNjS3OShwLjBdYeS9PKOk2OfxusYW9ScSoH
 AdpZxkcr52bpAOw/99tN05gC5VCfMOusg2PVqLILjnN6FMdz2YezC37iCMPPKNLzSHD9n/55QxH
 Qyi/n9hkZLQozFGyjC/TDa/VxCb1/gQnYf3/g/dpOA7TZDUjBTqcUxjKmTYlxGVJ1eWakI8Zadc
 f3Y9VyukA+Ys+HdZ7biEVaCOKoCMztF7hg5kshBRn2Tqo0cLId/zDXr0Ie/lbmmOVgFlTKyQmoA
 XfF3JpODkZL5+3Y6gkLGeJdmj4xjw0sVKqqtNXI+AA4/lu0ZJsIydw1DMqFeraC2q3OUVZ8DlF+
 I9+v3ZUItnz+JqxJ72ZADIId0gCG9mgEZSt1zMtjuLH341EB3K/iVWr8FHeAxnRDeP42rKYcPui
 a5MHdsm2hOIPUH5Y9ZpygkSBKlHcTkFTKVk4izeDmaLAtK0Ehv5zgN952IJ4KL8eRRw2yvkLq6t
 kj5AJ/B5+GYvVXHwNYowP17lfor4+IhTjtJdS51IHYRZshDvF1fTQn1Zdns5F+8Zv/gil8eyw29
 SjRQF+vqVT+/yQg==
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


