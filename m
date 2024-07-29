Return-Path: <netdev+bounces-113641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC193F5D5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118C4281D6C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC0814901B;
	Mon, 29 Jul 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQ3TYA7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1D1465B4
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257220; cv=none; b=NUR/ir8ji1ij5X3RCFIMbJ/aKdtyRZqBUF0FCEHVjhkjD7jpvhdtpJdCLaC9TOU99Ome4vbHTbmC+7Jbu2KeDzvl0uUpVtI665/BHWIx/H9zcaMcQeAPVUhl7mLcaqJt/PUBhThlGHr1azTCkD3GGzARCwaXvSpwNYeOHtNeAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257220; c=relaxed/simple;
	bh=Em17AH/p42DHF2fSyDSbIKlzj5GnwamH4JLD+cvSG0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6Zm4Alorrg53m6zlJImzOWJOo7VyD+AI9EYqkEx1BGRjKURmE3jLh9qtobjQli7usszWLkTaOWSwDi/qHa4FSwyv8NvTTPxIokV7nteIlq4TLkLNXmX1HxLh6I7orTyoEonunee9qynd51lFQnnQH330d0jg7+6FWRi2sVREPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQ3TYA7U; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso12074a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722257216; x=1722862016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1ft8bumXnUvS+hZHtMDMqF7eb19fV3Q5V8+d7TpDdA=;
        b=AQ3TYA7U1ldaMMAMFrqd/YAU960dr1BTsQ+nPSVN/3KmRz7DgVIPu52P/kmrZ/AA3A
         CiRo79n9cmqc/VEb2xTncI0R4wtlZD/5ZetG4pcVS3hBtvC75e0t16CKfWxxxaOAj+5f
         SqTJUDnBRblBjjGKgGMXlA1LqrFKCuvq3JbSkciSeimM36WgYOq56jnPI8kS/8vQh7gP
         s3P3PhthRryaN3XZcnHKWf3lHgk58cqOPYyLir49O/dXb0yc/vgqGQWuT2eK8qyH6Ujh
         dJgNJZNnZFnpxXiFe2sI3G+sN0Yy9Xon42/hikWwORnRn2bfHvCYH0+h+XKREkGC3LEF
         xKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257216; x=1722862016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1ft8bumXnUvS+hZHtMDMqF7eb19fV3Q5V8+d7TpDdA=;
        b=DgYg3wODv9MAlI++9YX+Vkb+HQXBxZb9qMUu1ZcUQagNildz6owgG4PDmaWjY+LXa6
         PdHDs7Z9tbB62P3HO0PonfAtVPAAU0jN3D58wveLG6lpCfuixO/xB04GYoW9I1pJz8p6
         JWxAHcRvWp7xPwgxeoj1NOztwpDAx9AeAbtUmLneqBgmuJBsFRFhi4UAXLd92f/lTEPU
         zjUDOzlIPyH6RJzMbN0ZQ+j0nmWZj2DlnMPaAXNDHq9Rry5MeLmldzu2sFQmjRoSfig5
         c8us6sKMv9eq8BEQ+OMpG9jin+W2JRNrt3NYVCUPtyU9C9Wzh5Vul1HahPbOcJ4/qAXy
         NyeA==
X-Forwarded-Encrypted: i=1; AJvYcCWJpSyORaAyytD7DIe01M1lYJEoLBT/TP8ICOAuv7JWKYsC1JOmTWcnLS6QA5IxSyB0TcDBiR8Lz66jY5KIzyC/qUxOzfs5
X-Gm-Message-State: AOJu0Yx80tXGj+2++V5DL4VIEPi1haien6ONl6ohyS5UB6Ou3uiuWN1+
	3oyDrAuwL+R200ekPybUyeDj5mOGjXpmsp1Jd/OI/9yamlNnfJCKiOR7uG4fnclNb5iiFMRZaRF
	5YDw8ym96F/lvipkh5tcZlWQP7hlN0GWcL7At
X-Google-Smtp-Source: AGHT+IG0zwh6iwEcuHVBa8Uf4iHIUM4tytie0ynNSAYjmD2hYLjXE9KZf8DiiQhzvUMiBcZtfcywH66OhJhQ6KHwyQY=
X-Received: by 2002:a05:6402:26c2:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5b033b8b8e1mr298020a12.3.1722257213066; Mon, 29 Jul 2024
 05:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729095554.28296-1-xiaolinkui@126.com>
In-Reply-To: <20240729095554.28296-1-xiaolinkui@126.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jul 2024 14:46:38 +0200
Message-ID: <CANn89iKxeYhqO-zNG5cTxw_o_3ORhcsXN7OJvFbhxPUEcoB3nA@mail.gmail.com>
Subject: Re: [PATCH] tcp/dccp: Add another way to allocate local ports in connect()
To: xiaolinkui@126.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:56=E2=80=AFAM <xiaolinkui@126.com> wrote:
>
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> Commit 07f4c90062f8 ("tcp/dccp: try to not exhaust ip_local_port_range
> in connect()") allocates even ports for connect() first while leaving
> odd ports for bind() and this works well in busy servers.
>
> But this strategy causes severe performance degradation in busy clients.
> when a client has used more than half of the local ports setted in
> proc/sys/net/ipv4/ip_local_port_range, if this client try to connect
> to a server again, the connect time increases rapidly since it will
> traverse all the even ports though they are exhausted.
>
> So this path provides another strategy by introducing a system option:
> local_port_allocation. If it is a busy client, users should set it to 1
> to use sequential allocation while it should be set to 0 in other
> situations. Its default value is 0.
>
> In commit 207184853dbd ("tcp/dccp: change source port selection at
> connect() time"), tell users that they can access all odd and even ports
> by using IP_LOCAL_PORT_RANGE. But this requires users to modify the
> socket application. When even numbered ports are not sufficient, use the
> sysctl parameter to achieve the same effect:
>         sysctl -w net.ipv4.local_port_allocation=3D1
>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Too many errors in this patch...

Lack of READ_ONCE() when reading a sysctl.
Lack or per-netns sysctl.
No documentation.

