Return-Path: <netdev+bounces-116907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96694C096
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B350284FDD
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871E18E056;
	Thu,  8 Aug 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDP+oR4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242B18C355;
	Thu,  8 Aug 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129856; cv=none; b=lXooYd3GOiqEFZGS+Nj4rmsytDZkKagroUVGaO3ZFZaXYgfj7/ioEQXa4LdyyBADUEHIB5ikKH7S9N+Etfh4+2VrExUb3+NafD2LLIb0PnYQ3dpnsaZjneLVqOnILSy3zb5wWWcgsVD6sIZcBKm/nWK2eSZPgehHjhW/XfNQb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129856; c=relaxed/simple;
	bh=gUzCY93vOFCXuNB20coeGLxNXZ7HTb+v3XLDQ1zyD0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2IHoW+hpMVIpddg/6hM48Z85ec3eEm+BGm/IPg/GP0XQS9sdByEXLvkKXG5Wu9gjSs4oi6G2PhBhTRdztYTHKseun9kDg/EeBm3/XNS8ADdwk1IVpxdktK4CDDqFAuKhM/LS4lUkhyVb2VDTZ9JWthvTEpG+67AQunjaENSDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDP+oR4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146EAC32782;
	Thu,  8 Aug 2024 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723129855;
	bh=gUzCY93vOFCXuNB20coeGLxNXZ7HTb+v3XLDQ1zyD0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jDP+oR4Hk4WBzRLmur3ZpCci/KgVKT6NeFFEYaU6+20S8VO40N2SyRlck8k68c67U
	 m3XC0WtST3dRyxvEcOI8irmt2bJciXfiKCLq9RDCe4ZDmpNEnXGs6+3NH6do+LY1A1
	 5+BzX5SnvhSMvIBmaqVC+skwqocY606xOOeHc11WAbpbrpMCECmWeODhSMk+a0117B
	 IzWNKhjD7ANbmPHuiEUkMRGZG8BypPTt/S0KwcCGD6fGML/DQqvOj6R3scdooZxozy
	 4YwKQUeQg5795pU7xMO9XVNRrVg4Y/ci+j8O7xE8eFnQbpWHmBAkpc/BowV2utKMmP
	 DzHVFSs/eem1w==
Date: Thu, 8 Aug 2024 08:10:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Johannes Berg
 <johannes@sipsolutions.net>, Shigeru Yoshida <syoshida@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net-sysfs: check device is present when showing
 duplex
Message-ID: <20240808081054.1291238d@kernel.org>
In-Reply-To: <6c6b2fecaf381b25ec8d5ecc4e30ff2a186cad48.1722925756.git.jamie.bainbridge@gmail.com>
References: <6c6b2fecaf381b25ec8d5ecc4e30ff2a186cad48.1722925756.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Aug 2024 16:35:27 +1000 Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal, attempting to
> read device state when the device is not actually present.

True, but..

> -	if (netif_running(netdev)) {
> +	if (netif_running(netdev) && netif_device_present(netdev)) {
>  		struct ethtool_link_ksettings cmd;
>  
>  		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {

..there are more callers of __ethtool_get_link_ksettings() and only 
a fraction of them have something resembling a presence check in
their path. Can we put the check inside __ethtool_get_link_ksettings()
itself?

