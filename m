Return-Path: <netdev+bounces-128806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D694597BC61
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9337C281CD2
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94CD18990E;
	Wed, 18 Sep 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmBt01Nq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DD180A6A
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663384; cv=none; b=kWZxV+2bVgKnXamCs+LkIEJEqQP0kUWUJHtV+qRP8zdj2O41+dz0hIpk12isGNt4uFgmdd30lN304tGAXlFYgB1tYqjoUiLiHMA77yu9oCyTi/wqEdafjOWnmYE2ZrFmH/yIb0hvlDQKr/mSjYqqz4zqi97LmwbjVt/ldgX5q4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663384; c=relaxed/simple;
	bh=eyDOxjytA+nN0IhDPMsttJqJSY1F1WZxlvJDWMsLRMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kr5/5IHULuf4cDJaqh8tuOQ5vXYoEcHb/g4w75eO8IISu8z/ui3TjMQpexCLi93TLtxm3I3HO9PTeFDOSZurPGSYKoDuOvDGKKkD24DnABDWlOC5m62CmXAKlc3n0FYe1g1Jg8XjVjrIXMaTfrY6O1tWrxyQ+0wvO2qBe8NTsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmBt01Nq; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5c2524b7ce1so2286891a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726663381; x=1727268181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNBhWqZq17wyEKC+rFCVheefZZ0e85NnLYR5aCMNKYw=;
        b=qmBt01Nq5ZWuUS6wxK5HbPbjOW3qTN1wrTQwOsrqjAQ/l/BKJZQG+Hfde/y4aaJxFn
         oU125YUZoq+FaCGfSxz0ENy2ZH+NLcfMDYmc7kOVqIz6+Wh9lNJ/avXg2zg4HPUy8W8B
         /+jFx8kFpVTCEHVRw5jLanlOdTYn1qufF4Dxn2VSHZV32hWUCDLgfDQnLB9TgUTBE6y8
         AjkqcLBZ4iT0xQJu9TbiXSrUIEufMI3RSIdQU9+ZoZKh0hzinpEZ/o9/3zu+Tmvif8Nb
         vV0H1IpLiIkbsZ2CK/aI/WG0Gcg7AQ1opdjdsNULaCjPc3Lmc9CrHpxXjDqU3AWKXfBe
         CHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663381; x=1727268181;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RNBhWqZq17wyEKC+rFCVheefZZ0e85NnLYR5aCMNKYw=;
        b=JtNjarYFNL5KTyuV2JSfR/ZeqGv4GjhL3ol3shvBn5BamSLpkx7A4Kz+N7VwK7vsCY
         EJ9xrADU5FYS8oR7DBuaJhx5cIA3ZBH8A0xLVn64qWF0nVjp7ma0SRBblLI7cdsrYpbu
         UksoplgA4bBxz3KiVSwLeRGvx7Ug8NwZHQk1GHOl519/tLSWUIFTCLc3C98s4C5BQq2f
         cIWXxWyF3Rxu7EMqMlAZhVh42uWtTyU3hjqykRR4n6S6hZvnT8CnKxdI8LbxoUJclFii
         hT3pz2XNotcjld38DaNjmXrKy0xDryn1NQTcZPTWUIfVVC0qR2y0hRhd1lwVf6HFwprz
         I6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkxQuK305+PrM7Uh2zJDB5QuPG5/V7ZK2eEZnb1JXtQKJotJPiVIA4XuSuozl7RZipHpkM1xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaX7/jVESnG5dLZJUYYgh3iluBkyM1r+qxpzJCxZiPENM73L1w
	PZEtQRpqfbDea4g+DU1ZGjq3K6GIGY/CLzNcU0D/fqduQiN9vWbGaUpQ3bA1VI0xnPTpYRIcGCC
	r9w==
X-Google-Smtp-Source: AGHT+IEg1V1E+QUuLes0+C0mA72hdz5q6cepKXRGSq2AF8Z/VRlkKRu9UYtoNKhHgkM5gOQxleEFqoUxkDI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:2405:b0:5c4:14db:4a6f with SMTP id
 4fb4d7f45d1cf-5c41e1b1d6cmr12955a12.4.1726663381243; Wed, 18 Sep 2024
 05:43:01 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:42:58 +0200
In-Reply-To: <20240904104824.1844082-9-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-9-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZurK0lPLYVhyhgj4@google.com>
Subject: Re: [RFC PATCH v3 08/19] selftests/landlock: Test overlapped restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:13PM +0800, Mikhail Ivanov wrote:
> Add test that validates Landlock behaviour with overlapped socket
> restriction.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v2:
> * Removes `tcp_layers` fixture and replaces it with `protocol` fixture
>   for this test. protocol.ruleset_overlap tests every layers depth
>   in a single run.
> * Adds add_ruleset_layer() helper that enforces ruleset and allows access
>   if such is given.
> * Replaces EXPECT_EQ with ASSERT_EQ for close().
> * Refactors commit message and title.
>=20
> Changes since v1:
> * Replaces test_socket_create() with test_socket().
> * Formats code with clang-format.
> * Refactors commit message.
> * Minor fixes.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index d323f649a183..e7b4165a85cd 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -417,4 +417,50 @@ TEST_F(protocol, rule_with_empty_access)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
> =20
> +static void add_ruleset_layer(struct __test_metadata *const _metadata,
> +			      const struct landlock_socket_attr *socket_attr)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	int ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	if (socket_attr) {
> +		ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					       socket_attr, 0));
> +	}
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
> +TEST_F(protocol, ruleset_overlap)
> +{
> +	const struct landlock_socket_attr create_socket_attr =3D {
> +		.allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family =3D self->prot.family,
> +		.type =3D self->prot.type,
> +	};
> +
> +	/* socket(2) is allowed if there are no restrictions. */
> +	ASSERT_EQ(0, test_socket_variant(&self->prot));
> +
> +	/* Creates ruleset with socket(2) allowed. */
> +	add_ruleset_layer(_metadata, &create_socket_attr);
> +	EXPECT_EQ(0, test_socket_variant(&self->prot));
> +
> +	/* Adds ruleset layer with socket(2) restricted. */
> +	add_ruleset_layer(_metadata, NULL);
> +	EXPECT_EQ(EACCES, test_socket_variant(&self->prot));
> +
> +	/*
> +	 * Adds ruleset layer with socket(2) allowed. socket(2) is restricted
> +	 * by second layer of the ruleset.
> +	 */
> +	add_ruleset_layer(_metadata, &create_socket_attr);
> +	EXPECT_EQ(EACCES, test_socket_variant(&self->prot));
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

