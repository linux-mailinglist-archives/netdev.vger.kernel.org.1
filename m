Return-Path: <netdev+bounces-281242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BkKJVQM72kq4wAAu9opvQ
	(envelope-from <netdev+bounces-281242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:12:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ADD46E27B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E110430055FC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDA6390234;
	Mon, 27 Apr 2026 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hhf/jhgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE439022B
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273670; cv=none; b=GyDNb1bLYH+4Y+IYHXTdMc1KWZ07HtFQ0cTzKKr+BPUlNjSIp6lqjbsa5BmxilyAEycI41z1MgGONMEItrcvN1f+n8AGbL0fP5maefUZ2jbkGJ1cuo4DJuDVV8bw/dwrqa56qMVh3kLJaLi+0s9hEqV7g7o8X3thW0Z/UqFFRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273670; c=relaxed/simple;
	bh=Mhp3DwukdUvfofy9qsZYBJJjQOPNT4ymEbhmDCHLRCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyfiNNVi1Uxhv85mxKvi6lQtCjoLg7UAOk62br7x2IxnejFEzVDa0F6m6IrKPE3epjTX4TwylYCEcbj5DVHVaqrQ6aCx3Jo/Ery5DSUwXXEX43hEibnrAlUJz2VkCx1kE5Lx6grxeTrw4aMvXxJZxrAHMWdDRX1dBkngNT5X1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hhf/jhgA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 248A1C5CD44;
	Mon, 27 Apr 2026 07:08:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9228600D1;
	Mon, 27 Apr 2026 07:07:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C26B2107221B2;
	Mon, 27 Apr 2026 09:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777273658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vNxFg9b+KAR2PHSMWqVq5HtklhAticHLEOwjfIZMiVk=;
	b=hhf/jhgAMkiIqOacCFxd3zvikTv6CeHpjIXSb5XyivIdO5xk2KI+eS5cxfoEEfFnXB7N3L
	BQfFdPUZz+pE30zql++FRwg8x09eb45PDGEXSVOun3+lDT5sxv8aTmg71BjOaDmEfO0nIm
	pyV3Nq2BPA3nBvUJePubCp5jlAQ2KZogO/wicYVfzNvMO1x/rhdIyRFmqRJVvDsS0RzKWm
	N+14MNCObYr0Wn0MCBKL+asYWskq983xiA1T1IeQZOcIr0/B8bm2UixBSrQdjHG6AEhqbK
	H8wGvn/bDQtJu01G9z1iXJKOa8WqHHXoexxeIMvVwyjhlaJgUjpCtJcYQ4RVGA==
Message-ID: <c2d977b5-5ddd-4237-8b47-a28d5b97ac4d@bootlin.com>
Date: Mon, 27 Apr 2026 09:07:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lan966x: avoid unregistering netdev on register
 failure
To: Myeonghun Pak <mhun512@gmail.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ijae Kim <ae878000@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260426142806.36028-1-mhun512@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260426142806.36028-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 94ADD46E27B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281242-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]



On 26/04/2026 16:27, Myeonghun Pak wrote:
> lan966x_probe_port() stores the newly allocated net_device in the
> port before calling register_netdev(). If register_netdev() fails,
> the probe error path calls lan966x_cleanup_ports(), which sees
> port->dev and calls unregister_netdev() for a device that was never
> registered.
> 
> Destroy the phylink instance created for this port and clear port->dev
> before returning the registration error, matching the existing guard
> used by the common cleanup path.
> 
> Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 47752d3fde..22c496f588 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -873,6 +873,9 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
>  	err = register_netdev(dev);
>  	if (err) {
>  		dev_err(lan966x->dev, "register_netdev failed\n");
> +		phylink_destroy(phylink);
> +		port->phylink = NULL;
> +		port->dev = NULL;
>  		return err;
>  	}
>  
> 

Strictly speaking, setting port->dev to NULL should be enough, but IMO
it's a bit cleaner your way as the function cleans everything after itself.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com

Maxime

