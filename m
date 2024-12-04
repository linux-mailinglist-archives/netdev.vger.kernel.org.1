Return-Path: <netdev+bounces-149119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D849E4484
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 20:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B637528419D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EEC1A8F7A;
	Wed,  4 Dec 2024 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpUE7cDs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18925188724
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340170; cv=none; b=YY8iGUxT9j7AEvlb3c172QqVhUXmuUJm0gaExYrOYRr2yvtEHmKIwYM2wjDT4iI1gxfRhGKuXEoRbOI5e2w12Qb6S+YmcEdhQfqxn0Uy0RtoyXs15lu/pA2j0Dn4XK6ZIY+0eWGoTUgKuImApldBuOMDtcgCv4Efq+eDLFDCwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340170; c=relaxed/simple;
	bh=U9MhgtAeffgz+oaC2mlq+05LKyQ195Cfy9Cv4ozv1xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCKfmnG//GBY6+Fcsxkx10MrtaHBh9F1/h+KSPWVkIQYQhQ2joet1HPNwE2i1NLR41/b4ffM1FLEpwgF1ApqzrGLP+IPSAAaJ1NV+BUsqGkWuXymthx1C+/NZCoL3FSac/U9WGHJ2LxG3Enn+kfBqP3NFa/i1bX37Vqob3/UrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kpUE7cDs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa5500f7a75so11716166b.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 11:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733340167; x=1733944967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuQXhHT6k3Zp8vvS2h+zCPYZPZpH3H8+6qtOn00dwzU=;
        b=kpUE7cDsurERAP/sbB76S6La5s0ZM+YZu+qhzhf9b/b5ROhuo4um81/4mBVgin0KeP
         Nwg0qiSJFbChRFUoCWjvBnQ4uN2wQrLZ3MuWXdmRIUnFc6Vvjxg9G0OVQv5H/J/Ck43c
         uF3jsz8ycnhv+X7qXKd+7B3SOX2rJy53RyBolyBb738ScLh8N+F2omICP1O953iY/6zk
         iHFC8PpnfT9jj+5ZU/K9nkHM0BW1WFC5+XvOTGQjkVPWFi0cc6mzpDE4EzW60nMvTYwb
         AnqGqYAwlc8wmxbJ8X5zA8qKp1xFZ1NgG++lcblN/QH7uqCIMtEW3UjZ9xrdPnvYSvA9
         VBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733340167; x=1733944967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuQXhHT6k3Zp8vvS2h+zCPYZPZpH3H8+6qtOn00dwzU=;
        b=thfeCoAzoiYLcspzS6Lv+9PSoIQnB8qHNQrySbjA1HkRIx8fDxzBTT2pYjJ7mWCAYI
         7BrUGHJCtjfGhUuX7x4ixndMEje0TPcKxB3GHR5ps3/pcvmWov7ieo97BUSKN8LQEU3c
         yf1ppKOwc55gD/p9vGUyaBxe4fNPSqvh1voLvWILL+qBocCFPW/SIYJEPGABxmoxnUVR
         +H56RXh/EyGNd5hU3Oork0O2P/bsbhP3JLFho5YdZtk+5iCVUCNCdd6OnFFpkmSLyxJO
         JvXSHHkC0b9+9oSXBZuIGpciQZD2pF71jnisSxriuXJWodz+9c3u28cFR1JuqhPGhudP
         qN/A==
X-Gm-Message-State: AOJu0YwoOniSddXAu5oD0YxSv2odNDsqrsPKb36+1HU8ZZKUXpIIAg+S
	B4tLOvowBSFBV30EIGegO2kbiKEgGHQJxEQ19R079/q2F9ngorgXeraO6u5SohHQdmy5e2raPAt
	3QND7mbm3X7uI3mvXFYoRMCgU3LBlUostYMmQ
X-Gm-Gg: ASbGncuWW4zp5GEsdh83YPlKksWp7y/1yEFBRpkrl6DTzmHp9SHgz3WjqGOz+6JUWLV
	NGtroIwCeJT3FJMLadr+jd0O7J3a0Vu6B
X-Google-Smtp-Source: AGHT+IEcFt8n2sUWMMh++hz/kCqbtKVeSdHWuWfpvfwcZ1HSvPh1AGuir6VFsYZNsQFJrohXk6aXBnotOdRly0mJTik=
X-Received: by 2002:a17:907:5c3:b0:aa6:5ad:9a36 with SMTP id
 a640c23a62f3a-aa605adeccfmr440723066b.4.1733340167265; Wed, 04 Dec 2024
 11:22:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-jakub-krn-909-poc-msec-tw-tstamp-v1-0-8b54467a0f34@cloudflare.com>
 <20241204-jakub-krn-909-poc-msec-tw-tstamp-v1-1-8b54467a0f34@cloudflare.com>
In-Reply-To: <20241204-jakub-krn-909-poc-msec-tw-tstamp-v1-1-8b54467a0f34@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 20:22:36 +0100
Message-ID: <CANn89iL5oE79_qtNUFFsyxLXoJALJCZgawsubuvn1XOcOuOzFw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: Measure TIME-WAIT reuse delay with
 millisecond precision
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>, 
	Adrien Vasseur <avasseur@cloudflare.com>, Lee Valentine <lvalentine@cloudflare.com>, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 7:53=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:

> A low effort alternative would be to introduce a new field to hold a
> millisecond timestamp for measuring the TW reuse delay. However, this wou=
ld
> cause the struct tcp_timewait_socket size to go over 256 bytes and overfl=
ow
> into another cache line.

s/tcp_timewait_socket/tcp_timewait_sock/

Can you elaborate on this ?

Due to SLUB management, note that timewait_sockets are not cache
aligned, and use 264 bytes already:

# grep tw_sock_TCP /proc/slabinfo
tw_sock_TCPv6       3596   3596    264   62    4 : tunables    0    0
  0 : slabdata     58     58      0
tw_sock_TCP            0      0    264   62    4 : tunables    0    0
  0 : slabdata      0      0      0

In any case, there is one 4 byte hole in struct inet_timewait_sock
after tw_priority

