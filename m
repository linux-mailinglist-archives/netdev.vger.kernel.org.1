Return-Path: <netdev+bounces-275598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B0fLVm402mqkwcAu9opvQ
	(envelope-from <netdev+bounces-275598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:42:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 260653A3A54
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE1B6301650D
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBC2EC54A;
	Mon,  6 Apr 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NFftRxmS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1732EAB61;
	Mon,  6 Apr 2026 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482913; cv=none; b=Tmbf/3RJsIsNMGjY3gG9p0/KKaRt3PAj5DMYcbrSBQSLwU3sg240XWNQKlWiGo5CiiP74yJROwAfzCU7sPbmomAn3B5Ky0VIWIxQSNnO4FFuTt2WPZqEjWeKKYc8XpenTdLpCWGig5cGVNEFQvnic9FSYQCXRpN/+frwzlZy0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482913; c=relaxed/simple;
	bh=ZkWh6ni8clb78ksTKZC/zmZzMqZGtQd3d5gS8a9Nu7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8XJjnylwCG20rxOOdnypejCfbKWAaihtGWRwWBM7F+sPYxjAgVp+6UGb2mJbk7BB2LL3Xy2GkgBM81Ef6jl794gaz7oFgOo7BmzrVzl1P+GAEExQWA52iZN7M6mX4lAodbN2/iLThWp747aSt6ivgKJHJ+Sk65uQ+ioa9qqg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NFftRxmS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ULEfWSjnqZuwvt7ftQT2cZMGqxDo3cs9w58PjSSKSms=; b=NFftRxmSEWDdcDcVYXH3jB2Cgi
	5WYkKX1EkS5m/0XvRfje5kJmtQWASWn2jUr9tIlrMUgUz24X6XiqMnvy/prPdy6XWmb9Kpj/bjo4+
	kuBQ7+Gk1PePsp1Crjns7FYrgA/Og1aUAhTm6ZPuHmsEgGTmFlseWyzKquOQz3hEMmww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9kCu-00EzZN-63; Mon, 06 Apr 2026 15:41:36 +0200
Date: Mon, 6 Apr 2026 15:41:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johan Alvarado <contact@c127.dev>
Cc: me@ziyao.cc, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, ggo@tuxedocomputers.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-motorcomm: fix eFUSE MAC address
 read failure
Message-ID: <a276bd90-4883-42e9-b470-5ec0fc762d08@lunn.ch>
References: <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
 <fc5992a4-9532-49c3-8ec1-c2f8c5b84ca1@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5992a4-9532-49c3-8ec1-c2f8c5b84ca1@smtp-relay.sendinblue.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275598-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid]
X-Rspamd-Queue-Id: 260653A3A54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>  	motorcomm_reset(priv);
>  
> +	/*
> +	 * After system reset, the eFuse controller needs time to load
> +	 * its internal data. Without this delay, eFuse reads return
> +	 * all zeros, causing MAC address detection to fail.
> +	 */
> +	usleep_range(2000, 5000);
> +

This seems reasonable. My only comment is maybe this should be inside
motorcomm_reset(). But i don't have a strong opinion.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

