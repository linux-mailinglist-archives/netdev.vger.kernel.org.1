Return-Path: <netdev+bounces-153373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595A09F7C92
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C19188D8F3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E828218EB0;
	Thu, 19 Dec 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WHg0xXHM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E41BC58
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615796; cv=none; b=lwkuua5/zO4jdd4Sej2nBNdPfupJMSjBWXvxQAi+yJuO2PYQXlwLFlyRakQ1FKs7LiAIfUc+7xA04ME6TuvzFoOyMX220rmxb5uXt4Hu48+GcsNzlReO/ENiyMtxMvFP8YEKjYlRiXINK7JrCDqcfZUH89/vEtTvv4QbSD0y3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615796; c=relaxed/simple;
	bh=kHX/4s/j9iOUoVcVIa9iSbev/OQq5C3/mWwIZfkwFHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo8VDnbrdv82VlLg47PQyHihs4Syl7n5F1QaS+7QCg1g6bjMjpC25D9zqo8Bobv/7ugQ3I8OOPTshERCCRiQ15mNc83fF25s8KEUF2SNGX1uB4QGnDF4cJV2hnaZEHVJ42Sz5LcawRbALcFSb87tRz75GqkrEX9Yj7pe/3ZaHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WHg0xXHM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A5M1Oa/kKWQ8KzO71+ORq6Vq0trJEb3/sUHn76yLNkI=; b=WHg0xXHMiY4ylvnjPxC3xfdJxi
	OmKSaXfNKKiC4oVDlc2/XeAlXaq3FDX+O+kJug7zsOQra5jaEw9L4DWFAc5dSJ5Q9TczCzwSFq0PS
	Pu6UC6v3FNRR4itqxuV2lEiSfthtfX0F2PBAo+60QcPKYR+LkbN0BGABZqE+Fho0R0Og=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOGny-001dG8-SS; Thu, 19 Dec 2024 14:43:06 +0100
Date: Thu, 19 Dec 2024 14:43:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
Message-ID: <b8a26f52-c8a6-4c38-8df6-ca058c9e328d@lunn.ch>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219123106.730032-4-tobias@waldekranz.com>

On Thu, Dec 19, 2024 at 01:30:42PM +0100, Tobias Waldekranz wrote:
> NOTE: This issue was addressed in the referenced commit, but a
> conservative approach was chosen, where only 6095, 6097 and 6185 got
> the fix.
> 
> Before the referenced commit, in the following setup, when the PHY
> detected loss of link on the MDI, mv88e6xxx would force the MAC
> down. If the MDI-side link was then re-established later on, there was
> no longer any MII link over which the PHY could communicate that
> information back to the MAC.
> 
>         .-SGMII/USXGMII
>         |
> .-----. v .-----.   .--------------.
> | MAC +---+ PHY +---+ MDI (Cu/SFP) |
> '-----'   '-----'   '--------------'
> 
> Since this a generic problem on all MACs connected to a SERDES - which
> is the only time when in-band-status is used - move all chips to a
> common mv88e6xxx_port_sync_link() implementation which avoids forcing
> links on _all_ in-band managed ports.
> 
> Fixes: 4efe76629036 ("net: dsa: mv88e6xxx: Don't force link when using in-band-status")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

