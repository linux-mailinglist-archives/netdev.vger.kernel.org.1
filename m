Return-Path: <netdev+bounces-225008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A258B8D0B0
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 22:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205F31B26CCF
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817D2951A7;
	Sat, 20 Sep 2025 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBJFl0nh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5922069E
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399578; cv=none; b=AhiXnou4zxxzkjqh3L003P+coyBnFV7lXkSQYHRQb+PpNgwfGc59AI1JFwGi5UjuVwvzfo67YulCBAAaSaaoJSxWbWNznrZwY6/7cC4Yw5EiCJpNVo1LT9ac2RuwgcxY3lmhXjbkEpoF99WYtlJA1Tjm8T9oiASbC3APkoUnZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399578; c=relaxed/simple;
	bh=av8Yvw3+ljl0FvvzBf9sej2cxaJVtqogAeog/isanmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHnBF14Cmfe/cbVuAK56qPwKA6Ipc36T/0WG13GkQd6t0k/X+TBQ/rRDc7QQ3DgWUT5s/OuZ7dmXZ3OB+rymo3dOLs2+H4pdKkCt8dWO9jjrnoq54rO/rn4Czmn0w5PyOdxwg2Mux25ikGg3MUp9olT2ig+PAbICLCsPvrLJDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBJFl0nh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b5ed9d7e96so33953851cf.0
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 13:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758399575; x=1759004375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqceUYl9L4yN7Obx/5wjK8FkGr/KlngUqLxjtnrr16s=;
        b=iBJFl0nhcjeUQpxfXK4fcJ9fbbLQTQyVbJybGYuq+N0RWCKZBkJwXwWNc5QXTYrMrf
         9DCK36sR7faTKrDdTXY0OuF5t7BV5any5gw7Jsh6BxaFxxGVqc8cViNOz23sWpGB7Xz/
         c+Td5MNC2tFNXKw9V1r9Lr2GKSSJ+4qR7gUWIPjxHArMbQG299/6T8MbbboqjjgzfQdg
         f7usaDSH5i5ytSXExcXrLjTa8HM7YgeXJH9utsaX9RZbIAryh6+lWIz7U5FyX8VglmXo
         ungErXehDafAMuNSRaqamEDypcIHP/EF/xpRiKmsLbv9tx72p38qWWnb8rwxt6j5/Kef
         eW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758399575; x=1759004375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqceUYl9L4yN7Obx/5wjK8FkGr/KlngUqLxjtnrr16s=;
        b=KBh2DXG/LhlWilEHYPa5iNPFpjbbY9e8fnoJUgySPt1ghW2uFUbPtg7lWb0ZVoa4F9
         sbbytmSvt0m9+wqmS0wEk9sy0SvYLVZNhtc8ts1UAHGbENqwaMEHJynhvkmQk7JIDXX2
         LcVIReU7XEq3p2ljLi7ER85X/qbu2D6O96slAElyVW38JzITSOUh5c1RN74zv9NKn7UD
         HE5dDrPWhQ6lE4k2a3XveblrOYYbYH4fBxGRguwcU86U37vJICheCtmk2JD9urtsRm+R
         5CwE+IBm/uO3YwSdDQ3Zd0JbsFy/KThwcFFSq48y+Q+Xx48M9aSPQkqZJM5MUh6EAJLT
         IlTg==
X-Forwarded-Encrypted: i=1; AJvYcCW75dH7ExepptVzjxbkHlJnINXRvqf/mIEOQZWsrPq+Qx79t/gsRU4PpQh+kVAMwBv/a1znugQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3l3rHRw+YV/OqP0buEnXXcSGW22hwDBmpQt37lIQ+/EXnKW9/
	rbjizIawB0Dunp9wi2jZO2LHMWexIhdWxJN9Z5ad8pYTiOYAwYuObMLo6Ii0kLlW28F7Jy8CHKD
	I0XHRSD8qZoAlqmv1uJHCqlSMfo9tUVa2CPS6jTiT
X-Gm-Gg: ASbGncudf2z2wy0Onr9iM9NjP0V+aK4Dap//ESfqpDiiAmyh4/lG9nSZrwMidsYDZHt
	8nIerzRaYYPhwsKSaM9k9bkMfWFPk2OSpuaq6hWhzpVeQxnd7NBHJ7lsxSnKdNvzVV1zO7TtQtH
	kdn1bBh8XQx5QTTf7cLSQakBqmxqGFKz1qyd1zUgakbGxCJvvgXTf7CQ/HU60Z2sXm+iYwDz6wf
	VTG+rZh
X-Google-Smtp-Source: AGHT+IE0PtoCHqbFMkajXTsiMP3No7HZ6kaiM75KQobDbF6/LqJJqV9wcO5k8b2oMpgXoMu3mQfYYsrytKjYaJUX6Ho=
X-Received: by 2002:a05:622a:1f0d:b0:4b6:24f4:c72 with SMTP id
 d75a77b69052e-4c03d7af25bmr88561921cf.17.1758399575213; Sat, 20 Sep 2025
 13:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920201138.402247-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250920201138.402247-1-kriish.sharma2006@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 20 Sep 2025 13:19:24 -0700
X-Gm-Features: AS18NWBV0Mmj7rPzAvbmKR_dMzi2WrrnLtl2a-KtIEovgTjGkuef8G5Jln9ImCE
Message-ID: <CANn89i+3Lin=ZZZzzEXKLrWU=vyLWmUEoeTAE_4_N_fKvRYVmg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] net: skb: guard kmalloc_reserve() against
 oversized allocations
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, kerneljasonxing@gmail.com, martin.lau@kernel.org, 
	mhal@rbox.co, almasrymina@google.com, ebiggers@google.com, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 1:12=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
>
> Add an explicit size check in kmalloc_reserve() to reject requests
> larger than KMALLOC_MAX_SIZE before they reach the allocator.
>
> syzbot reported warnings triggered by attempts to allocate buffers
> with an object size exceeding KMALLOC_MAX_SIZE. While the existing
> code relies on kmalloc() failure and a comment states that truncation
> is "harmless", in practice this causes high-order allocation warnings
> and noisy kernel logs that interfere with testing.
>
> This patch introduces an early guard in kmalloc_reserve() that returns
> NULL if obj_size exceeds KMALLOC_MAX_SIZE. This ensures impossible
> requests fail fast and silently, avoiding allocator warnings while
> keeping the intended semantics unchanged.
>
> Fixes: 7fa4d8dc380f ("Add linux-next specific files for 20250821")
> Reported-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5a2250fd91b28106c37b
>
> ---
> v2:
>  - Add WARN_ONCE() to make oversized allocations visible
>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  net/core/skbuff.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ee0274417948..70588f98c07e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -591,6 +591,13 @@ static void *kmalloc_reserve(unsigned int *size, gfp=
_t flags, int node,
>         /* The following cast might truncate high-order bits of obj_size,=
 this
>          * is harmless because kmalloc(obj_size >=3D 2^32) will fail anyw=
ay.
>          */
> +       if (unlikely(obj_size > KMALLOC_MAX_SIZE)) {
> +               WARN_ONCE(1,
> +                         "%s: request size %zu exceeds KMALLOC_MAX_SIZE =
(%lu)\n",
> +                         __func__, obj_size, KMALLOC_MAX_SIZE);
> +               return NULL;
> +       }
> +

You are essentially duplicating a warning, which already exists.

You can be sure syzbot will hit hit this warning.

Instead, please fix usbnet.

