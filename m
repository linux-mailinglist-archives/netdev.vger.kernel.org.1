Return-Path: <netdev+bounces-130951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8E198C33D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F621C21CD7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2021CC17F;
	Tue,  1 Oct 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="u/DN0StE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720981CB51A
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799504; cv=none; b=h+CzIR+4RahTrdzizgjWgI37yzo7SfiHGrZPCckOOL+Y7vObgQ0rtE05aw647nCC/0bmF9xmEc0+yUIC/hunT/lvpDbumgjSCq/OilSIEWmoUT7qH2iGVCHHPuuo86kXPJvLw/R/Orta7/PZPdXEIR5Snm36f7xp46AJPpJ5L7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799504; c=relaxed/simple;
	bh=xieEol6+JQz79GyzIWRlwgt+8ey+4QinMuknhqWRI1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0Taha8ksrAtSUhMsZB9L/DNH7TP20q2HeVNggP/D82ZiSi7qLWBnW0/4DGWcEiQuNVnIgLzvLKsWQYUmAXmR2G/FvlZraeqXKjGxXqQQYvjpBhuHm45rJS31Y8x2DpZ84rQx3RMXB6M+A8uOlBTDhNG2QFj/x26IW8KSBAJYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=u/DN0StE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e3991843e2so2010486b6e.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727799501; x=1728404301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4nwVYL/oOOkxfZt2IoSXaLqBrvuY+A42NP3608hs3o=;
        b=u/DN0StEKseydMbWoCdvpAIaaXBqDIfUH30UccC6jj1CKJtSGZbw8P1R1nkh3Yto6p
         Ogi1++1lo9X8RGQksm7k5J26ipm7ndJmDwTj1xS7+vzmhaHAJID9J14wjQn2c2mbXtdK
         ZIVZB6vzytbo3rAKj2hFVHSFHDmYmDdBTu2wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727799501; x=1728404301;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4nwVYL/oOOkxfZt2IoSXaLqBrvuY+A42NP3608hs3o=;
        b=HwpLU8pRPBCYI3qlUcdfa6sPFGI3MkA4v2QqkFaz0oxk3VDDB8YuVEuxeIWerG+SKJ
         W/iR7weeK5g+G4z5g6l/JbgC4l0hG/SBHSJtoYjZpTUJeYnYH+ObF5aP+k/Y3DOheD2i
         3U5g9/2gmGJl4lkP1SSMawmiSKBHfY/ak2oGdniJvKc1TV0vhX8qcACtGe0ur2tyR6Vp
         HfRfhU4CNO89TULcSA/3TG4AL9nynwy06IaohSW9h4lK90dyYY702AukZDyY6ikLtIIf
         RF4wdnJrakFSQc3L+t1UIR7dGIrBG1QU8GJKbxoXKqSj3Z7RHzLYmrsZ9RE3QnHL7qv8
         rE9A==
X-Gm-Message-State: AOJu0Yzf8KUAj6qEt1YTKKMLhjS/6Czu7saVfQRnpFOzS8bMFX2oEaRf
	Z7C2bE9LAzwGQ4x/CcuSceqAGPEClFijmnlx5IskaLMCUPnxZXragxaKT3woBsU=
X-Google-Smtp-Source: AGHT+IFzC+5nrw6mZVT8TzOt8bouT+dyYrWRbuV571W0qJeWfRcbIAFjyQ0c6C4m4yIAL67I8mYdGg==
X-Received: by 2002:a05:6808:1406:b0:3e3:a285:b284 with SMTP id 5614622812f47-3e3b40f9214mr343858b6e.11.1727799501474;
        Tue, 01 Oct 2024 09:18:21 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eafa4sm8590066a12.73.2024.10.01.09.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:18:21 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:18:18 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next 1/2] ena: Link IRQs to NAPI instances
Message-ID: <Zvwgyt_IJB-EZquT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240930195617.37369-1-jdamato@fastly.com>
 <20240930195617.37369-2-jdamato@fastly.com>
 <a6a2c78faa8740fab0ca53295bbc57d2@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a2c78faa8740fab0ca53295bbc57d2@amazon.com>

On Tue, Oct 01, 2024 at 08:57:47AM +0000, Arinzon, David wrote:
> > Link IRQs to NAPI instances with netif_napi_set_irq. This information can be
> > queried with the netdev-genl API. Note that the ENA device appears to
> > allocate an IRQ for management purposes which does not have a NAPI
> > associated with it; this commit takes this into consideration to accurately
> > construct a map between IRQs and NAPI instances.
> > 
> > Compare the output of /proc/interrupts for my ena device with the output
> > of netdev-genl after applying this patch:
> > 
> > $ cat /proc/interrupts | grep enp55s0 | cut -f1 --delimiter=':'
> >  94
> >  95
> >  96
> >  97
> >  98
> >  99
> > 100
> > 101
> > 
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump napi-get --json='{"ifindex": 2}'
> > 
> > [{'id': 8208, 'ifindex': 2, 'irq': 101},
> >  {'id': 8207, 'ifindex': 2, 'irq': 100},
> >  {'id': 8206, 'ifindex': 2, 'irq': 99},
> >  {'id': 8205, 'ifindex': 2, 'irq': 98},
> >  {'id': 8204, 'ifindex': 2, 'irq': 97},
> >  {'id': 8203, 'ifindex': 2, 'irq': 96},
> >  {'id': 8202, 'ifindex': 2, 'irq': 95},
> >  {'id': 8201, 'ifindex': 2, 'irq': 94}]
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/amazon/ena/ena_netdev.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > index c5b50cfa935a..e88de5e426ef 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -1679,7 +1679,7 @@ static int ena_request_io_irq(struct ena_adapter
> > *adapter)
> >         u32 io_queue_count = adapter->num_io_queues + adapter-
> > >xdp_num_queues;
> >         unsigned long flags = 0;
> >         struct ena_irq *irq;
> > -       int rc = 0, i, k;
> > +       int rc = 0, i, k, irq_idx;
> 
> nit: This breaks RCT guidelines, can you please move it to be below io_queue_count?

You are right; sorry I missed that. Will fix in the next revision.

