Return-Path: <netdev+bounces-117055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C92094C89D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5511F23CDC
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD4D17996;
	Fri,  9 Aug 2024 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaG2ovmD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF912B73
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723171312; cv=none; b=RqfpGqsuYzJ3Wqo4TXixrn3Ydg5ELZ1pmteMX+h2j3pqmG8o6/hAFdPQo6/OkZipDtKzDdbLFmhXbs4kbeWdpe3Y/LejZENkNau5/f3/XXd1Lw9GzvkVytz1DWoynSeesq6mAHLBzhSdoO0VdzItnIkapTWXGyxcxpeyvSfsdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723171312; c=relaxed/simple;
	bh=HquVFU/wLFDUON3I1WCCx03bOA3hog3bFezWra2DzmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gc6hb7V2WowIZlU+1jfRUIaalgUYoZw76jnTAVwdmaNsTmJpalj1+09YV0ye3bjnqgVp29l3XP/xeaKC2oEIeqPenmuBTVdQrnG7z1AWs+VgFOcRGpp8V0uxVE57Ng7/5xy9hXd3U11xMEK/OAQTaWVaFKdfYX+bSQAlQQkepj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaG2ovmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADA8C32782;
	Fri,  9 Aug 2024 02:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723171312;
	bh=HquVFU/wLFDUON3I1WCCx03bOA3hog3bFezWra2DzmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uaG2ovmDQIgU5LQbd9gg7rTvs437hZ2VjKNMblQSfjJof3ZMMyugjqNmL6lOE6OZP
	 yQfKZ9F/d6hFCaSoJVEDlu1EJu3LVkX3sNuypvItwT7V7azBLXGFH5VA6a/uibQYmy
	 3XfiZViN2MiYWFIckaC0V9S2mSrk/tlrlDOuIwEjLX2gcJCjdWzTeqCo3JRDbamc2Z
	 0ZLh7ak3po4xI18AMaw8QyT80tiBmkxM2GUt29F+/RhLF4ZzPPgjgLUec5x0b2wE2m
	 F54pnqBttZuD4AJdW+DaLcYvk4dy5Y0hgKeanUpaRXqjRpQ/cdKj8Y6LqU7TXH16BR
	 9YSvdEcq1Q8nA==
Date: Thu, 8 Aug 2024 19:41:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, Wojciech Drewek
 <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next 4/5] devlink: embed driver's priv data callback
 param into devlink_resource
Message-ID: <20240808194150.1ac32478@kernel.org>
In-Reply-To: <ZrMZFWvo20hn49He@nanopsycho.orion>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
	<20240806143307.14839-5-przemyslaw.kitszel@intel.com>
	<ZrMZFWvo20hn49He@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 08:49:57 +0200 Jiri Pirko wrote:
> > 	lockdep_assert_held(&devlink->lock);
> > 
> > 	resource = devlink_resource_find(devlink, NULL, resource_id);
> >-	if (WARN_ON(!resource))
> >+	if (WARN_ON(!resource || occ_priv_size > resource->priv_size))  
> 
> Very odd. You allocate a mem in devl_resource_register() and here you
> copy data to it. Why the void pointer is not enough for you? You can
> easily alloc struct in the driver and pass a pointer to it.
> 
> This is quite weird. Please don't.

The patch is a bit of a half measure, true.

Could you shed more light on the design choices for the resource API,
tho? Why the tying of objects by driver-defined IDs? It looks like 
the callback for getting resources occupancy is "added" later once 
the resource is registered? Is this some legacy of the old locking
scheme? It's quite unusual.

