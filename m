Return-Path: <netdev+bounces-163964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E842DA2C314
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18859188389A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F51DFE04;
	Fri,  7 Feb 2025 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdyeLAvr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249E944E;
	Fri,  7 Feb 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932747; cv=none; b=AU+pcFN5vsOq4I8PHu5WOOJhSYfHaVYIOPtnw6Yx8pMKpwcc7mYAQHyLuMgZJIrD8fWee/aKHQ1HUJGoIeCd+YWZdWILdxafCg0zCBQvVMAwKXbfslaoBNgV9kpS6bocXf+x2NYoO1be3o3gHBAWrxGAx17/t9buJiK4/fJGytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932747; c=relaxed/simple;
	bh=k9oWtPJpZNtCX90rrpLJ6o6Dh2QeZ3JLruW8K4A1dG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYET1osmyw2AONptUIjoF+lajOkaZ8uDEoMzyc4OkMlfqry04pzovS1t9g/UMRBOZ3nb3ob3e+vBtMZToO5DCR9fuQsgkuX7xmd1TV7oSd/STxb6htXaLSCuK+9g4L2Gv/IaDQpw8cLjuigy6AULAP80Wmkl34JOpwZrdRTdmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdyeLAvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5591FC4CED1;
	Fri,  7 Feb 2025 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738932747;
	bh=k9oWtPJpZNtCX90rrpLJ6o6Dh2QeZ3JLruW8K4A1dG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdyeLAvr8C3jrOW6uAgTF3pFY4Vf0dnWGUNrrIuZ2kSPMe5UQb05fSAbdijedBEb3
	 Vq7ZpjaaHW78JtP58dIIN+O1QTMXFWKg2m1j5120KwQQhb7MjggUOfJqUGpeJ03iHk
	 HG3e+1806tCJ4Pa9RRp92POP8RGiKItJ71fu8UEUI+WQPDIcU8cmbGGfOXFAS4cBai
	 jgJZQzCYss9d54QFKJZYoC3dtYHoH25b2vCq9MpkjzbS0/pW3BTOCNAl08II/OLv1+
	 29d5iNi2Qf/Naii44xx6yJwMYbPT/cV7MschlSGJuw6BQ4+4ssqzxsMQsMP/Nae0fi
	 r/AACn614v+ww==
Date: Fri, 7 Feb 2025 12:52:23 +0000
From: Simon Horman <horms@kernel.org>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 04/26] cxl: move register/capability check to driver
Message-ID: <20250207125223.GQ554665@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-5-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-5-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:28PM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 has some mandatory capabilities which are optional for Type2.
> 
> In order to support same register/capability discovery code for both
> types, avoid any assumption about what capabilities should be there, and
> export the capabilities found for the caller doing the capabilities
> check based on the expected ones.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

...

> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c

...

> @@ -117,7 +124,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
>   * Probe for device register information and return it in map object.
>   */
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map)
> +			   struct cxl_device_reg_map *map, unsigned long *caps)

nit: The Kernel doc for cxl_probe_device_regs() should also be updated
     to document caps.

...

