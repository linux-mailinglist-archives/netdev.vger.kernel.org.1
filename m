Return-Path: <netdev+bounces-81192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC7886804
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D7228769C
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45915AD0;
	Fri, 22 Mar 2024 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PFgdmLpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D210A19
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095239; cv=none; b=axX6kAHMiJWV9USLmSY+W4FT2G4Zheya2XMlVgzWRLfQZs5YHETDrxVmfQ/J9fzz/vyqLHM6FX4t+catG4LTFv346G4dn8CkbEwMEa+ubzBQCCE3x3p64GZcn/QTdR0FEqrUix3uJybG1mNMqzgbU5pkW/g85aWDY/mMCr8klsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095239; c=relaxed/simple;
	bh=WfjmEuuKCN3xsHqH7dLGCnA6wCbMjmd4BRcdgA7BHc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTCE9qIYAM+dwt02T45ogQSPUq4vmc7+E2+yaMtp89H86/555G63oafibAtufCSiAjXDJyCcuPOKSFEiQ2r7rjaKw1ATJQGDN6VkdIpSjlKuKDyTAvMN8cjzf0/m4h04t6HOxJHzNZKneGMBnrlNnvdq+PxeFhaDxdk1BG4OkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PFgdmLpd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4146f2b3fafso13376215e9.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711095236; x=1711700036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyqAEuiGYY1fZnxN3qvRC88gt7+sHxYQlEaYtT4i3Js=;
        b=PFgdmLpdjKNc1GW95EyWlOtdvKmNGSxTZKgCkmkyidIBdiXrRmPnX3qzD8pceFRhCy
         lY1YHXPXDQEFZ0kvQKW27BMeOgAIiCXlNI/o8ikrU6IpyTGNyYLetZVxZ6UdDfbW59o7
         gcdZgx4eCDWFJpSYFu7XHFuBL50cjXiEyyrnRiPZercBSYeL3Yu3ARCp/o8/s9jtyy+l
         QYSIyH4A90/jZwI2i4JicV9JYaRGRNUVwk90S+OvdxmCE1G4NcC+k/LYN1evnZ8x6eIG
         XseaWpF2t94IM8Qnvet1UIqvYYVDj3SiM+LZ3A33NA8xEg8le8245bo7+WnRCJzPrB6K
         QZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095236; x=1711700036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyqAEuiGYY1fZnxN3qvRC88gt7+sHxYQlEaYtT4i3Js=;
        b=d+jTu7LEmBkV4s1QBAJ+OwolwrPNleGFbDoiEfY9fWyRvEvrkyCB4mirTiqM1mSJ5f
         yBq2xrF7CIkg9Ip4MYdWFdzx3FBQabjv4fVGYX/3tlp//i5215OZBBax8nVmGns+vzuD
         W4qYaMqhOBwfIAmX+QT5KjXGWT99Axm+bU/Ig3VHId74+W9IuYWmlTwDKPylbVCPSmqs
         hR6noJQy9nZSvTCe0xPuU6qhny8lpFGebK33FH/YrlxisbrzhupzqhTWHBjI8AiqhPMK
         DlV1ceW3xeTD2uwkh5dPL/36eDw45KdhNH3D4rVmQZ1T5zg2YzmFXf5AVqMdpb6ZJcxF
         xjBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSfm7AbEeK1jpdaSqMPim1+pW7AA/7xDTMZo5B8l4ZZf6V1NAi3kdV1JYtJ0Uograhqy2znS70/LNCxg8NXwwJCcaZ546H
X-Gm-Message-State: AOJu0Yylp48ctBFSuNelA2K3txpxUkX9ZvKwtzMYhNnImRR6AgSBM/1V
	dhDOy88m4EDYHx5DVJLm/j/mn9jXtjocmKDMkhCQtcIzmcfx4lnMrTS/Ze58JgA=
X-Google-Smtp-Source: AGHT+IFCo8RGcn/AtPX28oGcoH6zEjuFTQbeGnBIiBNB2w0Mnp2lXH+BhehggEZzTuZOoRjtsaaXtQ==
X-Received: by 2002:a05:600c:3b92:b0:414:63c2:8041 with SMTP id n18-20020a05600c3b9200b0041463c28041mr1084209wms.32.1711095236275;
        Fri, 22 Mar 2024 01:13:56 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b00414612a43a9sm8068942wmq.28.2024.03.22.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:13:55 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:13:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: mkubecek@suse.cz, idosch@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yanan@huawei.com, liaichun@huawei.com
Subject: Re: [PATCH] netlink: fix typo
Message-ID: <Zf09wW36JcpObTPC@nanopsycho>
References: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322072456.1251387-1-gaoxingwang1@huawei.com>

Fri, Mar 22, 2024 at 08:24:56AM CET, gaoxingwang1@huawei.com wrote:
>Add missing colon in coalesce_reply_cb
>
>Fixes: ec573f209d (netlink: settings: add netlink support for coalesce tx aggr params)
>Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>
>
>Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>
>---
> netlink/coalesce.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/netlink/coalesce.c b/netlink/coalesce.c
>index bc34d3d..bb93f9b 100644
>--- a/netlink/coalesce.c
>+++ b/netlink/coalesce.c

Please make clear indication which project/tree you target with your
patch by putting appropriate name in the [patch NAME] brackets



>@@ -93,7 +93,7 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, void *data)
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES]);
> 	show_u32("tx-aggr-max-frames", "tx-aggr-max-frames:\t",
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES]);
>-	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs\t",
>+	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs:\t",
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS]);
> 	show_cr();
> 
>-- 
>2.27.0
>
>

