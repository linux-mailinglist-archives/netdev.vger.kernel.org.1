Return-Path: <netdev+bounces-199080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710C6ADEDB1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249753BDD2D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679632E8DF5;
	Wed, 18 Jun 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7rzJfxo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918DA2DFF3C
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252876; cv=none; b=WS2FOYEqS8hAKNSyEzHXS/foPHfXU0EnAUAOlVho/a8Vkq3GVMAf8/Kp1OsW2GVJv9gtSry9+h82b33HBeOy57FfDu0y3TAO57kAxeibnUDA9cV36ZjRVD+QA9gseEHSa/Gs9A9YhSCZaEr3ddlHBeVLbrKPAezYiKwKVU1MMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252876; c=relaxed/simple;
	bh=kT0Spwcq+vogP8F2a8/Wd2vNFi9nvabufuc5xT+bLyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVoO0xTVLHIzF2/jXlGRx7fFRNMAzqD4Gkald48vnWYMfYMscVh/7tFcf2Xnu3Jlt3f9m9XBXA4xepkgLpTFtfJXShak1uREp/PomTQYUEeknfx4YJr8C8/gDbYHwmfJkK96JHkBmueZHTg/2+OIMFhWp4vlcfxp454abuU3v68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7rzJfxo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso12624255a12.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750252873; x=1750857673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILlB2y1mDBr74OFUoZhZeCUrTGp8IjTl6Y5tgDyynyg=;
        b=k7rzJfxo+9mLNSo7YOwZv0PYXKPyPo+bpaJQtb2ltSyqbORCGJS88V0BflmKSdOxYg
         AqbYAep8N/R+tFmw0b5j7XWxzh2dKsfmfRzzk3vN8ihaf3tgA93aZUyYu4jWjo81DdwH
         VTuI0z32apjbUUtyVN7daCMeSkZDHf8U/FJlL82QnVv3+UjSzdD0DTNj01ZWI/Td6jaB
         M2F9dhonFB4ngOPMzG4mUQplibWTwHfJVBB9GQQNiRRS5Lh4Pj1MzRCdFcEG+xI11Fbr
         AxFLYE4GlGALgyskgzVG+4BTASMAzrSQGVCdCKP++o+9y+fzzl2rep6rv7k+DGdASZQB
         rALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750252873; x=1750857673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILlB2y1mDBr74OFUoZhZeCUrTGp8IjTl6Y5tgDyynyg=;
        b=CGkaBHlE7aNmNc4VojghPEOnSAgo0a7FGZQ8e58I4uXyjOvmqfwhCnrGTxuEdSa1xC
         9tu6Pu5g1a0+RPU1/3Ru8nH4St8hjXJ0QrB8gKMgju+8aiw/gjfoLGH5drORQLo+3rGe
         Af5GtlbrT6gmIJdEazpvm7qXbVZOxp1/Y4A6BhMHWeffANh0Kbopa3igN3vyiIOEVMij
         tFomqbbbyUZv6ElEqYVZ/Q4lT7tHHVpycaGrG5BNKXZ39CehKsCxvMuTABPNyMUFMXzr
         HGLIQv5Q7DI6jCoCXOSG5IxX3rWKGpPo/s4BgOhEsQGjDWfZ9QN+8MemSfLqSz/V7Nrp
         IKLA==
X-Forwarded-Encrypted: i=1; AJvYcCXigQ+9dy6TvzmL1j3E4jO2vR0jP4mJNgFc4ui1IsNrOr5/1bobOyx98vgfp+Z1pSODVyLRB7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdTENC4G6SEJPAuNmDEJhU2ZyeLSTK/DKhfXq5ErnVi67hOH5
	9qK0QTAuEt4l5kr94qMM09Nd1Q7aVVDlH1djN3YIEmeNuwcu4oJqb9F1RVq5cYVUECf2wM4nw9+
	qCKUIxQnn0WOn+NE58dDFG3Lm4OPx+24=
X-Gm-Gg: ASbGncuoGhmUQ8YRvND6Uy37re91fmc9DGJ+xyetbpeIqF/D3I4qINDJdBhxtLJWrCZ
	FShZs3nPMA6gnOfnxYZuhmBw9CoxZHSZhI2Ay1KAD3plDvN2V+nrlGfNghyVLtnX7YbkRMOXyUi
	JQLGc74zz1WLcx/vX+XcKlAfCf8asU2PefJbEwma99y3Zh
X-Google-Smtp-Source: AGHT+IHh9IHQiF5HWHtF8YGKvn675M5sQc7BHyjXFld0V7pc0Q44BolF0XABqI94KltSlDplNoXwKFj6lv9bXFeQUQI=
X-Received: by 2002:a05:6402:2786:b0:607:116e:108d with SMTP id
 4fb4d7f45d1cf-608d094bf38mr15081690a12.21.1750252872624; Wed, 18 Jun 2025
 06:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617094540.819832-1-ap420073@gmail.com> <CAHS8izNXHvavBAWyyvwzwFh6CgaBhCnvQvtMsE4B2CHVm206hg@mail.gmail.com>
In-Reply-To: <CAHS8izNXHvavBAWyyvwzwFh6CgaBhCnvQvtMsE4B2CHVm206hg@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 18 Jun 2025 22:20:59 +0900
X-Gm-Features: AX0GCFvcn0tPGH_1iTBLmfJx47U_lxi75NJPo6NONd33qGNxhP_ip0WpSBJpyhA
Message-ID: <CAMArcTVpYct8FP1r3UsVaHDW+fSY6FG9NNmhDfyiTjgCkiYsxw@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: add netmem TX support
To: Mina Almasry <almasrymina@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Pavel Begunkov <asml.silence@gmail.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:14=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>

Hi Mina,
Thanks a lot for your review!

> On Tue, Jun 17, 2025 at 2:45=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > Use netmem_dma_*() helpers and declare netmem_tx to support netmem TX.
> > By this change, all bnxt devices will support the netmem TX.
> >
> > bnxt_start_xmit() uses memcpy() if a packet is too small. However,
>
> nit: this is slightly inaccurate. memcpy itself is not a problem (via
> skb_copy_from_linear_data) is not an issue because I think that's
> copying the linear part of the skb. What is really a is
> skb_frag_address_safe(). Unreadable skbs have no valid address.
>
> This made me realize that skb_frag_address_safe() is broken :( it
> needs this check, similar to skb_frag_address():

You're right!
The real problem is the skb_frag_address_safe(), as you mentioned.
I will fix a git commit message in the v2.

Thanks a lot!
Taehee Yoo

>
> ```
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index c05057869e08..da03ff71b05e 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3681,7 +3681,12 @@ static inline void *skb_frag_address(const
> skb_frag_t *frag)
>   */
>  static inline void *skb_frag_address_safe(const skb_frag_t *frag)
>  {
> -       void *ptr =3D page_address(skb_frag_page(frag));
> +       void *ptr;
> +
> +       if (!skb_frag_page(frag))
> +               return NULL;
> +
> +       ptr =3D page_address(skb_frag_page(frag));
>         if (unlikely(!ptr))
>                 return NULL;
> ```
>
> I guess I'll send this fix to net.
>
> > netmem packets are unreadable, so memcpy() is not allowed.
> > It should check whether an skb is readable, and if an SKB is unreadable=
,
> > it is processed by the normal transmission logic.
> >
> > netmem TX can be tested with ncdevmem.c
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>
> Seems like a straightforward conversion to using the netmem dma
> mapping API. I don't see anything concerning/unusualy.
>
> Acked-by: Mina Almasry <almasrymina@google.com>
>
> --
> Thanks,
> Mina

