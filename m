Return-Path: <netdev+bounces-125535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5C96D947
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302741F28D47
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6EE19B5BE;
	Thu,  5 Sep 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tq2mmAe7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4719D065
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540466; cv=none; b=dBNgB1gxuNTk/LSL5QsbJZjwW/OfZDbdcxLiO2RvSJzCUL+YoO22dAPziPPS/LNjff6UKY8ZTuXQvbC3+H6/rCEt3oZS5XuruUCDZRKc49xTtDC7f6ahTuHtw7pyovJlLSVWvZE9WGiFggUYNtTd6AOAr6t7kELrRFSJRvxM/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540466; c=relaxed/simple;
	bh=9Sv5b2A2lfd4aggybE9kTsGXA5YDtbIFYv6eBi1VCSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PygyYs3WH3oJOHrCs3o20bAyarRfbTqZwVEU9UFihs/Z4ASQsDEL2MjwwVJM6Hsg8t57C7QXNyi57LjplaaFD8mrdi6mmFXIWDOys2vFW8XWG7Zy5dT0Q0Qzsu3g/KPrtA1lE3eyGXatM8LNwktDT3Q21nj9OZE18bw/xQvAQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tq2mmAe7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m9hv2NwnKnkmfWUEmbg2iZOG0DRFTPN4sMrmwnDn8yo=; b=Tq2mmAe7JPanSqTdSgpz0kmTyP
	Y3f+RjLjjB/Qkcp5pzMHf7bBq65LOepLd4AWPKdb6hgvhj6KNU2SM+HAb+38FYjsGK+uAK4E/7358
	iwzE1WS3uJjLHs80hQZEcfKqvpSInSO+v4hVHcjAVbac3q4NkSJqZdLIAQBSt9pA6eTE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smBte-006g2L-9P; Thu, 05 Sep 2024 14:47:34 +0200
Date: Thu, 5 Sep 2024 14:47:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Ido Schimmel <idosch@nvidia.com>, gal@nvidia.com,
	Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [mlx4] Mellanox ConnectX2 (MHQH29C aka 26428) and module
 diagnostic support (ethtool -m) issues
Message-ID: <5e176dbe-1a31-4349-84da-9f724d73d92f@lunn.ch>
References: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
 <ZthZ-GJkLVQZNdA3@shredder.mtl.com>
 <b0ec22eb-2ae8-409d-9ed3-e96b1b041069@ans.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ec22eb-2ae8-409d-9ed3-e96b1b041069@ans.pl>

> Also.. I think this is 3rd time I'm recompiling ethtool without netlink support.
> Would it make sense to add add --disable-netlink?

Looking at the code, it should be trivial to add. I expect such a
patch would be accepted.

	Andrew

