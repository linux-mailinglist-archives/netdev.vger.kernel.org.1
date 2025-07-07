Return-Path: <netdev+bounces-204699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616DCAFBD0F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F10C7A414F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0F2857F2;
	Mon,  7 Jul 2025 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdppw/Y4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683CA285C99
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922128; cv=none; b=k3AIDhu9hsram/zKbYC/zbzlYAvKw8EDv+DrRLjpsolG3LYrTbAEC0ExqQ7nARF3m5chyYCinLElf4WDBQRc1wQRAh6hz++FdwZkhLEVqMI+6e/vUmJQXKEoPKi6zRJfiOkTVaCEz71OZmaPjdE04zUATefycMNFO0dSpcd2gvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922128; c=relaxed/simple;
	bh=3XWZY4haMHTEPrlvkNxrDSRLRhzeng3ULSJbWttpu2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/XjAXFEEt0i0SnlMUhLhOZ7I9T4uZzKp4hyVvrRJg6/hqo5Wr4CPdjtLPIFlwAjcKxVkjxaevp1Dmk1R/GokkuTg0iavYcbjuHXtHXfrnWA5b7uYGpb5fbCwgA9aYVrIod1dpZ1bC1ek7G5/DCp00eqcICORIiBt9/skj/HaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdppw/Y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353D1C4CEE3;
	Mon,  7 Jul 2025 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751922128;
	bh=3XWZY4haMHTEPrlvkNxrDSRLRhzeng3ULSJbWttpu2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xdppw/Y4vFNfEXuRBg8CM4MsAFvgAJN5ErizEfyZZbxMu00rpIAUCgHwYJW+lgagM
	 zxJWAq1EpceHmkEDwuS3fGYSFezZtNAXXYunqJ6ne0d6p1ErBJtWmy1YYDkjKJCQ7H
	 Or74G2jnRmEwc7O+HyzAGfoTXII4Tyhh3vSv3l2pi45TORdS2Pv9DxnKBYqTujHQP+
	 ulO7bPJlenCKSmLvqeIObezqobrS/BliPmFqEQWHEaEmcq7B6rNYSAZa6bs6m9GWVe
	 hrwRY2ldqaGzRKNPN2FWUSJsN3Puvu8yikUla/u9gxlrz2jJkMxrQ3ZymXWIPl4qlk
	 dapCiu8n/EdNA==
Date: Mon, 7 Jul 2025 14:02:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 02/19] psp: base PSP device support
Message-ID: <20250707140206.0122c47e@kernel.org>
In-Reply-To: <686a96ed46da5_3ad0f32941e@willemb.c.googlers.com.notmuch>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
	<20250702171326.3265825-3-daniel.zahka@gmail.com>
	<686a96ed46da5_3ad0f32941e@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 06 Jul 2025 11:31:57 -0400 Willem de Bruijn wrote:
> > +/**
> > + * struct psp_dev - PSP device struct
> > + * @main_netdev: original netdevice of this PSP device
> > + * @ops:	driver callbacks
> > + * @caps:	device capabilities
> > + * @drv_priv:	driver priv pointer
> > + * @lock:	instance lock, protects all fields
> > + * @refcnt:	reference count for the instance
> > + * @id:		instance id
> > + * @config:	current device configuration
> > + *
> > + * @rcu:	RCU head for freeing the structure
> > + */
> > +struct psp_dev {
> > +	struct net_device *main_netdev;
> > +
> > +	struct psp_dev_ops *ops;
> > +	struct psp_dev_caps *caps;
> > +	void *drv_priv;  
> 
> not used?

I'd rather keep it from the start. The driver-facing API needs to be
relatively complete otherwise drive authors will work around what's
missing rather than adding it :(

