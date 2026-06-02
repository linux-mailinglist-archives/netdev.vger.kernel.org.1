Return-Path: <netdev+bounces-294194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H1z1Cj7LHmrLVAAAu9opvQ
	(envelope-from <netdev+bounces-294194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AE762DFB3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:23:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=ZubpUS2B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294194-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294194-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF3863032764
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B73DA5AD;
	Tue,  2 Jun 2026 12:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03613D891C;
	Tue,  2 Jun 2026 12:21:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402893; cv=none; b=KEIEYs/KDyZ+834nTByKRbqTHTfNzGaomYMOEYRyEF+xfOBo3l+PVAbmlhyCNg+zNopDCgS+y0HbY+lbdsdaK1n8yedgh+z/PoREwqP99G8UoxOeCUPXXNv0wFdOvom4rlaog48ZZ/AY18X5rOreMKP0T4WVZAgQfkkFXQaTbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402893; c=relaxed/simple;
	bh=KSIVPzGB/KOFzsRmY+QOMoza4M9dHb1Fwl+9iTGxg9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdBEBz2ftBrrZMuFOHoF0j2XBVhvvO5yVDCPvBgWCF5Y14eEMy9mMSIDmmc1zv+vQIUuOrruIeSyeif3f4c6Whxzrc6BA1t3yIV1GsFor/NgmbZ8mYaNFUR9y0OGCnJ4N8YGBV8kUg611vNK3V5wPBXtm3E+42W/aU1zPKm32+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZubpUS2B; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 48B6A4E42DCC;
	Tue,  2 Jun 2026 12:21:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17DED603BC;
	Tue,  2 Jun 2026 12:21:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14A9A108883E7;
	Tue,  2 Jun 2026 14:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780402889; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JmmUNE8EvUgOeKezAWA5DAJi307Hu7PDjg8cEuhbAUc=;
	b=ZubpUS2B57BJ1nm8s6L/YQwAmjph1Gm6zY+1RAqDzRNEwpQvWCt9QyP1JzBrUThjLWqc7c
	mc2dLxSWH/zIVEgrUorDqYF3sX2LULyBMWYonCj9M/rMOW14tk4AMZP9SNzxbRsaaLW3zk
	rinU5dQVS0/csDtJnZeSvPTY/a3GhpYJnOddc2y1OOZrNfIt2R+DAkxvZMqJgZlwd+/LHi
	rrvEQyuCxOGCElZKoPJ34IKp6mtKYrCgDMXjaCmyoa//921nCOAWMoVMgz28tXmV93SC43
	TknnPNaogZdii201900AlXQqHx+rYP4aLXgIW5wMO3nyKap+id4s45v/q9O8+Q==
Message-ID: <aba1f7f6-612b-4c0f-99fd-4a5f0ee0b221@bootlin.com>
Date: Tue, 2 Jun 2026 14:21:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] net: dsa: microchip: implement
 .support_eee() only if needed
To: Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
 <20260526-clean-ksz-3rd-v1-5-5b63e732149a@bootlin.com>
 <aa312024-16ae-4984-98bb-d530abb71207@redhat.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <aa312024-16ae-4984-98bb-d530abb71207@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294194-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:from_mime,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92AE762DFB3

Hi Paolo,

On 6/1/26 10:55 AM, Paolo Abeni wrote:
> On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
>> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
>> index a39541d29ad5..e0b3724a7558 100644
>> --- a/drivers/net/dsa/microchip/ksz9477.c
>> +++ b/drivers/net/dsa/microchip/ksz9477.c
>> @@ -1909,6 +1909,54 @@ void ksz9477_phylink_mac_link_up(struct phylink_config *config,
>>   	ksz9477_duplex_flowctrl(dev, port, duplex, tx_pause, rx_pause);
>>   }
>>   
>> +/**
>> + * ksz9477_support_eee - Determine Energy Efficient Ethernet (EEE) support for a
>> + *                       port
>> + * @ds: Pointer to the DSA switch structure
>> + * @port: Port number to check
>> + *
>> + * This function also documents devices where EEE was initially advertised but
>> + * later withdrawn due to reliability issues, as described in official errata
>> + * documents. These devices are explicitly listed to record known limitations,
>> + * even if there is no technical necessity for runtime checks.
>> + *
>> + * Returns: true if the internal PHY on the given port supports fully
>> + * operational EEE, false otherwise.
>> + */
>> +static bool ksz9477_support_eee(struct dsa_switch *ds, int port)
>> +{
>> +	struct ksz_device *dev = ds->priv;
>> +
>> +	if (!dev->info->internal_phy[port])
>> +		return false;
>> +
>> +	switch (dev->chip_id) {
>> +	case KSZ8563_CHIP_ID:
>> +	case KSZ9563_CHIP_ID:
>> +	case KSZ9893_CHIP_ID:
>> +		return true;
>> +	default:
>> +		/* KSZ8567R Errata DS80000752C Module 4 */
>> +		/* KSZ9477S Errata DS80000754A Module 4 */
>> +		/* KSZ9567S Errata DS80000756A Module 4 */
>> +		/* KSZ9896C Errata DS80000757A Module 3 */
>> +		/* KSZ9897R Errata DS80000758C Module 4 */
> 
> Sashiko noted that errata:
> 
> 		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
> 
> has been lost above.

Yes that was more or less intended because KSZ879x/KSZ877x/KSZ876x don't 
belong to the KSZ9477 family. I haven't found a relevant place to move 
this comment as .support_eee() is removed from ksz8.c, maybe I should 
have mentioned it in the commit log.

> 
>> diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
>> index f8f220242f7a..4cbbcf7993c9 100644
>> --- a/drivers/net/dsa/microchip/lan937x_main.c
>> +++ b/drivers/net/dsa/microchip/lan937x_main.c
>> @@ -915,7 +915,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
>>   	.port_txtstamp		= ksz_port_txtstamp,
>>   	.port_rxtstamp		= ksz_port_rxtstamp,
>>   	.port_setup_tc		= ksz_setup_tc,
>> -	.support_eee		= ksz_support_eee,
>>   	.set_mac_eee		= ksz_set_mac_eee,
> 
> Sashiko noted that `set_mac_eee` usage is gated by `support_eee` presence,
> you may want to remove even the set callback.
> 

True, will do.



Best regards,
Bastien

