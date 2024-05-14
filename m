Return-Path: <netdev+bounces-96324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5FC8C50B4
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBED0282140
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888EA13E8B6;
	Tue, 14 May 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4e/0vTo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC16D1B4;
	Tue, 14 May 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683595; cv=none; b=ebl81oE9puI6D8Xe+6x9PKN/QiScty1ixMf7rKobzEPWaode8QUA/xOQyi+3xPkcOat6UE/jPk5kFRwP+AgcayFQM8cW9xEXSANSG50KC46qyIFL6QeuRunGcuNSWYfPzqOdxcOWgO3Xu2h23n+Fid2Z9kvJt5o+31jEdNo2K7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683595; c=relaxed/simple;
	bh=DHFuiyL6T5J2md2p75u4E5Jz8QSMYKiBIleKiS1nJh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU1528G/m2+5s2lJPkHO+m+uXCj9ZzGqmNs2zLxkpunD5AGpHNPLSmjBSwwECM4PCnYTcw/lvl1u93Rd75u8P2QUz/YWuB0djvZfHrGgjFwXmH6vmt/Schw60Ejc4GuP3z4feLfLEcUT3kikjJWy9kxfLJ2LMNZe1ucT8QgeRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4e/0vTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE6C2BD10;
	Tue, 14 May 2024 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715683595;
	bh=DHFuiyL6T5J2md2p75u4E5Jz8QSMYKiBIleKiS1nJh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4e/0vToJzWnMNABYFEb4mmjwzdFvt8whPVkDhVQGVZsd1pCwDU5fO/OnKDblY/i3
	 88Sm+EYr5yGI0aO4xWDXQ1dfL7KZ+Vq6/YhRZhOIJCCCBx+oaXk5ADEFadUSOvIZJp
	 Mizuyt+YaWqmabrF+GUHajeM8UubkHt2uxD+WOayb5bD4WgWHLZO9Krv9XIurhl7ql
	 30/NPnQpZPKzIECZ8fvkVPCHDM5b2d/YQT6yQq7BJo22H/wGq38yxAlfhsHV3qEKY5
	 3YhljaB8T2eZ4XVEugsVw/z/DhtdTK0k2lkcy3ER60Lfp+nJv1cr0pEy+0AN6XrQ4J
	 MvA4WPFkgVsbQ==
Date: Tue, 14 May 2024 11:46:26 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: Re: [EXTERNAL] Re: [net-next,v2 5/8] cn10k-ipsec: Add SA add/delete
 support for outb inline ipsec
Message-ID: <20240514104626.GE2787@kernel.org>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
 <20240513105446.297451-6-bbhushan2@marvell.com>
 <20240513165133.GS2787@kernel.org>
 <SN7PR18MB531442D0D88031D320F3372BE3E32@SN7PR18MB5314.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR18MB531442D0D88031D320F3372BE3E32@SN7PR18MB5314.namprd18.prod.outlook.com>

On Tue, May 14, 2024 at 06:52:38AM +0000, Bharat Bhushan wrote:
> Please see inline
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>

...

> > > +static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops = {
> > > +	.xdo_dev_state_add	= cn10k_ipsec_add_state,
> > > +	.xdo_dev_state_delete	= cn10k_ipsec_del_state,
> > > +};
> > > +
> > 
> > cn10k_ipsec_xfrmdev_ops is unused.
> > Perhaps it, along with it's callbacks,
> > should be added by the function that uses it?
> 
> I wanted to enable ipsec offload in last patch of the series 
> ("[net-next,v2 8/8] cn10k-ipsec: Enable outbound inline ipsec offload")

I appreciate the patchset being split up like this.

> Is it okay to set xfrmdev_ops in this patch without setting NETIF_F_HW_ESP (below two lines of last patch)
> +	/* Set xfrm device ops */
> +	netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;
> 
> Last patch will set below flags.
> +	netdev->hw_features |= NETIF_F_HW_ESP;
> +	netdev->hw_enc_features |= NETIF_F_HW_ESP;
> +

IMHO, yes, something like that would be fine, as long as it leads to a
working system (with a feature not enabled).  Perhaps it would be good to
include a comment in the code about this to make it clear what is going on.

...

