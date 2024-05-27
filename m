Return-Path: <netdev+bounces-98335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8D8D0EC6
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393A31F21ABB
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD8D41C62;
	Mon, 27 May 2024 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VcbWi//G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EC20DC5
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843156; cv=none; b=F/wNJZZC0k+EVqOHhPFuCRAOcaPgse48+NenLbRzZMaZj6Y/Sn+/p/iEyRwq9WbHQ5u4gGZP/6d4AHY9dy+i6rSvJuLouFZzucc4r2/D0OVu/v8mDfO/YJwXDz2bMilZw4c9dnViRz2ruhDr2VH9+3KR63wfuf5OyW/D7XQEGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843156; c=relaxed/simple;
	bh=wudtqjXegGU2LtEgfC5Ee2aj9ydGYtWtwEHcvXo/4S0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6AlBhQfpWGZM8vQZUq898+/xFZS0my25pCkA3Zj2d1a+fLRC5WSCMY+sG+NZ6Mc4eWHKYrZIx5UBLlLD8XgVnALScXQ6TVX6+Yhs8g4M3/QdQkyKSbkb4qBIwQDVKI8NIsUfNMxfIUkleEu9mCHc4n6YqX+d6iH93MEQXpGSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VcbWi//G; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df789a425d3so184990276.2
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716843154; x=1717447954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdSWbeuLkDTbi8rWZxWdxrTiYH7VS1P/CmuJ+z7yq7o=;
        b=VcbWi//GhbGv/psMmJLARTlU7QOQVYkrDvHl9GhF36Qs8bmMpqPbvGF6QTbQuatn/c
         Gn+BFhA5duxUdP6+EOHXzcBHowiQxDzoq4faeSiJTQRr6Ao0FNLyFqS/bpNwvCNqPsVw
         M6f/AV+L4KKuGellOYL1KZs5GHLH6nJx4sZ8Lt6JPlwvzof/J/S4NIzSEdfFaIVne3Rf
         By/Hzlknqj0L41sS0rMZik5jcuxoucULuBPpLkFZPNoaGhSpo5jLMoQtBTjPpVpu6xVg
         mxYuBVs72E4r0ePDm3NqtigcAi7L2ev1FO3vItUjlxhuFMpv4niCtT41icMVP6ZD+M5E
         whwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716843154; x=1717447954;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bdSWbeuLkDTbi8rWZxWdxrTiYH7VS1P/CmuJ+z7yq7o=;
        b=H5/1a7MkwkJ+rVW6ufzaY9amLrptH7FRQ8cZLv6sbn8lacn45Kox4CtD8Em5uJXuPT
         /RBvXo8kA31DDkeUfMsiR9Rhw+XLScliSiNTA0Ye6vJF94eeNkvN5CiPSlC4Pe5miPkx
         cgmfgqx3GdZUrtLjNAYOohTmJ90eNlev2XPIzIkjVEm+s6ykihomVyvpBoWEWBcRgPgg
         q7jo4/pGKlif0P+Z5+sl3LmmBPuM/Ed98bXYBzvMbX97wa4+5DD9bjjEaCg5DmD3jMkH
         iJYjJ+bb3VJCpeulBzqCTthp/SkT8g5Rfk1W6pCwzmHAeRIJXGoiMpT51MiYii7TGjvM
         RJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf9HQ/VYhigdmKyZK7UGcdLlKFp4sjhmAvTB25Pqnd5kSGbVFNb+dFloI1pMltAujpgt4Cp6mJzyeiT+t3M+T1sy3Q+5mX
X-Gm-Message-State: AOJu0YymhK6pocqaKpMX+m1cJUXVoTCiWrjBtNaKlC0JT9fYagAMJg6r
	6re2HL2OW2vFSrzGkUtt5lb2iSEf2CYqqXmsO3jIZr7MO8x4n8XeJdFvsfvZdZCAfu5AyyTtWgE
	1HQ==
X-Google-Smtp-Source: AGHT+IHDLacknHXmGIL0fTHZIViFSMUziqkpSLS4ou7PKscFtSM39cprVmoLrkxlA8wxM5OY6SXv9Fa4dTU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:943:0:b0:dce:5218:c89b with SMTP id
 3f1490d57ef6-df77217397cmr911644276.5.1716843154243; Mon, 27 May 2024
 13:52:34 -0700 (PDT)
Date: Mon, 27 May 2024 22:52:31 +0200
In-Reply-To: <20240524093015.2402952-5-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com> <20240524093015.2402952-5-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZlTyj_0g-E4oM22G@google.com>
Subject: Re: [RFC PATCH v2 04/12] selftests/landlock: Add protocol.socket_access_rights
 to socket tests
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

I see that this test is adapted from the network_access_rights test in
net_test.c, and some of the subsequent are similarly copied from there.  It
makes it hard to criticize the code, because being a little bit consistent =
is
probably a good thing.  Have you found any opportunities to extract
commonalities into common.h?

On Fri, May 24, 2024 at 05:30:07PM +0800, Mikhail Ivanov wrote:
> Add test that checks possibility of adding rule with every possible
> access right.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>=20
> Changes since v1:
> * Formats code with clang-format.
> * Refactors commit message.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index 4c51f89ed578..eb5d62263460 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -178,4 +178,32 @@ TEST_F(protocol, create)
>  	ASSERT_EQ(EAFNOSUPPORT, test_socket(&self->unspec_srv0));
>  }
> =20
> +TEST_F(protocol, socket_access_rights)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D ACCESS_ALL,
> +	};
> +	struct landlock_socket_attr protocol =3D {
> +		.family =3D self->srv0.protocol.family,
> +		.type =3D self->srv0.protocol.type,
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
> +	EXPECT_EQ(0, close(ruleset_fd));

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

P.S. We are inconsistent with our use of EXPECT/ASSERT for test teardown.  =
The
fs_test.c uses ASSERT_EQ in these places whereas net_test.c and your new te=
sts
use EXPECT_EQ.

It admittedly does not make much of a difference for close(), so should be =
OK.
Some other selftests are even ignoring the result for close().  If we want =
to
make it consistent in the Landlock tests again, we can also do it in an
independent sweep.

I filed a small cleanup task as a reminder:
https://github.com/landlock-lsm/linux/issues/31

=E2=80=94G=C3=BCnther

