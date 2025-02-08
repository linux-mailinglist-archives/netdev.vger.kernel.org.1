Return-Path: <netdev+bounces-164384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C860A2D9E0
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 00:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E357D1615A1
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393271922E7;
	Sat,  8 Feb 2025 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihBwHBaD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D45243397
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739058501; cv=none; b=iJVU4y1xY0wFRW548aFp2vqvblj9Z+T0W+EeAFP8PUuc/KqH/1o8q2hvhTi6Zp/UeBqpGJWudl63rv60lbJJQQpB8mWtc5PnUeXtfV68Bz0zIeuMTIn88nhnZNZEYyrta1eWY+/DYdI9G5nlbY+qV/x4/ABEF6oSGd5LmpJf3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739058501; c=relaxed/simple;
	bh=Hn+v7VNDlo9ZORpoDe8CpLwwNf4GcRTowqZoVFdxJ6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+2KlUB1+nOp1CnC3SvsgV+Y7whL8AUUMjzejgoPpBGyddcNLb/SsNk2J0Zi8mtIf/8IcQF6a2kIZnhkWkLnIOBXWs8VWd5zIi3kSgdg+dIPDUocSYVkcLRoT6j+sOmiYxIbFpiuhEszS5LW3jNYPIyW/OZg4I6Qc+SBRfbcdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihBwHBaD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4718aea0718so17871cf.0
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 15:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739058497; x=1739663297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn+v7VNDlo9ZORpoDe8CpLwwNf4GcRTowqZoVFdxJ6E=;
        b=ihBwHBaDDxlhB0cwIZuPYYRaZelUoj7QEUE8fM8FUlHMuWSa2mLQ1D5e2rs6yvtmVt
         Eh86WY9e3JwausqwT0wmcQsqRQg2cm45GOJk2Ue9USSUSosnpOJeKw0XeAImxDoy0g2s
         4dxrgxsePhgpknwllmiVtkrjEnR+NuVwwP7+mIw+icM2PwpadnJYamTMHyOS5X+qq7yL
         hJOTVXX85NQiytFaj6/81L8E+Qob74i8g2EqQOwPohTvgrc7XOvW7tgsHLW2E4+RgQJ4
         VA+zREY+cgIg8i8nFtLtZlLxSnZz31uOoTg5UWZxygeso76eq8lKvRVFyq4i4DIOFQ6a
         X2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739058497; x=1739663297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn+v7VNDlo9ZORpoDe8CpLwwNf4GcRTowqZoVFdxJ6E=;
        b=iN7uXpWZfiH/Ecpz35dSS7F4Z8VbwWxTqYcH84bPRWZZtGtJzUG7rFnq5a/khMSxoY
         eA7/40tGHkxQOlUtfLRH4235USc1oJnzCOv26Mvm7lKB4GfGlm++4M1Q+YCk+8/tgfKg
         iv7FtHsgAomtb/tVsJdFOzAmwwDyPEcIxsJuo0duOsFFbpqmpt/b6e0CvD1mxKh8szqz
         kL5oWXKrJmL7Qroys+rWg6pLyEt2fzi4HUax93PdMbBTCMN6WXyUlyb4XjXl5emx7m+c
         /vnTL9pBH0AuNhpVrMYUFH6yxXakoDzlfuJNRSRIB5H8j41H5k3jKHQFzXnbEom44lJV
         SZWA==
X-Forwarded-Encrypted: i=1; AJvYcCWWWEB3NsCb48CPoCyDYBqP/QiE6LA+Pmap+W+mFjrOoM1HZrqMt3rgfr9WzQLmZAQXyTJPWzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyhaUJX0OOhLDzRh05lEzVRrPsnjC2f1WHoBMrUbQgulrPunr
	7Cg+WaJJpBcQlhtvIsTDhgti+HM87BBWHcgUfJsYZEcq0BDptuWIGOJ2Q9sxON0nfZ7BKpquHZ9
	/mzBMkSvjMBRNoeaiXKyPmk0pvwX4CTG539z5
X-Gm-Gg: ASbGncsqBQTHav2uTOWbFPkL782azpuIjwzJQatQ6QuvSZGPh4PtFjMLp9g/08bRKt9
	1twSagsR7Agqr3zS8jGzQdkh6uoZNpY6deGEqEZsLjsKfHkVIiKwvMXJhVzZ+EzexDGzJFt4=
X-Google-Smtp-Source: AGHT+IGabzJoroKrtEqA0IQgFTYMX8t1Gm9G7nTckfxiNYJtDubpoVDIwix0UkGU4KnjZToIocgiP9YEqOGKRlHS39A=
X-Received: by 2002:a05:622a:590e:b0:466:a22a:6590 with SMTP id
 d75a77b69052e-47177e8b82bmr3046551cf.9.1739058497198; Sat, 08 Feb 2025
 15:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-6-edumazet@google.com>
 <CAL+tcoDRCu48Dbs-T4-JvBJ4kVnbT8peK5RhBvKv11HwmR0N+Q@mail.gmail.com>
In-Reply-To: <CAL+tcoDRCu48Dbs-T4-JvBJ4kVnbT8peK5RhBvKv11HwmR0N+Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 8 Feb 2025 17:48:01 -0600
X-Gm-Features: AWEUYZk3zrPcQ5w6pDowZ5FU3b6utXjLv1G2jCxMIMvIdr-X-ZLyqgO8NryI6p0
Message-ID: <CADVnQynosa9kG3dg6vOsDYLaHWePv4OTUsAm5wGPn4O3rQbxaQ@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] tcp: add tcp_rto_max_ms sysctl
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:46=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Feb 7, 2025 at 11:30=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Previous patch added a TCP_RTO_MAX_MS socket option
> > to tune a TCP socket max RTO value.
> >
> > Many setups prefer to change a per netns sysctl.
> >
> > This patch adds /proc/sys/net/ipv4/tcp_rto_max_ms
> >
> > Its initial value is 120000 (120 seconds).
> >
> > Keep in mind that a decrease of tcp_rto_max_ms
> > means shorter overall timeouts, unless tcp_retries2
> > sysctl is increased.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

