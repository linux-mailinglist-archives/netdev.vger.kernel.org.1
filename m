Return-Path: <netdev+bounces-134744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E4E99AF7D
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BCCB234AD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469221E4930;
	Fri, 11 Oct 2024 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ek+ObBeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC91E412E
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728690153; cv=none; b=VGS6VJ/JyHFxDIohAlezWO2g8x65w+/92n7YgvB+RQx4MweZw8enULfbnfncfjRswfvejpnp6ZdYUkHsMuzBmjDhohytYe1XP8Gh3S2fIIhIYosm13SwVZaYEML0m25Yw3DPfIxZIP2ZOtZxaIEROOL9j7wo3+aWWtbML2tmIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728690153; c=relaxed/simple;
	bh=TBPC0eowcXh/MBu7GZif3OSMhDwxQ3mPafJT5pUGJt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGAMd0b7hUtNvrY1u2WKItF4k3tIDFsryZSYi7nMZNvA6ELTZX3cRxdi8HyrceE15oD9NBwzQRg0aLJhf2+Yu0jOoTg7wSstSvlZulPfsX8jZNZkwscT/kzD2JtjRI8u0TNUhtmQyWX6LN8IoQAgszt0mp5aGvR5KVYhEvEKiD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ek+ObBeZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbce16d151so13232746d6.2
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728690150; x=1729294950; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xXJBMqCoMuYuDY4nzuhWTUrJv8A53VZgPDgtsloBNPk=;
        b=Ek+ObBeZYjrEB+hI7D9ensGEQRykWGZuKEATgD6MsHglUsJaaE1/MkWttXitmD9XKA
         qEt5aF1BEjRy8W5Z/LZWJdvTEy2RtSI/VtephOqnmLa4LTF5yRPPXAgT9Qpn8Niy8tHU
         FYzqTRNLOnVPqWwo7DLYjVHfVXskpg/zObTDFh7cKtXwYdlJsAQkdNPBKtvmAb5SYeF8
         dP55pcqSVYZRD8KJ6+8soY0dfTWwbvy1jzytPjFg4ppEpVe1ghvzEjxFbf4AWviC6Bpm
         54stL/bi/Q8RIsFIq2iN48FljDLoA3umEgmvPkoL+63IF0E++uVy6u/EBVLKophDIjD7
         oLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728690150; x=1729294950;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXJBMqCoMuYuDY4nzuhWTUrJv8A53VZgPDgtsloBNPk=;
        b=cZZMbjvlceAIVtHu+/eQnKLJTvIe7PtLaSiBSRcvLR1fmpQNxyk4qIi3LH+40Jsaao
         HOg0M/Yx6A+YhrGsWKi26zjVST10nLK5AQDo36t4oePGE0IfEmhKevqWrhdI9Yz6C/K8
         ZsuX1SRghvmYv5Hqc1AUwxgmlE7BEzQERM8jkZAiF5te8mZnmTbBqNEWB8285xbQB2hx
         yrbIcAh0rY0VIMrdiNQUm9vaPn4rlqNIZ6w+c5R0CsJAWiNAOC3mFvYup4RXdez1+jcY
         Kz1dvKKatEyUeo0oRQRIAc44AwnVt5TxJ3Oo3d5K7X6Lz+lpVusEbb12d4y7BQmsQjt5
         RpWg==
X-Forwarded-Encrypted: i=1; AJvYcCUZTO8QJ1e0gCMtXVIpenp43Dxf9icOk8BALk5ND5SdeGqoZd44nC6B01jsYiUf7+lFaZwJu3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLvQALuratbiDDN06F2BRFXEKj9ashYNpHOfDUfUiUJ0bdXoH
	5BaXpB0JzSXA55MHaDNZoBaEKHsQWYa8m6qxuaoChO/WeS06u0pX4YofJH25Ypo=
X-Google-Smtp-Source: AGHT+IFH9bT6CVOYPLqw23tWCJW9/9IfbvX5Fo48QkoulgGtFqu1xzBgNKvi+Xhn0j9hbOAHPdRblQ==
X-Received: by 2002:a05:6214:5242:b0:6cb:a75f:9c6e with SMTP id 6a1803df08f44-6cbeff80f1dmr81302266d6.10.1728690149985;
        Fri, 11 Oct 2024 16:42:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608f79sm20550526d6.75.2024.10.11.16.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 16:42:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szPH9-009Xgw-JI;
	Fri, 11 Oct 2024 20:42:27 -0300
Date: Fri, 11 Oct 2024 20:42:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mina Almasry <almasrymina@google.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net,
	michael.chan@broadcom.com, kory.maincent@bootlin.com,
	andrew@lunn.ch, maxime.chevallier@bootlin.com, danieller@nvidia.com,
	hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com,
	ahmed.zaki@intel.com, paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com, idosch@nvidia.com, asml.silence@gmail.com,
	kaiyuanz@google.com, willemb@google.com,
	aleksander.lobakin@intel.com, dw@davidwei.uk,
	sridhar.samudrala@intel.com, bcreeley@amd.com
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory
 tcp
Message-ID: <20241011234227.GB1825128@ziepe.ca>
References: <20241003160620.1521626-1-ap420073@gmail.com>
 <20241003160620.1521626-8-ap420073@gmail.com>
 <CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
 <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
 <20241008125023.7fbc1f64@kernel.org>
 <CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
 <20241009170102.1980ed1d@kernel.org>
 <CAHS8izMwd__+RkW-Nj3r3uG4gmocJa6QEqeHChzNXux1cbSS=w@mail.gmail.com>
 <20241010183440.29751370@kernel.org>
 <CAHS8izPuWkSmp4VCTYm93JB9fEJyUTztcT5u3UMX4b8ADWZGrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPuWkSmp4VCTYm93JB9fEJyUTztcT5u3UMX4b8ADWZGrA@mail.gmail.com>

On Fri, Oct 11, 2024 at 10:33:43AM -0700, Mina Almasry wrote:
> On Thu, Oct 10, 2024 at 6:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 10 Oct 2024 10:44:38 -0700 Mina Almasry wrote:
> > > > > I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
> > > > > for dmabuf may be wrong.
> > > > > I think device memory TCP is not related to this flag.
> > > > > So device memory TCP core API should not return failure when
> > > > > PP_FLAG_DMA_SYNC_DEV flag is set.
> > > > > How about removing this condition check code in device memory TCP core?
> > > >
> > > > I think we need to invert the check..
> > > > Mina, WDYT?
> > >
> > > On a closer look, my feeling is similar to Taehee,
> > > PP_FLAG_DMA_SYNC_DEV should be orthogonal to memory providers. The
> > > memory providers allocate the memory and provide the dma-addr, but
> > > need not dma-sync the dma-addr, right? The driver can sync the
> > > dma-addr if it wants and the driver can delegate the syncing to the pp
> > > via PP_FLAG_DMA_SYNC_DEV if it wants. AFAICT I think the check should
> > > be removed, not inverted, but I could be missing something.
> >
> > I don't know much about dmabuf but it hinges on the question whether
> > doing DMA sync for device on a dmabuf address is :
> >  - a good thing
> >  - a noop
> >  - a bad thing
> >
> > If it's a good thing or a noop - agreed.
> >
> > Similar question for the sync for CPU.
> >
> > I agree that intuitively it should be all fine. But the fact that dmabuf
> > has a bespoke API for accessing the memory by the CPU makes me worried
> > that there may be assumptions about these addresses not getting
> > randomly fed into the normal DMA API..
> 
> Sorry I'm also a bit unsure what is the right thing to do here. The
> code that we've been running in GVE does a dma-sync for cpu
> unconditionally on RX for dma-buf and non-dmabuf dma-addrs and we
> haven't been seeing issues. It never does dma-sync for device.
> 
> My first question is why is dma-sync for device needed on RX path at
> all for some drivers in the first place? For incoming (non-dmabuf)
> data, the data is written by the device and read by the cpu, so sync
> for cpu is really what's needed. Is the sync for device for XDP? Or is
> it that buffers should be dma-syncd for device before they are
> re-posted to the NIC?
> 
> Christian/Jason, sorry quick question: are
> dma_sync_single_for_{device|cpu} needed or wanted when the dma-addrs
> come from a dma-buf? Or these dma-addrs to be treated like any other
> with the normal dma_sync_for_{device|cpu} rules?

Um, I think because dma-buf hacks things up and generates illegal
scatterlist entries with weird dma_map_resource() addresses for the
typical P2P case the dma sync API should not be used on those things.

However, there is no way to know if the dma-buf has does this, and
there are valid case where the scatterlist is not ill formed and the
sync is necessary.

We are getting soo close to being able to start fixing these API
issues in dmabuf, I hope next cylce we can begin.. Fingers crossed.

From a CPU architecture perspective you do not need to cache flush PCI
MMIO BAR memory, and perhaps doing so be might be problematic on some
arches (???). But you do need to flush normal cachable CPU memory if
that is in the DMA buf.

Jason

