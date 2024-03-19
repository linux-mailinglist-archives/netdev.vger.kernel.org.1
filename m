Return-Path: <netdev+bounces-80566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03987FCFE
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B321F22C71
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647337EEF0;
	Tue, 19 Mar 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzIHfCf/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4453E09
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848213; cv=none; b=ECUgNFlQC0xRfGcAMw88+afSUmocjH4Hg9TYavz+LxqNsoCViUEuUauC7xGDjHrF4kN4x1Y01zJOnI2uCMbuaXG73mSW54IEZpZ0i2lxffta6D8SowZNmMuXbBroNtMQdM0e3LXhQWTxTsbb7Vho7Yebp5rpNs7gQoMSr5GpxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848213; c=relaxed/simple;
	bh=6+wCK+ovT17KkvKndAS+QtxFK5cQkQusDV9tIeTnBSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+yD2l2r7zt1QA2fwMgc6q8/+qg+MtUdYLaRt1rA28+ox7yNE5DuH/H64rY3GB3Mfo7Uk9Lt2JoSL+A52+Z9T5EsBZ9XK19qVYOvoEPSLGK2e6+3riPpuQCyH+mzYFjG2utWOdYszhVoM9OnFHlHVeBqHC+BvI0f8jRf+cGEPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzIHfCf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922E8C433C7;
	Tue, 19 Mar 2024 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848212;
	bh=6+wCK+ovT17KkvKndAS+QtxFK5cQkQusDV9tIeTnBSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzIHfCf/Y3AubpqAhxj3EHKJa3//OTapYMMAZ+DnxzxEay52ewrs0WKIX/yQMtHCS
	 aUZES6NoSJtAn1yVLTp4/YrM53WHuu0nNZ0XN7wabzDT5ykxJP+nfodBv5sPEhsMrF
	 8fIQCgFKiKDPrCgm7CjOWkyfK3/5Lhc/yPhwaIx16yao3q3ut4i5vRZcaETjMhmaLH
	 aT971ZzOccqZ7NnYSE6iv8wblsOet6kR25KyfnIoiWlFieh7LlPysf3yc2/DOxo5O+
	 8hqddHe7qYmoHj1aol10mvA/64TY37Ohw2qfUTcgvcu6Pst1krbJtFMXy3IXOdnFTx
	 pWTWLuA9qL3+Q==
Date: Tue, 19 Mar 2024 11:36:49 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [iwl-net v1 1/2] ice: tc: check src_vsi in case of traffic from
 VF
Message-ID: <20240319113649.GG185808@kernel.org>
References: <20240315110821.511321-1-michal.swiatkowski@linux.intel.com>
 <20240315110821.511321-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315110821.511321-2-michal.swiatkowski@linux.intel.com>

On Fri, Mar 15, 2024 at 12:08:20PM +0100, Michal Swiatkowski wrote:
> In case of traffic going from the VF (so ingress for port representor)
> source VSI should be consider during packet classification. It is
> needed for hardware to not match packets from different ports with
> filters added on other port.
> 
> It is only for "from VF" traffic, because other traffic direction
> doesn't have source VSI.
> 
> Set correct ::src_vsi in rule_info to pass it to the hardware filter.
> 
> For example this rule should drop only ipv4 packets from eth10, not from
> the others VF PRs. It is needed to check source VSI in this case.
> $tc filter add dev eth10 ingress protocol ip flower skip_sw action drop
> 
> Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


