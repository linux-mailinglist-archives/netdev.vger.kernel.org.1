Return-Path: <netdev+bounces-222233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7408AB539F6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302F7A057C1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ECF35690E;
	Thu, 11 Sep 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZ4J2t4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3C342C95
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610435; cv=none; b=r2O8vLxiMZLTqF58Hkvezp2HIwffAolCocLf6couhjoryAS+qu0aqawmzSfT9jZnaQO/BaCv1e70h8IDH1Nmu2bsUFoVoGqC6DTmfUXdTKlFuaBfslQZx9ZcLkGcWDedgF4IykKgJzPCbvJiARqNXrPhdX4GuJs1oOz5GeWjtPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610435; c=relaxed/simple;
	bh=fEpW62jK2Sh77DG1A8A7TKupnGbqPmS6QdF0VNXKVFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxUQI7axVaqV4f8V/Cn8Hi1BmWh85uodEUcUZOq0KZ8E3sef5A7Y5q+diI905FWLi3g0t8yGiDMb1i4Bsi8SOHrLjga1ecYof7fSgEYYOLbkxHu01oxb5i/bu8N0r7HI3YMt7EZvs3f/RbsaU5nSniVvW9tINDMQCjBm8aEh3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZ4J2t4t; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-721504645aaso8719626d6.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757610432; x=1758215232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T/Ui2R0DGVS2yNVSbOVkh2JfanxX9/R3OrXADazbUg=;
        b=HZ4J2t4tfx+gm7VfC8oC0CQJS7CedTDoZypkLujMbIQzJZYlnbFRJSkJx5nOf3M62O
         eBT6d9B3CCe0VVX7QQGBbViVYOyIQKMNRC/dL1P0GJr4ijkru2wbFs91KQ7nmht3MdcN
         qJ2cLtAJCZwv9tlCTo0aBlbvzsC6e/jd/vNVyq4ofRbogMCdGjBpOgmByIwQ0qcKcx1U
         Nc8+IHvjP08fjK4mMf/6lF6laC0N109Zd/5/zYpESPXfJQTQOCURaC1HjHC7oTzlOwx3
         ih7AsjR8qqlc7QJCQMfvpStUr9wApVHki/3z29ldeHDo7IOnoq6KPcfJi50YlUXz+kMR
         +jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610432; x=1758215232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T/Ui2R0DGVS2yNVSbOVkh2JfanxX9/R3OrXADazbUg=;
        b=vJTRme7u0gK2F1Pr0xqT99GB5nPL638NNoV7unRlF10CArjoSQZzkJJ7EHwNAYQyeg
         OYE+QJMjCpiadxpvMOuTFrNiRj9ed8zH8Vcev9R5pcXzueGwV+Ok6DxA8ya7lbXCrWyq
         kVnwqCTdnPKJu7TjQKcrn8Sx1iR9H/4o4tgnfAcyRJNPgGEZaF//WR8QJcv4yhsZwU7p
         kj02xxgq2kgkdfFu2Ckp6V0rTlt5ZUEsYrBQWeMnIROe5zNQCupj+MLxhkAbs0Ehnqlt
         alLgg+iAeMmoDzzDAUijsaDXJGrhubzsJTpPwucfY/2pywz89q5tjYvjiqprNVpt+x1T
         v20g==
X-Forwarded-Encrypted: i=1; AJvYcCXM9tBM3lWznWe5Zy+zrZHiuklqL6BHMqD72bIQth8WFzMjAxSa59Ln3FGfgtX0+GY6L+q2GUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPRJwARWmRdTp5Qc5hDYNZXdTBrM9yAmV/DIg7C9MiJ90Cs2t
	/NnCiO7AVCvwXh+cbukLebTIhdkSyDW6CYQUMgthsxqWPYaZHrDMmowKvYuhHJm0gxU3mtlupAt
	NvyufmKh6p6UIwwwNtkVStibDQ5nFFnvoudv3dVXJ
X-Gm-Gg: ASbGncsYi0ob55hwHWsC7k6Xn2EmzT6g8tl7zztrjxrhqAnAkON/TFy/nnOBNgUC+TH
	FBcy7CSxXHZgj5u6FlfBE/+8RGMy+VMN2+0H5hvpm81m1CT7XymwyV0ezmosCnYPDoAyX6UQ20E
	kvQ2aS3mnTnHN4zYwXbf5QCIP2sECJEio9bl6IfvTcuDjI5j8tFWox2Bl091CJaSOjCuIUfos0O
	AbGimRxFnf4Qds=
X-Google-Smtp-Source: AGHT+IGpqc0Y/UOXLyivlVz0Odxy8kQW6uwYbptjYjJJV7+Juh0TcCJISrIDwNfG+cqh69bA1LZYDg1z7fQ+SqYXAAM=
X-Received: by 2002:a05:6214:e48:b0:764:96db:fe6a with SMTP id
 6a1803df08f44-767c1b99894mr951546d6.33.1757610431455; Thu, 11 Sep 2025
 10:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-7-kuniyu@google.com>
 <CANn89iJnOZ-bYc9bAPSphiCX4vwy4af2r_QvF1ukVXF7DyA4Kw@mail.gmail.com> <CAAVpQUA3cnUz5=2AYQ_6Od_jmHUjS0Cd20NhdzfDxB1GptfsQg@mail.gmail.com>
In-Reply-To: <CAAVpQUA3cnUz5=2AYQ_6Od_jmHUjS0Cd20NhdzfDxB1GptfsQg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 10:07:00 -0700
X-Gm-Features: Ac12FXzzckbGdICo4U-hFl06y4dO3sPJMBfxAsYHac5VurS3Nf3GlXMTmBcsYUA
Message-ID: <CANn89i+dyhqbd0wDS+-hRDWXExBvic4ETm1uaM2y1G9H4s69Tg@mail.gmail.com>
Subject: Re: [PATCH v1 net 6/8] tcp: Use sk_dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:53=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:

>
> Sorry, I missed this one.  I'll drop this patch and send the
> series to net-next.
>

No problem.

Main reason for us to use net-next is that adding lockdep can bring new iss=
ues,
thus we have more time to polish patches before hitting more users.

We also can iterate faster, not having to wait one week for net fan in.

