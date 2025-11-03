Return-Path: <netdev+bounces-235265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE2C2E655
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E1594E10D8
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FC2FC89C;
	Mon,  3 Nov 2025 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaZpRgO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF272C11CB
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212413; cv=none; b=FrDnX5Mn6tkVu0xPEbNo6W6cMm5+9tsyciZm4VBvLbXXvalYOFjAyBZrzyZrSsc3QQSzuxAXukN30VeK9Olf+oNSOZmhajC9uvC3NcCmqkIBjAsaoH1gwzl1ZZad/2yv5yqXMJmKSpz05Fr4gIxcZy8kSPOP/n8RLFRrhyIeD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212413; c=relaxed/simple;
	bh=2HcRl+AUUNPTADPQiQNaUf5DmXSD5QbDI8DNpa9myjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2PBqif+UFELu3DOMnOv4uApMlwrgt7TVGqbdLwhvWbcINQjQlLmPYL2+Ly0IFjDmVQbqDuDxjJYD8KB/Bgy/M9iOd+esvhQvns6dTN9mW90fKSruA6U1c0mrT2PPHcRIm2cvvR50buCrIeJHHu+eoVjCj/7ki+ZZwQw61MWJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaZpRgO7; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-433258101ceso18923005ab.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762212411; x=1762817211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7HIfct8/HpEvf2IuhNdVp4Z2eFKKL3FAierXwcqD2o=;
        b=aaZpRgO7cT6d81DDbVVLNogDTkd59ZWazm5K29+u1YH/krwNQMdzOR1HInSI9qBMt9
         MvMqt3ow0Eg0xXsELAPSzrgJeG0g+GlF2CFNIvI7oZfY071UD9QtG7eV0VixgV900oMy
         7tNnZyo4A1IVY9L9vOwjK4aTxvoT3LjG4ngj+r3OI+eaK+4NQyteEWay8zYmwsMBlNVj
         lOgHJe1G8I5ic2REc85x7ykYElTvA8nlO5ttaA5XycSOtBp4t7qcP3+Mr3L5MWKy9ymg
         ke2dFip/uDFa8fS2Ps7/DJthbsSvPvkJMs8+UHmklpsFJ6AG1d2hjIKobs55mhTnf3WC
         ujqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762212411; x=1762817211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7HIfct8/HpEvf2IuhNdVp4Z2eFKKL3FAierXwcqD2o=;
        b=OB+ECcg4yYTtvg9Vqo5kKak3wabHol2vgnKItbOA9VSi6+cDQcS8M6cad0XC4HfXch
         fm5GYwzhqHn6+aKfILv60jilKTKRJ07N0ZrZwmEooiTkeTMSyPALnYJ7abXoV1BJa+zJ
         F+/Ruu1RXoFlsatirxfWygdk+iw35oHHgsf1QIkEAkzMPDa/YMVDDAjaWcb+6NeVxVb9
         U+XgQXcEM1UXVWSE/zZft5HnCfjyJmbDSHrM41EM+ioKQNMBM5mbSVUFXqH0yUt2xLGG
         VGWlURJpt/P1FcIHenoZps+EOLRPpV2yzOORoSaxeTQw6k7hnufJG+z9eLRUe52wfAaG
         MRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDAk9u4kcPzQVwqKsaRffR8b+17vGNl+3YTU0GG0L3Dj40GZzIga5N9EEMEgvLe82lY7VyG1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGkx6FOLbomUD3Byxf3sucrgIDC/jwwWTFWGAi6z6P0Lo+Zss
	eH9ReZulUqGQsizgEXk7wbceKzVAY+RnJYtnUj0ZtcHH0LdPcWDqS6rXquMkiCwyzFU9JjYgS/W
	qAzaS2ksmNoRCZ0BUCWTHZWyG/OX5oSA=
X-Gm-Gg: ASbGnctMs6/a7ojJEmLHJEpPvOtW6MTg7nnpslxnSB2+B48oU9Aheo5lbrmXgGUYTrp
	cZozSS2rgKpKcYwkopLfDcBRjNDleItFUIf9yL/BnnMY1ShDvxZFM90TWKOz2OQN1N5MXTFv0l/
	dQ7U3au7PhLi16MNnVxCOURV3vjq8t3KClw/A1/vFUMgMkap90upg30D23H9yp4akfDBsfLwIpa
	7n1HAWIGJ1kgTVmqgN66c1qXpz5oNBCw8pMQzHkXeoV+EDhA++KK95HTRDP4b9sZtslI3EnfA==
X-Google-Smtp-Source: AGHT+IFgDdSPeMwWNo/N5tqJEPbjhTUVEBZiQsXzkOfNXUji3qvPg7ylnisoTb13G+AXl8IMUYAXe0pwmpE8JqSZOBg=
X-Received: by 2002:a05:6e02:1524:b0:433:3102:b107 with SMTP id
 e9e14a558f8ab-4333102b578mr60244835ab.5.1762212411099; Mon, 03 Nov 2025
 15:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030000646.18859-1-kerneljasonxing@gmail.com>
 <20251030000646.18859-3-kerneljasonxing@gmail.com> <aQjDDJsGIAI5YHBL@boxer>
In-Reply-To: <aQjDDJsGIAI5YHBL@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Nov 2025 07:26:14 +0800
X-Gm-Features: AWmQ_bnPk4jKKtljON0RlrLgyCVIMv8791yxEbigSYJfuxnc4RHAvD-hc2N8gtc
Message-ID: <CAL+tcoCx23rAbzFTh=78mdC_7a_D-XLvi8yvZkc9Sbj74MANcw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] xsk: use a smaller new lock for shared
 pool case
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:58=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Oct 30, 2025 at 08:06:46AM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > - Split cq_lock into two smaller locks: cq_prod_lock and
> >   cq_cached_prod_lock
> > - Avoid disabling/enabling interrupts in the hot xmit path
> >
> > In either xsk_cq_cancel_locked() or xsk_cq_reserve_locked() function,
> > the race condition is only between multiple xsks sharing the same
> > pool. They are all in the process context rather than interrupt context=
,
> > so now the small lock named cq_cached_prod_lock can be used without
> > handling interrupts.
> >
> > While cq_cached_prod_lock ensures the exclusive modification of
> > @cached_prod, cq_prod_lock in xsk_cq_submit_addr_locked() only cares
> > about @producer and corresponding @desc. Both of them don't necessarily
> > be consistent with @cached_prod protected by cq_cached_prod_lock.
> > That's the reason why the previous big lock can be split into two
> > smaller ones. Please note that SPSC rule is all about the global state
> > of producer and consumer that can affect both layers instead of local
> > or cached ones.
> >
> > Frequently disabling and enabling interrupt are very time consuming
> > in some cases, especially in a per-descriptor granularity, which now
> > can be avoided after this optimization, even when the pool is shared by
> > multiple xsks.
> >
> > With this patch, the performance number[1] could go from 1,872,565 pps
> > to 1,961,009 pps. It's a minor rise of around 5%.
> >
> > [1]: taskset -c 1 ./xdpsock -i enp2s0f1 -q 0 -t -S -s 64
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/xsk_buff_pool.h | 13 +++++++++----
> >  net/xdp/xsk.c               | 15 ++++++---------
> >  net/xdp/xsk_buff_pool.c     |  3 ++-
> >  3 files changed, 17 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index cac56e6b0869..92a2358c6ce3 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -85,11 +85,16 @@ struct xsk_buff_pool {
> >       bool unaligned;
> >       bool tx_sw_csum;
> >       void *addrs;
> > -     /* Mutual exclusion of the completion ring in the SKB mode. Two c=
ases to protect:
> > -      * NAPI TX thread and sendmsg error paths in the SKB destructor c=
allback and when
> > -      * sockets share a single cq when the same netdev and queue id is=
 shared.
> > +     /* Mutual exclusion of the completion ring in the SKB mode.
> > +      * Protect: NAPI TX thread and sendmsg error paths in the SKB
> > +      * destructor callback.
> >        */
> > -     spinlock_t cq_lock;
> > +     spinlock_t cq_prod_lock;
> > +     /* Mutual exclusion of the completion ring in the SKB mode.
> > +      * Protect: when sockets share a single cq when the same netdev
> > +      * and queue id is shared.
> > +      */
> > +     spinlock_t cq_cached_prod_lock;
>
> Nice that existing hole is utilized here.
>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks for the review :)

Thanks,
Jason

