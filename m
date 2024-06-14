Return-Path: <netdev+bounces-103593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBF908C0A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC7E1C22370
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5DC1991B9;
	Fri, 14 Jun 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJskuzA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1F195F1D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369291; cv=none; b=ko/LBvd8n5BOfELQSLbvA0aByIZeqns3q331Rd83TAbczg/hOSimY5EcLkeHJiFnCYQKNVGfo/oO0+CfjhPRvAHzzNqdFDttO/CkrrKxW1e/2ZUKIJS6qPFtVBusjIdF1W4odNxARGQIPNYC1u7WqlUXt5VKrip9WPoCvjZPs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369291; c=relaxed/simple;
	bh=VmOYk6Qu9NWootxGXFwe8WoslXB6Nq+KnkrS82ihHfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRk3pMjvFchhnk89JC3hQOygbXjvBS1iQVd1cnI4p949Ze5QeKkwhE9jIA9xJOoNi6taZGkV/TSWe98YCsao9iPpM0bH5JYCCYzrDSVsGQOU9SmGgdeunan8SKc/uXBDfpvItWWE3TISHSy+W53/s4lyoxlcWE0wxtgd+Rp+gXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJskuzA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F07C2BD10;
	Fri, 14 Jun 2024 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718369290;
	bh=VmOYk6Qu9NWootxGXFwe8WoslXB6Nq+KnkrS82ihHfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJskuzA8Aj2eNhmbhOyqZcHXBUEWFN+Q0OgOGrtlhMtE0n01rvTsJ0XfZVsUvSxmy
	 +dnpPZrXhh/tKzCrpZPaXMsSEm1Ak9yrbxiIlqd3ZYzdaiCI2oqtkO18PBeaC88epa
	 gZDZZ3zf3AdE9PeWeigAyGTo7PyoWqYKCnfPQlbiXiRmmdcg+vp0BNUErIlL83scY0
	 /efr4RVgPEUfoebq9CCRSD/lqnAoR7LT+Ir1KsUuMxKMAps8KVHIpf1IoTO3uL56ru
	 tQFg6WZ0mDCbR0+2Db3Mu8fccTjj07erGQLBTNatys0bvfawg9tVBcG9eV8AjkV0ED
	 gttLu8t81cv0Q==
Date: Fri, 14 Jun 2024 13:48:06 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com, kuba@kernel.org
Subject: Re: [iwl-next v3 2/4] ice: move devlink locking outside the port
 creation
Message-ID: <20240614124806.GO8447@kernel.org>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
 <20240610074434.1962735-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610074434.1962735-3-michal.swiatkowski@linux.intel.com>

On Mon, Jun 10, 2024 at 09:44:32AM +0200, Michal Swiatkowski wrote:
> In case of subfunction lock will be taken for whole port creation and
> removing. Do the same in VF case.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


