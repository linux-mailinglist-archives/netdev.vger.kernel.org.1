Return-Path: <netdev+bounces-40386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75F7C7169
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE911C20AC3
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7A273D9;
	Thu, 12 Oct 2023 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QiGAjHtD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A23224CF
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:28:34 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4ECBE;
	Thu, 12 Oct 2023 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LtxAnAjUqRhHfJGOc405Qbe6cZQPQAf92M0E/m+mSns=; b=QiGAjHtDTnv4+anA8SuXlkh7jk
	NIfxlHDjYt/UXj7RN33ePAKEzZtnZI0fJcB0srWzakaHsSNSIcL3sf5KPxe+kKWAK4xpc8c6eT4zc
	H1MI+GTILX9PxysGH6pHmH39RHzeXDS0qVWhByuo44rRXgcCj/2fvPwmcucM4/WQwtmA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qqxbv-001xOP-DJ; Thu, 12 Oct 2023 17:28:27 +0200
Date: Thu, 12 Oct 2023 17:28:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix tx_total_bytes count
Message-ID: <524856b3-6876-48d1-aebf-09f7f6c71f7b@lunn.ch>
References: <20231011063700.1824093-1-danishanwar@ti.com>
 <4d7c2ab9-e980-42a5-9452-79bc0d33e094@lunn.ch>
 <7b5f195f-c5c8-6847-9458-3d5563cf0112@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b5f195f-c5c8-6847-9458-3d5563cf0112@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 10:51:12AM +0530, MD Danish Anwar wrote:
> Hi Andrew,
> 
> On 11/10/23 18:11, Andrew Lunn wrote:
> >> @@ -29,7 +30,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
> >>  			     base + icssg_all_stats[i].offset,
> >>  			     val);
> >>  
> >> +		if (!strncmp(icssg_ethtool_stats[i].name, "tx_good_frames", ETH_GSTRING_LEN))
> >> +			tx_pkt_cnt = val;
> > 
> > Doing a strncmp seems very expensive. Could you make use of
> > icssg_stats.offset?
> > 
> 
> Sure. I can define the offset of these two stats and then use them in if
> condition as below.
> 
> #define ICSSG_TX_PACKET_OFFSET 0xA0
> #define ICSSG_TX_BYTE_OFFSET   0xEC
> 
> if (icssg_ethtool_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
> 	tx_pkt_cnt = val;
> 
> if (icssg_ethtool_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
> 	emac->stats[i] -= tx_pkt_cnt * 8;

That is much better. Also consider adding something like:

BUILD_BUG_ON(ICSSG_TX_PACKET_OFFSET < ICSSG_TX_BYTE_OFFSET)

I've no idea if this is correct. Just something to prove at build time
that ICSSG_TX_PACKET_OFFSET is read before ICSSG_TX_BYTE_OFFSET.

     Andrew

