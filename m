Return-Path: <netdev+bounces-32128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8221E792DA4
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3317328112B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B36DDD0;
	Tue,  5 Sep 2023 18:47:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5AD53B
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 18:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF53C433B7;
	Tue,  5 Sep 2023 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693939638;
	bh=vwIhxkPYcjFxPomaJbsoXjAdT/MnM6aW9I1OHi6pZLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O9Kmlsup/bYHoalSyJLkha/3fGRM8P871U5C9UKkJicTtTNb/moOVykas28GO15Ag
	 yp4EQcKG48YxHerTNzQURB+fQFio3/BxwO5AJXas5YtRt2FPjfWLWlmz+yx4wjZqEJ
	 ItZF4ZW7Kjy2yVomZ0nqEgqq+Fu9D/3rL9lGh3btQSN6IHqfiQQRQxq0QkfiPVVKCq
	 2AHtN406YFgcqTy3DIc31q/WoERFGdT0bKE3iZQE3ilQxWgtBHzvpzAmhIcTPLY33b
	 YgpRYJOw73VoQGp9e+6SkRq6yZWW3VT/Xn/DvJW9HBWaTf7+PyBvVMoedq4IYkVRDE
	 gvF88fpX7NHcA==
Date: Tue, 5 Sep 2023 11:47:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 glipus@gmail.com, maxime.chevallier@bootlin.com, vadim.fedorenko@linux.dev,
 gerhard@engleder-embedded.com, thomas.petazzoni@bootlin.com,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH net-next RFC v4 2/5] net: Expose available time stamping
 layers to user space.
Message-ID: <20230905114717.4a166f79@kernel.org>
In-Reply-To: <ZPYYFFxhALYnmXrx@hoboy.vegasvil.org>
References: <20230511210237.nmjmcex47xadx6eo@skbuf>
	<20230511150902.57d9a437@kernel.org>
	<20230511230717.hg7gtrq5ppvuzmcx@skbuf>
	<20230511161625.2e3f0161@kernel.org>
	<20230512102911.qnosuqnzwbmlupg6@skbuf>
	<20230512103852.64fd608b@kernel.org>
	<20230517121925.518473aa@kernel.org>
	<2f89e35e-b1c9-4e08-9f60-73a96cc6e51a@lunn.ch>
	<20230517130706.3432203b@kernel.org>
	<20230904172245.1fa149fd@kmaincent-XPS-13-7390>
	<ZPYYFFxhALYnmXrx@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Sep 2023 10:47:00 -0700 Richard Cochran wrote:
> > > Clock ID is a bit vague too, granted, but in practice clock ID should
> > > correspond to the driver fairly well? My thinking was - use clock ID
> > > to select the (silicon) device, use a different attribute to select 
> > > the stamping point.  
> 
> I've never heard of a device that has different time stamping points.
> If one ever appeared, then it ought to present two interfaces.
> 
> > > IOW try to use the existing attribute before inventing a new one.  
> > 
> > What do you think of using the clock ID to select the timestamp layer, and add
> > a ts_layer field in ts_info that will describe the timestamp layer. This allow
> > to have more information than the vague clock ID. We set it in the driver.
> > With it, we could easily add new layers different than simple mac and phy.
> > I am currently working on this implementation.  
> 
> I think you should model the layers explicitly.

Maybe we should try to enumerate the use cases, I don't remember now
but I think the concern was that there may be multiple PHYs?

(Using [] to denote a single device)

#0    integrated NIC: [DMA MAC PHY]
#1       "Linux" NIC: [DMA MAC][PHY]
#2   DSA switch trap: [DMA MAC][MAC PHY]
#3 DSA switch switch: [PHY MAC  MAC PHY]
#4   DSA distributed: [PHY MAC][MAC PHY]

All these should be fine with netdev + layer, IIUC.

