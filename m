Return-Path: <netdev+bounces-280751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEatOScU6mmVtgIAu9opvQ
	(envelope-from <netdev+bounces-280751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193B4522CC
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49D4D30293D6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76953537D0;
	Thu, 23 Apr 2026 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ViXpZ0Q8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967A37105A;
	Thu, 23 Apr 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948065; cv=none; b=koz/SOLbrWVaa8vqdAsTrwrsBjoMf+LuikQap7zR5vciBMqGzi8+a6JveslxIhmetxgRBEhuWoZ8X2SsdlflySsKcZt3R9dQWCXHHstDs4/ruo0RTvrq4oZj44ZQLenZ6MwdM0GnDiW8xAwMrvsSHk4PgJGr0eLx+InwIF5EIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948065; c=relaxed/simple;
	bh=Zk4HKmvkfs7hH0SDQwXkpHH4i4EuKAYcVwx5XA2iOss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGa3wRCZRuAq4CfYnpp+zGDzR4WandJOvq/XCsbw4mOQBL0uWkFzwQRFvHLurz/1SOShnrerJ5KxWRnY3IG6tkk64NKlDEOvEzlEIsdC2qxvoZo0cxNoYnE3L0kOAPQYFKMckM/FYPROC+CniKRL4i3A43gUYTWB5ydrWHfYJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ViXpZ0Q8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8FmwZtN1y6BoV5Ve6lAIvLGkkB7olc90eroXqrsLzQI=; b=ViXpZ0Q8lnAYZfguogeZWC4nq4
	74FBn+wJPgtxOOGrskyjPGTXFL/AkOc3mKioZxtfOY5GYogpEzjc/H+mze+scM6AY1PYQnvsutsmi
	Hwo6Bi4b2Kmzn1jwvu2sgVakgCQCpmq7Zl/DOycY2UVKHSFByekeXQwXoLSebMYJe8rA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFtMR-00HF9b-Su; Thu, 23 Apr 2026 14:40:51 +0200
Date: Thu, 23 Apr 2026 14:40:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [RFC PATCH] net: skb: on zero-copy formatted output to skb
Message-ID: <8ed4f473-9c7b-4f77-911c-85cfb2fba2a5@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9193B4522CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +int skb_printf(struct sk_buff *skb, const char *fmt, ...)
> +{
> +	int len, size = skb_availroom(skb);
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	len = vsnprintf(skb_tail_pointer(skb), size, fmt, args);
> +	va_end(args);
> +
> +	if (unlikely(len >= size))
> +		return -ENOSPC;

A quick look in drivers/bluetooth suggests that none of them care
about truncation, at least they don't check the return code. Maybe it
would be better to truncate than return an error?

I would also try to make the behaviour consistent with the normal
sprintf(), or snprintf(). You want to give users some idea what it is
doing based on its name. It is well known that snprintf() will
truncate, and does not return an error code. sprintf() will just
overwrite the end of the buffer and not return an error code etc.

However calling this skb_snprintf() would be odd, since you don't
actually pass size. But it hints at what it does.

So please add some kerneldoc describing what it actually does.

Please also annotate the const char *fmt, so the compiler can do
format string checks, parameter counting etc.

	Andrew

