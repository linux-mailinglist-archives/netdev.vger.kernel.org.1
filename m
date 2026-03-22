Return-Path: <netdev+bounces-270326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMoPD61twGm8HgQAu9opvQ
	(envelope-from <netdev+bounces-270326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 23:31:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D22EB07D
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 23:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A7B53003341
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B931F9B4;
	Sun, 22 Mar 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="qKeM3FFM"
X-Original-To: netdev@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881792D6401;
	Sun, 22 Mar 2026 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774218665; cv=none; b=Fmi1wm0U5OGnKHoXZ3Qk1iHFstckT9joUu/vbN9NQbvAtcrlcyb6uUuBgFub6/0YhIFNuZd9QdJmXXDgomr6kz6cUxJMRdFcPwrUzfduuDkS2eilV7fXNqDNa+UFu0uEzdsD6X8xX8abGvr4jSp33PHxSHdz4ctYqjT0nS02L24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774218665; c=relaxed/simple;
	bh=lYKe0OFVCOvUad8XOwgsB65LZTSeh6vt7MKgfoAxGH8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kvoCYN+iksGrCXoxrsQQdzQUDYH6ss627KlqSMzE4qAXvYFejbWLDgocZmHABI0Q/82jYP+ajiYZ2YSOc5GAkmnavKFGTx/J7oQ7iu9XXRQU4rJ4mKCbYAggTGTqJuisM6vgAgzuyUwHVElxKMBBH+7JnbdFVx/LEJEbWHQE1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=qKeM3FFM; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [192.168.2.30] (unknown [46.253.254.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 9DAF6C0BDC;
	Sun, 22 Mar 2026 23:30:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1774218658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYOCuf/ly8BoZXQyzkfsTc2ynrPZJj+oggEuSvbMOTQ=;
	b=qKeM3FFMe4IzA7tKgbFXUWAJmh3wN3aKcOKm5ouoKB4E+gv95U79hAq91jQ8u1ZobVY/+x
	hXGKDpz4QpkRFTHgq/2ieM6GJoECEIvoKLiQa6Oedr93NfQ5REp2OMmeLe0iAvv1DDvkzq
	cp2aUcIlsuhv+SU3EZ2EYb0AD7JJSwMLCJhWh9ErIsiu3MN22JoG3dLwd9ROmxociF7v1v
	9XmtI6F3KogRBiyG+dIMDgKb8QtAx88+lN3/5fBH0IqRcdtqHINsv6xUveNNJM3Tbem68s
	QUl/Jj5/a4KGO2ZHxA/mYbgCkiTwNoEx0v8i8/C4LKMIdnDRn8QpacrLSMnq3Q==
Message-ID: <3e1d00af-de85-46e0-9d94-2e8fdd29928d@datenfreihafen.org>
Date: Sun, 22 Mar 2026 23:30:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ieee802154: atusb: drop redundant device reference
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Johan Hovold <johan@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260305104313.15898-1-johan@kernel.org>
 <d71db3f0-12b0-485b-afec-ea5eeed35305@datenfreihafen.org>
Content-Language: en-US
In-Reply-To: <d71db3f0-12b0-485b-afec-ea5eeed35305@datenfreihafen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[datenfreihafen.org:s=2021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[datenfreihafen.org];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270326-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[datenfreihafen.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefan@datenfreihafen.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D96D22EB07D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello again,

On 3/22/26 23:27, Stefan Schmidt wrote:
> Hello,
> 
> On 3/5/26 11:43, Johan Hovold wrote:
>> Driver core holds a reference to the USB interface and its parent USB
>> device while the interface is bound to a driver and there is no need to
>> take additional references unless the structures are needed after
>> disconnect.
>>
>> Drop the redundant device reference to reduce cargo culting, make it
>> easier to spot drivers where an extra reference is needed, and reduce
>> the risk of memory leaks when drivers fail to release it.
>>
>> Signed-off-by: Johan Hovold <johan@kernel.org>
>> ---
>>   drivers/net/ieee802154/atusb.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/ 
>> atusb.c
>> index 95a4a3cdc8a4..5f7fc4ee7a07 100644
>> --- a/drivers/net/ieee802154/atusb.c
>> +++ b/drivers/net/ieee802154/atusb.c
>> @@ -961,7 +961,7 @@ static int atusb_probe(struct usb_interface 
>> *interface,
>>       atusb = hw->priv;
>>       atusb->hw = hw;
>> -    atusb->usb_dev = usb_get_dev(usb_dev);
>> +    atusb->usb_dev = usb_dev;
>>       usb_set_intfdata(interface, atusb);
>>       atusb->shutdown = 0;
>> @@ -1055,7 +1055,6 @@ static int atusb_probe(struct usb_interface 
>> *interface,
>>       atusb_free_urbs(atusb);
>>       usb_kill_urb(atusb->tx_urb);
>>       usb_free_urb(atusb->tx_urb);
>> -    usb_put_dev(usb_dev);
>>       ieee802154_free_hw(hw);
>>       return ret;
>>   }
>> @@ -1076,8 +1075,6 @@ static void atusb_disconnect(struct 
>> usb_interface *interface)
>>       ieee802154_unregister_hw(atusb->hw);
>> -    usb_put_dev(atusb->usb_dev);
>> -
>>       ieee802154_free_hw(atusb->hw);
>>       usb_set_intfdata(interface, NULL);
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Given that this does not actually go through my tree an Acked-by would 
be more appropriate here. Sorry, its late.

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>


> Jakub, Dave or Paolo can you folks please pick this up into net-next? I 
> waited a moment but I have nothing else for wpan-next in the queue for 
> now, so it would be silly to have a pull-request just for this.
> 

regards
Stefan Schmidt

