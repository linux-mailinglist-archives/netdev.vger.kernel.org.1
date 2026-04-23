Return-Path: <netdev+bounces-280744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DToOLQP6mn4sgIAu9opvQ
	(envelope-from <netdev+bounces-280744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C812451ED0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23823300A66B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10093ECBFB;
	Thu, 23 Apr 2026 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SizbUwvi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0D82899;
	Thu, 23 Apr 2026 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947102; cv=none; b=air//ekNQj2gOYzLpDxvxNNtjMibWSyPpUegZv7PdEqy51QC3F8Qjq6ND8U5M+P4gKFyqPJBkILSljUDEDyUjzHFfk59yELKQ4U1/OQ7o8pSyA2kCVmN220BXrqTXUV4p4IYuiG+G7Zjb64kzLOE0osVnKmXDKm3NpYCv6TBP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947102; c=relaxed/simple;
	bh=pYNDTD2TuHDQtdBUXzbB4URB+iX9VGSqf9gw9/7uMhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMtMGUvg7vCl/Q/tKTkZR3UIeEDP9lC6y1V9UbVmc3r4F+BGx+BAYS1XvZn58qKwshglyjdWXFlIRsZqQMP7cAYC3QH75M3ojpEkfVJoqjE8Aj0KUQXkt/BvkKDed22LXRjh4M8Sbv7XK1cUy7JPmtjIeWm6kjwulCNKMf0dae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SizbUwvi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=irLnLXr9Ikf9jWViwJYxyqv+QNGEYSxQxLxPXn3fKvE=; b=SizbUwviG1pvLPTva6V+RcdBn8
	VIswrFy3jL0WGN2Y7v/kdLxIOA/xvNNAHkOO7/UVzTGiDqvVFwq0vqIC6RjQ8MeUT85L476n5zYGA
	NrzR3V4QN5SdjfsFESGFFWGRdsXQHluhoyRz/QWrrvOORZ4kxaGkODJ5PFBNoU3hcs+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFt6y-00HF3R-3Z; Thu, 23 Apr 2026 14:24:52 +0200
Date: Thu, 23 Apr 2026 14:24:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [RFC PATCH] net: skb: on zero-copy formatted output to skb
Message-ID: <d56a7c77-cfc3-48e7-bbcb-5891b0e6c4d8@lunn.ch>
References: <20260423073638.778334-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423073638.778334-1-dmantipov@yandex.ru>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280744-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 8C812451ED0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 10:36:38AM +0300, Dmitry Antipov wrote:
> Some code, most notably the Bluetooth drivers, uses something like
> the following:
> 
> char buf[80];
> snprintf(buf, sizeof(buf), "Driver: %s\n", driver_name);
> skb_put_data(skb, buf, strlen(buf));
> 
> This looks suboptimal at least because:
> 
> 1) It yields in BUG() just in case the developer underestimates
>    the size of an skb being used;
> 2) It requires extra data copy from an external buffer;
> 3) It uses 'strlen()' redundantly because actual data length
>    is calculated by 'snprintf()' itself.
> 
> So introduce 'skb_printf()' which aims to address all of these
> issues. As usual, thoughts and comments are highly appreciated.

Please always include at least one user of a new helper.

Do you plan to modify all the bluetooth drivers to use this?

	Andrew

