Return-Path: <netdev+bounces-13468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B9873BB82
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6E1281BA8
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707CAD4F;
	Fri, 23 Jun 2023 15:21:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF9AD4A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC9CC433C8;
	Fri, 23 Jun 2023 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687533669;
	bh=D+wwQ3+bHnykFGVXD+dgrnJVEACzOcRqV/6S0i66dhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FUqWYMwDIq6t9pJ5EOyBrul5YscdOcoX5YbC7VXoWWoMHvxCF1tz8B4x9CSNyhzTe
	 nh03ExC8nq/JoAfZSvgHT7v2V/CCNORq1zmtIgf37rmAvESDqsO9Riu/bnd2lRo8OQ
	 1dgblLAjnPGY7HMBl63VfxOyan9ntXVpfeLyPbw3yUh28ISHGhHOMD2hyJPoxbnj8z
	 vLrdgeVrnmMgrAHvGnJ/wCgaTHY2TfoF7s6DlDXRrQb7NrE/OE/U1pN/YZJKKRsOMJ
	 TocrLCaZ6p5TMnt7ExYxngcTCA8bBty2dE6TYKv2RrFQGZCJezsIa2CSs1Q/HMernj
	 wX6UW0fx81QYQ==
Date: Fri, 23 Jun 2023 08:21:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <20230623082108.7a4973cc@kernel.org>
In-Reply-To: <ZJVlbmR9bJknznPM@nanopsycho>
References: <20230612105124.44c95b7c@kernel.org>
	<ZIj8d8UhsZI2BPpR@x130>
	<20230613190552.4e0cdbbf@kernel.org>
	<ZIrtHZ2wrb3ZdZcB@nanopsycho>
	<20230615093701.20d0ad1b@kernel.org>
	<ZItMUwiRD8mAmEz1@nanopsycho>
	<20230615123325.421ec9aa@kernel.org>
	<ZJL3u/6Pg7R2Qy94@nanopsycho>
	<ZJPsTVKUj/hCUozU@nanopsycho>
	<20230622093523.18993f44@kernel.org>
	<ZJVlbmR9bJknznPM@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 11:27:10 +0200 Jiri Pirko wrote:
> Thu, Jun 22, 2023 at 06:35:23PM CEST, kuba@kernel.org wrote:
> >SG. For the IPU case when spawning from within the IPU can we still
> >figure out what the auxdev id is going to be? If not maybe we should  
> 
> Yeah, the driver is assigning the auxdev id. I'm now trying to figure
> out how to pass that to devlink code/user nicely. The devlink instance
> for the SF does not exist yet, but we know what the handle is going to
> be. Perhaps some sort of place holder instance would do. IDK.
> 
> >add some form of UUID on both the port and the sf devlink instance?  
> 
> What about the MAC?
> 
> $ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 102
> pci/0000:08:00.0/32769: type eth netdev eth8 flavour pcisf controller 0 pfnum 0 sfnum 102 splittable false
>   function:
>     hw_addr 00:00:00:00:00:00 state inactive opstate detached
> $ sudo devlink port function set pci/0000:08:00.0/32769 hw_addr AA:22:33:44:55:66
> $ sudo devlink port function set pci/0000:08:00.0/32769 state active
> $ ip link show eth9
> 15: eth9: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether aa:22:33:44:55:66 brd ff:ff:ff:ff:ff:ff
> 
> There are 2 issues with this:
> 1) If the hw_addr stays zeroed for activation, random MAC is generated
> 2) On the SF side, the MAC is only seen for netdev. That is problematic
>    for SFs without netdev. However, I don't see why we cannot add
>    devlink port attr to expose hw_addr on the SF.

Yeah, the fact that mac add of zero has special meaning could be
problematic. Other vendors may get "inspired" by the legacy SR-IOV
semantics of MAC addr of zero == user can decide, or whatnot.
The value on the port is the admin-set MAC, not the current MAC
of the SF after all, right? Probably best to find another way...

> >Maybe there's already some UUID in the vfio world we can co-opt?  
> 
> Let me check that out.

