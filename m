Return-Path: <netdev+bounces-75774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68486B24C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE0E1F26CD9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCB2151CD3;
	Wed, 28 Feb 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwuz6L4N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC912E1DD
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131741; cv=none; b=e5MjGoI20PN9qj+KYhbivmz7HW48AepZeO++vQqxd2Qetx7RlJt5EkmA4SLZRG5ctl1tUIUBAtn8tbepxdMIbXfudtRLDPLu0ivYHcW1jlL8kw81mN8reLOLEIf34zHDawrwMD1vhpTQnBgUmxtahLP4Vzk58AX+Z7BfhgOZCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131741; c=relaxed/simple;
	bh=MR+jh3Jc65T/XDWjd68f1WpETwT/Q+VjVGIbPGp7HGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSfa7JYwVM92GNgUnKEKVlITLn2lN7xuOIZXowAc7SBDJwCI5u8HeFQUr/KPWdTJoHSONeeGrDOpgwf0cQr7wZV2e9rPgx1+PGsv0ot0G/3010gI6ZKZRdVMIwXyElfuN9Mmup72jKUwO9WjDTBhi25e4in7Kz7+2apktd8jYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwuz6L4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530D2C433F1;
	Wed, 28 Feb 2024 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709131740;
	bh=MR+jh3Jc65T/XDWjd68f1WpETwT/Q+VjVGIbPGp7HGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nwuz6L4NiVZn8ZZ26EKn8pGiqcvoSZoFIYvI03BqgJ4gShCksiCW+bqI7bLbzst+G
	 0RnbUc4jb9H0/9Kb/7+8mYy1eIQw/AhnzaU4l9i1GxzZl3E7skzaLG2BzTR/s+jY2J
	 CyhA6AxoGhpv/UHhKo/YZ74pijG5MnPGP7Z1RklsptEHDWs8Vb0gd1mOWqIn6ieGpn
	 2ZSXarTOXsygzzuaBSAyoz5MFjqI8hRygW16kbgedLnbc5LHinR5wZVsJYqhZclVa9
	 1tep1V3nHbAvv7r448j4P+BoU0ZGd/wDSO7EhyLupeAgjQLMrbhiemRy+QaLQfhveg
	 uVL9CVeavmGvg==
Date: Wed, 28 Feb 2024 06:48:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net: nexthop: Add NHA_OP_FLAGS
Message-ID: <20240228064859.423a7c5e@kernel.org>
In-Reply-To: <877cioq1c6.fsf@nvidia.com>
References: <cover.1709057158.git.petrm@nvidia.com>
	<4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
	<20240227193458.38a79c56@kernel.org>
	<877cioq1c6.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 11:50:33 +0100 Petr Machata wrote:
> > Why bitfiled? You never use the mask.
> > bitfield gives you the ability to do RMW "atomically" on object fields.
> > For op flags I don't think it makes much sense.  
> 
> Mostly because we get flag validation for free, whereas it would need to
> be hand-rolled for u32. 

NLA_POLICY_MASK() ?

> But also I don't know what will be useful in the
> future. It would be silly to have to add another flags attribute as
> bitfield because this time we actually care about toggling single bits
> of an object.

IDK how you can do RMW on operation flags, that only makes sense if
you're modifying something. Besides you're not using BITFIELD right,
you're ignoring the mask completely now.

