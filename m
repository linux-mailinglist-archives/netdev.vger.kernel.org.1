Return-Path: <netdev+bounces-156084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CDBA04E3D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430483A1745
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C223FBB3;
	Wed,  8 Jan 2025 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbXs4ar1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78AEADC
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297131; cv=none; b=D/Em7R8utCx3eDjuZzD80ttSAadFwwPaW++7umPh4Ud6+1TD52xiHJfTfSdGfQuTgWnwPRwJ+nkv7Ra4EdHoMnTRKzdlooBBME1YDoRYZ2BbhKHSvmT5cWx2QhuO7Yen3PpZ16gxngMHHr4E6s7QxT2Fz4kCb7WEmq38tXccjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297131; c=relaxed/simple;
	bh=jsAGW7/F5gcreFJA/I1DxQSfefh+t5OvjGDcW+5xvE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORJJlxRO1gVv5e8VvoG07rU69MWdc7mhwVwx3aRPtWsmIdm4nnxgKhR8H/oK2LGE2oePQ7pLd+5leGP5fJnZ/Mm0ujfZYhd8gxVALRzCRIPEcsxBukUewksxewRSoshAdghmuOsJH4Ja6D8XGIMuslZxggFIl4BMNAJNY8p9MMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbXs4ar1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C81BC4CED6;
	Wed,  8 Jan 2025 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736297130;
	bh=jsAGW7/F5gcreFJA/I1DxQSfefh+t5OvjGDcW+5xvE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GbXs4ar1mdm1LrGlxn+Wa05wsm9DKjwsKHly3hYFRFL7BTjJty6fIYySa1yn5kRxo
	 L/7zVYhp8cE44zFShwsahWmraofE8afeb5N8gQkQl1SBMYeGU/3MA2Tq6VSrDFYHjL
	 GPnc8HnbBQKzVG8sIYLEy9czJXARlsSdLkJUdM/qlxHa/WbSKnEzlDQZo2DVPPzyAt
	 cWjvLqEWuljCkcWcozBrv+hJXVA8jnKsbFLDcrIWskpGNBBgBXJKzWUQlD5o0AHTJl
	 MZE/vC7n/K6KBYOqFb7gLeMQEgDidBqIYG11Obcu9qJEY/RgF4n2+Af+GK65KG1MZs
	 a+sdAG6kFtVtA==
Date: Tue, 7 Jan 2025 16:45:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, sdf@fomichev.me, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next v2 6/8] netdevsim: add queue management API
 support
Message-ID: <20250107164529.27603de6@kernel.org>
In-Reply-To: <CAHS8izO3FWZ6Wgnf0jwHLo8xDczz1zmCq_ypXRAWijYuxUY0MA@mail.gmail.com>
References: <20250107160846.2223263-1-kuba@kernel.org>
	<20250107160846.2223263-7-kuba@kernel.org>
	<CAHS8izO3FWZ6Wgnf0jwHLo8xDczz1zmCq_ypXRAWijYuxUY0MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 14:53:09 -0800 Mina Almasry wrote:
> > +/* Queue reset mode is controlled by ns->rq_reset_mode.
> > + * - normal - new NAPI new pool (old NAPI enabled when new added)  
> 
> Nit, probably not worth a respin: Normal seems to me to delete old
> napi after the new one is added and enabled.

Yes, the comment doesn't really focus on removal order, it's less
important. I may be missing your point..

> queue stop -> napi_disable(old)
> queue alloc -> netif_napi_add_config(new)
> queue start -> napi_enable(new)
> queue free -> netif_napi_del(old)

I think you have stop and alloc swapped here.

> > + * - mode 1 - allocate new pool (NAPI is only disabled / enabled)
> > + * - mode 2 - new NAPI new pool (old NAPI removed before new added)
> > + * - mode 3 - new NAPI new pool (old NAPI disabled when new added)
> > + */  
> 
> Which modes are 'correct' for a driver to implement? 2/3 is for
> testing only, as you note in the code, the add/del functions should
> really be called from alloc/free and not from queue_start. I assume
> modes normal and 1 are both correct implementations of the queue API
> and the driver gets to pick whether to reuse the napi instance or not?
> Asking because IIRC GVE implements mode 1, not what you consider
> 'normal'.

I can't think why any of them would be "incorrect" per se, but 2 and 3
are likely weird and unnatural. I thought mode 0 would simply be most
common, maybe I shouldn't have called it "normal". But because of all
the "modes" netdevsim implementation seemed too messy to be considered
a blueprint..

