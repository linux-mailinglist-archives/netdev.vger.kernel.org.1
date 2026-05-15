Return-Path: <netdev+bounces-288308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECggDP4WB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:52:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C420F54FEF1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 292D43026F01
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247CF242D6B;
	Fri, 15 May 2026 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AdIB5a9F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6DF23D7FF;
	Fri, 15 May 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849236; cv=none; b=BTXUkYa6c+hZnksS2EGkcz/Iyqdbe0fK8uamFgz0OwvbxSuAEGUWiOQjLw0FDkcoA9Kv1ipZr5Al3r7hdNZiExdILkuYskCjOQPkHhBa7tMrDx3s575goVhssLh9ZXpSDKznI0WLpOwVdO1WS2AWqJ56W3lzW5VOjKciu45+bVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849236; c=relaxed/simple;
	bh=/rQz0n7I5ID0pC/3uZdyjXEI3ecbm5cYZM4YFWxmbq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW8BQ15vhMVE2FD4BH4w4EqSOkBwTYrGYDXaiQYWpDnDngo6QYBkLSxAs2jMV/7WoTxLcbFesk4g80lAm/OmU7yjZ5EzMgPnom6+6/kc7v1x74v4JjQiHfTAk5MQtiE2mV2QlwpVDaypSrSIDy2MduMLGrGbTrwmAuzlqyUMz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AdIB5a9F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EF+740UnJnqAgctNgdg2R5aHolnMpCTYC3TQf0irLIg=; b=AdIB5a9FUoLhQ4tXb72J/+z7zV
	VgffyIEypIZ1NCJb4YLBK2VXZEv+t1X8oIUGnDxhRLLWnolVTY+zgqJnwfUJZR8PqTpPZ82DaRmXh
	MZSUGME5WHiQBxF5e9CvxdSWWK2+CHHKSr9PHlpbtICid4HGLvOtt68R2tA1Rbo2WHTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNrwW-0033xq-8P; Fri, 15 May 2026 14:47:04 +0200
Date: Fri, 15 May 2026 14:47:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Raczylo <lukasz@raczylo.com>
Cc: netdev@vger.kernel.org, Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: macb: fix build of TX stall watchdog by
 replacing undefined netdev_warn_ratelimited
Message-ID: <3aa11074-2b96-422e-8725-35c5522272d3@lunn.ch>
References: <cover.1777064117.git.lukasz@raczylo.com>
 <20260514215459.36109-1-lukasz@raczylo.com>
 <20260514215459.36109-4-lukasz@raczylo.com>
 <20260515095336.92237-1-lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515095336.92237-1-lukasz@raczylo.com>
X-Rspamd-Queue-Id: C420F54FEF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288308-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 10:53:36AM +0100, Lukasz Raczylo wrote:
> netdev_warn_ratelimited() does not exist in this kernel -- neither
> mainline net-next nor raspberrypi/linux rpi-6.18.y define a
> netdev_*_ratelimited() family.  I confused it with the existing
> net_warn_ratelimited() / pr_warn_ratelimited() macros when
> authoring v2 patch 3 of the macb silent TX stall series, and the
> result fails to build with implicit-function-declaration.
> 
> Replace with the standard `if (printk_ratelimit()) netdev_warn(...)`
> pattern.  Same semantics intended by v2 patch 3 (bounded log noise,
> retains the netdev prefix in the message); works in every kernel
> version.
> 
> Fixes the build of patch 3/3 of:

What you should do is reply to patch 3/3 and say

self NACK

and explain why it is broken.

Then wait 24 hours, and send a new version of the patch series, with
patch 3/3 fixed.

    Andrew

---
pw-bot: cr

