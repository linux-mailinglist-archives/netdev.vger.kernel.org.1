Return-Path: <netdev+bounces-293620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOYNJelKHWphYgkAu9opvQ
	(envelope-from <netdev+bounces-293620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C0A61C0F7
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313B530C7C14
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B436B33B6F8;
	Mon,  1 Jun 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1jgLt+l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZytZ623"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B036604F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304126; cv=none; b=r7Fat3ngxS941c4ZRP70SDmwoJQtkxiaoPliJwmb1jsxf+PQgdYMrmmn/I1MqHOrqPnx62/HVc5ksAgA1IBmmqr9OBPHvfcGPcPp3mVHPOWYdrk+uuhMkhabfD/EtkGfRYjVy5c+IOz7BkGbfeyLD5BjBZvZwVn4pLIndX6LmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304126; c=relaxed/simple;
	bh=RdY42p/wifndKo7H6IvgYAEM6T3/yfdMFrK3fgm+JxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMUZ8hUGM46MukP1f23TtnydK+1w3j8hwQmIwpxD9EQwzX67qooxCreQypXNVFBugUh6TM/hcioLQlanmROM2ZiSA+tDZaeI2+ioPv/ND0rBpVNomXdsZ5KV0AU/reLPb+xmYNs1YRzYfL34OvarZVj60NvZPIDibKy3n0b7BLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1jgLt+l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZytZ623; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780304124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yjzh0NtHlyLrWYA9pbw4B3H4HjCFbZjoPTHNDaaKotI=;
	b=E1jgLt+lvjcGXjAgs4gmrntpVl7zbsUh9kx0dslFt6ysYDYq8VKeuxOlTJR/Q+DLfgS5v7
	TmdTqBeLNcxkernBR9q/KAkHVcZyU0tuCZ8v5fUrOVYwqYaj5DuGbrfQkZEvna3ivatUei
	Ti0/v4/cAAkdgvCHPHt+uGmwoE/RdeQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-T-qYyQ0vPMaNHmfps9-t-w-1; Mon, 01 Jun 2026 04:55:23 -0400
X-MC-Unique: T-qYyQ0vPMaNHmfps9-t-w-1
X-Mimecast-MFC-AGG-ID: T-qYyQ0vPMaNHmfps9-t-w_1780304122
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eee3f9f03so3262359f8f.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780304122; x=1780908922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yjzh0NtHlyLrWYA9pbw4B3H4HjCFbZjoPTHNDaaKotI=;
        b=ZZytZ623HuAPZLw3CHnVyaAWLAnZcvhErkPM2jTHpI0J+5vGrMPd7zWhr5htcChMNh
         5t0mi39/wFbqxpEbjreN0DmO2j2qmZS6bbyFXZxJVNpqFp+WExig393H9s/labDnfXvs
         IvbjavVFU5rHOETKUhTA65u6Mifp2UdteDAF4M5ZKzYljmsyYDQRybOw7+UNmvmn+3w0
         YJUIn9cGNjer0zxzAkg+jBOYAEZGpHtUkFBfKynUzB9/DaDAafaploaw44CpLnNyV28K
         obGuyCsdKf0nX/IHSVLhFAGx/cj0x/OMeGPvUB41plfsBxDaOt20XDJ4zf9ATSDT9fDm
         OpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780304122; x=1780908922;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yjzh0NtHlyLrWYA9pbw4B3H4HjCFbZjoPTHNDaaKotI=;
        b=awfAH/xRCMuH3ATpfwLZ3JjN2XSok9+vMx97lzqHoCs8thQvU/iReK4STYfcwTY/L/
         NXq3neVKV5fg9a4xaFAXwW6YVlVGJh2FBZW1DrZXfRTmc9sBiiwV5mGZbas45VYN6GDU
         9NL16t7N2g+Pza1cuqNkGpdJfqyVk86dfLbTyhavb4rfbJDntPlZ7Bdt1BAeBh/axdcy
         4sFUbXdhVtVOcrR7wZmUaWaCanDoC2wnNGMBg24H+wcj9y/WOEY1kopbt0MVfDz/0p0m
         v8QyKn4IosYYP6dx7dOdRxikVjtJtfPneCAwssTrZ9jK4J9hJQLY6IDWXY+T1lMCa8iu
         UmeA==
X-Forwarded-Encrypted: i=1; AFNElJ9Wtfxt0SaarlHO9qWfCod73Ma2hZReU8wKCfvC3aLk+dp58qAvCrBKt49hEpFkkyOGlZtBcR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbZqatRU52+73jc1mnvwmFN9tN0Zz/Dpqj8zgGcyFKoef/yHQ
	Me83me7srlNTeis+8rfn7VSmG5x/FBuVsW+AyVzy1zLkz5I5N2zghL6wz/wXqvimKk2C7Fvy9n1
	N2kxkN32NaP5d7JEXXaP4FfuhyQVHsYyxhRAstDXdQ8uw1jXfim0uYizM/A==
X-Gm-Gg: Acq92OFEZ+1BaJk2GW8pQJ8v6fsUVucbBWCXp3Zt6ANY0giZl8W5TlcC+sDtXz+PbKL
	Q/GcJgk3AvI4J4Jx1s/WRKo91mdZuo+3wWbFDDApA2r674Al3Z6s+BNDR6DGlAog8UDHHY5akJy
	bYUDXfwi6Ot+XLwUyFlE2GHkIOVgYNKV/BeYbHIXG7BThWI0FctFoDAZ0eTRwgP3Xk29EwAJckW
	NWdEgdS3nH00GwYswujANESis4WL3syf9QyJ5toiDxfe4QRVslPBpYg/+KfmPielzJD22TjUSq9
	ZPlkDnURSbIGnnaDKU/YXI5wR8NZLnbGeqIBUxXAlFPGv6N2WuyW22nbY7U3RSIq9svBUu3zIUj
	YPbmjefFXvkYIzj9gwaqxG8xfHI797Yw2QewEs2i+djvLJfOaWFslfTkiHTA3PuJEa0M5
X-Received: by 2002:adf:e510:0:b0:45e:ef4a:819a with SMTP id ffacd0b85a97d-45ef6b1fb03mr15886991f8f.17.1780304121590;
        Mon, 01 Jun 2026 01:55:21 -0700 (PDT)
X-Received: by 2002:adf:e510:0:b0:45e:ef4a:819a with SMTP id ffacd0b85a97d-45ef6b1fb03mr15886931f8f.17.1780304121110;
        Mon, 01 Jun 2026 01:55:21 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3563cb9sm24854431f8f.29.2026.06.01.01.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 01:55:20 -0700 (PDT)
Message-ID: <aa312024-16ae-4984-98bb-d530abb71207@redhat.com>
Date: Mon, 1 Jun 2026 10:55:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] net: dsa: microchip: implement
 .support_eee() only if needed
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
 <20260526-clean-ksz-3rd-v1-5-5b63e732149a@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526-clean-ksz-3rd-v1-5-5b63e732149a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 04C0A61C0F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index a39541d29ad5..e0b3724a7558 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1909,6 +1909,54 @@ void ksz9477_phylink_mac_link_up(struct phylink_config *config,
>  	ksz9477_duplex_flowctrl(dev, port, duplex, tx_pause, rx_pause);
>  }
>  
> +/**
> + * ksz9477_support_eee - Determine Energy Efficient Ethernet (EEE) support for a
> + *                       port
> + * @ds: Pointer to the DSA switch structure
> + * @port: Port number to check
> + *
> + * This function also documents devices where EEE was initially advertised but
> + * later withdrawn due to reliability issues, as described in official errata
> + * documents. These devices are explicitly listed to record known limitations,
> + * even if there is no technical necessity for runtime checks.
> + *
> + * Returns: true if the internal PHY on the given port supports fully
> + * operational EEE, false otherwise.
> + */
> +static bool ksz9477_support_eee(struct dsa_switch *ds, int port)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	if (!dev->info->internal_phy[port])
> +		return false;
> +
> +	switch (dev->chip_id) {
> +	case KSZ8563_CHIP_ID:
> +	case KSZ9563_CHIP_ID:
> +	case KSZ9893_CHIP_ID:
> +		return true;
> +	default:
> +		/* KSZ8567R Errata DS80000752C Module 4 */
> +		/* KSZ9477S Errata DS80000754A Module 4 */
> +		/* KSZ9567S Errata DS80000756A Module 4 */
> +		/* KSZ9896C Errata DS80000757A Module 3 */
> +		/* KSZ9897R Errata DS80000758C Module 4 */

Sashiko noted that errata:

		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */

has been lost above.

> diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
> index f8f220242f7a..4cbbcf7993c9 100644
> --- a/drivers/net/dsa/microchip/lan937x_main.c
> +++ b/drivers/net/dsa/microchip/lan937x_main.c
> @@ -915,7 +915,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
>  	.port_txtstamp		= ksz_port_txtstamp,
>  	.port_rxtstamp		= ksz_port_rxtstamp,
>  	.port_setup_tc		= ksz_setup_tc,
> -	.support_eee		= ksz_support_eee,
>  	.set_mac_eee		= ksz_set_mac_eee,

Sashiko noted that `set_mac_eee` usage is gated by `support_eee` presence,
you may want to remove even the set callback.

/P


