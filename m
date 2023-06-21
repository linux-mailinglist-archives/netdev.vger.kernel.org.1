Return-Path: <netdev+bounces-12774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4543B738E86
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758681C20F6E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263919E66;
	Wed, 21 Jun 2023 18:23:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB619BDA
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 18:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C483C433C0;
	Wed, 21 Jun 2023 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687371834;
	bh=1gohOjV9jG+uRFJl0KlHJXO+OkOch/r4WW/AgrWEW0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJLK+DleCu7MOrVPnzJT3FMFcO5CidXug5Ir3bxe9oQqM4yK/RDQGndxLHysuORdJ
	 iTq5fzmPPCMDO5Irg0abt7VBnqsseI87+jvibfUgNGQX+kYzGu/oT8iHnHJt7Tox6D
	 Zr1/a4IkVviR7q4WRgWLme3ps05HVS/w55RjZw8B4Sx0vJGrzpNnyJYVE+oThIvlIB
	 fedkqVFMD21Z6kRISAinvAGDHq7hl8WUWIFRyQoboYjG4K9cp1P2rgi8tPnhsFWu2W
	 PDeYQ0C8EPLKtIozDf2XdTlFSMoUyvVO83jkGkJX0GFftXhSP03wU1qocahvc8+Usw
	 XBM506dqEfB+g==
Date: Wed, 21 Jun 2023 11:23:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <20230621112353.667a285d@kernel.org>
In-Reply-To: <ZJL3u/6Pg7R2Qy94@nanopsycho>
References: <20230610014254.343576-15-saeed@kernel.org>
	<20230610000123.04c3a32f@kernel.org>
	<ZIVKfT97Ua0Xo93M@x130>
	<20230612105124.44c95b7c@kernel.org>
	<ZIj8d8UhsZI2BPpR@x130>
	<20230613190552.4e0cdbbf@kernel.org>
	<ZIrtHZ2wrb3ZdZcB@nanopsycho>
	<20230615093701.20d0ad1b@kernel.org>
	<ZItMUwiRD8mAmEz1@nanopsycho>
	<20230615123325.421ec9aa@kernel.org>
	<ZJL3u/6Pg7R2Qy94@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 15:14:35 +0200 Jiri Pirko wrote:
>> Did I confuse things even more?  
> 
> No, no confusion. But, the problem with this is that devlink port function set
> active blocks until the activation is done holding the devlink instance
> lock. That prevents other ports from being activated in parallel. From
> driver/FW/HW perspective, we can do that.
> 
> So the question is, how to allow this parallelism?

You seem to be concerned about parallelism, maybe you can share some
details / data / calculations? I don't think that we need to hold 
the instance lock just to get the notification but I'd strongly prefer
not to complicate things until problem actually exists.

The recent problems in the rtnl-lock-less flower implementation made me
very cautious about complicating the stack because someone's FW is slow.

