Return-Path: <netdev+bounces-162681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ACEA279B9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E9D188253D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA5217707;
	Tue,  4 Feb 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XRh0CJtc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CE217675
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693708; cv=none; b=cMWkz/s4UhLvHefMGeniffyCHZcTRA85fylLF5BgqiiW20tVh3JaTjeB9h+TxK1qgbU9GP+2CxSGBOXaENZTlq+St7xvM22xxSn8gdWvyBVqDHIRpzFMve9Qsb9ai+3uqwPYzDOOEkScarwpWCgC+C+gatwE4VU/qcUrIgrmJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693708; c=relaxed/simple;
	bh=AQhmKbtg1pduwiPcBd8kSw2dcbXPSj8PxbDEVcvjfIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrOxo6HVdIMyYT/6NYp8wiIYjYaFZZ/rvXt62OtULktwU9sVXiKVesQw+Pbp8MgaxpVrZ8/GqV1Jm/B52j5iACdX4J3pv0LhW5BrdNyaiSxINMHxIL9SVi3swUsgKLL8ToN898B5YmL/xMv+a8RVvyCvaPAocCmT8KfJ/QCMYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XRh0CJtc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21effc750d2so19438085ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 10:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738693706; x=1739298506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpwkLu/KM6vrkAOkPfjjRePz2x6DxSmgv6WMUQgxnP0=;
        b=XRh0CJtcxsv6NruBgHfePiw7Dj/MzgvthbbJfnfvIY/5ps1/62OGyf3fYDXQiQ5E1s
         qDXMMAdiJEnBGQ0lXCuyp2qnSQIMs2yRzBVpHCeLV/2iZeS/V0SBYFXSoDHKqlYJ0J4C
         rQmfLZ5no5CG5mxt+95JdqUvMW3vjIvSz9L9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693706; x=1739298506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpwkLu/KM6vrkAOkPfjjRePz2x6DxSmgv6WMUQgxnP0=;
        b=XYvrp6rtHShtcQq3AdCs3B0Y4Ee45wd+FxzNi+SipLUQn11nUsrHALjpFTK5QEaCDR
         2clsWh7i96PHkD4ou+sNyoyJ5JAg1RcdOPsKmO9dSABcmzf56nZ2Aln2k1bqhVIT4bf2
         u/GnWC3oOri7JmeOPMI1YbnyEpmdqu2+FD2PChXvdTMdSpck5PNglVrawXn2Jsy2p0I+
         Yuy6JLi3rmb3ORWFwIz5c2eDY4Mwte26gvC0mgfYaVdlgNevPSqsMgIIdLarNbnm6Ja1
         7whVump4Qz+YQL5cCASicU8xVaDdfpMDf9WXCpCVUG9b8+OoyOfb+FS6+L/lzwRRA/zi
         cyZQ==
X-Gm-Message-State: AOJu0YwpGTJ4XNklRvahOXY/ateL6RHF77eSub0stOFUNI75ZhzGUAE2
	ngT5mpHA9ZKT5Mkk/7I0x5c6/zxfQlyT722OIYacGUtv3CGX8YfvQhKpfVK5rcB0yFg6ZDOpOe8
	9
X-Gm-Gg: ASbGncs3HpB7+WgpkGXiSYcRXkihVDBRkFCcVR1YbjzlAG5pBXJc+pyJOEGOrCjA5A0
	mvICyLzEu9afEdbZAq7pISWpPS9CH3vuW6yaXxyUDjKoWruvKGPAZFUDOsADnMxtfwVkEyEui2Y
	uLXPlIRlVmhgMfF6IDsKzHEV3cNjHoJdGS3ib5ljcFEB5sYfjzlkknFTYniIE2yS26iu3qZ2Knr
	LD4o8ovOWsJj9AVQQ0CHQRXrz7i/02J08+UzgDeuv3S2lqadxEiFUYoXa/6JUrJf+WK3dMGoW7T
	TmBnX4mSa0lSMyNFtHFrSlLDfUHDXsyXpecdd/NWpMO0IkA31keEWTWwIw==
X-Google-Smtp-Source: AGHT+IESH7rvOjvQqQpDRnYB7plwMyi+XGz1EDdB2sknGAaIrG0ap9pCxfWdg/DN6W8STdFM5HdFAg==
X-Received: by 2002:a17:902:ea0a:b0:21f:a02:2c17 with SMTP id d9443c01a7336-21f0a022cb7mr37866645ad.45.1738693706150;
        Tue, 04 Feb 2025 10:28:26 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f165298e8sm840215ad.216.2025.02.04.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:28:25 -0800 (PST)
Date: Tue, 4 Feb 2025 10:28:23 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdev-genl: Elide napi_id when not present
Message-ID: <Z6JcR5IH8WzH1lP9@LQ3V64L9R2>
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

I'm not sure what the right etiquette is; I was thinking of just
taking the patch you proposed below and submitting it with you as
the author with my Reviewed-by.

Is that OK and if so, are you OK with the commit message?

