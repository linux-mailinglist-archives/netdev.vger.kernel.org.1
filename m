Return-Path: <netdev+bounces-139605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD839B3833
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAAC1C222D3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B371DE8BC;
	Mon, 28 Oct 2024 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR8zCYpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA571684AE;
	Mon, 28 Oct 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137793; cv=none; b=fw4g0Q3vZnw+CPdwILhqHZnLw4yFBTvn0oL0jB7KKx8H86b8/G5I9/88bQ8bkb6QIBjwWBl3lsGviPlegNO1t5NKJ3Pm93ua5TeM0rrFNIXDQojNnaUt9AbVpPwOaHn2Slbrz2ti+2zxczyAEXxXDsvb+WBqekFmJg9BLuS9jzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137793; c=relaxed/simple;
	bh=E//W8m4YIl+8TPawrXItaAVzCM6WdsT2a+xP/caSd88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Umrs/dU4ep8LiJMgJyfhRjzvKoxQggJdCfRieEjIhXtFLeNfc9EzR7c3m6oS+cuvi1mtkE820QbmYdFv+FAQSCJjlqOVzI3ajbYRIX7oeIz6MYFrVcdjEZ8sTALwyJiWCcUX3IVAEW36jqKbangsAgktoUl5a5Lj5nMmuHGqK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR8zCYpd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431ac30d379so9710815e9.1;
        Mon, 28 Oct 2024 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730137790; x=1730742590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS+CDaRqLDX9OzIJihQbnIilfInW0I2/bW/aL1LjTwM=;
        b=TR8zCYpdqaV7iV72k6m5LHctycktex7XJxjR1odaivTXBjOl3u3UssvEN52bflzOLV
         IYrS3xgP+vkkciGWdz/0+f91uTaNs9dYc9C+yLsetDKwZJJobZN6IlFOr3eAhZFL9MBy
         N53xEwzzxiXwUAeLKfpeKom71VDwnVOf4ivAE4ISSlDZcSDNLQgaUbcyG/YpWnMI/zA6
         a2S/j5c9mS/H9ck55glqMr8N93WIQP2dUIZFsEOyn5lTVWK9JbgqunZOsdPOKrAVuNFa
         ZVnDZML6NwXcjQ2Xs70RluJHn0c2QAFAJpxXG2NfPuD+ku2K4YCT9oYPqg/Ia7Us9YYP
         hN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137790; x=1730742590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dS+CDaRqLDX9OzIJihQbnIilfInW0I2/bW/aL1LjTwM=;
        b=Agx9ddz7ecnxmmdOa3/LSPP5a44S1y+LX+kvOElrmhKk8UTewBx2S4iVQHNUfcQj2D
         YkDW3rKkabVWlbzAvqXLRr1HYaxORfWVagMh8IyzxNSdjYrJCXjTwpYo71zyIPdLQooB
         4CRiJyqoyuzA/GI+I3+YnKkvtDl/H6MSmy/+Ha6jI3h3bj4hVLNDgOS66AM507pC8xDE
         EMpJzi+0mWg69fr3411XLJRyMLspP1+gPwWcyZhw0TXW1aFG+Ns7XKevf7tsA0fbj1OY
         My9x9g5NQMk7/dODDXgEpKPgjhQmKobXN2IT0v1xWezpoCqDa26/wyTeHh0rUG7CIOEV
         ClPA==
X-Forwarded-Encrypted: i=1; AJvYcCX2jWcicPsxv4P8I9zW6i7mLLTFMiEyCO62OirJfJlzLYDmd3T1jf04wU3LEZ/dpxY6by4uz8q3@vger.kernel.org, AJvYcCX9C1sANcrsD/ix0Cf2UHwlsiA706bZwAA0Zm8EMVFlKhosyZ0hlPJ1YdylG+wmwHQ+4KbkeP58MWoR+XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcLDsBdiV6Hq7H+EJHZzOakIAjwR6DZLJl0XkET/kdlD/9dfc
	RqJMfhmdNofGz184sXqt106x2LmPsfgK9gAFGqYKgpn15IlqFwlStm5WbxvUiSPeYUivO4JIbV6
	3QPhu0VUSKDTXX5ISDbCpKqssjt8=
X-Google-Smtp-Source: AGHT+IEZiLVIqCI0cfYUlRzU/AbFdJ9mVCLjbS6yx75u6/19fy5sdAACVuuh5PZYe5RJd1iUMLtWWGteS29/GiRwVks=
X-Received: by 2002:a05:600c:3593:b0:430:54a4:5ad7 with SMTP id
 5b1f17b1804b1-4319ac76449mr84448105e9.1.1730137789737; Mon, 28 Oct 2024
 10:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028115850.3409893-1-linyunsheng@huawei.com> <20241028115850.3409893-3-linyunsheng@huawei.com>
In-Reply-To: <20241028115850.3409893-3-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 28 Oct 2024 10:49:13 -0700
Message-ID: <CAKgT0UfAyx54KW-Fx7_+DRx2sspYci21XvuL0MmwZ4c+Cpe2nQ@mail.gmail.com>
Subject: Re: [PATCH RFC 02/10] net: rename skb_copy_to_page_nocache() helper
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:05=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Rename skb_copy_to_page_nocache() to skb_copy_to_frag_nocache()
> to avoid calling virt_to_page() as we are about to pass virtual
> address directly.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Linux-MM <linux-mm@kvack.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/net/sock.h | 9 ++++-----
>  net/ipv4/tcp.c     | 7 +++----
>  net/kcm/kcmsock.c  | 7 +++----
>  3 files changed, 10 insertions(+), 13 deletions(-)

Looks good to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

