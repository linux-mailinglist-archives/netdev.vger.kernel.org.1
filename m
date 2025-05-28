Return-Path: <netdev+bounces-193960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F47AC6A0A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5436A4E2893
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDF5286880;
	Wed, 28 May 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FZVJWZNx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAB28642F;
	Wed, 28 May 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437822; cv=none; b=Ppb8GlNHqumfA0kOHPR9szCUWZ1fF+MuelUh8dLR1Uq3HRF6ZagNNIFNw6xeNa27DKAlbiPtVjnriwqw5uJa2stFoeF/mkDiVEgXdhQquKU0ecu2cqULRmvSXpiVavXVWepaa3HNR1VjHpkh/An9h3VFXRnvJhZakzu0vzowlYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437822; c=relaxed/simple;
	bh=3//2x1aqktliMt3C7OKPxIAa3P4Rzdpq3q8YXamdG9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS52oamZpGW73qxsfYtrUUHC0SM4a+G2N9YOBDHDg23IKeWI+fuLrP0pViAet6BgYHrztbu8wmswcAkdw9uF2wu46WTBrvi2kv0yI/kYGhfnTZAslctaCa+6lXWRzOg/AgjgqLz3lYaP0ODzS+iAi9qs6NkFext73536CLCYjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FZVJWZNx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCiolB005896;
	Wed, 28 May 2025 06:09:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=lhFFwHACWIeW/4ep5BhL9R3Wp
	6JYUJNGPHcV8EAW4ro=; b=FZVJWZNx1k5Ry+wcedX0t7LEWZ6oG0S/JJrhPlbQX
	krl7+d4j++obUfQqiT+zx+K1oIptoHlGb2rEAyO2jcxzvUWuKe4Ufdtt2EvEoxdI
	XX7JjVd0io4MmcekL4RXIhrE4HQVHXW1Licp5nfcW1NeaQ6ETyldHk1HqgyNF1K8
	3BhnpwEmTdSxzTDMbszAa0D6TKSo4OGsWxUrMzmnY0B8hXm5gnCPS0IpONgWxYQp
	Qp+1EkWktCxOk3FPYvpHy9eOFiQBFpa33Ypk5dPmhvPAAq8DsB6XkPQRD2XCUA21
	r6CGkrk3T72OKOjnGVDHGS/DfPKKv5+TTdaOKLNUYt5AA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46x2rkr2ug-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 06:09:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 06:09:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 06:09:40 -0700
Received: from f50a6ab61f9a (unknown [10.193.66.37])
	by maili.marvell.com (Postfix) with SMTP id 441653F7045;
	Wed, 28 May 2025 06:09:34 -0700 (PDT)
Date: Wed, 28 May 2025 13:09:33 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
CC: Sean Anderson <sean.anderson@linux.dev>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Simek, Michal"
	<michal.simek@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and report
 coalesce parameters in DMAengine flow
Message-ID: <aDcLDdKA2GNRIY3G@f50a6ab61f9a>
References: <20250525102217.1181104-1-suraj.gupta2@amd.com>
 <679d6810-9e76-425c-9d4e-d4b372928cc3@linux.dev>
 <BL3PR12MB6571ABA490895FDB8225CAEBC967A@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6571ABA490895FDB8225CAEBC967A@BL3PR12MB6571.namprd12.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDExNSBTYWx0ZWRfX6XRbvJ3Qdt9e mMPjkhiUIbUREw3clM21ckDVA+Bq6UwtCLBQwE4HZ+Kycg4VI4XAFmMMC7K9+m+GA9RRxn/GNT6 KGIRVrJK4d+HiEFevevglF1PRTu697xhCZY9esibIH6o6zpq1pk9qepkEvQTIvd6D4e1nvc9lLt
 Cw7kQMXec/ACqZSbZKXEsr2eHtMu1uXPKZJF4HwJF8VZmCPSkiSa6eAGRwphqEP40SfJCXgio4N g5N/+fAsC3mxb//WsyUIdn16iCxlfs8NVTMLhuvwEUB4pc35M9Fxo0AOkFpK6DCrWUa2XsyzSUv 9KP3Oq/+uc++YA6I9D5Cnj6b6GQK2u4dpJf/X0u2LxFZKRALmAuk3vG9CdUOf0U4LKbI1iRP9pA
 lxIvN8rngti42iDbo6BXv8jqaecDAcsfO1d7CzhTsXHIDY1u3l8avhiccTizflVBJ8TUFJ8T
X-Proofpoint-GUID: qPMMYTQBXYqk7OnWGy4VniD-WZ2prfLP
X-Authority-Analysis: v=2.4 cv=fvzcZE4f c=1 sm=1 tr=0 ts=68370b18 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=JfrnYn6hAAAA:8 a=Phdkh1rV2inUpnr7k2QA:9 a=CjuIK1q_8ugA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: qPMMYTQBXYqk7OnWGy4VniD-WZ2prfLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01

On 2025-05-28 at 12:00:56, Gupta, Suraj (Suraj.Gupta2@amd.com) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
Fix your mail settings. Cannot be internal if posting to mailing list :)

Thanks,
Sundeep

> > -----Original Message-----
> > From: Sean Anderson <sean.anderson@linux.dev>
> > Sent: Tuesday, May 27, 2025 9:47 PM
> > To: Gupta, Suraj <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; vkoul@kernel.org; Simek, Michal <michal.simek@amd.com>;
> > Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; horms@kernel.org
> > Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> > <harini.katakam@amd.com>
> > Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and report coalesce
> > parameters in DMAengine flow
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On 5/25/25 06:22, Suraj Gupta wrote:
> > > Add support to configure / report interrupt coalesce count and delay
> > > via ethtool in DMAEngine flow.
> > > Netperf numbers are not good when using non-dmaengine default values,
> > > so tuned coalesce count and delay and defined separate default values
> > > in dmaengine flow.
> > >
> > > Netperf numbers and CPU utilisation change in DMAengine flow after
> > > introducing coalescing with default parameters:
> > > coalesce parameters:
> > >    Transfer type        Before(w/o coalescing)  After(with coalescing)
> > > TCP Tx, CPU utilisation%      925, 27                 941, 22
> > > TCP Rx, CPU utilisation%      607, 32                 741, 36
> > > UDP Tx, CPU utilisation%      857, 31                 960, 28
> > > UDP Rx, CPU utilisation%      762, 26                 783, 18
> > >
> > > Above numbers are observed with 4x Cortex-a53.
> >
> > How does this affect latency? I would expect these RX settings to increase latency
> > around 5-10x. I only use these settings with DIM since it will disable coalescing
> > during periods of light load for better latency.
> >
> > (of course the way to fix this in general is RSS or some other method involving
> > multiple queues).
> >
> 
> I took values before NAPI addition in legacy flow (rx_threshold: 24, rx_usec: 50) as reference. But netperf numbers were low with them, so tried tuning both and selected the pair which gives good numbers.
> 
> > > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > > ---
> > > This patch depend on following AXI DMA dmengine driver changes sent to
> > > dmaengine mailing list as pre-requisit series:
> > > https://lore.kernel.org/all/20250525101617.1168991-1-suraj.gupta2@amd.
> > > com/
> > > ---
> > >  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  6 +++
> > > .../net/ethernet/xilinx/xilinx_axienet_main.c | 53 +++++++++++++++++++
> > >  2 files changed, 59 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> > > b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> > > index 5ff742103beb..cdf6cbb6f2fd 100644
> > > --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> > > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> > > @@ -126,6 +126,12 @@
> > >  #define XAXIDMA_DFT_TX_USEC          50
> > >  #define XAXIDMA_DFT_RX_USEC          16
> > >
> > > +/* Default TX/RX Threshold and delay timer values for SGDMA mode with
> > DMAEngine */
> > > +#define XAXIDMAENGINE_DFT_TX_THRESHOLD       16
> > > +#define XAXIDMAENGINE_DFT_TX_USEC    5
> > > +#define XAXIDMAENGINE_DFT_RX_THRESHOLD       24
> > > +#define XAXIDMAENGINE_DFT_RX_USEC    16
> > > +
> > >  #define XAXIDMA_BD_CTRL_TXSOF_MASK   0x08000000 /* First tx packet */
> > >  #define XAXIDMA_BD_CTRL_TXEOF_MASK   0x04000000 /* Last tx packet */
> > >  #define XAXIDMA_BD_CTRL_ALL_MASK     0x0C000000 /* All control bits */
> > > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > index 1b7a653c1f4e..f9c7d90d4ecb 100644
> > > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > @@ -1505,6 +1505,7 @@ static int axienet_init_dmaengine(struct
> > > net_device *ndev)  {
> > >       struct axienet_local *lp = netdev_priv(ndev);
> > >       struct skbuf_dma_descriptor *skbuf_dma;
> > > +     struct dma_slave_config tx_config, rx_config;
> > >       int i, ret;
> > >
> > >       lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0"); @@ -1520,6
> > > +1521,22 @@ static int axienet_init_dmaengine(struct net_device *ndev)
> > >               goto err_dma_release_tx;
> > >       }
> > >
> > > +     tx_config.coalesce_cnt = XAXIDMAENGINE_DFT_TX_THRESHOLD;
> > > +     tx_config.coalesce_usecs = XAXIDMAENGINE_DFT_TX_USEC;
> > > +     rx_config.coalesce_cnt = XAXIDMAENGINE_DFT_RX_THRESHOLD;
> > > +     rx_config.coalesce_usecs =  XAXIDMAENGINE_DFT_RX_USEC;
> >
> > I think it would be clearer to just do something like
> >
> >         struct dma_slave_config tx_config = {
> >                 .coalesce_cnt = 16,
> >                 .coalesce_usecs = 5,
> >         };
> >
> > since these are only used once. And this ensures that you initialize the whole struct.
> >
> > But what tree are you using? I don't see these members on net-next or dmaengine.
> 
> These changes are proposed in separate series in dmaengine https://lore.kernel.org/all/20250525101617.1168991-2-suraj.gupta2@amd.com/ and I described it here below my SOB.
> 
> >
> > > +     ret = dmaengine_slave_config(lp->tx_chan, &tx_config);
> > > +     if (ret) {
> > > +             dev_err(lp->dev, "Failed to configure Tx coalesce parameters\n");
> > > +             goto err_dma_release_tx;
> > > +     }
> > > +     ret = dmaengine_slave_config(lp->rx_chan, &rx_config);
> > > +     if (ret) {
> > > +             dev_err(lp->dev, "Failed to configure Rx coalesce parameters\n");
> > > +             goto err_dma_release_tx;
> > > +     }
> > > +
> > >       lp->tx_ring_tail = 0;
> > >       lp->tx_ring_head = 0;
> > >       lp->rx_ring_tail = 0;
> > > @@ -2170,6 +2187,19 @@ axienet_ethtools_get_coalesce(struct net_device
> > *ndev,
> > >       struct axienet_local *lp = netdev_priv(ndev);
> > >       u32 cr;
> > >
> > > +     if (lp->use_dmaengine) {
> > > +             struct dma_slave_caps tx_caps, rx_caps;
> > > +
> > > +             dma_get_slave_caps(lp->tx_chan, &tx_caps);
> > > +             dma_get_slave_caps(lp->rx_chan, &rx_caps);
> > > +
> > > +             ecoalesce->tx_max_coalesced_frames = tx_caps.coalesce_cnt;
> > > +             ecoalesce->tx_coalesce_usecs = tx_caps.coalesce_usecs;
> > > +             ecoalesce->rx_max_coalesced_frames = rx_caps.coalesce_cnt;
> > > +             ecoalesce->rx_coalesce_usecs = rx_caps.coalesce_usecs;
> > > +             return 0;
> > > +     }
> > > +
> > >       ecoalesce->use_adaptive_rx_coalesce = lp->rx_dim_enabled;
> > >
> > >       spin_lock_irq(&lp->rx_cr_lock);
> > > @@ -2233,6 +2263,29 @@ axienet_ethtools_set_coalesce(struct net_device
> > *ndev,
> > >               return -EINVAL;
> > >       }
> > >
> > > +     if (lp->use_dmaengine)  {
> > > +             struct dma_slave_config tx_cfg, rx_cfg;
> > > +             int ret;
> > > +
> > > +             tx_cfg.coalesce_cnt = ecoalesce->tx_max_coalesced_frames;
> > > +             tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
> > > +             rx_cfg.coalesce_cnt = ecoalesce->rx_max_coalesced_frames;
> > > +             rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
> > > +
> > > +             ret = dmaengine_slave_config(lp->tx_chan, &tx_cfg);
> > > +             if (ret) {
> > > +                     NL_SET_ERR_MSG(extack, "failed to set tx coalesce parameters");
> > > +                     return ret;
> > > +             }
> > > +
> > > +             ret = dmaengine_slave_config(lp->rx_chan, &rx_cfg);
> > > +             if (ret) {
> > > +                     NL_SET_ERR_MSG(extack, "failed to set rx coalesce
> > parameters");
> > > +                     return ret;
> > > +             }
> > > +             return 0;
> > > +     }
> > > +
> > >       if (new_dim && !old_dim) {
> > >               cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
> > >                                    ecoalesce->rx_coalesce_usecs);

