Return-Path: <netdev+bounces-178927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28ACA7992C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 02:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10337A4C97
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDFF4A0C;
	Thu,  3 Apr 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdVa8tJ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A3D531
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638543; cv=none; b=GqX4fhF6mdBKV6+kkgEBAElx4Jj7WmvYLNBTGpWi4Xt0Kic9+RzCXev0uh7ZU8S4wOV8au6ESuAy4NnqUaRAY021WEQZTliZ2/20zIuzBij1mMAxbY6EWjAYnGL9n6ot/KocWaXWCle37u4XTVX9KBOZnFy2ugLbT5C2Qildg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638543; c=relaxed/simple;
	bh=XU0SPOy+ESVftylTjF44Lu0FsBBPS2ssGHhhyWDqICo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oofWDwj/Z7ZVcsxquP0e6es0w/fNHK5L/pIM3Pq0cKBZPVQAUOdMEHsCf5pak5pI4/0ZiZZXvWuse92TykN4p9msupNSK20MnSDkv7OqtFFsktyBmTj9PPEZCHY0Fop5bOUSM5RQaKIAuNq6xZWuB81KNQjX5gY55Zph1c3N14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdVa8tJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924CAC4CEDD;
	Thu,  3 Apr 2025 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743638542;
	bh=XU0SPOy+ESVftylTjF44Lu0FsBBPS2ssGHhhyWDqICo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdVa8tJ/9oXYqZL2zIAhvL7GVCrN3jKW7Co220zxwU9vZdYd6qHX8tGxIizjLxPJY
	 Moxn9nryOMslBJt1y0U4t1ct7lu3Co/HCGxyfwMegtabV//5VFMm1lurwqgq3tppNj
	 QmFDCSp5DynuK1PCPTlZm8K32kDrTvHup+nKE/vMY/T/msUQXbN+65csX0LRnUatY4
	 inJig0QP4F7KhJD66bLNy4Rv/RbEa/BUY+uQLuqvUVhj0CAWcEghSgX+uq1KvA2iiR
	 ha9M96HZsda0IDZf5eSWJFVJ9shoOGbV6z+E0P0e6K9ahjFhaYPQ629Ef+Hzjl4K/r
	 IbyRsy4rWfpBA==
Date: Wed, 2 Apr 2025 17:02:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v5 02/11] net: hold instance lock during
 NETDEV_REGISTER/UP
Message-ID: <20250402170220.4619a783@kernel.org>
In-Reply-To: <20250401163452.622454-3-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
	<20250401163452.622454-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Apr 2025 09:34:43 -0700 Stanislav Fomichev wrote:
> +	netdev_lock_ops(dev);
>  	/* If device is running close it first. */
>  	netif_close(dev);
> -
>  	/* And unlink it from device chain */
>  	unlist_netdevice(dev);
> +	netdev_unlock_ops(dev);

Is there a reason we don't hold the instance lock over
unlist_netdevice() in unregister_netdevice_many_notify()
but we do here? We need a separate fix for that..
but this series is big enough already. Unless there's
a reason I think we should be consistent and not lock
over the listing?

