Return-Path: <netdev+bounces-259725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOx9NW1vmGkoIgMAu9opvQ
	(envelope-from <netdev+bounces-259725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:27:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40223168567
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08498300A8F1
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBDB34D4EA;
	Fri, 20 Feb 2026 14:27:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bm.lauterbach.com (bm.lauterbach.com [62.154.241.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217734A790
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.154.241.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597655; cv=none; b=Nbsk1S7hJZtCdxn791TEZ2Y5qwtidjJuyihSTbiMp9W+Z8WQ6ei/KkzdtZAXafsjOqEnOmls47T+vXUxsT78TsjGRO0N7yt+hQksK2dKAYRQt2fiJBcfZBLumTMNWtjHr7uhla/TUE3JiMobxHcPVmmUXqv2t8eRamLR5IQmkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597655; c=relaxed/simple;
	bh=KHeo0++U87a3xG6gGydqHX+mCnrR5Q4odZ0OeFvICss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1utISJ3+BYBHqdkXj6Ayg1KBw9KU2LjEO3vkv7U9fzQDQ+CaOk72/fUNV6JxEDUqa/kKlIpfN5dq8iHk9USksT11jiDZPFqE1zB5SuR/AqPFf/h10VWdN+5uEEojbbotjb9OfDzWhdKFtlALTO4kolcZ3cFlVmHfwIzdpnBuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com; spf=pass smtp.mailfrom=lauterbach.com; arc=none smtp.client-ip=62.154.241.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lauterbach.com
Received: from ingpc2.intern.lauterbach.com (unknown [10.2.10.44])
	(Authenticated sender: ingo.rohloff@lauterbach.com)
	by bm.lauterbach.com (Postfix) with ESMTPSA id 92FBBD604D96;
	Fri, 20 Feb 2026 15:27:23 +0100 (CET)
Date: Fri, 20 Feb 2026 15:27:23 +0100
From: Ingo Rohloff <ingo.rohloff@lauterbach.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: macb: fix race condition in TX queue
 initialization
Message-ID: <20260220152723.2d98c022@ingpc2.intern.lauterbach.com>
In-Reply-To: <20260219144338.50e8bb73@kernel.org>
References: <20260218104325.28381-1-ingo.rohloff@lauterbach.com>
	<20260219144338.50e8bb73@kernel.org>
Organization: Lauterbach GmbH
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1771597643617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lauterbach.com];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ingo.rohloff@lauterbach.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ingpc2.intern.lauterbach.com:mid]
X-Rspamd-Queue-Id: 40223168567
X-Rspamd-Action: no action

Subject: Re: [PATCH] net: macb: fix race condition in TX queue initialization
Date: Thu, 19 Feb 2026 14:43:38 -0800

> > On Wed, 18 Feb 2026 11:43:25 +0100 Ingo Rohloff wrote:
> > Commit bf9cf80cab81e ("net: macb: Fix tx/rx malfunction after phy link
> > down and up") initializes queue->tx_head and queue->tx_tail to zero
> > without holding queue->tx_ptr_lock.

> That commit does look quite buggy, but I'm not sure whether the fix is
> effective.

Yes: I myself think that what I posted is definitely not enough.

I am not sure if I can come up with a real fix though:

Looking at ethernet drivers which use both:
   * phylink_mac_ops->mac_link_down()
   * net_device_ops->ndo_open()
the most commonly used strategy seems to be:
* When net_device_ops->ndo_open() is called:
  - Setup ring buffers
  - Call netif_tx_start_all_queues()
* DO NOT call netif_tx_stop_all_queues() or similar when
  phylink_mac_ops->mac_link_down() is called
* DO NOT re-initialize ring buffers when
  phylink_mac_ops->mac_link_up() is called.

So: Leave the ring buffers alone in
phylink_mac_ops->mac_link_up() and phylink_mac_ops->mac_link_down().

The driver in macb_main.c seems to be one of the exceptions
which calls netif_tx_stop_all_queues() in macb_mac_link_down() and
netif_tx_wake_all_queues() in macb_mac_link_up().

My problem is:
I don't understand why the OTHER drivers don't do it like this.
What's the expectation of the hardware, if I fill the TX ring buffer
with TX skb's even if the link is down?
Is the hardware supposed to throw all these TX entries away
and still produce completion or error(?) interrupts?
Or is this handled, because drivers which use "phylink",
automatically call netif_carrier_on() and netif_carrier_off() via
"phylink" when the link changes up/down state?


If you know the expected behavior:
Could you teach me what's expected ?

If I understand the expected behavior I might be able to come up
with an idea what the macb driver is supposed to do :-)


> But the fix should be locking and fixing whatever
> questionable dark arts the link_up handler is performing on the queues
> (we are resetting the pointers without freeing outstanding skbs!?).

Yeah: The last one also caught my eye; I think this might produce
an ever growing bunch of outstanding skb's.

I think the reason why the macb driver is unusual is,
because the hardware itself resets the pointers into the
TX ring buffer, when you disable transmit; which means you somehow
have to clean up the TX ring buffer after a link down
(if you disable transmit).

Most of the other drivers I have looked at, somehow seem to expect
that this cleanup happens automagically; but I have no clue why or
how this cleanup happens for other hardware.

I will be very thankful for any input what's the expected behavior!

so long
  Ingo



PS:
Just for reference,
I looked into the following drivers which use both:
    ->ndo_open() and ->mac_link_down()
not many surprisingly(?):

ethernet/altera/altera_tse_main.c
ethernet/atheros/ag71xx.c
ethernet/cadence/macb_main.c
ethernet/freescale/enetc/enetc4_pf.c
ethernet/freescale/enetc/enetc_pf.c
ethernet/freescale/fs_enet/fs_enet-main.c
ethernet/freescale/ucc_geth.c
ethernet/marvell/mvneta.c
ethernet/marvell/mvpp2/mvpp2_main.c
ethernet/marvell/prestera/prestera_main.c
ethernet/mediatek/mtk_eth_soc.c
ethernet/microchip/lan743x_main.c
ethernet/mscc/ocelot_net.c
ethernet/stmicro/stmmac/stmmac_main.c
ethernet/ti/am65-cpsw-nuss.c
ethernet/xilinx/xilinx_axienet_main.c


Drivers which stop netif tx queues in mac_link_down()
Note: Seems like these still start
with enabled tx queues in ->ndo_open() ?

   ethernet/microchip/lan743x_main.c
   ethernet/marvell/mvpp2/mvpp2_main.c
   ethernet/ti/am65-cpsw-nuss.c


Drivers which DO NOT stop netif tx queues in mac_link_down()

   ethernet/altera/altera_tse_main.c
   ethernet/atheros/ag71xx.c
   ethernet/freescale/enetc/enetc.c
   ethernet/marvell/mvneta.c
   ethernet/marvell/prestera/prestera_main.c
   ethernet/mediatek/mtk_eth_soc.c
   ethernet/mscc/ocelot_net.c
   ethernet/stmicro/stmmac/stmmac_main.c
   ethernet/xilinx/xilinx_axienet_main.c

And:
   ethernet/freescale/ucc_geth.c
Which seems to be another potential start_xmit/link_up race,
albeit with fancy handling. Look for usage of ugeth_quiesce()



-------------------------------------------------------------------------
Dipl.-Inform.
Ingo ROHLOFF
Senior Staff Embedded Systems Engineering
phone +49 8102 9876-142 - ingo.rohloff@lauterbach.com

Lauterbach Engineering GmbH & Co. KG
Altlaufstrasse 40, 85635 Hoehenkirchen-Siegertsbrunn, GERMANY
www.lauterbach.com

Registered Office: Hoehenkirchen-Siegertsbrunn, Germany,
Local Court: Munich, HRA 87406, VAT ID: DE246770537,
Managing Directors: Lothar Lauterbach, Stephan Lauterbach, Dr. Thomas Ullmann

-------------------------------------------------------------------------

