Return-Path: <netdev+bounces-263820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COiwHaI3qGkTqgAAu9opvQ
	(envelope-from <netdev+bounces-263820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:46:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A4200A8D
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740C531918B9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7106334CFC6;
	Wed,  4 Mar 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vn118Ggo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0104372B28
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631642; cv=none; b=M88h8+8LulJQffk+iYAHJwMY3ErvNPcup8WLjG1q31Mh288RLea8eu1WiRMwQxA/AwNxSEEQJmOHiXc+bM1wUBojMNEaE5uc9lCZuqYGbpAH5G2MRXm6BPY0QqLb2qa/zz5gbybtrt2eOfoMu+aoEPLagV/2X8wMLURH+/pBDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631642; c=relaxed/simple;
	bh=M3L6PJl832x3WfzQnsuTQ35CN1Iuu4WS8z/YiFVWNIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1M3lo52V3acNI7j4C6oMyjbJ+I5F/90qfjzXNoEUHx4Aj6zcb3n11daUcsC0s4qzA8FrL00cMAEjdV/z461j6rSGIJzIYZJN19Ho/nuYyuipMJi56CDwWeeToSOXEOJjqIly4+fS0FYgMmr9ZzA9EbBswSDkqxLqy3FgCkz3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vn118Ggo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6E4B64E4253B;
	Wed,  4 Mar 2026 13:40:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F0205FF5C;
	Wed,  4 Mar 2026 13:40:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7079E103695C1;
	Wed,  4 Mar 2026 14:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772631637; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qz60AARpWD1sB++xNj24Xpr0iuf312nxadvUtUC3rJg=;
	b=Vn118GgoGSZz1GylG+UdJIQGQ4df9EqLS2TKom3wzm9J74F5UctRwcQUc6ZygU0ej9PEPP
	zRpPr/azw25GCGk+cPfm6FQGPD6Ep3kJm0AgnURo/z5JiB7rQh7ctKPKZ2WypgQPiYRIFY
	/RIs4JFBFLrfoQEAYP+C3nIEmFqPMQVOXtHmQo7BDO8lvFXGd45faW6R4Y9cGSakKwbXof
	64LIt+IAf1fzFYf47eKE3jPjelFX4mX+/90m3JZxS4qlwyZVX4x7NE+dBzyS0p3nGbgxIf
	qCM0AvVBvWwYig1baDtLTodWiRI+M+rObs90OpjvxI3vCvfFe0Rrne9Dboyjzw==
Message-ID: <5826cc04-10c6-45f5-a39c-6fe56bc671dd@bootlin.com>
Date: Wed, 4 Mar 2026 14:40:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] amd-xgbe: prevent CRC errors during RX adaptation
 with AN disabled
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 horms@kernel.org, Shyam-sundar.S-k@amd.com
References: <20260304122305.812541-1-Raju.Rangoju@amd.com>
 <20260304122305.812541-3-Raju.Rangoju@amd.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260304122305.812541-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CF3A4200A8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263820-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Raju,

On 04/03/2026 13:23, Raju Rangoju wrote:
> When operating in 10GBASE-KR mode with auto-negotiation disabled and RX
> adaptation enabled, CRC errors can occur during the RX adaptation
> process. This happens because the driver continues transmitting and
> receiving packets while adaptation is in progress.
> 
> Fix this by stopping TX/RX immediately when the link goes down and RX
> adaptation needs to be re-triggered, and only re-enabling TX/RX after
> adaptation completes and the link is confirmed up. Introduce a flag to
> track whether TX/RX was disabled for adaptation so it can be restored
> correctly.
> 
> This prevents packets from being transmitted or received during the RX
> adaptation window and avoids CRC errors from corrupted frames.
> 
> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Small nit on my side :

[...]

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index 4333d269ee84..75c021b38a28 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -1266,6 +1266,10 @@ struct xgbe_prv_data {
>  	bool en_rx_adap;
>  	int rx_adapt_retries;
>  	bool rx_adapt_done;
> +	/* Flag to track if data path (TX/RX) was stopped for RX adaptation.
> +	 * This prevents packet corruption during the adaptation window.
> +	 */
> +	unsigned int rx_adapt_data_path_stopped;

This is only ever set as true/false, maybe make it a bool ?

>  	bool mode_set;
>  	bool sph;
>  };

Maxime


