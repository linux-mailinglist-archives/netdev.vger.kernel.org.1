Return-Path: <netdev+bounces-187556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C88AA7D77
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE5E16E587
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70C26FD86;
	Fri,  2 May 2025 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvl9Vk9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2926FA46;
	Fri,  2 May 2025 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229863; cv=none; b=QoNhKy2G78I+MyljrL5KVhr2F7WZqaY8zHOpBPTtl5oxbZjWF6k2CDjTGozO67tcIjdYrYpSwCYdfmtEeepQnaBgHUGAVNU7O1jVVgg/f9ai4hsMVs+UuRZFa41JSWKfyWvdCP5rG+ZxzbEoUGh1YFUTgIhXBEM6XmeYfeHUxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229863; c=relaxed/simple;
	bh=aKrWXBVCrG+e3+Ml462cXe5Y1NZSgwzHBhsRjL5mNO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe2Q8h76QSknBlfPVld6RWL0IO4IMpk2cZIxGPZtNau+6p9IaE2mE2TOsTDSKDZqUIsouSxpBqG2qf/EzQ3NJiebbvbjfwc0FQphFXwVQakTNeoRaoyLO+qDdp0adj7/Y83frkyH07TdOIoVem+mbmDfF396Mu+ZzoBlb2+B3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvl9Vk9E; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so29113116d6.1;
        Fri, 02 May 2025 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746229861; x=1746834661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwhAOszonc/zk1grsNfE4+Jc6827zk/H0LKdtiazqhU=;
        b=mvl9Vk9EWcjp/NgivLq+Keu4aWgIyyrZOqlfT7pzbtZFq6bSCW7YHy75/MKoIINZob
         ul7uHhfZxz3p+/aRFrQ8/HGP3u/Z3HoL/C43djVnjimnfMXPubhCUqcg10+bm/bkzrhQ
         VwHV9ow4t9zHJWZiIUTpu8QWzqYhh1hF36oPzdt+Uu693m3vueCVRWvyL5O4eLw3aTrO
         JOomrJyhpUgRD6b6M5eX+Jtl1hThvIg5W3gymiOsPxTOX92tPy+UHBV7ex+rRzgenDgV
         fqdVV+6MdxrhXK/0bzqKZ3zbQo2bVoFvhoxjvlZ0AN88Tiq73rZ4T0yJNJy40crrShEo
         CsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746229861; x=1746834661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwhAOszonc/zk1grsNfE4+Jc6827zk/H0LKdtiazqhU=;
        b=HIxtmtKexk0nkgW2WMUsXECQ8oGeF9d8VcECpVeFlCMcBnzvhZanM9GgT7z05FSDTq
         1ENYpk7CNknmu7Z6OoRo+WVwJLDAYl3phxVPqsV6VZ3sQbzCyMsV6K8fL4lyHcRm6DjM
         72m8hd/ADvW7h41WQcFLTr6we0IWmleFmdMzCkaqX66m3lyw4/kqaOd2q0B6p+KolBeu
         xtXXopO9CQKeggylieSsWIGyDoBA1u5+f+o5WyOkA7PcGKCWRnu24ZF4VUcWlRZ4NKVW
         C5VGHoMwjCH3A2fh3OiNyToNaYijfqnedwE/XTBNm/ZS8EyzYjYsTXDD+TrfB3jlSbOX
         wnmw==
X-Forwarded-Encrypted: i=1; AJvYcCU5bZir63gQlPJJDRzU1qZG+owleBfyo0OlNPGiKY6WcNjK7GW1mEAdDkEVHsl6nna/EezPLCUe@vger.kernel.org, AJvYcCVVfn/L1sUo7FwiX7+4nuVCqitbdUxAzdidnU/JqKQ+/Vg+bdMW9E7J3knHGTF8PZewc1zFAPTBhdSZAoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBbcDyGGYmcrV1enqjlXeiNN7aoI6yYCRKo+JM/wewAy2NYR2
	fhJJgCM68i5rX7J1mrW8UvhESoNVLBf857sX+5Ldk9SLJ7rLD2S28IhEoYgbae06bmxgtrz6VnQ
	g9RZVd2NGTYRgeafEESfDUYr7ZQ4=
X-Gm-Gg: ASbGncutd6A5qtWRAAdsE8A/XTI3cQPpjYbLlV2dIHO6yCTZB71/ofcpK9SeMzwQ+YX
	ymBWajVqC9rl9hfu2dJsXt8oXuvZMXjVY/OkvqaWub/PcjZq41El7V4tio6kjkh3gtsxR/EYHLy
	ZKxqEoi+do3TD6L1Q3MfIX9Q==
X-Google-Smtp-Source: AGHT+IHB8oiJWrbY009G2fsW3lPulWnSCJAW1zOAkTIk9NWb+srZNZo+N7KbfA5KVFqROvkAUEZp7A5rU+3bIhbXK10=
X-Received: by 2002:ad4:5b86:0:b0:6eb:2f30:55cd with SMTP id
 6a1803df08f44-6f51580dbf9mr63733176d6.45.1746229860892; Fri, 02 May 2025
 16:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425231352.102535-2-yyyynoom@gmail.com> <20250429143503.5a44a94f@kernel.org>
In-Reply-To: <20250429143503.5a44a94f@kernel.org>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Sat, 3 May 2025 08:50:49 +0900
X-Gm-Features: ATxdqUGqfEX6ZdoD5W8pkMUTv_VYN1eHfMA_5mzpjWaEp3c5tPyDIMsFKrybwjU
Message-ID: <CAAjsZQwymBUvn67+jWJ1WRG2iJHyQFLwWEh8+3O_ryfX31mesw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dlink: add synchronization for stats update
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for reviewing my patch!

On Wed, Apr 30, 2025 at 6:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> I could be wrong but since this code runs in IRQ context I believe
> you need to use spin_lock_irqsave() here. Or just spin_lock() but
> not sure, and spin_lock_irqsave() always works..

If my understanding is correct, then it seems I was mistaken and you were r=
ight.

I misunderstood that the same form of locking function should always
be used for a given lock. However, as you pointed out,
`spin_[un]lock()` seems to be the correct choice in this case.
This is because the `tx_error()` function is only called from
`rio_interrupt()`, which runs in IRQ context. (There are no other call
paths.) In this context, there's no need to enable or disable IRQs at
all.

Also, I believe that `spin_lock_irq()` in `get_stats()` should be
changed to `spin_lock_irqsave()` since `get_stats()` can be called
from IRQ context (via `rio_interrupt()` -> `rio_error()` ->
`get_stats()`).  In my view, calling `spin_unlock_irq()` in this
context could be risky, as it would re-enable local IRQs via
local_irq_enable().

There are two ways to lock the `get_stats()` function: either add a
new parameter to check whether it's in IRQ context, or simply use
`spin_lock_irqsave()`. I found that `rio_free_tx()` behaves like the
first case. I'd appreciate your opinion on which approach would be
preferable here.

Thanks again for your feedback.

Best regards,
Moon Yeounsu

