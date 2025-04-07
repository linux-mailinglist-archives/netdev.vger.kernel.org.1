Return-Path: <netdev+bounces-179693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C5A7E2C7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDA217CBE2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534061E25F7;
	Mon,  7 Apr 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdxIJOEa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2B1E2616
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037050; cv=none; b=aiiZlYj+cgDVi7ws1jKfJ0T4EDmaFXwWTF0HrhEOlI3hSDeg5N1WXrBWXcgse9sufh4EF5K++8EvRh9TCsYje9Ewf02MNhdFWlX1Epaqx9M0SV54f/4UWVuIFdFPkNElfYBs8citUb9IvmC/2KfItXO0ai2dcvJxH3J9mwElz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037050; c=relaxed/simple;
	bh=iAFgVmh1qXM0w1IR6tvKw2avKjMqWvNH45/oak3cYuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1IaGb6KGYuitP+SM9JaDqF1PgNC3EjRGsD/T/WFdg67BUTtboGm4ZSxWCt4XjLMku6uxBdavjmfKh3O5hRKLbqT8LzYuJWRrmhkFEnPWQFiNJrPdZPSafkkFpgE2QKjPzDntjNPSRr+W0hHR734ZKuaJ0pGjHcL/S0YYr4lR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdxIJOEa; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8641b76c455so241136241.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744037047; x=1744641847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Syn5jtXviACUgIGCUheG7PeZdWX6IDJJuYZ5/CxssQ=;
        b=jdxIJOEa+hj8dWj14HwWILMrAok06a36XmqOTdNy/sGe94nhDQuNKoQBvy1u1RUmXY
         FKapf0cV2q1eoI4E11NThGZ6ctas6ibUMxFbHZhsWNLdCHxngDXgW6JUiEA0DnfRpC5U
         P3+jCdvd1Krv+sPg/tXvND/L/oAhWpWnVf53RtCl/G7YidRqiTwEkHKmv8HrxWRf6h0W
         txQty8lN+lKt76R2qGSiWEe793RxlXxx6BvwmbEJiA/iMoUzUfS3WtxahoLHBhYUuDkV
         mWG/bbzvMZpaCq4eES5KjxbF5CdjEFeF4PXtI7eZrOfqwcrSbDjn18MIRGEyGnQYstBE
         1xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744037047; x=1744641847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Syn5jtXviACUgIGCUheG7PeZdWX6IDJJuYZ5/CxssQ=;
        b=FZIX09q3Baky588K9xMkgFj95Ee37N63NDJWFE+2CtReZZ9vUeqF/Ewe0qkkm/rSWL
         U1qwJqa+8soN7V3BHzUOtmUoSGF4FOUtW1HWH4pSVUVnl4oGKWTLFMy04QZHzGDZqwac
         NgrRn+IJPLvTSOslugeJovtwifZ9wIP0I7Do69A1yWP/3TeadonwQOLMmeko+MRBy6Sv
         re6D5nri08Eb+yARghmj8Zc8LA0zgLDriXwChZR3y0NpQwSyqbPAsauuCASAuq58U6pp
         yVsK6ExXnr4X9SEOvGy+otUdkQCvJW76sQapA518tmVDSygz6CmKo/7oZPLIg3BStgxp
         RS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUOWgJFQgZp/Pjya5RwrW/HsFqiUo6Wg00h01wWcrhuHyJEgflKLY5iONXs9Z22A6Ef1jiSIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Inbo2f6KiB89K/rVR+hDOMc3+H2msLwmfQ8lTU1Kd6ot1FWD
	SOvWx6pbGt8v9ruKareaaPTKgDwmWp5Wm2NF6pt/QAhTqdtbQwAB6JbtTTbaT6YQiue10FpAaHi
	kJBIK0mkogxtIRLS3Uz0V2TT+bQ==
X-Gm-Gg: ASbGncsc0pqEX7WEDBfTmMBZSfcCnRQcuIHQ13fI+R7o+0f7E963XijLakV4y9ARrI9
	y74/wkA7sza0cbbsNH2czoUhN7w/hso9hdTceR60XvPdi6d3eh2Xlpflj4IM1Uqt3Pq9LI4qvaX
	F4okMuYo2NkCPyShRqQ50z62uqJqU=
X-Google-Smtp-Source: AGHT+IGNPP3i83/VvPK7WNbXVFQ42DqU/EqMe+KtLDyE+WIfZWrz6Enlu5ttJD2ZTPHhqTRHjXZ98T/zOwlIfbByE04=
X-Received: by 2002:a05:6122:902:b0:520:5400:ac0f with SMTP id
 71dfb90a1353d-527645793f4mr2964661e0c.3.1744037047495; Mon, 07 Apr 2025
 07:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250406192351.3850007-1-chenyuan0y@gmail.com> <Z/NjXSRVFp9c/XmQ@mev-dev.igk.intel.com>
In-Reply-To: <Z/NjXSRVFp9c/XmQ@mev-dev.igk.intel.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Mon, 7 Apr 2025 09:43:56 -0500
X-Gm-Features: ATxdqUEzW1g5gHLGkmrrnA1qYZFVRpXWMmkf1_wJ_hd8wRs7s4QRFeddXWYjUFk
Message-ID: <CALGdzurKz4D3tzbjY-_xES6VUzzg8E2ALmj3mgiFT=4yX=_aCw@mail.gmail.com>
Subject: Re: [PATCH] net: libwx: handle page_pool_dev_alloc_pages error
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jdamato@fastly.com, duanqiangwen@net-swift.com, 
	dlemoal@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Thank you for your reply and suggestions.
Would you like me to send a new patch (for example, [Patch v2]) with
the "Fix" tag included?

-Chenyuan

On Mon, Apr 7, 2025 at 12:32=E2=80=AFAM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> On Sun, Apr 06, 2025 at 02:23:51PM -0500, Chenyuan Yang wrote:
> > page_pool_dev_alloc_pages could return NULL. There was a WARN_ON(!page)
> > but it would still proceed to use the NULL pointer and then crash.
> >
> > This is similar to commit 001ba0902046
> > ("net: fec: handle page_pool_dev_alloc_pages error").
> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/=
ethernet/wangxun/libwx/wx_lib.c
> > index 00b0b318df27..d567443b1b20 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -310,7 +310,8 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx=
_ring,
> >               return true;
> >
> >       page =3D page_pool_dev_alloc_pages(rx_ring->page_pool);
> > -     WARN_ON(!page);
> > +     if (unlikely(!page))
> > +             return false;
> >       dma =3D page_pool_get_dma_addr(page);
> >
> >       bi->page_dma =3D dma;
>
> Thanks for fixing, it is fine, however you need to add fixes tag.
> Probably:
> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
>
> > --
> > 2.34.1

