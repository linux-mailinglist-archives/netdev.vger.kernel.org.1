Return-Path: <netdev+bounces-181720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C252A8648D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2E716769F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB1224888;
	Fri, 11 Apr 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/7sWOt2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BE221DB3;
	Fri, 11 Apr 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391930; cv=none; b=ZzJejCxggsebj8jaW5L8MBujjfKlgH+Lcu8WkrS1ymicd/4rIn0/xZTBw3uVRC4rFbDH3j4CnBkGnikMttnPYsrOfqL5yZnPpMrjwFlPv/tMGABn+icg1r1kAx1TgULnvbOVMTASYIxdU/N/4vsdzBR7R3z8A85iABlQvXFHcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391930; c=relaxed/simple;
	bh=lRKwdQ9StQwDkVSRqJkrGUFaZtKmCreOQJCWpPe6TOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz38ZscTfHLAQQD3BVrwci42KC0arNJESyV1U5Q9uiis6V7EMpna6Z+Xs9wQtC4n8gPvqrBaznlcISeeRTJPtg65v/2GJ1mNxCQ36YRO9kwJGXEGx/agn5R4YPfAdADInvjFRdldcgNKtsX+uNjifOUPNtjph/7hzCa6/clFcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/7sWOt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D951BC4CEE2;
	Fri, 11 Apr 2025 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744391930;
	bh=lRKwdQ9StQwDkVSRqJkrGUFaZtKmCreOQJCWpPe6TOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/7sWOt23ZlZr8J+iLl1EYrM58L9dFPTvPbIlatsExxzGuIxVT1UUyyg24+oQVGry
	 SEdQi1+e99GeDZlxUNKzSEdEbYr7RbmFyrko36wM3zekG37pcpdzPMYByqN2JZNyCy
	 qh/hETc2eQGD335bHdFLqds2ebuIy4c+nlaftBeMyUjnicXyVS/0M6/8w+/3aYHYVW
	 Z1wX9usjrS7T0bs4Pg2OKOJNMvTe9sfwKZkNh9QF7AGN2ebb/pheWaaz+JkwRVOz0C
	 qdvfN9sznMUUTprszvLIW9J75jwipVwWkKsimhjA+KJJ6bKkN+5KCPLtuBc6x5FjhR
	 IfbGLAPmEWB1g==
Date: Fri, 11 Apr 2025 20:18:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
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
Message-ID: <20250411171844.GW199604@unreal>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-6-larysa.zaremba@intel.com>
 <20250410082137.GO199604@unreal>
 <Z_ehEXmlEBREQWQM@soc-5CG4396X81.clients.intel.com>
 <20250410112349.GP199604@unreal>
 <c1ff0342-4fe9-44ec-a212-9f547e333a5e@intel.com>
 <20250410134443.GS199604@unreal>
 <Z_fOu3veEUcPUxuh@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_fOu3veEUcPUxuh@soc-5CG4396X81.clients.intel.com>

On Thu, Apr 10, 2025 at 03:59:23PM +0200, Larysa Zaremba wrote:
> On Thu, Apr 10, 2025 at 04:44:43PM +0300, Leon Romanovsky wrote:
> > On Thu, Apr 10, 2025 at 03:05:19PM +0200, Alexander Lobakin wrote:
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Date: Thu, 10 Apr 2025 14:23:49 +0300
> > > 
> > > > On Thu, Apr 10, 2025 at 12:44:33PM +0200, Larysa Zaremba wrote:
> > > >> On Thu, Apr 10, 2025 at 11:21:37AM +0300, Leon Romanovsky wrote:
> > > >>> On Tue, Apr 08, 2025 at 02:47:51PM +0200, Larysa Zaremba wrote:
> > > >>>> From: Phani R Burra <phani.r.burra@intel.com>
> > > >>>>
> > > >>>> Libeth will now support control queue setup and configuration APIs.
> > > >>>> These are mainly used for mailbox communication between drivers and
> > > >>>> control plane.
> > > >>>>
> > > >>>> Make use of the page pool support for managing controlq buffers.
> > 
> > <...>
> > 
> > > >> Module dependencies are as follows:
> > > >>
> > > >> libeth_rx and libeth_pci do not depend on other modules.
> > > >> libeth_cp depends on both libeth_rx and libeth_pci.
> > > >> idpf directly uses libeth_pci, libeth_rx and libeth_cp.
> > > >> ixd directly uses libeth_cp and libeth_pci.
> > > > 
> > > > You can do whatever module architecture for netdev devices, but if you
> > > > plan to expose it to RDMA devices, I will vote against any deep layered
> > > > module architecture for the drivers.
> > > 
> > > No plans for RDMA there.
> > > 
> > > Maybe link the whole kernel to one vmlinux then?
> > 
> > It seems that you didn't understand at all about what we are talking
> > here. Please use the opportunity that you are working for the same
> > company with Larysa and ask her offline. She understood perfectly about
> > which modules we are talking.
> >
> 
> While I do understand what kind of module relationship you consider problematic,

Awesome, thanks.

> I still struggle to understand why stateless lib hierarchy can be problematic.

As I said already, I wrote my remark as a general comment. It is just
a matter of time when perfectly working system will be changed to less
working one. So when you and Alexander are focused to see what is wrong
now, I see what can be in the future.

To make it clear, even for people who sentimentally attached to libeth code:
 I didn't ask to change anything, just tried to understand why
 you did it like you did it.

> The fixes that you linked relate more to problematic resource sharing, of which 
> libeth has none, it does not have its own memory or its own threads, this is 
> just collection of data structures and functions.

It is just a matter of time and you will get same issues like I posted.

Thanks

> 
> > > 
> > > > 
> > > > BTW, please add some Intel prefix to the modules names, they shouldn't
> > > > be called in generic names like libeth, e.t.c
> > > 
> > > Two modules with the same name can't exist within the kernel. libeth was
> > > available and I haven't seen anyone wanting to take it. It's not common
> > > at all to name a module starting with "lib".
> > 
> > Again, please talk with Larysa. ETH part is problematic in libeth name
> > and not LIB.
> > 
> > Thanks

