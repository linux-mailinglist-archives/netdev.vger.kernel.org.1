Return-Path: <netdev+bounces-74935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1298676B4
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 14:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03AD1C25169
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9608A12880A;
	Mon, 26 Feb 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT1geo/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EA128818
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954495; cv=none; b=N4xk4HzMOtW7qFzoEaG5aKsSUn93SdftjRjdhfBhuSqmlUSPWyrJIN8N5aDy936T/oPBxCGADJJ0lpknvhbRDtiyiNO2OIWxqbJ8DZbtSVQpuNc+AvHIDaWk7PnROLJ1Teii77M3dVpRbFvGdHrk0CBN+NurwStsICs2FYNkrvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954495; c=relaxed/simple;
	bh=NNQsaKzpuPTzXVbaGA8OwxNsXErOBzvA1/tgnbVup9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpU1JkcTFKFBlcL06+MnuCpyXDlH77BK3Pg1V8LGHlLyQADC7/jCReUHIn4tG9xf11E8CT+B4uZMbhcFK9qJM7ZUKWHlExTT4kgXuFm3Rt6R8JEiQTBfgdF3PX487fcl1S+shU38J3fGV3oN6ZwAgHJcaCsIMsqT+E/BgwAmXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT1geo/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4EBC433C7;
	Mon, 26 Feb 2024 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708954495;
	bh=NNQsaKzpuPTzXVbaGA8OwxNsXErOBzvA1/tgnbVup9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NT1geo/PMk7ZbU4Pf7W4ktRJ5SauGPSC6TDDF48jorGlMiJLT3ReCdX5CXWiUEvWn
	 25343qd64CmECHroGpTeadbwQPOLw0vPBhfKWi/wUhgVRrPgeDP/JBWorXpp/rQVk5
	 qSTNWuaKVqmovkRvZEefb54x5fslXmagrmOHG4kJ6fWU20n+UhO/2HANc+XICX5jV1
	 cpqWjP3OBfJo/zEKeSKDZzjx85BXEZbugofsYaxHrgX83/MVwceKRd5eb+LFJK416T
	 6XeLMsgkiiTMURhaPLQ+Wlxu+RMA54zsY9tIiHdWqiyT8qBqqYFUgG/4GVj4B1I2+e
	 0iC9129MkGHzQ==
Date: Mon, 26 Feb 2024 13:34:48 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@intel.com, sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com, pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [iwl-next v2 1/2] ice: tc: check src_vsi in case of traffic from
 VF
Message-ID: <20240226133448.GD13129@kernel.org>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
 <20240222123956.2393-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222123956.2393-2-michal.swiatkowski@linux.intel.com>

On Thu, Feb 22, 2024 at 01:39:55PM +0100, Michal Swiatkowski wrote:
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
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Hi Michal,

Should this be treated as a fix: have a Fixes tag; be targeted at 'iwl'?

That notwithstanding, this look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

