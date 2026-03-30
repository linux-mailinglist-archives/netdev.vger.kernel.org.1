Return-Path: <netdev+bounces-273288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBAKJ969ymkb/wUAu9opvQ
	(envelope-from <netdev+bounces-273288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:15:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC435F9E3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0F95300BC45
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353773DEAC4;
	Mon, 30 Mar 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7qt/M4r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A6385512
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894508; cv=none; b=i3uyFnDg/Rq/r01PMfH1T47bOvPpgzdi3qalFyY7FwGtQwxvZNUv/tMVw8vOt1u1GlvD3rwm2baXrerd2UD5JjWQapspFsb2S/4t7KrLm/JRqmaqI11lM249Vg9OmX75sc43D9ITbb31APhUZ40Q41kUm8j0H17qjJO50KfYPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894508; c=relaxed/simple;
	bh=Z0VU27kp+EiqqnBSSicMghyKj31cSkFU4hmQ8/ef5W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfiLFZrp6pEp8K47WwYc8M/47aPv8+D4JD603riPIE5+VJtqgvDD58h1p7CLKbaEsRdnP7oIP5/3LGiZZSZUFIYsFF6RmbjcPgt73XspqMscZ2ybRqW0W+ec+6VhmHYG4VfNBDwqs5Yuvq8JiBu9rYN1k5RGDc6Tf9lqEL4b8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7qt/M4r; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732165d1eso6655728c88.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894506; x=1775499306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOJfBRB99YZhtUsegm8iktYsZnnKxVREnxVNFeF5TrQ=;
        b=Y7qt/M4rhOyUADD4ca8igdqqaX5eqlDrK841/s3hkc619bm3HSDz6wpXJO0Du5qqPt
         md9kT2K9Q/QYcE5cr+Q0UgWpDUjcTsVboV4BxTYWdWdUksqTb2GknZ96h6347BAf1jVX
         /U5C3zsnQvRq5OBJxK2CrBTMKxv3JDD7SdvKUiAtaFUFBpC3zrKZLYnxg0NfWDs5T92o
         MdTBdG5Lx06hjG4/QSEHkFx2ezmNi4LD1aHc/4kMb0r0t8qV0HQ+FX+/QXTVgUgcONJv
         NYJlSeFEeqcbuUZNWPxCoFGUpcpP2VhnxGHd1sUmUIb3W/XnUPf3f12B9rnNVxFMwhm9
         8vRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894506; x=1775499306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOJfBRB99YZhtUsegm8iktYsZnnKxVREnxVNFeF5TrQ=;
        b=B4TFf4oG470rndCM0MkpJQky51//obSr017Of85ak0c3wzL2TBw02/k2/uYV8MWlUp
         IgOQtz3dVbupN3hJJ7EryK8yvdZ9ptsSjxi6JxfAYBv1EMGRgr+ztKva19ZmfEe00v8H
         b1KfCb3eTyrsLJNVbxGJ8UW/nzgIKAwltPmjOrFyPJGZ+stYnfNsSyGMDZBU7rE4FGaw
         l04z0AaSxN/baW49haIOpiJxTT3fwhrIYYh6O+ccaSkmgPn7F8vYmSOXBglknGoG2Ux6
         ER5JWnuHiUKXHBhL8oiy0mkkjDDbEiTEMNQTbxOaJxyHFu1HoAl00gYPqjjdc3vedzWQ
         39PQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2WKQ3bhWEW2/LjX2/B62/WGPLN5mkeJFzOKsVhNYZQ3bJR7u5+e9zn/SD5g654St+kRPPRkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWbCMxV+fvFcL9AvL/sFgAqYQgMfRAkpwDqeBigOKRODrIbX8
	ZUvXUOw0Fp4V+1eSukqUceyaKWlFucDu39N24eh7H+x74K5DKXNqxexo
X-Gm-Gg: ATEYQzxSGZMciIvQDALpFiARse400ayi6ByTXm9ag5YyoDLq8vSNeoVv1hdMjWVTka0
	5fLaWr3/COCmbxjo2z5p7NARX/kJN2l6pN89/pNeDyfZEXtQLdgxmkv9itzy2IORA85UqKquiTA
	gC1e36JKZb81gPPbN/iIKGr2CeFFkCIhqn4JJZqBf+47zRO4VpuPJyVigVqRhf+uwCuSQ5aCWj0
	I/m2icuNfuvZCm+e5Ee1wkXL0mcrypwTqdFWJEzVm1J2wJNVvctNwOkZCZ+9k5BvUIIlsVK1sO1
	wDGqZI7NHyTzCGF0JhBRQt0EaMZvzPYnJcthau3NG4cnqfaM1F9FuYjQwmMAaYmhJ+X4Dug1U26
	jpF6VyMvC9JON41wUEqnhZhb4rV2HuVXwknsdh6fM3YLnUWeAvpzRqDSjYhBEpaNUJiOfPzFA4w
	VEg6sZGmi7m5fSlmxXdiuLnLic0qzMqZhrU3mNMrtC1pkFy30yhftxjE52n4O3A202K0uPWKz11
	4Z9lz5nuSUp
X-Received: by 2002:a05:7022:f102:b0:128:cf75:42a3 with SMTP id a92af1059eb24-12ab28d157dmr7026576c88.21.1774894505880;
        Mon, 30 Mar 2026 11:15:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::1:79e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97d88c0sm12032304c88.5.2026.03.30.11.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 11:15:05 -0700 (PDT)
Message-ID: <aeaa44fc-d7e2-425e-a7f5-703bc8539f82@gmail.com>
Date: Mon, 30 Mar 2026 11:15:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: bcmgenet: convert RX path to
 page_pool
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Eric Biggers <ebiggers@google.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-2-nb@tipi-net.de>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260319115402.353509-2-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,arndb.de,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98AC435F9E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



>   		if (priv->crc_fwd_en) {
> -			skb_trim(skb, len - ETH_FCS_LEN);
> +			skb_trim(skb, skb->len - ETH_FCS_LEN);
>   			len -= ETH_FCS_LEN;

Looks like 'len' update here is unnecessary since we are overwriting it 
later anyway?

>   		}
>   
> +		/* Set up checksum offload */
> +		if (dev->features & NETIF_F_RXCSUM) {
> +			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
> +			if (rx_csum) {
> +				skb->csum = (__force __wsum)ntohs(rx_csum);
> +				skb->ip_summed = CHECKSUM_COMPLETE;
> +			}
> +		}
> +
> +		len = skb->len;

