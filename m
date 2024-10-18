Return-Path: <netdev+bounces-137073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C09A4447
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79807B23572
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC3204002;
	Fri, 18 Oct 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bnCMsTGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7042036E9
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271082; cv=none; b=ADGE1lYybJn47yfkTobkGCC8V/Gx0y5NKjv4DIUs8M92RBLiCW1qKMLSZ3c/E385SN9DX2QS0zg8D6dTdmDoR0/QRKmrLj9YuIS4R/zkDVHUoxl7l8BUT2ryFrQzGh9uMjqEWg6lMXtFOjGzOLG+XeyRdsFpg6/5QLgF5urcJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271082; c=relaxed/simple;
	bh=jEbwmXDlyjCibKTNMv24TwqrHjApLHR6NvvSxLCBnLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN4Ug8hhb60m0PQUBCEIUKFGGAK7Fmum4GO9urgCMS4/LstDWFHGce/1Kw6Wldt/h0jwC+KC0UMpgtyXIC6JkrDtlzMw52zDhRjTWrga8CMBwkZAB5d8ErBUTeZyLmu8Zyh/wr1xkyDG0tiQ/AqXiCeUX9IRHungdXqkXTQFl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bnCMsTGP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e6cec7227so1906819b3a.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729271079; x=1729875879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCMQDa/dP8RDWv8tfIk4E6+eiiSMZlKszynM6qeVdr8=;
        b=bnCMsTGPbnurnITwaWWXStp9QrMSL2e715utPGxD1LHUQkJB2mNEJITJhfnswIbb7T
         bKvFJi7DXbeEeGi7fPtsN0+caxyco8aZ6+boCR3r8h+fyOo8lE5RiZpDnO9Ip5OKozhj
         E2E8U7Dx3QC8p5WcHi4G6T3Yc/MmFZi92RkMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271079; x=1729875879;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCMQDa/dP8RDWv8tfIk4E6+eiiSMZlKszynM6qeVdr8=;
        b=DdHtX3QWNJRa9RgQJ9J1+eHLsUBEIGQS4dLOeOuVSkaaVqBhB6byS2jKaeciZyfu/Y
         p9FCyyFX89fVY5iukabJE8A5iyZLXNQ1CiwkRCZW2FkeDYNxZVWxVh0QlgnKz+Zvu/ih
         7V2d7ai3VYOsjkumciG8Jf/3kHwTTXM835aPmjR3EFEy212geYw2hzG7U2n6wGFksGGU
         kl3Xi+Aq+ED8/m/Qj8OM3cvt17O/LvyLsQJwiDnb1QoIerlBCgRoFx4JWklpEzVGXKgM
         VZsXv5479kJPioILKZDn4Ok8v4J2T5zauYemuo7rFEeD0c+rIHWk5FlcciZ42t5WE2mB
         q9eQ==
X-Gm-Message-State: AOJu0YwjtqDwDRqP01Pj9Ya/AP+G25PEdxj7e8htUOEezEdLxgOkGLfG
	85snWFOJaD4mXTPVbUVslLGiblLlu6a43bAU56B4WO557J5BDNFoaRHl0mHXprE=
X-Google-Smtp-Source: AGHT+IE0G/O/vUc33igo/n3Q/6L0CYUI2iXIetuWqMCaUU7jmAzUGItm6+7bfb3fKzqj0wL1ZAFAgQ==
X-Received: by 2002:a05:6a00:4b4c:b0:70b:176e:b3bc with SMTP id d2e1a72fcca58-71ea31f6287mr4479529b3a.28.1729271078666;
        Fri, 18 Oct 2024 10:04:38 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3312d5csm1694348b3a.5.2024.10.18.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:04:38 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:04:35 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, vinicius.gomes@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] igc: Link queues to NAPI instances
Message-ID: <ZxKVI_DvFWBvRMaf@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	vinicius.gomes@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
References: <20241014213012.187976-1-jdamato@fastly.com>
 <20241014213012.187976-3-jdamato@fastly.com>
 <87h69d3bm2.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h69d3bm2.fsf@kurt.kurt.home>

On Tue, Oct 15, 2024 at 12:27:01PM +0200, Kurt Kanzenbach wrote:
> On Mon Oct 14 2024, Joe Damato wrote:

[...]

> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 7964bbedb16c..59c00acfa0ed 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -4948,6 +4948,47 @@ static int igc_sw_init(struct igc_adapter *adapter)
> >  	return 0;
> >  }
> >  
> > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> > +			struct napi_struct *napi)
> > +{
> > +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> > +		netif_queue_set_napi(adapter->netdev, q_idx,
> > +				     NETDEV_QUEUE_TYPE_RX, napi);
> > +		netif_queue_set_napi(adapter->netdev, q_idx,
> > +				     NETDEV_QUEUE_TYPE_TX, napi);
> > +	} else {
> > +		if (q_idx < adapter->num_rx_queues) {
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_RX, napi);
> > +		} else {
> > +			q_idx -= adapter->num_rx_queues;
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_TX, napi);
> > +		}
> > +	}
> > +}
> 
> In addition, to what Vinicius said. I think this can be done
> simpler. Something like this?
> 
> void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
> 			struct napi_struct *napi)
> {
> 	struct igc_q_vector *q_vector = adapter->q_vector[vector];
> 
> 	if (q_vector->rx.ring)
> 		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_RX, napi);
> 
> 	if (q_vector->tx.ring)
> 		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_TX, napi);
> }

I tried this suggestion but this does not result in correct output
in the case where IGC_FLAG_QUEUE_PAIRS is disabled.

The output from netlink:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                             --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'}]

Note the lack of a napi-id for the TX queues. This typically happens
when the linking is not done correctly; netif_queue_set_napi should
take a queue id as the second parameter.

I believe the suggested code above should be modified to be as
follows to use ring->queue_index:

  if (q_vector->rx.ring)
    netif_queue_set_napi(adapter->netdev,
                         q_vector->rx.ring->queue_index,
                         NETDEV_QUEUE_TYPE_RX, napi);
  
  if (q_vector->tx.ring)
    netif_queue_set_napi(adapter->netdev,
                         q_vector->tx.ring->queue_index,
                         NETDEV_QUEUE_TYPE_TX, napi);

Which produces correct output:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                             --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]

I wanted to send you a note about this before I post the v3 so that
if/when you review it you'll have the context as to why the v3 code
is slightly different than what was suggested.

