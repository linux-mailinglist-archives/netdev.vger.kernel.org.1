Return-Path: <netdev+bounces-102182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41157901C42
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF412822F5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F6055898;
	Mon, 10 Jun 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8sTvkzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187BF55885
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006609; cv=none; b=MYhslphBZLiSg0yCAH9Jtz8267IGzWyFNNHky/AnWP9I9zZsHzmeogVllH1N3pDkCzNvVZPhhmRhJC4Ihr9KxGZG+LBsDURF6Wxss+Xyl9jOYgwA+cnMXmV2Q1frqHPgUjXhTlqOHpuMJsm9e6ba88x0WNBZW9+JNAtHSf8bhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006609; c=relaxed/simple;
	bh=AoFy+rf1qZRigJ4LH6ipbIRwsjVgf59hZHjebuClpOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mgvt0tZK4i5BdEoQVISmViPWK5GxrFtai2FsSugNO8Wj3580G+tSf0ctwK8YXEVYjLXeP+NVzll5xI2rkqrkNkavSUe2ylke90qTfS5NVReIPAD5ToZdzZ1TJKwVHhGxIsFVoRqhhrYISSywjcRZQ86tp8rDedEhgrRVxTHi4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8sTvkzI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62c823393a4so56451287b3.2
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718006607; x=1718611407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5Q1iezkHd1ZRu0oHAjMzqV0sR5Aqpfu+Gd/v+RGtA8=;
        b=K8sTvkzInp9J5+K9RnO4rt6HqA1AzsdD3k+6tJfs9ORH797yOfCrQ1ROM1yG4ZE4z8
         w22gli4fRf/b65fNxxE/PGjXZiT6Z2ESIfyOVqcAjg0Vw5i28tL2yPTgEsmxrHP/Za+e
         UXC97Nbay9OnyuFWh6Qu442gdd9+Nw/WREmawsdLH/GgXMqgzd5cqtSn35UzBzvqJe6v
         p5KJCghtT+/BI5N0tMp0v1yyHOiKmB9AV8HCMLn1Aar6jG05u56wRLrW56bHsKzhkCHd
         Ya3u6Z3ahrrIOi76r4RsAGdYylOaI3c4H4r5SwPCRUuUa1/G2/JkwH3/gQ+u9eh7bl7G
         FtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718006607; x=1718611407;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u5Q1iezkHd1ZRu0oHAjMzqV0sR5Aqpfu+Gd/v+RGtA8=;
        b=Q3VyM7H9FRtrlj5pAwscxSa1YvM75EfTU8HglzHp0QZ83JOrow9lHsD2Dk+BTRKDAP
         W48nrt2bTE3fwLBSMkgKK1hlrDysUP285/yu3Qc0okZV3RmFtv23K/FmMEaFx9txOtTi
         moRhVEW5ISjlhezmyLRfbNb+M/iaPwGvwsdDRusV1ItuEKNzqP5JDhqE1h0YmkNuEoeF
         sozP7a3gwhketqYphB9zczIHA9wBifI8PhbXVSUs0BgSZNWAEFXy16GYJhDpx3b7uAd5
         4c3/kEPpOZ4Ui0nf/DAdlEps7riYxoNfDSnl3LVnlhYMKWMMGPBF2j2iKDzGvnLCK/8s
         U7cA==
X-Forwarded-Encrypted: i=1; AJvYcCUshQtfVORKCkHeSUkB1E0allFMbr7H6QxSuezMj7yu8rn/iRn00XzY0waMY1xNXe4xUAz7L90Vd6IkGbNQ4QILJWFFHJTD
X-Gm-Message-State: AOJu0YwLSoXmOGPYdmJPReoOIBtLcOqwi5CfDbdMdC4ns9VLncNIWoZc
	q5rrjoFNg60lpenQXUN94n6x9fAyNaW298YUo2ZDlf8IWk1Knrjg7n4Lc49/U4fCQHYyWZSXF71
	GuQ==
X-Google-Smtp-Source: AGHT+IEqUSN8bbuvDaJ9iwyS/r+NYoz4VPyxoViB6VkdbhYoxkNWwauW4YkGrTdiiidcWgxVr6IZzZ91l5Q=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:39c:b0:62a:564d:aed1 with SMTP id
 00721157ae682-62cd56571c5mr28478027b3.8.1718006607062; Mon, 10 Jun 2024
 01:03:27 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:03:24 +0200
In-Reply-To: <ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com>
 <20240604.c18387da7a0e@gnoack.org> <ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei-partners.com>
Message-ID: <ZmazTKVNlsH3crwP@google.com>
Subject: Re: [RFC PATCH v2 00/12] Socket type control for Landlock
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack3000@gmail.com>, mic@digikod.net, willemdebruijn.kernel@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com, 
	Tahera Fahimi <fahimitahera@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 02:44:23PM +0300, Mikhail Ivanov wrote:
> 6/4/2024 11:22 PM, G=C3=BCnther Noack wrote:
> I figured out that I define LANDLOCK_SHIFT_ACCESS_SOCKET macro in
> really strange way (see landlock/limits.h):
>=20
>   #define LANDLOCK_SHIFT_ACCESS_SOCKET	LANDLOCK_NUM_ACCESS_SOCKET
>=20
> With this definition, socket access mask overlaps the fs access
> mask in ruleset->access_masks[layer_level]. That's why
> landlock_get_fs_access_mask() returns non-zero mask in hook_file_open().
>=20
> So, the macro must be defined in this way:
>=20
>   #define LANDLOCK_SHIFT_ACCESS_SOCKET	(LANDLOCK_NUM_ACCESS_NET +
>                                          LANDLOCK_NUM_ACCESS_FS)
>=20
> With this fix, open() doesn't fail in your example.
>=20
> I'm really sorry that I somehow made such a stupid typo. I will try my
> best to make sure this doesn't happen again.

I found that we had the exact same bug with a wrongly defined "SHIFT" value=
 in
[1].

Maybe we should define access_masks_t as a bit-field rather than doing the
bit-shifts by hand.  Then the compiler would keep track of the bit-offsets
automatically.

Bit-fields have a bad reputation, but in my understanding, this is largely
because they make it hard to control the exact bit-by-bit layout.  In our c=
ase,
we do not need such an exact control though, and it would be fine.

To quote Linus Torvalds on [2],

  Bitfields are fine if you don't actually care about the underlying format=
,
  and want gcc to just randomly assign bits, and want things to be
  convenient in that situation.

Let me send you a proposal patch which replaces access_masks_t with a bit-f=
ield
and removes the need for the "SHIFT" definition, which we already got wrong=
 in
two patch sets now.  It has the additional benefit of making the code a bit
shorter and also removing a few static_assert()s which are now guaranteed b=
y the
compiler.

=E2=80=94G=C3=BCnther

[1] https://lore.kernel.org/all/ZmLEoBfHyUR3nKAV@google.com/
[2] https://yarchive.net/comp/linux/bitfields.html

