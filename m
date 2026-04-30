Return-Path: <netdev+bounces-282682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHvwHyEH82lHwwEAu9opvQ
	(envelope-from <netdev+bounces-282682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:39:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E1249EBD3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1434300E688
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A83E9593;
	Thu, 30 Apr 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2Xt19cg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rTNmR/xC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECD3D1CC1
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534721; cv=none; b=N6ghbrcgBRs/fq4G9TX1tcCcejh61yMWOCp+8wja5SXPzdOV2kdE51iY8Y0iR78Q7wDIT2crtWGjeLPrMOEXqGTjD9iY3gC5GCmHU1+qFYB2UQ6usFfPJU9G4K2LIBUEVvEXiHzQx9YdH0ktf4yVucN3ld76UnE/sFmxoskqjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534721; c=relaxed/simple;
	bh=sk0vIHPf1KGhP/s52BoHh4ZDFHdAvSKew1mZHChtjdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4zzggObyfZ/+2D7zV2x24c0/TP+fehzE/3Nr5mazXZYAPanzp8jpFaLIItA9voSbuJPoah2f9nTFHy9xAdiNjikdWTCgk82atbmOG9JfUCsCFWY4xmDOlcrdbKoB2nq+u1ueI0IatnFBbP+3/6lujz5BoaxWfxAAsdzIgkIfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2Xt19cg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rTNmR/xC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777534714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WDYnnUoiqNbJR98i81Dp10k2P1EVxsRyVeqRvwR0cc=;
	b=A2Xt19cgJ9/neOuDMmbLxG0SHMlPSEKYGZCpRYfOscAoNDqlVD+kdMKWsFXUeR5Ablr2rt
	j6pf2eUHjXVRNu2NgqqVAMQYnPKaGSJ+yKFqm3KlX9P0GBHxl64IPsUrgLqyBdUvNZkt6G
	k9jtHJ2GwC7ZgwSWOLRmt3udUw3KGvY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-tZvewdjrMDGtZflchSYzzA-1; Thu, 30 Apr 2026 03:38:32 -0400
X-MC-Unique: tZvewdjrMDGtZflchSYzzA-1
X-Mimecast-MFC-AGG-ID: tZvewdjrMDGtZflchSYzzA_1777534711
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5adc12ffso3577705e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777534711; x=1778139511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WDYnnUoiqNbJR98i81Dp10k2P1EVxsRyVeqRvwR0cc=;
        b=rTNmR/xCr7c7b9af/Ii2KRTzQXQyFVXk72QwoK9jv58whXtNtOJGBBe+MMQf9kc+xd
         +Em8stDMARaZPHwB0mCsZo6BaSVDzETxxN/wc8e0sEsmGyNKFNMxUg2E7nWIBfE65UIY
         lRVcehFUNEI/N6r3k5qUCsvdIv8xzbJ37olm8nRugtUX0H5Bu+U93BF/BQZkQ6UNJZ2h
         W669xp5oy9Uyk8fLF3hrlrvwINluDzv3fl0wQB67nXMfyB8I8yYVx73S9M3r0o/x69nR
         HI1mJBo/FCR5bCA0qzDII5rnhYve3XCXuj21+mShRdO1XtPIDsUWzo+B48A/Nu9cpnpM
         NIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534711; x=1778139511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WDYnnUoiqNbJR98i81Dp10k2P1EVxsRyVeqRvwR0cc=;
        b=mZ74bMCIOVQlkbb1q30GUmffKqDLTawCEZtIzVMLPiS0YgUdF4ZMvYA5AvDcVtefRC
         p29QGBw6+6sZCK6jm19AwwYQ6ABpaUXTJFknY06/FxkzesJt8yWqYbXJMM97y6J0klfu
         KKe8Ai82flJQpL/xCGJ8qrYA2UMxZOASX34rFRfeVoxYQ9eEagKfJmTa4l/IdHnmhmE+
         Qb/s4fhhsd0GPouXRfqxpzDHuU3cZjAGgUYmk4h2X/HglL4fQq6e0BQnUfjUtALV2OVU
         UWoh9G+4JAcQjRJQilS/uUpGWwYZUsMfKCIM5lPSZQB8YamhUcdNZRw97CtoxsGBJ1hF
         fhCw==
X-Forwarded-Encrypted: i=1; AFNElJ9cbpsm4An/XQufkfizjvUFcuNFPkiHdvxOHM0kGuitg6gRcY2B0cSI1K+I8WowmW9f4fc73Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfIsuW4rLi5bndX/eLwMrOx6RgA7yjulzb4h77HGyVKigVYYT
	Qdwaky/GoPUruy/BnOLITbw1g80afyHK+K5lnDHKGwU72mupk4rBSUDEkoIXHDkHhyzplKetTPZ
	uQIpuxyd2XkfnUlBsFbPgxuOH+LxEeTrktbf04XMvllGZ1252TO1rG1jBFQ==
X-Gm-Gg: AeBDievlBTEEsHoHH4+jPRmBAKTbFAuZKb0SVo2kId2rt0vFHZe+O6tITIX5tvZvJ97
	X9vILJCca+h3BmUrsCvbNdRB2TNvsCEJc9gFTCCmghFwEZSbmc6OUl1Ezwe5U4+JT9f6SlrlQHB
	5Xb3hoYW8FjlkfEClmK9htMYKLLdiME2iNTfI37iV73h47GIGtsY0bFWeYxj7F94AkfZWjUHXo/
	7Ocggv5gdC7JN5ykc9ovQ72kpKcxMxGyLY3aU9UiA65dEylzklrrAxFMfVobKwS9OUVMkPDT7Av
	c6pW5TZbTbh8/lFje2xJv/bKm7v4LZx+CyIrxQ2h1olxkOwF8m0EYsBABU288D+gfM533QShYnX
	sJx1dNnSP1K30hDNeuv2aGAZApQVAtQcQVBYxF05gLGvK5Ksc48G1m6SPkkQbjTY0Gg==
X-Received: by 2002:a05:600d:c:b0:489:fec9:a17e with SMTP id 5b1f17b1804b1-48a844f4fd9mr18983475e9.12.1777534711211;
        Thu, 30 Apr 2026 00:38:31 -0700 (PDT)
X-Received: by 2002:a05:600d:c:b0:489:fec9:a17e with SMTP id 5b1f17b1804b1-48a844f4fd9mr18983195e9.12.1777534710740;
        Thu, 30 Apr 2026 00:38:30 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2f2eb8sm59538525e9.6.2026.04.30.00.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 00:38:30 -0700 (PDT)
Message-ID: <a642b858-eea0-4b7a-aeb2-aa67c6cf0f64@redhat.com>
Date: Thu, 30 Apr 2026 09:38:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] Reimplement TCP-AO using crypto library
To: Dmitry Safonov <0x7f454c46@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Dmitry Safonov <dima@arista.com>
References: <20260427172727.9310-1-ebiggers@kernel.org>
 <CAJwJo6Z9oJSMMBUL_pbYWN6ha3n4MRpKV_aVut8E+af3JUDFkw@mail.gmail.com>
 <20260427155538.2e1b8488@kernel.org>
 <CAJwJo6Zh_1V009JSBGwAmR7GWj=2HdG6f=uBxK8krE4B1YrGkA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAJwJo6Zh_1V009JSBGwAmR7GWj=2HdG6f=uBxK8krE4B1YrGkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 71E1249EBD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 4/28/26 2:00 AM, Dmitry Safonov wrote:
> On Mon, 27 Apr 2026 at 23:55, Jakub Kicinski <kuba@kernel.org> wrote:
>> On Mon, 27 Apr 2026 20:09:05 +0100 Dmitry Safonov wrote:
>>> I do like these numbers quite much! Yet, as I mentioned in version 1,
>>> removing a fallback for other algorithms' support does not sound good
>>> to me. There are two reasons:
>>> - Ronald P. Bonica (the original RFC5925 author), together with Tony
>>> Li do have an active RFC draft to support the additional algorithms
>>> [1], potentially in addition to TCP Extended Options [2]
>>> - There is at least one open-source BGP implementation (BIRD) that
>>> allows using the algorithms that you are removing [3]. Without a
>>> deprecation period and communication with at least known open source
>>> users, it implies intentionally breaking them, which I can't agree
>>> with.
>>>
>>> I don't feel like Naking as we don't have any customers using anything
>>> other than the 3 algorithms above (and BGP implementation is
>>> [unfortunately] closed-source, so that would not feel appropriate even
>>> if we had such customers), yet I do feel like it's worth and
>>> appropriate to express my thoughts/concerns.
>>
>> What do you want to happen? You are the maintainer of this code,
>> you don't get so say "i don't want to nack it but also no" :)
> 
> Yeah, that's not what I meant. I see value in Eric's contribution, and
> I like getting rid of tcp-sigpool. So, anything but "nack" is not "no"
> :-)

I read the above as: "If there isn't any additional feedback soon,
please apply".

>> Like Eric says if there are no real users code can be deleted.
>> Adding deprecation warnings upstream is quite slow, IDK if injecting
>> deprecation warnings to stable has been discussed..
> 
> FWIW, I've written to bird's mailing list inviting them to this
> thread; in case if they need other algorithms to be supported,
> hopefully that should avoid any breakages on their side.
> I'm aware that ciena and fortinet use tcp-ao too, but I'm less
> concerned, as they aren't open source.

Let me add my 2c here:
- the only TCP-AO use-case I'm aware of, is to _drop_ TCP-MD5
- We had some discussion about TCP Extended Options in past netconf, and
IIRC at very best it's not going to happen any time soon kernel wise
because it basically requires disabling GRO.
- the possibility of using crc32 is indeed a security issue, that AFAICS
must be addressed, and can only be fixed removing such option. I'm fine
dropping support for any other algo considered vulnerable.

More than 48H passed since the last email on this thread, I'm going to
apply it.

Thanks,

Paolo


