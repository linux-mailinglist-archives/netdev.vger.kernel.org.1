Return-Path: <netdev+bounces-275163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DZtBw4M0Gkp2wYAu9opvQ
	(envelope-from <netdev+bounces-275163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A253975FA
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D67E304179F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35203321D4;
	Fri,  3 Apr 2026 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="cNIYchlX"
X-Original-To: netdev@vger.kernel.org
Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB12609EE;
	Fri,  3 Apr 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242241; cv=none; b=RcSbmQcMiDs19Arp5XUV4WoY0zCOkhMWYEvGlpF8UM/+eRl4QFT2wFAiipQgCjA6jtwtNl0b9uYrZ+61xBKdBMjn0rWFUqsSpqteOOIZPpRV7iKx7RdvOwXGwvSVHoT48R+B38CycLqF5C1BOOQ8GwasUFNjinE2rVw3sNxBqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242241; c=relaxed/simple;
	bh=PLkzHh7WX5iP/eYi2YropN4oyZR1H+iSVgCMtWmW6Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXxduV8V9uJ1mlPGRIHNrC61PPi2U+/XnXhbtpotJdOU2JPwfcgUyEI6ReN2gh4079VvDE/LZrVRJHKkiNRCDwpMDxX52HLU0BUvg4WB7FnQlthpkG8L352d4FW+dqgyoUk37TCxDfN5BSKQ8O8jegdA8qup3A+eKtxLts8RtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=cNIYchlX; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from [IPV6:2003:ed:4710:15a0:647d:69d5:7259:bfac] (p200300ed471015a0647d69d57259bfac.dip0.t-ipconnect.de [IPv6:2003:ed:4710:15a0:647d:69d5:7259:bfac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id 4FC46401AF;
	Fri,  3 Apr 2026 20:49:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1775242161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ON37NApWxsC8V/sj7ioD2/bDEAduSr51+G/8BZcbqGg=;
	b=cNIYchlXaMftO7KnShbSr0sIfp5IHGfDIGc3SbJ5bvNiYsBBCymtjgH6FnYXOjOjYkPjVF
	fcFYl9883GJgFSsnqwURZVwtE0eHQmGHZ9uqqPSbGynXvksFgZ3OVN1lfWTcGzBdVTJEyk
	Ze/h+oPlMouRyTRYcNkGW7TWSaBZ8i3Au8KQ9hCA8EifjcvqvH6GQiomwywt8JB6641Cxt
	HQcQ3c6JZJBy8iMutV4SXsOQ2Q4lZOhl8m0lzGpx7bmPGcw9nu4+9zeH8lpeGzWTWLXpKq
	it2XXVm2nRDXszlJUZuCKR3J6GIyIkMjDWRXRUkvIsBRKJBjhKdYDnGby4X+aA==
Message-ID: <1b1202e0-64d3-440b-a303-d10b8ee111f6@3e8.eu>
Date: Fri, 3 Apr 2026 20:49:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: realtek: support MDI swapping for
 RTL8226-CG
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Markus Stockhausen <markus.stockhausen@gmx.de>,
 Damien Dejean <dam.dejean@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260327202001.413280-1-jan@3e8.eu>
 <acvOOnuc709EhdSo@shell.armlinux.org.uk>
From: Jan Hoffmann <jan@3e8.eu>
Autocrypt: addr=jan@3e8.eu; keydata=
 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
 AqNjQxfojjo=
In-Reply-To: <acvOOnuc709EhdSo@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,gmx.de,vger.kernel.org];
	DKIM_TRACE(0.00)[3e8.eu:?];
	TAGGED_FROM(0.00)[bounces-275163-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.041];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_DNSFAIL(0.00)[3e8.eu : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@3e8.eu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[3e8.eu:s=mail20211217];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C0A253975FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell,

On 2026-03-31 at 15:38, Russell King (Oracle) wrote:
> On Fri, Mar 27, 2026 at 08:32:28PM +0100, Jan Hoffmann wrote:
>> +static int rtl8226_config_init(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	ret = rtl8226_config_mdi_order(phydev);
>> +	if (ret)
>> +		return ret;
> 
> As I've been pointing out in other patches, putting this "defaulting"
> here is not a good idea - this path gets called when the PHY is attached
> to the netdev and also when the PHY is being resumed - which will wipe
> out the user's configuration just because their system suspended.
> 
> I don't think that gives the user a good experience.

In this case, there is no user configuration which could be overwritten. 
Whether MDI swapping needs to be enabled depends only on the board 
layout (the feature exists to avoid PCB traces having to cross).

But there is indeed no need to configure it on every resume, just once 
should be enough. Do I understand correctly that .probe would be the 
right place to do this then?

Thanks,
Jan

