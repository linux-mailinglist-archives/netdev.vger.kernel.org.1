Return-Path: <netdev+bounces-170111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BBA474FE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 06:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EA1188ED11
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B31E8344;
	Thu, 27 Feb 2025 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl2tAF7B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5A186E2D
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632421; cv=none; b=lgbWY/N9H598JKrwcf5vt3R4MON6wOz35d6EVEyJfeJyioDqAI7sr9DctDzk3qNuHNOVGl0oZU/XOP+fdZseYXhqKeEGi/QEa+tHGAAix/6qHgbo6AA76bjXeYvr9YJkMH+kOiHbrXP5isI6mGjI+9/keRhVf0F1f8b72d/M+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632421; c=relaxed/simple;
	bh=cH9ADhDyyzTH6t90hkfT2m+dij4Q/TZDKGKu0TYJDwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2XE/6jzrKE9ROC5SqJJe27Usfr3i8MbxhCJQkrXTZn30EKGVWz3ngsYTZ61UiMeUUhpwHBttK4lx+8MWN0JvFBSr0nm6lLDZIQ8hyU7Em9fFlPlrj3K4CEabMAOK1z/vwFjUq1hrZvximjXwfgMePqlabv3T/dARoHkXLT6csM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl2tAF7B; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so612476a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740632418; x=1741237218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH9ADhDyyzTH6t90hkfT2m+dij4Q/TZDKGKu0TYJDwk=;
        b=gl2tAF7BTDpAKGhNEgnULyI9JHskgcSSCXlylUTOaWTZXoIYW34PANujcd35h54ciy
         lcF2vCZrjlSmiGzAVBsh3A29eg4uLMaOMpsxHOGErZvGDKzbp4ULRiCgJuk2wIJIxRA0
         tizNrgCR48+AyJhI6EukQ5IAUPNu0oGesXyvHr/ciuUeHWZd5eCzkidDXG/zVPs9CO6J
         8MfG421xlyZds3UzN7cn9OzXMPrEnqv9VdHWnplaDHvUsN5gJNavolI2MyKGaD0IgP3V
         m+w0JWH1tWKHOgY62uYGWNNspn5EiHP58To86gWzv5g8m3H49+mOBofmINkIByEf/tqk
         BqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740632418; x=1741237218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH9ADhDyyzTH6t90hkfT2m+dij4Q/TZDKGKu0TYJDwk=;
        b=vf1avyh6h2l+hLBNqdjJWsTTqQBFhgWavpOKoWuAoXDi17SvNPmbR+Sn3fvorj9xJ0
         xKECQNktEY/WnlOmTXFiPktkmRf6eeXZmHhNnoZZssdBo5rZuCXS3hjsS2+vj2w57bJG
         18keW6RsKkZAYOI7uLBlAbXqTZxYYyyWPgYdgAdMkaYXfDTRa2VA48Qis1RBxycoUlpg
         mfxCmoK0lprctOP65ZP+/iEN7w998lkRgkGWnZi+Y5WDspnScDmymCj55g9RkR1oBAvc
         UDL31b+RDmZ8HDq8i0uXKx+REp3FWgts6h9GL8FgL2YMFHmeUImfegF/8eEnfXxv6zXZ
         V41Q==
X-Forwarded-Encrypted: i=1; AJvYcCViyuPoZpk+1E5aAjR10hL2hrhwjopDmcX1KrOBYLLcsuvD3T3/7f4Wj2WsNcpubSUGSwPxcec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqkE6UuWl8krUj//vShgT0HgEPBU3Mqk8t5hJeMpzUNHOLS5n
	3GHfivzjvzOGX1PyUE5V3ut+/GxY9OAOvfwwprtdC7VxYSLFFOJ6DsQ6WI9fcnZ97vFBfH0+Gms
	4aqnNMkyxZxUZNMyiYnTKYlaTrMg=
X-Gm-Gg: ASbGncsy3yNPwBMMJ0GutPqZGeKDaGOpICch7zWhVXwY7w0nRc/Xy7NPhgqfe2n41Oq
	bGoQWmqbInL4kRV9YxqdC/losj/UXkHcUwgHHzIQr3fk6VaoEzGYiIG05a9bTf91IraoDrOGnpY
	4fLVfpaS4T
X-Google-Smtp-Source: AGHT+IEseA0D3pEUnkbra8fYAnp9NqRKGagbPXaFLuxa++Cz7j1QBEqId/ncNSTTyyq1qa5ZGWJzSwsC2bPh08jUMhI=
X-Received: by 2002:a05:6402:40c6:b0:5df:a651:32ef with SMTP id
 4fb4d7f45d1cf-5e0b7231cadmr25986265a12.27.1740632417638; Wed, 26 Feb 2025
 21:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226061837.1435731-1-ap420073@gmail.com> <20250226061837.1435731-2-ap420073@gmail.com>
 <20250226180729.332e9940@kernel.org>
In-Reply-To: <20250226180729.332e9940@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 27 Feb 2025 14:00:05 +0900
X-Gm-Features: AQ5f1JqVuvL1ivFyFv_nKC4sgrkPDONDG5loxmr602eO1pUkcLFHoMHWLd6WOp4
Message-ID: <CAMArcTWTV1FBi1vob7M8=vBQrn8LaVf1PB_193EffzmTAwVqWw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] eth: bnxt: fix truesize for mb-xdp-pass case
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, gospo@broadcom.com, somnath.kotur@broadcom.com, 
	dw@davidwei.uk, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>

Hi Jakub,
Thanks a lot for your review!

> On Wed, 26 Feb 2025 06:18:35 +0000 Taehee Yoo wrote:
> > When mb-xdp is set and return is XDP_PASS, packet is converted from
> > xdp_buff to sk_buff with xdp_update_skb_shared_info() in
> > bnxt_xdp_build_skb().
> > bnxt_xdp_build_skb() passes incorrect truesize argument to
> > xdp_update_skb_shared_info().
> > truesize is calculated as BNXT_RX_PAGE_SIZE * sinfo->nr_frags but
> > sinfo->nr_frags should not be used because sinfo->nr_frags is not yet
> > updated.
>
> "not yet updated" sounds misleading the problem is that calling
> build_skb() wipes the shared info back to 0, but it was initialized.

I checked again after this review, and you're right.
sinfo->nr_frags was wiped in the napi_build_skb() in the
bnxt_rx_multi_page_skb(), this is called before bnxt_xdp_build_skb().
So, this patch is wrong.
Thanks a lot!

>
> > so it should use num_frags instead.
>
> num_frags may be stale, tho. The program can trim the skb effectively
> discarding the fragments. Maybe we should fix that also..

I didn't think it through, Thanks!

>
> Could you follow up and switch to xdp_build_skb_from_buff() in net-next?
> It does all the right things already.

Okay, I will try to switch to xdp_build_skb_from_buff() in net-next.

>
> > How to reproduce:
> > <Node A>
> > ip link set $interface1 xdp obj xdp_pass.o
> > ip link set $interface1 mtu 9000 up
> > ip a a 10.0.0.1/24 dev $interface1
> > <Node B>
> > ip link set $interfac2 mtu 9000 up
> > ip a a 10.0.0.2/24 dev $interface2
> > ping 10.0.0.1 -s 65000
>
> Would you be willing to turn this into a selftest?
> The xdp program I added for HDS recently is a PASS so we can reuse it.
> 29b036be1b0bfcf

Of course, I will add selftest case for this.

Thanks a lot!
Taehee Yoo

> --
> pw-bot: cr

