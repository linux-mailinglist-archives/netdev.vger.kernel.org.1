Return-Path: <netdev+bounces-279737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN+kNycm5mmgsgEAu9opvQ
	(envelope-from <netdev+bounces-279737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:12:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0442B505
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0458C3083569
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59F3A0B13;
	Mon, 20 Apr 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T+47RR4Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB839FCAD;
	Mon, 20 Apr 2026 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690278; cv=none; b=Vqe/hr4tDeAQ7ZmjIFnRPuweDWL8ZRQLM2u8xwwUOCrgdNWKTbxHOdTC090jKIR2EKg/YP75ZKU04um4n5v+72DTJ9mfPVp4RyRDamuFXume3KSv6oAoDLkitBURcLLJ5J/E1nSiWH1/mqbPJo/yRJWr1mJaoZPNmptKfiHNZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690278; c=relaxed/simple;
	bh=IckNs1lb9ON8haf5AAzlqpdarUqnxonM78zax5oDwFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj7vro1YNkrW6wIG4mp+2DXq/Rbfqmkw3Gnk0vL7tTD+1oGeTD08UIOIC6Hb9mH8YnqCVSZ/F2ZFIqB75AG5gq7AduaxGzMAoFbkB09HUbjZObkdcSLQHjPHfilKaBcri/WJ7ODluiU37p+GHqtivLXljpusiJQpab2wSRLcLNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T+47RR4Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j+Ow2iVIvgHDS0iOM3IoQCUnHCWQqTfVvjNR0f5AxYI=; b=T+47RR4Z1TU/7a3p5HLHP47eTA
	QuNTQH83CPj3DT5PAzKeChrfHeWtCTE20bymK7RO7uD0dSdLzsOSUtqYsicepIWGOHd2sudsvJIrq
	NqWot33L3ovaQ05cuQ9h35lG584r4I+/DOLIUakLZ0p/JpWRGS16+Bwsps2teoBvF4V0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wEoIg-00GkBG-6M; Mon, 20 Apr 2026 15:04:30 +0200
Date: Mon, 20 Apr 2026 15:04:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: rose: use pskb_may_pull() in CLEAR_REQUEST length
 check
Message-ID: <48f45bdb-6edf-4676-a96e-4530634cd7c0@lunn.ch>
References: <20260420015723.462479-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420015723.462479-1-ashutoshdesai993@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279737-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 86E0442B505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 01:57:23AM +0000, Ashutosh Desai wrote:
> Commit 2835750dd647 ("net: rose: reject truncated CLEAR_REQUEST frames
> in state machines") guards against short CLEAR_REQUEST frames using a
> plain skb->len comparison. Use pskb_may_pull() instead, which both
> enforces the length requirement and ensures the bytes are in the linear
> part of the skb, making the subsequent accesses to skb->data[3] and
> skb->data[4] safe for non-linear buffers.

Did you review all the other comparisons on skb->len in rose?

rose_route.c-	if (frametype == ROSE_CALL_REQUEST &&
rose_route.c:	    (skb->len <= ROSE_CALL_REQ_FACILITIES_OFF ||
rose_route.c-	     skb->data[ROSE_CALL_REQ_ADDR_LEN_OFF] !=
rose_route.c-	     ROSE_CALL_REQ_ADDR_LEN_VAL))

rose_loopback.c-		if (frametype == ROSE_CALL_REQUEST &&
rose_loopback.c:		    (skb->len <= ROSE_CALL_REQ_FACILITIES_OFF ||
rose_loopback.c-		     skb->data[ROSE_CALL_REQ_ADDR_LEN_OFF] !=

Do these need the same fix? Are there other places non linear buffers
should be considered?

       Andrew

