Return-Path: <netdev+bounces-147605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321D99DA88C
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 14:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8029161B2F
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7EC1F76A5;
	Wed, 27 Nov 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwJKcbvV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2D6A8D2
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714307; cv=none; b=Sesm3EC7pg9cDTlH8WBd2oHHH5E2ypDL/uFscH/rFonql1LMmaVRuY1xfKNR1XoxGARXHk10oj56uSo2CL+nii2FTUxdIGJHzpXvRtoF2Gl5DX2X8Zs6ZYJk4XZx404cq0QudLn0lRhxiw4JIYx8ds3zEl+gqSHcCEHr+ovA1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714307; c=relaxed/simple;
	bh=cldKOGvGEDCVtpyFEnvKqgLQdUBtqnf8swX67yPUtWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIRyOd1WPU6hij86aWknh2bCdKCPCacjgH07Y+1PGfMTkgcxEdJ8G6W029n9z2Q1anxESlAp1tfZtGdv4BTJiLbzpWZW3jjfD2aRKZHWmRnC9n/HRuxlf/U7CE1SNSySU3bQSkkAbMWMNXGN2g8akFHmB8MfwlvNetNzWvjDmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AwJKcbvV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 43D0E1140108;
	Wed, 27 Nov 2024 08:31:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 27 Nov 2024 08:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732714304; x=1732800704; bh=kD4GGRRXaJo5coUVseQ9cL4WW5EIeSMVT52
	/M/YXrqo=; b=AwJKcbvVk4bZADXM0lQ75mLzLoElEG7hc+c9BuWIsNbyzCMdnL5
	kno3T++TVEwRCKf0PMegKvZgdXwcmuHz6MsoQ7UCwG77X5ojgXakERDC1Qf5HbLO
	nrg3DszrAfMtocoj/1eGMqAIvxXlLVrE5755JXNNlUJzC5gsmWajXigZY/HDKvP+
	jqfJHNY7fPrEAWBTmJjDNRnlKZbhkyumR35rbQ54gueX/GYCJVXNz8uKwt3sx4F7
	wOhvUoqPlaSdJ4ohaMVw32x7epDZEyj8xOmrS1GpKX86pkO8BeWteoihLzksTzAj
	gKDHXaeAjtONJKXQF9AAAj+QfG+diyVw24w==
X-ME-Sender: <xms:Ph9HZ_D9cAvcx7BRdtg_NxroEY9qbomzQ-iZMydPWLfXnGSZpgd1bw>
    <xme:Ph9HZ1jbd-QB9tbOaVgRtIDFTeLGr8soT8xUwktkANplfSPv6uy4tYts7wvpUi57L
    w3knU9fyiBWQ8s>
X-ME-Received: <xmr:Ph9HZ6nMmXLhcXGacQGI-hUTdWDfHYdTGtEkHaGIW0AaPNprerRguB4BBJM90bCgP7SdY7ykx3vXPtppIxL4I69yLPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudff
    vdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehi
    ughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheplhhorhgvnhiiohdrsghirghntghonhhisehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehmrghilhesthhkudehgedruggvpdhrtghpthhtohepnhgsugesnhgsug
    drnhgrmhgvpdhrtghpthhtohepshgvrghnrdifrghnghesmhgvughirghtvghkrdgtohhm
    pdhrtghpthhtohepmhgrrhhkqdhmtgdrlhgvvgesmhgvughirghtvghkrdgtohhmpdhrtg
    hpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmtghohhgvnhesnh
    hvihguihgrrdgtohhmpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkihhn
    sehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Ph9HZxxmC3iu7jjQT6jEOfhqON8G0HY1LLNJDQSZ8OvW5Ask2wtXiw>
    <xmx:Ph9HZ0RmqwAAe4YJu_iLtG4siluM5JMOuPaLT-DLCglSg3nHopv21w>
    <xmx:Ph9HZ0Y_cgaxonZc3g2QKMg55FpMgxDQwFIBWhN5fM8b8EDJYUf4eg>
    <xmx:Ph9HZ1Rmo974fapYeKDrIkjkS1ZcpUKfFxMRoov-jakQh1SS9FmAZQ>
    <xmx:QB9HZ3Ex6aB9bsAbLeVpOpgerrbD8h8THsOs-XtxAa1w-YNULKBI3I2V>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 08:31:41 -0500 (EST)
Date: Wed, 27 Nov 2024 15:31:39 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Til Kaiser <mail@tk154.de>, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
	netdev@vger.kernel.org, amcohen@nvidia.com,
	aleksander.lobakin@intel.com
Subject: Re: [PATCH net] mediathek: mtk_eth_soc: fix netdev inside
 xdp_rxq_info
Message-ID: <Z0cfOzsujtoxO422@shredder>
References: <20241126134707.253572-1-mail@tk154.de>
 <20241126134707.253572-2-mail@tk154.de>
 <Z0YQYKgUyLt8w4va@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0YQYKgUyLt8w4va@lore-desk>

On Tue, Nov 26, 2024 at 07:16:00PM +0100, Lorenzo Bianconi wrote:
> > Currently, the network device isn't set inside the xdp_rxq_info
> > of the mtk_rx_ring, which means that an XDP program attached to
> > the Mediathek ethernet driver cannot retrieve the index of the
> > interface that received the package since it's always 0 inside
> > the xdp_md struct.
> > 
> > This patch sets the network device pointer inside the
> > xdp_rxq_info struct, which is later used to initialize
> > the xdp_buff struct via xdp_init_buff.
> > 
> > This was tested using the following eBPF/XDP program attached
> > to a network interface of the mtk_eth_soc driver. As said before,
> > ingress_ifindex always had a value of zero. After applying the
> > patch, ingress_ifindex holds the correct interface index.
> > 
> > 	#include <linux/bpf.h>
> > 	#include <bpf/bpf_helpers.h>
> > 
> > 	SEC("pass")
> > 	int pass_func(struct xdp_md *xdp) {
> >     		bpf_printk("ingress_ifindex: %u",
> > 			xdp->ingress_ifindex);
> > 
> > 		return XDP_PASS;
> > 	}
> > 
> > 	char _license[] SEC("license") = "GPL";
> > 
> > Signed-off-by: Til Kaiser <mail@tk154.de>
> > ---
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > index 53485142938c..9c6d4477e536 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > @@ -2069,6 +2069,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
> >  
> >  		netdev = eth->netdev[mac];
> >  		ppe_idx = eth->mac[mac]->ppe_idx;
> > +		ring->xdp_q.dev = netdev;
> 
> I guess you can set it just before running xdp_init_buff(), but the change is fine.

Lorenzo, is it legitimate to change rxq->dev post registration like
that?

I am asking because we have a similar problem [1]. In our case we also
register the rxq structure with a dummy netdev which is why XDP programs
see an ifindex of 0.

Thanks

[1] https://lore.kernel.org/netdev/ZzYR2ZJ1mGRq12VL@shredder/

> 
> Regards,
> Lorenzo
> 
> >  
> >  		if (unlikely(test_bit(MTK_RESETTING, &eth->state)))
> >  			goto release_desc;
> > -- 
> > 2.47.1
> > 
> > 



