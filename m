Return-Path: <netdev+bounces-181300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8AFA8453D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D34A18860E9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191AA28A3F2;
	Thu, 10 Apr 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWFnvSEr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA212857FA;
	Thu, 10 Apr 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292691; cv=none; b=gsXWqdWBDD1u+QDa/7UwbC+LZq6oj9Jf/PifRpubRfgIBzx0Uub7OeeURi+4EnVXcir/yHwS+JUDIGMXJq9jsdSZ+fh2r7tXdtWOHSMM2KzfAAHzp4Cuk1cXS71iwvuOPGCO451grG0QvdPlEVGNgmOf/Tio9rfeHJf1gD07xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292691; c=relaxed/simple;
	bh=zIuv99jR6/DvhIj/ezFd7gDXDCcqNb+1BR6FZTmkWrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaLPSk4WfSpZ4yvNBThlrE3Md7vZH1X3QchXS4mvpbSwS8riXxEfvO7JnI3yCsUBFbvIbBIcP/GBNU5Upqh5PBMC4CVwqcBS5mD54ye60mX4Pjz+CDsV2ZJEV5xpV8seVHuElfaJhjf6jFp73qZ4pjIQ5QobEPJ5uthTXIvTWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWFnvSEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C278C4CEE9;
	Thu, 10 Apr 2025 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744292690;
	bh=zIuv99jR6/DvhIj/ezFd7gDXDCcqNb+1BR6FZTmkWrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWFnvSErJGHoAFL49fO2hww9SHO0/RHs5AH/HqVziawMjh9vkYSNexmYM9V1qao//
	 Uh5m0IBGBkSMOyIl6LkSlHlAzZ8YKtLENE/p8M8TUsEKyGyM9YU4yx4VNGvR+vZpeJ
	 myK2knY44CdZhmM1cF4cFbU8prSB9k9gCLko941gW1mDLOBdONOpcnJXQkkw0Nuzng
	 SOBwpUziCkn/UNnqzHR0tQdkzSkfGkkBfztnfEcXBSOrSxMfFsR97hoDLizOpcrsJY
	 nBHLyuWvuLHh2P7ENrjNiNabOB/jqF0W7PDRh3p6iblYP0qF5q//7SvENLREFz9+8M
	 sxOCOcCxwnQcQ==
Date: Thu, 10 Apr 2025 16:44:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <20250410134443.GS199604@unreal>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-6-larysa.zaremba@intel.com>
 <20250410082137.GO199604@unreal>
 <Z_ehEXmlEBREQWQM@soc-5CG4396X81.clients.intel.com>
 <20250410112349.GP199604@unreal>
 <c1ff0342-4fe9-44ec-a212-9f547e333a5e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ff0342-4fe9-44ec-a212-9f547e333a5e@intel.com>

On Thu, Apr 10, 2025 at 03:05:19PM +0200, Alexander Lobakin wrote:
> From: Leon Romanovsky <leon@kernel.org>
> Date: Thu, 10 Apr 2025 14:23:49 +0300
> 
> > On Thu, Apr 10, 2025 at 12:44:33PM +0200, Larysa Zaremba wrote:
> >> On Thu, Apr 10, 2025 at 11:21:37AM +0300, Leon Romanovsky wrote:
> >>> On Tue, Apr 08, 2025 at 02:47:51PM +0200, Larysa Zaremba wrote:
> >>>> From: Phani R Burra <phani.r.burra@intel.com>
> >>>>
> >>>> Libeth will now support control queue setup and configuration APIs.
> >>>> These are mainly used for mailbox communication between drivers and
> >>>> control plane.
> >>>>
> >>>> Make use of the page pool support for managing controlq buffers.

<...>

> >> Module dependencies are as follows:
> >>
> >> libeth_rx and libeth_pci do not depend on other modules.
> >> libeth_cp depends on both libeth_rx and libeth_pci.
> >> idpf directly uses libeth_pci, libeth_rx and libeth_cp.
> >> ixd directly uses libeth_cp and libeth_pci.
> > 
> > You can do whatever module architecture for netdev devices, but if you
> > plan to expose it to RDMA devices, I will vote against any deep layered
> > module architecture for the drivers.
> 
> No plans for RDMA there.
> 
> Maybe link the whole kernel to one vmlinux then?

It seems that you didn't understand at all about what we are talking
here. Please use the opportunity that you are working for the same
company with Larysa and ask her offline. She understood perfectly about
which modules we are talking.

> 
> > 
> > BTW, please add some Intel prefix to the modules names, they shouldn't
> > be called in generic names like libeth, e.t.c
> 
> Two modules with the same name can't exist within the kernel. libeth was
> available and I haven't seen anyone wanting to take it. It's not common
> at all to name a module starting with "lib".

Again, please talk with Larysa. ETH part is problematic in libeth name
and not LIB.

Thanks

