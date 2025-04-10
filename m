Return-Path: <netdev+bounces-181213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD63A841AC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DE69E4790
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09EE283691;
	Thu, 10 Apr 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObQEx2DO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FEA267F7E;
	Thu, 10 Apr 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284238; cv=none; b=gqH3D38xWeuAb+O4it79PcYoRX2nhZezBx2a1sl7znR7M8V6D3n01O5aoTF1wTGHI/dyyA9kyY9vnE/CLgy289hnRJqpaDAcROR+MROAhVz92XdHuq5pK3L8VQ1+guKIV9jh7XAqHQFc+4WHryzXrTFlwrwZ+Jr3SE10B1fBhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284238; c=relaxed/simple;
	bh=PknozqK0QTn2k3o+Lhfc4fC0nxKDbSSnOTmCnXOnXH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjYiOvixJM8iAUzlczZOVOiKGBJig+XBs9hqUO+kXSFIrZqoDnLT1he933RiakF+u7teH3yTWPofTd3ACWiNQvtanYBWwkCEUyXnzCQ0j7YXagA2uoODCyQsAWt2HrLmB4Oe/BmN+AFHNYYSYMIFzH5HTrWvzXlOEnQLS44qJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObQEx2DO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFA7C4CEEA;
	Thu, 10 Apr 2025 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744284238;
	bh=PknozqK0QTn2k3o+Lhfc4fC0nxKDbSSnOTmCnXOnXH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObQEx2DOUSjDBCjmT86Ayu3EXJCCbxib5UoaWSInHWLgCMWsHihi3YS4zHro79c78
	 vURW2nF2T3EoE/4oLFef1xn9aIq0OFFuF+YXa9JzYhwJPXgua4mby2r916vRBAvNkJ
	 cGzzrxlj93SElFDJ6e1uUf9IVuJpGe32Z6qupCwI08Yy46y5iVUvgtXDtpdwKiRIys
	 GNfPOkPjf5cG1NCWovKsOsWsKyBaABGKQPq34xAnaIckdnuLKGUycHhIMzGbByRMto
	 Ya6F12LmPMrZmqzZtEaXPZYuhwsJUT4kq7rMlnaze+lpf1fqOENvBwDYsK6yLdAEAE
	 9SS3/32amAt6g==
Date: Thu, 10 Apr 2025 14:23:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH iwl-next 05/14] libeth: add control queue support
Message-ID: <20250410112349.GP199604@unreal>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-6-larysa.zaremba@intel.com>
 <20250410082137.GO199604@unreal>
 <Z_ehEXmlEBREQWQM@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ehEXmlEBREQWQM@soc-5CG4396X81.clients.intel.com>

On Thu, Apr 10, 2025 at 12:44:33PM +0200, Larysa Zaremba wrote:
> On Thu, Apr 10, 2025 at 11:21:37AM +0300, Leon Romanovsky wrote:
> > On Tue, Apr 08, 2025 at 02:47:51PM +0200, Larysa Zaremba wrote:
> > > From: Phani R Burra <phani.r.burra@intel.com>
> > > 
> > > Libeth will now support control queue setup and configuration APIs.
> > > These are mainly used for mailbox communication between drivers and
> > > control plane.
> > > 
> > > Make use of the page pool support for managing controlq buffers.
> > 
> > <...>
> > 
> > >  libeth-y			:= rx.o
> > >  
> > > +obj-$(CONFIG_LIBETH_CP)		+= libeth_cp.o
> > > +
> > > +libeth_cp-y			:= controlq.o
> > 
> > So why did you create separate module for it?
> > Now you have pci -> libeth -> libeth_cp -> ixd, with the potential races between ixd and libeth, am I right?
> >
> 
> I am not sure what kind of races do you mean, all libeth modules themselves are 
> stateless and will stay this way [0], all used data is owned by drivers.

Somehow such separation doesn't truly work. There are multiple syzkaller
reports per-cycle where module A tries to access module C, which already
doesn't exist because it was proxied through module B.

> 
> As for the module separation, I think there is no harm in keeping it modular. 

Syzkaller reports disagree with you. 

> We intend to use basic libeth (libeth_rx) in drivers that for sure have no use 
> for libeth_cp. libeth_pci and libeth_cp separation is more arbitral, as we have 
> no plans for now to use them separately.

So let's not over-engineer it.

> 
> Module dependencies are as follows:
> 
> libeth_rx and libeth_pci do not depend on other modules.
> libeth_cp depends on both libeth_rx and libeth_pci.
> idpf directly uses libeth_pci, libeth_rx and libeth_cp.
> ixd directly uses libeth_cp and libeth_pci.

You can do whatever module architecture for netdev devices, but if you
plan to expose it to RDMA devices, I will vote against any deep layered
module architecture for the drivers.

BTW, please add some Intel prefix to the modules names, they shouldn't
be called in generic names like libeth, e.t.c

Thanks

> 
> [0] https://lore.kernel.org/netdev/61bfa880-6a88-4eac-bab7-040bf72a11ef@intel.com/
> 
> > Thanks

