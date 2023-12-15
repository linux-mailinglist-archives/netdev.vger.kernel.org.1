Return-Path: <netdev+bounces-57913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4718147A9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB559283049
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE3288D5;
	Fri, 15 Dec 2023 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhhcqzWF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D31A705
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBCDC433C7;
	Fri, 15 Dec 2023 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702642029;
	bh=4tWBusSmYJLXRPcmH1m3PdCWbkmgh9r9Ow3XFChuPbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhhcqzWFthAIlZ+JK7dmrjjP06nDzIhoI1jUNBVORrRM2JI2PZEeTMTsG3wzoXl8w
	 DWj1k7093eDUWJZH63j8c+/TRvL0Y0eqrZ1dTkWTRTmgPm92aud0RMCLjaOoVwu9EV
	 6Q4IqXqLXMdYk6Qj79lTb/PeRgJDvZFaPl/AcmAEfpBm87zOYKisQ5udBtZlvLcR6K
	 8bfXuRqVsq1vYlCwXbDX8ufhANUfvdZobkKVGNeSZZfT8HTKLyhGwTFrQzrjda1hg2
	 CeOsZFTo1Cq2dfBmzNDXzQivWIzp3LORgSmfZ+eYalSYrv+gvo+r9ImzSgwtKl/nDf
	 d0BZwNdHPBrxg==
Date: Fri, 15 Dec 2023 12:07:05 +0000
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: alter feature support check for SRIOV
 and LAG
Message-ID: <20231215120705.GI6288@kernel.org>
References: <20231211211928.2261079-1-david.m.ertman@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211211928.2261079-1-david.m.ertman@intel.com>

On Mon, Dec 11, 2023 at 01:19:28PM -0800, Dave Ertman wrote:
> Previously, the ice driver had support for using a hanldler for bonding
> netdev events to ensure that conflicting features were not allowed to be
> activated at the same time.  While this was still in place, additional
> support was added to specifically support SRIOV and LAG together.  These
> both utilized the netdev event handler, but the SRIOV and LAG feature was
> behind a capabilities feature check to make sure the current NVM has
> support.
> 
> The exclusion part of the event handler should be removed since there are
> users who have custom made solutions that depend on the non-exclusion of
> features.
> 
> Wrap the creation/registration and cleanup of the event handler and
> associated structs in the probe flow with a feature check so that the
> only systems that support the full implementation of LAG features will
> initialize support.  This will leave other systems unhindered with
> functionality as it existed before any LAG code was added.
> 
> Fixes: bb52f42acef6 ("ice: Add driver support for firmware changes for LAG")
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Hi Dave,

I'm interpreting this as fixing a regression of an existing feature.
In that context:

Reviewed-by: Simon Horman <horms@kernel.org>

