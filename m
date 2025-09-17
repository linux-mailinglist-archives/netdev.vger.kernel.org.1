Return-Path: <netdev+bounces-224041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6CB7FE64
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8FF1C8006B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360862D838A;
	Wed, 17 Sep 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2KMJxzxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1772D8379
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117892; cv=none; b=Esjj0hQmDIxfML9y3ufXsEYdgjL3KB9v4cJif67wSUrenfMc82uVXelukNQmuxsiGWHmCbKHrWiwUglObXt0l1JSBIsiv2ZrOFk6HJKjif58+/gVJsl/AkRYV7didQsOiT4EyyP6zMXHpc5DtgU9BPJ5pJG6lRJ4lOcucW+VxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117892; c=relaxed/simple;
	bh=OBAIcvHUghATrYnSSQaV8xQwxdOg4X6Q+YqeLfZ93DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNB9u8KHPKz/1J1DS1/PJaxhmiCe7r+RswHR2fA8pods0+ccANHn9JtA66lgOdl3pfiomJlLJ2i81msOyd9RkQ0m5UQtam0aTsuyqUZBMwCxtb9SPWcPUNKHPM0xxInSWjfB7ucP0g5YqAR4Y3oQW4TFeCbaehIQ3sjrHrtbOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2KMJxzxp; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ea5c1a18acfso673831276.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758117887; x=1758722687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSf4Y6Cd+QvIWBxKph9JvEoJ2gq6aXmXb4nRGjqRK9s=;
        b=2KMJxzxpUPvxOVMB85N/yADW4WJdq5NN5pnSQxZRYatvsfq8C++IXpa7OIpMDUVnhe
         eAcDrn3UVl4T47WXbgQU4yhFDqDFsZtP+XpKRXfONG7iA30brO+KrmsW7GZ83QtKFHKF
         0MfCkEPOeTQcYU2fszUydcnKl+4J2d5XLcjIKgqIZK8NIzdhazbDRNm3pbS8tAJsgDiN
         Qo1KbQz6B0jCoHHkOxEQ+7GdymvZril6nixXIaowBd2kObc8AGwmFgHTa/LZnI7i2wlx
         db97fMrySjnFqRoL0WPOLlt6BURCNrPVJ3Cm7r/BLVKwx16iF9A4xWCOc8Zf+rX2CAOs
         lG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117887; x=1758722687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSf4Y6Cd+QvIWBxKph9JvEoJ2gq6aXmXb4nRGjqRK9s=;
        b=G3vyj2lionQMAfDdUQZQxXJbtHCp+p9W4FyDTFS3mbkLPGE0to3iAVChsJ+pCXGhEz
         73pg4WY2/0G0mLw01qFpUMm7s9l61xjvLMYnnTObWtBP5I0gx6+BO7QaxqPtLemg7q/H
         MzG+LADVlgKYs5VNtkz/bvbg4ofMFH45vvLAjpdpz/PAXy6vmmJrF4kfx5oqKosW1xJy
         VtuI26jKkt67f4Tmns9VnhloUCGbXyPxLzpfgzB73BdOcjhxMiN/vG5btExiEev0k1ge
         4QdbFqVC4haUClY21EcDEqKDc0JXmHYqrR53qUMYlVOSlXv/oQqjYepXrngV7UniqKXr
         y+OA==
X-Forwarded-Encrypted: i=1; AJvYcCXpVw+sUm2AlQ7BaObfWiL092jq4MmZsOGAqUjwTT+mqBWaj9ov+4AOXEFNcSKSmGnzaURDMjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjlsTn/qDB3X93o9LeKhly6GYCTQM7ERx5dwDy/vs2nxbx+74j
	X2F7nSv8liYH46gXw1O0b0WANrnSsc0SwB9liO+JmMZyGwVvk9Ql9mblMsLzvRSGxJAkigPLODb
	tHrdu39ok9n0Yxa35mpjpc/WPu1W6Je7XsxdRa0P7
X-Gm-Gg: ASbGncvXyrJXB8EPUlJoJH3HbBv4FzF9Xh/O+Y0WjRpli+rBXeOoVO8YSkJjAXyAAJE
	VJU5X6TayA3939ExPk+UXME47N4grrD9ggXwCWPRFlruoZuqSAMcxVMvYzuDaBQ0A8Rr9TNRSUW
	G277VICQgcmiArH9Lzs8yxN/JeGaEhAYzlfB9Khw9qaqwM62f4XqDjcq/Kq1TVgAr5nMXwHJtaZ
	Kq6R0MwvoqfM1DIbcn9uY4=
X-Google-Smtp-Source: AGHT+IG1wj1F0s6RhfBKZIK1BejYLxW4synWAXpAqvkW06HFnEWGW3o9Sp1wyeHLb8s2JQXe0UudgBVYZBvTJFWg/hg=
X-Received: by 2002:a05:6902:33c3:b0:ea5:beee:4c24 with SMTP id
 3f1490d57ef6-ea5c068bc2emr1915393276.53.1758117886966; Wed, 17 Sep 2025
 07:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-7-kuniyu@google.com>
 <35a48361-c69f-4cf9-aec9-db1ac0597f96@kernel.org>
In-Reply-To: <35a48361-c69f-4cf9-aec9-db1ac0597f96@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 07:04:35 -0700
X-Gm-Features: AS18NWAkbxoDnP5rtsNfVk3rz5yASh_D6Lw5VHvFppbv056zBxaHxp4XaQ49UZ8
Message-ID: <CANn89iLT4P1qqtJBmKq0iA63isjMfdgv+gQ25+fM4gSG7dT4RA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/7] mptcp: Call dst_release() in mptcp_active_enable().
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:17=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Kuniyuki,
>
> On 16/09/2025 23:47, Kuniyuki Iwashima wrote:
> > mptcp_active_enable() calls sk_dst_get(), which returns dst with its
> > refcount bumped, but forgot dst_release().
> >
> > Let's add missing dst_release().
> >
> > Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole"=
)
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: split from the next patch as dst_dev_rcu() patch hasn't been
> >     backported to 6.12+, where the cited commit exists.
>
> Thank you for the v2 and for the split!
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> Ideally, it would be great to if the 'Cc: stable' tag can be added when
> applying the patch, so I would be notified in case of issues with the
> backport of this patch.
>
> Cc: stable@vger.kernel.org

I almost never use this tag, stable teams automatically catch things
with Fixes: tag which contains a precise bug origin.

Reviewed-by: Eric Dumazet <edumazet@google.com>

