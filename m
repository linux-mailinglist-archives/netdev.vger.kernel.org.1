Return-Path: <netdev+bounces-298545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5kKWDUjOK2qWFQQAu9opvQ
	(envelope-from <netdev+bounces-298545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EBD678286
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:15:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SmiUEHj0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298545-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298545-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49A0931DD2D9
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F3397329;
	Fri, 12 Jun 2026 09:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E533A48E6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:12:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255549; cv=none; b=R9pa0shHuxK02+hSilhVRDJFj8m/xVzXZcYsZs4Mo1ab0t9Cm8vBzD9+F3ITdDLUL2z4qxK8F+BznBeEgfrYAI5a49Asn0PLCWjbgpAVpdRqhE/QSqIqA3CzN4REzeeYFqN9WwJy+zJQ96GeDamELzoW23FTpKgd+SZW81/fNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255549; c=relaxed/simple;
	bh=x5ia02jF9wro4doFYC/Fr/A/5g2E7+lNxIqkYp+p8HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8pcQERXChp0EHWIzELZpV6UL2H+lZcS6LwlLSpuFVjMHUgS0Zg62IpFgFyR0S6UxMDPS3BF41vi7J05kwX52HqfHEF88OEbfk2TH+YwXLqFWkDw9ZvpGTT5w/HuW1ROCR+AflelhB4Gcsus8KYQl1SXEIhGXANPbw0GimHf2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmiUEHj0; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so618055e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781255545; x=1781860345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+DHFIH38268jkRIK86uH8Qu+qNuajmDb/465Zp5CG4=;
        b=SmiUEHj0gA9SNcpo6TvpQelE1GSagbI+F+Toy13EC+13u9BKBQnmvBEnrdSG9xd2om
         mEvrcespleW+H060NNcdi4gqkHKK5PRpMJOiuI0IrMYw6Y92Y0FzVv445yk+hPK0NZnb
         Nh9pBzbtQ0KvhIMQTsh2d2m6VuJwXgb+WFoSp76jw5bhtci+lnl36wB3nzxc+Rc9maT3
         k9qcQDTGZgD9jmHWEPA9qYXNCsRxYLBpcMH2HmiS7+XRU8IzK7qsQwU0u14z1Yy6mHIp
         IwqcFkHSZKNLyMy24jNUf6OXSeD58T6oyyCSAmWCqRc5tTFpqWG7meSiLPrszPHLnnNz
         MRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255545; x=1781860345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+DHFIH38268jkRIK86uH8Qu+qNuajmDb/465Zp5CG4=;
        b=NfdM4jh+C/6Wy9XhDDcaMRyeiTChhnoelcHuupUK+Ha9HFitFI8l2bIo4MZ/4kYmr1
         qoTh738OLR7lObHNEr9N1c3P80ATNtfpz/C/YbY+e9stV8GTHr4LuWkhdFMsudGUvk7W
         Cb4D7gEahI9cqlJt2x6mJ33DcILSfVtArdbcN8vf+GgkbXcRNJ4NMkZLr6cdwamwAwxo
         C5jQ6vtl7rp1ZIPE9hHc30zdxfym4a/tJp1OF/dZTMGrPdJX5Dbc8fKYmcOmXcRHx97i
         9vkS++atWFdEVpEWkVI2uZmhSKy5Ap/zYVcHYnXSKMftp45rFzMej/+eZzyFsxFlQLc4
         81iA==
X-Gm-Message-State: AOJu0YxUu8PgkA91MVgU6x7SU4W7dn80kiugDYvJso8mh5WLCoj6d5UH
	9+h47vR3v664plZZjdNF8fCzOWNZ5G2GHgEl3BFebHQ0tEJVtPZmjqPw
X-Gm-Gg: Acq92OF1F52Acqen/xnMApvBs1DpHh3h4SHXarts/8tSocRZzdUWSqS0yIZlH4tuds7
	IC6AhMIiWz7/WjfqvBME0hUqLT+Ylkxv+sucd/gR4Mw+mV1RP/2/N9McFkRKCK8O/V+GEzdFSeU
	DpE+6sC1rMyrD3zosKDLZgfBu7cmgizLzshNA6Vb3mXM3sHZCRkEhtRR3S8XhrvGz5egP0E3dSU
	MPIzWY5agFm2e1XKTSzUWxqNI5wLW0m1c/bLJOcUkOqD5+MqtTywql9OLg+gYSC6wkfoByOHvhM
	kVUCu/DAQ2QOWly64CGqw2/GoEZiiKBLhFRpOLg863VhPpYkytbrWQoIESZYN0edb0e1mIFeXGF
	HNwboxGORO5NzyuRUzMrEelfpEzyte3KTfHpYxhhhsEHFs/WgBNXE5eQAYpLfVrZEuZaZfGQtgv
	09fr1wR84Ui9paQbLbJT9eF4t1YyeE8IQ8jpJxpLTULI+4G5JIq+DEntU2Oyf6dL7EURh00reRU
	Jr2P7c9iw==
X-Received: by 2002:a05:600c:8486:b0:490:a298:acf7 with SMTP id 5b1f17b1804b1-490ec4ee700mr27363565e9.17.1781255544907;
        Fri, 12 Jun 2026 02:12:24 -0700 (PDT)
Received: from [10.1.0.164] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d0fb23sm131583745e9.15.2026.06.12.02.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 02:12:24 -0700 (PDT)
Message-ID: <7bce6163-675e-4c80-8d08-1f7a63c8f65e@gmail.com>
Date: Fri, 12 Jun 2026 11:12:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
To: Marek Vasut <marex@nabladev.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicolai Buchwitz <nb@tipi-net.de>, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
 <8d9fc953-0c59-4811-8273-016ba98089a3@nabladev.com>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <8d9fc953-0c59-4811-8273-016ba98089a3@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marex@nabladev.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:marex@denx.de,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[nabladev.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,microchip.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1EBD678286

On 6/12/26 03:05, Marek Vasut wrote:
> On 6/9/26 6:19 PM, Fidelio Lawson wrote:
> 
> Hello Fidelio,
> 
>> This patch implements the KSZ87xx short cable erratum
>> described in Microchip document DS80000687C for KSZ87xx switches
>> and the following support article:
>>
>> Link: https://support.microchip.com/s/article/Solution-for-Using- 
>> CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family
> 
> Have you also submitted the ethtool integration already ?
> Is there a link to a patch for ethtool to operate these PHY tunables ?
> 
> Thank you for your help !
> 
Hello Marek,

Here's my submission for the ethtool integration: 
https://patch.msgid.link/20260612-add-ksz87xx-tunables-support-v1-1-0e97a91b78c8@exotec.com

Thank You !

Best

