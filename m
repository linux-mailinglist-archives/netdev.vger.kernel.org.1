Return-Path: <netdev+bounces-307352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /vmbCvy4VWr3rwAAu9opvQ
	(envelope-from <netdev+bounces-307352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:20:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B046A750CA4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:20:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gFRniAjb;
	dkim=pass header.d=redhat.com header.s=google header.b=JyvLq3GP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307352-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307352-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 010BA300D1CC
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24C2D0C8F;
	Tue, 14 Jul 2026 04:20:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382EA27FB1F
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 04:20:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002809; cv=none; b=Vxh01D4L4wwnM4HrDI/W1jiXTks1fdbokl1ysWHlgfWrQQjDLhk3tUmYbmMvpGEEmw+DdZX4N6wwq+dakN2yytWDUBZUYxWazSqj+tI0RvGaHLKwMlhxdsI9K2LdpdkBFL2ZKbAhQf8v9rmbmUADDCpON05vrPyDd7kKcaLWQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002809; c=relaxed/simple;
	bh=XM7NEXOYbLEOlVK7b+ErnVKUAU0qhKE/jPtFLL0SHYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar4WKFgEbWg9iE+uKdACfE5oY94PoGvW0AccFwUfdHKBUNeIU5xP+su5Bzssgs2i08AgUcGQINMj2QYCcKjDoICzjVEihLvtoFKnDBA/6oB1dmdKna5791deDS5gvD71m2XZsWC0fk/Mwx94SBOVtgC24I3Q+edzpu6vjv+BSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFRniAjb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyvLq3GP; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784002807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1HupOzpJp3e8c0sikfAglH5/ggvC1reaC6Xy3JGlOtc=;
	b=gFRniAjblkwFMnoAgzKDIEDWv0W8cI27jN2MHYJjWeXXRPs9rW9ytXykRLebaVWGZUmuIv
	56C42kA3UCvUrhBesEjgsYdfwEsuA+1wDNAq7dKUk8eCg+cLZSXUVXrlP+/35XpWgtiQPL
	vxeScp/UtrR9TKoRNNWZJbkI/fXfxac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-gfHU0-X4OwmizztLikDGFg-1; Tue, 14 Jul 2026 00:20:05 -0400
X-MC-Unique: gfHU0-X4OwmizztLikDGFg-1
X-Mimecast-MFC-AGG-ID: gfHU0-X4OwmizztLikDGFg_1784002804
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493b0fe95b6so23435935e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784002804; x=1784607604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1HupOzpJp3e8c0sikfAglH5/ggvC1reaC6Xy3JGlOtc=;
        b=JyvLq3GPtLlHWnEiDBR/z5cZLIdPHYhJWPnhQmiKRexAV20u7ZOxhYlHX2b/O4YUZ4
         NAHx6jP9zMjEqH+GhmLwsJ7qLY51UaZrHSzzBN3wH0xHPimZVXdINWpuuKfCYCs4QMcx
         yhjQ2KBRFX99SIQqiuthrlPZKvzADGmFc6t5bZncssUFInSp4Pee5ISUgRq1DYP21JNU
         RgZ4rltxnJrqdj7EHU9ttHkwzqcTg+VhyoUR7BsT3/S2UOkFycy9RKINJCspuIIOnoZ+
         FjTah1jwXQBFMatBubfb6GAPUJJpg8Xw8rMTzMXUdQ0+9V28h+JDgDZImAdX2MA2StOv
         du7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784002804; x=1784607604;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1HupOzpJp3e8c0sikfAglH5/ggvC1reaC6Xy3JGlOtc=;
        b=D/BxPzNVY0EFKk2tvSJhHTiPEbNPkqjeNRAdC+Z7MULyj/vI84UAshtcAWWG6d6vgl
         5cQ+/6wivmESpUFW0YTGgTEHnfsROsz2yqrI0bAVxeDRnhG40KcrzH7m95bbIFMmQ6Dz
         n11i/hkIJZ0skYXK97Vo7QkBa/rRrgQBu54hS/5jnJxizDnu1C3I/Tx/KkoyUMOO+jRJ
         zu6HnNu6kOQI5LX75W+E5ARiMkD63Ug1A3DZjYzhDiz3WzFNCv7byuQFFxJYKGw0S53A
         vEFHYHVo1ZdhUf+u19+4ne9xyMOTuIIUFVIieOksouZqRlD7YY95m5fVAetRPVR7OJQd
         iSlw==
X-Gm-Message-State: AOJu0YxMZJvqV/3lb8H+JPTmh36gNM3JHymHwz8ANbH8lwANMIynZyBQ
	gtEQ9vpTWF7GRRt1An68D/3+YcQPTsh5F+p7Cmj3ZGkp55ZZEvyLExWKsNM6EznbI6kN05gphg5
	mlBQv8RfvIHBt1OGqOCXnrijdzgiG9rofeQB+Otf32R0XgXYKtVbfqId6cQ==
X-Gm-Gg: AfdE7cnfGBp4uiqCU3f0x5nENYkDh6hRgVjiIyc80JC0js+3sbWNrQig4XliTh9tRoT
	ZbpktJz4n5V+3yKO5O8sj4EfWgLs2UNLERTqrg5/rKuIccAgrXRVzMmsO/zpw9V2KGrlnfneUX8
	5l1fpVAn+2rzC5tPdb4zI9rexsyqo32vDcAzxAgJ2pmoMLYJs4t0Xwx8ImBCC+LBYPYn7njzP0u
	EWUg3pwPrOqOeQV6p0TUW0LgE4CjMAu8HDnlKaaXY2xPFIxWhxfdmVzk4Lz17+Cm1BcBAV2T8K3
	F1RWqtWxCmPKziveRYLsJYge1WhOrbgSKwKoU5SzmdmNgaBeG2s3Hx7E4iBgbPoDwzKgNxtbUk2
	llxrT0T12
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493f883157bmr120878755e9.26.1784002804068;
        Mon, 13 Jul 2026 21:20:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493f883157bmr120878625e9.26.1784002803737;
        Mon, 13 Jul 2026 21:20:03 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871cbd6sm52708055e9.3.2026.07.13.21.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 21:20:03 -0700 (PDT)
Message-ID: <c4796562-699c-4ac2-87ea-290708ff577a@redhat.com>
Date: Tue, 14 Jul 2026 06:20:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: pcrypt - Remove pcrypt
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 linux-s390 <linux-s390@vger.kernel.org>
References: <20260713223234.24812-1-ebiggers@kernel.org>
 <20260713223234.24812-2-ebiggers@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260713223234.24812-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307352-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[thuth@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:steffen.klassert@secunet.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thuth@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,stackexchange.com:url,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B046A750CA4

On 14/07/2026 00.32, Eric Biggers wrote:
> pcrypt was originally intended to improve IPsec performance.  However,
> it's no longer useful for that.  Reports from the rare cases that anyone
> has actually tried to use it over the years indicate that it actually
> reduces IPsec performance, e.g.:
> 
> * https://github.com/libreswan/libreswan/wiki/Internals:-Cryptographic-Acceleration#obsoleted-ipsec-accelerations
> * https://users.strongswan.narkive.com/liqTaTq8/strongswan-problem-with-pcrypt
> * https://unix.stackexchange.com/questions/594336/ipsec-multithreading-via-pcrypt-worse-than-single-thread
> 
> It's also undocumented and quite difficult to actually use.  Its design
> is also broken, in that any unprivileged program can enable pcrypt
> systemwide at any time (by instantiating it using AF_ALG).
> 
> Meanwhile, pcrypt has been a regular source of bugs, including at least
> four that have received CVEs.
> 
> Let's just remove it.  No one seems to care about it anymore other than
> people looking for vulnerabilities.
> 
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   MAINTAINERS                                 |   7 -
>   arch/loongarch/configs/loongson32_defconfig |   1 -
>   arch/loongarch/configs/loongson64_defconfig |   1 -
>   arch/s390/configs/debug_defconfig           |   1 -
>   arch/s390/configs/defconfig                 |   1 -
>   crypto/Kconfig                              |  10 -
>   crypto/Makefile                             |   1 -
>   crypto/pcrypt.c                             | 394 --------------------
>   include/crypto/pcrypt.h                     |  39 --
>   tools/crypto/tcrypt/tcrypt_speed_compare.py |   7 +-
>   10 files changed, 2 insertions(+), 460 deletions(-)
>   delete mode 100644 crypto/pcrypt.c
>   delete mode 100644 include/crypto/pcrypt.h

Thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>


