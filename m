Return-Path: <netdev+bounces-71991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2428560B7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AB21F2242D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BAF129A98;
	Thu, 15 Feb 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kpz6q7xp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994748529F
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994756; cv=none; b=Kgtz8EkCxOv2Hmq+EQp+k3OBfald9cHNLSdE9ZGgvCxXhwE2Soor4K2lD5PLgfn0Xz+9Z7hlg2HpGvrm4QfQW5s+juQEJflLao5kjnu2XEcX3VOKQIIVRi72yg78IQxvE8qT5ePFY/3BvYeOxyKW6ZEMalzgq3hdGlMWekCENMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994756; c=relaxed/simple;
	bh=RoOhYsWKl4id9h2UBMjJnCZPzwetbNdKICsUFnEQ9bA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czRk9eNg4N9T15NSH5+JJl1ryNohAM82jIVXP8ucQmw5AzzGPSJwsMRFxMIAmXARMRpvk9C+r/O54s3NkIFSpjlu6i6RhR3400woYrIOVoPxE3D7K/u8q1tfn24MsuvnVppNL0uzHM6vandTFV2OPQUi+K9L4QX51ZxnrOJ4mac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kpz6q7xp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707994753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=woqgG7qDUaCEdyTuoC12m4r/isYcHMcNv/Nepgm3+JQ=;
	b=Kpz6q7xpcIJu8NmQ4Qw5/rECizdRXHua65wvlI5kKT2WZMzbPfU9mHAvn1wdeR1dh5gCgq
	HxkEBBQJf6YjS84bv6vzz9caDJ3q+FF0tk3TIoxUj1KbXRja9FOsdY8u+auAwKpW5RlHPQ
	5ky3zu3axQKNy4YCe6SwgA1Wvd4p8XM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-hnRcslzLNrCYF2v2SPqPyA-1; Thu, 15 Feb 2024 05:59:11 -0500
X-MC-Unique: hnRcslzLNrCYF2v2SPqPyA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-411e27d561dso1747515e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 02:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994750; x=1708599550;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woqgG7qDUaCEdyTuoC12m4r/isYcHMcNv/Nepgm3+JQ=;
        b=VKYXPZoWLL6NfOiKYZIFVaNJeHg4s5TfMk5Eb2OD1kYZV2hhVjwACgjS9c2zKiBIcc
         ks8CBzI6UsvbDvsSk28yeBeftmBV+0q+8hS1TBcNBxBCC23KzXdkyLZQUGhwBMa37NCl
         tfQa3wF7L1sdcX/u/fiWbas5hEhY1eeRpkSAF5FHXeDvV2EG1G8mO+BZyMkP7jGnQZUG
         AhplUGRb4cBYzw0Q5azCS50REWKlAbb7xY2YLl8xLnbM0hZqaEIqTymiNtvusqtPKcTh
         fj2yd10uBzNwLvVK+mNKrxtVV8NB+gxI37YwZCmDMCueO7LjK4InNRabuOoPTfAzhRLE
         iePA==
X-Forwarded-Encrypted: i=1; AJvYcCXb8G2Lszxp6gMyaOO7GnIHezcGcwfy0IYITNuJlDoP80G5UUFvQKoPyPikjpZBMiVSopdyIAdQE4XPIJiltuJLgWnzX+ct
X-Gm-Message-State: AOJu0YxXrQ/W9pGY5tofB5oEwiKo/WK5cTkPiyfGn9G7XXimfxqk2OyW
	JLeg3QPRu/gTF004bxgQmZvRtO0NvKt0dGJ9hR3j60+Txz9BO0vZXnkNzYBwcHDhJCS4ds+AzjD
	+qBtuMW6DFX06ZqIDbawknyzQwsroenjpS4UDlYGZUvsGzVg1Mb7D+g==
X-Received: by 2002:a05:600c:4f15:b0:411:dd14:8c36 with SMTP id l21-20020a05600c4f1500b00411dd148c36mr1022602wmq.2.1707994750291;
        Thu, 15 Feb 2024 02:59:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL6gXUtDYGp5A2tJLOK0tEzbzBXqS1/Ue//Eq8lYqnI+XjjiQuS0mZaoxeSpZ2FKNyb5dJEQ==
X-Received: by 2002:a05:600c:4f15:b0:411:dd14:8c36 with SMTP id l21-20020a05600c4f1500b00411dd148c36mr1022589wmq.2.1707994749918;
        Thu, 15 Feb 2024 02:59:09 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-156.dyn.eolo.it. [146.241.227.156])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c221500b004101f27737asm4647602wml.29.2024.02.15.02.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:59:09 -0800 (PST)
Message-ID: <8bcd540b747ae30edc10c5208d7876b901e702b8.camel@redhat.com>
Subject: Re: [patch net-next] tools: ynl: fix attr_space variable to exist
 even if processing unknown attribute
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	donald.hunter@gmail.com
Date: Thu, 15 Feb 2024 11:59:08 +0100
In-Reply-To: <20240213070443.442910-1-jiri@resnulli.us>
References: <20240213070443.442910-1-jiri@resnulli.us>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 08:04 +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> If message contains unknown attribute and user passes
> "--process-unknown" command line option, _decode() gets called with space
> arg set to None. In that case, attr_space variable is not initialized
> used which leads to following trace:
>=20
> Traceback (most recent call last):
>   File "./tools/net/ynl/cli.py", line 77, in <module>
>     main()
>   File "./tools/net/ynl/cli.py", line 68, in main
>     reply =3D ynl.dump(args.dump, attrs)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "tools/net/ynl/lib/ynl.py", line 909, in dump
>     return self._op(method, vals, [], dump=3DTrue)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "tools/net/ynl/lib/ynl.py", line 894, in _op
>     rsp_msg =3D self._decode(decoded.raw_attrs, op.attr_set.name)
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "tools/net/ynl/lib/ynl.py", line 639, in _decode
>     self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
>                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "tools/net/ynl/lib/ynl.py", line 569, in _decode_unknown
>     return self._decode(NlAttrs(attr.raw), None)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "tools/net/ynl/lib/ynl.py", line 630, in _decode
>     search_attrs =3D SpaceAttrs(attr_space, rsp, outer_attrs)
>                               ^^^^^^^^^^
> UnboundLocalError: cannot access local variable 'attr_space' where it is =
not associated with a value
>=20
> Fix this by setting attr_space to None in case space is arg None.
>=20
> Fixes: bf8b832374fb ("tools/net/ynl: Support sub-messages in nested attri=
bute spaces")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/net/ynl/lib/ynl.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 03c7ca6aaae9..b16d24b7e288 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -588,10 +588,12 @@ class YnlFamily(SpecFamily):
>          revalue =3D search_attrs.lookup(selector)turn decoded
> =20
>      def _decode(self, attrs, space, outer_attrs =3D None):
> +        rsp =3D dict()
>          if space:
>              attr_space =3D self.attr_sets[space]
> -        rsp =3D dict()
> -        search_attrs =3D SpaceAttrs(attr_space, rsp, outer_attrs)
> +            search_attrs =3D SpaceAttrs(attr_space, rsp, outer_attrs)
> +        else:
> +            search_attrs =3D None

It looks like that later-on the code could call self._decode_sub_msg()
-> self._resolve_selector() with search_attrs =3D=3D None, and the latter
will unconditionally do:

	value =3D search_attrs.lookup(selector)

I think we need to explicitly handle the None value there.

Thanks,

Paolo


