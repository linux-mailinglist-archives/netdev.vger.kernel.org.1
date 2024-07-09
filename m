Return-Path: <netdev+bounces-110319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1D92BDD2
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBCAB2A669
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6D419CCEC;
	Tue,  9 Jul 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJLntkxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BA18EFD7;
	Tue,  9 Jul 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537027; cv=none; b=Gg2vzETuaEqIIDka+Ito/M76h+fJgNphnnYItDvVSebWsUOMU+CiZ2TMj2JATYWHNSRyn++s/Ekayv1qYexCYLEwCcdUiXo9HeNIQiHP/OMcyNk82Pd5JsZZOyDV1ONRiz5Vhor/XvxkWaUomRebdlWSJGA5V1/sGzKJaardoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537027; c=relaxed/simple;
	bh=TGP78oa4Q8trWeJFoXv/gZ8zqFMpduK6EZ81uys4LZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPT3hoDp6dsKAUgNXq4nuoorYZFznNsf+lJcU9xfPpx3lMbzo0bytDEfnmczV6fYCq3+1iup90aX7hpkXiP0sJfjMF6e0x6d6D1fhW1RF0SrrAEmAoe/hLbMEi7nGFlfDYb/kJ6N0mBsiGlY1n0HkHmNRY7OllxnBmefA7TRG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJLntkxR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367a3d1a378so3502377f8f.1;
        Tue, 09 Jul 2024 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720537024; x=1721141824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGP78oa4Q8trWeJFoXv/gZ8zqFMpduK6EZ81uys4LZQ=;
        b=ZJLntkxRmtqJ1PntSUGsre5Cye5UBrOKKcw6flP/7FbY0pTpCZzIC7+gbDvhdZmDVF
         Yk+Pimy196psIHWapN5ZWXjz2/dB69CsVWL347dz/MIagewwrohV1ss6M1iRgrN60WYl
         Ma90r6Btm4K7CIJ4lfpWcpPEKXIxz9bfXM6bymA3ROvZB9SppILJWdHHc0aq1UmpEOqZ
         5wy3GXdXYQQP5YkTyd5ZkeEcDBFB1zzWXAGmkczKpY5zlyX+k/YA1QXFIceuHZpFEUxh
         b+uLGJTUW23Q/HCHfR79631AovHE+m4hZa6R6jKd+v6IQwr8qTSy06jPsh6UpMK6VDnw
         LmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720537024; x=1721141824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGP78oa4Q8trWeJFoXv/gZ8zqFMpduK6EZ81uys4LZQ=;
        b=Ft2cSpoJTCWT60ClFvJ4muZlaQYpvxvV/RdlgFXAgFcdnQxGB2y7ym32Q5AoILyvMs
         pIySRvUicRkTU5bHJtsR6ZDEOH5KeqzZC681MhNUMuHGNZZ1jrFJcCEsr9Fy1oHDgmQr
         zfiF/GUoH75n7Pgn+wGf2Esta+e66hy6iYcxUt0BX6XNJ5lyXZwq8cGjXAgcv02jz1TZ
         vrQ8E1+3UcCvB698Toxxk4EruxAWQcqRyIAS4oXhggxhdrsbgCR6GHzSMxqwYB6C7v0M
         C5WxAgCeotT0/ib7239dPYspeDJ42EhsunzseQgdDiv5Yl4Y4h3zjLNTXe1UueutMeXQ
         9kOw==
X-Forwarded-Encrypted: i=1; AJvYcCXZdonvnGRwSA7gHZeO4LU08waVe8pUNi+lRSt4UXtXv05G7Kesmmpd8QSnws8owGGKhSsD5RNZkkdCB8aOVyUKdqKNiz/9Kchgsu85AILk1e3Xlhu3xZE2AvFuKRvyzjrPu2/2
X-Gm-Message-State: AOJu0YzDEVdVL//jnFPIU8Nr06+QCebsa1nbl/JkH4HWwzerlwCGXiKz
	I9PxVMnM6gbrySZQvO7A0FZaqmYW+t+gxaorHNxBXDIGrR8amio+pQ/Uw5efoWRvIh4rHEUi/XD
	HQMDI+qUZiuNJIC9ZfUIS0uvlXPn57w==
X-Google-Smtp-Source: AGHT+IFftnKHZMj16Ic6EO/cWEKP2Brpaqf++vaF4SjaXWM9Nok4ZOTK803ow3PbVjGrqZPfXi5GiRSoYvnusza54Rs=
X-Received: by 2002:adf:a38b:0:b0:367:89e6:e28c with SMTP id
 ffacd0b85a97d-367cea67d63mr2613384f8f.17.1720537023803; Tue, 09 Jul 2024
 07:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709132741.47751-1-linyunsheng@huawei.com> <20240709132741.47751-13-linyunsheng@huawei.com>
In-Reply-To: <20240709132741.47751-13-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Jul 2024 07:56:27 -0700
Message-ID: <CAKgT0UdwGGtnTfMv2LDmPVyT4WAbs+Vy7jv-0=WBJy7Ltnxbcw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 12/15] mm: page_frag: move 'struct
 page_frag_cache' to sched.h
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:31=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> As the 'struct page_frag_cache' is going to replace the
> 'struct page_frag' in sched.h, including page_frag_cache.h
> in sched.h has a compiler error caused by interdependence
> between mm_types.h and mm.h for asm-offsets.c, see [1].
>
> Avoid the above compiler error by moving the 'struct
> page_frag_cache' to sched.h as suggested by Alexander, see
> [2].

Both the title and this description are misleading. You are moving it
to mm_types_task.h not sched.h.

Also I am pretty sure you could just fold this into your second patch
where you moved the code originally with just a tweak to the
description explaining the build dependency issue. No point in moving
the same structure twice within the same patch set.

