Return-Path: <netdev+bounces-84569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6998975CF
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 19:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343E81C215FD
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304ED152170;
	Wed,  3 Apr 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arista.com header.i=@arista.com header.b="VSsW3yJU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9141514F6
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163663; cv=none; b=YDdWnunwmkZ4ILPAxzRdm4Xvr8NM6E53a/OGpzcEnLxVkRWYtDfQIfNJJkTFFdvlU25rvnQNcLBCr6Mcd0/2cO44GMmooayiGhgc6I1lh0rrAaZbUO9dmtghvAQetBfkkFyq8IrVkLjnLFZQdLX7hnDAAXioGs6ZVFJCL5S7Bu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163663; c=relaxed/simple;
	bh=pCLNzzLPBjclBQkvMoJ+H7z2bFenb2zAQY9AAvNZjGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2MB4UwZB6d78l2F0Acx14viLLnr26e2NdmbQJ4D0dKeA11arm0Z3C57RfAYPp4O5Y11HD01PMVjh/WTr0nON2+wfXwIGaUXzNoaHcqe9hrScjanzwJsiYzGuxVIiKmg1eMtvcs76UppAQv5efctxk/Y1R0NdFNIwO8tyJhSoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=VSsW3yJU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a2c028b8a6so3728a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 10:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1712163661; x=1712768461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eijqq1kellEja2nXJ0nGvTSxawC3HDrhpQA6YnGCSQ4=;
        b=VSsW3yJUleNGPeqHgxDeDpkKvQ851yLnVQChKjh/WFepnQIKGBr3AcuouwsLt8g3yX
         qHXUuHrXkCGs3XFGRly7x1uuyS0fjMU90tq1xQyjua5Uu0ZD3WdCRbsYhJLXN7moZp0U
         sHvBriemOyRI9oHzeT5W13Js9BeZ6o1wHsgORJ0Y23J0HZPfP6uq6smTglkbatOdq9Fy
         QpNGvvgR8AFbomu0OGmE1P7k52lmVTCM8eqpr0E97PTIAmS9zoePpJPx00F837RbZYRy
         OsfbWaI/v6usx4fy1GehqG/lwjMs8GiJs5zSUCWYhiXjM+rfnFASwCf1srQiSqjDDIkg
         7zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163661; x=1712768461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eijqq1kellEja2nXJ0nGvTSxawC3HDrhpQA6YnGCSQ4=;
        b=ARCeznHRhDGzZ5/bhZC82nO6DLhrHpkThMg//g06HnkT6u8A6AJjkFKFuZiqtJ+QGg
         lVhfRavZQPwOP1HrxfO5c2tIHUScx+otcZK5Ee7qSSaitDyzqox9fZPFTHrhHVmYTV87
         CjgF1hB3te1v87wuHNXbd43ywSjQOS5STnj2ciFnnBWnMv0H6vdHa3eGjnt6OhEVnx5x
         3tSq9Jrut3bQ9VFSkwLq0DO/+T5dOyhouXele8Mmq4u5RoHSpYFa/vZwKiC2PHVV70HC
         DfB4xZw+lO1L3SSXXpHrXSqg8Xy2WHu5iDQv6T96wiVwJbw/czJop0H4xNKOgr+v2uGa
         GMWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpeGRkjn0NGkuMioqGTM8+8GgA9Jb6cB+k/hmKVWzDpvVQhZ9iRhUu+CKVo8AKVp8exEpq5sdcNK1hZMDf7PDeHll3o8bA
X-Gm-Message-State: AOJu0YxysQ6d5loOaFNiIHdgnaqM+ey9cC9Lw89BoxsP4irLYngOa25g
	Ip+uxjJfHIXdT6L1mpkcqLGLJDXfVc0Yq07mzcAG+t6JZmIGx7fJMZb6EKPsAJuk+9GioJS7s2o
	BzUIc7w3aMUK8TQbzGFnEkT1hSG/LoltXI3qK
X-Google-Smtp-Source: AGHT+IH+b/yzFFmXkyLOQ8e/HJ2CJOFKEsj8o894ViUToeucMYnGc5Ulmwpl7GyflCzMs9YbMXKZZLY6LiWJ86MkzmM=
X-Received: by 2002:a17:90a:ce82:b0:2a2:6a52:96f4 with SMTP id
 g2-20020a17090ace8200b002a26a5296f4mr118745pju.9.1712163660743; Wed, 03 Apr
 2024 10:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403132456.41709-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240403132456.41709-1-aleksander.lobakin@intel.com>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 3 Apr 2024 18:00:49 +0100
Message-ID: <CAGrbwDQ40DWXZ1AYesdXMXrb3HWW6bs6dAYVaUrwDriCekwg3w@mail.gmail.com>
Subject: Re: [PATCH net-next] net/tcp: move TCP hash fail messages out of line
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Francesco Ruggeri <fruggeri@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	David Ahern <dsahern@kernel.org>, nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Wed, Apr 3, 2024 at 2:26=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> tcp_hash_fail() is used multiple times on hotpath, including static
> inlines. It contains a couple branches and a lot of code, which all
> gets inlined into the call sites. For example, one call emits two
> calls to net_ratelimit() etc.
> Move as much as we can out of line to a new global function. Use enum
> to determine the type of failure. Check for net_ratelimit() only once,
> format common fields only once as well to pass only unique strings to
> pr_info().
> The result for vmlinux with Clang 19:
>
> add/remove: 2/0 grow/shrink: 0/4 up/down: 773/-4908 (-4135)
> Function                                     old     new   delta
> __tcp_hash_fail                                -     757    +757
> __pfx___tcp_hash_fail                          -      16     +16
> tcp_inbound_ao_hash                         1819    1062    -757
> tcp_ao_verify_hash                          1217     451    -766
> tcp_inbound_md5_hash                        1591     374   -1217
> tcp_inbound_hash                            3566    1398   -2168

I can see that as an improvement, albeit that enum and the resulting switch
are quite gross, sorry.
I had patches to convert those messages to tracepoints (by Jakub's suggesti=
on).
That seems to work quite nice and will remove this macro entirely:
https://lore.kernel.org/all/20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@a=
rista.com/

I need to send version 2 for that. Unfortunately, that got delayed by
me migrating
from my previous work laptop. That was not my choice, resulting in
little disruption.
I'm planning to send the new version optimistically by the end of this week=
,
at worst the next week.

Thanks,
            Dmitry

