Return-Path: <netdev+bounces-227992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8E5BBEC88
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 19:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6A0B4E42C4
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A6C225414;
	Mon,  6 Oct 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cThwXl7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCBE2248A8
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770697; cv=none; b=MMdIHnAn6RXxzZLHMKj+OLYjnvQWLfKeBZxweZAgWxN16K3Arow2n0SB830BUUhCxgJLZ/+9SpOIuSozPf92Rx71aJ4vwxUtivS5zobyvw8R/5WdlSBywSp1UIXHiOH6kmFWCMBLpIPNJqPihWYYGNfCkn6VeAOBddc13+ojTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770697; c=relaxed/simple;
	bh=zKkTa7ZhmrpRX4yKjc3XCfiejGSkZfXEDNwW1ZmtDtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4tq89UcNUvgqd0vfrJJT4sLNVFDDTTo3VpX2dtbhkzVeaKFBqI0K/rkEmJJdVflsisHcINOKJLIWsYD1vCZsf1pg/IwfZM5RMykRiYBNkdl46FqtPcg9VXjYvhBJaSg9ad+/f7sj6CtLXeOizck9KZv9D4erHUZ74KMQXf0FX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cThwXl7H; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so991245266b.3
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759770694; x=1760375494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ON0py5Pr4Nz6NW5O8PJrqmYAOhtAM3BBfWdJdJiOtZI=;
        b=cThwXl7HcInRoi2HKYBoD1TUhc0fPFrnndUrC9sQ9qS6zLiRyiD34xO4ypEfMYIMYH
         UWTq+rH737ldp+0p1+G/+MyU/oGt8WE83C8Xij62q+OKtfsKNTTZiljWlrB0GMeENrBc
         n9/9/+Zgitv2EaE3+uBILs7mkcRcAEA7tq9sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770694; x=1760375494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ON0py5Pr4Nz6NW5O8PJrqmYAOhtAM3BBfWdJdJiOtZI=;
        b=emFaI+nZnpqZKZT+aZIGxSWuSOdUqTpmd+vKFC9ChI9dmQ3SolfxZRiIipHpSZb9Jq
         4L0WBBwgOoxHRkeHYbclhALX/lAqbTzY4Sj1MSX00Jbx46eaaXo7ZHMn2x9PqhX0AgMf
         o2Lx+aS/yOJmu03ihQMKzxnGoo04vlgAocRv7NKXNpXDgsCsokGKHGtqPjV6dYXwXTfs
         fXplIDn3hKfYSX83FOmpIgspt68KTZfIfX9IsRAwBs3pov6m8U+TQHP50KvJsTwhZUyB
         3GTc78Z2m8YSc6XJmF9R7stjCXQvQcMzk43n9xDcLKYAmho2DvRagk5/tMNIRWB5CoU2
         MZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsGSHyrTbUR1kiNvhSRHwe0yOcKg+AqT9N6/7CxlmgTXA9OqR/J6c6ZofiX3xGuINnsxAvNnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfP7CCzB8StCmzU4tjZslsXL5VM6k28aBhZWjK9rhgGLynIE84
	oJJDLn4plO82wCdhloQ8E8Si7wvk5iMDlAIKdDfp+PNmx4L6qtCVzaf9cmsFU76zS8OAnkf+d50
	Q90joyMY=
X-Gm-Gg: ASbGncsh15a0adi6F53EAjJoG8chx3ISNA9zn08dc4aTfmsSoMOdHs0EDd9qOG7UZZw
	ZFBmJJ1dR3MQIaOjOx6GjdZWjwfzVNWHeYJ7aSQHNdGB49aofaxHpvuKaKAAfvZxX3EpLbtsIUM
	hyhfyDYDavqTUV5Ui0vOazVZvTOxIRWvb02E8uJaN0R5lAWS358ikUiDKHZ4KN/P8qjQ1+BSOYM
	sj72NtaEyv4Q3qQBlmJVhr7wqBsS+XDdLSyX+1QI2QB/fhIQVIY3lLUVz2Th2FEYnSZ4ZRA4ds6
	IpXGQNK/iN9Vv4YB+TCZz77uJe7KFAZQ5FqP1jkhiTDnIamNtkREeX8TlohrpK+ashZqfsL1oln
	gJKmvEX1Dbv49DwnJLXeSPiDKu1kiixRY36/6+qjqEy6OJRdg5mPLa4tI2aKzjiVti+8rT1whcS
	hZUopdPinpOMuRKD7spkXR
X-Google-Smtp-Source: AGHT+IEMk0dRnjStsYF6Ar/YGFZ+SUpHMlpaNRO5T8xTmTe6i9EtOaM2lmen1JHOaWXJoekAbkkLKA==
X-Received: by 2002:a17:906:c14f:b0:b30:ed1f:894c with SMTP id a640c23a62f3a-b49c3f77bd6mr1709743766b.43.1759770693783;
        Mon, 06 Oct 2025 10:11:33 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4e5d8sm1171837266b.82.2025.10.06.10.11.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 10:11:32 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6398ff5fbd3so2878861a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 10:11:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaQYR7ImF4NRfqLqMutWdwz6l7hmbNT3CNc3GZVQ2jnFwupEenjE0WhIPXazLtsPB3UNKDviY=@vger.kernel.org
X-Received: by 2002:a05:6402:788:b0:636:7b44:f793 with SMTP id
 4fb4d7f45d1cf-63939c42c3dmr10575986a12.36.1759770691962; Mon, 06 Oct 2025
 10:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIirh_7k4SWzE-bF@gondor.apana.org.au> <05b7ef65-37bb-4391-9ec9-c382d51bae4d@kernel.org>
 <aN5GO1YLO_yXbMNH@gondor.apana.org.au> <562363e8-ea90-4458-9f97-1b1cb433c863@kernel.org>
 <8bb5a196-7d55-4bdb-b890-709f918abad0@kernel.org> <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com> <20251002172310.GC1697@sol>
 <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com> <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
 <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com>
In-Reply-To: <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 10:11:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
X-Gm-Features: AS18NWCXa0wSJ6_VpJSDmpZcgomwitAo1Hggc1PbqkhjmqP5uTQVk83I_Ms3YkQ
Message-ID: <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, "nstange@suse.de" <nstange@suse.de>, 
	"Wang, Jay" <wanjay@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 09:32, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Okay, so I get that we don't like fips=1 around here (I'm not a
> particularly big fan myself), but what's with the snark? fips=1 exists
> in mainline and obviously has users. I'm just trying to make sure it
> remains useful and usable.

It literally caused non-bootable machines because of that allegedly
"remains useful and usable" because it changed something that never
failed to failing. That's how this thread started.

So that's why the snark. I think you are deluding yourself and others
if you call that "useful and usable".

           Linus

