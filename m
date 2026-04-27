Return-Path: <netdev+bounces-281441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOm6MTio72mpDgEAu9opvQ
	(envelope-from <netdev+bounces-281441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:17:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60394478607
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B34A1302C766
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFED731E84F;
	Mon, 27 Apr 2026 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fJORxUaT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5103E9298
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313682; cv=none; b=NjDMYfhA3opQjHMBCSt2KYaVRUd4ZtNvnQ6SxXjos1c9Wk6OV6UGeZqFovfXjnvzTjyRyHM7mBUEi2q/5WgXZcumnkmbwvFI/0jc8emzEIslfJBcolW3Jbwc2iTgLf4N2qKJsSOn7spSdBL7tx6s2vOkUnkumKWNI0+BPbBa5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313682; c=relaxed/simple;
	bh=HPkklJMSjDq+plPrDi+PNv7bIYwLDsk27D1D7Ma0l1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmyW8YKyf7vOAwBSLY89HcRddjlZ8Yg57wmUaZ2kxyKYsgplqY8LBZ3ju4qRm76K7dWx8aJhxBex1HbtJ3UoWR+RfsVN3tA3ey/z6CbQr+HRBXJxrrvk+bDLMXJi7tXTpZQXjmb9rEfRrHYTukACOeuw/xuZV9fFpuOlykCcqvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fJORxUaT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5fMY+7qktMp3ALtvvo50hwkE7y/ouSRzuEqm5ukl6zo=; b=fJORxUaTBnYCMOIs0Za8LGeA99
	t4Gfi7rypiksLK1frPKt7LvpqU9OkMGR1U1t67/4C/GxdoEKtuUIn0IlrJSJKXAsYW/dL++onszFZ
	0f2es7xPyyWAdsQZp6lwNWj3Ta2iAMhZ0+bnPDWzT6I0+Dr3X/Fh+ff9J2bDrzZFh3c8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHQTc-000Cl8-55; Mon, 27 Apr 2026 20:14:36 +0200
Date: Mon, 27 Apr 2026 20:14:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: kernelcoredev <sonionwhat@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: nixge: fix skb leak and missing bail on DMA mapping
 error
Message-ID: <a122c852-8fa1-438d-a22a-800dc1cf5383@lunn.ch>
References: <20260427174608.8201-1-sonionwhat@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427174608.8201-1-sonionwhat@gmail.com>
X-Rspamd-Queue-Id: 60394478607
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

On Mon, Apr 27, 2026 at 01:46:07PM -0400, kernelcoredev wrote:
> When dma_mapping_error() fires during RX buffer refill in nixge_recv(),
> the skb allocated by netdev_alloc_skb_ip_align() is never freed, and
> execution continues writing a corrupt physical address into the hardware
> descriptor ring.
> 
> Fix by freeing the skb with dev_kfree_skb() and returning early.
> 
> This was tested via code inspection, as I do not have access to the
> hardware. If dma_mapping_error() occurs, the current code continues
> execution, which can leak the skb and program an invalid DMA address
> into the descriptor ring. This patch ensures proper cleanup and early
> return on error.

Please continue your code inspection. What happens to the ring
descriptors if you return early?

If the fix was so simple, why do you think there is a FIXME?  This is
the problem of not testing on hardware. Do you know if your change
makes the code better or worse? Please argue why it is better,
including an explanation of what happens to the ring descriptors with
your fix in place.

	  Andrew

