Return-Path: <netdev+bounces-69678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C384C27B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C51286C4B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDE7DDD4;
	Wed,  7 Feb 2024 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLlt5EIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9927134A8
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272670; cv=none; b=jgNOY5BURlL9IBkCUKqAEeFe6mZPMN0/SpFnUZQwIJDPJplhfIpJv+Zx2suqhFjvyy5D5z7U0t1T3kxzYwU+vsN3YTi/b2u09IdGCkUTHYrnThWlsqvrsrTheo8zMslfdSbozIBNOSB1o2eMl23VcGsPphxbJ+9xf+NgtByeRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272670; c=relaxed/simple;
	bh=Wr1cSZmWUevh1p4qQ9I6SDYfX6Gybu59uC8rTDv8ZEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+s+Hp0MACfuRT1wGGFLWpefyxKillW8fiOMZiuKjgcKo5tLa+prAr52GWHfVR2dVB4OKBliMfy3X5Txjk6o5wmZdPLPuk34UAoGxLhjiJ5NnMq6aDLzttQ4R96QjreU1lawjcBqoq+c47omxLx26eyiYWJ7jf9aEioGlPN2rNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLlt5EIR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55790581457so143391a12.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 18:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707272667; x=1707877467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLmc1Qc1yNuECN/M/DHNgea1UKbbefnp3y8K+KzNOkc=;
        b=YLlt5EIR6TfdHsQhkLZkr1esNg7uvqXHSmJ3U7RYfGkOeNIHXest+dLXGq5/Fh+vjz
         IwQ3KaB9LXfmc3V6HLtPw0dxAlpX992sUOtHQZNAWHK1q6JuyclqxY4K8T+fW3j4kqg6
         iOYZYIs1OpfIJavyWMY9jflb90agLpPsVt5nYM45PMZJABJmu/npRxD5gOYYwFLdVqys
         vnmsEvaF/b7/j60FZOxoEvMBliLpvgHeb/7ppE6NwZF/nW0Zx4pEn2jiD2m4GbwqqsuQ
         uvORtVeJv0j/PytC8jykxDNB0xs03zB8dCgq/JGk3/rfI6X8fqyLmmg8OapTFiRwvMJE
         TaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707272667; x=1707877467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLmc1Qc1yNuECN/M/DHNgea1UKbbefnp3y8K+KzNOkc=;
        b=kMMWDQyxvY8aWaqRehfw2JEyeD9s6PG03a+T/e4wTAaGjY+DMJBalytdHb5gXg3yz1
         l6VbaL94Wtx8RdL6Ma0PKn9EBLqkoIoJ4GRp9E7i8qiqO5byix/EBpmWOup1V82o0SkV
         RyrjajJvcxBK4WzBs3pJf020iTrMlvMm/KF9PmqE2Eb3Cfyh+7CVXjmwRfhONxrFlmGm
         sGiP7EARpQ/bb6SPID+MIM8GctRREcCyMUDXEeLiH0WAPfH83ObaSZOc3rZYudOoz3xn
         pA3xTrSXuEndF5wlljoSVe5LrewylgIh0ZzeD6tBk+vyL+upQQn3ThLSwF3WMMX+c39+
         neGg==
X-Gm-Message-State: AOJu0Ywp1oLJamjw0ksp1fCKLrXs9bi9ItdnjnOdhQ+0DbFpJGKKPULE
	QrqFwvi+vZOOlQDIZeu5/HWX4PhTBapH3GVxsgbeBjBlSlAlNT4E0btO3cOaG3pNNcGz0Rg3ybk
	fsGXLBxvL1KYiuKDbtkTFnYKumGk=
X-Google-Smtp-Source: AGHT+IGU7wbrq7EVDNueY4gk18lq7wJQm3Vhj03fApg+zb3CFcQA6ap4Mo9vXpIF1xx2oKpm8ByX0pE1A8pEWf8dpiI=
X-Received: by 2002:a05:6402:715:b0:560:93b1:a351 with SMTP id
 w21-20020a056402071500b0056093b1a351mr3016151edx.37.1707272666976; Tue, 06
 Feb 2024 18:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204104601.55760-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240204104601.55760-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 7 Feb 2024 10:23:50 +0800
Message-ID: <CAL+tcoCZG=SCPZDd3ErxFCW6K8A_RHaYR6vJTQJB_BOkhsg-JQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] add more drop reasons in tcp receive path
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 6:46=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When I was debugging the reason about why the skb should be dropped in
> syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> general. Thus I decided to refine it.

Hello, any suggestions? Those names in the patchset could be improper,
but I've already tried to name them in English :S

Thanks,
Jason

>
> Jason Xing (2):
>   tcp: add more DROP REASONs in cookie check
>   tcp: add more DROP REASONS in child process
>
>  include/net/dropreason-core.h | 18 ++++++++++++++++++
>  include/net/tcp.h             |  8 +++++---
>  net/ipv4/syncookies.c         | 18 ++++++++++++++----
>  net/ipv4/tcp_input.c          | 19 +++++++++++++++----
>  net/ipv4/tcp_ipv4.c           | 13 +++++++------
>  net/ipv4/tcp_minisocks.c      |  4 ++--
>  net/ipv6/tcp_ipv6.c           |  6 +++---
>  7 files changed, 64 insertions(+), 22 deletions(-)
>
> --
> 2.37.3
>

