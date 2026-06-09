Return-Path: <netdev+bounces-297153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id toqMJX5CKGrZBAMAu9opvQ
	(envelope-from <netdev+bounces-297153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:42:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 197BE662863
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:42:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XyAp5jSs;
	dkim=pass header.d=redhat.com header.s=google header.b=snR0Stvk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297153-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297153-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83899318EC26
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DB137D13A;
	Tue,  9 Jun 2026 16:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD737BE95
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:11:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021502; cv=none; b=quEWfgN2i4l5A/8cHqL8XM/LwKDLN/P7lVEcXp5H7NL1pwSZGGdGhFkrDlEwycaR05rLWW62KFNg5f83D2q5qtYyEiGVZLit1vwaN9iVrDnefpnao87zbrA9dWjV6eLooH6VkWkVJZh9OFyvBHaSB2Cl9NLnA96YfG7sX/P/z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021502; c=relaxed/simple;
	bh=SAwVSIpbBVSSm/QOrxOQeLPJSaQMMq+APGawOi2mwz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0E/WJxT0RtRGngHZawTz3KseynEbyvvF8VUyRsKMCUYuWEV1swvVsDqoBelTHbvYxhLpbPdnEBB7LGH66CArGMchq2VC4/PYvMh936+pXOIj4FZRnFUdxsgCaAsSCC5R6TAu1N631wuXkpnPNaXOtXvt2mJnWGDJd/4y01lm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyAp5jSs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=snR0Stvk; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781021500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUi2jL88nb99lUkzNQdrBv5hE8psb1dm+z91nfr54A0=;
	b=XyAp5jSsUTiK27BV1wmfrcWyetFeaTQCBQLtBDC1C5tyGqFys+KxazZOV08dpVf3Fl3Fc9
	zzLR6urvXFZKhwxb0xl8SDes46eWujPw0tFqGBjvuUKM6Gs4YpWoexwJrlayNBKL3XrGVw
	vKyMJKxViV/aG398U8TT1Nd0oYo7kIw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-e-dlrAIjNT-vDV3KnNzWfA-1; Tue, 09 Jun 2026 12:11:35 -0400
X-MC-Unique: e-dlrAIjNT-vDV3KnNzWfA-1
X-Mimecast-MFC-AGG-ID: e-dlrAIjNT-vDV3KnNzWfA_1781021494
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso57899225e9.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781021494; x=1781626294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUi2jL88nb99lUkzNQdrBv5hE8psb1dm+z91nfr54A0=;
        b=snR0StvkBf9vI3vfMMe/NhUTl11QWCcbn5pB8YxUfArcwtuRP6kg39uyA/xiSy3wv9
         9V5bOxePQ1sUDVZox6siw3oN+J3kL4blxCfY7OT98xkYM5virOYN0WSlSz60A8xZJ0pq
         DYzH170AyunFCriXVvfVSWU6cQtOcUtHBeR24eV3hpownOXXb4ZsZlx7PM7yKTrkc/pA
         hizqc+xOaz7uAhwRNmAuo+sySg4qEGIjw32Z1aU/d7dUORN7bDfqWUJWgF4NRz0UG2kF
         zR4hmJXaVl1nQN9vUPOlZ0oAjWgzyMGUf7vcgpqMl8wAAszC18Er19fDj0p8R3/lb0su
         JLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021494; x=1781626294;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUi2jL88nb99lUkzNQdrBv5hE8psb1dm+z91nfr54A0=;
        b=o/2WyEKM773QY2F6X+D50puO7c6k4Vqxl5hfclCs9FtwCAKG3lBPPbyp28EJNiDQxj
         xOHd2lKg/07t7+64EwO6DI30c4Lejg4xidLRfIOJp5xal80B4cr0fZwNiP2/dy8L9+rP
         K33k4MwJbpoHUwKhGj6hdBuwcTqG+5d+ogbHHRjcwSBoBcs8GMiTaZi2nJMZieIQMeMp
         HxCVNk/3+v91o8UmNNlV7g1+x4UA/ZUBg4n9LmQdFWae9n48x/z7HO37oq9FZC7O4RuB
         +8SkbuuYAGWpavF2wYayZHsWpNzKYwua0W33Uuj+xlHIjExeQfm7yLGJrgHCzwW1Qt6P
         jDjg==
X-Forwarded-Encrypted: i=1; AFNElJ+dw+m+PX/cw6X/8xxZKRWUJOdahKr4VdrURc9gGBsILOuNZrnkbqX87zuXFNAzJZWR1beYKpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSb2ZgiZYmXzFVzmu3rD6xMeB8zUAY9pG2WBmBDY8UZZJ7ue9
	1tNjiDJ2NLUeibLe8AzWyXBBAW/PY6IYLH6yEZWKd5bS77pyfR+zJL221T3c1r5eizQGhwBFkMS
	hayGq5ouqkZ/sRzsOy8GBIpOmh/j9m+p3iGed+Wseu3tm0wIzju5tuM5q5A==
X-Gm-Gg: Acq92OEFAxanXklfWLJt9fW/FopTH3kEuDBHAnqyjOnR2BvONl+KtARoKRYgvE6HpcI
	ZcBd37ArxrzJfSZFN7nEwkMjgNlYTBgYZS6lsGUoZ9Eaxu/y3dAEprin6FvFXcsK4OrLEjP6xfw
	LleZOvgMc9uc1/yvPcTRotN/08LLwVjXqYOZ8T/bDf0flI0a92t48JrhuwQqA6ussUj6G0aS709
	3z1PuKFU3WSOYCj6BqUoFT65iSBH+57VDgijNEmZwxuevprBmc4w4MBd3MJm9aY7hHHNbas82dT
	ErczcQqp7i65lKsrDWXyPkOrMKWCUUcCVm3tBhCLXBwQRcu+n5hZiuyTWq0Foa5HwbNShH6+9PY
	sTkxw3YQdfJIriG9FXYuCeODgEQFMI3Vo8lBG6SaycoAXP22+POx2yW2nylwGNOwKPQ==
X-Received: by 2002:a05:600c:529b:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490c2528b6amr350246025e9.0.1781021494208;
        Tue, 09 Jun 2026 09:11:34 -0700 (PDT)
X-Received: by 2002:a05:600c:529b:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490c2528b6amr350245255e9.0.1781021493734;
        Tue, 09 Jun 2026 09:11:33 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc40716bsm524282715e9.12.2026.06.09.09.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:11:33 -0700 (PDT)
Message-ID: <a4091402-e7c0-415e-a2a4-67d2b509462f@redhat.com>
Date: Tue, 9 Jun 2026 18:11:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] Consolidate FCrypt and PCBC code into
 net/rxrpc/
To: David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marc Dionne <marc.c.dionne@gmail.com>, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Eric Biggers <ebiggers@kernel.org>
References: <20260608173921.GA434331@google.com>
 <20260522050740.84561-1-ebiggers@kernel.org>
 <CAB9dFduBir-41_Ef4noEJPHsFU-++JHDxMU-6S7B8pBYynvadA@mail.gmail.com>
 <20260603050557.GB18149@sol> <764077.1780985938@warthog.procyon.org.uk>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <764077.1780985938@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-297153-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:herbert@gondor.apana.org.au,m:marc.c.dionne@gmail.com,m:netdev@vger.kernel.org,m:linux-afs@lists.infradead.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:ebiggers@kernel.org,m:marccdionne@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,davemloft.net,google.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 197BE662863

Hi,

On 6/9/26 8:18 AM, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
>>> If there's no more feedback, could this be applied to net-next?
>>
>> Any update on this?
> 
> It's fine by me, but I'm not sure what I need to do with it - shouldn't it
> already be in the netdev queue, or do I need to post it?

This slipped under my radar, sorry. I just revived it in PW. Also, I
think we need an explicit ack from Herbert.

Link to ML post:

https://lore.kernel.org/all/20260522050740.84561-1-ebiggers@kernel.org/

Thanks,

Paolo



