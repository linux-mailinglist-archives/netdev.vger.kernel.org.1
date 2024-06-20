Return-Path: <netdev+bounces-105223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA391031B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4731F22E61
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134671AC23D;
	Thu, 20 Jun 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="QKqQ0Je0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192D1AC230
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883338; cv=none; b=ZVPtXKhWpUwr+85/aFaUG2MXkZXBIcTpekDgGkv77IfnsZ4FEwF5FbLKKiakcrSpPZI6fRJC0flYW+STyhzDOBAr2oC6X+k04MPU9PEb2nPOc8fLFmbtZYNGjAVo5Xz1/AxpKO4BRFEHAr38rKJBne8N85uFuoRUhpaj2fY/YaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883338; c=relaxed/simple;
	bh=x7omDxUPbZV7/HufJPxDWQarrRBoOigY55WGBtYBibA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJ0ja3Ob50f03wFYeM6N09WaQt1suSzerqGEgAmOsvOC80SRP6Ge4biixKTGMbfPFBYiQnEJwe4p3T8prX+uL9x6p3EBz882ktqjTZlMMNwKCV6iFb6XgGtik5+VXqMW72yaFbsu4/LetmjOoKkp41PXTA2wTRIWA4mayvUNFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=QKqQ0Je0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so639519a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718883335; x=1719488135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dVIO9B/gKgBOADV8jO7dDGNIDax+746A0tzxgyv+QQ=;
        b=QKqQ0Je0QBdrTIm8zqLUzlEAZfwYryBBrosrKrNumTWbU2c4RQYEvfuwNdRlN9r+0j
         xJP+tZjJBgDxmloGyr3PS/91c+WIwWnTstxMODex64/Ro5jY+CJm2VdcVPGuzsUPUp/K
         19GBDtOX6vYyZTBSGHX1vgKtXTAwscV+A/o05ZSWh9/hwda+qM91oI26q09SqwFs67s1
         /9lgW/tDvqC93K/Z22g9PxCbfGI61H5HzngcxENS5stf7Y1QdRWerdyGOqkC2rTKX/WE
         usB8dVaE7ATi2L7NTHJFfng2Tn9TfxyYzmeojwkJP9+N+MHWokTrbERGiLpuIH0e0z6J
         4+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718883335; x=1719488135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dVIO9B/gKgBOADV8jO7dDGNIDax+746A0tzxgyv+QQ=;
        b=Y/hfvr7+ltyuRCYncYkOlbLboHZxypVjs0CjgUpzg9cdCSyJpTPNZBeuB7giwgsq49
         u9eulHDETZq0Ty93rjL3UCzfvDjjToPUX+S8kI9ZnNCtwVV47sNMRPKbnT01lGg7Mhvf
         1HEj0k1GyJi/artD8scFMLJ3dv4asQKPo45muZ18pwTUVSsiErXC0iLQR4B5rKTfWnUV
         R2epplMIXU6cb3X8dwZNn0cNq02kWXVM4C8MJTI+aewofxfhhJzqolkr18ue5YwGPPj2
         s5wrWeFR7wqF9oXf+SuEUl0lyZW/rOhXgO9pVa0VW086n1i/O5rTw9/HxwZ/wKJ0f/v/
         J4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQUJMjHTWJr18bZhCl/TpRE+uGCQWQdKb/Z4eTWvU4qcwieS2k1BdxjKaWUt7pqwp9iugZ70lHxiAwBhC8Id5zRyxjxocR
X-Gm-Message-State: AOJu0Yx09J9lsFvyB2FygP9vywwUx/ojdl2mj7PnbDQvSEWHPuT0mNo3
	x2Gfm6r90rR8LAfLdVo1ZS8bynhHoLX59MtHikmC/8/y3vTYiWOHAFVjhs7aSJs=
X-Google-Smtp-Source: AGHT+IFRllndN6Xym3DAVRxuUPeCS0DRq1KGMb2aEJa7kDuGQNYUEeIY8ehUjwujMjdb446BuXz+yg==
X-Received: by 2002:a17:90b:104c:b0:2c7:6305:9905 with SMTP id 98e67ed59e1d1-2c7b57ff1f9mr4863150a91.10.1718883334926;
        Thu, 20 Jun 2024 04:35:34 -0700 (PDT)
Received: from remote.smartx.com ([1.202.18.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9db7sm1442885a91.40.2024.06.20.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:35:34 -0700 (PDT)
From: Changliang Wu <changliang.wu@smartx.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changliang Wu <changliang.wu@smartx.com>
Subject: [PATCH] netfilter: ctnetlink: support CTA_FILTER for flush
Date: Thu, 20 Jun 2024 19:35:27 +0800
Message-ID: <20240620113527.7789-1-changliang.wu@smartx.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From cb8aa9a, we can use kernel side filtering for dump, but
this capability is not available for flush.

This Patch allows advanced filter with CTA_FILTER for flush

Performace
1048576 ct flows in total, delete 50,000 flows by origin src ip
3.06s -> dump all, compare and delete
584ms -> directly flush with filter

Signed-off-by: Changliang Wu <changliang.wu@smartx.com>
---
 net/netfilter/nf_conntrack_netlink.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 3b846cbdc..93afe57d9 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1579,9 +1579,6 @@ static int ctnetlink_flush_conntrack(struct net *net,
 	};
 
 	if (ctnetlink_needs_filter(family, cda)) {
-		if (cda[CTA_FILTER])
-			return -EOPNOTSUPP;
-
 		filter = ctnetlink_alloc_filter(cda, family);
 		if (IS_ERR(filter))
 			return PTR_ERR(filter);
@@ -1610,14 +1607,14 @@ static int ctnetlink_del_conntrack(struct sk_buff *skb,
 	if (err < 0)
 		return err;
 
-	if (cda[CTA_TUPLE_ORIG])
+	if (cda[CTA_TUPLE_ORIG] && !cda[CTA_FILTER])
 		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_ORIG,
 					    family, &zone);
-	else if (cda[CTA_TUPLE_REPLY])
+	else if (cda[CTA_TUPLE_REPLY] && !cda[CTA_FILTER])
 		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_REPLY,
 					    family, &zone);
 	else {
-		u_int8_t u3 = info->nfmsg->version ? family : AF_UNSPEC;
+		u8 u3 = info->nfmsg->version || cda[CTA_FILTER] ? family : AF_UNSPEC;
 
 		return ctnetlink_flush_conntrack(info->net, cda,
 						 NETLINK_CB(skb).portid,
-- 
2.43.0


