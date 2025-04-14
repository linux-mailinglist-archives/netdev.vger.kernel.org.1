Return-Path: <netdev+bounces-182373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409BDA88958
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26873AEC1F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354F4284685;
	Mon, 14 Apr 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXae/3fB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B29191F98;
	Mon, 14 Apr 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650433; cv=none; b=UA1zzLwmGAEsqPh9kO71QySvtQsmWb/e1/ieSc/19A03jiaSTSnhH//0WLvtjwTPis2suOwHYfque21VAhTj58zJQJhzNGmz5oDhPFpLK4OjjkQPlY5P/VCUkUz8/C0TOQGRc1Z9fJglQZ9S1mP0R/RH8Ho82KLg/uzQSyOhXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650433; c=relaxed/simple;
	bh=fNUgT7DJYQcXoNCcmnlI9t3Uad037thoynfSCazQZT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cxoq53eOOVXoxcx3dvA68yD5PSeINCNIggL/4wQJ9S+u/j5sACOHtnJlXGkVtrix2oAJbuU5f1IjOwVADD0aNiLWjgDd6ld9ziRiuGtT+kLli6fCBqedgMdtvY25y4328wYAz03pZGgm0ECRGx5xPLr/gmYqawrmkBZuGoFcHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXae/3fB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2255003f4c6so47432965ad.0;
        Mon, 14 Apr 2025 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744650429; x=1745255229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aC8nbQnSsY/ycvYA2e+g0txRbF4OxqLuWWrvhhoWrA=;
        b=kXae/3fBYgcCnwxb0w/E55XxS7+sVMEPSmkGylnotiLQMtc8o7aEvU9wjgugADIDqN
         IfOy/kFlmoUv6zqbFlh/oH5fBdXW/GgE4g5Dv+eigjT2swgNPic5Whip6wZ2nEpgG5GR
         uLBz22Tx5yNH+YjK9o0HKmpL2dn6mHTR/S/WzUhXqyenju59C8Kmj0xlSW9TBEsZ/Fc+
         7RTaMw6OZKgBx9aORYfvfcA3LoZVAE9uXz6hxrsOtAfRlzfwVFwb4QLFuiffmqe+Dqwo
         EdDt07xZTiRGMU+jenLmQVvWvgCxsZUWvZAEftYl+vToTwI0POkP/fms1coEUvmnMjL3
         yzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744650429; x=1745255229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aC8nbQnSsY/ycvYA2e+g0txRbF4OxqLuWWrvhhoWrA=;
        b=Nptodxz6QD4e3pV36YqQd62d+yH/LNbuOo2EfP8/U2DrVNFd4N5mpLs9uml9gbKX45
         PLybzNwJPsnFMChpcGXKqnGMb2iHH58WnolrxQesCcvonrvShQRKhIw9iItgSyrWgmUa
         UJhn1cB3S2qdMH4jf7XNF52loMB/y3yxaI5a/kFBimbfwC8CEDY1fuM+XxyRvp821sbR
         YkAe4TqoFocF6SKXzJEOCO+IRd3q4zWgv87DAMggiaQ/VXmFplkPpBz9La1v7GqJXDV5
         J8O75sYL54jfe06mvlvm2aco9C7oJxk/LRiO6WyHpjqc0VQn/X6vwJ9dSyrZ5UlMb5nd
         OCfg==
X-Forwarded-Encrypted: i=1; AJvYcCWZJusW5CbXjro3SPXsp88mLS5AH62NFct6zVHoAl8HzrXxBcW8yWFbILcqWMtsmuXt3hTvzk9p@vger.kernel.org, AJvYcCWfzyZvC7nw8AmPV0deXLcLpFGz/6xKpRJwmj9b5XRD4JybdG0XqmWYrFOMSz8sAJmETDLUxGO43FyA+js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fInCirWZdIo01YwjFsB0PnfQQXbofB8OsPHOfl/YTn88DJan
	I3ny7X+H+QXM1dStRXRTvsynRqkWO01WDpxu+HaKbB10J0qhWjzS
X-Gm-Gg: ASbGncveI/hmFz5NtaOZUo+qKf2aVnsyFg8LDsiJ7MuYO8seHTZ+ofgerFzXQuQgcsP
	dz0pyBf0kpf2URHVlm1cJ0JktcASj0au8NZTtVUH5hgWwqNf/eIdA+rR5Nk3ORJ2ttviPetaGyn
	MhejTNKh/MtOWPZ6UrQc8Th2EiPO1QvuivTp5UtVTkm8AQ2FOuG/WZg5ZPoXRjSyreg8R5N0cne
	PZnVgj4Yfuhlhi6HgjEjgYgs/soN3tElTFseG4N88Y/Y7D50dlLrAbQlEuJsY16yRDOIwefelm/
	f5nWOdYdVkfZjnQlQXjd0YOQihh8zB/ydvrbgL/s9NDQj2cOj/2f/Wm0
X-Google-Smtp-Source: AGHT+IHy3L0sRObM5h249A+XUtwuSyc4JgCYWx+PjAgceH3ncF9lhZgv07boVjBJOwpPAYsZzwXr6Q==
X-Received: by 2002:a17:902:ea01:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22bea4fd0a0mr186730335ad.49.1744650428600;
        Mon, 14 Apr 2025 10:07:08 -0700 (PDT)
Received: from localhost.localdomain ([49.37.219.136])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7b8c6b3sm101818335ad.77.2025.04.14.10.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 10:07:08 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: bharat@chelsio.com
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	horms@kernel.org,
	Markus.Elfring@web.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rahul.lakkireddy@chelsio.com,
	vishal@chelsio.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path
Date: Mon, 14 Apr 2025 22:36:46 +0530
Message-ID: <20250414170649.89156-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the for loop used to allocate the loc_array and bmap for each port, a
memory leak is possible when the allocation for loc_array succeeds,
but the allocation for bmap fails. This is because when the control flow
goes to the label free_eth_finfo, only the allocations starting from
(i-1)th iteration are freed.

Fix that by freeing the loc_array in the bmap allocation error path.

Fixes: d915c299f1da ("cxgb4: add skeleton for ethtool n-tuple filters")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2:
- Added the Reviewed-by tag from Simon Horman
- Also set the branch target as net instead of net-next as it is a fix

v1 link: https://patchwork.kernel.org/project/netdevbpf/patch/20250409054323.48557-1-abdun.nihaal@gmail.com/

 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 7f3f5afa864f..1546c3db08f0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -2270,6 +2270,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
 		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
 		if (!eth_filter->port[i].bmap) {
 			ret = -ENOMEM;
+			kvfree(eth_filter->port[i].loc_array);
 			goto free_eth_finfo;
 		}
 	}
-- 
2.47.2


