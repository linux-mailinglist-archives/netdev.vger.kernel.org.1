Return-Path: <netdev+bounces-280811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN1QFQ1O6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:51:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F9D4551CF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81212301D625
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA637BE89;
	Thu, 23 Apr 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jtuFRaQR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACE31DDBF;
	Thu, 23 Apr 2026 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962808; cv=none; b=kUkclskBtWLM0bMr/6CGtyZ772dEpLLOoL0PO5f6IsbJLW7iMzd7e/DfGSXKp46J1fD77tr2xMzM33TUudDN0/JSp88GWZA4ni1yvpEihDyHCq90eT1WC77yGh6qNZKjS6wJUKbrS0W+tGmyZ2Pqzl97y7LsImrq7k8Y9nlAjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962808; c=relaxed/simple;
	bh=bT4T3mr5wQG7XMwrFze16ct6UyUgR364L6z1mh3xjjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAcjGkic+CAqOfwvN4cOEMLOq2RUQdgCZhfUMwgF8ZNGjzB82qsGjaz13o//g/ZBAxHTjZByp3Gm4WYheNPOqRPsStoTOR26JDRERzh13Cc3iuf3yRNh7uKpzhBRAqFbxgO3lLwMwX0Seo5qCqATXUpPu9pF6bs0cjq4ngTBVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jtuFRaQR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KRyk8zs0yOkAi8m3yp/2JrJvn5JKJ5mHqm7TULytzF0=; b=jtuFRaQR9HJKm6KgImnmOr3pFQ
	1fvyJdWnFXwpgUMaYxiV7wyC+e206Bon8Wb7mPOMg5hgUqxeqYR2ljBYijO+o0amP7oClbSCXNL5y
	kFetmKw9OKiVM70w+bWCdfZmee6PF87rmosVeXRL9LffY3Ilca/inWJ7AaT6a3FVazvc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFxCI-00HGq4-Kx; Thu, 23 Apr 2026 18:46:38 +0200
Date: Thu, 23 Apr 2026 18:46:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [RFC PATCH] net: skb: on zero-copy formatted output to skb
Message-ID: <cdcb241c-5c7c-4ce4-a628-0375ff2668b2@lunn.ch>
References: <20260423073638.778334-1-dmantipov@yandex.ru>
 <8ed4f473-9c7b-4f77-911c-85cfb2fba2a5@lunn.ch>
 <65872064c2ab5fbf47a743f2dcd72182ea8296a7.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65872064c2ab5fbf47a743f2dcd72182ea8296a7.camel@yandex.ru>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280811-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7F9D4551CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > So please add some kerneldoc describing what it actually does.
> 
> OK, some more neutral name like 'skb_fmt(...)' may be better indeed.

Sure. Just document what it actually does, what the return value
means, etc.

> > Please also annotate the const char *fmt, so the compiler can do
> > format string checks, parameter counting etc.
> 
> Surely '__printf(2, 3)' should be used here.

Yep.

Thanks
	Andrew

