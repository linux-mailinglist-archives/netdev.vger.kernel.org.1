Return-Path: <netdev+bounces-167487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814DA3A7BA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7497A2F2C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DA91ACEDA;
	Tue, 18 Feb 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8aHHNkX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75221B9FF
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907410; cv=none; b=KWvKZ84xhC2c7JzzJmnkIz0WGcd4jK6Wg89o/uQ65HnqQfiiYViexnZNLY9OSEJlEAzG399GX/1z4I7QdUBWz3DwyOCJgQd9UF6ZlC81RrFFwKwsW4JtctGCi4Xvmyz+uzqyshDSOjXqrEY52bAQFwYwQ5i8fFauxpq3DqMJ5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907410; c=relaxed/simple;
	bh=oFEhF3wt6ZT0mOj/XPg0GSRReiIjfauwIWnBqH3w9gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GST7J+BsX834ZvGnBw+k78p/3kGo9jhpSrY00iJyI5rvafG4ih0AabiTy4nYvYLc9UKk+MHrLVzBzjSFoU+BxPooyiyFj35N9dA3LK/ZUcf6O/rqn5hczCf1k2YHFCvw9AX0H7MGmQmZrRTMOGVS8sVvXE/aU04yRbsG7AsYJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8aHHNkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F99BC4CEE2;
	Tue, 18 Feb 2025 19:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739907410;
	bh=oFEhF3wt6ZT0mOj/XPg0GSRReiIjfauwIWnBqH3w9gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8aHHNkXHR5wL11T2YB2E2oCvm87h9wv5eBQhqj8lccbzt4iG8/J8t+bsivhqTksL
	 FzUqLxL9vmGymo4EJlKB0ZsdbgL4lA7hebhGmgvwiinvhnkwYcx/0CHJqV1A8LgcH5
	 1m/uLWQ9QMyiK1IbTK5+X0Q2ioK9TZhNPb5AM7zORNT4Ulk8h4cgSJd4sqPp3hvnUz
	 YAEXmC/d+K5LC3T9td+TbrCWK87ssGvmYvM7Zb4to+DJtreh24r79zdC/NmQQs0VTS
	 LSKVYHaeHaIsOsF7sF7aBPNe5D/38J9I+FLvyWxbdhrlMmbufFcToZMAGDaGK+HEwg
	 WdeyUdHP7Pcsw==
Date: Tue, 18 Feb 2025 19:36:46 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com,
	pmenzel@molgen.mpg.de
Subject: Re: [iwl-next v3 3/4] ixgbe: add Tx hang detection unhandled MDD
Message-ID: <20250218193646.GJ1615191@kernel.org>
References: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
 <20250217090636.25113-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217090636.25113-4-michal.swiatkowski@linux.intel.com>

On Mon, Feb 17, 2025 at 10:06:35AM +0100, Michal Swiatkowski wrote:
> From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> 
> Add Tx Hang detection due to an unhandled MDD Event.
> 
> Previously, a malicious VF could disable the entire port causing
> TX to hang on the E610 card.
> Those events that caused PF to freeze were not detected
> as an MDD event and usually required a Tx Hang watchdog timer
> to catch the suspension, and perform a physical function reset.
> 
> Implement flows in the affected PF driver in such a way to check
> the cause of the hang, detect it as an MDD event and log an
> entry of the malicious VF that caused the Hang.
> 
> The PF blocks the malicious VF, if it continues to be the source
> of several MDD events.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


