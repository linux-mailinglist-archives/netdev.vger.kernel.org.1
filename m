Return-Path: <netdev+bounces-248012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931DDD020BF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 11:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62D05309ADA9
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5953EDD43;
	Thu,  8 Jan 2026 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDyljAdi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE13ED64C
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863289; cv=none; b=oBRNhUQb+luCymFrcbyjQRzNsaXWw32H9ZfJFlPPtz/Run6QBQ90Eqo0/ExnyUB1pJpEYsmIKaWA5keLUFcR0GU3pgW13U4IGcvxX1lnFcVVf0BKvWDLuGfxtLjJ5q1QCZDRMXHWJ84yXjFTiOL4OvjZBL0HkkhedVwQKKwsG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863289; c=relaxed/simple;
	bh=EcQMbFRqCCUt+PdLgwmmmiL3uuXJ8DSVtKR8dQ9uhG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFrq6fqSGmbqcZzYljCIucfe6+pFFDXyIu5IQXT0E6Cl3REoO7/vRfZKSOsLPAeOFTVid3yh94s6LRqSHYqyCyh+H33n+wEB3txszR5sflpUcp7UOEFF4PTiQ/srR395uKw+xvRhia1t1x2YtK3RSy4Wa3ZLfXasi+JHhq8WUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDyljAdi; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3ece54945d9so1173698fac.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767863271; x=1768468071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkTLgIk5KrHlnn8sSgveH34RTajKbioDLcNlqwR3F5M=;
        b=LDyljAdi0tWRTawnRtHNSfegxTeKHbKHb6vdjM0N+Wvs8qq3qQIJcFGwKFd60fC6q0
         XaLLqXAJTYKLA/SZKmXGGDUBgNTe0YFgr4hTdbnAQiuvYUd5qw3Hc6u6D1+P68VRi7Nr
         mY2L7hScTK+88ofOd7DcDNq10lyC9ZE6YFk5Wv2QcvzpQBu20Oj25beEQp6Aa9edYncV
         pYUXd7M3/8rfr32i3QrCnAAxwCI0ZCSZDQx7KU3PoiUjOosay7ySDK+w6L60MZPPrcp5
         c+o5tA8ABDmfiKcj7zBbmnHOW3UZNzMQnNC9R1+eLIynSnBt5u1NYR57GYtqz3f3zkYY
         J/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863271; x=1768468071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkTLgIk5KrHlnn8sSgveH34RTajKbioDLcNlqwR3F5M=;
        b=JJGL4GI7JKfjivz1yAqs/e07OXJRggnuGAn9XXVRSa/9S60glg3RIPjxJKaIbxZ87/
         EMglnWBzTJw9d8pDgEMWWzGlHNNnjXxhsBnDO5AX8SByUDUCkDhpEiIyLPe/gzm9XGff
         eIwyymqxl8XZCi3jezvjH1rwzAmWMEiaOQdBBUdvhyvethcAuPNuNo+7n38LTDI3n6UL
         cmA15lNxWNh/umjaqoOnEFU8ATEG4mA2fwFCI1jos6t4Flg4CRkAHOHAJdfo5NQH2mAi
         MEusvx+EH6xRqBNgBTxhvR4GzqN1aFUSZ7bDZKYmUN714zwQqDq8zZLYQy7L4BG4wlnu
         P5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCX79yCCY9Q21t2/G9TGmw8VgvYRDXidOaAsy+NwUVESRTBi9a9OdjC3qhcddFm3+mf5qOvCYKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylU16D1I1OtmD3ofzoBOatPigoPL4usyY63DLFKFNbDDC/eHk4
	Yyvl5LXj5pj1xhsBDochFeH7EexR0jPKJUqZ5t4vxJ7XM4ouTUWjrmbEYW1hVicL7eR54Drt7p6
	vmhjHQnkIH3SZCF7VqTBvWv5b0zYXlog=
X-Gm-Gg: AY/fxX5eGcRflILveoVVSDtvaoAqzqxKx7f3CVX8St5C3V6mUU2FaLwhXgm0PaOJUSv
	tpkjsUdqiF0Kwx+ioyeQK0WYiqj373QvlGnfWzp137iTGcAhV9u8GltumLNU28yz+HkQOlyGq0h
	jaO8EMVIwgppDENYLJcDSrgKjbd8MF03Cg+SW7V8+n9yUUwdwL9X8m/Q6gJjFQx+GUvQACD40gt
	5E4ACo0sn6wxrq+yYoUEWIalOzjT5xAw3XgaeySN7+yJuM6FVGB4hjhcnRbQ/bl0TkcpSmN
X-Google-Smtp-Source: AGHT+IFBo8zNIrl5j2mohTMd2uNoYwsPPGHofB19QKh2LY79gcOhIgQg6/uoivaFX++yrCsun8LJVjDzUsWItkno0Gs=
X-Received: by 2002:a05:6820:4806:b0:65b:29af:b56b with SMTP id
 006d021491bc7-65f54efb18amr1447679eaf.34.1767863271099; Thu, 08 Jan 2026
 01:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
 <20260104012125.44003-3-kerneljasonxing@gmail.com> <9f0fffcd-8e2a-4ae1-b89d-ae73dba9e1be@redhat.com>
In-Reply-To: <9f0fffcd-8e2a-4ae1-b89d-ae73dba9e1be@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 8 Jan 2026 17:07:14 +0800
X-Gm-Features: AQt7F2pgMp0e7-268Bxr47VfBc0T8fY326idWgf-BRHx2clhCS_An9Xn84B51Lw
Message-ID: <CAL+tcoCLqr1HjnPZ5BvgEzE04C+KPbTvUe79Vy-=d5KEbmqZuw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid
 touching a cacheline in sending path
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:55=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/4/26 2:21 AM, Jason Xing wrote:
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 6bf84316e2ad..cd5125b6af53 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -91,7 +91,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struc=
t xdp_sock *xs,
> >       INIT_LIST_HEAD(&pool->xsk_tx_list);
> >       spin_lock_init(&pool->xsk_tx_list_lock);
> >       spin_lock_init(&pool->cq_prod_lock);
> > -     spin_lock_init(&pool->cq_cached_prod_lock);
> > +     spin_lock_init(&xs->cq_tmp->cq_cached_prod_lock);
> >       refcount_set(&pool->users, 1);
>
> Very minor nit: moving the init later, after:
>
>         pool->cq =3D xs->cq_tmp;
>
> would avoid touching a '_tmp' field, which looks strange.
>
> Please do not resubmit just for this. Waiting a little longer for
> Magnus, Maciej or Stanislav ack.

Got it. Thanks for the review.

Thanks,
Jason

>
> /P
>

