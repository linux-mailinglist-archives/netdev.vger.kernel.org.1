Return-Path: <netdev+bounces-134756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3999AFEE
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 03:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9D71F23DAE
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAADD2FF;
	Sat, 12 Oct 2024 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z/0WUiBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F2BE65
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698303; cv=none; b=ThGk5iyoYy2bX1PHpbQQ6PUHdZWI1S4jypyarVcM6wVG9LTXZE7T29Z7CsjG1YwBjqiIQBoNCHcpG77QEU+7VkNBGkwfRpQ7bY+bfuiyjXcGZa1MIjPMg+xTo5REcdKaL2WGOu6WqL2UFRsr1HEusC4aRBpENbXzqE1exRRd2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698303; c=relaxed/simple;
	bh=JYyhdjLuK+sa9K5bjE1c35qX1akVAJs5ZAijfqzQmpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNa23E5GZOnVyvkkGzJWt9W0C3gQroHFOcx4WmPLikM0U+fLQYvB10O3YfxoTvhxmrTXwvjBvhRJJn9Xio0twcvgNvaFsR4rISefBuU1BbcDoanYvH/95KsFqoxyPKszeIEIyjYZrs3iWQAFAF4DriZUsmRMpb2Y7MG8bQ5ilDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z/0WUiBW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c803787abso17911345ad.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728698301; x=1729303101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPTxo3VFYU4gU7ufZRtzjpXalxztZVEPSaPzwsbMAL4=;
        b=Z/0WUiBWQSuZ2BqmSHQ1tFPqHEc2V4hRBCWntI1URq1lEfG0GZ6+HmLZgsff+4xeWt
         1lbWez7Co1Gx7ozPYGN4YDFk0n1Y9gsj2rTXg+LFLfl6zYX9FjmwdjZ14aa50BvkegQE
         PRoKvZutJcn4jkZEkS99lQmHY9rPW4VCU0cFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728698301; x=1729303101;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPTxo3VFYU4gU7ufZRtzjpXalxztZVEPSaPzwsbMAL4=;
        b=w6pN3IrNicoU64GtlBKVIk3oLLp7wA/FKM0xb6INYMgijWOrB1UqeBFB7bUf3tev7y
         HDYs3TtUtkx3fB6vQtNHD+mrX5hIw9jcGb6crn+X7+TF7C0ai57fGtzpTMuRrcfPYxSN
         cNqN4p1DagZh6n5eBEs8w2mtKE2AnrQ5yyEb4FkjxJxRCUXJPBSF0R9TADbKFCQpmwxP
         I7Bsu+yuKnn+QDLkLkxz5YkgDR/B9mYh8K1QA46w4DJaklp0vcKDXYa78DdtGArT3GKw
         G+DIPDk1noWrXEisygG38Le3MEUPb9Ui7Ss49gSIbaQuDzfkE7Tv0nfvZoqJGajakv1v
         FQHg==
X-Gm-Message-State: AOJu0YzzsPEpWbtKolUmzUs5QtiXAmunKOu+CisQUYeqD27hwlABhEX6
	yq0Feo7zp9hObsPKnDdE946o/WDfOdLygcjrirkceek1dwgYTJLE7lCKpYqg5Xc=
X-Google-Smtp-Source: AGHT+IFVwIQ6PMGM56eLlaZkrc08o6k3Sy0bydvPmDgSTXAqrEzreKcjXkDt2YW3st/N3yNRzoCaPA==
X-Received: by 2002:a17:902:c403:b0:20b:c043:3873 with SMTP id d9443c01a7336-20ca03d6844mr64920765ad.21.1728698300799;
        Fri, 11 Oct 2024 18:58:20 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad9b4asm29730905ad.45.2024.10.11.18.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:58:20 -0700 (PDT)
Date: Fri, 11 Oct 2024 18:58:17 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 2/2] igc: Link queues to NAPI instances
Message-ID: <ZwnXuSUbaFiyGn52@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241003233850.199495-1-jdamato@fastly.com>
 <20241003233850.199495-3-jdamato@fastly.com>
 <87msjg46lw.fsf@kurt.kurt.home>
 <Zwa3sW-4s7oqktX3@LQ3V64L9R2>
 <87wmig3063.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmig3063.fsf@kurt.kurt.home>

On Thu, Oct 10, 2024 at 09:08:20AM +0200, Kurt Kanzenbach wrote:
> On Wed Oct 09 2024, Joe Damato wrote:
> > On Mon, Oct 07, 2024 at 11:14:51AM +0200, Kurt Kanzenbach wrote:
> >> Hi Joe,
> >> 
> >> On Thu Oct 03 2024, Joe Damato wrote:
> >> > Link queues to NAPI instances via netdev-genl API so that users can
> >> > query this information with netlink:
> >> >
> >> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >> >                          --dump queue-get --json='{"ifindex": 2}'
> >> >
> >> > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> >> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> >> >  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
> >> >  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
> >> >  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> >> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
> >> >  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> >> >  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> >> >
> >> > Since igc uses only combined queues, you'll note that the same NAPI ID
> >> > is present for both rx and tx queues at the same index, for example
> >> > index 0:
> >> >
> >> > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> >> > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> >> >
> >> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> >> > ---
> >> >  drivers/net/ethernet/intel/igc/igc_main.c | 30 ++++++++++++++++++++---
> >> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> >> > index 7964bbedb16c..b3bd5bf29fa7 100644
> >> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> >> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> >> > @@ -4955,6 +4955,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
> >> >  void igc_up(struct igc_adapter *adapter)
> >> >  {
> >> >  	struct igc_hw *hw = &adapter->hw;
> >> > +	struct napi_struct *napi;
> >> >  	int i = 0;
> >> >  
> >> >  	/* hardware has been reset, we need to reload some things */
> >> > @@ -4962,8 +4963,17 @@ void igc_up(struct igc_adapter *adapter)
> >> >  
> >> >  	clear_bit(__IGC_DOWN, &adapter->state);
> >> >  
> >> > -	for (i = 0; i < adapter->num_q_vectors; i++)
> >> > -		napi_enable(&adapter->q_vector[i]->napi);
> >> > +	for (i = 0; i < adapter->num_q_vectors; i++) {
> >> > +		napi = &adapter->q_vector[i]->napi;
> >> > +		napi_enable(napi);
> >> > +		/* igc only supports combined queues, so link each NAPI to both
> >> > +		 * TX and RX
> >> > +		 */
> >> 
> >> igc has IGC_FLAG_QUEUE_PAIRS. For example there may be 2 queues
> >> configured, but 4 vectors active (and 4 IRQs). Is your patch working
> >> with that?  Can be tested easily with `ethtool -L <inf> combined 2` or
> >> by booting with only 2 CPUs.
> >
> > I tested what you asked, here's what it looks like on my system:
> 
> Thanks.
> 
> >
> > 16 core Intel(R) Core(TM) i7-1360P
> >
> > lspci:
> > Ethernet controller: Intel Corporation Device 125c (rev 04)
> >                      Subsystem: Intel Corporation Device 3037
> >
> > ethtool -i:
> > firmware-version: 2017:888d
> >
> > $ sudo ethtool -L enp86s0 combined 2
> > $ sudo ethtool -l enp86s0
> > Channel parameters for enp86s0:
> > Pre-set maximums:
> > RX:		n/a
> > TX:		n/a
> > Other:		1
> > Combined:	4
> > Current hardware settings:
> > RX:		n/a
> > TX:		n/a
> > Other:		1
> > Combined:	2
> >
> > $ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
> >  144
> >  145
> >  146
> >  147
> >  148
> >
> > Note that IRQ 144 is the "other" IRQ, so if we ignore that one...
> > /proc/interrupts shows 4 IRQs, despite there being only 2 queues.
> >
> > Querying netlink to see which IRQs map to which NAPIs:
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump napi-get --json='{"ifindex": 2}'
> > [{'id': 8200, 'ifindex': 2, 'irq': 148},
> >  {'id': 8199, 'ifindex': 2, 'irq': 147},
> >  {'id': 8198, 'ifindex': 2, 'irq': 146},
> >  {'id': 8197, 'ifindex': 2, 'irq': 145}]
> >
> > This suggests that all 4 IRQs are assigned to a NAPI (this mapping
> > happens due to netif_napi_set_irq in patch 1).
> >
> > Now query the queues and which NAPIs they are associated with (which
> > is what patch 2 adds):
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \ 
> >                          --dump queue-get --json='{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'napi-id': 8197, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8198, 'type': 'tx'}]
> >
> > As you can see above, since the queues are combined and there are
> > only 2 of them, NAPI IDs 8197 and 8198 (which are triggered via IRQ
> > 145 and 146) are displayed.
> 
> Is that really correct?

So I definitely think the case where IGC_FLAG_QUEUE_PAIRS is enabled is
correct, that case is highlighted by the original commit message.

I think IGC_FLAG_QUEUE_PAIRS disabled was buggy, as you pointed out, and I've
made a change I'll include in the next RFC, which I believe fixes it.

Please see below for the case where IGC_FLAG_QUEUE_PAIRS is disabled and a
walk-through.

> There are four NAPI IDs which are triggered by
> the four IRQs.

I'm not an IGC expert and I appreciate your review/comments very much, so thank
you!

I don't think the number of queues I create with ethtool factors into whether
or not IGC_FLAG_QUEUE_PAIRS is enabled or not. Please forgive me for the length
of my message, but let me walk through the code to see if I've gotten it right,
including some debug output I added:

In igc_init_queue_configuration:

max_rss_queues = IGC_MAX_RX_QUEUES (4)

and

adapter->rss_queues = min of 4 or num_online_cpus

which I presume is 16 on my 16 core machine, so:

adapter->rss_queues = 4 (see below for debug output which verifies this)

In igc_set_flag_queue_pairs, the flag IGC_FLAG_QUEUE_PAIRS is set only if:

(adapter->rss_queues (4) > max_rss_queues(4) / 2) which simplifies
to (4 > 2), meaning the flag would be enabled regardless of the
number of queues I create with ethtool, as long as I boot my machine
with 16 cores available.

I verified this by adding debug output to igc_set_flag_queue_pairs and
igc_init_queue_configuration, which outputs:

igc 0000:56:00.0: IGC_FLAG_QUEUE_PAIRS on
igc 0000:56:00.0: max_rss_queues: 4, rss_queues: 4

That's at boot with the default number of combined queues of 4 (which is also
the hardware max).

The result of IGC_FLAG_QUEUE_PAIRS on was the result posted in the
original commit message of this patch and I believe that to be
correct.

The only place I can see that IGC_FLAG_QUEUE_PAIRS has any impact
(aside from ethtool IRQ coalescing, which we can ignore) is
igc_set_interrupt_capability:

  /* start with one vector for every Rx queue */
  numvecs = adapter->num_rx_queues;
  
  /* if Tx handler is separate add 1 for every Tx queue */
  if (!(adapter->flags & IGC_FLAG_QUEUE_PAIRS))
    numvecs += adapter->num_tx_queues;

In this case, the flag only has impact if it is _off_.

It impacts the number of vectors allocated, so I made a small change
to the driver, which I'll include in the next RFC to deal with the
IGC_FLAG_QUEUE_PAIRS off case.

In order to get IGC_FLAG_QUEUE_PAIRS off, I boot my machine with the grub
command line option "maxcpus=2", which should force the flag off.

Checking my debug output at boot to make sure:

igc 0000:56:00.0: IGC_FLAG_QUEUE_PAIRS off
igc 0000:56:00.0: max_rss_queues: 4, rss_queues: 2

So, now IGC_FLAG_QUEUE_PAIRS is off which should impact
igc_set_interrupt_capability and the vector calculation.

Let's check how things look at boot:

$ ethtool -l enp86s0 | tail -5
Current hardware settings:
RX:		n/a
TX:		n/a
Other:		1
Combined:	2

2 combined queues by default when I have 2 CPUs.

$ cat /proc/interrupts  | grep enp
 127:  enp86s0
 128:  enp86s0-rx-0
 129:  enp86s0-rx-1
 130:  enp86s0-tx-0
 131:  enp86s0-tx-1

1 other IRQ, and 2 IRQs for each of RX and TX.

Compare to netlink:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                       --dump napi-get --json='{"ifindex": 2}'
[{'id': 8196, 'ifindex': 2, 'irq': 131},
 {'id': 8195, 'ifindex': 2, 'irq': 130},
 {'id': 8194, 'ifindex': 2, 'irq': 129},
 {'id': 8193, 'ifindex': 2, 'irq': 128}]

So the driver has 4 IRQs linked to 4 different NAPIs, let's check queues:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]

In this case you can see that each RX and TX queue has a unique NAPI.

I think this is correct, but slightly confusing :) as ethtool
reports n/a for RX and TX and only reports a combined queue count,
but you were correct that there was a bug for this case in the code
I proposed in this RFC.

I think this new output looks correct and will include the adjusted
patch and a detailed commit message in the next RFC.

Let me know if you think the output looks right to you now?

