Return-Path: <netdev+bounces-67502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B919843B46
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0937E1F22277
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A926773D;
	Wed, 31 Jan 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Soh9i6BX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4469942
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693948; cv=none; b=jtOn+iCOfHa35AEWWrZMTvYl/+mCBCZVeNP1f7+cDmV4aKtpV5vcqmeob7rx56incqXzOORhaXir4NKR/QzLEW4/ymJnumVNapOqy3KkqB3jeFYSOU/xLPOHBBgssCqTgfP7VUxZBkupKqzqcn7mEXTDQ6YlQTF0sMVN8pBi8tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693948; c=relaxed/simple;
	bh=EdvinsgMmsFd9ywhc9GwyJvZ5Z5k3y3pzogjtHpDOjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McWPQBVOZWjKUVqzVwNzmyQvKNN4IKd3EEARMd15v/aOT2XFDys0ue3Pn5tRg2WmCC2I6/SepG3oVeD64ixIyGK8WxFPi9U3inKvmS3ZHa2jfOoA7DZxImu3onf/xfgDSI1auAtYNuszexyKOgMRZQBpg9RaPVjYGFv6Z4c8zkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Soh9i6BX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so50826445e9.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706693945; x=1707298745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZLVmXZ0B3Z3/XsbTVN9T8mNDiHI0n8yXspjnvc/22g=;
        b=Soh9i6BXfI3TWh4pS0d0Xd0BGLsbz8RhKNNGJA2NwSWS0MhkxNngr9b2QySLYvZPYd
         7XNA7EUSijgie7LaJo81dUTvOyE4h8kVSsz0K25NOkDyIC0X3LCRhbhAFBePf/fKJ1cl
         Al0Ucd8l/0Lfsk4H11QsrxSsbsEVEI9elzTSUc+8Pvh4mNdSvI8bLQzJgVWcCayij96M
         mC64Q0bTzZ4PHcEkY9x2A9kr+0prjQ+73LJAlWxMhdBOXZSXUXCAq7ds2ijLaZKCNMYL
         V281sUFDM9+EsLE7dIxrNRlnJo151SNeCz4rDnvp+VB53Fem+8tKnMNR6ydEGnnZWhxr
         x+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693945; x=1707298745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZLVmXZ0B3Z3/XsbTVN9T8mNDiHI0n8yXspjnvc/22g=;
        b=v0tvOiiwol0IzVBfTYaSb4crIeIZvmEYLF5Lcgnn4H6Yu+oUkbzkzGZ7BVFkFf1MYp
         HSxKXX6qFKXy7KlEJaTS4rhMMf1lko7eURdKevSr9qqZ6qgtw2HnyLGryuocgGXlmXnw
         gjx119A766udCaW/wF2Lkge4HHBG7NEh/Zf293mYunDXlrGXfeI9KPfGXQMstBBmRccy
         LYZsVjichRXXe//TFYhJ1O8ChKGJVDHi1NEbRf7QG36D+kK/uTt9OZxBypI5+MbRlb+S
         kH4BRIwyG2GWj6DqEXClx7W8muMc8emJA3CUJl1ZwtyFnYBD7rChKlDLUu3VctOV2mgt
         BArw==
X-Gm-Message-State: AOJu0YzJLW4v1sNhCIfoM59PlukfFdn6SbfNxgeqYXbtzyeJsVIlLpyG
	ZtQ6ue9DIingZVBLgGFvns+FFdOLWSjtQpuNrxk/O5j5bruOfGoXcxTle/MHmlA=
X-Google-Smtp-Source: AGHT+IHZiPIxhl5dhiXrkFKdSLGxPAeui/YC7KY07GMjP/JPbjh+tC78HTNaiTZUIwh9bkctN0kZYw==
X-Received: by 2002:a05:600c:35cc:b0:40e:e7c6:ddd3 with SMTP id r12-20020a05600c35cc00b0040ee7c6ddd3mr734846wmq.9.1706693944812;
        Wed, 31 Jan 2024 01:39:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbF+Bdp0xhU87Qu/+uxjPhzjR7hSQAJOHAk1/Acpax4QfxRaS5F43QdUsfJrcs1+xvCuO1vnaauGK7VnxDEKPAAX3oNPrQZPyAZ7j3kRWYo0vF+OQ4ygCTfl73GLXEk3klU5tK3SFVY5BxIk4r34sfFq2qs652mh0H0/3rwNpvn7kVSAEvb+VIsWkfDCmwExhVi07O9zrhtEd5mELt/zhLsalvSmlhI8vsq7ry
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ck14-20020a5d5e8e000000b0033afc81fc00sm3574206wrb.41.2024.01.31.01.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:39:04 -0800 (PST)
Date: Wed, 31 Jan 2024 10:39:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next 2/2] nfp: customize the dim profiles
Message-ID: <ZboVNWrlgucuxH9N@nanopsycho>
References: <20240131085426.45374-1-louis.peens@corigine.com>
 <20240131085426.45374-3-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131085426.45374-3-louis.peens@corigine.com>

Wed, Jan 31, 2024 at 09:54:26AM CET, louis.peens@corigine.com wrote:
>From: Fei Qin <fei.qin@corigine.com>
>
>The latency with default profiles is not very good when adaptive
>interrupt moderation is enabled. This patch customizes the dim
>profiles to optimize the latency.
>
>Latency comparison between default and customized profiles for 5
>different runs:
>                                     Latency (us)
>Default profiles     |   158.79 158.05 158.46 157.93 157.42
>Customized profiles  |   107.03 106.46 113.01 131.64 107.94
>
>Signed-off-by: Fei Qin <fei.qin@corigine.com>
>Signed-off-by: Louis Peens <louis.peens@corigine.com>
>---
> .../ethernet/netronome/nfp/nfp_net_common.c   | 27 ++++++++++++++++---
> 1 file changed, 23 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
>index 3b3210d823e8..cfbcec3045bf 100644
>--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
>+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
>@@ -1158,16 +1158,28 @@ void nfp_ctrl_close(struct nfp_net *nn)
> 	rtnl_unlock();
> }
> 
>+struct nfp_dim {
>+	u16 usec;
>+	u16 pkts;
>+};
>+
> static void nfp_net_rx_dim_work(struct work_struct *work)
> {
>+	static const struct nfp_dim rx_profile[] = {
>+		{.usec = 0, .pkts = 1},
>+		{.usec = 4, .pkts = 32},
>+		{.usec = 64, .pkts = 64},
>+		{.usec = 128, .pkts = 256},
>+		{.usec = 256, .pkts = 256},
>+	};
> 	struct nfp_net_r_vector *r_vec;
> 	unsigned int factor, value;
>-	struct dim_cq_moder moder;
>+	struct nfp_dim moder;
> 	struct nfp_net *nn;
> 	struct dim *dim;
> 
> 	dim = container_of(work, struct dim, work);
>-	moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
>+	moder = rx_profile[dim->profile_ix];

It looks incorrect to hardcode it like this. There is a reason this is
abstracted out in lib/dim/net_dim.c to avoid exactly this. Can't you
perhaps introduce your modified profile there and keep using
net_dim_get_[tr]x_moderation() helpers?



> 	r_vec = container_of(dim, struct nfp_net_r_vector, rx_dim);
> 	nn = r_vec->nfp_net;
> 
>@@ -1190,14 +1202,21 @@ static void nfp_net_rx_dim_work(struct work_struct *work)
> 
> static void nfp_net_tx_dim_work(struct work_struct *work)
> {
>+	static const struct nfp_dim tx_profile[] = {
>+		{.usec = 0, .pkts = 1},
>+		{.usec = 4, .pkts = 16},
>+		{.usec = 32, .pkts = 64},
>+		{.usec = 64, .pkts = 128},
>+		{.usec = 128, .pkts = 128},
>+	};
> 	struct nfp_net_r_vector *r_vec;
> 	unsigned int factor, value;
>-	struct dim_cq_moder moder;
>+	struct nfp_dim moder;
> 	struct nfp_net *nn;
> 	struct dim *dim;
> 
> 	dim = container_of(work, struct dim, work);
>-	moder = net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
>+	moder = tx_profile[dim->profile_ix];
> 	r_vec = container_of(dim, struct nfp_net_r_vector, tx_dim);
> 	nn = r_vec->nfp_net;
> 
>-- 
>2.34.1
>
>

