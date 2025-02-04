Return-Path: <netdev+bounces-162677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FAEA27981
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0171218823C4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB51921770C;
	Tue,  4 Feb 2025 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DN1Y8Q+O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CDE21766E
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692815; cv=none; b=KMb72MRnhcmnI1l86ZY4QjkagHMBS4LYaBq+vzcRh9xsTS4YC6lg02A16/rhujf1VLRtqeO//EMbjRsXGNIADclcebwZ3NnZq8DiU+UGESP9BaFSniiCb9bDTSQwcKRznkoPxq1S4wtQpSoB0New74+nflGpVFNgDiE1QvSy2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692815; c=relaxed/simple;
	bh=ABeCt5RQl/OtYqxEp27acHnOBV6LCKQEjwGGJd4EmN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1wTbMZ8KRmvfAzNa+amCl7BDMP8R8KQ5YPjeSDQJ45Ab3Upx82o8cKyXcoaXocUQW9GcPYTlGpwvC1jd0lp3pxXN63yqmmD41cHEHvYKnKYzOlNFeEs5zB/Cydm1UxHdEftMtGqrzxI2WD9UUFyEbeU1TkJLEVAu2GYUN90HpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DN1Y8Q+O; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso7631155a91.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738692812; x=1739297612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jOlwUXhleVpVW96ZqZRH18mvt7irgV17WG7W+qTWSs=;
        b=DN1Y8Q+O1fBxmpn2nOOamIDNIcD6G+DsWo5nA+DbgO4KnE2LvOLLZ3Fa1374qdc7re
         /3e92a1lkjqwbN0wFCribyEIGO8AgcXLJHmwY+SVVZoh3iePV7xWtl5TvvL32q4e9aJE
         s/Xsm427ly0+CjokCSAfSqA/Qdy7F/K+Txomc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692812; x=1739297612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jOlwUXhleVpVW96ZqZRH18mvt7irgV17WG7W+qTWSs=;
        b=HIxmjUtidTdbZ1F5hYiDmRD3OHDQMXUCJNIrTZQkXF8/YW9JFgO4W1l68z8x3cGG17
         /nRyIowmmYiPdXT4tSs5ZZ7YlVuO4HcAfLvqZBPnRVvgS9x63opPWH2x/bsNVFHM0vF9
         ZewGgztqvYSsoJnHJ6zKcM8iEPcJKz3I81nLf0J8A0Dr7aeJVvgM31VwrHg/AlWisJyS
         Talmta7C751wI4QAsPCuXu5wgepOcq5o6OGOuflY8pykY/9ZG7k/MnMQQluNZOBqcaCM
         4z6Lba/vpBUUDTdk3K0XwPUrQoFm0FcbQl5/iG78UAi6wj2agZit4+iex/T6WXlozLz/
         v0HA==
X-Gm-Message-State: AOJu0Yydxj+G2bUIlT4c+r9aFb2nM0KA8WO1SfaRh6Y1qn3u5AvYBrLn
	pKlGFIhNqnTKnD7avDrVZP1T1MoEZJ6Y+kqkur5h7f7Ft3x72IJpBJiTyplGNkA=
X-Gm-Gg: ASbGncsF31Xxx4Kxe863S0aVeYIBr//A3ieVjGLOlLdU2zal7iYrqZC9FkaqRtjd5vV
	vC3vqTBSwct6wzEOfxwZrr2gsQl8klw7lmts3yElV01Pe8xq5SijbppamZiYtukmCmxU26xJOMu
	rDR+Xl4UnYjELzKn+Edrby8Fx6n8OmhvKtZdrRMTsEAHpMLV7pJtf05A1hGmvsIRu/Fi8PRcAXZ
	Ijnkddm933Q8SgQB/cQDJ0vd5FwwvHoZx/z71qjRMrQ2AktLpUl3UBRPM7yXHrnUI1zMQnkG6t8
	yXpHA2c6rcskIH/oUdBcJFYul1CCqoZ9PopP73gFb0Xg830/k91CfjGuuQ==
X-Google-Smtp-Source: AGHT+IFtjkOAfwfYO8hVjlh+QcCog+25LHHkluPpKbr5sJcAhRMEZztXzq6nUMVz1VaTaoEequ5dZw==
X-Received: by 2002:a17:90b:2c84:b0:2ee:b2e6:4275 with SMTP id 98e67ed59e1d1-2f83ac65958mr33338939a91.26.1738692812469;
        Tue, 04 Feb 2025 10:13:32 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc97d25sm13987346a91.5.2025.02.04.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:13:32 -0800 (PST)
Date: Tue, 4 Feb 2025 10:13:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdev-genl: Elide napi_id when not present
Message-ID: <Z6JYyak3nuQaJNgJ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	kuba@kernel.org, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250203191714.155526-1-jdamato@fastly.com>
 <CANn89i+vf5=6f8kuZKCmP66P1LWGmAj06i+NhgqpFLVR8K5bEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+vf5=6f8kuZKCmP66P1LWGmAj06i+NhgqpFLVR8K5bEA@mail.gmail.com>

On Tue, Feb 04, 2025 at 06:41:34AM +0100, Eric Dumazet wrote:
> On Mon, Feb 3, 2025 at 8:17 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > There are at least two cases where napi_id may not present and the
> > napi_id should be elided:
> >
> > 1. Queues could be created, but napi_enable may not have been called
> >    yet. In this case, there may be a NAPI but it may not have an ID and
> >    output of a napi_id should be elided.
> >
> > 2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
> >    to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
> >    output as a NAPI ID of 0 is not useful for users.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  v2:
> >    - Updated to elide NAPI IDs for RX queues which may have not called
> >      napi_enable yet.
> >
> >  rfc: https://lore.kernel.org/lkml/20250128163038.429864-1-jdamato@fastly.com/
> >  net/core/netdev-genl.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 715f85c6b62e..a97d3b99f6cd 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -385,9 +385,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
> >         switch (q_type) {
> >         case NETDEV_QUEUE_TYPE_RX:
> >                 rxq = __netif_get_rx_queue(netdev, q_idx);
> > -               if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> > -                                            rxq->napi->napi_id))
> > -                       goto nla_put_failure;
> > +               if (rxq->napi && rxq->napi->napi_id >= MIN_NAPI_ID)
> > +                       if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> > +                                       rxq->napi->napi_id))
> > +                               goto nla_put_failure;
> >
> >                 binding = rxq->mp_params.mp_priv;
> >                 if (binding &&
> > @@ -397,9 +398,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
> >                 break;
> >         case NETDEV_QUEUE_TYPE_TX:
> >                 txq = netdev_get_tx_queue(netdev, q_idx);
> > -               if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> > -                                            txq->napi->napi_id))
> > -                       goto nla_put_failure;
> > +               if (txq->napi && txq->napi->napi_id >= MIN_NAPI_ID)
> > +                       if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> > +                                       txq->napi->napi_id))
> > +                               goto nla_put_failure;
> >         }
> 
> Hi Joe
> 
> This might be time to add helpers, we now have these checks about
> MIN_NAPI_ID all around the places.

Thanks that's a good idea. I'll add that for the v3.

