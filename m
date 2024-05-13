Return-Path: <netdev+bounces-95941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70708C3E32
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46838B22ADA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53401487E9;
	Mon, 13 May 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZWXSHh0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B41487E8
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592921; cv=none; b=Dsuz5qW8nbUZoBOUIYsLBkUJMZMkCC40gTbwcEsJiT8ZOgceZxQtGRDJhkEWmHss/uqjvFza/yen+26uS2s6+dxxfFZj4FXGToayh2njr2iIMKmRfikQ/p1K1uv+WTUU6ikQIUYR8ciHQXUFK8rAccwHEs5jnvWz+wneBqzdB5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592921; c=relaxed/simple;
	bh=dScarophLZOg+BW56onrFuby3S0kB365mJ9qhDWAIDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auPy9mMfS7pr9hhhRm4dJtPhviRl+kSw7Fp7EvjQ0DhYIHVNuMYN74RxuAGE8UEcVKqk4KP6Zsqf9lImJGNC/iabOIeygNAQ8UkM9LzfBDU7uV3fl94O+FqT9ICJOEzxsFdKSVdvuaIK8bafp5pDQgvBEaE//89ipA5+nh8EGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZWXSHh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1180BC113CC;
	Mon, 13 May 2024 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715592921;
	bh=dScarophLZOg+BW56onrFuby3S0kB365mJ9qhDWAIDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZWXSHh0+rDAeX1NGEbNjyUorZ+2E6HHNTpn+IF0THNcJlnCeamKwzZirU2EtmE2F
	 qIe7L+muRFaADM1w9Od5rMpdlVOApcPOtNZk3UfDnzX8rAt3R9x1Pt4B/zM+TVmiVK
	 /KRvBgBEBHHU3wrqtpTacF5GklE97/uBgFq9UId3V6/IXHHjj9vs2yZT1G85MuRBwg
	 t7/SmDBNBEPeVYEri93PFyFkm/TOeUoNQVVf6DAapsleO5Fvvo03SlddEfmS0bGK9p
	 GXBItZtMBgj1R4qQcpyh8fT9/haQpSazNr72BLptzuoEWlXrNmOEtCSiShr5SHf98K
	 Se+dYLr4DXqhg==
Date: Mon, 13 May 2024 10:35:14 +0100
From: Simon Horman <horms@kernel.org>
To: darinzon@amazon.com
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH v2 net-next 4/5] net: ena: Changes around strscpy calls
Message-ID: <20240513093514.GH2787@kernel.org>
References: <20240512134637.25299-1-darinzon@amazon.com>
 <20240512134637.25299-5-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512134637.25299-5-darinzon@amazon.com>

On Sun, May 12, 2024 at 01:46:36PM +0000, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> strscpy copies as much of the string as possible,
> meaning that the destination string will be truncated
> in case of no space. As this is a non-critical error in
> our case, adding a debug level print for indication.
> 
> This patch also removes a -1 which was added to ensure
> enough space for NUL, but strscpy destination string is
> guaranteed to be NUL-terminted, therefore, the -1 is
> not needed.
> 
> Signed-off-by: David Arinzon <darinzon@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


