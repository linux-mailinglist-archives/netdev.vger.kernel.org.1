Return-Path: <netdev+bounces-142198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F29BDCE2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D081C230E1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891AF18C01D;
	Wed,  6 Nov 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIke/+/p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63293335B5
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859355; cv=none; b=iY7/qJ6gOWFN1l178WVtOomjvF4TKqjCgSo7Kijj+vvQgCeaa4kFwelrT8BIY1t/dArviMt9ppU8RAZ5wv3cBIPDI7oOqKO5WKsIYuZ25yCPOWlWfk+HbGJeAKV90Apn+lyQ+LPKnC7v9K93o/HvkU3GMbeasJsjtrKN8tu6D+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859355; c=relaxed/simple;
	bh=YmeclzIkiatawZgZIDhNFvDealy+y6phg17N87dmU2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1qGIF/MF04d+HHPUMSaVdNpWEbH9j9UTQXGkUMBfGx9IEnY/Uu2jPl8Y7VYj7c30pqekRGIv0NN96kT57UCQE7XPTKDIeLldNcpPP7fLeVes2VkL7FdV22CbJ63aB16sydz+JxYxps01F1sLgFaJ3H9wguWzBPnntHvrpGFWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIke/+/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E147C4CECF;
	Wed,  6 Nov 2024 02:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859354;
	bh=YmeclzIkiatawZgZIDhNFvDealy+y6phg17N87dmU2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BIke/+/pYf6LBbywKMj/vSLgA+BhgIEQNkCDJrXn35qpSZ5UD5bYKfPwUQ4I8LP2L
	 WWw3vu+J7Ghi++6vN7oCIugnPGaRpeke1t74MTJTHaDbx1koOQNX3aHFBYhnMGrJZV
	 Vz8JFftYt2MDYKdndN3GWu9hBnGca1k7DM4KOODSPzxKOC1dO76OJ8hVouPZ2gO8dt
	 MS64ZnPazuKcpt9mEZG+YCNcAxJn3IBsc3L0sUZrFcl5wF+QpsEGAoCej1KcjZ2mMp
	 lAFTcoaOj3xPoaj9S7Sr3kOMzaOxRoirmX5b2pzbCC5gNBkKrXp4TI4Wx60PM24DjA
	 HYSoBXIIb/zfw==
Date: Tue, 5 Nov 2024 18:15:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: "Arinzon, David" <darinzon@amazon.com>, Gal Pressman <gal@nvidia.com>,
 David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>
Subject: Re: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Message-ID: <20241105181552.02ea5525@kernel.org>
In-Reply-To: <875xp1azla.fsf@nvidia.com>
References: <20241103113140.275-1-darinzon@amazon.com>
	<20241103113140.275-4-darinzon@amazon.com>
	<20241104181722.4ee86665@kernel.org>
	<4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
	<91932534-7309-4650-b4c8-1bfe61579b50@nvidia.com>
	<4ba02d13a8c14045b0df7deaee188f82@amazon.com>
	<875xp1azla.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Nov 2024 18:02:57 -0800 Rahul Rameshbabu wrote:
> I do think the phc-to-host related statistics are on the niche side of
> things. The following drivers are error free in their gettimex64 paths.
> 
> * AMD pesando/ionic
> * Broadcom Tigon3
> * Intel ixgbe
> * Intel igc
> * NVIDIA mlxsw
> * NVIDIA mlx5_core
> 
> The above drivers would definitely not benefit from having "phc
> (nic)"-to-host related statistics being presented here. I am more in
> favor of making these statistics specific to amazon's ENA driver since I
> think most drivers do not have a complex . Also, what value is there in
> the count of phc-to-host successful/failed operations versus just
> keeping track of the errors in userspace for whoever is calling
> clock_gettime. I am somewhat ok with these counters, but I honestly
> cannot imagine any practical use to this especially since they are not
> related to anything over-the-wire. So the errors in userspace would be
> enough of an indicator of whether there is excessive utilization of the
> requests and the counters seem redundant to that (at least to me). Feel
> free to share how you feel these counters would be helpful beyond
> handling the return codes through clock_gettime. I might just be missing
> something.

Agreed, thanks a lot for the analysis. I misread the code.
I looked at ena_com_phc_get() last night and incorrectly 
assumed it's way to complex to be called from gettimex64 :S

