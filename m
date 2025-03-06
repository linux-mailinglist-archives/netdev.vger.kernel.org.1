Return-Path: <netdev+bounces-172533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8871A5539A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE80E3B4E36
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C383F26AABC;
	Thu,  6 Mar 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihu/8LA1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1626AABF
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283666; cv=none; b=RGjOWKc2AQ6XQBvAGJsAx2aa4SLOp+Etr0NEVUQzzZIco+RCuUFpZSeXcJHulNqeLBAcUHgZdvP1QOTv62t5BoNVyGAq+ZmTQVu1DCQKWfmlgJ89R0nhab5/B3EE4sEdkXgQ2pZupIJTaZmcHq1U4RRctajXTesOQnZ8QIaw4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283666; c=relaxed/simple;
	bh=74me6EBTwxfLa3+N9Qs74EU4Ympvdr8j2NUeivG2w4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtY8PBtR9NRlKDyasX2Mb3jWUOygRpu64d1gqb2co7MfSfsZN25mpktcmpIeoHfoS5tH1dYxnH+8B7XrRiqXpR79p+kCjrgmEisywmpPrcCtkgExb7cdoHRzRxjpPGihQJrcF2hUxl+yfbLm83GLf/lZJwR+IF0v7MwdkPWaFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihu/8LA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E832EC4CEE9;
	Thu,  6 Mar 2025 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283665;
	bh=74me6EBTwxfLa3+N9Qs74EU4Ympvdr8j2NUeivG2w4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ihu/8LA152qMkA5fLli9F7vxQbUZKL0GU7bfqAtsqIRJOdb11Ma3QAY/ROM3+TcWJ
	 WaSFJVj5v3ap1WgS21u7MAWMGNs93R/AiWOnv6E81yU/8hNzwY/GJiSC/SAA8/VuAN
	 1N9zmwtFgp76hterXpooNEAMKAjtQZNFk0UU4jkQ8kFlfvDpTDO+S0kabmvzlqT3CG
	 0wvN55B/TWX1+DxzobwvLiTY4wPB4OHo8FeuQ7YyJcvLydfCpbdgb6m10m2BewnLD6
	 XglD3M0xWj7Ns7vjwoP1vJYgiEhK96RkOk4HWjCQ83S+APuH7xicBQQrAUqyXdfaN5
	 Vi8jKS7p0PPoA==
Date: Thu, 6 Mar 2025 17:54:22 +0000
From: Simon Horman <horms@kernel.org>
To: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor the Tx
 scheduler feature
Message-ID: <20250306175422.GD3666230@kernel.org>
References: <20250226113409.446325-1-mateusz.polchlopek@intel.com>
 <20250303095405.GQ1615191@kernel.org>
 <b5e34397-0b81-4132-86d0-498a111cc363@linux.intel.com>
 <ad9799ed-5313-4787-b982-c8fc82a281a2@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad9799ed-5313-4787-b982-c8fc82a281a2@linux.intel.com>

On Wed, Mar 05, 2025 at 02:30:30PM +0100, Szapar-Mudlaw, Martyna wrote:
> 
> 
> On 3/4/2025 2:43 PM, Szapar-Mudlaw, Martyna wrote:
> > 
> > 
> > On 3/3/2025 10:54 AM, Simon Horman wrote:
> > > On Wed, Feb 26, 2025 at 12:33:56PM +0100, Mateusz Polchlopek wrote:
> > > > Embed ice_get_tx_topo_user_sel() inside the only caller:
> > > > ice_devlink_tx_sched_layers_get().
> > > > Instead of jump from the wrapper to the function that does "get"
> > > > operation
> > > > it does "get" itself.
> > > > 
> > > > Remove unnecessary comment and make usage of str_enabled_disabled()
> > > > in ice_init_tx_topology().
> > > 
> > > Hi Mateusz,
> > > 
> > > These changes seem reasonable to me.
> > > But I wonder if they could be motivated in the commit message.
> > > 
> > > What I mean is, the commit message explains what has been done.
> > > But I think it should explain why it has been done.
> > 
> > Hi Simon,
> > 
> > I'm replying on behalf of Mateusz since he's on leave, and we didn't
> > want to keep this issue waiting too long.
> > Would such extended commit message make sense and address your concerns?
> > 
> > "Simplify the code by eliminating an unnecessary wrapper function.
> > Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper
> > around ice_get_tx_topo_user_sel(), adding no real value but increasing
> > code complexity. Since both functions were only used once, the wrapper
> > was redundant and contributed approximately 20 lines of unnecessary
> > code. By directly calling ice_get_tx_topo_user_sel(), improve
> > readability and reduce function jumps, without altering functionality.
> > Also remove unnecessary comment and make usage of str_enabled_disabled()
> > in ice_init_tx_topology()."
> > 
> > Thank you,
> > Martyna
> 
> Sorry, I caused some confusion in the previous version of proposed commit
> message. Here’s the corrected one:
> 
> "Simplify the code by eliminating an unnecessary wrapper function.
> Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper around
> ice_get_tx_topo_user_sel(), adding no real value but increasing code
> complexity. Since both functions were only used once, the wrapper was
> redundant and contributed approximately 20 lines of unnecessary code. Remove
> ice_get_tx_topo_user_sel() and moves its instructions directly into
> ice_devlink_tx_sched_layers_get(), improving readability and reducing
> function jumps, without altering functionality.
> Also remove unnecessary comment and make usage of str_enabled_disabled() in
> ice_init_tx_topology()."

Yes, thanks :)

