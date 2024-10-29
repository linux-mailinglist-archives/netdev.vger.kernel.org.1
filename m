Return-Path: <netdev+bounces-140038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 201539B5190
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB775B21BEF
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BAF1DD539;
	Tue, 29 Oct 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOSSaaia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573541DB929;
	Tue, 29 Oct 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225327; cv=none; b=Q4r/Xwe0Fp/xNQnx6UC47S2mcEsnWv1KGDmy1h6KxVNdUDUxlvangX8cWPQHit7Ltx31qOYNDHDbob2Az8aZKrjiFFNXnnrnQrh5GjLqjYciYq4+oSqEHUUMEz2uaRJuhLasHafeM6ougm7HexHxm3m3iY2EKFDjyDotUKvFg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225327; c=relaxed/simple;
	bh=iJLj11O4g41SPsxiCL9Pj63IUN3VrnEb2c1RDciZciU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhBnQVD8m2RPQObH4uMXmasbkU/pd8fQZaI0rUznu2RNDI01Pwo2Km8b24k06KgoEVYUW+CIUsYeyzm2iK3Dn2BZM8q7VmV8pw5VX5Xi9/YL+//C2p+Za+GVcfX+zSX505jSk4pWPnTiubWFSIuCwGu0B5zmaArCoT58XUHABdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOSSaaia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E05C4CECD;
	Tue, 29 Oct 2024 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730225326;
	bh=iJLj11O4g41SPsxiCL9Pj63IUN3VrnEb2c1RDciZciU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tOSSaaiaWNoPAl+nKlkGkrJBdelh/1LB7gZ1HgrEAnpXCM4BLsnAIX1xrhOymWEp9
	 lddeFvmBx0/JHKOx+ze17PmAYvSBntBmR/0wrwoQ1MOyQZxJTJdMfhBYJjZs3/n8pE
	 nYnI7kHTFSUrtrUM/QYCuNFngoaHDvF+xwdK2xJF5qznxWC756r7fNUW0h9HLJwkT3
	 WHleKVF23wqifyHtVmmVDQDM31QVvG5MwfXSDv7gOGX6Oq9Roku1J6TrPRuLpr4Fi9
	 Bk8DzyvroAlbMLRqsqh5UyU3QRP8pzT3I0GZDivtwZ6YnfG56EnmYe3gOexetahgBx
	 H+DGsGFQB653w==
Date: Tue, 29 Oct 2024 11:08:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241029110845.0f9bb1cc@kernel.org>
In-Reply-To: <f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
References: <cover.1729536776.git.gustavoars@kernel.org>
	<f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
	<20241029065824.670f14fc@kernel.org>
	<f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 10:55:14 -0600 Gustavo A. R. Silva wrote:
> On 29/10/24 07:58, Jakub Kicinski wrote:
> > On Mon, 21 Oct 2024 13:02:27 -0600 Gustavo A. R. Silva wrote:  
> >> @@ -3025,7 +3025,7 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
> >>   {
> >>   	struct bnxt *bp = netdev_priv(dev);
> >>   	struct bnxt_link_info *link_info = &bp->link_info;
> >> -	const struct ethtool_link_settings *base = &lk_ksettings->base;
> >> +	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;  
> > 
> > Please improve the variable ordering while at it. Longest list first,
> > so move the @base definition first.  
> 
> OK. This would end up looking like:
> 
> 	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
> 	struct bnxt *bp = netdev_priv(dev);
> 	struct bnxt_link_info *link_info = &bp->link_info;

Correct, one step at a time.

> >> @@ -62,7 +62,7 @@ static int linkmodes_reply_size(const struct ethnl_req_info *req_base,
> >>   {
> >>   	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
> >>   	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
> >> -	const struct ethtool_link_settings *lsettings = &ksettings->base;
> >> +	const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;  
> > 
> > here it was correct and now its not  
> 
> I don't think you want to change this. `lsettings` is based on `ksettings`. So,
> `ksettings` should go first. The same scenario for the one below.

In which case you need to move the init out of line.

Thanks.

