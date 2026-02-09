Return-Path: <netdev+bounces-257953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPQgNIDniWmdDwAAu9opvQ
	(envelope-from <netdev+bounces-257953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:56:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D910FEE1
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F3353004CA2
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17B379972;
	Mon,  9 Feb 2026 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYTQv7n9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11463793DF;
	Mon,  9 Feb 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645372; cv=none; b=RcuoSWutSWZ2QYcwKshTreNXoS9eQOIS6UDqA7KfZy0psHcRrJMP7Oamd2QnA3mh9ETnrXjPm5US5tWf1EjY7d8Yvv/fow5lqKjlJI1HlKNW7WN6Z+m5lXP43A5uuRxd47+FRCWnZB0/HpsksYcWyBDVfMPnRz14hOHmiUy+uNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645372; c=relaxed/simple;
	bh=rBL1bBvkjTPgCykjgiqbVv+dDMCeoT/dfKbtap1Pryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrulAoupnFqmsILwaCMANA/GAg/leY1QUOKoWwWT3jgjzxHoaLIZ1Kcl/Otn5MmDeHkjn5ZNAUvJG0mFKAhTN610dLTAWw1aY2l62USU6iR3W3eQcn4y7qsadXQb82XoGYWSZY4w/EVF9A5DvY7jLnp/btjVAZRCpE6oH5rgXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tYTQv7n9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kacjq2rEcfQB30IBAxC28QfPwUJPcJ/L6ti1cdxg2ME=; b=tYTQv7n9d34Tc3ERpKjTpLAREf
	u+uy40WbpgRgG5Q711xisNoXonQVrgM7Av/tV6101c3qzkbSq6Kz0VmM6Exn5vt/6Zrnzvlm0zIZ/
	xcrVsQDSckspPS4JcQD0Ijyp85mF/Xv39BdPSLpHwPVzMiRYorE0bKth3vwNumgOZqC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vpRkB-006jGu-61; Mon, 09 Feb 2026 14:56:03 +0100
Date: Mon, 9 Feb 2026 14:56:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: kaweth: remove TX queue manipulation in
 kaweth_set_rx_mode
Message-ID: <d697a88f-dd8c-4ec1-ae4d-c97578a98498@lunn.ch>
References: <20260209053013.1701134-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209053013.1701134-1-n7l8m4@u.northwestern.edu>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257953-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 189D910FEE1
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 05:30:13AM +0000, Ziyi Guo wrote:
> kaweth_set_rx_mode(), the ndo_set_rx_mode callback, calls
> netif_stop_queue() and netif_wake_queue(). These are TX queue flow
> control functions unrelated to RX multicast configuration.

I think there needs to be a better explanation why it is safe to
remove these stop and wake queue operations. r8152 does the same. Is
it also broken? Rather than removing these, should we actually be
waiting for the completion of the urb?

	Andrew

