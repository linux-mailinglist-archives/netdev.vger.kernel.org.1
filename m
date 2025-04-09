Return-Path: <netdev+bounces-180579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB05A81BB2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC893BCE1D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF64C19D087;
	Wed,  9 Apr 2025 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFChpnqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85D442C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170598; cv=none; b=qj2wmmhDK4qMGnjFCHaztEJYCpFvXw1F2coE+dF9dPPGri3mGOm1h75nPzG2b7h3Px+KFzx5Bu2/ZqUoWF7dEfyBi0B+shpP8mmBCCkbHSXJep5lagVeaScAy3cJylYlBjmicKxf/eIKN5gITmepJ4f8SPJOXH/fQIxyI07YRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170598; c=relaxed/simple;
	bh=Krc3Q+p0VBO5BnzuxV9D92UBb560zcRb8Pion/CJjrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAARy4eyZnUaIjEdBGZJLoI7tDJBIjggn7k5USQzh8WD/+KsfxnYwi4uUPfrbPX0VgR40IKem+jjhoyzDqtphUOQvZ5zgrZDIdvhZUrxKTjiW0bumWzjZKt+XA2JTwccmV+FanGCyRsClpPd4MuZGdaWs0r+t8XxykqBZ8iY8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFChpnqg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so10390179a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 20:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744170595; x=1744775395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+8wIbHOqaloYleMqj3xFsn1RgoCWSeTQfC/eEp4xqg=;
        b=dFChpnqgKFb3SbkclPTDkJg+Q0Gql2PWAxz6G70qiCXdQ9XdsXKC8ACDdpCBkMuBUK
         D4bdFPgU8TG/N2+Nt/P/HQFay6/T9itooFkt4Sl8GZYIobz4AG529NWw0F9kHaL4sWUe
         VeYUwSEeviG5DpRM7kf6iaIj98i0ho3IhJWgAv7BQV1TlLUULUkA8j9udSRnNHhx/sLN
         us9xb28NGkVqeONIrfS/fr6fWAIlg0XvmKK5PSCxtqVayFjmnvtSWvNmEUxyWMKdNMV4
         r9s6OZ2Iaa4JJ6aH4k59fubvffk8EocubiwvhewGSfU80778ni+lQ2sv+LSo98Bwdq7R
         ZrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744170595; x=1744775395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+8wIbHOqaloYleMqj3xFsn1RgoCWSeTQfC/eEp4xqg=;
        b=cQhaL2EoKvKZUrg/b+rEMp5WyDSC6n3khj7K0Y2EyuuWtGUg661mhRq/Mf1D/EdPlY
         +jObBqHQMoev9A4Hh+82MHAGPlLFdE72xTw2OT3qew7hw23GWNqVOuJ1O2OtwKbrTUXm
         XSZ/sTZzQaSgBvI0VcuaTSTjRFpVFvravkGAUS2Kmp2UCbsm0RJqomPgtlcl1ukHTb1W
         PIaD759wfngNRwtxbRNjeH6IKixkq+F5IoWFQ0FdloG1ppaYbHTvG+IbIES5r4q3bN5j
         U4wB2HJNnWYzczRc9THJQxA8oBSjiCP+GELkM/njTZBfK2GxwaF7K77RR31hF6jELrKd
         OYuA==
X-Forwarded-Encrypted: i=1; AJvYcCXuYi5ooert37RliI2v1etlt80dXMQIT5dIzrYKaGOFCrftN75ZpsvUThS9flm0XnfHh+sFxmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrzwNsiK4lsQwumXI+SVfWo3O+XBSduPauY9RwBRptLX859Lc
	/wlMxFi8z2ijcU4oixEArUCKTwWLPHB9SR1n7YuYciYysfmsmZuf/g7vZSQbDrCvr154vbU0rPn
	Ixt5lN4V8LR3gPJJQSj0xdHDU51U=
X-Gm-Gg: ASbGncvlKy3qOfEV62y0kbvhrqaPH2nBbZzZZnYVMlzJevQYWsW68iN4HgMwrTS9q9l
	Q2hzsk+JdZeNYc4gbsEDwBjCyXYWnCvShXvFVizDsQXmGjdHdX0oE1kYDUDYZlOTdvzQwRniRL9
	qOgdbh2vjF7bQDFr/mNhALn0bu
X-Google-Smtp-Source: AGHT+IFcYG/Mi127Fd6JvrBAe/BMKy9HpQ1fWxJF2+jpDT9tGcZsbgKkoxlUzm22/FCp9TXT/ApwTTDMx7eHFZEeV90=
X-Received: by 2002:a05:6402:5387:b0:5ee:497:91f0 with SMTP id
 4fb4d7f45d1cf-5f2f775aa11mr1165892a12.34.1744170594806; Tue, 08 Apr 2025
 20:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408043545.2179381-1-ap420073@gmail.com> <20250408185935.2984648d@kernel.org>
In-Reply-To: <20250408185935.2984648d@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 9 Apr 2025 12:49:43 +0900
X-Gm-Features: ATxdqUG7P42SYLK0Ft-_oQQMyfPC1AVyPcj6tPFYJ7bCa8PdT4aHbjIsH78r6Us
Message-ID: <CAMArcTXY-WHxJEC_jOSRbkYbW4eNvNcMcYh-AOa1Rup4-avF8g@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: add support rx side device memory TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, dw@davidwei.uk, kuniyu@amazon.com, sdf@fomichev.me, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the review!

> On Tue,  8 Apr 2025 04:35:45 +0000 Taehee Yoo wrote:
> > Currently, bnxt_en driver satisfies the requirements of the Device
> > memory TCP, which is HDS.
> > So, it implements rx-side Device memory TCP for bnxt_en driver.
> > It requires only converting the page API to netmem API.
> > `struct page` of agg rings are changed to `netmem_ref netmem` and
> > corresponding functions are changed to a variant of netmem API.
> >
> > It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
> > page_pool.
> > The netmem will be activated only when a user requests devmem TCP.
> >
> > When netmem is activated, received data is unreadable and netmem is
> > disabled, received data is readable.
> > But drivers don't need to handle both cases because netmem core API wil=
l
> > handle it properly.
> > So, using proper netmem API is enough for drivers.
> >
> > Device memory TCP can be tested with
> > tools/testing/selftests/drivers/net/hw/ncdevmem.
> > This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
> > 232.1.132.8.
>
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:1262:14: warning: variable 'map=
ping' set but not used [-Wunused-but-set-variable]
>  1262 |                 dma_addr_t mapping;
>       |                            ^

Thanks, I will fix this in the v2!

Thanks a lot!
Taehee Yoo

> --
> pw-bot: cr

