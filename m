Return-Path: <netdev+bounces-126918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA27972FAB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D401F23B38
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCF318D63B;
	Tue, 10 Sep 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLkWhyqZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5618B477
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962015; cv=none; b=Uk3oB6BofazdaLp6X+R5gfoibjwa2VJvizOX6bmhSSPsruMmEa+BmlnVOBfCSLzFrMntRQdWtQqj/NrHyDrn5y3hVKDMGczRSTyK2hH9TIAOaV+hf19AxwHd1ZAqbIG1GjoA5kB6IIaVFOX5KabhOwh4bJH4IDl/5PgY9+hOEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962015; c=relaxed/simple;
	bh=bUjKo2hKjo47ALYGkcpnrzn7VI8TDc7sUV14SFfR5BY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X5abr/3UOUulFG87y/xyIbbjYPkov0C084hrNZY/KoTz5H1z7KIugbX9ChGD38xAWbu7QqEXFJmUvsUI+eX/jVdAi5Cj+r6Ea9JtA5GjTJqtmij/zcyZSg9ZperAbADUOCHegWJnCVIE2xlKyQXwBlJx4NHvIVCfk1rUHyMEzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLkWhyqZ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a8d0d87f204so366170366b.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725962012; x=1726566812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLwzZqGyb/MrVPN3DxT7ybP0Dg2vrqdUnFlphaKFoAA=;
        b=fLkWhyqZPrUn2RTPMIxVuvgazuhVpKBuHBjy+UKi1CMZ75bnyjKMOhznOTsf04RFCO
         xWpAdutKoMQDwJfwZHSl98o+T9vZm7TKMt9VVPkao++EmLebUaZcZ+1ZmeYgZovNNLmT
         2Knm+DtCGLmc2uMwMq1aWqTrmPSzd4jTGArnkLGV2S1A3oX6+u2BLlrZgjnXXQ1hPKwP
         SPUlRbTeWaHzXuL5E6KU/1Tn+RCPgd2ccyjpxZtWhy4WzRCRkmK8P0e3mLAmyIADnrX2
         2FpLF3lwrQNvkavEewEwRDtmihK6HWshWW+2FhbJGfw769A3i3G1mY3LTQoeHcOg2wLu
         rkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962012; x=1726566812;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QLwzZqGyb/MrVPN3DxT7ybP0Dg2vrqdUnFlphaKFoAA=;
        b=oVO8LW6hTssekB0wETSfv0KIApZxPK7YT6aIcce52nSJoO5ArK7jODDkRBrtNp3t5G
         O3LTKKlj286BPJ2luHP2u1XARHlauboD1VgHK3fw5OqTVyWxXG9Of/HCXJnk1AkFRZAh
         spZQoRP+GKpohcEPer6R9SO2+P3ec10awSQCsoefCuVmoF12NNGCGuA6i/VVUwW436rF
         SsuqcfwuXn9Kk7zMtFYVd2IDw+BqG4CcQf/zgo/SyhQcjHYu1A9sKaVT4CTUgzpUbJDl
         rZpzDvjn8ReWszstJkVs7nJYB5LgDUh9mSYNUgdwIDc+dbkurPt5mW5oB+FYBA25qdvI
         3mrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB2KMzpXEzyg3mKuucDVVZPI3qWlXAguON+Wdf9SfOgWaWrOUo4CwDmTonnXpEtMIGHLrTOi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKxi1giOILU2zmhsYU67T1TBX8k0NFUKfn1jB5s0yKNrYzBZN
	g5tL86C3it82SNrbrk2qCZqft+le7O87nLLxk/m1JRYVQ7jJP+l/qi76YhVkvTql6btihAhqTbp
	jJA==
X-Google-Smtp-Source: AGHT+IEKRkuwKZ+CzVsiEkxduxS73xjFyBD2cngHBnHjRzLoQtzVHwrcWcBID3PvyDTBlYs+V00WXsliOxM=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:3798:b0:a8a:802a:bfcc with SMTP id
 a640c23a62f3a-a8ffaec4543mr8266b.7.1725962011800; Tue, 10 Sep 2024 02:53:31
 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:53:29 +0200
In-Reply-To: <20240904104824.1844082-5-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-5-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZuAXGVBbld3UfKH0@google.com>
Subject: Re: [RFC PATCH v3 04/19] selftests/landlock: Test adding a rule with
 each supported access
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:09PM +0800, Mikhail Ivanov wrote:
> Add test that checks the possibility of adding rule of
> `LANDLOCK_RULE_SOCKET` type with all possible access rights.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v2:
> * Replaces EXPECT_EQ with ASSERT_EQ for close().
> * Refactors commit message and title.
>=20
> Changes since v1:
> * Formats code with clang-format.
> * Refactors commit message.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index 63bb269c9d07..cb23efd3ccc9 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -16,6 +16,9 @@
> =20
>  #include "common.h"
> =20
> +#define ACCESS_LAST LANDLOCK_ACCESS_SOCKET_CREATE
> +#define ACCESS_ALL LANDLOCK_ACCESS_SOCKET_CREATE
> +
>  struct protocol_variant {
>  	int family;
>  	int type;
> @@ -294,4 +297,32 @@ TEST_F(protocol, create)
>  	EXPECT_EQ(EACCES, test_socket_variant(&self->prot));
>  }
> =20
> +TEST_F(protocol, socket_access_rights)
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
> +	for (access =3D 1; access <=3D ACCESS_LAST; access <<=3D 1) {
> +		protocol.allowed_access =3D access;
> +		EXPECT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					       &protocol, 0))
> +		{
> +			TH_LOG("Failed to add rule with access 0x%llx: %s",
> +			       access, strerror(errno));
> +		}
> +	}
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

