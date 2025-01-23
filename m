Return-Path: <netdev+bounces-160460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EF4A19D03
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 03:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3FF3ACB50
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 02:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9222B2DA;
	Thu, 23 Jan 2025 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dJqFsFVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88022F19
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600452; cv=none; b=lvIfW1lHGQAF1Vuvd+3NyInaI0537jHXqGoC+YHv/0KGi2bz/wH0GKr8vZwZg6zfc3EFFOmfpEy6ruIfVgskHzXUUKkYEMRZM1nfVoo0g2FyzJIpNiXubKnwAni32rWTNW3fzVuSjCVoHZOAUGKb8g4ZHk+Lj6Kwgcu0k9eGGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600452; c=relaxed/simple;
	bh=qpz5GHIV/q1Z6mS3ehwKqxMZzFsWsx5+0NpTvYpIx3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAHsbvSMOHDdZv8MdGfmdK59STioRgcwTQiGFZEedT3bH6LoI2ipI/sS7q7GB9NOOcjmd7k0KQvz+OWnMl5rfzLb2FNlvlIK3uHppUiUB4+BoLeeMlXPCA4wEmtRtrh8JHCCTmjpy7D9BWAQcbNXYR9INiw28b/B1L9rzhIeUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dJqFsFVm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21661be2c2dso5945755ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737600450; x=1738205250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2UgsPHwIKBOqMrfozZVw3t3KHtftNFDPhqp8M0WAbQ=;
        b=dJqFsFVmbHUevobE6/TzgF6tALw6Q/7oDf32v58DT3qwItRBAstwqqDZXyh+/xECv1
         TdWPmVLfaeIFBAJnVFxRVo0gN1u4LG+gLNKkZdOMS0uUHfse8Tc/R+7XW1Hr0PTK4P49
         /5tHTmuQlj4olEG1mlR4VogDjwDAGU5T++aQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737600450; x=1738205250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2UgsPHwIKBOqMrfozZVw3t3KHtftNFDPhqp8M0WAbQ=;
        b=osCc8eojaDPDmNbFq+Ky7qktqDxZZO7CVKKnyCERxcwAKJA7zipx00omV3RgV5YLqd
         pZVPUIaZzCpp4Ck6LjLOzuaIKJdl/lhiR6hd3iZdtOHLTG4ZtHV3jUqvRuuRnI6kVEdg
         rsM2eQBrd10xL0zGFK7+wxUUGI7w4AtfMYFen8eBEjur3SRNsoIg1mjFEhMqAoJsdWeK
         wKueXIXLij0PvYsJb7OIrG31dlqTEkOFNZY7H9y6NGYiimWFQLPe1kKYEDZjJYDFGRXL
         DTyfaV4/0wGoonwVaM4DX5zyFCAPqqCev2nf7CPYgdoLsIgA3m9XOL70VqOdzJLWTRb2
         6X2Q==
X-Gm-Message-State: AOJu0Yw7JuGocmGfvUl1eNk0K4XmGMotgEI7FsAJG1hSSB+7y0nwUDnU
	bSsSragsznSWWl+JYdQvQm1qTKB4hx5KnTTFWBj2z+oZBosEpsM4JoT0M3k6GQ4=
X-Gm-Gg: ASbGncvuaaytIPqucVdW0kRk9P7g5MyR+XUm5G19uuYeS6fXfi8fNz2Y1Wp85TjP9hd
	fD1TqtJAVxABBIAoOcDtCZYXs4BXcQUWjnuRFSCR8YfPM42h9IxTy8dL/M9Qw0N1NP9D6eABcTu
	VWqLPjcURDsJTpiWZwwEvMz8SXhCakzXDerIVtQPMOyQyltr84JRfXNKcdbw6jTEwGghhvbCo/9
	GSH8SoagYRPwPs7e9dnkq4QPI0R6wxQy144MW2JJCt10vSBBmDqRiGejnPzpIinV9BAsV06Hv8b
	91R0G4Nubw+6F56kD8cZrQUEeFC0XOWaGnHkGPt3FxAwFOXrrr6xxZWk+Q==
X-Google-Smtp-Source: AGHT+IFJpJzS0Tmwz6QJjW16olbKOsy6uoF4TTmtdWvfMVbO5XC6LPMoIN8L//vAPXE/Dy/lO1nFLA==
X-Received: by 2002:a17:902:e5ca:b0:215:b473:1dc9 with SMTP id d9443c01a7336-21c355fa313mr312106225ad.46.1737600450217;
        Wed, 22 Jan 2025 18:47:30 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bce3a7eedsm11353188a12.40.2025.01.22.18.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 18:47:29 -0800 (PST)
Date: Wed, 22 Jan 2025 18:47:25 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
 <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>

On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> On Thu, Jan 23, 2025 at 1:41 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > On Wed, Jan 22, 2025 at 3:11 AM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > Slight refactor to prepare the code for NAPI to queue mapping. No
> > > > functional changes.
> > > >
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > > ---
> > > >  v2:
> > > >    - Previously patch 1 in the v1.
> > > >    - Added Reviewed-by and Tested-by tags to commit message. No
> > > >      functional changes.
> > > >
> > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 7646ddd9bef7..cff18c66b54a 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
> > > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > > >  }
> > > >
> > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > +                                  struct napi_struct *napi)
> > > >  {
> > > >         napi_enable(napi);
> > >
> > > Nit: it might be better to not have this helper to avoid a misuse of
> > > this function directly.
> >
> > Sorry, I'm probably missing something here.
> >
> > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> > in virtnet_napi_do_enable.
> >
> > Are you suggesting that I remove virtnet_napi_do_enable and repeat
> > the block of code in there twice (in virtnet_napi_enable and
> > virtnet_napi_tx_enable)?
> 
> I think I miss something here, it looks like virtnet_napi_tx_enable()
> calls virtnet_napi_do_enable() directly.
> 
> I would like to know why we don't call netif_queue_set_napi() for TX NAPI here?

Please see both the cover letter and the commit message of the next
commit which addresses this question.

TX-only NAPIs do not have NAPI IDs so there is nothing to map.

