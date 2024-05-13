Return-Path: <netdev+bounces-96185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4548C49CE
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85E0281B91
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6D84DE3;
	Mon, 13 May 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCAcHdOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADA446A5
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641229; cv=none; b=J/D439JcNrALj5EkWR4SqYexuQ0P6CUScj2oxGiMdnJNQms1ETSB4V2803iXiecJepObaI4HCTJTdeMx/s2m9tjTNDmDtrU+4JWVtULXLzHSVm0l6J1FrSvr7zmLEQrr0/W3B6I7G2BoqXCaW0fWD8fczln1vFeXxG8ZgrcCtis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641229; c=relaxed/simple;
	bh=7/lsj1n2mP6ZcUoNKBtIEVK9Xi32uNbuVT+ShFMEnVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEBMzQM2zzA2JOJuABKwj3KjVelDBOZijjbWrlhHgq7yZKggtbLTOCk41hx6TpydUTNWOfwS6mHKuPk7TouuKUhZkw9lT0PpKua/j6KO3F3Z2vgx9gsuUBFgd0TAJu8qoHXnuqrCFcIQPDym1HSyg+4/1XNyr0yCItqMSEq2d3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCAcHdOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2009FC113CC;
	Mon, 13 May 2024 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715641228;
	bh=7/lsj1n2mP6ZcUoNKBtIEVK9Xi32uNbuVT+ShFMEnVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCAcHdODyiEjYlgLV1WS0D/+aHmQs625b42CoKco/iAcj3wtMOLCz/YOJU+4qonfS
	 f5Xu/OiBAhXgC9j8QzHxaSkNIXD3Swk8bxZUJ3FV6ArNJXT2YB508VdJGGnkrCZqG7
	 qr6M2nmIwMwXs3poFP90o2hFnz24dGHX/yGaDNHbnjSv0fTTnOhg2GglAA/GI2VWf+
	 UYLC+lrI1TJZVGuSzidGN5pmn1JqRL4M1LHvvWa/3/fOX2jKWzegfNjR/E+abNwuWG
	 XK9om0x+668fWqNOPgyQF+cOwX/y16Zb6aUUZdBaG/KYgOr8FhTSuDjBRdmrrL0PRT
	 GEyRv0DP0wKaw==
Date: Mon, 13 May 2024 16:00:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com, Sai Krishna
 <saikrishnag@marvell.com>
Subject: Re: [PATCH net v3 2/3] net: wangxun: match VLAN CTAG and STAG
 features
Message-ID: <20240513160027.6a4a2350@kernel.org>
In-Reply-To: <20240510061751.2240-3-jiawenwu@trustnetic.com>
References: <20240510061751.2240-1-jiawenwu@trustnetic.com>
	<20240510061751.2240-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 14:17:50 +0800 Jiawen Wu wrote:
> Hardware requires VLAN CTAG and STAG configuration always matches. And
> whether VLAN CTAG or STAG changes, the configuration needs to be changed
> as well.

With this patch the resulting configuration will depend on the order of
actions. Basically the features will be disable if the last action is
either stag or ctag disable. This may cause to subtle bugs if some
refactoring changes the order of enable and disable.

It'd be better to turn both features on if _either_ feature was
requested. And require that _both_ are disabled before disabling.
-- 
pw-bot: cr

