Return-Path: <netdev+bounces-134636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0548999AA67
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD01F28BDA
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA31C2DB7;
	Fri, 11 Oct 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0QcrklZ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2B1C32FE
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668040; cv=none; b=dtlHKA0xiAx9/EIrmu9BzPuTlbVu40foir+ko3Y1tiRCmiT6F9kibr/171sEjJKlRWfdjGc8JvTAzFC48KqRNPqHZGcBBvp1ro1Kho9tNoJmX+prwmOHEfByeBAt8+3uOv8mi8bkhKzISVPXeHy6gbLLZVxGf4CCxm91x5Tcg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668040; c=relaxed/simple;
	bh=VRrf8ntlcACFdviPg6gJE38L8OLS0KaeN7NIdzpw4Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJeO7vClGCcRyQDznjlaeu8f0j4+6Og0vh0l47miXKaOAfiKo1na37D01fZY8ihzRymcTTllpuAmlypRAo+Bihs8dJ9Ibd6kLzVuOw2UNoSs4qwFpayx2VVJ9FXhgHOrFtoFayFPGjY58pX1ftkvBv76LyL/E/LS+qFCvGgy4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0QcrklZ8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4603d3e0547so6451cf.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728668037; x=1729272837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmnghbBZ3GwSfb268fMdvHk82X10qhUobyckvFj2KWQ=;
        b=0QcrklZ8wXoEmcO/JXs3Eqc0BMbHGTDaH63XfoX2H2f1l3+VMBpXJ0IT2P5EWh7lE5
         cF9uuskr1DAbyTBdQJ/rQCIAX3ecbmJPrBT4DDgc6N9AHGeS6cQtvJzSq3vNcfK4tjGB
         KnsR3lYnIIXdiKoBKynw4u8SmyABEH/yLvMLrFAh5Fpmmz5ajJ6aWcri+TGrPoe+5REQ
         GJr+Vq739eiiGR50xxEXL7RLHBbeOJZ4HV0/kylI9V47+GtoWLLE/J4FV0QaUWCubh3X
         ZJSNEtZ5YNiMqscowmsHbI3avTraL6fY0eDnX/nrtGduh+yXcUvrvXbXKRdxkEIIHDMZ
         aqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728668037; x=1729272837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmnghbBZ3GwSfb268fMdvHk82X10qhUobyckvFj2KWQ=;
        b=J1J3K2C+YqQdwTVlNkfgv8UgfHf54ddGubAVTllbQFSYYhAmKrprrZU2cWSU308QTM
         Rb1OgbQ6cJrFApz1xkrD9eHLhqawCECDxqeLUDeQn5PyxRUkKYM10np6kckN+9kPt17S
         fgOFGWp9byYfURFtklrwVB9YQBRdTfuBY+HrLIFo25oL5cnonAo8MJcU+CwwfPlPgtvt
         QzReNabDO2//Qu3UIrwSBLfd6k0IO9WEczabj5s/NlxjTyvWKSpM/pDj/UznJW/+2/5T
         tyfZrCj/y2BEZnlk2XPh6cdj7tmlYyKLB4xMiJV3zT4GSRFCwRLOsCyYr1Dg23kqt+T8
         +zMg==
X-Forwarded-Encrypted: i=1; AJvYcCXLMzjNYiir111rGoSd6eDWt1Iu7dcIS6+PrVb2foh4k4yYqj/Z5FURhpJMduHPiVEiVZ9C5Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxiDkuC747dv4vNjsUk0g1QfamwCQn1jKU31LBA+kXT0PMXjE
	ARUJeXv42D6+00bXtBYmzYjGmOORWDYY6o305b68J7TWHBAjiNW8umHMFVyaJqeRNT0ho3pFIm6
	kGuJOk0Usx8rTrJ3pD3mpEBxmdxosi9OaMWtP
X-Google-Smtp-Source: AGHT+IFz4SsvmOVlN9wmuI0OD+n+Y3BKo/jR94QdcFEtQIr/0/iWWqkX2UXzu02XCIryglx7gU3frkwmZlQJh7tb8Tk=
X-Received: by 2002:a05:622a:820c:b0:45c:9eab:cce0 with SMTP id
 d75a77b69052e-4604c16ba51mr3184741cf.15.1728668037354; Fri, 11 Oct 2024
 10:33:57 -0700 (PDT)
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
 <20241010183440.29751370@kernel.org>
In-Reply-To: <20241010183440.29751370@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 11 Oct 2024 10:33:43 -0700
Message-ID: <CAHS8izPuWkSmp4VCTYm93JB9fEJyUTztcT5u3UMX4b8ADWZGrA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Samiullah Khawaja <skhawaja@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 6:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 10 Oct 2024 10:44:38 -0700 Mina Almasry wrote:
> > > > I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
> > > > for dmabuf may be wrong.
> > > > I think device memory TCP is not related to this flag.
> > > > So device memory TCP core API should not return failure when
> > > > PP_FLAG_DMA_SYNC_DEV flag is set.
> > > > How about removing this condition check code in device memory TCP c=
ore?
> > >
> > > I think we need to invert the check..
> > > Mina, WDYT?
> >
> > On a closer look, my feeling is similar to Taehee,
> > PP_FLAG_DMA_SYNC_DEV should be orthogonal to memory providers. The
> > memory providers allocate the memory and provide the dma-addr, but
> > need not dma-sync the dma-addr, right? The driver can sync the
> > dma-addr if it wants and the driver can delegate the syncing to the pp
> > via PP_FLAG_DMA_SYNC_DEV if it wants. AFAICT I think the check should
> > be removed, not inverted, but I could be missing something.
>
> I don't know much about dmabuf but it hinges on the question whether
> doing DMA sync for device on a dmabuf address is :
>  - a good thing
>  - a noop
>  - a bad thing
>
> If it's a good thing or a noop - agreed.
>
> Similar question for the sync for CPU.
>
> I agree that intuitively it should be all fine. But the fact that dmabuf
> has a bespoke API for accessing the memory by the CPU makes me worried
> that there may be assumptions about these addresses not getting
> randomly fed into the normal DMA API..

Sorry I'm also a bit unsure what is the right thing to do here. The
code that we've been running in GVE does a dma-sync for cpu
unconditionally on RX for dma-buf and non-dmabuf dma-addrs and we
haven't been seeing issues. It never does dma-sync for device.

My first question is why is dma-sync for device needed on RX path at
all for some drivers in the first place? For incoming (non-dmabuf)
data, the data is written by the device and read by the cpu, so sync
for cpu is really what's needed. Is the sync for device for XDP? Or is
it that buffers should be dma-syncd for device before they are
re-posted to the NIC?

Christian/Jason, sorry quick question: are
dma_sync_single_for_{device|cpu} needed or wanted when the dma-addrs
come from a dma-buf? Or these dma-addrs to be treated like any other
with the normal dma_sync_for_{device|cpu} rules?

--
Thanks,
Mina

