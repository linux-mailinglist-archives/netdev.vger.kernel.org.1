Return-Path: <netdev+bounces-148952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950B9E39D1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D786B23A59
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23321B4F21;
	Wed,  4 Dec 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljZNXT52"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A82188737
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314008; cv=none; b=O/t2WYThPvuPsor51m7mxvhw+/tBU2FgLbhFMA22tjFRLDrVAxlLy5Cz6cHZGSYn2dg7FDV7HvRVpEGEXdSHSGH4x2SKZJX8Ct1/FBXo0GpGl5TsieoAiOApqCWfmB7Mb7UY76zaUmGV9DI/5zC86cnUFdGOkw7Ka9dV42C16y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314008; c=relaxed/simple;
	bh=JDuHv6uKQbsHmnfZl4eZomwStWLbB2P9XNr61tQtoTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RRrTcNrw/UwWuASCTVH0qLCTjDUuhZWdEbWK0wIJ3WNRzONNCNRyguMVXeoBsjiP81/vZ9HJ7do6uOyRxvS0qfb6UhGp09sF2asrXuOKQf5UO4TRQIRPvl5WWLDoBWOOdoLxBq+Yx9F5UEyzXLySV0G1LKcPH++rXLgHR9xZLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ljZNXT52; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434aa472617so55157825e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733314006; x=1733918806; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywma13jqMEAR0GKd8Er2i+hQcM6w7VPqBl5YrMVzLNg=;
        b=ljZNXT527HsCuXDN04ftSTOa7EdLqkLaJgxqyahBN/Hy3l0O+uPycEaB5EmEKsdMxe
         kV7ey+bTmpyZV6esyDa3I5Br6Pmw77su4JefNShB474nT3N9vmjSh79QBlWEo4y7UNUl
         XOAH6Ioxsx6Dpk94+vGwVOHQXCYsFUXRhU+5JxbfuhF/sTw2CFWpQn1vQhP4NOuH6fwB
         4/MTZgWGcwrt3XDaFjKwYS9Q3voxeby96NcSmTjWllX8xAjFq6/INHXwPVsuRUWdqo2Q
         sWEvU1nRomKubzL6/hzh/o4DUxrFDJjzPB7kNhTI66RxbAYXJFLdp94NK8pCESdn/b8f
         XQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314006; x=1733918806;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywma13jqMEAR0GKd8Er2i+hQcM6w7VPqBl5YrMVzLNg=;
        b=o1S9fy+usm22DvGjDnBHR+b6rHYHSwV3wsiCHA0N0Y1tu6EgSCg7aCOMx7u9zPGsNB
         bn63eRrOsX1VOeYYJxpykIZk8+8bULbb1277jsoHCVNK17Dc6Sb02B1FnIsI7o4uTa0J
         pJ1G4io8XvD0tiybJTMz1t8JmU7+qO08f5TwZsdQq8Ve/kn4S3e5adf//n4QPs/bjcqW
         r1MAdTNqw2E7P1jtfa9IMivnM7CyPGoU0p8vQdM+dhMb1lJS92wCtrCnf6gaUAWSGN2G
         mCYXtmAK5LGXMC/JhtnHylrqa+kNAPKfI/3j7BY6/eZ6skLnwpYQeQ6kyBXCi5Btro9q
         fKAw==
X-Forwarded-Encrypted: i=1; AJvYcCUz97WOormG6WmG3JF+K1agvhflARUO3pSD6GOshhGmQfruhXPP7PFO9zby4YEvzejvRvjQWA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CpEi+TVcKAj/dJ43OR+RlhHiJ1RNnL8cVeNEplHpfZHDCoRW
	djr6f6ZiL5OiT7E2UPeMRfoPz2hmpAsMU8NMQwAuO2dwcaFMrKQO35Tgnqw9KeA=
X-Gm-Gg: ASbGncsnOU/jjYwF4E7NAOHAU/jizK1M3kSAWR3p7T//e4slcRovLGjcKxogKFKkq88
	m4k9tmv73eh9PFzcJ9n3jiiJ2hLDSgEgja0LisVid9cj1Uzt9pLOkwmJOK1vgLfrpASG71mo+NP
	i0waVpHXCJ44fcl84k0JxIzvRcdOhHYSuqAn9+wA/Y02j/kDiBaGG9du4XUyETDzni7PPoNYQ86
	JdDyOD1tCBU2AWc1qIRu1ci5fC4amC62sCsoZSKakqKXPKw0AwkkpE=
X-Google-Smtp-Source: AGHT+IGJUj6d/zYcZD5M/Et3lJs2ShDAAV/RYF8yEIzq3ilyWBo8QUqo+ERoO6DKk5D16w9J5pmwRQ==
X-Received: by 2002:a5d:5f83:0:b0:385:df4e:3691 with SMTP id ffacd0b85a97d-385fd418da7mr4972574f8f.42.1733314005639;
        Wed, 04 Dec 2024 04:06:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fd599b31sm4473289f8f.21.2024.12.04.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:06:45 -0800 (PST)
Date: Wed, 4 Dec 2024 15:06:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3 net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <07477254-e179-43e2-b1b3-3b9db4674195@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dr_domain_add_vport_cap() function generally returns NULL on error
but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
and if it's and -ENOMEM then the error pointer is propogated back and
eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().

Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: fix typo in commit message
v3: better style

 .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 3d74109f8230..49f22cad92bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -297,7 +297,9 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
 	if (ret) {
 		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
 		kvfree(vport_caps);
-		return ERR_PTR(ret);
+		if (ret == -EBUSY)
+			return ERR_PTR(-EBUSY);
+		return NULL;
 	}
 
 	return vport_caps;
-- 
2.45.2


