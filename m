Return-Path: <netdev+bounces-188387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50100AACA34
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73ABE1C41B65
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA805283FEE;
	Tue,  6 May 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWwpJ86h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BE283683;
	Tue,  6 May 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546978; cv=none; b=Jv6Q3W+G+1Lah3c85HzcIQk4sI7SiwF1I8CRWIVDIf63+LNGyJjosygWu/1vi/y9OAHHa7AM/D7aa7mbFQHmMx6tGRhmSDicM0egprDd9vFJJKHLDJMQaS1Q8XXAyL6e9+cZiLC7e+4z2dk2sRj7h5RVnY+EpDzkq3Hp0dSDu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546978; c=relaxed/simple;
	bh=2SoxB3NHD8Ps6GC9v+38YxKziXQIx1dUTPfuOnXpEro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCaCRzTSPFOTqe/rII09kaa9ZvbqA/v+C7Kru6KtYr/OGTtKy3owKHvreiNMoiNvpkZWuDqo1+coasEJfitCfQbLlh+51VSCbSujhxCOq5xFVpB9NYvmidhhLBRFN3Qvi28hbEPz74tlyZw6ltp8uNtgAYdLF+d6oC9JfDQI3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWwpJ86h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43272C4CEE4;
	Tue,  6 May 2025 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746546978;
	bh=2SoxB3NHD8Ps6GC9v+38YxKziXQIx1dUTPfuOnXpEro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWwpJ86hlQiUW9zdWW7S6eiNlsvlCwncKV2/DbQ1uoAGG2tdlAq0Rbq/rLNdwdw9n
	 52dvQAhw//fLVprgIfAUlUtB9Dl+PD5262iPHMDc73eQrRHgvTtNyEEtYqNNXebCZK
	 f0MOiYmlKtHbmrSdAsEwTUJvLUOqAeKHD5aEQ/2eem0MGdQwqngcoH34yOKeUYyIvU
	 JVWFm/yZdabAzfF2cOnq0hVdE0VP3rPs1t7AHcDaVXpE1FmGrupKux+iohiJWSdqLN
	 NRw/Yh0WRK681h409b1xZt3qFce/aHyjDM3I3ZGs9b2IufH6whOqV2AuAOZz44uYrN
	 zNoaMKCv8mGHQ==
Date: Tue, 6 May 2025 16:56:10 +0100
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
Message-ID: <20250506155610.GS3339421@horms.kernel.org>
References: <20250424113241.10061-1-larysa.zaremba@intel.com>
 <20250424113241.10061-4-larysa.zaremba@intel.com>
 <20250428165657.GE3339421@horms.kernel.org>
 <aBhhEgEvjjsxtobY@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBhhEgEvjjsxtobY@soc-5CG4396X81.clients.intel.com>

On Mon, May 05, 2025 at 08:56:18AM +0200, Larysa Zaremba wrote:
> On Mon, Apr 28, 2025 at 05:56:57PM +0100, Simon Horman wrote:
> > On Thu, Apr 24, 2025 at 01:32:26PM +0200, Larysa Zaremba wrote:
> > > From: Phani R Burra <phani.r.burra@intel.com>
> > > 
> > > Add memory related support functions for drivers to access MMIO space and
> > > allocate/free dma buffers.
> > > 
> > > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> > > Co-developed-by: Victor Raj <victor.raj@intel.com>
> > > Signed-off-by: Victor Raj <victor.raj@intel.com>
> > > Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > > Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > 
> > ...
> > 
> > > diff --git a/include/linux/intel/libie/pci.h b/include/linux/intel/libie/pci.h
> > 
> > ...
> > 
> > > +#define libie_pci_map_mmio_region(mmio_info, offset, size, ...)	\
> > > +	__libie_pci_map_mmio_region(mmio_info, offset, size,		\
> > > +				     COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> > > +
> > > +#define libie_pci_get_mmio_addr(mmio_info, offset, ...)		\
> > > +	__libie_pci_get_mmio_addr(mmio_info, offset,			\
> > > +				   COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> > 
> > Perhaps I'm missing something terribly obvious.  But it seems to me that
> > both libie_pci_map_mmio_region() and libie_pci_get_mmio_addr() are always
> > called with the same number of arguments in this patchset.
> 
> This is true.
> 
> > And if so,
> > perhaps the va_args handling would be best dropped.
> >
> 
> For now (but this will change), we do not map BAR indexes other than zero, 
> therefore it is the default less-argument variant, this looks nicer than adding 
> ', 0);'. Still, it does not feel right to hardcode the library function to use 
> BAR0 only, hence the variadic macro.

Thanks for the clarification. I would slightly lead towards adding
va_args support when it is needed. But I understand if you want
to stick with the approach that you have taken in this patch.

> 
> > > +
> > > +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> > > +				 resource_size_t offset, resource_size_t size,
> > > +				 int num_args, ...);
> > > +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
> > > +					resource_size_t region_offset,
> > > +					int num_args, ...);
> > > +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info);
> > > +int libie_pci_init_dev(struct pci_dev *pdev);
> > > +void libie_pci_deinit_dev(struct pci_dev *pdev);
> > > +
> > > +#endif /* __LIBIE_PCI_H */
> > > -- 
> > > 2.47.0
> > > 
> > 
> 

