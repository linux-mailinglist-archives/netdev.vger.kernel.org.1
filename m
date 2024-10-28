Return-Path: <netdev+bounces-139621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD99B39A0
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15E31C21FA1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D741DF747;
	Mon, 28 Oct 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cL1wLOoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214C18C333
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141518; cv=none; b=pzoytD9/aL2jMCbzfGg/PXWKxV+HNjCm9h6c9lWj+KzenSYOy0azg6adzAcdngPKj0XqJVoIVfzAobels6eXSye1J3gQBkxEYweUoR1j62i9w136vbzJlIXMDTI+VNh+EMJDUPGwc5XPm9RkuZotaa1YrEomP2UsI4mqzO4yUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141518; c=relaxed/simple;
	bh=Q54nlgBjuBFB4r6tHPXM4j6dUaaYJxGNLaFDV8LGv84=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur2MdXcStwYWqRPmw3sM9DWIJfrHOOJp5fOSvxCB5YA6+rnBKEG8LH8idBx1BNLLOGhG+MJQrj8xrQWRtolMn4AWVgH4XkmimVAhmisVi+hfSxfa+ArzNi0p+aqgscmRs077/DsWVt9syhhVaEV1k2lymMptapZ94VI77HT7Sr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cL1wLOoa; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so216422a12.1
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730141515; x=1730746315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x499EQiG2Wmo1EmlB324vwf45OQNiIQd6JHEbQS0ZZ0=;
        b=cL1wLOoaseqJci0bbO0iEt9F27nLOafxEWI14QUrNPqSBwiqNHUm2IMFajVryZbDw4
         JbUMRSqBaW/ymi8MxoVsVH5L4+HkzfVx5Me0o3oK3XdCA3wa/G0UtGcFaSWr+SvI6Pe8
         p7zDvTEqgP3NNEASiNSa/0c+OSYccFudZdsgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141515; x=1730746315;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x499EQiG2Wmo1EmlB324vwf45OQNiIQd6JHEbQS0ZZ0=;
        b=PcAL51IQZ8zWsaap9FBK/nhoUoTUYtxCK+41QA/UO1RbAHOYRymPpkqMLAwihMx/z0
         vH/haQcnaBfyZFd511NoIS/cvDcoXZD1xEcT/l6Sr83jkntJ5ibNbGBQJVGYW4CSvQHt
         a+e8xRwfz4jrIALJC9jtpONUnvnBTLQpNitZtuLPx97Ck9dtuDtqrK7DTxoDSZtxgaLj
         +BB9AP3aE8LqHgUiN9y9weSSneqa/RXl4uSWY7Ma+P6vaZXQtQIflM4VGObPqbwG32xZ
         phTKLUrPZA93rO5fwmfNXIjdmOK5Cp7hG6tMMDo9DnJUw61JyetYMubVLZZBgk3h1I6G
         tuWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOkt1Oxw+uxzmeauihWAeykmKxC+87yK2UGbGAh4yKTu02j2bIOkzFLnPQas0H80zi/3E30b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JSUWbJNzTOOV66h+8L/wKlk5XOxGAohMr7hKeqRveBJep5rd
	NBclLswd4H0toZq9IFIqi/zfdh02I+ePxociNzQEPxbBGa8U635nT+Yljh88CMI=
X-Google-Smtp-Source: AGHT+IEZR/gF4/j9FU35yRUYoMuV73t1c1oyFaI+RLQe2U6webVUSu1hPPVgOwfuPAwgI/xzDKuJQw==
X-Received: by 2002:a05:6a20:cfa7:b0:1cf:6d20:4d6 with SMTP id adf61e73a8af0-1d9a83d5a7bmr12156551637.16.1730141514826;
        Mon, 28 Oct 2024 11:51:54 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793175bsm6116781b3a.48.2024.10.28.11.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:51:54 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:51:51 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"kurt@linutronix.de" <kurt@linutronix.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	stanislaw.gruszka@linux.intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v4 2/2] igc: Link queues to NAPI
 instances
Message-ID: <Zx_dRzBBtPK1pbDl@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"kurt@linutronix.de" <kurt@linutronix.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	stanislaw.gruszka@linux.intel.com
References: <20241022215246.307821-1-jdamato@fastly.com>
 <20241022215246.307821-3-jdamato@fastly.com>
 <d7799132-7e4a-0ac2-cbda-c919ce434fe2@intel.com>
 <Zx-yzhq4unv0gsVX@LQ3V64L9R2>
 <Zx-1BhZlXRQCImex@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx-1BhZlXRQCImex@LQ3V64L9R2>

On Mon, Oct 28, 2024 at 09:00:06AM -0700, Joe Damato wrote:
> On Mon, Oct 28, 2024 at 08:50:38AM -0700, Joe Damato wrote:
> > On Sun, Oct 27, 2024 at 11:49:33AM +0200, Lifshits, Vitaly wrote:
> > > 
> > > On 10/23/2024 12:52 AM, Joe Damato wrote:
> > > > Link queues to NAPI instances via netdev-genl API so that users can
> > > > query this information with netlink. Handle a few cases in the driver:
> > > >    1. Link/unlink the NAPIs when XDP is enabled/disabled
> > > >    2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
> > > > 
> > > > Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
> > > > 
> > > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > > >                           --dump queue-get --json='{"ifindex": 2}'
> > > > 
> > > > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> > > >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> > > >   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
> > > >   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
> > > >   {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> > > >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
> > > >   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> > > >   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> > > > 
> > > > Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
> > > > is present for both rx and tx queues at the same index, for example
> > > > index 0:
> > > > 
> > > > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> > > > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> > > > 
> > > > To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
> > > > the grub command line option "maxcpus=2" to force
> > > > igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.
> > > > 
> > > > Example output when IGC_FLAG_QUEUE_PAIRS is disabled:
> > > > 
> > > > $ lscpu | grep "On-line CPU"
> > > > On-line CPU(s) list:      0,2
> > > > 
> > > > $ ethtool -l enp86s0  | tail -5
> > > > Current hardware settings:
> > > > RX:		n/a
> > > > TX:		n/a
> > > > Other:		1
> > > > Combined:	2
> > > > 
> > > > $ cat /proc/interrupts  | grep enp
> > > >   144: [...] enp86s0
> > > >   145: [...] enp86s0-rx-0
> > > >   146: [...] enp86s0-rx-1
> > > >   147: [...] enp86s0-tx-0
> > > >   148: [...] enp86s0-tx-1
> > > > 
> > > > 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> > > > report 4 IRQs with unique NAPI IDs:
> > > > 
> > > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > > >                           --dump napi-get --json='{"ifindex": 2}'
> > > > [{'id': 8196, 'ifindex': 2, 'irq': 148},
> > > >   {'id': 8195, 'ifindex': 2, 'irq': 147},
> > > >   {'id': 8194, 'ifindex': 2, 'irq': 146},
> > > >   {'id': 8193, 'ifindex': 2, 'irq': 145}]
> > > > 
> > > > Now we examine which queues these NAPIs are associated with, expecting
> > > > that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> > > > have its own NAPI instance:
> > > > 
> > > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > > >                           --dump queue-get --json='{"ifindex": 2}'
> > > > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> > > >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> > > >   {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> > > >   {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> > > > 
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > > > ---
> > > >   v4:
> > > >     - Add rtnl_lock/rtnl_unlock in two paths: igc_resume and
> > > >       igc_io_error_detected. The code added to the latter is inspired by
> > > >       a similar implementation in ixgbe's ixgbe_io_error_detected.
> > > > 
> > > >   v3:
> > > >     - Replace igc_unset_queue_napi with igc_set_queue_napi(adapater, i,
> > > >       NULL), as suggested by Vinicius Costa Gomes
> > > >     - Simplify implemention of igc_set_queue_napi as suggested by Kurt
> > > >       Kanzenbach, with a tweak to use ring->queue_index
> > > > 
> > > >   v2:
> > > >     - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
> > > >       disabled
> > > >     - Refactored code to move napi queue mapping and unmapping to helper
> > > >       functions igc_set_queue_napi and igc_unset_queue_napi
> > > >     - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
> > > >     - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
> > > >       igc_xdp_enable_pool, and igc_xdp_disable_pool
> > > > 
> > > >   drivers/net/ethernet/intel/igc/igc.h      |  2 ++
> > > >   drivers/net/ethernet/intel/igc/igc_main.c | 41 ++++++++++++++++++++---
> > > >   drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 ++
> > > >   3 files changed, 40 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> > > > index eac0f966e0e4..b8111ad9a9a8 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc.h
> > > > +++ b/drivers/net/ethernet/intel/igc/igc.h
> > > > @@ -337,6 +337,8 @@ struct igc_adapter {
> > > >   	struct igc_led_classdev *leds;
> > > >   };
> > > > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> > > > +			struct napi_struct *napi);
> > > >   void igc_up(struct igc_adapter *adapter);
> > > >   void igc_down(struct igc_adapter *adapter);
> > > >   int igc_open(struct net_device *netdev);
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > index 7964bbedb16c..04aa216ef612 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > @@ -4948,6 +4948,22 @@ static int igc_sw_init(struct igc_adapter *adapter)
> > > >   	return 0;
> > > >   }
> > > > +void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
> > > > +			struct napi_struct *napi)
> > > > +{
> > > > +	struct igc_q_vector *q_vector = adapter->q_vector[vector];
> > > > +
> > > > +	if (q_vector->rx.ring)
> > > > +		netif_queue_set_napi(adapter->netdev,
> > > > +				     q_vector->rx.ring->queue_index,
> > > > +				     NETDEV_QUEUE_TYPE_RX, napi);
> > > > +
> > > > +	if (q_vector->tx.ring)
> > > > +		netif_queue_set_napi(adapter->netdev,
> > > > +				     q_vector->tx.ring->queue_index,
> > > > +				     NETDEV_QUEUE_TYPE_TX, napi);
> > > > +}
> > > > +
> > > >   /**
> > > >    * igc_up - Open the interface and prepare it to handle traffic
> > > >    * @adapter: board private structure
> > > > @@ -4955,6 +4971,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
> > > >   void igc_up(struct igc_adapter *adapter)
> > > >   {
> > > >   	struct igc_hw *hw = &adapter->hw;
> > > > +	struct napi_struct *napi;
> > > >   	int i = 0;
> > > >   	/* hardware has been reset, we need to reload some things */
> > > > @@ -4962,8 +4979,11 @@ void igc_up(struct igc_adapter *adapter)
> > > >   	clear_bit(__IGC_DOWN, &adapter->state);
> > > > -	for (i = 0; i < adapter->num_q_vectors; i++)
> > > > -		napi_enable(&adapter->q_vector[i]->napi);
> > > > +	for (i = 0; i < adapter->num_q_vectors; i++) {
> > > > +		napi = &adapter->q_vector[i]->napi;
> > > > +		napi_enable(napi);
> > > > +		igc_set_queue_napi(adapter, i, napi);
> > > > +	}
> > > >   	if (adapter->msix_entries)
> > > >   		igc_configure_msix(adapter);
> > > > @@ -5192,6 +5212,7 @@ void igc_down(struct igc_adapter *adapter)
> > > >   	for (i = 0; i < adapter->num_q_vectors; i++) {
> > > >   		if (adapter->q_vector[i]) {
> > > >   			napi_synchronize(&adapter->q_vector[i]->napi);
> > > > +			igc_set_queue_napi(adapter, i, NULL);
> > > >   			napi_disable(&adapter->q_vector[i]->napi);
> > > >   		}
> > > >   	}
> > > > @@ -6021,6 +6042,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
> > > >   	struct igc_adapter *adapter = netdev_priv(netdev);
> > > >   	struct pci_dev *pdev = adapter->pdev;
> > > >   	struct igc_hw *hw = &adapter->hw;
> > > > +	struct napi_struct *napi;
> > > >   	int err = 0;
> > > >   	int i = 0;
> > > > @@ -6056,8 +6078,11 @@ static int __igc_open(struct net_device *netdev, bool resuming)
> > > >   	clear_bit(__IGC_DOWN, &adapter->state);
> > > > -	for (i = 0; i < adapter->num_q_vectors; i++)
> > > > -		napi_enable(&adapter->q_vector[i]->napi);
> > > > +	for (i = 0; i < adapter->num_q_vectors; i++) {
> > > > +		napi = &adapter->q_vector[i]->napi;
> > > > +		napi_enable(napi);
> > > > +		igc_set_queue_napi(adapter, i, napi);
> > > > +	}
> > > >   	/* Clear any pending interrupts. */
> > > >   	rd32(IGC_ICR);
> > > > @@ -7385,7 +7410,9 @@ static int igc_resume(struct device *dev)
> > > >   	wr32(IGC_WUS, ~0);
> > > >   	if (netif_running(netdev)) {
> > > > +		rtnl_lock();
> > > 
> > > This change will bring back the deadlock issue that was fixed in commit:
> > > 6f31d6b: "igc: Refactor runtime power management flow".
> > 
> > OK, thanks for letting me know.
> > 
> > I think I better understand what the issue is. It seems that:
> > 
> > - igc_resume can be called with rtnl held via ethtool (which I
> >   didn't know), which calls __igc_open
> > - __igc_open re-enables NAPIs and re-links queues to NAPI IDs (which
> >   requires rtnl)
> > 
> > so, it seems like the rtnl_lock() I've added to igc_resume is
> > unnecessary.
> > 
> > I suppose I don't know all of the paths where the pm functions can
> > be called -- are there others where RTNL is _not_ already held?
> > 
> > I looked at e1000e and it seems that driver does not re-enable NAPIs
> > in its resume path and thus does not suffer from the same issue as
> > igc.
> > 
> > So my questions are:
> > 
> >   1. Are there are other contexts where igc_resume is called where
> >      RTNL is not held?
> > 
> >   2. If the answer is that RTNL is always held when igc_resume is
> >      called, then I can send a v5 that removes the
> >      rtnl_lock/rtnl_unlock. What do you think?
> 
> I see, so it looks like there is:
>    - resume
>    - runtime_resume
> 
> The bug I am reintroducing is runtime_resume already holding RTNL
> before my added call to rtnl_lock.
> 
> OK.
> 
> Does resume also hold rtnl before the driver's igc_resume is called?
> I am asking because I don't know much about how PM works.
> 
> If resume does not hold RTNL (but runtime resume does, as the bug
> you pointed out shows), it seems like a wrapper can be added to tell
> the code whether rtnl should be held or not based on which resume is
> happening.
> 
> Does anyone know if: resume (not runtime_resume) already holds RTNL?
> I'll try to take a look and see, but I am not very familiar with PM.

Well, I took a look and I'm probably wrong, but here's my
assessment:

- runtime_suspend can happen via ethtool or netlink when rtnl is
  held, so rtnl_lock will deadlock as pointed out above

- suspend happens via device_suspend in kernel/power/main.c, so I
  think taking rtnl is safe for "regular" suspend. Other drivers
  (like bnxt) seem to take rtnl in their "regular" suspend
  callbacks.

If the above assessment is correct, I think this change should fix
the issue Vitaly mentioned and I'll submit this as part of v5. It
adds a wrapper to tell igc_resume to either hold rtnl or not
depending on whether it's called from runtime_suspend or suspend.

I'll submit this as v5 shortly, and my apologies on my lack of
knowledge of PM; I am happy to perform any sort of testing on my igc
device you folks think would help verify that this is working
properly.

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 04aa216ef612..051a0cdb1143 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7367,7 +7367,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
        netif_rx(skb);
 }

-static int igc_resume(struct device *dev)
+static int __igc_do_resume(struct device *dev, bool need_rtnl)
 {
        struct pci_dev *pdev = to_pci_dev(dev);
        struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7410,9 +7410,11 @@ static int igc_resume(struct device *dev)
        wr32(IGC_WUS, ~0);

        if (netif_running(netdev)) {
-               rtnl_lock();
+               if (need_rtnl)
+                       rtnl_lock();
                err = __igc_open(netdev, true);
-               rtnl_unlock();
+               if (need_rtnl)
+                       rtnl_unlock();
                if (!err)
                        netif_device_attach(netdev);
        }
@@ -7420,9 +7422,14 @@ static int igc_resume(struct device *dev)
        return err;
 }

+static int igc_resume(struct device *dev)
+{
+       return __igc_do_resume(dev, true);
+}
+
 static int igc_runtime_resume(struct device *dev)
 {
-       return igc_resume(dev);
+       return __igc_do_resume(dev, false);
 }

 static int igc_suspend(struct device *dev)

