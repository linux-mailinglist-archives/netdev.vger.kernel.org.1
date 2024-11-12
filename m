Return-Path: <netdev+bounces-144118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4BF9C59FF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2995282F8E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26211FCC4D;
	Tue, 12 Nov 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbnjWrgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F761F708F;
	Tue, 12 Nov 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420749; cv=none; b=tXGCKXS8EOO2fdCr2t7iKz+xiOZDURIdL9fHy7mMi8za+0hDq39ssYLYfgRftkTSp2AFbP3jIvcH5b5uupbIxByWe8pTbowV2flQsurTWyUgoZ1hePhWAPgOhrnua5qEL8sVzB/VeGZBM1/SQIj84SWrE4YD7UlOCuwiSqQJaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420749; c=relaxed/simple;
	bh=r5dFJAER5XHtnBG6KFvP3JWd+yitNyVN7EVvuqkBReY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB//fUbIzpnF9LCripcjEJ9BHNGa6gn2d5dgTpu5FU0c2jFk2DuzKzkWG0rKh75JozdZMR2PEUHK2pg2U5lynFshHNBGhOCktCy6rZNBsOLlKT0OcBWA2GlabT8+4XIakbVgQ0MFUtrtMpOo0SATGd1s7JnVxN+Td5Krt09p7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbnjWrgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0008C4CECD;
	Tue, 12 Nov 2024 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731420749;
	bh=r5dFJAER5XHtnBG6KFvP3JWd+yitNyVN7EVvuqkBReY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KbnjWrgk9T+CJiRkwRirmro/LUJtc3ETpytZxbWPqZXnPfnGnCxregYQkO5kdKtob
	 ITlLI/jvPgVU2K+4Qfk4OFq6nZRLSBS5wYZls7h56PHX++GZZfZLws7DbTL/+vE9Zu
	 cE/LstpxurDMaeqmUvTpUBNGIGyYy0ipZ482C2d5IbhLp9nY22QdaxrbA9k2DsCTky
	 dWN+9eWqckArv7FiKraz3FZZkxyUvVoH9m9PqE+qYQ67bge/YHuXssiClL9VUF3ZwP
	 smsI0DYGXeZe5Ges0jYrA23OJ4/KrmHSgLRyrpIVfWDvRsDKZhSstFPPlEAQuaGzPN
	 IAFaRZtpDBu0g==
Date: Tue, 12 Nov 2024 14:12:23 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Haseeb Gani <hgani@marvell.com>,
	Sathesh B Edara <sedara@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	"thaller@redhat.com" <thaller@redhat.com>,
	"wizhao@redhat.com" <wizhao@redhat.com>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"egallen@redhat.com" <egallen@redhat.com>,
	"konguyen@redhat.com" <konguyen@redhat.com>,
	"frank.feng@synaxg.com" <frank.feng@synaxg.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next] octeon_ep: add ndo ops for VFs
 in PF driver
Message-ID: <20241112141223.GQ4507@kernel.org>
References: <20241107121637.1117089-1-srasheed@marvell.com>
 <20241110131846.GL4507@kernel.org>
 <PH0PR18MB47348854DEA380C378C5F2E0C7582@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR18MB47348854DEA380C378C5F2E0C7582@PH0PR18MB4734.namprd18.prod.outlook.com>

On Mon, Nov 11, 2024 at 05:29:53AM +0000, Shinas Rasheed wrote:
> Hi Simon,
> 
> On Thu, Nov 07, 2024 at 04:16:37AM -0800, Shinas Rasheed wrote:
> >> These APIs are needed to support applicaitons that use netlink to get VF
> >> information from a PF driver.
> >> 
> >> Signed-off-by: Shinas Rasheed <mailto:srasheed@marvell.com>
> >
> >...
> >
> >> +static int octep_set_vf_vlan(struct net_device *dev, int vf, u16 vlan, u8 qos, __be16 vlan_proto)
> >> +{
> >> +	struct octep_device *oct = netdev_priv(dev);
> >> +
> >> +	dev_err(&oct->pdev->dev, "Setting VF VLAN not supported\n");>
> >> +	return 0;
> >> +}
> >
> >Hi Shinas,
> >
> >Given that the operation is not supported I think it would
> >be more appropriate to return -EOPNOTSUPP. And moreover, given
> >that this is a noop, I think it would be yet more appropriate
> >not to implement it at all and let the core treat it as not supported.
> >
> >Likewise for other NDOs implemented as noops in this patch.
> >
> >...
> 
> I think the problem was for some userspace programs and operators, sometimes returning -EOPNOTSUPP is a no-go. I think the idea was at least if the user saw these messages, they would know to
> set it in some other way, and also not have the operator stop just because setting these values failed. Though I understand that’s counter-intuitive, but sometimes it lets operators work and go ahead. What do you think so?

Hi Shinas,

I think it would be good to provide more detail of such use-cases:
my understanding is that not implementing the operations would
be the go-to solution if they are not supported by the driver.

> 
> Thanks for the comments!

