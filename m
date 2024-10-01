Return-Path: <netdev+bounces-130909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B1598BFDF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8A51C23742
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2521C68B3;
	Tue,  1 Oct 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="b4kZGcJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415319D06E
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792913; cv=none; b=MAZ5eJ7QMyLBR+6zGmTwZCR8qm8g7S3udq2Jwz7RIl1rqVeA9BA+P+InKw52d1WFnsMz7DaK+zMIcUOOlv5cbcZWP/pznw37wz5rfIayGNGKqCq4CZdYr3jMkwnNdJ4g9BBxKA3whngWxFOStCO62UrX1+gtgjV6Ov9/7+HmoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792913; c=relaxed/simple;
	bh=fjOy2zZ3GK1y+nU2yQ3naJCNXt7vEPXcel6WkVrmH9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6K/Tnobxw/dSQf7JEr3CT7U8IX0URUlCsdOPTbsxboAQldVx8rZlv0zJnNRYvUnExzISFFmayYJU+Fd2hPdpa+mdlB3GBMGYJu24mXokHLAuWwFm2yIJm//qFa791ZsJbSfjH4ArX44aAdSDe+bz6omP5QK9xh8NHJqCJXH8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=b4kZGcJO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b7259be6fso28105345ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727792911; x=1728397711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOF0GWvnEPqrZ0H2jwx7NQt72HcvOEJ5C0SLw3lM530=;
        b=b4kZGcJOPsO6g1J0YTNFclk3TTlgt9Nx99cd3lGk1Uqvx/PI/vvjkE/cUaSejWWtRV
         Ys8LwtBQ78xTVmLCNm7VvZQ9+tZGUrkg2fAqYuBSm5tpq2HOOPzoY4aQR4cn48in5Xxh
         Oj1orv7OCFU79+FAGjwIv3E5gy3WCRq8u42lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792911; x=1728397711;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOF0GWvnEPqrZ0H2jwx7NQt72HcvOEJ5C0SLw3lM530=;
        b=ULrlvpV9KBOWZ+VJseh+UVG1sYDDjhRnf2hrty8ERj7LsR8FvfmDCcYuf2qMZ0NyP8
         Anfc8qOdiFGVfjWcPx35SqIsKXSjO0ugd29TJE/BASwdMqehvxpDDBaJQIzBYjyLpAIK
         TMPi+kpqbOdMqJ6BXLQImVl5ibnT4//7s14BGNjQhnmMWFfFZRHgey1Uo70Df5OxgW9w
         b8AX/+Zk52XqWkVrSDU5S3KfpMJMilBUB6sRoEs1To+iJ6UaICIzl0VA/j+CVoKHXjtm
         xCkP+5qbcRX4cwicoW/DNn4e+QdRogWOZJqQ+E2TTLLboaKhSxPwB3Pc6zQqIt2utQDA
         MIjw==
X-Gm-Message-State: AOJu0Yxl4xzni9nzspN2YkYsG6defBWwwild0E6VmDeyL9vLHqBrS4Xy
	4x/k28NmU8E7LII0chRPKwkfgCCKmK1VCLs7lQcsOYp7xf9uYTLroPzZpZ1zYQY=
X-Google-Smtp-Source: AGHT+IF7K2L2iuJ/fe+OrSotNCP+yQ3syTvOPGEn34rUCZ4jrEPGmpEr4GjHzNCnor5AXoUb2l/aig==
X-Received: by 2002:a17:902:f691:b0:20b:90ab:67de with SMTP id d9443c01a7336-20b90ab6d1bmr92688855ad.8.1727792910630;
        Tue, 01 Oct 2024 07:28:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d65asm69507325ad.123.2024.10.01.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 07:28:30 -0700 (PDT)
Date: Tue, 1 Oct 2024 07:28:27 -0700
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
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
Subject: Re: [net-next 2/2] ena: Link queues to NAPIs
Message-ID: <ZvwHC6VLihXevnPo@LQ3V64L9R2>
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
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
 <20240930195617.37369-3-jdamato@fastly.com>
 <eb828dd9f65847a49eb64763740c84ff@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb828dd9f65847a49eb64763740c84ff@amazon.com>

On Tue, Oct 01, 2024 at 09:06:16AM +0000, Arinzon, David wrote:
> > Link queues to NAPIs using the netdev-genl API so this information is
> > queryable.
> > 
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump queue-get --json='{"ifindex": 2}'
> > 
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
> >  {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'rx'},
> >  {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'rx'},
> >  {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'rx'},
> >  {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'},
> >  {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'tx'},
> >  {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'tx'},
> >  {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'tx'},
> >  {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'tx'}]
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/amazon/ena/ena_netdev.c | 26
> > +++++++++++++++++---
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > index e88de5e426ef..1c59aedaa5d5 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -1821,20 +1821,38 @@ static void ena_napi_disable_in_range(struct
> > ena_adapter *adapter,
> >                                       int first_index,
> >                                       int count)  {
> > +       struct napi_struct *napi;
> 
> Is this variable necessary? It has been defined in the enable function because
> it is needed in netif_queue_set_napi() API as well as in napi_enable(),
> and it makes sense in order to avoid long lines
> In here, the variable is only used in a call to napi_disable(), can the code
> be kept as it is? don't see a need to shorten the napi_disable() call line.

It is true that its only used to call napi_disable so if you prefer
to have it removed let me know?

I think it looks nicer with the variable, but it's your driver.

> >         int i;
> > 
> > -       for (i = first_index; i < first_index + count; i++)
> > -               napi_disable(&adapter->ena_napi[i].napi);
> > +       for (i = first_index; i < first_index + count; i++) {
> > +               napi = &adapter->ena_napi[i].napi;
> > +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
> > +                       netif_queue_set_napi(adapter->netdev, i,
> > +                                            NETDEV_QUEUE_TYPE_TX, NULL);
> > +                       netif_queue_set_napi(adapter->netdev, i,
> > +                                            NETDEV_QUEUE_TYPE_RX, NULL);
> > +               }
> > +               napi_disable(napi);
> > +       }
> >  }
> > 
> >  static void ena_napi_enable_in_range(struct ena_adapter *adapter,
> >                                      int first_index,
> >                                      int count)  {
> > +       struct napi_struct *napi;
> >         int i;
> > 
> > -       for (i = first_index; i < first_index + count; i++)
> > -               napi_enable(&adapter->ena_napi[i].napi);
> > +       for (i = first_index; i < first_index + count; i++) {
> > +               napi = &adapter->ena_napi[i].napi;
> > +               napi_enable(napi);
> > +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
> 
> Can you share some info on why you decided to set the queue to napi association
> only in non-xdp case?
> In XDP, there's a napi poll function that's executed and it runs on the TX queue.
> I am assuming that it's because XDP is not yet supported in the framework? If so,
> there's a need to add an explicit comment above if (!ENA_IS_XDP_INDEX(adapter, i)) {
> explaining this in order to avoid confusion with the rest of the code.

Yes; it is skipped for XDP queues, but they could be supported in
the future.

Other drivers that support this API work similarly (see also: bnxt,
ice, mlx4, etc).

> > +                       netif_queue_set_napi(adapter->netdev, i,
> > +                                            NETDEV_QUEUE_TYPE_RX, napi);
> > +                       netif_queue_set_napi(adapter->netdev, i,
> > +                                            NETDEV_QUEUE_TYPE_TX, napi);
> > +               }
> > +       }
> >  }
> > 
> >  /* Configure the Rx forwarding */
> > --
> > 2.43.0
> 
> Thank you for uploading this patch.

Can you please let me know (explicitly) if you want me to send a
second revision (when net-next allows for it) to remove the 'struct
napi_struct' and add a comment as described above?

