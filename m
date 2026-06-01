Return-Path: <netdev+bounces-293893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFsIMAbWHWq6fAkAu9opvQ
	(envelope-from <netdev+bounces-293893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:57:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C4B624511
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D28C300EC63
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC673537E5;
	Mon,  1 Jun 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g8VwfbQ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B3346AD3
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339722; cv=none; b=fUMlMwOrrSjV4Cv6QwiVS+KedrZtIQVE5uOqPNx6/I/iuGf4kRtDSuGtBiOGIkgJMMbIc+iPxXRS7nlpDRpEu8JpL/a1Le34+7zJsD0hr/406jApldYwMhioQKLMSeiSuoMPDk4KtmcNwkpxnwccfRqKEFbO0PPVGOQ71WjHGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339722; c=relaxed/simple;
	bh=dpwh9EurGC8PWJHM2nwOEMbtuDAWOKFskADoJMJikXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV5ftDgEc6QZcmQ6BD62OMyn+MU8n6qf87YvY9ipabAzrtfz4PGmBIhKrxW8L5ducBoK19ZGwJOM7t/+FefDFbuOl+GLfTmzd3WsDJsaWTrrz7UmOFrsPuvDcau8I28UF6H1UPqBjtf4yoS0aQFkxdHE22pf43wL4wdSC9696rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g8VwfbQ6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91541fa94aaso278444185a.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780339720; x=1780944520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZOVGBJ+B1pIGsdNReY7mg4M6+73TAYZ+OPVziP9NXJE=;
        b=g8VwfbQ6/OQdI+ssi72qB/rPbqUxNqrG0AwhNoH/u/48EizSI2O4Hxjc9PC9FiFhle
         gYaxDuKwklcxwE0R62QrehCjGP4mXnCKCN3rnL5qe1NSzg4geZWep8jezMiDHrUBngID
         v5bwNcXovAurH+sb4zbeyZbeIN6hQMN6OJb1xp3qn1Xt+16aIU+bvuVU+gCMvpn6NOuT
         daXS6fCOsUo8SdGhK16F/tUJ3UvyLJQ7r2MpXAZNEhd+kqVZDJgIaKZOwqTHJHHhWYcl
         /x/yIWCza/NV861UVCqG0H3T1y/6cI/tCPloRGkfJ3irllFEcNi9N+OAxS8MV4Xcxpsa
         dnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339720; x=1780944520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOVGBJ+B1pIGsdNReY7mg4M6+73TAYZ+OPVziP9NXJE=;
        b=KGUHpBdpcsbkyJDAdfdlIkCzBb6l8rhbEQpErdOj/AETDkJ1eACI+WaLVUgM/BuQe/
         EJa0TuYty3XwO8aaKrF/57wjXYXramGJDSC/LzGurOJPMrbutmAqytthc98u1zE21DZN
         ElG4UzUJ+gw1A09mC2tYJxZO21K1mGofzuRsyic4rlF+RFIiQKCAk/QrTg1VVzThFLno
         MZrWM7EiSYciU3SAYgeYozBYt45DYP8222mWCSVFpRTxqYzLftx23qxEYWyV4NIRhqUj
         +3T1drQOZaa43TdCQEYMPwtwmVG3LQtWH1djj96LwoAJLCSPkOdHp59S9g24u6sdP2Jm
         h36Q==
X-Forwarded-Encrypted: i=1; AFNElJ9V9rKNJS2IXqH1/7NnVKL2XEKGIutE5fy8PcSqpeV4pbgdnRuKw4EVGxu0pO2dlH7nGJnkyWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx278Vl/jybGSSHhONfGEYWx+UM8agodDCR74Q5ShKVWvEwysbn
	d0fMc7vxUPgZNgDxcaKzTnFTmk/WVIrEBk+GDbt4X/c9IxUB+tKf6r1IJgqIfHk+3OY=
X-Gm-Gg: Acq92OEv1pa8pZtD8gbKc1BGFtC/8uQP8uqgqxxugSXYODU0ZXbbmeth3dxUD0mbIF7
	H5OZsNqkyu3XNvuqsXaQFrLz2+1QIna5ROnl+jOlB7pu3qFWjKAnz7f23CqDYvg5r5TB5eMDmq+
	Ts6LvyyeTujBqwztR28JAccissf0GObz4CJS3yvrVf239jP0xO4QOFzGu4/bHXO2OER/buhSJNZ
	swYn3z+LjAsOlETvuArNtInPEsmjCbcOzosnlgLvwtAyaIL/pRoA1GawgfWE55tJSC0WMwFzt+G
	+HWdqnYldzzlCKrLzc9fNRFVd17squ/4HSNBUH7vvD2yir4s96s6mU8bZRcmRe7wSuDLdHUD1wW
	o8saQ8/rZNc21V8dUDFudr3gjxRVWMDKW50QgnoSmC7HcCT5c7QCYb/qc/2EeNJq56nQJU/UoM7
	sCzt5xkT8KZ/2AQvIT5JliiXt84I1GL5PDEAxGoGva3X+jUy5qeD7AqHVrPOiuqao/qFg7rAvRW
	0Wkp3vZ2KiLlrc3
X-Received: by 2002:a05:620a:630f:20b0:912:1206:ddd1 with SMTP id af79cd13be357-9153d93b157mr1356674885a.1.1780339720004;
        Mon, 01 Jun 2026 11:48:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153262f45dsm1098180085a.41.2026.06.01.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:48:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU7gk-00000002GHG-3uxy;
	Mon, 01 Jun 2026 15:48:38 -0300
Date: Mon, 1 Jun 2026 15:48:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260601184838.GE2487554@ziepe.ca>
References: <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
 <20260601174734.GB2487554@ziepe.ca>
 <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293893-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: C4C4B624511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 08:17:15PM +0200, Christian König wrote:
> On 6/1/26 19:47, Jason Gunthorpe wrote:
> > On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian König wrote:
> >>>> When you have a complete open source driver stack which utilizes
> >>>> VFIO passthrough as the interface to communicate with the kernel
> >>>> drivers then we can eventually talk about that.
> >>>
> >>> That decision is not up to dmabuf
> >>
> >> Yes it is. This is the DMA-buf API which is added here.
> > 
> > It is a DMA-buf kernel API that is added, I think it is overreaching
> > to try to veto a VFIO uAPI that calls it..
> 
> Well as long as that is a private interface between VFIO and mlx5 I
> have no objection at all.

Well, as you know, we are using dmabuf to mediate many of these
connections now.

I don't mind a "private" interface as a starting point, but it does
need to discoverable and negotiated without weird module dependencies
or symbol_gets.

> But when it starts to affect DMA-buf I need to make sure that it
> works for everybody. And without even being able to test it that
> becomes really tricky.

They should have an argument how it can be used for CPU backed memory,
IMHO.

> > This exposes a PCI SIG defined TPH capability in a reasonable simple
> > VFIO uAPI that can be re-used by any other device that happens to
> > support TPH on inbound MMIO. The uAPI has sensible general semantics
> > based around the PCI spec.
> 
> That it's implementing an official PCI spec is a good argument.
> 
> But on the other hand looking at the spec it's not really specifying
> much since everything is architecture specific.

Yeah, spec doesn't say what TPH does when it is received. It is
intended as an opaque channel between the source and target.

Even on the CPU DRAM side we make an opaque call into ACPI and the
BIOS returns back the right value to use for the CPU. The whole thing
is agressively opaque as to what the values mean to any particular
device.

So I don't have an issue with VFIO supplying a value for MMIO it
owns, it fits the general architecture.

> > Anyone can repeat the demonstration Meta outlined in their cover
> > letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
> > analyzer and you will see the PCI SIG defined TPH bits set the way the
> > VFIO uAPI says they should be set.
> > 
> > There is nothing uniquely tied to Meta's device here, or unusable by
> > someone else's devices. Arguably this is actually a mlx5 feature to
> > allow VFIO to control its TPH generation HW.
> 
> Would it be possible to demonstrate the functionality with some FPGA
> implementing an PCIe endpoint?

Sure, you don't even need a special endpoint, any endpoint that
doesn't explode when it receives a TPH is fine to illustrate that mlx5
is emitting it correctly.

A fpga reference board with an out of the box PCIe IP demo is likely
entirely sufficient, and you can use a FPGA logic analyzer to inspect
the packets.

Though keep in mind mlx5 is formally supporting TPH in a growing
number of kernel contexts, so we do test and verify our device is
working properly as an initiator. So I wouldn't advocate anyone
actually use their time on FPGA :)

> Doesn't needs to be anything funky, just the ability to exercise
> this for basically everybody who can spend a few $ on the HW.

Topologically you also probably need a PCIe switch as the CPU P2P
likely discards the header.

Jason


