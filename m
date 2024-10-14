Return-Path: <netdev+bounces-135363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8099D9D6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C365283363
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6363A1D365A;
	Mon, 14 Oct 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzfwijva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FF1D2B34
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945518; cv=none; b=D0fLCIq3qn8TAVoSFzNRd5DDpAH2VJ95T7Rss92gyvcDMGMQ5YrZL91INzxLA1cSo3XKOXumdkB+UfgtrHYlvgJoNQRhxfXWqSc8z/+G5jIkFpOpEQk14sspC6OROYa/vJKzXCxAkxNKO1tQAs14sTJBZyR4SBFJ4os5STiBcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945518; c=relaxed/simple;
	bh=PhqhnmdCB9XngJNz2rIDc7PJUCLcY/GGyiAZV/PbUMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcHhbJ66cvyUEzoCi/Ox1+CFPhDysAGids3lM2sT+PrDKx7KvEk02ZOXOwbeIDEKWJr0fYL5z92Km1Ck0xn9/YhySAl/axBTViJ8MYH7e2D0Dj/+Za+m0Sic5gPk0dFD6zo5zMDAzJswWM99/ukveR1tbPrbc5Ik8SvqUvsDIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzfwijva; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4601a471aecso524781cf.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728945515; x=1729550315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyvAu9TReOmTcwHD1Rb4BWZDjEunnoRovVshTlZA/yc=;
        b=Pzfwijvac+wbD91rVSI5ETuPnjpGr4BiKNbgjwgvCE24OU5kwfQLgik+1VwXIi1SUN
         nEaT4bhZ6DPPjUMiBHw04UkG7/WC7fSGuiDJVP3GcYu5hXHuN/o626CTWR60v4SL3d7k
         hkw678yWYDtTULctv64AIsrng58CVu2Rph77RmZlFd8fESKsrcJ0/vT1EZESvaF7UeXJ
         8wKfPHKpZWH/0BIp45yiKzM4DoZx0NUEnSyKy5vXpGI3Y/NbvPZOjegWmEXjFBNm46Nm
         WCO5WkwZZG6VeDu5vB+hbB2WxbLrVyMpi6XiWC/JeUyrGMiZK5xmiRH2QOCqla1dNQQv
         wDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945515; x=1729550315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyvAu9TReOmTcwHD1Rb4BWZDjEunnoRovVshTlZA/yc=;
        b=Jvrft+mWhpzls5rVzN27VsNq8h2yu0t6f6RlmRK/BLmZDvssbEfru8iK7tGH6nFnqp
         T4iLZLZrJU750OesmHimd4dnzvcbh8zIAkGra17T7ksFS2iDq50yX5QA2u4Qvfh8dPK2
         4uDJYLn6bloVxSLyY8TAVOhFEl119EbYqMtGbrX4nqZXI0o3QMW3ObmQ03/6OeAVJ57U
         NA8qZ0wUiUeWdU1mPEcRMAFPMS4WJdVSxsbXoFfk+DBWQwL/3bonfWcA92BCMe/ghBP0
         zX75XmvUbJbz1Pj3RNJqLZHZMRk9n4IpolGoIhe+/grU4Nv8H8o2SvXVoPtXS5zEBXdW
         z4mw==
X-Forwarded-Encrypted: i=1; AJvYcCXt94LXSv2sX/C4rdgriKd/uyaRJ9Az9T/5gEAZe9/SeZucMTpMSYZsvgqIS4JGEjWG8s77gB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUubusCRhdxi6vFg07fol2KgiwA9Uj30Okf7HtWJD+kn2flQIH
	LKHFlxRS2yVumDYs3YKz1A9+L6ygYfjn6fk9Ve7XH8zab8W46Y+9nixPZ2083SvOTSd8KfI227v
	PfwHMKQ1PwGZ9Q4oLgT5ev8iAjYrEPzvLEQke
X-Google-Smtp-Source: AGHT+IHi6sSSFzBDyuwdSrT3t3q7K9HlsuHKwbKdeIy1z9B9ZSLOV6FEv4PAQC/ug4UTq2hi2cgvXTFFNv4LnT6PCuQ=
X-Received: by 2002:a05:622a:5f0c:b0:45f:6e8:287 with SMTP id
 d75a77b69052e-46058f57a0amr6720411cf.18.1728945515164; Mon, 14 Oct 2024
 15:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-8-ap420073@gmail.com>
 <CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
 <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
 <20241008125023.7fbc1f64@kernel.org> <CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
 <20241009170102.1980ed1d@kernel.org> <CAHS8izMwd__+RkW-Nj3r3uG4gmocJa6QEqeHChzNXux1cbSS=w@mail.gmail.com>
 <20241010183440.29751370@kernel.org> <CAHS8izPuWkSmp4VCTYm93JB9fEJyUTztcT5u3UMX4b8ADWZGrA@mail.gmail.com>
 <20241011234227.GB1825128@ziepe.ca>
In-Reply-To: <20241011234227.GB1825128@ziepe.ca>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 15 Oct 2024 01:38:20 +0300
Message-ID: <CAHS8izNzK4=6AMdACfn9LWqH9GifCL1vVxH1y2DmF9mFZbB72g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, kory.maincent@bootlin.com, andrew@lunn.ch, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com, 
	idosch@nvidia.com, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, aleksander.lobakin@intel.com, dw@davidwei.uk, 
	sridhar.samudrala@intel.com, bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 2:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Oct 11, 2024 at 10:33:43AM -0700, Mina Almasry wrote:
> > On Thu, Oct 10, 2024 at 6:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 10 Oct 2024 10:44:38 -0700 Mina Almasry wrote:
> > > > > > I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
> > > > > > for dmabuf may be wrong.
> > > > > > I think device memory TCP is not related to this flag.
> > > > > > So device memory TCP core API should not return failure when
> > > > > > PP_FLAG_DMA_SYNC_DEV flag is set.
> > > > > > How about removing this condition check code in device memory T=
CP core?
> > > > >
> > > > > I think we need to invert the check..
> > > > > Mina, WDYT?
> > > >
> > > > On a closer look, my feeling is similar to Taehee,
> > > > PP_FLAG_DMA_SYNC_DEV should be orthogonal to memory providers. The
> > > > memory providers allocate the memory and provide the dma-addr, but
> > > > need not dma-sync the dma-addr, right? The driver can sync the
> > > > dma-addr if it wants and the driver can delegate the syncing to the=
 pp
> > > > via PP_FLAG_DMA_SYNC_DEV if it wants. AFAICT I think the check shou=
ld
> > > > be removed, not inverted, but I could be missing something.
> > >
> > > I don't know much about dmabuf but it hinges on the question whether
> > > doing DMA sync for device on a dmabuf address is :
> > >  - a good thing
> > >  - a noop
> > >  - a bad thing
> > >
> > > If it's a good thing or a noop - agreed.
> > >
> > > Similar question for the sync for CPU.
> > >
> > > I agree that intuitively it should be all fine. But the fact that dma=
buf
> > > has a bespoke API for accessing the memory by the CPU makes me worrie=
d
> > > that there may be assumptions about these addresses not getting
> > > randomly fed into the normal DMA API..
> >
> > Sorry I'm also a bit unsure what is the right thing to do here. The
> > code that we've been running in GVE does a dma-sync for cpu
> > unconditionally on RX for dma-buf and non-dmabuf dma-addrs and we
> > haven't been seeing issues. It never does dma-sync for device.
> >
> > My first question is why is dma-sync for device needed on RX path at
> > all for some drivers in the first place? For incoming (non-dmabuf)
> > data, the data is written by the device and read by the cpu, so sync
> > for cpu is really what's needed. Is the sync for device for XDP? Or is
> > it that buffers should be dma-syncd for device before they are
> > re-posted to the NIC?
> >
> > Christian/Jason, sorry quick question: are
> > dma_sync_single_for_{device|cpu} needed or wanted when the dma-addrs
> > come from a dma-buf? Or these dma-addrs to be treated like any other
> > with the normal dma_sync_for_{device|cpu} rules?
>
> Um, I think because dma-buf hacks things up and generates illegal
> scatterlist entries with weird dma_map_resource() addresses for the
> typical P2P case the dma sync API should not be used on those things.
>
> However, there is no way to know if the dma-buf has does this, and
> there are valid case where the scatterlist is not ill formed and the
> sync is necessary.
>
> We are getting soo close to being able to start fixing these API
> issues in dmabuf, I hope next cylce we can begin.. Fingers crossed.
>
> From a CPU architecture perspective you do not need to cache flush PCI
> MMIO BAR memory, and perhaps doing so be might be problematic on some
> arches (???). But you do need to flush normal cachable CPU memory if
> that is in the DMA buf.
>

Thanks Jason. In that case I agree with Jakub we should take in his change =
here:

https://lore.kernel.org/netdev/20241009170102.1980ed1d@kernel.org/

With this change the driver would delegate dma_sync_for_device to the
page_pool, and the page_pool will skip it altogether for the dma-buf
memory provider.

--
Thanks,
Mina

