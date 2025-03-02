Return-Path: <netdev+bounces-171000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B624A4B0D8
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 10:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3143B4884
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A41D5CDE;
	Sun,  2 Mar 2025 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXJrGnWT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955193C0B
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740908978; cv=none; b=lISIxWyCsDWm6ZD1HsL7Sbe9gkzXKd77+tYcau0i65qFa7cBoAqfyFxddgrWtJmrTeZDTaIk61uudmelqGsyDrUOyk45zE0ULURYq6XNw2tq8WGreYuiYjOAvILT4ixO3+/y3HDXKkqH0NsiFVkqy0t1Gznv24EgXifz5we+Xms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740908978; c=relaxed/simple;
	bh=PVpgpk00Bh+Bf1jHwLQDSi3hQWk7nKef2fXv27t254k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8MkLLkwQMh1mqSEbhcBj4xtvhlbPj4IVUkq86i6M/ub1/CV7FWAJiqHWXVXtSdmXAKEUd0km0+8+9fZZH97p6n2bRnbZ69s/iSCYFYFbCr/rknYuChH0nswc8GsIQv2JYXFBseXW1QLPECL0wsFJutqqwawc43ISH8e3CjV3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXJrGnWT; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d2f5a932f5so11543905ab.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 01:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740908975; x=1741513775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVpgpk00Bh+Bf1jHwLQDSi3hQWk7nKef2fXv27t254k=;
        b=TXJrGnWTjWJ0QWFPHfPfAwmuqhqOPJ48fKp2kI2XRwdni00n6UB22OYbGzQglJxXXb
         3oNeGT5eT+yAFYLAsmg+tzMYyWJGmTK/gdwVr73Jfa+1MJdIQMSJU2o0x7bprQ+j8etL
         byKbaZwIAXS/niBJoajFS95x0plknX6ml9dMFPyHUri6ocer6OtFC5PTwwV5SHCv+uB7
         c+iwqEtgEEA90s2Gh51Olo2EZq4oN5P9ODpkOSargQpWkU/4spryn6nZxqZAr8X6geP4
         D/F9F6K1RGAWA+3nIgYlgWMTtdw0EhVpLoYSPDK5yCui+Zxx9n9UVfr2GdR0PVLxMOgR
         bQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740908975; x=1741513775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVpgpk00Bh+Bf1jHwLQDSi3hQWk7nKef2fXv27t254k=;
        b=fHpESqMDFDUb083z5ghQC5AjnUvzM7t03QdIslrPxD4D0SQ9IC1hSt8pbBcTjqpB2w
         DTsp+g71xI+YZ1LI66cXaY2c7HJe4A73lIUqOCV606ys2GnZhmMEFDJ1kpUr4pHwIJLq
         w8FlnDuEYiYTabvUPrShLSK42N7jU2tGpUKIqv+qwP5pVbHcJqzdYruqyDYBzZfK0nyh
         GtjYb6SR/V5Qf9mM474ftvYa10oGeZDqZ3DMLKbC/mQQP4n5qZYAFc5xyr+bJHcXFKZv
         JI/fn9BFG+dbMOQwOmgB+9iekC/sBaTS0e/bHvV17bRfY98jgM/tu5Ne7B6HVGbJHR2q
         1ErQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2IHexbQBb+clInrujjRcdNAW9l8V0478SEl3Xu49nM1mExmgmBg++G++1MjSevo8HaQ8pB/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3bG3pR/50cZGZyc9tcdWkFcwhytfX4+TENlkUshZfrloc6MP
	MFRiZwAYJq2VdKbnivK2R1oCgx6F3vvv0E47LtwKI4VmP2+pme9jthDqjPJl8JOfHv2+7QbFUcl
	5cFtSGEv0iAsUCm79U4xe6DrUkdg=
X-Gm-Gg: ASbGnct3Wal7SUwZw+VmLQ3Nt0RMXEefIqcGrv5EDhABFt32MWLxZ7RZfPqncFgbwnU
	ntUIwYwBk3GUoxtWwPepk4kSn6bReeTDfDO9u5HUaYqxLnfexj0t3SkJ6Ejh8O3iv0AHtW9ul8B
	ifM4mmTfNfo/A7VX7luOqNb+R/bw==
X-Google-Smtp-Source: AGHT+IFqvrduf1AmaT+0fW2F/mSlDgdSJjgVW0Q5hWu2Tse5zQx2BSDa19Jaohzv/iN3V31cre5GNKDpDEmySU62shA=
X-Received: by 2002:a92:ca47:0:b0:3d1:968a:6d46 with SMTP id
 e9e14a558f8ab-3d3e6e42b50mr82318505ab.6.1740908975611; Sun, 02 Mar 2025
 01:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301194624.1879919-1-edumazet@google.com>
In-Reply-To: <20250301194624.1879919-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 2 Mar 2025 17:48:59 +0800
X-Gm-Features: AQ5f1Jo6CWmWqbr0OMtutM6sSBtuY-at7L6l1GYdrMEagZ02hS9AGuBGuSeCpNU
Message-ID: <CAL+tcoBAVmTk_JBX=OEBqZZuoSzZd8bjuw9rgwRLMd9fvZOSkA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use RCU in __inet{6}_check_established()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 3:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> When __inet_hash_connect() has to try many 4-tuples before
> finding an available one, we see a high spinlock cost from
> __inet_check_established() and/or __inet6_check_established().
>
> This patch adds an RCU lookup to avoid the spinlock
> acquisition if the 4-tuple is found in the hash table.
>
> Note that there are still spin_lock_bh() calls in
> __inet_hash_connect() to protect inet_bind_hashbucket,
> this will be fixed in a future patch.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

After Eric just reminded me, I similarly conduct the test and succeed
to see a 7% performance increase. And there are 1225112852 times early
return with -EADDRNOTAVAIL (during single test period) in RCU
protection newly added in this patch, which means we save 1225112852
times using unnecessary spin lock. It's really remarkable!

So,
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thank you.

