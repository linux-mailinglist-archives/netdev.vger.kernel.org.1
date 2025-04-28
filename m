Return-Path: <netdev+bounces-186492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B85A9F650
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA1F1896D1E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143682820A5;
	Mon, 28 Apr 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME35vYQ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38A27FD7E;
	Mon, 28 Apr 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859426; cv=none; b=uXQFJ9D+ABfLNngGmud6xFyBkPsd/flFZpZc4kI5haK7Jx2eM+97Ei+MeUX3gf3jyb/M5iY3dLi55hLdgBXs2DcxuN6TUOZ4HswpUbx78WN6t9V1SmvLykDcQOEvLFVc0e5y4C6ZEI+cz+l0XtjPeC6tfIMH7s/19mXsoldYpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859426; c=relaxed/simple;
	bh=ZVz/phxXgV/uhXfx52GtvXgEsnsHvFfAcq8ln7+IPzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfXceUkQInGlwTqsFRwyKFvbpPpJUxfHCZOT6+HxIxy/BYavCDNF/2BuarVae+uLXMmA4OaWn/J9Yu9Bb5kyqS+5SAvosDzxMvywqeN7HGZIka2+M1ufO1hXP8PC7gNFedZds1FwbegysYUo2jjiGDJtSYJZKDT6MVShCZX7DkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME35vYQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8016C4CEE4;
	Mon, 28 Apr 2025 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745859425;
	bh=ZVz/phxXgV/uhXfx52GtvXgEsnsHvFfAcq8ln7+IPzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME35vYQ/VH0HQptcDvrpE5BVTSCvw+KZks+EMhweVEEGIR1r0Tk1DP1ZV3cw8N9mt
	 EpiCGCFNCTVbHLiwxmsXneao9mB2mpkc0BHHj9dQqu+2bgcA9EPEucL+UeuNx16TfE
	 v8/fFCEmQv9z1nE3t1srwRIxY4x0xBx6fYbE2P38P5Wx1RLCQszj9yM7hGsxCp+Y8X
	 9nfqGizpRaEp/Ozg3P2UOtl9YfOMFjoT3ibjjJQEnPZTGftRP9P8rzWwTY1Cp02UW/
	 IaqfKADAPkkKkFJDHCqzcAXRFCxXp7Yfb7el6rHaBRFV9Lf1Z/Nt+9sM5qTLmzvLJC
	 HBlO8v32Kit5Q==
Date: Mon, 28 Apr 2025 17:56:57 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Phani R Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH iwl-next v2 03/14] libie: add PCI device initialization
 helpers to libie
Message-ID: <20250428165657.GE3339421@horms.kernel.org>
References: <20250424113241.10061-1-larysa.zaremba@intel.com>
 <20250424113241.10061-4-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424113241.10061-4-larysa.zaremba@intel.com>

On Thu, Apr 24, 2025 at 01:32:26PM +0200, Larysa Zaremba wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> Add memory related support functions for drivers to access MMIO space and
> allocate/free dma buffers.
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

...

> diff --git a/include/linux/intel/libie/pci.h b/include/linux/intel/libie/pci.h

...

> +#define libie_pci_map_mmio_region(mmio_info, offset, size, ...)	\
> +	__libie_pci_map_mmio_region(mmio_info, offset, size,		\
> +				     COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> +
> +#define libie_pci_get_mmio_addr(mmio_info, offset, ...)		\
> +	__libie_pci_get_mmio_addr(mmio_info, offset,			\
> +				   COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)

Perhaps I'm missing something terribly obvious.  But it seems to me that
both libie_pci_map_mmio_region() and libie_pci_get_mmio_addr() are always
called with the same number of arguments in this patchset. And if so,
perhaps the va_args handling would be best dropped.

> +
> +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> +				 resource_size_t offset, resource_size_t size,
> +				 int num_args, ...);
> +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
> +					resource_size_t region_offset,
> +					int num_args, ...);
> +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info);
> +int libie_pci_init_dev(struct pci_dev *pdev);
> +void libie_pci_deinit_dev(struct pci_dev *pdev);
> +
> +#endif /* __LIBIE_PCI_H */
> -- 
> 2.47.0
> 

