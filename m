Return-Path: <netdev+bounces-62774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931F8291B9
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 02:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBF7B241ED
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6063D;
	Wed, 10 Jan 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIPC8l47"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4A81E
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704848724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDuMstrISFSfKQKJSfyzZh7RGQR46ElR13WcY4pdUew=;
	b=KIPC8l47Va9eNKzrhJQhJ6YOCcTmquTrK4CL74mFsEXsSjGxsQqGVvO3oCvEl5gehCKYNW
	vHLUMVxxerFS7x2jqSDVb0dnHKT4jtmCF8+rj8L2osiEWia2mjGvjYoC14IZdMOQjaI81u
	BKhJmmXMaBLEHyZQvrC8VQHd0nH4c0k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-UJkOKFaUPTqKdvTMyRF2Qw-1; Tue, 09 Jan 2024 20:05:22 -0500
X-MC-Unique: UJkOKFaUPTqKdvTMyRF2Qw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e41740b6eso30787385e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 17:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848721; x=1705453521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDuMstrISFSfKQKJSfyzZh7RGQR46ElR13WcY4pdUew=;
        b=ujWdY3Ovm8KxJc0HFH1INnWFEeoovCwGMSaRFGgxnKYBZ89Zh5gJ0kgGKZvijWnIi6
         qVgGykIBm4XWw2oIpCHSVOsXIjByfJ+IT8Z2BjfuZ2YYnuuNrHS/eSHabdUwimhDC0Tr
         FvI6/p96lSjREhPCYnJuGhH/K8PWZpPjnsK8HbRhAq9VSfCOccWPlguXnSwcNcLMI3Dk
         5bphU/vwsvQzRiTspojFWI/X9SKti+ZN37b2LmQxN5Qzmu4M0cQRaozXiZEe3cWr+MjB
         5EoPya3Xuy2j3sX/4ttkC0sTXoMSmkXD5vVDFZFNnrzkc2SuDATil2dPmGoCG0yC+bGZ
         Uvpg==
X-Gm-Message-State: AOJu0YzPxV1C1/B0NLCuC/lkjm3dqFMMkPvj8GCMl2mZgx5likDi3yDA
	rmcLH12n4ME7iTbPQo3bwtCMitxTGzklg2gW/fPRSFCErIv1No0/n9n2i+O287NdF/oZt8qflIG
	+i5WOw2Ly7doEcQv3fDXyHem9GrsOdP0PooFz/k03
X-Received: by 2002:a05:600c:a007:b0:40e:47d1:5929 with SMTP id jg7-20020a05600ca00700b0040e47d15929mr90343wmb.194.1704848721436;
        Tue, 09 Jan 2024 17:05:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO/oKaTYNEjGYuCr6C67mnkh30/qw8eVG3XHpGebumEk5NYxM9UWvntMr2Xi5gnxWSmx+sY1pCCHDJ/5lLErw=
X-Received: by 2002:a05:600c:a007:b0:40e:47d1:5929 with SMTP id
 jg7-20020a05600ca00700b0040e47d15929mr90334wmb.194.1704848721095; Tue, 09 Jan
 2024 17:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108181610.2697017-1-leitao@debian.org> <20240108181610.2697017-8-leitao@debian.org>
 <CAK-6q+jy-0+bZRUKhRsB2RMtpJ=Sw1A5qHk+rpnYaOzV8WFD5A@mail.gmail.com>
In-Reply-To: <CAK-6q+jy-0+bZRUKhRsB2RMtpJ=Sw1A5qHk+rpnYaOzV8WFD5A@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 9 Jan 2024 20:05:10 -0500
Message-ID: <CAK-6q+iMkVKQZjkhFussJ-f62Yza87u3Ep8rtukP_kPk3Ebz4w@mail.gmail.com>
Subject: Re: [PATCH net-next 07/10] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org, 
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-bluetooth@vger.kernel.org>, 
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-wpan@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 9, 2024 at 8:04=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> Hi,
>
> On Mon, Jan 8, 2024 at 1:21=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
> >
> > W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION()=
.
> > Add descriptions to IPv6 over Low power Wireless Personal Area Network.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/6lowpan/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> > index 7b3341cef926..80d83151ef29 100644
> > --- a/net/6lowpan/core.c
> > +++ b/net/6lowpan/core.c
> > @@ -178,5 +178,5 @@ static void __exit lowpan_module_exit(void)
> >
> >  module_init(lowpan_module_init);
> >  module_exit(lowpan_module_exit);
> > -
> > +MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network=
 module");
>
> Here is a nitpick as well. The correct acronym [0] is "IPv6 over
> Low-Power Wireless Personal Area Network", otherwise it is okay.
>
> Acked-by: Alexander Aring <aahringo@redhat.com>
>
> - Alex

[0] https://datatracker.ietf.org/wg/6lowpan/about/


