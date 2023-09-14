Return-Path: <netdev+bounces-33834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F33A7A06BD
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB347281B10
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8897F224EE;
	Thu, 14 Sep 2023 13:57:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC691FA4
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80340C433C8;
	Thu, 14 Sep 2023 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694699877;
	bh=iougeaANvMtmhq9yHCMyazdxrEHMJx4Dbqd9TxO0SEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1v7OkYbw2tsUl4FkEsHPUAao1C7djxSBryOaucncV7pk8Yi1BNBtrc6KqNJa6/Kj
	 pGhth1x7MJwDkVod6+BuAjkyQNBcqCw3TrVdC0xkb6LawjopbU4cSMw7QqWwB3BCEZ
	 92XYQskxcQYwXPTfcgHL1CEeEod9Xh3eK9lbqoLOTSdb7rYvWr97OsrkI0heG7xkCx
	 smLzUWvQPvshU4YkJFCyRuB2mEWwdPNCTO17Ln/UGkPy4vgKTKUg+9s4mpnn44TDEZ
	 dRwMYkaFIUjt9a4zD6SDcvskn2TFOwSyEOwkpSM5QMJSBORFO1Ilgllh40jA2pmey+
	 cLIpY5FOJl7IA==
Date: Thu, 14 Sep 2023 15:57:52 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, idosch@nvidia.com,
	petrm@nvidia.com, jacob.e.keller@intel.com, moshe@nvidia.com,
	shayd@nvidia.com, saeedm@nvidia.com
Subject: Re: [patch net-next v2 00/12] expose devlink instances relationships
Message-ID: <20230914135752.GB401982@kernel.org>
References: <20230913071243.930265-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913071243.930265-1-jiri@resnulli.us>

On Wed, Sep 13, 2023 at 09:12:31AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently, the user can instantiate new SF using "devlink port add"
> command. That creates an E-switch representor devlink port.
> 
> When user activates this SF, there is an auxiliary device created and
> probed for it which leads to SF devlink instance creation.
> 
> There is 1:1 relationship between E-switch representor devlink port and
> the SF auxiliary device devlink instance.
> 
> Also, for example in mlx5, one devlink instance is created for
> PCI device and one is created for an auxiliary device that represents
> the uplink port. The relation between these is invisible to the user.
> 
> Patches #1-#3 and #5 are small preparations.
> 
> Patch #4 adds netnsid attribute for nested devlink if that in a
> different namespace.
> 
> Patch #5 is the main one in this set, introduces the relationship
> tracking infrastructure later on used to track SFs, linecards and
> devlink instance relationships with nested devlink instances.
> 
> Expose the relation to the user by introducing new netlink attribute
> DEVLINK_PORT_FN_ATTR_DEVLINK which contains the devlink instance related
> to devlink port function. This is done by patch #8.
> Patch #9 implements this in mlx5 driver.
> 
> Patch #10 converts the linecard nested devlink handling to the newly
> introduced rel infrastructure.
> 
> Patch #11 benefits from the rel infra and introduces possiblitily to
> have relation between devlink instances.
> Patch #12 implements this in mlx5 driver.
> 
> Examples:
> $ devlink dev
> pci/0000:08:00.0: nested_devlink auxiliary/mlx5_core.eth.0
> pci/0000:08:00.1: nested_devlink auxiliary/mlx5_core.eth.1
> auxiliary/mlx5_core.eth.1
> auxiliary/mlx5_core.eth.0
> 
> $ devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 106
> pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
>   function:
>     hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
> $ devlink port function set pci/0000:08:00.0/32768 state active
> $ devlink port show pci/0000:08:00.0/32768
> pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
>   function:
>     hw_addr 00:00:00:00:00:00 state active opstate attached roce enable nested_devlink auxiliary/mlx5_core.sf.2
> 
> # devlink dev reload auxiliary/mlx5_core.sf.2 netns ns1
> $ devlink port show pci/0000:08:00.0/32768
> pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
>   function:
>     hw_addr 00:00:00:00:00:00 state active opstate attached roce enable nested_devlink auxiliary/mlx5_core.sf.2 nested_devlink_netns ns1
> 
> Jiri Pirko (12):
>   devlink: move linecard struct into linecard.c
>   net/mlx5: Disable eswitch as the first thing in mlx5_unload()
>   net/mlx5: Lift reload limitation when SFs are present
>   devlink: put netnsid to nested handle
>   devlink: move devlink_nl_put_nested_handle() into netlink.c
>   devlink: extend devlink_nl_put_nested_handle() with attrtype arg
>   devlink: introduce object and nested devlink relationship infra
>   devlink: expose peer SF devlink instance
>   net/mlx5: SF, Implement peer devlink set for SF representor devlink
>     port
>   devlink: convert linecard nested devlink to new rel infrastructure
>   devlink: introduce possibility to expose info about nested devlinks
>   net/mlx5e: Set en auxiliary devlink instance as nested

Reviewed-by: Simon Horman <horms@kernel.org>


