Return-Path: <netdev+bounces-177997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6FA73E4D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CF53BAD6C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05501E505;
	Thu, 27 Mar 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRVDrf/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1EB2914
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102146; cv=none; b=Zt8pYLjLxj8sb67Fx7HZeCWG0w62eY4xza40TE2798YL3P8Iy8K/0qU69mMUMRCcVSsVPTcVn+zgJGCNRAuwCzYnC/Ph4NhRaz6n+/3BOtUaOb9geVmwbCdiUUihchUxjAwQJRu0VB7gRNXzaMEMW3bLU5sH1d/zEdcM5VG1Mtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102146; c=relaxed/simple;
	bh=DmweSSCt+1Re1u4nFTFQpw0xrr5obCsMJQuaRD+mYcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldfaiS1ZZpGyok3iurSrLd7EbBus9wmt+K9Qnr2+dsduzJNlezcY6er+ktV28joXlw7DGLnsbaYfk81viP5Re3ZzAFOxmhQNtfTYPEDnaknaFMDn3PKS32og5Xw6I8o5iMYz5dhhrTw2YbSauiNrUCOVVMzDpu00D3y2LTNJKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRVDrf/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2AFC4CEDD;
	Thu, 27 Mar 2025 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102146;
	bh=DmweSSCt+1Re1u4nFTFQpw0xrr5obCsMJQuaRD+mYcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bRVDrf/G/GtV0SEDpi7HlSNYyoKNLlO+C55p64hXbOg5GXaPgOYSlnOi99nx0ciIJ
	 3GXWAvqIHwJ8jRLLvqiXhP0fnC1hwgbTIeKCnl2s/sE1yFT4F8MOSegHgv3DCLdUFt
	 0rgc1zJPGXiQ20U1t7/HQrasifJ7uiY3U3xwktno5jwOVxQt+MpvB6G2zBnZwYW6EZ
	 TgKez8jLF7TZ3hB4IShgXOCYMKeW9j3B8jwN4q6BEw/0pC45xvD8TiDlaS/LejjLnh
	 YUAalaNcABrchTeJ6hXg3s1i5GbhivGwu0E7/4BE8nGXKZmDU1KZpOqsfUTfSDt4X7
	 mYyWFf1lXlmBw==
Date: Thu, 27 Mar 2025 12:02:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 03/11] net: use netif_disable_lro in ipv6_add_dev
Message-ID: <20250327120225.7efd7c42@kernel.org>
In-Reply-To: <20250327135659.2057487-4-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 06:56:51 -0700 Stanislav Fomichev wrote:
> @@ -3151,11 +3153,12 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
>  	cfg.plen = ireq.ifr6_prefixlen;
>  
>  	rtnl_net_lock(net);
> -	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
> +	dev = netdev_get_by_index_lock(net, ireq.ifr6_ifindex);

I think you want ops locking here, no?
netdev_get_by_index_lock() will also lock devs which didn't opt in.

