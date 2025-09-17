Return-Path: <netdev+bounces-223929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA5B7D5AE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A273B6942
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1948334F489;
	Wed, 17 Sep 2025 09:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBD32D5C5
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103102; cv=none; b=ft8OHoXs3tee5RQVmr1bry1GOKJrfC01jlElTMDCSCNUJgGL3Odccigop5lvmTgmWB9V7m7CFml//SpZOlhNkFQieS4UQoi2ghiHNBS0R8YbHbp+aL6JjRqdQpJDD0Q2yq6A7bj+nmCgOxmUdMcuTBzLl8By6NPfMDszstS8uvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103102; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s8I4cp0sOlUo2KJNGibY0jt1NRZRlOy9npecXGkhjZJK7fdFm5j4a5KI1psoWPLmklvwMZnEs0p4X9Tfr7g1hVjUY4fONqVtItFUOIvrorH/1fTS+70nOIRl7Lvvc3X+Vd8nXDLdjVW9//5BhxoydCJhiRMN4N4WGHs8jhmUYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so986164266b.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103098; x=1758707898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=oaGqiKHDB7OHIHXZLN0FNyLIdJ1o4lCiZxAd4pBXgFRowDUJvPOWtw4cV86+n/HpZL
         kNNw5Gpi8GTU2mkIyAXgbzWUcdA+aBc3DZuIdYd0i+VfLLwEBjBrO+Ur+DFv2A43AaE2
         D2pgPRhOaEf29lwzJWjSJFUqS2HRE1NGt7Z7UlWt4Z2AGwSgPpJqqecWhIpsilR6uQIL
         3meAioVA6zf+8ShbWnIVmjMmdTQgo2bgCu5BAZ9md4nqTUShJUAeR61J+Q3FIgQArO7e
         KUWxw111GxwrKM4IrdIDDff44Ndq68SzOIUJPNGm0MqACCfAXhNfRI+PFNQFpjBmfcgn
         Q0qQ==
X-Gm-Message-State: AOJu0YyGTDJdjWimkxsrtpwYwPH0hndmP1tsn2QlQQJN7fNH3oP57YO6
	MxgycCh5EIF/Uh1iRwreft9RkOw46MKhVTJ2bQ3E8M4egqLz3vF8Blv7
X-Gm-Gg: ASbGnctvtvC9DSkNNHF+lht37ZTDBOU8nnC+8D5daG1EAslho4fT3TzvaCiw4polqLw
	H+UM3ZhWh0plMaizo2q+kv3uOnflMmSJAABI4Ma3Ad7j1nTXBciNWMRbugdNTdTVggQlto/ob5s
	EkDJK4a3vgV4MAAa3x0izVSChvIOXBEaMMowYASKWPHUrneQIry4gP4aW9NO5G6MqNzRMor/Pdv
	9z8UPLtlvxEd32Q59pX1Z0w3tUs/6hGGLiwK3kvxLDHWm+BX/8EbAwxbMBspGoPKhWWB5dpL/4i
	2sqGLzEve3ncoKBQPEOQ62BtpocdXw4S8E5oTgNwiV0wPA1VQsbKrAhFFaz15N6bNLYSXdkwpHj
	vzDYm1nUyYeo1
X-Google-Smtp-Source: AGHT+IF32qzwZCLc4MBxGsmW9WhgDqh4KQLE/xEwqC+/peEotmieMDpT8LsNsX1yfGVQeGzp8aNg9A==
X-Received: by 2002:a17:907:3c90:b0:b0a:333:2f97 with SMTP id a640c23a62f3a-b1bb7f2a341mr188100866b.37.1758103098067;
        Wed, 17 Sep 2025 02:58:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da388sm1326212966b.22.2025.09.17.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:08 -0700
Subject: [PATCH net-next v4 1/8] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-1-dae520e2e1cb@debian.org>
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY27qTLNPpFEVPrZdXSTPTiQ6yrKRmKdqmbf
 QY6yNNOuS+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bQckD/9KObOk9COJoYFWO77hAsuCTU4+zMulh6m6xxBNe2DEIfWbp25ZjPPkQvGdIOLoTpWIk11
 /KP9eABtbMiR7ngAtKDSONV7dzKEF+Zb5ryUkNUuIJ5XB7HC6vUJVOFZo8AfEBNiSl4EaUwAdL/
 04vhfxMoYkR05psE9C2m1NYoVdmYcne9aTD37LlJM0L5X6HafbABgc/q+JfhHnKve/+yYoCKTYk
 B2k+OKQ9iT6QKha9+ecgjxmlCTx6abQeUGOj6PL4xUN5KthgiP1Pcut4XNye3i3SG5qJPlwrgFs
 ugJaubjrPuRQLyAeKsXA9YnDijtLCZtFU3ScMRXVIhCUb/wLpzms4sDAPt0+xrQZB9moFV1BnlX
 hk+y38UhWRYpuRUgQdVw7QGs4t8lmKRCIFY41cRRG2itSE4Fgk+6nLiMEH/BdgWnGka6rUfZ9cg
 gcBS7ecSS2svUmxIzqStNxRRHB+87Qrvh2BI4tspyf8fnBga5TKtu8seg2THJh9oEU1XNgoq8W/
 yhd3NkkZEZ7fioMHrbxPnt8g/MkunSCxGRlcpAW5XZRc+RjPhECxJ5FzEjbXtFAxEvM11k/Aw+7
 97xa7iB0YkNHopjyTuYhiVzXCZvVQjKONrQa4dpzeG2hP+1H6M982JUFkyXJrL/8CD2PbdRthO5
 ouVU5d0dfifzTzQ==
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


