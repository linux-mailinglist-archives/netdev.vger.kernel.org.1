Return-Path: <netdev+bounces-89630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDA8AAFB1
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250DCB247EB
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433F712A160;
	Fri, 19 Apr 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlqYc11H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E885938
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534496; cv=none; b=DHQrKEn3V/FuoLprjN6jd0+5xozGu+wkwtHy2cEqImfJd9AlFb2uOEYFbhGRrd3QKn6oQ/d+qlnMFC4bjglXBRIx8T2pSm0+Ku4NS4lMriSdFvl7bHi8YF7ZFCilYr+w6LqzxFVeYWoYxbL+3OdXtXIw05ObovaCNJO0Z6lNRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534496; c=relaxed/simple;
	bh=fNsZJjVS5QYarskYSPuKy5dAdN/RZT7vgDlQIYeswyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2WYsXGyUksBpSgXEXcIT4rX1wT7vXTUm2SqiOhUJ9Z2C6mIMD24hfwngi5q61qYcOwTBvdg0YB7k70o+eEXNl2E+Vmen8z1WLHMfYwuys8G0RN+nvQ9o7ztBSEDntb+XLtyAFQhhUj679umUMgmcGzSC+naVUrqVzV47q4J7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlqYc11H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6328DC072AA;
	Fri, 19 Apr 2024 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713534495;
	bh=fNsZJjVS5QYarskYSPuKy5dAdN/RZT7vgDlQIYeswyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlqYc11HaF35FI6A/Yu+YDMnoN7QMK0IDcQhuKPxsMHgL1LXQXSalCkZBTNTXJINt
	 gvqbgPK+hpzDAPeLIQs2b3ns6sTqZHMzGfyRWlLMuKpHT0PkxaX13FH0SEunMYImAV
	 1usBJCnNd9E63eDEYypQx6YXsnWqTxvJpBtg7RXjgxH02rW71/15a/cJ1DTW/KV61w
	 62paT6Q+0l39s/aaAjtXrDs8Z9aKMLS3FUofGsCUMs2Zv/zvg1/rztkL+7QZJEfWI1
	 DLvozdbFvE70j6eG6eJU2uj7tPH7VI9arv+hV0w5B80FeahkC+cie7KiuyV8ZjbLP1
	 AI7cXN/wKcX+Q==
Date: Fri, 19 Apr 2024 14:48:11 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v4] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <20240419134811.GC3975545@kernel.org>
References: <20240419-bond-oob-v4-1-69dd1a66db20@kernel.org>
 <ZiJpfZQb_yA936Wh@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiJpfZQb_yA936Wh@Laptop-X1>

On Fri, Apr 19, 2024 at 08:54:21PM +0800, Hangbin Liu wrote:
> On Fri, Apr 19, 2024 at 12:08:25PM +0100, 'Simon Horman' wrote:

...

> > diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> > index 0cacd7027e35..64a06e3399ee 100644
> > --- a/drivers/net/bonding/bond_options.c
> > +++ b/drivers/net/bonding/bond_options.c
> > @@ -1214,9 +1214,9 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
> >  	__be32 target;
> >  
> >  	if (newval->string) {
> > -		if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
> > -			netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
> > -				   &target);
> > +		if (!(strlen(newval->string)) ||
> > +		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
> > +			netdev_err(bond->dev, "invalid ARP target I4 specified\n");
> 
> Hi Simon, the error message should be "invalid ARP target specified\n"

Thanks,

I'll send an update after waiting a suitable time for review.

--- 
pw-bot: changes-requested

