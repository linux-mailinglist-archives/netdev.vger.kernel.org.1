Return-Path: <netdev+bounces-128807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCFB97BC6C
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C027D1C218FE
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F576189900;
	Wed, 18 Sep 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foWdHXDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9218952A
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663478; cv=none; b=WNiRJKM9lErKSHZLK9pSJHY1QTor+79mZ2TidxHxMTFhH7tHBbApTAo3yGAmHhEdaN77bzxVWvdji1cst93Ut9Vve1Mz0pj/v8XmbKsK3jxD9EjHNgce3dYJ/e/Np5/X2bFUPFXvYymFigTAX7anx3j7nc0KLX8icyDpLHpXOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663478; c=relaxed/simple;
	bh=jyJkxVM6sAS/3tT3j5iaZDDXjdnQJ6Ydv1cWnP0Sa98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kiJkENbDLR7nwNonvACtd5ZqyYd7smrVwS9gZ7+w1kHUbSaSWWoWRb7TwmO7CrESLg/rTt1VMdnvgfZWPsJIThY2oAKVIKAoe/ThqUWyDBJxYiHl8fCypDfOWBRTVwsADC0S3kns+qmQch8Yot7KtzLW0CDasY48qR580g9RQ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foWdHXDZ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5c421ae1c7aso3050187a12.2
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726663474; x=1727268274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIwyfI4/DdUEaRJiUtONmUR4y8m0f8u2TdK+52Bbk1Y=;
        b=foWdHXDZ6r9lGWFC7vbT6+7PGHfQ3zkOoP5MuV7khcbH3GbNh3WsHO/RrNSPsmsH7W
         rWVLU/CQQWJ4gfXEJwRoO+Ct2AXqcsYS3kbKz1ZhuTH1xffypDY1Mq86WrnfnkNuqlfn
         ScN3EWC1sCqAxxmBNYhkZEFsuqVqjCIt3Xe8Pub5CgkXVgS7CDKPZpI977+Fzen2jYEh
         08diuszlKSpKUSV/+weyy6qXXUlRPGxGLBX+kwL6OTxdGdor8x4sajYYd1wpFtFXJI6q
         ufu3lE2cpPgFSSpAGMVfTakbkQJjPAaiArZMz89Ud+zVrHTssjj2uBYGpVpfiu0mk5UB
         NBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663474; x=1727268274;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIwyfI4/DdUEaRJiUtONmUR4y8m0f8u2TdK+52Bbk1Y=;
        b=bzztWDR34/KVDxRu03PUnWnV+4OBqH1J4QiWJ+W3vBBzq4gFJggeeAGKTGjTLEubLM
         aK6CAf8mDSQt6tV10RqQdEAD+FuP2J5oAJXp4cwv4yzeyI9rgv1x7GjLIuBHc5BhHt3w
         UYUY6vBXt6oWXV2D6HydFRMkqnmqSm39N1YGUBSthLHe1xEGbCXtlCbz/fNfB04seJzl
         89KvSDydQHFy14poGz42mTRx12P2mT8q2Q7TPZCTsmlJ5WNNW3+RZ54y4/YNqJWCg6qv
         fTp/yrocTExb2lAt+b0PcZusZnq3CUKRPn1M8KDsZ15G9RUpf6FXEt39YBkxSlLuaU+Y
         88UA==
X-Forwarded-Encrypted: i=1; AJvYcCUe2VOJ3C3511T7Ys/yFS5yss5OhQUEa3OHrgPfpaMStc4jTLemHltmwkiBRl4wlCCqMNEGxww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmMafxPmqNlMiZEEUDjOIGXN4YFkw2g2vI2B5VQ3CDE2UO2OX
	6eEsVq/sVhk4i7JERhvD/oTqpz7EmT8UROFM1PJBzRZ50D85nuVZZvAY7Ystm/X0zGkrujiOFkr
	U7A==
X-Google-Smtp-Source: AGHT+IEWfqwFAH1gT3bjvwsq5qPRyPUo8YazJWN1VHnOslXH4YppMhSKjdh9NHPPxOHvjw24Fuj/C7wQTHo=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:320c:b0:5c4:2278:28b0 with SMTP id
 4fb4d7f45d1cf-5c422782cb8mr9821a12.5.1726663474364; Wed, 18 Sep 2024 05:44:34
 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:44:32 +0200
In-Reply-To: <20240904104824.1844082-10-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-10-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZurLMFiskkMjcsx_@google.com>
Subject: Re: [RFC PATCH v3 09/19] selftests/landlock: Test creating a ruleset
 with unknown access
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:14PM +0800, Mikhail Ivanov wrote:
> Add test that validates behaviour of Landlock after ruleset with
> unknown access is created.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v2:
> * Removes fixture `mini`. Network namespace is not used, so this
>   fixture has become useless.
> * Changes commit title and message.
>=20
> Changes since v1:
> * Refactors commit message.
> ---
>  tools/testing/selftests/landlock/socket_test.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index e7b4165a85cd..dee676c11227 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -463,4 +463,20 @@ TEST_F(protocol, ruleset_overlap)
>  	EXPECT_EQ(EACCES, test_socket_variant(&self->prot));
>  }
> =20
> +TEST(ruleset_with_unknown_access)
> +{
> +	__u64 access_mask;
> +
> +	for (access_mask =3D 1ULL << 63; access_mask !=3D ACCESS_LAST;
> +	     access_mask >>=3D 1) {
> +		const struct landlock_ruleset_attr ruleset_attr =3D {
> +			.handled_access_socket =3D access_mask,
> +		};
> +
> +		EXPECT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
> +						      sizeof(ruleset_attr), 0));
> +		EXPECT_EQ(EINVAL, errno);
> +	}
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20

Another one of the tests which is almost an exact duplicate of the same tes=
t in
net_test.c, but should be fine given that these tests are exercising a stab=
le
API (and therefore should not need to change much).  If you see a good way =
to
reduce the duplication, I'd be interested though :)

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

