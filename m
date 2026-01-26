Return-Path: <netdev+bounces-253516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MH4JyWBd2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:58:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4666189D84
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4E6430309AD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6EE3346B5;
	Mon, 26 Jan 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VPONkrhe"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B12BE7C6
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439359; cv=none; b=q5dnwXCxhUkd5yK9KsDp3VxVdYfh6q0GRecZjpolZWAV9eqdtM2WSVbt+UmegmtSYYP3xqm8mv1UsOcdNhPnBvFqcgRa4t0KaMNkFusar4lSh8eSgY1q0GeC8EE0+kbiz9koCaI0EY9RCp36AMHj/Wl23SNG/6hj3txjnaAZTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439359; c=relaxed/simple;
	bh=MDmBBGGuPsR8+N/8tM8Hw6z+AHRj6CTwlvcV3NwZhVQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=kb+aDJux4FAwMqQu1JBEi6V5eJPHgyWoENg1cMc4yaBQ5D1fQYwOEq/CM2twjzDGJQi2ezKgkD3ZecLT7bpT7QoOWpWhZV3epXXLD6Cg9aZh03+ORnsaTxBIt2B5Fki+QFfq7r42IDsftAVtoZ0BgSGKjA/LwjkrYw47xe3n/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VPONkrhe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 76B291A2A53;
	Mon, 26 Jan 2026 14:55:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B1F260717;
	Mon, 26 Jan 2026 14:55:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17F1C119A860F;
	Mon, 26 Jan 2026 15:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769439353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4o0SETIqk3lQBmYw6tEO8k7aX0EALyrPx6wDM4E+Fk8=;
	b=VPONkrheDRNRn9V2KaC61AyMtfNCPIXg0+3bWkSyAljOFv/ypEIzSKRGw/d5BP1WmPKy5p
	6E+6KrZ7G/jlyqHV+4njs3zoZNJ0Kb7Tr1/ztdw9RQnSIxt+CkwTzYL9kGOj7lDFJPX5Mk
	CmzUsefqE8KNtO+fdFPE0uEiZ2o/+9ojoaCXwIxDrOI2sPId9OdOa3G2pYg5T99icV/XE6
	KKEuqV/sAVLN7YEnllM0nLoR90fbadvttrk5eCHOgQM4D5FkpB3hRsajL86xip8M+zuq2q
	YFIr5Jhk9wu/Eme3UnIooxrerWzuMc5iKjA0c/5URBkD7e0sEFjuG3sGf5QsAg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 15:55:49 +0100
Message-Id: <DFYLWF9IATJE.H6R8RUZQI1FG@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
In-Reply-To: <20260115222531.313002-4-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:url,bootlin.com:mid]
X-Rspamd-Queue-Id: 4666189D84
X-Rspamd-Action: no action

Hi Paolo,

On Thu Jan 15, 2026 at 11:25 PM CET, Paolo Valerio wrote:
> Use the page pool allocator for the data buffers and enable skb recycling
> support, instead of relying on netdev_alloc_skb allocating the entire skb
> during the refill.
>
> The patch also add support for receiving network frames that span multipl=
e
> DMA descriptors in the Cadence MACB/GEM Ethernet driver.
>
> The patch removes the requirement that limited frame reception to
> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
> contiguous multi-page allocation for large frames.

[...]

> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/phy/phy.h>
>  #include <linux/workqueue.h>
> +#include <net/page_pool/helpers.h>
> =20
>  #define MACB_GREGS_NBR 16
>  #define MACB_GREGS_VERSION 2
> @@ -1266,6 +1267,8 @@ struct macb_queue {
>  	void			*rx_buffers;
>  	struct napi_struct	napi_rx;
>  	struct queue_stats stats;
> +	struct page_pool	*page_pool;
> +	struct sk_buff		*skb;

There might be a cleanup issue with the GRO queue->skb field.
It gets cleaned up by gem_rx() in
 - various error codepaths with the free_frags label, or,
 - the happy path where we hand off the skb with napi_gro_receive().

If we get closed in the middle of a transfer we have queue->skb that is
valid. It sounds like an issue if we shutdown (and leak the SKB) or if
we reopen (and have the old SKB laying around). I have not encountered
this on HW, but I haven't tried.

Do you agree? A job for gem_free_rx_buffers()?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


