Return-Path: <netdev+bounces-147849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2129DE6B9
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED9CB225F4
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DA19D07B;
	Fri, 29 Nov 2024 12:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7D19D07E
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884964; cv=none; b=S1rb0RfHVmKLlqQB3mlwlwMWBwuRL2A94FxF7wMgsAj3xt2zFy3pTtxnSBB4bSZQxlFA1l8XTrLrasiOvhEmb2dBf5+JzyhmB4XZ6oL0gJALHcTvoPPzP5EqjaU26vzAkG+mvEuO7flruSIOFCbv9iWIPlEroD4mYEPGDV05rsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884964; c=relaxed/simple;
	bh=IoJbv4cxFy7KMzPCthm14HRhYg14O7eIZAq+dGWWKl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge3QYAsjj9783ItENEyFMnjL2/mea6GqhHpnI7EOMBkXlsa/9FOl8qGMiK6oVhbAHASX85p0pM2MGJRV9+HHXza9y5OzwVzoa6GTAss+f0QEZCZLdKTKG37bLgiLmrY5l4aBDIkYnvvT85LI3oUqnk8irpBCEk2lDJYpntnxvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0XN-0007Hy-M4; Fri, 29 Nov 2024 13:55:57 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0XL-000n3H-31;
	Fri, 29 Nov 2024 13:55:56 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0XM-004qPo-1x;
	Fri, 29 Nov 2024 13:55:56 +0100
Date: Fri, 29 Nov 2024 13:55:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <Z0m53JjLCTEm7On8@pengutronix.de>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105094823.2403806-1-dmantipov@yandex.ru>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Nov 05, 2024 at 12:48:23PM +0300, Dmitry Antipov wrote:
> Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
> new skb, I assume that the same should be done for an initial one
> in 'j1939_session_new()' just to avoid refcount underflow.
> 
> Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

