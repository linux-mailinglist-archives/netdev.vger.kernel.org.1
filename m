Return-Path: <netdev+bounces-180928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B9A8302A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492761B64E82
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708C27817F;
	Wed,  9 Apr 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqsJAkDc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411127781A
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226064; cv=none; b=Z+f/JpkkJ4Iabn2QtGBDgDwVwUSCTXg6HBZM4f5nDoDUOsV3cB+hF/MW9DNTzDVR3TuIkUvrD7RcgatE79zgAwzgcvyfdKse+HJD35jiD5N1a9CsE1PpPfM8+40+x12xa9mvKC5GDsqz2PHTMRFqluQcO3/CGo21Z9lirtZNy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226064; c=relaxed/simple;
	bh=mkegaqk9Qgo7XWvZ8uMZPxdjYbkUplu8dX1c47OLdFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1KVo4aIJ1GpzQTCx2CGJtSS3B9952hqbEK53aDLwYe49mtbErZQg1UuZcsKNspyRrBfci7lTFHq/wMatsemWgI6V7cA5/0a2v6FWIxHfJEze+vSTezDE3JKFzVhoITaV54Kcu8+7uAwtiKafn7J6lh1XZLrGIlHJJk4c2btdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqsJAkDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3BEC4CEE2;
	Wed,  9 Apr 2025 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744226063;
	bh=mkegaqk9Qgo7XWvZ8uMZPxdjYbkUplu8dX1c47OLdFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqsJAkDcbHZUev17YYh5zyDaybb0eJ9DEaogTyAQyMBieBlb3IgCynp5uY7pMelbQ
	 EPodJmkLaB0FMW/sx0bJv4gWpTUHRCrGT2MUkoYZWNWpp5aLHiWY4sULH1YHRM78sI
	 T0BD3Kq92WHo+Z6rF+HiZWapka4RDTyr2UzRb+9eCxSWbYDeD4OKoxTG7z0/WWXpJ1
	 Upb4BjF+6JQDynYZ72WNtcnfzV3CKQl9TckbaqAUX8PTTLS7oDpMi83I7znmhf50vK
	 ecYytzpM/OCQ10nfK/7cUzxMB6qEpdCsL9jUHuaG3mpOSnBICVaZv47Dr/DQEdQCpV
	 XmqwKze6JIy0g==
Date: Wed, 9 Apr 2025 20:14:20 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
	Michal Swiatkowski <michal.swiatkowski@intel.com>
Subject: Re: [PATCH iwl-next] ice: add a separate Rx handler for flow
 director commands
Message-ID: <20250409191420.GR395307@horms.kernel.org>
References: <20250321151357.28540-1-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321151357.28540-1-michal.kubiak@intel.com>

On Fri, Mar 21, 2025 at 04:13:57PM +0100, Michal Kubiak wrote:
> The "ice" driver implementation uses the control VSI to handle
> the flow director configuration for PFs and VFs.
> 
> Unfortunately, although a separate VSI type was created to handle flow
> director queues, the Rx queue handler was shared between the flow
> director and a standard NAPI Rx handler.
> 
> Such a design approach was not very flexible. First, it mixed hotpath
> and slowpath code, blocking their further optimization. It also created
> a huge overkill for the flow director command processing, which is
> descriptor-based only, so there is no need to allocate Rx data buffers.
> 
> For the above reasons, implement a separate Rx handler for the control
> VSI. Also, remove from the NAPI handler the code dedicated to
> configuring the flow director rules on VFs.
> Do not allocate Rx data buffers to the flow director queues because
> their processing is descriptor-based only.
> Finally, allow Rx data queues to be allocated only for VSIs that have
> netdev assigned to them.
> 
> This handler splitting approach is the first step in converting the
> driver to use the Page Pool (which can only be used for data queues).
> 
> Test hints:
>   1. Create a VF for any PF managed by the ice driver.
>   2. In a loop, add and delete flow director rules for the VF, e.g.:
> 
>        for i in {1..128}; do
>            q=$(( i % 16 ))
>            ethtool -N ens802f0v0 flow-type tcp4 dst-port "$i" action "$q"
>        done
> 
>        for i in {0..127}; do
>            ethtool -N ens802f0v0 delete "$i"
>        done
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


