Return-Path: <netdev+bounces-126919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FE972FB6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C951F2321C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05B18C025;
	Tue, 10 Sep 2024 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkhmPsTl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39B188CC1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962033; cv=none; b=pcYsWTRnwZ+2uQjLVaeKUMS6+60HhtgKqZAHD7ePJuz6e6RHay3Vi7blJ2d9pEm91YgTHdiACH/e/NkvIgZyxQarbyfCW7umH1vgUYIoA8iCxMYA0lfWns0cJ+cOSPTV/0EaZM01gTaBOAp+dD9Oq7tgoYPryaYGQrR02I8CuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962033; c=relaxed/simple;
	bh=P2QgNQVbnWqUf9E81eBquhK8ELfIYoPeyv7XxDqNpwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l2/V1sCSr+NYjl+NkvEMtjvvJP4xyMqlOASn3XOQ0XpAKwqMLkG0saBQ4HhfrnDKUpy8fFiJGgl/a5q2cFHEDPD6N32cGR5WzVL0aLT7vlIFCqHAxEG6pyW9yV85tSf2mg9vDvL9zAELaGRcLpnNhZQKBqVpeAgJLJNYF7NHB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkhmPsTl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d3e062dbeeso122584417b3.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725962029; x=1726566829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htdu7gDJb2RXBiSiRNLgmzPRTEXOF0XUOmdJwojMinU=;
        b=rkhmPsTlPqPell2ceM7Dhm2wExii/M+j4fkYaIMwlM0MbkZ8PnpPE9rk6/3o7O07d6
         FzpqFsFQDYHC80PCgGzN1Rh19jhrq0cD+Dfl0ypCdp+p6CDgtlJlgFVf9DTWccDIDCUT
         SrdgdqdIBZRQPeil/UulhB6JW11l24Bm+8lT3jLdvTtOS8YG+09CZc8EK+o6G9Nc0brP
         aNTp1JGyLArN4nvVuT6XRw16b8ppO3ezgEYd9UYhdm00QEDIxXvnY3hjbRHgwmWy3uR0
         34Bqv6aRxWtE6xdNdH45CmdGbKb8WC7cgs28Fo2OoTkDoIQz2rfv1dD5cTvO0DjynVgD
         J9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962029; x=1726566829;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=htdu7gDJb2RXBiSiRNLgmzPRTEXOF0XUOmdJwojMinU=;
        b=feLMyxzKrZmpU89urzEavnfHE0oNgOvi1VY/jUhyeDNIb8TtbdZnp7+cw4f+FFpj9b
         /LATSRyHIaqU2u+HZ3D/E6R1HQpX2iKcL12B0xfDmkPsSo5B0TGZY60gR02llxVU6WfM
         Qsp9+v/W6CPvUZBBMgB9hGzm7Aqv8HwjwpRnjX93iS29gblPt/DMfE7YT/Ra7zyLK2+g
         DJpXLJckas7MPo1IHT1+K30oSsIskOA8j6aGG0BDyBL8M12tx/xLrpcARx9RRQz0q+/B
         JRcYN4AmDhdimXH2WbXgQ6PWEktzLxnZsyKSvOaHyzCFW90jEMwIAeApX+YRKLoZSksp
         C3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKT/qIf45MRr9Q2d9b6GTA/a7vyAqGLt34cH7Fegutrf7rUGCfzGqlCfZ904TAFamVHdi4luM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VaALBWWmX+zbKbe9fJzcCX4roepMpKvSdyj5GLTAtwme7BjR
	+nDGupHG19ywv2uiEeLEIig53vLYao9AjO0nxaNAJYsKpip2ZCOynWxZpVD2DYvKM1SGnPM8N26
	4MA==
X-Google-Smtp-Source: AGHT+IEj4kZV9r2+zjVhtoRcCn29CGlTh0LzKssnI32SUN244Iy+MkVQwaT4ckAV6lByV2bDmvtFVDeWTdE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:4481:b0:6d3:e7e6:8460 with SMTP id
 00721157ae682-6db9532edadmr1416287b3.1.1725962029627; Tue, 10 Sep 2024
 02:53:49 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:53:47 +0200
In-Reply-To: <20240904104824.1844082-6-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-6-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZuAXK7eoXxPNl9J-@google.com>
Subject: Re: [RFC PATCH v3 05/19] selftests/landlock: Test adding a rule for
 each unknown access
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:10PM +0800, Mikhail Ivanov wrote:
> Add test that validates behaviour of Landlock after rule with
> unknown access is added.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v2:
> * Replaces EXPECT_EQ with ASSERT_EQ for close().
> * Refactors commit title.
>=20
> Changes since v1:
> * Refactors commit messsage.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index cb23efd3ccc9..811bdaa95a7a 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -325,4 +325,30 @@ TEST_F(protocol, socket_access_rights)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
> =20
> +TEST_F(protocol, rule_with_unknown_access)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D ACCESS_ALL,
> +	};
> +	struct landlock_socket_attr protocol =3D {
> +		.family =3D self->prot.family,
> +		.type =3D self->prot.type,
> +	};
> +	int ruleset_fd;
> +	__u64 access;
> +
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	for (access =3D 1ULL << 63; access !=3D ACCESS_LAST; access >>=3D 1) {
> +		protocol.allowed_access =3D access;
> +		EXPECT_EQ(-1,
> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					    &protocol, 0));
> +		EXPECT_EQ(EINVAL, errno);
> +	}
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

