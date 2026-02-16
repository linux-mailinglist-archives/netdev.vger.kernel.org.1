Return-Path: <netdev+bounces-258925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMTXIwhFk2kP3AEAu9opvQ
	(envelope-from <netdev+bounces-258925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:25:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348611461E1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C61603001398
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E76B3328FB;
	Mon, 16 Feb 2026 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HuIStSfF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F953321B0
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259138; cv=none; b=MBz50PquU7elrqfxk3F0TQFdC7dsdONk6eBaEx5Mo4LKEn1uTjXv4PUZJPW9GV5VIz/ASGWr7G0lpVNIdoIokojq92nTieHRSHZFaFk0PH73K1GNn4COamu36/P4Zw4mZ+kkMq+vRtDsKFwiedMmVdJtsAd6cQOigFfyB1gMcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259138; c=relaxed/simple;
	bh=Ta4kICJ8Y9QJyH+T6a9wkyN42wP3ffVBmrjA3P93nNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbhU1OhVQAz60Byb8m5pH9SS6qx9rwmpHfa4QCAg9zw/8++KptVHLbLjpkqq2/2CeotlgCk02H7jmv0Eho6Ok5gbeR4ORQ+deg0Av3AI90KM/M5hNIYhneN1AnY7w6nPiiNzOEbKFUg6x/I/qZJ9kPIa2bkeXh1/QQrafp3fyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HuIStSfF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LVdUmiB0ZqaQigmrzQPPDJOm/XTAfJoKvIXnDMYbanc=; b=HuIStSfF/XAyIc6Mv//fn8W9B5
	qwe/TxRCCfRWCba8c9p3QUE72ljod+t9epIC9LrwNAw2wDf9l2tVZjsXzNJzQknpgt3kTsRDJ15Fj
	dynvqUlkMYZQiDviT0WOWwBVicmTYeHnSH3KVKjdiZz7jP0b4I+kHIk8KoEPIYTI5L5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vs1Ph-007W5l-Ke; Mon, 16 Feb 2026 17:25:33 +0100
Date: Mon, 16 Feb 2026 17:25:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Message-ID: <d80e1fbc-04ed-4bb7-81ea-b298c6a0f15a@lunn.ch>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZNBfh81p1zBvbi2@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-258925-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 348611461E1
X-Rspamd-Action: no action

> Is there a reason not to create and bind one socket directly to each of
> the underlying slave interfaces, with a socket filter attached to only
> receive the HSR+PTP packets you want?

I don't know HSR too well. But what you are suggesting is what is used
when you have an 802.1 bridge on top of two or more
interfaces. ptp4linux is configured to open the lower interfaces of
the bridge and sends/receives frames out the ports as required. I
_think_ it only works in L2 mode, since the ports don't have IP
addresses of their own.

If HSR can be made to work in the same way, you might be able to avoid
all the invasive changes.

    Andrew

