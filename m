Return-Path: <netdev+bounces-195259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED079ACF183
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A0816658F
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2AA2749ED;
	Thu,  5 Jun 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4CQZnVPR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6B1E500C
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132303; cv=none; b=Q8ZApEgGZUFDRZf7H9Z/wqijZLpbI/N2Kf4m8wAJ33+CNkA4ZkHmEJBDnJMR3MvhlX7AhMuDwQ/ADk/N/A5qEcxPFHqn6H+FzFZIoEjlDELbiOAtfyMlq8sL5q5vOACTOIMTsAqXMtdW5UppfViZshYfUVrfh+ztvyMlCXcfRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132303; c=relaxed/simple;
	bh=gAvR+Cs9ZGmXIj5nDVjNtPfHB2KTpHDycvMz98WLB+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoKSL0a+1knE0/Y69M8nPt7ljX6mR2BM/2pEIZgoscbHBnM6s9StgLqsrQmluWFTqDYnPladO8s3Wu5Afb48NDcSWirPsQY89PZb7ena89DGS1U5RvsPv6AWMbM8bEP8KilH73qF+2/0YIBBxN1bAPknipfnk+UVXgbafzkIHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4CQZnVPR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uCeznskelHqtDK2qSw5TV5JZc+mTpp4OO2+yvV0NTKo=; b=4CQZnVPR2QqlZyHWvG2F4bchGU
	DsW7Ar8tpfhHrSFDark15seR03YiUgjE1MU5+BdZX+czUScfT2Px9pLmnQ/AfeE/w9jwhizkmICPG
	WndFSE2VuFzAMseUVfn/D0ooO/GS5GRi3oTq7Xfb1emf6LfptjpgBQystLWfWye4jcvA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNBDB-00EmHg-Av; Thu, 05 Jun 2025 16:04:53 +0200
Date: Thu, 5 Jun 2025 16:04:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org,
	leon@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com, jacky@yunsilicon.com,
	horms@kernel.org, parthiban.veerasooran@microchip.com,
	masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	geert+renesas@glider.be
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
Message-ID: <96f53bdd-13e4-4e4b-ab8e-3470782df3b2@lunn.ch>
References: <20250423103923.2513425-1-tianx@yunsilicon.com>
 <20250423104000.2513425-15-tianx@yunsilicon.com>
 <20250424184840.064657da@kernel.org>
 <3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com>
 <20250605062855.019d4d2d@kernel.org>
 <CAMuHMdVMrFzeFUu+H0MvMmf82TDc=4qfM2kjcoUCXiOFLmutDA@mail.gmail.com>
 <20250605065615.46e015eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605065615.46e015eb@kernel.org>

On Thu, Jun 05, 2025 at 06:56:15AM -0700, Jakub Kicinski wrote:
> On Thu, 5 Jun 2025 15:39:54 +0200 Geert Uytterhoeven wrote:
> > On Thu, 5 Jun 2025 at 15:29, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Thu, 5 Jun 2025 15:25:21 +0800 Xin Tian wrote:  
> > > > Regarding u64_stats_sync.h helpers:
> > > > Since our driver exclusively runs on 64-bit platforms (ARM64 or x86_64)
> > > > where u64 accesses are atomic, is it still necessary to use these helpers?  
> > >
> > > alright.  
> > 
> > [PATCH 1/14] indeed has:
> > 
> >     depends on PCI
> >     depends on ARM64 || X86_64 || COMPILE_TEST
> > 
> > However, if this device is available on a PCIe expansion card, it
> > could be plugged into any system with a PCIe expansion slot?
> 
> I've been trying to fight this fight but people keep pushing back :(
> Barely any new PCIe driver comes up without depending on X86_64 and/or
> ARM64. Maybe we should write down in the docs that it's okay to depend
> on 64b but not okay to depend on specific arches?

I agree. I expect in a few years time we will start seeing patches to
drivers like this adding RISCV, because RISCV has made it into data
center CPUs, where this sort of card makes sense. Its the fact it is
64bit which counts here, not ARM or X86_64.

	Andrew

