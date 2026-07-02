Return-Path: <netdev+bounces-304106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gE8vDhRBRmqOMwsAu9opvQ
	(envelope-from <netdev+bounces-304106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:44:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C36F61AC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:44:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=SOQWFAL+;
	dkim=pass header.d=redhat.com header.s=google header.b=lDuLJHXh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304106-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304106-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27DDC302679D
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A38639A061;
	Thu,  2 Jul 2026 10:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5F3A3E60
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:42:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988981; cv=none; b=PR/kcVPJiEwhOyIU7KFlfSG32xyg+0tQDyAUe+BTTPhG85vuqGtIMgcWGpRh6jhnmPZtzA7iXP6Hn8BVutqQKyxu3dwwk4i0tHJKmLOX56ekllNhAj3BdKL6b0ZAdyrnF9CJlVTsWHMAjXv2gxS6wd0itd9Kq0zR1/MkaV2vdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988981; c=relaxed/simple;
	bh=6sQRIq7b9Zu9XKPDiUd+ggNhyc4hQiLpe1Vw/AVrFSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2IYSenkfV8Zu8dp8e2NASq17OjjmNASj7M5Qt/wOMUmADgyTqSBHV7enTHo01SOUWtl/FOnZZ0Aupk4YjqpkxR0NvcD6JMyFHBwyumreRskFnYP7EgGpLl4f9v8gA6aQqpzcK3EpHhCRABlkqkWCkDTL9NmtKS/BRNBr60f4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOQWFAL+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lDuLJHXh; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782988979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqGzQrV1pDX1atAYAe3/sAYqSpXdWp3fwZzPzPU+03Y=;
	b=SOQWFAL+2CVmVE3Vee8SgPxzv/cGnWvcGgktoOswuKrAMX5TzqjHOR8N0RuMMYYiuYiRfq
	neygJfQzeU+aAtTn4T3nJnkn1y1/Zw7ptdWqcqMiFyVQ/tj42QghjzVJv57zIWn5rD3wRr
	wqA0oxaNs3dFmlrSssc54gJa7ZJXX7A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-kHCLttAROx-T_dGoMckYBQ-1; Thu, 02 Jul 2026 06:42:58 -0400
X-MC-Unique: kHCLttAROx-T_dGoMckYBQ-1
X-Mimecast-MFC-AGG-ID: kHCLttAROx-T_dGoMckYBQ_1782988977
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46fd6d94a8dso820999f8f.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782988977; x=1783593777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqGzQrV1pDX1atAYAe3/sAYqSpXdWp3fwZzPzPU+03Y=;
        b=lDuLJHXhKRVycDXq/Bfbc8ZcHeKJ4QO+H5qyx9wV7UAWQndtayWL7sDvDnrFMtWCfO
         oAq1Fv2LijwjBCPihkPL48+V+RVx5xKaG1nJVplRfXV+Z3Z0MycJChwHy7Jvg6AWx9dM
         7F2ap4rdWo+24wcU8dNO8Xr6mRrbLJ7Fwg1q5mqw/jz38YSEsEYZDiqstFzI4oZu4587
         6PfIr5vjJ0Zli2C/7unxLVagzpAAciJub4UQIorngRR/iQk8i7/2Jpc/+KgpBxXf3QE7
         ddDUMFiF39l2t1869YTFT/+YrHuAUYpfFoeKjdM2ateqHzGZQyle4AvFcIY0ZPrWhoux
         0dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988977; x=1783593777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqGzQrV1pDX1atAYAe3/sAYqSpXdWp3fwZzPzPU+03Y=;
        b=lCt5AhpJHbWGBEHFq41tuwwAEOIz+EDzcYsSCRmIrLNqo4Yn/d7y90YORZE3IHSQKp
         X0x7sEpYU60AyO8PT+olyJ8Chx6rw0jR6NRuuyleox53bJ9vMhj20ZMdKWfoGnWhLwlV
         cwvVcZUN7SRDlQz9q4x2dv9J9eIHlv+A9hC6EWDXqqz/x7pi2Y4Q5h44ppELUgDx9lLv
         FX/7JeeZB/o0jPXe4HML8/y153n6sK9loTht3+hsON6oU3CCXBIpn8fKuWfcubCIqirc
         wcxbKiaZdm0vMSA79ukwIOT1mCaNjGKGvXMLNka/3clGZvoCcXn2R581cTtHH54/aG37
         3C5g==
X-Forwarded-Encrypted: i=1; AHgh+RqoeaP433HYZsF3C1pxWlKNA7Fwq33VrbV+NOU8yeGmjCO/KUsgzaB/dx1ri2ITdv89RsvYZf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKhj4wOTl6NwjENqtCZ5QiXkIFXLwf7gFvD6PJoNouKfO1NNE
	+/LdTqEcydRyqkf0AVIlJJoCChSXxkY53kGb8W5t9iJv9D/Y8Syb8eI/wNRABStGI9TuKXY0WG0
	AdWJv66YQcqD5qrzGWUt41GWH+gbY6ZfGMKK7X8dmPH1lqOtE16Lt+JMtlNaNmosFhQ==
X-Gm-Gg: AfdE7cmF/Fkzel9M0QhFSCaZmOBomDgB5cwSG8ymBKHfpMqGaluD1qtipZBrIFwML0R
	StBZ9LK/sM9P365Asfj+vXtyO2vyU0D3iYBtANzhFYOuJYm2Y7y46m2eBFWcCt4EbJx6/5ZAAac
	ha5HFWhNexp6ODYg1I4MirmzDoGEB15VipdO0NHIV1WwjnCDuh6v5PiCJs4dNBsav185aQXIvvU
	xk+QdeGtJHLX/WvSOWVsMELgpNsbJJqCuEbcsU4OxI4P9DDcJuGfS0i7tPGMJjHO9UmlqMcPCFF
	hth05BO+O5hm90PP7hMRx8COPxrYhFasXYQJxoymF18Pz53la5CYNXjC4gDbVcmAjXGYPA2+pCo
	FuvOOr4JLZK+WTyjWH3VVcjLrCtDvIpRn0ehemjYenP1Nn+w1UBsFb+sbgv61Y/dYKeQBLrXHWQ
	Z5nk3kZc1chw==
X-Received: by 2002:a5d:5d08:0:b0:476:135a:1349 with SMTP id ffacd0b85a97d-477571cb873mr8078453f8f.6.1782988976755;
        Thu, 02 Jul 2026 03:42:56 -0700 (PDT)
X-Received: by 2002:a5d:5d08:0:b0:476:135a:1349 with SMTP id ffacd0b85a97d-477571cb873mr8078421f8f.6.1782988976326;
        Thu, 02 Jul 2026 03:42:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94c829sm7517038f8f.24.2026.07.02.03.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:42:55 -0700 (PDT)
Message-ID: <517ee2e3-1bc8-48ad-94c7-5d8e47073d5f@redhat.com>
Date: Thu, 2 Jul 2026 12:42:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] net: emac: use DMA-specific and SMP memory barriers
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260630041634.284127-1-rosenp@gmail.com>
 <20260630041634.284127-4-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260630041634.284127-4-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304106-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E56C36F61AC

On 6/30/26 6:16 AM, Rosen Penev wrote:
> @@ -1845,7 +1845,7 @@ static int emac_poll_rx(void *param, int budget)
>  	}
>  
>  	if (unlikely(budget && test_bit(MAL_COMMAC_RX_STOPPED, &dev->commac.flags))) {
> -		mb();
> +		dma_rmb();
>  		if (!(dev->rx_desc[slot].ctrl & MAL_RX_CTRL_EMPTY)) {
>  			DBG2(dev, "rx restart" NL);
>  			received = 0;

Sashiko geimini thinks the above is not enough for PowerPC:

https://sashiko.dev/#/patchset/20260630041634.284127-1-rosenp%40gmail.com

> diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
> index a3839cf02ec4..5144ee94a7d2 100644
> --- a/drivers/net/ethernet/ibm/emac/zmii.c
> +++ b/drivers/net/ethernet/ibm/emac/zmii.c
> @@ -258,8 +258,8 @@ static int zmii_probe(struct platform_device *ofdev)
>  	/* Disable all inputs by default */
>  	out_be32(&dev->base->fer, 0);
>  
> -	printk(KERN_INFO "ZMII %pOF initialized\n", ofdev->dev.of_node);
> -	wmb();
> +	dev_info(&ofdev->dev, "ZMII initialized\n");

The printk change is unrelated and should go in a different patch.

/P


