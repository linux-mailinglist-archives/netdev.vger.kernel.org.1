Return-Path: <netdev+bounces-147861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7409DE72A
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 14:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D21281631
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297419DF9E;
	Fri, 29 Nov 2024 13:22:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E419C566
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886576; cv=none; b=l46JziKhUxy55HMv2Bhqz/+xtYEr029cwM8QrSdyRNlP2MQW3oWrREZJzXZoCFP3lFPrR7NKnI7jyXiQGNY44Xp9J8f+NJiRmcL9XJrfoN/vU5ZYZGXl8V3DXojsgYFqAs/WpigMSO/WgbkFOvN+UhU7wsobs/FrzWVsykgWJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886576; c=relaxed/simple;
	bh=9vM84tyM8iIyK4R5JdG7+WvlA7iQFb65QceBAWYLaKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGYhE7lWqqPrO8LV9AD71pao8JwoKGlSGeJN8ptqXZf8xPmosyfakCduqonpOQgQ63FnSMtbU2mTDbuVlHprl2G8CY3lLRslZGZd/jxlI7OFgICfZNbjH800iOViPOkE7lTUfYQTAE7fCfU5nEbP9dU75KAWlPcIGUiTIOCZ0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0xO-0006ts-JH; Fri, 29 Nov 2024 14:22:50 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0xN-000nN7-0y;
	Fri, 29 Nov 2024 14:22:50 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0xN-004qxT-39;
	Fri, 29 Nov 2024 14:22:49 +0100
Date: Fri, 29 Nov 2024 14:22:49 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <Z0nAKU7gJAdyY_KN@pengutronix.de>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
 <Z0m53JjLCTEm7On8@pengutronix.de>
 <20241129-poetic-snake-of-recreation-32e05a-mkl@pengutronix.de>
 <20241129-skinny-jackrabbit-of-relaxation-903ae4-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129-skinny-jackrabbit-of-relaxation-903ae4-mkl@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Nov 29, 2024 at 02:05:11PM +0100, Marc Kleine-Budde wrote:
> On 29.11.2024 13:59:28, Marc Kleine-Budde wrote:
> > On 29.11.2024 13:55:56, Oleksij Rempel wrote:
> > > On Tue, Nov 05, 2024 at 12:48:23PM +0300, Dmitry Antipov wrote:
> > > > Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
> > > > new skb, I assume that the same should be done for an initial one
> > > > in 'j1939_session_new()' just to avoid refcount underflow.
> > > > 
> > > > Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
> > > > Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> > > > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> > > 
> > > Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > Can you re-phrase the commit message. The "assume" is not appropriate :)
> 
> What about:
> 
> Since j1939_session_skb_queue() does an extra skb_get() for each new
> skb, do the same for the initial one in j1939_session_new() to avoid
> refcount underflow.

Sounds good. Thx!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

