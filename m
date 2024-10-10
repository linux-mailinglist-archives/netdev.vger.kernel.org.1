Return-Path: <netdev+bounces-134227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5CB998736
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA261C22C1E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129661C7B6E;
	Thu, 10 Oct 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iav6r1OQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A11BE245
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565830; cv=none; b=iyhiwoSOZdrqsDGrZhyeprcA/Os8bPJCMSYlCRGc1GNP/bfhJybKMfkvAxqrCgi9+byvvxhLyTRXpSDF9PP4gISybxXzfzQFQn02DrG9jb3wPEQi3WaWMe6SVoqjPQL81tBGp9cYzkOVp1LhpF8ZZoef2Kb5V5vQB2C8ZD/8SmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565830; c=relaxed/simple;
	bh=yGKKqzECFJIXz9sYW+kpZp+UfpWWzxZhqt6ptkQ65I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiOZ1OMcpuyPd8tDKirUMHljUIoZ6939PkSDJ+JXy4GLXooPLSVshhk81wj/4rXchxc4RRZs2cWhteK5tsuY2bDaM86porrX728/Q4MPU158iltWP+Q2wtsYKtsDvDt4NED6HJfNJaEUVspNTyKLJZNGYvu0D6AFk0tRaT+E9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iav6r1OQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c928611371so1203932a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728565827; x=1729170627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGKKqzECFJIXz9sYW+kpZp+UfpWWzxZhqt6ptkQ65I8=;
        b=Iav6r1OQ1nk4cTfWLJ9ThQ9lKgkBcRx0jj1lf/oqSZYZg+Ym0DzTdT6aK+jsO8QWVQ
         mkiCzvqEzMMitHH3rCHiGch1ock4HMq7okcwyjaUJNkFTthCxncVwdhoDSC3salPfZlQ
         95Smci9Hz//7bGFC0W+o9fENkaWM5PTLKgvA3vJ83SycZkWKSsyQrPqLHPCBVX0KlIIy
         fR7QVaTp68TYOwtWMRdvI9qqH37ZKepS0ySa5Y5P7wo1acEd/hzyWx2pELzziSPIzXCI
         8RgMC5x2gdbknb/Vjd/vHX7CQ304FP4TrRknPAuoVlGzdi1tupFrIorcrSrxzfeBirnO
         8mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565827; x=1729170627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGKKqzECFJIXz9sYW+kpZp+UfpWWzxZhqt6ptkQ65I8=;
        b=w2txlTPWNzaf6Rp+AcgyKrOhF86cXJvTbEVTYzU48nEB9M3GcsB8qyHdKt43lJeb7d
         bfvNUUvUZpf6K6KQX4W+dkONwPELuEB4mXTaPg2z3i/hInPh/YzZ3j0KXfcGsyPliMT0
         l7+VV++JXYuwGv1KVtTkDh3vwBbzU5j3MOhrMH6HRImUSvV1HTV+I8TwlNfz1Hb1/LWP
         o6sAlVZJv54LePzj+GZvJi5GROJVnLXUHXV4TP52IVWL3kWShaKd/bfS3Jj9xjGAy93Y
         wAAlZCM58X0vloFwB41ha8p4/F4PsOYi9mSdMfXv2LCJ1UfypHnIAEL4GPyGDalwkf+Z
         02Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUPq1hnE5V6/CdTNhMAJWnHF7Ed6zJaDKN3/qehl1SjTeDXRcgP88oH8Qr5SDH+uZV41wtbkcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqMzhauVHa7PBLialdQvTpY7xhJyqmzvRzzl7Yx8hep6dpNWj
	KxXqpf12t+O7JRZGX06YJTO3C7NBcicvRJXSF1RpfX7V0ygKX21XMQsvmZmz/q22GrknTOMfNj8
	vrjYxVqvKpfmtLlrLbKPP6Q5izgcU7ljxCm3K
X-Google-Smtp-Source: AGHT+IHM3DBbjZt8QCqh/ZxFY4SFFR5F4yFchbViA4jWffYA3jHxM5W+O8e/3iqhkd8vWbrm+2mtby5BFW7rC65JyGc=
X-Received: by 2002:a05:6402:550d:b0:5c8:7a90:6a71 with SMTP id
 4fb4d7f45d1cf-5c91d58c718mr4861148a12.13.1728565826383; Thu, 10 Oct 2024
 06:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-11-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-11-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:10:15 +0200
Message-ID: <CANn89iLqoEPeWBpDC4BZPgSy_5ocdfDp-Gj+MnnY_vcuqOrkRA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/13] rtnetlink: Clean up rtnl_dellink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will push RTNL down to rtnl_delink().
>
> Let's unify the error path to make it easy to place rtnl_net_lock().
>
> While at it, keep the variables in reverse xmas order.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

