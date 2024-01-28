Return-Path: <netdev+bounces-66675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E01108403D4
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70541B20E86
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7435BACB;
	Mon, 29 Jan 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVSQ0PYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93145B5D5;
	Mon, 29 Jan 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527788; cv=none; b=OQJwNWlxC3KzkewijQh3MRxLJOnbrzljmJV6+gYpfbfbQZM70ayEtP/y/t6/Mj4dU0OIfYKfluqfvoMW0TievKlTERjE2Pb5u5rBgx6pEptCYqSgsuWfG6qjhrpOyUkbVhMATNnBoWT7B4SvaqmGmpXh74/UIrlfjtsTrcOeORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527788; c=relaxed/simple;
	bh=AP42ouJKWQqOU4d3qKqBkeJ+2fkyya31t08UrB3VEs8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=sZ1yUEP4wgkip8pRXp4BORrh3SDJAWkBbxN79ShXmSNH/tNBJMtg4OTnc6U4XvzxJCGKiDqDgfj5sz5yxPhdOIR3nh06eFpRMDJLIIGrc0rKVQahVbbZHbww20++zbW5NrbSJ5O7uU+TcD031DrEw7siPHkafngyB+KZlsgh6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVSQ0PYd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ef6454277so7462065e9.2;
        Mon, 29 Jan 2024 03:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706527785; x=1707132585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AP42ouJKWQqOU4d3qKqBkeJ+2fkyya31t08UrB3VEs8=;
        b=gVSQ0PYdy3XzBEfVxCenmUS+cwq3KX4jvtB9NH6dc4pqpWdLSXBNnWKLk5eRbAg8tl
         ET/Q+K8BEsPYgeHd/LI85stR3EYE+HLjQ5ai+8UlEGYQMtnnJ6BwjgSfevaO9yWPC+4Z
         Fw4RiXLY7xSgmquYBbYRnCx1alB4QBwbcVUnKfbw5lBaV+qRVRPqv2stKRu9odsV3hVR
         ipZgLS/yyaM3C5q915cia5Jxt4ik4kVgcrhdwTy18ckVmkgG+CFCbWsBKfMgDPT+5LO1
         xebl3V0oVhG5OafoSlehXaWxOkuae6THL07bknuQMNnYDUjwgdtrdJKOfKgVuvZW4hfM
         3mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706527785; x=1707132585;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AP42ouJKWQqOU4d3qKqBkeJ+2fkyya31t08UrB3VEs8=;
        b=nVSCMZ5Zw9RFLCbbk1Wds0h1qWCZnww9S3WbOrrPR2NRXfnfG2nU+WsazLN70CGMht
         4iAcACAuJ7ux6LJhz2devPEiZDiKyU0/r15ctI/K5psny9Xb/8hUSKt4KAK1oA0qcPRl
         9R786kvCe37wC9J1mzMe5T1a9Cyz+l90+n4M8fL9RG+hCiqvop9TK8F0hhp7i4ZcIVlT
         Uqpf455J++oW62wCX9igr3qLtrWFdzPVA+/q0rvK1vzrJ72/CmfC9E6H03F/HRW2Og+9
         mpbhMLCov7Eg86dejSHx5O3s34b0d347h0trPCQk0YujINH6CYuQkLVAhbYCDjy4bKWE
         Uzeg==
X-Gm-Message-State: AOJu0YyV5EP0VYsfH4kj0yNKXWHB9ptSO+ToEhiR2qVXeuep3mpJMuGa
	ajT9H5vtyvDh+2WPY42n7sImuAEArG8wlacQ3TdIfdlhGmAaAnET
X-Google-Smtp-Source: AGHT+IEakUV8KKyakttgRCGQdrlI4VjW/CE96elnVQ8kGcaWG8wVZc4p/UEIsNBuK49S9QCNhfJsUg==
X-Received: by 2002:a05:600c:4282:b0:40e:bf77:8152 with SMTP id v2-20020a05600c428200b0040ebf778152mr4473382wmc.5.1706527784615;
        Mon, 29 Jan 2024 03:29:44 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:cc46:8505:d45b:c5be])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0040e4733aecbsm9760798wmq.15.2024.01.29.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:29:44 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Jonathan Corbet <corbet@lwn.net>,
  linux-doc@vger.kernel.org,  Jacob Keller <jacob.e.keller@intel.com>,
  Breno Leitao <leitao@debian.org>,  Jiri Pirko <jiri@resnulli.us>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
In-Reply-To: <fcf9630e-26fd-4474-a791-68c548a425b6@gmail.com> (Alessandro
	Marcolini's message of "Sat, 27 Jan 2024 19:52:20 +0100")
Date: Sun, 28 Jan 2024 19:36:29 +0000
Message-ID: <m2bk95w8qq.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org> <m2ede7xeas.fsf@gmail.com>
	<20240124073228.0e939e5c@kernel.org> <m2ttn0w9fa.fsf@gmail.com>
	<20240126105055.2200dc36@kernel.org> <m2jznuwv7g.fsf@gmail.com>
	<fcf9630e-26fd-4474-a791-68c548a425b6@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> On 1/27/24 18:18, Donald Hunter wrote:
>> Okay, so I think the behaviour we need is to either search current scope
>> or search the outermost scope. My suggestion would be to replace the
>> ChainMap approach with just choosing between current and outermost
>> scope. The unusual case is needing to search the outermost scope so
>> using a prefix e.g. '/' for that would work.
>>
>> We can have 'selector: kind' continue to refer to current scope and then
>> have 'selector: /kind' refer to the outermost scope.
>>
>> If we run into a case that requires something other than current or
>> outermost then we could add e.g. '../kind' so that the scope to search
>> is always explicitly identified.
>
> Wouldn't add different chars in front of the selctor value be confusing?
>
> IMHO the solution of using a ChainMap with levels could be an easier solu=
tion. We could just
> modify the __getitem__() method to output both the value and the level, a=
nd the get() method to
> add the chance to specify a level (in our case the level found in the spe=
c) and error out if the
> specified level doesn't match with the found one. Something like this:

If we take the approach of resolving the level from the spec then I
wouldn't use ChainMap. Per the Python docs [1]: "A ChainMap class is
provided for quickly linking a number of mappings so they can be treated
as a single unit."

I think we could instead pass a list of mappings from current to
outermost and then just reference the correct level that was resolved
from the spec.

> from collections import ChainMap
>
> class LevelChainMap(ChainMap):
> =C2=A0=C2=A0=C2=A0 def __getitem__(self, key):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for mapping in self.maps:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return mapping[key], self.maps[::-1].index(mapping)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except=
 KeyError:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pass
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.__missing__(key)
>
> =C2=A0=C2=A0=C2=A0 def get(self, key, default=3DNone, level=3DNone):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, lvl =3D self[key] if key =
in self else (default, None)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if level:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if lvl=
 !=3D level:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 raise Exception("Level mismatch")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return val, lvl
>
> # example usage
> c =3D LevelChainMap({'a':1}, {'inner':{'a':1}}, {'outer': {'inner':{'a':1=
}}})
> print(c.get('a', level=3D2))
> print(c.get('a', level=3D1)) #raise err
>
> This will leave the spec as it is and will require small changes.
>
> What do you think?

The more I think about it, the more I agree that using path-like syntax
in the selector is overkill. It makes sense to resolve the selector
level from the spec and then directly access the mappings from the
correct scope level.

[1] https://docs.python.org/3/library/collections.html#collections.ChainMap

