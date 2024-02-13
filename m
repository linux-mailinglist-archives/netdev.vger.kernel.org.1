Return-Path: <netdev+bounces-71151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30892852733
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906A7287205
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62F138C;
	Tue, 13 Feb 2024 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0HkJaEJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB44683
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789527; cv=none; b=Jp1kNflwIplVhhscrQ3TJfGfj6blUdZrZZRPxJ4Sziw4rmKHJBJTk5+vNXRaIMsrFyCrx0IJLKOnZZK2BHMXh2afqe+7PO9zxdQFVud/jk6pkwB2E6FspyxasNoicjVy05HEoS/WrFFbvzhZ1xYCbAcZxXKuvIkwl/k4hOUh/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789527; c=relaxed/simple;
	bh=lHSEcTgNBFqrw/oPJimRZXLMRiWb4zBsC7pQ4VfB1hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iy4KR3n1Ups3SiZNtth7/fAW7ojKA+rQpebM/wzhHYDMll18cxn3KvHdaRyaDvau9hUezhgSxDF5Sfh4aBRwhI6O1hi0nfHeC2fPE4deNcFNwUthB4EDWi3m+dCUOZ2D8vvgP5YLNNNxi2FT2iQpjHVBnHuyIg7gYaaH2xoKBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0HkJaEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7BAC433C7;
	Tue, 13 Feb 2024 01:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707789526;
	bh=lHSEcTgNBFqrw/oPJimRZXLMRiWb4zBsC7pQ4VfB1hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m0HkJaEJL3yolafUN+Q1SCJhsMu35yoGugukmDhbE88kv5tyCDWgAstmgeoRv3nyE
	 XU/vzM2zeWPGCaAWZ52pipwbG5rkgprsrDX9YTzsLw4F4PkQWpJbmfU7a6nHnWHQgi
	 qIOsGqJ300YXoWy/mkRd4jjkDmKCWGke8m0o/c+AP3leyG/VxsO045O8zoxDtK7xMf
	 VkDpGEADlOOmAGY4wp0ss4FTmzxN9T7ID/XTWVR5FIshx2BI/5kVkmaZVIbm9a+CP6
	 QEyzXtyC66qTNjIVhPPGHXZkmV27u4uxfRU1OdTvmQZT2gxLeZEBiR9qKMEVY47Bsy
	 dwsYcp81TjvtQ==
Date: Mon, 12 Feb 2024 17:58:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net-next 06/13] net-sysfs: use dev_addr_sem to remove
 races in address_show()
Message-ID: <20240212175845.10f6680a@kernel.org>
In-Reply-To: <20240209203428.307351-7-edumazet@google.com>
References: <20240209203428.307351-1-edumazet@google.com>
	<20240209203428.307351-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 20:34:21 +0000 Eric Dumazet wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 24fd24b0f2341f662b28ade45ed12a5e6d02852a..28569f195a449700b6403006f70257b8194b516a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4031,6 +4031,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>  			struct netlink_ext_ack *extack);
>  int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
>  			     struct netlink_ext_ack *extack);
> +extern struct rw_semaphore dev_addr_sem;

nit: this could potentially live in the net/core/dev.h header?

I could not spot any real problems but the series seems to not apply 
to net-next because of 4cd582ffa5a9a5d58e5bac9c5e55ca8eeabffddc
-- 
pw-bot: cr

