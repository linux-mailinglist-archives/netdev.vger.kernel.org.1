Return-Path: <netdev+bounces-173111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B87A5764B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A872188B4AB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAEC211A36;
	Fri,  7 Mar 2025 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaponxcO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F81925AC;
	Fri,  7 Mar 2025 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390764; cv=none; b=R4ki4ZevuKUS4E3Vp/cZXW4DqfYLbxHjf8XyughpANKh3HfwiFs/BbSTDVKee5XIzrBr7In+HLPxhGtx6hPrLVjrFoOpwU7WKZMZlN971vR3U3VG+R7ASbyKFGTJoBkepKY4Ndson0+KZYZREIjHxlADCUz05fBdrzyup9hdfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390764; c=relaxed/simple;
	bh=SV4Yv8MgpgnqWWpntSd6DC3/0ggPzEEXI2koiecMUBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4NiCVaL+1eXbsUfSm8cdCdVMjrmLBnpKMVtjkbR/OX9X5w5ZWF4w4quAUR52461iakJXwhV6gT8tcCU/YCznqN6BgUXnQSqPVA9yuRXVJe/89urbiXfXchmpoiBAcV0XxNqGV6wqLDFevDG2ab4xAsCHTvAU28f4nUnwUCIzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaponxcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25218C4CED1;
	Fri,  7 Mar 2025 23:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390763;
	bh=SV4Yv8MgpgnqWWpntSd6DC3/0ggPzEEXI2koiecMUBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FaponxcOG2H7IyzQ4u8CvOl03z/JLRCtCPS4bVJudRJKFSlQlt46sz3sDkNTuNGyY
	 ORrW0SK8bUrzQUz4Sc6m8r1H5bO6SLdMvied32PtNvdwY9LDrhu9LziGIOEsY5wlh4
	 VHF+aVbO17w2MpYAOAX2pDqgckK4AByp2uCHJEQLMSCG4CdfjfghnUvbJ4ECBk1Ee9
	 Sn6zFcsFvkSpgeuc9cev2B6i5nOb8sqYQCE5Tx6pVMyLu5XqR2xi8D6bx1EfK7JIcH
	 SwrOTp8b6AhOn1FJ8x27dOwSLNvxujYAjS4cifIq0SA044cyrI3Qe/CWE7qIZtXvBw
	 5duJJ76hlerRA==
Date: Fri, 7 Mar 2025 15:39:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com,
 xuanzhuo@linux.alibaba.com, almasrymina@google.com, asml.silence@gmail.com,
 dw@davidwei.uk
Subject: Re: [PATCH net-next v1 4/4] net: drop rtnl_lock for queue_mgmt
 operations
Message-ID: <20250307153922.18e52263@kernel.org>
In-Reply-To: <20250307155725.219009-5-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
	<20250307155725.219009-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 07:57:25 -0800 Stanislav Fomichev wrote:
> All drivers that use queue API are already converted to use
> netdev instance lock. Move netdev instance lock management to
> the netlink layer and drop rtnl_lock.

> @@ -860,12 +854,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  	}
>  
>  	mutex_lock(&priv->lock);
> -	rtnl_lock();
>  
> -	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> +	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
>  	if (!netdev || !netif_device_present(netdev)) {
>  		err = -ENODEV;
> -		goto err_unlock;
> +		goto err_unlock_sock;
>  	}
>  
>  	if (dev_xdp_prog_count(netdev)) {
> @@ -918,14 +911,15 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (err)
>  		goto err_unbind;
>  
> -	rtnl_unlock();
> +	netdev_unlock(netdev);

Ah, here's the unlock :)

Looks good for the devmem binding, I think, the other functions will
need a bit more careful handling. So perhaps drop the queue get changes?
I'm cooking some patches for the queue get and queue stats.
AFAIU we need helpers which will go over netdevs and either take rtnl
lock or instance lock, depending on whether the driver is "ops locked"

