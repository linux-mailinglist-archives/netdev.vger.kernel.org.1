Return-Path: <netdev+bounces-284828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHBmGhE7+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA694DA9F4
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B3BA3019151
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9E5423A77;
	Wed,  6 May 2026 12:58:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786144E047
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072326; cv=none; b=ifsRYdDRkfk+w8MGlNerjqGq1lU2sc+HHQgej5tyZ6D5+8GT21xpv3fxPEuYXkwhYDYp7606pkpJvR+1bQ52bRy58hufEWnNaFw1hrIWxq5YoMCnXS44vQuB1Wg6eUx4cbt46P9wQqV8gSRBvRgta8E5s6eA+hlfGVJjEqoNpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072326; c=relaxed/simple;
	bh=z9jqkhW0V6ud7bKJ/0boSGhrhI5MbHlXZNIajKm0+1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd/wIYutHF4nRdeMnuxR8jSuAbkdAVGnnnPE9a9tSs5/ctyd4CsebiiqMAy5q3lUumYmfBSRhgDyqWCmkemZmIsLedDQq8/lw8RweRaOyvM2h54v3mONXnrt+KPm9Iq8xmk7UUa3tM7vfSGp+WtHpidl30XZoPUqJagbPfP2PhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wKbpO-0001SE-Jy; Wed, 06 May 2026 14:58:14 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wKbpL-000kKR-1k;
	Wed, 06 May 2026 14:58:11 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wKbpL-00000003UPo-3cWl;
	Wed, 06 May 2026 14:58:11 +0200
Date: Wed, 6 May 2026 14:58:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Miaoqian Lin <linmq006@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: usb: asix: ax88772: replace
 usbnet_link_change() with queue_work() and usbnet_unlink_rx_urbs()
Message-ID: <afs6467DFTQ35e9b@pengutronix.de>
References: <20260506010344.184636-1-Markus.Baier@soslab.tu-darmstadt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260506010344.184636-1-Markus.Baier@soslab.tu-darmstadt.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Queue-Id: DEA694DA9F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,pengutronix.de:email,tu-darmstadt.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, May 06, 2026 at 03:03:44AM +0200, Markus Baier wrote:
> Commit 36bdc0e815b4 ("net: usb: asix: ax88772: re-add usbnet_link_change()
> in phylink callbacks") restored the link-change notification that was
> lost during the phylink migration, by calling usbnet_link_change() from
> the phylink mac_link_up() / mac_link_down() callbacks.
> 
> While this fixed the original symptom (RX URB submission not being
> initiated after link up), usbnet_link_change() also calls
> netif_carrier_off() on link-down, which is redundant in a phylink-based
> driver because phylink manages the carrier state itself.
> 
> Replace the usbnet_link_change() calls with the minimal operations:
> 
>   - In ax88772_mac_link_up(), schedule dev->bh_work directly via
>     queue_work(system_bh_wq, &dev->bh_work). This is the same
>     mechanism usbnet_open() uses to schedule the bottom-half
>     that submits RX URBs.
> 
>   - In ax88772_mac_link_down(), call usbnet_unlink_rx_urbs() to
>     return any in-flight RX URBs to the host controller.
>     This releases USB bandwidth and avoids keeping unused buffers
>     queued while the link is down. This is the symmetric
>     counterpart to scheduling new RX URBs on link up.
> 
> Tested with the Apple A1277 USB Ethernet Adapter (05ac:1402,
> AX88772A based) on a Banana Pro (Allwinner A20).
> 
> Fixes: 36bdc0e815b4 ("net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>

Tested on AX88772C. Thx!

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

