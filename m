Return-Path: <netdev+bounces-225317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D7B921F1
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCED63AA6EE
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909631064A;
	Mon, 22 Sep 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh8V+6NY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A4215198
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557080; cv=none; b=VVM1uXRmD8KNgdiJBQoqDJ+jkTsBug8FR7mSev2sNU7ar+BV3bhXi3Uj3WlTbYuSAOXv5+liYGlhM3dagG2oP1BLGJxtWttuqWa1LGgudvMD/cdnCix+FiRkaxLG5LoKeYtkmg8vxNkzhqtdP4qrBf1vT8AnTg1bymY5CE1f4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557080; c=relaxed/simple;
	bh=Ljl7ScAxZk2dO+3HqKN3rFODorYsVJJH+Gqu5QhG1gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqHS5YjVKpfFkU4z8Qd+sxwFrd6TT7UEEi5e5hJit6pzqmtdc9iXgPpl+KSCtb0yH/9NXcUBVX0grQBuuTyJ33Fz1O4TsD19TLOiI8QqX/FsZ+f4UZVxDagfytEhCgEn8BztZdeGY0fN35V6aylNXVvPW1m9JIZ18Nk1+75mIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh8V+6NY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77716518125so2343590b3a.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557078; x=1759161878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bn105Zf1c9vstVchIVF2tlN/PNR2fCVJTATnppqTOaU=;
        b=eh8V+6NYcKqnWrRtpVUW+up9FeqORw8WTE6EufHqAQiDYI0TaS5Jtt/Tg+A4k8xnDX
         8ExBdrBCwgdiRwOd812H+I/MG8+t1fqpSVfxQyBH2MmR/+scbBi+uxhpN+L+lBFW2J6U
         5+Bvbb4PsfEgI6d0Nev1t25PW8WY1bsso3Bf1r0RG/QUx/ZfHxNi6nj1zMRU6YM3xRYc
         D59qw83RlfIwdhxf3bhUp4jjZQFHCEtg5J7P0x8y+yVEKqitkkftLzBjFMZu6A0n6mAU
         DThK63dXvm7cJ4EWL7yJbC/pVrUmVEHTRzINQrmQ043NCLP1++YNScIpqqdH3WeenWHs
         3HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557078; x=1759161878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn105Zf1c9vstVchIVF2tlN/PNR2fCVJTATnppqTOaU=;
        b=s/rEiyzqD/gHTMxVeqYCj5vTSS+oNDXm2Rz6IctZ4Qh1SlWC6iFTi3ch2+1QUdtZ2w
         zK87yljE2zSjry+xPSi72Q0lyPHM5TgRrd52K4jO+zaaUDItRKy8f/urYsfoNHTqbWOV
         9qDQ2PC9suGCTIP5Cme/G7mOYb52BsInazEQagfRXGHGVDBXQOxD5AJJEJS/11LU5pRZ
         BhSAdI2MnTw2I1dFPSnW65nRZTi9QkMBBAvTte6RU3T2cFB2Kc2Oz4sMTD1LwVWzbXwI
         DaY2aH5qOUuLpXhx/OGtVYTFsUFK0IZANXI57qFvOdW4NULmqZuQNKYMHjWegi8KGB05
         Dk0g==
X-Gm-Message-State: AOJu0YwZjP3PeE5fomz2mjFaMVc2I1bazhnbBP0+deAayNMTxjtDeJeT
	TG4pk3Zuw/T+3jP9xtys4VNddVRXHq+Dyu/CNneqO1dYtBGD95z/kHM=
X-Gm-Gg: ASbGnctIlYTRNstP9YMC2lHzEWoAbJkMSIurpaZ83RrpPvqtN+8ZD/8735SIgIDnnHC
	U5SLgAZnDvdwBLlSKErJEdJSKecEtNagqQAyW0/me4GtStTZLchCY67LE7925Sj9uJdkjb2FD75
	zUnQCVV45mVZB7HbxwSCiDu67fA8ETz4oLo223lRbJs3YG+e5NCdoX7Ki58AVQXfAcExKB67U7g
	KUvrddqDMxK72dUpo7nM6+TbXjxioRyvoX/NpVNR4Y0WPwfrYytUMvXiQB3ENEGGCG71HBLRJAw
	S+seG6SIoh5if5fEokCWTBW8J+MeSijG6Z5Db4Rp6rDmKLMc3uESIXEaKGLYie8PDt+vaFefqYc
	MotSxtCHGZvvOCaefFzn/bgUK3jbuVDnmrsj2i13eZNXdoObdT7FHO0xihpjEhQU93pMbiM0dBR
	+5uXdF+ADlU3icPHi6oQ8AULGQkolkpgSV8AbNlQnSBIbmVSLUmSMz96onLSPg3ubn2GkzGNI1p
	cwk
X-Google-Smtp-Source: AGHT+IFgNGiQkq6SDsfPdO8uo78KCpKKl1zg7NUJDeqgoOltS1XlWewrJE98ZUxgli6mEi4XPuM/6w==
X-Received: by 2002:a05:6a21:3391:b0:252:2bfe:b65a with SMTP id adf61e73a8af0-2925b41e6c9mr18528562637.7.1758557077400;
        Mon, 22 Sep 2025 09:04:37 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77cfbb7ab8bsm13345159b3a.11.2025.09.22.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:04:37 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:04:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 03/20] net: Add ndo_queue_create callback
Message-ID: <aNFzlHafjUFOvkG3@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-4-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add ndo_queue_create() to netdev_queue_mgmt_ops that will create a new
> rxq specifically for mapping to a real rxq. The intent is for only
> virtual netdevs i.e. netkit and veth to implement this ndo. This will
> be called from ynl netdev fam bind-queue op to atomically create a
> mapped rxq and bind it to a real rxq.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/netdev_queues.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index cd00e0406cf4..6b0d2416728d 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -149,6 +149,7 @@ struct netdev_queue_mgmt_ops {
>  						  int idx);
>  	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
>  							 int idx);
> +	int			(*ndo_queue_create)(struct net_device *dev);

kdoc is missing

