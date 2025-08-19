Return-Path: <netdev+bounces-215033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ABDB2CCF6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 21:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CF31C24340
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159BA322A06;
	Tue, 19 Aug 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2yvPoS8H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775D326D66
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631668; cv=none; b=ULdFKCkyrTCgCC5+9NIjNEyTE1/ramexmQsXqEGr55iYnzK5WLqGfQjcbxD1tRbc2ETXBsaIKYTGfD0MT3Usdw7SYw3ZWu5L7bw3PyW17Oc8OsajGyNRrafdDtHxpOQO/AMgF0grwNRVEkw3loAcfrTca84whnVCsAgVA9LFGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631668; c=relaxed/simple;
	bh=BlVzj2EUR10ubBzzoCWGCgBRnjT2tSR4AsN+B/Tx+uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dF8gcFPxdqTaimpX19xebNAdcQplJqdBMnGwQ8tCPEPvvdT2T4m0essamijA7/qsSigvd1deQ38mB6C1bl38NtrmXVnXmEwpTtH5MZy5kBjoINJa4VewScwPkcaGsQ1dcboUgc4KcciNyoCzyrxWDQwPst8BIjGq/NJxzULouGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2yvPoS8H; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b0bf08551cso97391cf.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755631665; x=1756236465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlVzj2EUR10ubBzzoCWGCgBRnjT2tSR4AsN+B/Tx+uE=;
        b=2yvPoS8HQWczeJaM7fx8jeCdrDaBiQmi4SbIn0siSypuiFDVh16Rl2L6b7paZZzsWu
         aQhddtinIru6QmgeVDzpB/rjT+OeRBQHG3pnwufmOcWe3Gmn78Qa5RnxvgUd6h9LR9nO
         srUzWuwWD20Ex6NB8g9qm47h8ybzzzwhRI3/MXMS5BgOSurLoWLhXjf2PXP2abvdtnVS
         qupbU5P7iamPH/DDFRWRlGvOi9wczfTDkJWX/Gf13CPTqK91oCmVFXXkrvrfzig1uo70
         Qaw04YlvGNy3ZluJ2AUhPNmCPmZdujB7/dg9gZoJF1DeLcKRQopTP7CulTrCrcBPQZYC
         lv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755631665; x=1756236465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlVzj2EUR10ubBzzoCWGCgBRnjT2tSR4AsN+B/Tx+uE=;
        b=kzLKtC3zKy7m3W7pzb2rwrywlsOYG6/kH2/vdE8/PVOUdf3L3wIQ72XlNt/WkS4jLs
         8/Jh0pngULM9NrxuS+HXDjyrlvGOCPfjJmNXNc4abXAUkeXvV5UhMbNjZGHv8pjUwLz+
         ioqHeaqudJbyoF09gtSsu/900tKNJDltv0PN+x1zaLKYZ9LitRWxNV27hOE1AY6NNKq/
         qHhUKqzaAV6gAFiNbwZH3S1vq7Sv7Kwqfu5NnvFU8mnVt/sCF65vV9kNw1OFISAvTQ1+
         WTyo7lOocijKXgXrd1d2FAV8Rb4CpUq8UN+S5ySPgSm2BMMQdn99iaLUByxhhhIbwRsE
         lRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRPUGERgMrm9iZMEuetBidRb92YmDw881yVtUbPyJxJTxFDzgvQCKa30HaAU3bBQ1EvZKnYG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvx/ByJyEyizoe+GElZ8laUtAOlaexYKekmH3LubhQ3OZvfWW
	tbfY9zKpNVUezvGG5B6UIWWs6EppZq3d9seG1uCGr01e8uYJWoBCB9j1gTg3RTBmQ7Jj19E2hAP
	e62vlpZPINMdY9pgd9agYpG/wfLSjX43YXuvHq4w1
X-Gm-Gg: ASbGncv8sRHlpp9qALkRBhSrE7DCOXlTQGIuYBn3L/UNW59foz6Y6zDiJYT6bM+lCYO
	z+jDu251fQRm4LrCCp0YUYZ1XzLuSRcCfBLIyYINMgskMeLYtdQKv6XVNcFAdHa6A/IowWlLqOt
	n91z0jVV/gchhFWombsueL5PJ7QcgaM/WOKQuwrHk8WBnb5bUQw0y0ACQxoDWCYYYtkj78saTA2
	3LY0s9aat77W7zn+AIfef2wypHDJ20DMf8k+UcrHzrInrcvGviYlIQ=
X-Google-Smtp-Source: AGHT+IEDWpSWU5ZzY/KJckLXK1MXb3iQFKIaTTR+UKAO1//noOtBrDSrcuDwJaJI6GftEm+TVmZKste1iti0T0BhbeY=
X-Received: by 2002:a05:622a:156:b0:4b0:8576:e036 with SMTP id
 d75a77b69052e-4b2916cdeffmr923341cf.0.1755631664504; Tue, 19 Aug 2025
 12:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <d36305d654e82045aff0547cb94521211245ed2c.1755499376.git.asml.silence@gmail.com>
 <CAHS8izO_ivHDO_i9oxKZh672i6GSWeDOjB=wzGGa00HjA7Zt7Q@mail.gmail.com> <ab60ab17-c398-492b-beb7-0635de4be8e6@gmail.com>
In-Reply-To: <ab60ab17-c398-492b-beb7-0635de4be8e6@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 12:27:27 -0700
X-Gm-Features: Ac12FXzollJPprpvLpQ4-IC38LVTaqJboHUEkHUZ0bfbl4-1_1fZtat3-UCqxVo
Message-ID: <CAHS8izPuZRsrBXaQoTNBPyisEo3w7J2aF0qyyOOnUAV=2-8o+w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/23] net: use zero value to restore
 rx_buf_len to default
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:51=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 8/19/25 01:07, Mina Almasry wrote:
> > On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> From: Jakub Kicinski <kuba@kernel.org>
> >>
> >> Distinguish between rx_buf_len being driver default vs user config.
> >> Use 0 as a special value meaning "unset" or "restore driver default".
> >> This will be necessary later on to configure it per-queue, but
> >> the ability to restore defaults may be useful in itself.
> >>
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >
> > I wonder if it should be extended to the other driver using
> > rx_buf_len, hns3. For that, I think the default buf size would be
> > HNS3_DEFAULT_RX_BUF_LEN.
>
> I'd rather avoid growing the series even more, let's follow up on
> that in a separate patch on top, that should be just fine. And
> thanks for the review
>
> > Other than that, seems fine to me,
> >
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
>
> With the said above, do you want me to retain the review tag?
>

I initially thought adding my reviewed-by would be fine, but on closer
look, doesn't this series break rx_buf_len setting for hns3? AFAICT so
far, in patch 3 you're adding a check to ethnl_set_rings where it'll
be an error if rx_buf_len > rx_buf_len_max, and i'm guessing if the
driver never sets rx_buf_len_max it'll be 0 initialized and that check
would always fail? Or did I miss something?

--=20
Thanks,
Mina

