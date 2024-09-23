Return-Path: <netdev+bounces-129292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1689797EB7B
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6E1281B15
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4C198836;
	Mon, 23 Sep 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSdABqor"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B31974FA;
	Mon, 23 Sep 2024 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094365; cv=none; b=MBsU+NB0N3FWTKTfQHE9ru73k0gNrn2bvQEaD3HZgONmd+RI8wANi1Tqg465/M1llC6yMUk30ewTKp2aSwUHekfVk5zQBgk9S1vdV3SdGVl8INzlZ/IPHSqu5K95Q763HhJ1LtkoUtcR6NuxmVmwQO0LBRJW53+I6Fpm+yezmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094365; c=relaxed/simple;
	bh=thO8VxYyImI2w80Ebuc+yVZ/26dy78mwPgP8fx3duWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j46ugJllgt7mwztOkfpj5RQXz2CBGiajCXExGR/vCYsK7UxL4AeSsFgiWo4colNTHgOSrE2GfSE6eCSzkkKDgbH00leAt6lhKKKzSKmUzzdWUwUwSHYVH6Jo1JG33VYLiEOOPfkWnPSxumBfZDkDr4BwCISSlGFOrNS1LNexNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSdABqor; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so562319766b.0;
        Mon, 23 Sep 2024 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727094362; x=1727699162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwuvqk2hbesNOUF+iNF8ZM1z2+Ejv+9It9RNoru66Uo=;
        b=cSdABqorAEuS6XjZRNvNfbLUJUksUs8iVwQPRvdsJhu14q0g/hW3qyYsd+24CtPglC
         1O3YTLQDgGSvdiaa/vuIEp78EhgcvKgGEOzpmrawMeFJGQLv/koSFmHSiyaUwtx+HYV0
         t3ONWLhE9HoDZCZ+BNkj6Kp+lOxWDSSyXFSFTrm0ddPmKxUBi3Irrel7ic8uOhw+oNUa
         5qZiLwndMckOtN/WyMBxkQYo9XW+zghA8p+KRnc+8NtD20ig9SDfGlwMiASVcAH+TNmK
         d9ZD7nN+cyZxQmNnGS9b4dRgSTaIjc5qi+JWVkfNuF0Xdr64t3p0hIaBMvrzocvjaw3l
         SZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727094362; x=1727699162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jwuvqk2hbesNOUF+iNF8ZM1z2+Ejv+9It9RNoru66Uo=;
        b=XEBnxDDZaMo//AHmh9d5jvhn3stTvqvOMscSiWF9C0cvcgi0YepKkuXxx9SMjp91wz
         WhTsifeN1b67MLxgKcuQAldJYe6SetaGhfshAye4Kd75jdIAD3ws0IVZx/PHFXG3tdOA
         X92GzUVGBpnFIgfTMvW26XDN9EXEzjo/db2tPzES0KPsByR72xJJeHiCEhSO5BZBmMl3
         /9wrZLpUF0A4ooBzdIZF422keS+xXQ2RRkD1FEa2nZHVSmafJ59X5fvOdpvvlmcDDaV1
         394l6xeE+FfI4jHxyfB61AEJHddct+XvaKZUzo+8Vgk3Q2AY4UhQHRz2zJgcfDrtggev
         Gt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPUfRNg7zD3El8IUxuysUnJ59g8qLQaocJA8D4H3sXnPKPu/bAxVkc2BFJ3NZk6yLvs1aeSJVv@vger.kernel.org, AJvYcCVoiXlxVCBPYgNghwz/UBNLrQe8vvMjWOAfjIWBDQPhR5LZC+/CRwB9bHzZd/pep/O8L8KnYvqfMPc3/Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoB6LHEl+x0RNAoFN7o3j8e2/yYhPaMKu0OZhIKnLEXUSSgFsq
	dkjGFqeq0bwUB4u3BGKGVrbr4NyDuQSnuxz2awoTRBnaGnQqcx9sEbxbyT4S
X-Google-Smtp-Source: AGHT+IHzOxGWgS4dSxMN2FQb39/d+5oUhTTL14UvFAX0MomqmfsHtiyL6nrH5PKtJ0BG80q5d6Wugg==
X-Received: by 2002:a17:907:d2d3:b0:a8d:4f8e:f669 with SMTP id a640c23a62f3a-a90d4fdf439mr1117254266b.2.1727094361886;
        Mon, 23 Sep 2024 05:26:01 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3833sm1217175866b.128.2024.09.23.05.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:26:01 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] cxgb4: clip_tbl: Fix spelling mistake "wont" -> "won't"
Date: Mon, 23 Sep 2024 13:26:00 +0100
Message-Id: <20240923122600.838346-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in dev_err and dev_info messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
index 163efab27e9b..5060d3998889 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
@@ -120,7 +120,7 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 				write_unlock_bh(&ctbl->lock);
 				dev_err(adap->pdev_dev,
 					"CLIP FW cmd failed with error %d, "
-					"Connections using %pI6c wont be "
+					"Connections using %pI6c won't be "
 					"offloaded",
 					ret, ce->addr6.sin6_addr.s6_addr);
 				return ret;
@@ -133,7 +133,7 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 	} else {
 		write_unlock_bh(&ctbl->lock);
 		dev_info(adap->pdev_dev, "CLIP table overflow, "
-			 "Connections using %pI6c wont be offloaded",
+			 "Connections using %pI6c won't be offloaded",
 			 (void *)lip);
 		return -ENOMEM;
 	}
-- 
2.39.2


