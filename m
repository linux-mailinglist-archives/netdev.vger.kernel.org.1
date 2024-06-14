Return-Path: <netdev+bounces-103700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FC090922F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B741F24223
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F919181B91;
	Fri, 14 Jun 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZEh1JO9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF14414
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389303; cv=none; b=qZANo/YRJvwMk/NozARwBC54Mw/L4zs3aVOqOxUC7FBOQKWE6XBl4lJOGWc0YygpNqPFxL4BSGTAjDmJ1OgBytC0Bcm/Tjizn1kmNsq2Rc1tUm6b9liTxrUCGugfmy7OdJ0hRfZcOKVztkB8C+wYqQQvbyL1HpMqKAPRwV69nOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389303; c=relaxed/simple;
	bh=AG+R7BYoqo/eeDdKaWJleZ1jelLFK+T7L1/68b6cO9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxnKmOY510E/UWdrIUpTcPe+jikOk97LHWRavhV6Zpr5qT34QL4tl5zW1fq+35J04kgBildSxZKFsn6ztYbwxYYZMM1cOyMBDspuaFD8dKZefF9gVXC+RE9u/VSo62W2ciN82jZQTa3eReQe8ShMYSyFXhAamZ23ocQiCQGE1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZEh1JO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E702FC4AF1D;
	Fri, 14 Jun 2024 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718389302;
	bh=AG+R7BYoqo/eeDdKaWJleZ1jelLFK+T7L1/68b6cO9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZEh1JO9LKFcm754KKcvxljjQBIoOZYUxVm6jck1PqsxS6TOzmhSe85SCCrZWLs5l
	 pegikI1yORKZhIgl0IjZ8uy8NVFK0fcmPf8oi4vyBD5NRhiqCzuXRHsyzdyfT/Kppz
	 3ow8/URgGFun76gfhiRLR/SoswzZuITmyU6tjv5OOmn5x1mEKsCLLJJMxpz5UNOQJo
	 aejghR9x+1vYFbfSep8MCyhEuQqzF2JJXfjTjGyGt7/HzPrbuxqH1GN7mbZLRsYKsr
	 m8N1JaPTTFjprwrt3c1pbB9JVh6r8tVxFhNH2cTfTm2d8NlRdMrl/rTXb5cJa1pqnL
	 ACEYpBXJwbs8g==
Date: Fri, 14 Jun 2024 19:21:39 +0100
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm: Fix unregister netdevice hang on hardware
 offload.
Message-ID: <20240614182139.GW8447@kernel.org>
References: <ZmlmTTYL6AkBel4P@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlmTTYL6AkBel4P@gauss3.secunet.de>

On Wed, Jun 12, 2024 at 11:11:41AM +0200, Steffen Klassert wrote:
> When offloading xfrm states to hardware, the offloading
> device is attached to the skbs secpath. If a skb is free
> is deffered, an unregister netdevice hangs because the

Hi Steffen,

Some minor nits from my side as it looks like there will be a v2 anyway.

deffered -> deferred

Flagged by checkpatch.pl --codespell

> netdevice is still refcounted.
> 
> Fix this by removing the netdevice from the xfrm states
> when the netdevice is unregisterd. To find all xfrm states

nit: unregistered

> that need to be cleared we add another list where skbs
> linked to that are unlinked from the lists (deleted)
> but not yet freed.
> 
> Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
> Tested-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

...

