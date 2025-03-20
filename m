Return-Path: <netdev+bounces-176530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05974A6AAEF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA293B96BA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F21E3DEF;
	Thu, 20 Mar 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR0ISiwA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E31E3DD3;
	Thu, 20 Mar 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487665; cv=none; b=cpYTe0akHx+/30sthR9mmZK0IqbshQLas2ur5LWrQ1RlRXmnxrB/FnBzaNV25gHLtqPGpq1pSkUrAOZQCzDeQNbyQBYW8qdYtskzShRQ/fpIBFdTLSzQzC0IIDbaa0z3KOJw5jn3XKVYM1cg3+3sss4IE9m2d3aW5I6aOU2l2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487665; c=relaxed/simple;
	bh=7i9rmtaPpA46pX+L8EJTadcvZ1WTRJEf3zTx7Hkk6EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkOhCxe5vmYyuZiBqU59r8KKoYe5snRN6A6VDRwctRgOIJURzqLt9acEt+XIeSlAVrXJHgDq+Z48+4WsHcnblWsHsBcXrqTDMFlb5XuumaOKgsnUZ6HpJb6efv96omYdJfjvfPVqiytKaljRLq7AToBrUZfhQfw8RjyaWxtpj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR0ISiwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A0DC4CEDD;
	Thu, 20 Mar 2025 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742487665;
	bh=7i9rmtaPpA46pX+L8EJTadcvZ1WTRJEf3zTx7Hkk6EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mR0ISiwA5H8svSINnZBRYlALikGjp5mkEw100CyQVLOALrgcwyn1I1L+d7I4Y/Cz+
	 I6BDxKdSQIM7PkutX3cb37d8KVP0H+n3wK355w8MpMky1/NxSDb3P625TwVqnAa2sy
	 DosMTQDdGo3G7tpzE6BzTuG/4xi/87xbKEiQ9vmg4U3nNDIwPkPJQvfhNFhFhIB8pZ
	 kinObXvq01GxNE/3I2cvXFzpIbotAAhlv7VOPMvYhm0zNYfHeUW5i+T33115qSkoNm
	 ur19OrpE+IrSv0Dssq+F140JJOibP3acVfYfYwUe+g6QQxm7cxoxrwk1Oo8H1Vvfb5
	 ujfPiQvRyHD2g==
Date: Thu, 20 Mar 2025 16:21:01 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v11 18/23] cxl: allow region creation by type2 drivers
Message-ID: <20250320162101.GB892515@horms.kernel.org>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-19-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310210340.3234884-19-alejandro.lucero-palau@amd.com>

On Mon, Mar 10, 2025 at 09:03:35PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

...

> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoder with reserved DPA capacity

nit: @ways should also be documented here.

     Flagged by W=1 builds.

> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled, int ways)

...

