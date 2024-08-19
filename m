Return-Path: <netdev+bounces-119897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6A9576B2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86151C220F4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6581D6191;
	Mon, 19 Aug 2024 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2mfnDNw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408471DD382
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103428; cv=none; b=FKfShxpNyjl2JH+X4kRqNfngOxPCiBbvGr32zA9qay6aQiL+1k+jLDJL6Iep6ZLibuS0QeuKSeQHix41Kk6+/QrO6B3FnXopCxzyo4ic8620tghjHcingI/gKw1jEAans2/wIHcJzVYqe9HzZe2/Nu/d8pXN5xSL2yAzD6Exi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103428; c=relaxed/simple;
	bh=vYAVcLDAzLHOXkjjsKxNHFJx5YFBFwRkGYiH4fkl7X8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DYR1CAsdp/PVVuzsvBiHxpenVmkGBcUkslvPPQGzm88futRg/tkKdQlBH4Z7+JUB2S/j/S2LeAr3bL2nWnwu0PRmAhR+INn7ZD6vvfHUhDLL4Ka7vOgGEKd6yhS/MiTsZ9uiPa11+YGHof6IcoDsr0Aa+SuLVlHVoWcko4mVbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2mfnDNw+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ad97b9a0fbso91083447b3.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724103426; x=1724708226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZ6C08RZa0gEr7q33GMAMFHHAHyuh6votb48gYCvR+E=;
        b=2mfnDNw+QzpzHSmfcMEtGLpmg9kKMW3hPSniBG/IivzBLiXyT2Azyrng68xRlOYzf1
         R/klQ4nobAuy4wy2zXdauK1IkpyBtEsNm0XvmZM2FXXwT1LviEf5nQTbjwvW9eNQZ2jt
         ql4eQAFonbzGkb/R00tG4NOWfuKQV2wKog/kQwhfAdaBtptGMfLKB1/7XdJ9FoSH2OMV
         OIFPQVhyPwI9DPlPRNXPDK5+EJvoszt6on5iVYdDOQ2AvsAuhay28SvlQPgKY8KI18K5
         SjQRzUTqekfGnTSvhOSt6ebpHxs08FAJSRNYwKvqT0frbgrfAZ8kmHyYMcbtyqPW3rFC
         iGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103426; x=1724708226;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZ6C08RZa0gEr7q33GMAMFHHAHyuh6votb48gYCvR+E=;
        b=uB8x707an+O8rtqRPCKZ5Z1I8Le67GbnyZoquS7cEIdrXUYMZ8Zcph8iz5Qo9e0Fl8
         j/jwiNS8RBlPQlrfuvav9yrndeCxThyOXlFPcpNGMWBnjC9ppxHJ/jrfp8RkSTKdAOnZ
         MLzy6+R9gxkEb7zIJnclokJ2+rs4N7F0x76kzVjrDKJLKF0rmctXQYVPQCQWYADnJRXR
         5pYDiTGwA3ev5wA2IkWl/EStR1N31yUWk5aeNydHhQNLE2LYSkg+fnGo8tc9955yt6S8
         QqZswbZ1qowu9onec5ftYq2kR8nAFW6C+47EU8GPDnJ1zxsrf3MigbK03l04Vm74kw9z
         1EFg==
X-Forwarded-Encrypted: i=1; AJvYcCWx3V8vFzBK4p8gDeLqFKBc0vlVZV5W+buVa+tHFqrpVTXKwm4+HCZMMSdXisk4Vcd1WG1ix24=@vger.kernel.org
X-Gm-Message-State: AOJu0YztlwWANjM/gbQGQTIgm6EOL8aQOZR8/7q5XbJnKvEjBj2gYwLh
	1zmPm3c9MhaNmR0gK9z4xePHLzB9tX9Br9hRwNFWa1oEubuBJbxfPZmXrsm3XQqPWmQwvf0wJnE
	7lA==
X-Google-Smtp-Source: AGHT+IFPWI3kkRHHFJIt3qwISrXOcJfxDYLchKswQv9BUwDwDDQf+NRjHU8hW/Z2gESKkKRMU8hTQubcmjo=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:4606:b0:691:2f66:4b1c with SMTP id
 00721157ae682-6b1baeadc0amr935997b3.6.1724103425960; Mon, 19 Aug 2024
 14:37:05 -0700 (PDT)
Date: Mon, 19 Aug 2024 23:37:03 +0200
In-Reply-To: <20240814030151.2380280-2-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814030151.2380280-1-ivanov.mikhail1@huawei-partners.com> <20240814030151.2380280-2-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZsO6_14c14BAn-kI@google.com>
Subject: Re: [RFC PATCH v2 1/9] landlock: Refactor current_check_access_socket()
 access right check
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

Thanks for sending round 2 of this patch set!

On Wed, Aug 14, 2024 at 11:01:43AM +0800, Mikhail Ivanov wrote:
> The current_check_access_socket() function contains a set of address
> validation checks for bind(2) and connect(2) hooks. Separate them from
> an actual port access right checking. It is required for the (future)
> hooks that do not perform address validation.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  security/landlock/net.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>=20
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index c8bcd29bde09..669ba260342f 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -2,7 +2,7 @@
>  /*
>   * Landlock LSM - Network management and hooks
>   *
> - * Copyright =C2=A9 2022-2023 Huawei Tech. Co., Ltd.
> + * Copyright =C2=A9 2022-2024 Huawei Tech. Co., Ltd.
>   * Copyright =C2=A9 2022-2023 Microsoft Corporation
>   */
> =20
> @@ -61,17 +61,34 @@ static const struct landlock_ruleset *get_current_net=
_domain(void)
>  	return dom;
>  }
> =20
> -static int current_check_access_socket(struct socket *const sock,
> -				       struct sockaddr *const address,
> -				       const int addrlen,
> -				       access_mask_t access_request)
> +static int check_access_socket(const struct landlock_ruleset *const dom,
> +			       __be16 port, access_mask_t access_request)

It might be worth briefly spelling out in documentation that access_request=
 in
current_check_access_socket() may only have a single bit set.  This is diff=
erent
to other places where access_mask_t is used, where combinations of these fl=
ags
are possible.

These functions do checks for special cases using "if (access_request =3D=
=3D
LANDLOCK_ACCESS_NET_CONNECT_TCP)" and the same for "bind".  I think it's a
reasonable way to simplify the implementation here, but we have to be caref=
ul to
not accidentally use it differently.

It is a preexisting issue, so I don't consider it a blocker, but it might b=
e
worth fixing while we are at it?


>  {
> -	__be16 port;
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] =3D {};
>  	const struct landlock_rule *rule;
>  	struct landlock_id id =3D {
>  		.type =3D LANDLOCK_KEY_NET_PORT,
>  	};
> +
> +	id.key.data =3D (__force uintptr_t)port;
> +	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
> +
> +	rule =3D landlock_find_rule(dom, id);
> +	access_request =3D landlock_init_layer_masks(
> +		dom, access_request, &layer_masks, LANDLOCK_KEY_NET_PORT);
> +	if (landlock_unmask_layers(rule, access_request, &layer_masks,
> +				   ARRAY_SIZE(layer_masks)))
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
> +static int current_check_access_socket(struct socket *const sock,

Re-reading the implementation of this function, it was surprised how specia=
lized
it is towards the "connect" and "bind" use cases, which it has specific cod=
e
paths for.  This does not look like it would extend naturally to additional
operations.

After your refactoring, current_check_access_socket() is now (a) checking t=
hat
we are looking at a TCP address, and extracting the port, and then (b) doin=
g
connect- and bind-specific logic, and then (c) calling check_access_socket(=
).

Would it maybe be possible to turn the code logic around by creating a
"get_tcp_port()" helper function for step (a), and then doing all of (a), (=
b)
and (c) directly from hook_socket_bind() and hook_socket_connect()?  It wou=
ld
have the upside that in step (b) you don't need to distinguish between bind=
 and
connect because it would be clear from the context which of the two cases w=
e are
in.  It would also remove the need for a function that only supports one bi=
t in
the access_mask_t, which is potentially surprising.

Thanks,
=E2=80=94G=C3=BCnther


