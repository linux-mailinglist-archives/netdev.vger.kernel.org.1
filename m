Return-Path: <netdev+bounces-108103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C591DD6E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6157DB20462
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27284DE9;
	Mon,  1 Jul 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzPW+pHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A2537E7
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831898; cv=none; b=Q52u1/C9U6ZLNkS3K6I5+YkP5DS7X6EAcx9hXjE8nRadr7/lC3KeL6/GyuEj6kSdM5FImQ3XNuJ+Hg/ewUg8VcVmLBr+swTTFLPdXc3hEQ3fp2HccVBrhEzaM9htTEs0m/4IUxUumNxBFKSJupAKBPARiG5yHr9XjJ8IMJoF37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831898; c=relaxed/simple;
	bh=Tdu35zkCaj9dNT3Y2EyFcFFG7H5luFNq1c0E1jFjfz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI5AT4+QhDOQvKB7Cjz4+Ir4eBfq19s5rAnSKkU19QTcL/LmXta1CqiBd8HufUQb05M6JLFgH/wX3d6FbrzKk85EsopcbA1AmeoibVAHWvV5rLuS/rgtOLJxgQ/ajl9o3/jW/92CDTGTP8H+lGQRoUCa3N0qFhKfaB4cPT2L/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzPW+pHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9ECC116B1;
	Mon,  1 Jul 2024 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719831897;
	bh=Tdu35zkCaj9dNT3Y2EyFcFFG7H5luFNq1c0E1jFjfz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzPW+pHsNQp8Bth8QFvod4emnGot+0hwXOpFVwZvJc7p4SC09ZISmjCbeWwv2qobj
	 YOXs1RHdbidVhKVjW/5Z0SX0hxD1Vze/U/rbyQSGxN88p2RW9MoAFr5CHPgUe1z41H
	 WF2uzTFo9crnSq5TKzsYevnZ1Hx4q9w6fM7iLffdxXmzHHWlNnIJCmqfrdMA4lTGdc
	 EIn5GZiHJA6jlOd7AFEUAbN0wQOujYDr5AaZJzdTT0SoXjtKvb21KGEAA1yXK1m/+B
	 nAn2owQlkTAPLwSn7Go5S0wk5h2DYssQcnU13FxwgwvCG1jcgPP0j0IFT2Uq3qHOYO
	 8tXaPM/dLLJfA==
Date: Mon, 1 Jul 2024 12:04:54 +0100
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Dima Ruinskiy <dima.ruinskiy@intel.com>, sasha.neftin@intel.com,
	Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: Re: [PATCH net] e1000e: Fix S0ix residency on corporate systems
Message-ID: <20240701110454.GW17134@kernel.org>
References: <20240628201754.2744221-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628201754.2744221-1-anthony.l.nguyen@intel.com>

On Fri, Jun 28, 2024 at 01:17:53PM -0700, Tony Nguyen wrote:
> From: Dima Ruinskiy <dima.ruinskiy@intel.com>
> 
> On vPro systems, the configuration of the I219-LM to achieve power
> gating and S0ix residency is split between the driver and the CSME FW.
> It was discovered that in some scenarios, where the network cable is
> connected and then disconnected, S0ix residency is not always reached.
> This was root-caused to a subset of I219-LM register writes that are not
> performed by the CSME FW. Therefore, the driver should perform these
> register writes on corporate setups, regardless of the CSME FW state.
> 
> This was discovered on Meteor Lake systems; however it is likely to
> appear on other platforms as well.
> 
> Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218589
> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


