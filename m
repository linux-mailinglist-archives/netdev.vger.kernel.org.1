Return-Path: <netdev+bounces-73430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682AA85C5C5
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994061C21031
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE2B14AD0F;
	Tue, 20 Feb 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpelj1ld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E19137C41
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460890; cv=none; b=jEtggzmjw7mLcGO26xlLcSrAu47NZfd0jt6+KpUUl+b/Ca2dwg6wDWm5GKLaqMBe4C5VC2fzy1WoA1v58+zY67Ug6f40r9Mhzcy9EqtEULNeKWng6CyUb/JQ00m82IoBTiX/odKRKVJrq1OpZOaNvjLxZpQ8jUP2Bn225+GynjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460890; c=relaxed/simple;
	bh=GQgLIKlAdVvy2bFe5rPqskxClECIFYvAuoKNrBTNJoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXxH5RMuHZTEqp4xUDD6Ka/K5rJE/wjoVmqV/+nGB7uWlpxiSf/mIJCcbc/BFKY5eM+upQsSq9Zh3m6RJvl8G0p5E7sGcuUgAy2+5Ujn0LZxt2sUP9W7drsIWUZPwyXw3mbB3TexjKoxcqvxMVSip10nhO2DCVFeVjFmi6iYOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpelj1ld; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso98a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 12:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708460887; x=1709065687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGaXiUaK8268y3wgNrFs6s9xPNTz34Vb7OyBgjAlC2w=;
        b=hpelj1ldSajxkFyV68vWJPjO0Hx8V6FeYQHMz3MBvCtHkuwrcKjMbq4SVALwZ+eaNu
         5tPUPvd6efNPAnUyLY4QK8GnjLBiZabTKZjvtveXlS/GbILxloFKrCsTNGldUsXApA4Y
         UplHEWodJDQEcQdrwuhdijC4b+RwzQP1Y/sOFvU5Dzmon4ROqXTry1o9ZF+FQw3Iisis
         U/y4pTnxB5MG56Vyu3Arsr+r67P6G9PtGHaHLPl+cePtKYKcF2o/ErxESZM/hqX0RkFQ
         J6eGKRcD2qFlhygjj6H9Lz6XYrV56JSYjjoSiEfz3lQm9Rb+aI15w1JZfXhPrD9eOL8I
         AHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460887; x=1709065687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGaXiUaK8268y3wgNrFs6s9xPNTz34Vb7OyBgjAlC2w=;
        b=FG1rIi4jvovwIZDdBYulhA16v9s3EUWYBR3bwoqZ9sGjcUNurG4osGN0U2d45gv1WW
         AmgkoS1Smaqc9kbuSZNv9Ue48BMMcrKqJkX7c1MhKFE9MhCI0QzjM5oZP9rGWuAR2Euz
         S1hfOvpt1zgOMxFb6cNnWuYhL5YWgW64ziD4wz6hPAplHLsr9HqbFGD/CpJNnxKyOBYT
         wkuvdd2uSVg3l0+uAMkNe35bKXR5HB1al+Liqy6//fJyddu8mlhm1e1l6VRnLZgMZ4nW
         FOkBqEfU/qGVmF4HsDEu6WCApdQnYN6Zyb1FEIXTKqHRJRnLuaVE3JVAUg34mnwmOAnz
         8Mng==
X-Forwarded-Encrypted: i=1; AJvYcCUzxndtjXXo87Ey32ujg332F9GkfiDbxk6aofGvAinJuQbbG0/lk4YIxTjd04mZb4ZVNQUilPqu+b99ujIQfTgHR/ekvkBC
X-Gm-Message-State: AOJu0Yzpzc0ED2iEPh17wlDSI/OmbXLo4s6V9QXyr+0o3G0ad9Lv4wyd
	roX+scCCp2NhX86pfp5lTya7J3TLucNynRGsRws5MIoV6q8iD2keCj/iuOcFTPaDhITQAP5+zcU
	oBeWkn3fF2LlymiTcTm4feEHAZqUsbypfrdOPJy8064ohvK9z0g==
X-Google-Smtp-Source: AGHT+IEIikXe2VmtzrbXwjRpfcYozsG20/ERQHd1Nb/TQTs8Ej4z3xPBzL0OjxdL3tRST2abRJz+I4A7+vc+kXYT6m0=
X-Received: by 2002:a50:c048:0:b0:55f:8851:d03b with SMTP id
 u8-20020a50c048000000b0055f8851d03bmr23995edd.5.1708460886408; Tue, 20 Feb
 2024 12:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216162006.2342759-1-edumazet@google.com> <170842742563.6347.16360782364826312051.git-patchwork-notify@kernel.org>
 <5f421a00-bdf1-8cae-bc18-24312b22c0eb@redhat.com>
In-Reply-To: <5f421a00-bdf1-8cae-bc18-24312b22c0eb@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 21:27:55 +0100
Message-ID: <CANn89iLnA7h3gzFN1_ck-UAb_-hOL9gDmNg057R8c4LZtGRwfQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: reorganize "struct sock" fields
To: Jon Maloy <jmaloy@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	ncardwell@google.com, namangulati@google.com, lixiaoyan@google.com, 
	weiwan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:21=E2=80=AFPM Jon Maloy <jmaloy@redhat.com> wrote=
:
>
>
>
> On 2024-02-20 06:10, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> >
> > This patch was applied to netdev/net-next.git (main)
> > by Paolo Abeni <pabeni@redhat.com>:
> >
> > On Fri, 16 Feb 2024 16:20:06 +0000 you wrote:
> >> Last major reorg happened in commit 9115e8cd2a0c ("net: reorganize
> >> struct sock for better data locality")
> >>
> >> Since then, many changes have been done.
> >>
> >> Before SO_PEEK_OFF support is added to TCP, we need
> >> to move sk_peek_off to a better location.
> >>
> >> [...]
> > Here is the summary with links:
> >    - [net-next] net: reorganize "struct sock" fields
> >      https://git.kernel.org/netdev/net-next/c/5d4cc87414c5
> >
> > You are awesome, thank you!
>
> Paolo,
> Do I need to do any changes to my SO_PEEK_OFF patch?
> In an earlier mail in our discussion thread you seemed to imply that,
> but I don't see that any changes are needed.

Please resend it, and do not forget to CC me ;)

Thank you.

