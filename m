Return-Path: <netdev+bounces-131394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37BE98E6B6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D6FB2194E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C86E19CC23;
	Wed,  2 Oct 2024 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="mV+HT5wo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EAD8286A
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911308; cv=none; b=DyrPWqVhZNrYJ5405mo0thzE2zvCj4e6xm5ZygVB4QdPjxtmLt5rg4YQ4ZzmCDOBYBPBrIMqoprQUxMAMrh9a55GGdgZCqF4vvZwmG8PD7DPcdYzJNaG+QipAYd29v6SdYsjBA93WT34EL6fW2f+fe6aRmz2vkcXkNOIk/fiZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911308; c=relaxed/simple;
	bh=UgcY+wNQp8XxmT35NKeAGyErRXgcmWWykfdLdZIOUes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0bjjF/RjqDuQrRCUc2jakxSr6i5zG1r4su+cRlDQAvWzB01vgPldO9S/yJO3cJAm7RHc+rG3RgBClIv/fDG+i3LTp8LJ1berNGTmhbS87Kmr2w3unbmKPEx56FU2GuKjpb5zDFSEc2tjuW8B1I89uZaSlefuf6dcprqVg50Ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=mV+HT5wo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso183227a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727911307; x=1728516107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMSZt2f+Fs+nBRBUgyo6uxKDO9ysy2u/oaoeF/+PoFY=;
        b=mV+HT5womGcH6AjEE2w8R8chDOv8lYQ9K5y4B9+zgFJAeyUcUG12KlXVK68myVHcqG
         +kK5A4PLflhJrSywNx6RngoahMiZR6uQR6vAU+1A36ay+GJHPskVFzNbpFKBoW4Omcni
         aq4IFbHanctOKM313hnXckfngv6UGIqHOA3rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727911307; x=1728516107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMSZt2f+Fs+nBRBUgyo6uxKDO9ysy2u/oaoeF/+PoFY=;
        b=IuOzXMBoFDPSj609cOqSY+xF5WptMNFj3yZHQIG+kffHhV/8VgiobOL357v9OSrxtg
         zx1bhJ/QcvgpBH40vLJO9gMBPd3z6wC4ZH+9BTBRnGCzMEY5ADZbr1eYyYXLIb1h0Eph
         Ymp2M7wxNGKrgYp5LOv5B/j4MFnyeISHZr/P9PGCDwd+Z5ks/bMpUJdPq9E8aGipH/Ry
         fbSSbmr8sZ/QolPQK9L4gAJnXczelU0bo8TlfPdIRHo5bk8mumAV3hbgFpXvx23N7YMw
         JR+xtaUGKI0PMETqKGxpGQcNqZRY1f4vxImtYa8QP08j7aPV4anFQlkNPUSZMj3Alj7q
         0+Sg==
X-Gm-Message-State: AOJu0YyeKbRnh+D+SrvzFr+RGkBvLUvFOpcR+2Gi2O1KI/zslYtZfiwF
	K0anpoKSvLKHDefJf2wm8ZlWvDU0CViCcxCsePvwh1nMoAPbwb6iun7sj/sMJWY=
X-Google-Smtp-Source: AGHT+IGxCRiO+MThPsnHFV/JWL+UWtXglUtoKM2ktl5U+eU1OimyCYDNPHhyUOSGNIvy2Gdw2GjQFg==
X-Received: by 2002:a05:6a21:1796:b0:1d0:56b1:1c59 with SMTP id adf61e73a8af0-1d5e2d4a211mr6284060637.32.1727911306792;
        Wed, 02 Oct 2024 16:21:46 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9df0ae6sm17684b3a.174.2024.10.02.16.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 16:21:46 -0700 (PDT)
Date: Wed, 2 Oct 2024 16:21:43 -0700
From: Joe Damato <jdamato@fastly.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
Message-ID: <Zv3VhxJtPL-27p5U@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240925162048.16208-1-jdamato@fastly.com>
 <20240925162048.16208-3-jdamato@fastly.com>
 <ZvXrbylj0Qt1ycio@LQ3V64L9R2>
 <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>

On Fri, Sep 27, 2024 at 09:33:51AM +0530, Pavan Chebbi wrote:
> On Fri, Sep 27, 2024 at 4:47 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 04:20:48PM +0000, Joe Damato wrote:
> > > Link queues to NAPIs using the netdev-genl API so this information is
> > > queryable.
> > >
> > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > >                          --dump queue-get --json='{"ifindex": 2}'
> > >
> > > [{'id': 0, 'ifindex': 2, 'type': 'rx'},
> > >  {'id': 1, 'ifindex': 2, 'napi-id': 146, 'type': 'rx'},
> > >  {'id': 2, 'ifindex': 2, 'napi-id': 147, 'type': 'rx'},
> > >  {'id': 3, 'ifindex': 2, 'napi-id': 148, 'type': 'rx'},
> > >  {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/ethernet/broadcom/tg3.c | 24 ++++++++++++++++++++----
> > >  1 file changed, 20 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> > > index ddf0bb65c929..f78d7e8c40b2 100644
> > > --- a/drivers/net/ethernet/broadcom/tg3.c
> > > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > > @@ -7395,18 +7395,34 @@ static int tg3_poll(struct napi_struct *napi, int budget)
> > >
> > >  static void tg3_napi_disable(struct tg3 *tp)
> > >  {
> > > +     struct tg3_napi *tnapi;
> > >       int i;
> > >
> > > -     for (i = tp->irq_cnt - 1; i >= 0; i--)
> > > -             napi_disable(&tp->napi[i].napi);
> > > +     ASSERT_RTNL();
> > > +     for (i = tp->irq_cnt - 1; i >= 0; i--) {
> > > +             tnapi = &tp->napi[i];
> > > +             if (tnapi->tx_buffers)
> > > +                     netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> >
> > It looks like the ASSERT_RTNL is unnecessary; netif_queue_set_napi
> > will call it internally, so I'll remove it before sending this to
> > the list (barring any other feedback).
> 
> Thanks LGTM. You can use Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

I noticed there's a misnumbering issue in the code.

Note the output from the first patch:

[{'id': 149, 'ifindex': 2, 'irq': 335},
 {'id': 148, 'ifindex': 2, 'irq': 334},
 {'id': 147, 'ifindex': 2, 'irq': 333},
 {'id': 146, 'ifindex': 2, 'irq': 332},
 {'id': 145, 'ifindex': 2, 'irq': 331}]

Note the output in the commit message above:

 [{'id': 0, 'ifindex': 2, 'type': 'rx'},
  {'id': 1, 'ifindex': 2, 'napi-id': 146, 'type': 'rx'},
  {'id': 2, 'ifindex': 2, 'napi-id': 147, 'type': 'rx'},
  {'id': 3, 'ifindex': 2, 'napi-id': 148, 'type': 'rx'},
  {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]

Note that id 0 type: 'rx' has no napi-id associated with it, and in
the second block, NAPI ID 149 is nowhere to be found.

This is happening because the code in the driver does this:

  for (i = 0; i < tp->irq_cnt; i++) {
          tnapi = &tp->napi[i];
          napi_enable(&tnapi->napi);
          if (tnapi->tx_buffers)
                netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX,
                                     &tnapi->napi);

The code I added assumed that i is the txq or rxq index, but it's
not - it's the index into the array of struct tg3_napi.

Corrected, the code looks like something like this:

  int txq_idx = 0, rxq_idx = 0;
  [...]

  for (i = 0; i < tp->irq_cnt; i++) {
          tnapi = &tp->napi[i];
          napi_enable(&tnapi->napi);
          if (tnapi->tx_buffers) {
                netif_queue_set_napi(tp->dev, txq_idx, NETDEV_QUEUE_TYPE_TX,
                                     &tnapi->napi);
                txq_idx++ 
          } else if (tnapi->rx_rcb) {
                 netif_queue_set_napi(tp->dev, rxq_idx, NETDEV_QUEUE_TYPE_RX,
                                      &tnapi->napi);
                 rxq_idx++;
          [...]

I tested that and the output looks correct to me. However, what to
do about tg3_napi_disable ?

Probably something like this (txq only for brevity):

  int txq_idx = tp->txq_cnt - 1;
  [...]

  for (i = tp->irq_cnt - 1; i >= 0; i--) {
    [...]
    if (tnapi->tx_buffers) {
        netif_queue_set_napi(tp->dev, txq_idx, NETDEV_QUEUE_TYPE_TX,
                             NULL);
        txq_idx--;
    }
    [...]

Does that seem correct to you? I wanted to ask before sending
another revision, since I am not a tg3 expert.

I will of course remove your Reviewed-by from this patch (but leave
it on patch 1 which is unmodified) when I resend it.

