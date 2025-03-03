Return-Path: <netdev+bounces-171261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C8A4C418
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894A33A8133
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2CD18858A;
	Mon,  3 Mar 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liqBqqHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F21482F2
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014021; cv=none; b=brh5rrmY+Z6hHWt07jkvJ/LsdB9HcDlwwyYYASFYIKu5hIfvbbKY/psEogwp4MM1L4qSTESbqYHle6G5C717PfNZaTT9AU1LPWUw8mRSuIwWzTvsneq5tPyUG5/6pAe8yZnQMCsF8LE4EcK4or0VT/d3TlUKdR4emOstEZwZN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014021; c=relaxed/simple;
	bh=uM5pu9BkqV4anLLPtclfY9025i+5//1fdfMZrWP2JAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaOR3OJOYw3KZMpv3Gd8WHPgV7XK90AJAVoAsHU7UQsNELBINnhxMrBj4hiauneaGPDM/ce4U6zEX9GjE0N8aGqGaXSglAwi/iKp03ajZuyre5ucm6lKvXRtQp5w0H55QS0ikt0cdjctAO9M2uQXp5lOsxhi4FPq78P5Vh+Msg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liqBqqHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1461BC4CED6;
	Mon,  3 Mar 2025 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014020;
	bh=uM5pu9BkqV4anLLPtclfY9025i+5//1fdfMZrWP2JAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liqBqqHr0nCrCWsQ4M77Pu+ENRFsORnAFsH+WT55wMguvJptMOmGhLh9B/GVk3mKf
	 eOci2AhNAQrIywuBVwk3jo+zOY3MV6nzPmZvtyNy9thvjzaB7TJ3MJb2lKzzR9A2ac
	 //JfdSFjMm8y3IJRZTZhK+hbSY9VeKrd9WDNoH/HAcOjsExtKLa4WuSDd4xdpX9kzW
	 IOVbrM+NXB0IuXbmiLlet4OmykMQ6OxGlDxGne5hFyMQ5HIFV6RShL2CMA0FXmX8Pb
	 5A3EF2zGsGc/pQVxAKS8j6/WIJDHwBjiNO3g2fxomMRzUuETmCAPRkp714N/5PFFYN
	 fKsQytXE4pU4Q==
Date: Mon, 3 Mar 2025 17:00:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v7 net-next 3/5] net: ena: PHC enable through sysfs
Message-ID: <20250303150015.GA1926949@unreal>
References: <20250218183948.757-1-darinzon@amazon.com>
 <20250218183948.757-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218183948.757-4-darinzon@amazon.com>

On Tue, Feb 18, 2025 at 08:39:46PM +0200, David Arinzon wrote:
> This patch allows controlling PHC feature enablement
> through sysfs.

Jakub,

Does it mean that from now on everyone can add new specific to him
sysfs entries and long-standing netdev policy of not adding new sysfs
entries is cease to exit?

Thanks

