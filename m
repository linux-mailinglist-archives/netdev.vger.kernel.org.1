Return-Path: <netdev+bounces-99800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1418D68CB
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283C31C2309E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32D17CA1E;
	Fri, 31 May 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VesrkjJv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6E7CF25
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179323; cv=none; b=fRb5P5C81eDivvfwk7tJlB1lxEYIDkwDK9VK0Vw+2pHLyJw+Zc8GrlPyyWbXmQ+7D+8YYlLXU8VKo8VJZYiXmREvhRDXedHdvHMMmo9kvwhxKpxk1AGnbxgMiBjV3qyXi0we83bW8ZKqxWz6KeVtcWwgMLAyb7Znmx+tn9qF82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179323; c=relaxed/simple;
	bh=Wqf/4nMRINsqR/TmXLZx/sDAoqGQhcSMG3F2Th/6ffU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu7AcypW6CLGe0zwAlboh6HUGUZThOjgK59in9vLP8nh81N7qojAmrmNm72kQAIVcnD2UN+6TcBVTNmYEHL54qylNEKqmkhbr+FREBUdYRsIqsQFjKD+/CuhEz0HrfFseRg8rLz2pmSqZXFzsxCKc3NqppAFUL13JV0ZwmENbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VesrkjJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E06C116B1;
	Fri, 31 May 2024 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179323;
	bh=Wqf/4nMRINsqR/TmXLZx/sDAoqGQhcSMG3F2Th/6ffU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VesrkjJv6up1diwqXuGtbYujr0cqQ07UxSj8iPxgUp6nKGcVSyQK1x6q6bOr6hp8K
	 ASQoIP6fkAzBXFwkHysbiQe7YgMm0sZMlxy5cCUkqpwA5SJ25KPlWRJ1fwUZ4rSImJ
	 dDGS6oMkPXA/1b07Ibpjq/JsvHk+52Ofthn9Fvfr9pBz03QLZhQ61W6FTlXbse8Uxh
	 rxMhGCVTBM15edO3d13YwDZOeREOnHXlvRIasrcv3reJuUL1z59kVH4Y6u1UGDJs+/
	 mWDGWiUPp3PC+D0C2bPpUbyjEEWAVUD0VJDTdgT+HB+xFf0kkugMEMMCvsS7LxUAA9
	 qzqTK9rXXwbhA==
Date: Fri, 31 May 2024 19:15:17 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 04/15] ice: treat subfunction VSI the same as PF VSI
Message-ID: <20240531181517.GH491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-5-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-5-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:02AM +0200, Michal Swiatkowski wrote:
> When subfunction VSI is open the same code as for PF VSI should be
> executed. Also when up is complete. Reflect that in code by adding
> subfunction VSI to consideration.
> 
> In case of stopping, PF doesn't have additional tasks, so the same
> is with subfunction VSI.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


