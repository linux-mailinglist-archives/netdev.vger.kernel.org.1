Return-Path: <netdev+bounces-281212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MogIPHL7mkMxwAAu9opvQ
	(envelope-from <netdev+bounces-281212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:37:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80946C282
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32BEC3030B37
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35931B82B;
	Mon, 27 Apr 2026 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UN+3sYGN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4262E7635;
	Mon, 27 Apr 2026 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257350; cv=none; b=CeKtqMOgovKuL2OlLNOw3zSxTxZEwz0zFwSrOqWrhmMGHCXWTrDQtv2zh9WC1k/NUNjzZg6FQDbXek3nCDhqtsQ/QTQgqxIMG3gR4eTupt8IH0zrUIaGwHv9a34yx2BpdvX6UvTEjihfmdCcd+7QJ7GVrWK+V0jq3a2AtJzHFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257350; c=relaxed/simple;
	bh=GKrByMniTwmG3Bjyw+UoCiRn1kmEwA/XQSRNSc5ZDOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU6STXyjcTVqTnWQkOAsKTJebXDluXtyJKpY2OxPmYguVlQrEND39wdY4yHjIfV1dAbsHuJwUN5Pzs1xB8FouaxdyBbBs5gBZNh/qYQ660pyLXXkud1pjlOZpsLbPlYy2szaBt/mkloScVerU9OLTBSZvLkwS6Nk7JdhnxrPvMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UN+3sYGN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zni08zNYUA9Kcs3QKHXh+0X7eCZUOzQbgnCEbOl9KWQ=; b=UN
	+3sYGNmo/5vbwknrnID6YODUQjbRsJ4G/n19nQjfN+0MujL0pmbB+s1H3mEw68TFUROdA+t0XArRz
	lKI7seuHbnpZXS9neexNgCsYrBy+SXBvfD2wxfRSY6ook4xgg50LB8nqm8MPmFJ/iy7E12NNVV/IB
	3EoGKs4OEDKO8zM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHBoz-0005hr-4T; Mon, 27 Apr 2026 04:35:41 +0200
Date: Mon, 27 Apr 2026 04:35:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?67CV66qF7ZuI?= <mhun512@gmail.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ijae Kim <ae878000@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH DRAFT] net: cirrus: ep93xx: fix probe error unwind
Message-ID: <4201a9ff-c137-4e08-85f8-32aaa6aa3836@lunn.ch>
References: <20260426141010.19049-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426141010.19049-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Rspamd-Queue-Id: DC80946C282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281212-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, Apr 26, 2026 at 11:10:06PM +0900, 박명훈 wrote:
> From: Myeonghun Pak <mhun512@gmail.com>
> 
> ep93xx_eth_probe() uses ep93xx_eth_remove() as common error unwind
> after setting driver data. When register_netdev() fails, this calls
> unregister_netdev() for a net_device that was never registered. The
> net core treats that as a driver bug and emits WARN_ON(1).

How did you trigger the failure of register_netdev()?

    Andrew

