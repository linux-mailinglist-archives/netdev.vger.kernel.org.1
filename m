Return-Path: <netdev+bounces-53831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48C804C8C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D74B20B75
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F33C067;
	Tue,  5 Dec 2023 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiBfDOfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518F39C;
	Tue,  5 Dec 2023 00:36:11 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so24822865e9.0;
        Tue, 05 Dec 2023 00:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765370; x=1702370170; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Aw3bIBLD9I3okY+FLIk3qcmw2Q86Yjtp0TosIQ3nxc=;
        b=YiBfDOfk6eXA4TCcJapBrWa/6S1aFvaczpehWjjcWhueCWCYPtJ+9E+nZM+eks8Jrw
         AqTrqBVgddQ6MQA8m+SqJAdb1ZUzatg+Eweqkiks/pma5NIAMp74CWVsnyvZGYV4Ws91
         NlsV2P34livgTEug4dlIYyKhZBdxtnnyWCi52a+3fZoP9NJtjBpoqPgRBAgddfn/r2Dd
         Fuf/E6H9dbeWEHAB0iypuuvLLqnV3rec0q33+0hvkpGkxs7E2b5uN5WwARjZ9kibmHiL
         PwlWz6+syxzTB9yfFZKjsHK+lqhT4ks9vRGvNgrUhAWoSOqMpovePPmBSEBWBNfVpP6X
         03+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765370; x=1702370170;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Aw3bIBLD9I3okY+FLIk3qcmw2Q86Yjtp0TosIQ3nxc=;
        b=ZaZ8UraX2EYIRXBEQV2X8+2vsJcdHoNugsppvf2K8ANs7jOztD6y8H5LdHKvgz25GR
         U7xUusIfe1ojOOL0ofW3hxXMYovzy7f/qLBuWVeHbV4+iW7hkB46+F6r8GSl95c8mOAN
         FcJrDCjxJEAmkAw3eeAqscDQUz9CecDmtMVj9mpG28H6AIifMJxrK+8pC/vTqojsEiDp
         vSL6ZzNeojsdDF4QGUIMDuLzvARXjYxeTV/hx7YZ0Vbx4gmYfDyLkr9cHPKYhgJiBbRC
         ir6GKlJc7avmxuJNZyzuBYakdGRRDwuvUo/nt1uQtTdsn0V+PvYOKDkcQufrJm1yLSGI
         V/qw==
X-Gm-Message-State: AOJu0Yyp+i8q05Cbx3L63F7HcbeuguRPYOemF/M2RaGpx1KOdsKDmUCQ
	b05CGeoY7IxnshZCiiEKoYM=
X-Google-Smtp-Source: AGHT+IHA4ZhRcANCZDUbwlmwBRjksD6TxpQ/dpSl1pEnljWePSXPlPmHuMNWKms66b3kHWxKZikY3A==
X-Received: by 2002:a1c:720f:0:b0:40c:902:d1d3 with SMTP id n15-20020a1c720f000000b0040c0902d1d3mr159698wmc.222.1701765369429;
        Tue, 05 Dec 2023 00:36:09 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d9c9:f651:32f4:3bc])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040b349c91acsm21413126wmq.16.2023.12.05.00.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:36:08 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 6/6] doc/netlink/specs: Add a spec for tc
In-Reply-To: <20231204103247.6476f4b4@kernel.org> (Jakub Kicinski's message of
	"Mon, 4 Dec 2023 10:32:47 -0800")
Date: Mon, 04 Dec 2023 22:38:23 +0000
Message-ID: <m2wmtt4mqo.fsf@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-7-donald.hunter@gmail.com>
	<20231201181325.4a12e03b@kernel.org> <m2zfyq53wz.fsf@gmail.com>
	<20231204103247.6476f4b4@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 04 Dec 2023 16:27:24 +0000 Donald Hunter wrote:
>> > Ugh. Meaning the selector is at a "previous" level of nesting?
>>
>> That's right. I wonder if we should use a relative syntax like "../kind"
>> for the selector. Will either need to pass the known attrs to nest
>> parsing, or pass a resolver instead?
>
> ../kind is my first thought, too.
>
> But on reflection I reckon it may make the codegen and Python parser
> quite a bit more complex. :S

That was my main concern with it too.

Another thought I had was to explicitly mark attrs that get used as
selector keys, but I don't think that actually buys us anything.

> Passing in known selector attrs to nests sounds good. Assuming we never
> have to do something like: "../other-nest/attr".
> Or perhaps in that case we can support passing in nested attrs, just
> not backtracking? Backtracking is the hard part, really. Yeah, that
> sounds simplest, at least at the "thought exercise level" :)
>
> What would "resolver" look like?

I was thinking a resolver would be a class with a single lookup method
that internally holds attributes from the current scope and has a parent
it can delegate to. It would try to resolve e.g. "kind" in current scope
then, on failure, delegate to its parent. When recursing to decode a
submsg, create a new resolver with the current one as its parent.

If we did it this way, there'd be no need for "../kind".

> BTW how do we deal with ordering. Do we require that selector attr
> must be present in the message before the submsg? I think in practice
> is should always be the case, but we should document that.

The selector attr is de-facto present in the message before it is
needed, both at the same level and for sub messages. So, yeah, I think
we require this and agreed we should document it. I will do that in
the next revision.

From what I have seen so far, selector attrs are at same level or at
root level, but I'm not confident that will hold true for all of the raw
families.

