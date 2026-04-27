Return-Path: <netdev+bounces-281363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH1zAVtv72mHBQEAu9opvQ
	(envelope-from <netdev+bounces-281363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:14:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F1F47421F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC7AB3044114
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02053D0939;
	Mon, 27 Apr 2026 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qr8X2TOc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8B3A6F04;
	Mon, 27 Apr 2026 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299161; cv=none; b=pJCkDeSXfCJyt1S7uZVs0XUyo8TiGva5YEGkxkhfTnwv8Cv5NtIrGPtxTuE25uVLuzEHxM6bZTOj177Oe1qMxv/Cp0zG1uztgp38+t6ma5ZjLti5azWZWlWF8qB+KRu0YB+o/GF3rivB476TQZfPpjyanwwhaVEEqeQYwDx1AmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299161; c=relaxed/simple;
	bh=03TncCMXZUXJYH/BBPCnT9988TKKQ8QG+wdLi/WlK9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEHbfGa/cqYr0TRprOCgm2HOFuzfAajclODbKa1ketZTaZ507S2wMmHvj+K9lGxRoNonW10n2FkJ99m/FXrbvo3Q3HN4D4HUJ5/CKpNbgP5OHXDVYHnjkHVH0CwxnX2pnnqumJuiVRa77Xz90krm1pWsQl3Mdbur+u5118cpQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qr8X2TOc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8HIS3FRWZVG5KCqXucX++N85XZYylDdp4L8cPTdPY+w=; b=qr8X2TOc9M9/SpmIO9Us3+oTpK
	EMH3vhqdg9BeolUJnMgjc8V8SZ9tNlc5bY2qQagnuZsfDhrEvY6RHin82J8Oa/HZn9K15ON8DdTUn
	9aTN4HEFUEJ2+IgSvSIaPseCtzg/tNi7B6Zt3vzbnkRYlePQHcG42wv4U/0Mu7Jwmt34=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHMhI-000AiH-KI; Mon, 27 Apr 2026 16:12:28 +0200
Date: Mon, 27 Apr 2026 16:12:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ijae Kim <ae878000@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH DRAFT] net: cirrus: ep93xx: fix probe error unwind
Message-ID: <3d4cc12b-e713-4804-9cff-da6deb62d9d0@lunn.ch>
References: <20260426141010.19049-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
 <4201a9ff-c137-4e08-85f8-32aaa6aa3836@lunn.ch>
 <CAGEsz8EkSB8T=D3uPzAt+1Qbh0h+-u6=1ABE13uwK5ZF=uVLkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEsz8EkSB8T=D3uPzAt+1Qbh0h+-u6=1ABE13uwK5ZF=uVLkw@mail.gmail.com>
X-Rspamd-Queue-Id: 56F1F47421F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[visionengravers.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 12:18:33PM +0900, Myeonghun Pak wrote:
> For the repro, I used an x86 COMPILE_TEST QEMU boot with ep93xx_eth.ko loaded
> and a synthetic ep93xx-eth platform device. I configured failslab with a
> stacktrace filter so the injected allocation failure happened inside
> register_netdevice(). That made register_netdev() fail from ep93xx_eth_probe().

So totally synthetic, not real world.

This driver was added in 2006. Can you point to reports of this being
a real problem any time in the last 20 years? Is this a problem worth
fixing because it does actually happen?

> This was originally found as part of the results from an ongoing research
> project with my fellow researchers.

Please redirect your effort to drivers which are still in use. Drivers
from the last 5-10 years. Drivers which are worth fixing, and have
Maintainers who cares about the driver. And problems which are likely
to happen in the real world, not an synthetic setting.

     Andrew

