Return-Path: <netdev+bounces-165553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE9A327C0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C78188B252
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A820E6FD;
	Wed, 12 Feb 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+aGQ8bR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056F20E009
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368548; cv=none; b=LPeynBR5U8SGwTYmDt07rb1/nLFuk6olns5bLD5MtO5LAJ1VgMmJAgCoV0IuXI29IQRo270aXKQpynduBkpI0vc7+cC/Q1o53AqmIfuL8V2JjrAmAtb4BTmqMK3VwhAE6zn850BGrLeC8BXGnI1w/cVIyT3qE3AyF3tDm4VBw+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368548; c=relaxed/simple;
	bh=iwro5pnQbEbWIK85TV6ZI40PUauO+7Jk1ypG5Ngq6yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVo5DsgNK5nUMfEfwagJOjYGP0dI9UrIauW0Xsmcjb98hXVbmCLZY4sGPeRgPhofM5p6rhnULCUyKGRZyfA29J5dJ90ukM8SLwBoEnaBlsh02+5LuFBr+jT/abivztbxt8Joce6t5UM+oNrXFqGqqPct1dcB8gShX9BEpkRiBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+aGQ8bR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso12897927a12.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739368545; x=1739973345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTEY7hDBvPI6Kv5j6bPlzFTu8MO8K3mXBtKEqFskLv0=;
        b=U+aGQ8bResHZS9j4Ucj5foqpwMe7PNKjbsdUU5BW17kk4chmv1jIFZW53L4kyVlcyH
         9USTfQ09sIbwmh+ZFJbWeTMQeUnayyPrfUCTKh5iLXIuJbFrAu8R0wJ6tstiHoMUp8sL
         qfFfeRD/YXqUzwKMTTE82yBmnzpCCkMPsoL/RWJ9JW61Msis3w87fscN89ta3LL54J4S
         SUwS4IXttqwoJFpQUcKXmoW5xTqk4k8CxMe/eYoAVOo4YT6Iai87FqQL0LWtPqMa1uli
         soWrL9Yt1xpkHlAFUGP2eVbeXNS4Xha6JLBFukIkUhhTY8tn+vbfVnOBDtt/sUzK+gtZ
         chiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368545; x=1739973345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTEY7hDBvPI6Kv5j6bPlzFTu8MO8K3mXBtKEqFskLv0=;
        b=pRH4xlYBtW7MwfA1KTa6ebqNj09gBl4lYPjLmFxfXM6zJwIEMC0D/rs5+LF/PzykVr
         FcyiqlD9awPpJKqAa1OzRJG4k+zEFCDivTh+vduleNTT6L8GBjYAR7oylvTDw5F1jIwX
         EE4Jv7Gtah2G2Vj6TWJD6Ce3O+bpVWev1oq2dkKvXBpK3Z5F5A8Vlguy/gRZp6DePwtw
         sJeFoTxvJXeJMxTkyDxdB0r2M/iXtFs0oxMqMn0wuK7tETahTaNt7B6k8FpdgytQoI+p
         QAhAccYtDVkg41wRk8GlrzmVWRmhHl7joIxBba/rJsot73PMWny/4sFveF4G9OwIwvVI
         ObzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGDrGjN1Mc6Om9PY4F9UJGuziglM4bjNbtOIFTM/oqBoXm9hzIlCcwSWuhrjhFitoo257eaR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybyuTohoatI3+MQxP2n9KZqs4DiKgsxWa9kYPrFFTWD8YyK/ro
	/MGhLy+fy1QbXjxEvHUmgKw7Dx6pxnRZjoHjc67ZBxjZ14JWyHtJHsZPXaPvsNjgvPSFOtNaH6z
	SireozW2zzY4TlHQFWTO01TbRhdwuv5NTtK5V
X-Gm-Gg: ASbGncurPvLfIPl3TdMEwEKs4ieVbYhQFDor+dnww2nVuNP0C23niNFdSAdVkrHnSyF
	m7rwh+WgvGe/kKhxK/z7ler/UKm9Ph7+5SZg91TNjH5nxNKHTGRNue/jSVRXzVz5dUPfdyt7sKQ
	==
X-Google-Smtp-Source: AGHT+IFU3ZGU5919c8uB6XOCVCwUjSaNGia5sSxQXhjCgDPgPqL/YgraQ2hbegzVohRnoCeKbm/XulfZaPiL3qcZUJg=
X-Received: by 2002:a05:6402:40c4:b0:5d1:f009:925e with SMTP id
 4fb4d7f45d1cf-5deadd9d246mr2763866a12.16.1739368544610; Wed, 12 Feb 2025
 05:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212064206.18159-1-kuniyu@amazon.com> <20250212064206.18159-4-kuniyu@amazon.com>
In-Reply-To: <20250212064206.18159-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 14:55:33 +0100
X-Gm-Features: AWEUYZl-lB5RLSwXRr44x-i1-e4KdvtqVoRQZwFboeJepc67CjAy4E5eyt39RJc
Message-ID: <CANn89iKAKfW36RdwAvvSogLPL52bnLhrV-PKz_u7oJ8GrL4-sQ@mail.gmail.com>
Subject: Re: [PATCH v4 net 3/3] dev: Use rtnl_net_dev_lock() in unregister_netdev().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:43=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> The following sequence is basically illegal when dev was fetched
> without lookup because dev_net(dev) might be different after holding
> rtnl_net_lock():
>
>   net =3D dev_net(dev);
>   rtnl_net_lock(net);
>
> Let's use rtnl_net_dev_lock() in unregister_netdev().
>
> Note that there is no real bug in unregister_netdev() for now
> because RTNL protects the scope even if dev_net(dev) is changed
> before/after RTNL.
>
> Fixes: 00fb9823939e ("dev: Hold per-netns RTNL in (un)?register_netdev().=
")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

