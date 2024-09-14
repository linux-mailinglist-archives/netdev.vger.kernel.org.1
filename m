Return-Path: <netdev+bounces-128329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD36978FC1
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349AF2896AE
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336731CEACA;
	Sat, 14 Sep 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTnNCeHW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38B1CEAB0
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307914; cv=none; b=MemK83KdNVmFOyUC2DJUorEsUPDoes1W1xIP11o0cJ0UrlNKH2p9sHSWcXrNeaPZM6JdMwfznSSJvh2TH55L4PQe8W22uCaTXIU0ZqwJosFiyLaRmcPxNuKwaBcv3SCzBwevbJoNwtbq2CDG85xUk9i2Xvf/24eAMvDYhDXGHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307914; c=relaxed/simple;
	bh=ya7/LjfmKpMsoE5aQBDX5qZQrPs7t0zo+9KUYJNQStI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KS7jn4ko/NLH8XNl9dEQ+BX7HtfWyvXiFYhI8hID5+DK0nmvL8wtLzQf4tMmUOew+FgnyQyzZmGWBncZPGu2zxxouufc3ZI1B9OLMREPlNF1I0PBADraGKdjkGYkCYSWXhimKf5fcYfUlUsiBeUpPC9ZEWrhL2uGX4nEgMpkb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTnNCeHW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c4226a5af8so1723651a12.1
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726307911; x=1726912711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdccIKzjZeBA+TQzTuhi7PDMeQ4nYvxBAZIlCMJ8mnI=;
        b=vTnNCeHWFAfU0LmCfnv/tvrG5P/re32LBV94Lvc/WUEXelnBWOh67l0Dkg5dvDfrZo
         tOidpEmCDf+cpmvTOdGZ5wDNnGDMW/145L2XVRcXviN39ADSZRX7ReRcpD9sn7N1gHx6
         m+MMSqcdfbUl2/vGuFzczv1z6Je3uPMizntJMkc0+JOIh20o8OMJvRsVUfJEB7o9PXKm
         Id0J6YSO6S2zWmuOtahkN3+FtZYM19sxRKxivNyWnqqLzMmXciXQ+CSV2PjXoxjRwIsk
         0sqwTyS1/acHhyUEG9/vKQjKWJPlAUeX40cQu99/v/QIvbzpTIE1ZaSF2mj61SeF0akx
         /UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726307911; x=1726912711;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdccIKzjZeBA+TQzTuhi7PDMeQ4nYvxBAZIlCMJ8mnI=;
        b=hDvyzasqY4JKqq/I4XbivicznYV2mRV7wnI18VgcfgcoDT5pQuHbIr7YOeqlz2imG/
         056KQywHtC8NLqpFfy94qzvlYBP3MfRy9lXXPPQibNpMrcmkLICzig3DgBhikpWpFqEr
         Ud70X5CYELwyP4x3JushR0ymN8TXFTMw96pkS5iy4B8huEfgVgcqLGyShi+6fnD+HAEM
         gw6TqUkUEXIWFL4UTBzqZbiyEsKTEm4Alvjwc/NaKve3yBt3pX8V+XWyhJAXEmS8BF3H
         ewJgKJhT28iPk3k0+16OLFKNbYx8gkMjUmCNeQSVizZ4iesf54stwNcL+CeGooxlU7lr
         rJkg==
X-Forwarded-Encrypted: i=1; AJvYcCU4pTLgHr4maJar1lPBoU1CRy8J/v4dl7ELa2Z0OSF7voIRdhieLDRm8JiBv5JnwdHOwbZxPcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVcrLC0mZxnGYgnx2aCEXrmTpZ1ESSzwnQqJo2O7cMFKhcUnBG
	PZXW2JoI7JKhGjPMCsW7NRLW0w7I8ZlMa00VYcQgCRr8hjNnhPZBrB6xXc0K+0w=
X-Google-Smtp-Source: AGHT+IFJrSTGbj6IkzPSkz0zqYy3lgixlfvOUhv6EL9dyvHz+N7B9GcrOxAec6RJljG6MrVvxkq3eg==
X-Received: by 2002:a05:6402:26cc:b0:5c4:2d7d:9759 with SMTP id 4fb4d7f45d1cf-5c42d7d9a77mr783746a12.10.1726307910740;
        Sat, 14 Sep 2024 02:58:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89d44sm499739a12.70.2024.09.14.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 02:58:30 -0700 (PDT)
Date: Sat, 14 Sep 2024 12:58:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Itamar Gozlan <igozlan@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: HWS, check the correct variable in
 hws_send_ring_alloc_sq()
Message-ID: <da822315-02b7-4f5b-9c86-0d5176c5069d@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a copy and paste bug so this code checks "sq->dep_wqe" where
"sq->wr_priv" was intended.  It could result in a NULL pointer
dereference.

Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
index fb97a15c041a..a1adbb48735c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
@@ -584,7 +584,7 @@ static int hws_send_ring_alloc_sq(struct mlx5_core_dev *mdev,
 	}
 
 	sq->wr_priv = kzalloc(sizeof(*sq->wr_priv) * buf_sz, GFP_KERNEL);
-	if (!sq->dep_wqe) {
+	if (!sq->wr_priv) {
 		err = -ENOMEM;
 		goto free_dep_wqe;
 	}
-- 
2.45.2


