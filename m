Return-Path: <netdev+bounces-177995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B4A73E3C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC923BAE52
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8221B1B9;
	Thu, 27 Mar 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CARpzHEW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AF21B19D
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743101884; cv=none; b=TVfhJq/4BIiBLEyUIqVj5u2K1srLd243HCGq5i3pAnH4DCRqJ6vUbyN+K/K6Hxsx+6/KX/CJ7I9A/aVL+SN922iZiZsTuJ9O2qOWCeQfIuBI9bDUEfYDk8s/Muxgz00u7gK6kVSdpoYwqb4tIvXBUtg6VnsFYlfTx5ZBXYuTFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743101884; c=relaxed/simple;
	bh=PMiR/ZIszEjBJWeFI+c2eHmOiJH7CA6U07mXXLoYIgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwxd+/+h4C5yzrl6WR0fEyakylBnVD6lCjuPbTRRfscpxIg1xY+Sdu+9EcdiXzXRxRGH5cBaTfGpIonCs7kQlwHydaOe9HbcahFLMcVSTbn/SR/CGE15J64PCK2pFRFLIYHdEmr/e/8HowkUQYapjcTazzpc+rlUDs4iq1ml4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CARpzHEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903E5C4CEE5;
	Thu, 27 Mar 2025 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743101883;
	bh=PMiR/ZIszEjBJWeFI+c2eHmOiJH7CA6U07mXXLoYIgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CARpzHEWjYe/PEYJMWZckni7PWPD2UKI/1mLfCMZV8gu/NIeo8oGekOxfS6r3BUWQ
	 /k/eNIdkyUkB5t/EfnfGuFojL6+S8/n4c+c1KBl6NJnRJSco0gUI1ciVXn2DZo/H23
	 Da4ajoEG0M4/994QL5RKMNDp/BV0Nvv+GCt0hspbGupuvoY/q6ObFUz5RowtJ84GuJ
	 EA8X1MAnA3zKA3BPg6YVPjxQTud65ikNzJLLlcQ4/kBoR9+k2a+CQrjlckdJ3xHSpG
	 La/sl4UOKTgAFxVMnqX9YRBjuEFIMEEM0smoMXtIZBtyj5fjaI7nxJ1MFeXYSZwupc
	 QIBF1UnQ/EcIw==
Date: Thu, 27 Mar 2025 11:58:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 02/11] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Message-ID: <20250327115802.4e2d5d88@kernel.org>
In-Reply-To: <20250327135659.2057487-3-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 06:56:50 -0700 Stanislav Fomichev wrote:
>  static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
> -						struct net_device *dev)
> +						struct net_device *dev,
> +						struct net_device *locked)
>  {
>  	if (dev->flags & IFF_UP) {
>  		call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
>  					dev);
>  		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
>  	}
> +	if (dev != locked)
> +		netdev_lock_ops(dev);
>  	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
> +	if (dev != locked)
> +		netdev_unlock_ops(dev);
>  }
>  
>  static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
> -						 struct net *net)
> +						 struct net *net,
> +						 struct net_device *locked)
>  {
>  	struct net_device *dev;
>  	int err;
>  
>  	for_each_netdev(net, dev) {
> +		if (locked != dev)
> +			netdev_lock_ops(dev);
>  		err = call_netdevice_register_notifiers(nb, dev);
> +		if (locked != dev)
> +			netdev_unlock_ops(dev);
>  		if (err)
>  			goto rollback;
>  	}

Any strong reason we wouldn't split the netns change into two chunks, 
and release the ops lock while we move the notifiers?
I'm thinking rename netif_change_net_namespace() back to
dev_change_net_namespace(), move it up in setlink, and let it take 
the lock.

