Return-Path: <netdev+bounces-172002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A142AA4FD5D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EDE7A8DA9
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262341F7561;
	Wed,  5 Mar 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmjsPKN7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7C2E3377
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173399; cv=none; b=HnOLhDhi8DyvdmGrPijGZdWF5MPKoolIO57N0TNolg+kSmhez4a33ufoCdCI5QqrbDlQiWCYxDRgsvbT/UfTGq0KhQJNl2mi8eA8D717VYEFEOvoLoc+61sRb7vtQy4vRcTEu8rTIoLiS+KFdtdPtFgtP2cqpqLMZdZ8FSjHHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173399; c=relaxed/simple;
	bh=baRZN0nr+QTo0b8GA5u5nvHO938y61aBV3RNzqP/6l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P44Ct16ly67S8Eb3Xu0Xz24cSaCI47vrOmpmF0/bDSzRaxcwlSiWHwNxoDXRHb+Eg2hxUrfpTKIN03CDJHpk4U9ZD14hrO1ZIE47elxjMHY0MXR5Y8LDnLKYqxJkcRCik5HMgNFuDrsuLj6eD5/vYUrcKzoF+uycutnf2CwzzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmjsPKN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D3CC4CEE2;
	Wed,  5 Mar 2025 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741173398;
	bh=baRZN0nr+QTo0b8GA5u5nvHO938y61aBV3RNzqP/6l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmjsPKN7tT8THH1wOV98bi/x7dum6ulkLT7VmXa8w3+UjsMwxf3N/K5M44tvF73nf
	 oQ6+x98m8EoTNw+wozzlNXjBMXZ76umqeRjn7XjxB2qeONbNFogP349tuNP97Aqq11
	 q3QgvXrY36ZU36RNfMt3uVKGjnEAkBZM9o37UfkO7PpHpZsg4FEFEH8F+BfBV/d8YC
	 mdbUsZKx0pzbtThiBkKJSug1QTv2H50qiFpSFXH7vcVFKh405tNTVivCl2OS4V9zr0
	 phyCbzcPGHN+DHntQpyGSbwW0b/jqJ65yfzRtKQWb/PEhp045Wa3bch+RuLm+a2RfG
	 cC0qibdO6roCA==
Date: Wed, 5 Mar 2025 11:16:34 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, andrew@lunn.ch, pmenzel@molgen.mpg.de,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v3 2/4] ixgbe: add support for ACPI WOL for E610
Message-ID: <20250305111634.GK3666230@kernel.org>
References: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
 <20250303120630.226353-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303120630.226353-3-jedrzej.jagielski@intel.com>

On Mon, Mar 03, 2025 at 01:06:28PM +0100, Jedrzej Jagielski wrote:
> Currently only APM (Advanced Power Management) is supported by
> the ixgbe driver. It works for magic packets only, as for different
> sources of wake-up E610 adapter utilizes different feature.
> 
> Add E610 specific implementation of ixgbe_set_wol() callback. When
> any of broadcast/multicast/unicast wake-up is set, disable APM and
> configure ACPI (Advanced Configuration and Power Interface).
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


