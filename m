Return-Path: <netdev+bounces-85974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20B89D1CF
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182F6282B64
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 05:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA987535A2;
	Tue,  9 Apr 2024 05:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dfw/g7pr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495774F887
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712639339; cv=none; b=E77gakW0uyyMx2W4XYTAVRPU/dDU7EYV50V9NAklMoPtbjhZwUTOeygLpmZX6hmUCph+opMC3aCqsLBOFlTVRBv8L7AGXQHER1UCXTvSe8aVpiDn8veeyLjo8PwMaIMSWTNOEY9yMYGqmnpM+vci2lpEbA2o/ohBw+hKzu94cz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712639339; c=relaxed/simple;
	bh=dpumPbGeuszlGgZ/6QcYn1ZPkL3r/LCYuwQdgcIzQWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMpa/IZvhHcVVx53Ip6MYmrWrSMoFgefFcaKCWcQDzxQqlXZ1eLM4oh086er7/DRwFijSBXGhZW6Gy3ob9M6nQQM1v3F1elpDQ/GwP8NJndY8Kn/MXzYaULeSv/ix59VZz3GySkEFjVrPBWLqIiQOeClQ1gm2Hs8TDjdy4vk/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dfw/g7pr; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a2825cdf7so73505ab.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 22:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712639337; x=1713244137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEL615D0PAohpi/ZueAVrRaSlrpex4n/Ywu5HFL+HUA=;
        b=Dfw/g7prRaRj41bE9F3PnmZH0yjd/3qWG/f8Cct7o8dyajA5KcnkENxar7Kn9W9PxB
         eWJS8hgWXJxpEeRuAG0gOwjGfM7SmGzH2n4phkqd+zAAT7T/fF+AGvgC3i4ZftPcIy0Z
         DesGy71tpK8cnLrRBij5j4Bdb86nMel+0ag8l013tLxml2owzoK7t7T6Q06LHYnsgJzG
         iKHUv2X4Tx0D6AozHiSlXRMFJrHmZt+9qZ9VbB71VpTNs5VPjINiSqYUNbPC6XqvHajn
         ec3pKm3Z4oY/AdG/dJrJq0SbslUih+Z0e1OkRjweujqqz3NQZZF3FCEXl2XQP6ASFDWF
         tFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712639337; x=1713244137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEL615D0PAohpi/ZueAVrRaSlrpex4n/Ywu5HFL+HUA=;
        b=wdF74Dc/3FrXRmefKuQUV6VdX03Rzfd6fubLJm0qqm1QqDBnzazYk1+mI+f5fdNYJM
         pe3IF4yS+KnksDOeIxAe+1MfsyL/EN2aS3koY+GcGSmGAMxAbuRhWcoEDSS0Grrwu8U8
         33V9NCQTr8ZLXj1K/D9lcq5+CjH6yqPfPcYL88gPAxrJVhYA1P1lB+zuCu3l+Celep3V
         iVT+42yKT2eTSW1UUyd9l8D6JowFnL9iaZgQkiwiB3el/2B0tkViulChLC7Vp6AjBEiX
         8AHvPZAwAW0kFc+pZRIRIGDpj/BMT6yA2yqSFJyI5rKldZCJuteUoPvsWfe9zHusuVd2
         ZEoA==
X-Forwarded-Encrypted: i=1; AJvYcCW5e5VZFJXq9bfP5ty3dQY1piEo5uAKRutVloWHNAA0OD2zWJNHvIyp7H63l7U7hHItG9HR6az/uub5W6C0nDgeHmHmTzsH
X-Gm-Message-State: AOJu0YzsbIguCVViebIxNMFKitUez5Y6LwN29fjhAtP8x/ymzjBMuFAH
	i1CTq7GKnIUGJZP8yz6ztQqJKVtW5bEXg2JKzCH+zgzq1mrELTwXj1zFO+XF9bjLqr/S1Wpt5Vu
	AbB0F3rJ66eBnk5Yk+DYZ3Q0I9NCtExzzYPFy
X-Google-Smtp-Source: AGHT+IH7efisCsDzy68bbh6f3D2qyn7Zhr5zd6BXbQlYQ1t6gloGyZQkP7PdJR/HI8I6TtSndLyjiGhNNjGm2w1rVPE=
X-Received: by 2002:a05:6e02:1d86:b0:36a:1278:5c5 with SMTP id
 h6-20020a056e021d8600b0036a127805c5mr177596ila.26.1712639337111; Mon, 08 Apr
 2024 22:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404082207.HCEdQhUO-lkp@intel.com> <20240408230632.5ml3amaztr5soyfs@skbuf>
In-Reply-To: <20240408230632.5ml3amaztr5soyfs@skbuf>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 07:08:42 +0200
Message-ID: <CANn89iJ8EcqiF8YCPhDxcp5t79J1RLzTh6GHHgAxbTXbC+etRA@mail.gmail.com>
Subject: Re: [net-next:main 26/50] net/ipv4/tcp.c:4673:2: error: call to
 '__compiletime_assert_1030' declared with 'error' attribute: BUILD_BUG_ON
 failed: offsetof(struct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx)
 - offsetofend(struct tcp_sock, __cacheline_group_begin__tcp_sock_...
To: Vladimir Oltean <olteanv@gmail.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:06=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> Hi Eric,
>
> On Mon, Apr 08, 2024 at 10:49:35PM +0800, kernel test robot wrote:
> > >> net/ipv4/tcp.c:4673:2: error: call to '__compiletime_assert_1030' de=
clared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct tcp_soc=
k, __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(struct tcp_soc=
k, __cacheline_group_begin__tcp_sock_write_txrx) > 92
> > > 4673                CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_=
sock_write_txrx, 92);
>
> I can confirm the same compile time assertion with an armv7 gcc 7.3.1 com=
piler.
> If I revert commit 86dad9aebd0d ("Revert "tcp: more struct tcp_sock adjus=
tments")
> it goes away.
>
> Before the change (actually with it reverted), I can see that the
> tcp_sock_write_txrx cacheline group begins at offset 1821 with a 3 byte
> hole, and ends at offset 1897 (it has 76 bytes).


...

> It gained 20 bytes in the change. Most notably, it gained a 4 byte hole
> between pred_flags and tcp_clock_cache.
>
> I haven't followed the development of these optimizations, and I tried a
> few trivial things, some of which didn't work, and some of which did.
> Of those that worked, the most notable one was letting the 2 u64 fields,
> tcp_clock_cache and tcp_mstamp, be the first members of the group, and
> moving the __be32 pred_flags right below them.
>
> Obviously my level of confidence in the fix is quite low, so it would be
> great if you could cast an expert eye onto this.

I am on it, do not worry, thanks !

