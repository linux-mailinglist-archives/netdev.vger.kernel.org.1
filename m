Return-Path: <netdev+bounces-178495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D5A774B7
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E850B188DC68
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6991E2606;
	Tue,  1 Apr 2025 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX8ZUeUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016B1DF261
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490106; cv=none; b=KUxrT1xtwx56lcMCmfLTodV3IFE8R7RsLlw4iwzKbrTDNyOyrnKQC+USbGlEvOcvXWe3uj5WFy5nYb5ow6IdnGhx3h+pKvpKCGoPnywdLlU3pD5mlARKQ7IsWTqYgBig2BlPebcti3Fhkyd+ch4qRKsnDsdfsMLVvMCnkTCoS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490106; c=relaxed/simple;
	bh=aWTMd0n/WGt5QHM3Y3BeRPkvR+LKpzjED4zv2rp+2z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqKJf536nF/XO6s4XSVj5S45MGBUnKNtRJFi71MOTldmuYZI54dk/m31fIp56LqCDeqQvHaKz1bp2g14q+NpVMwv7Y+9JgeM2z32V1thoM4zQgkz2wF1h7/ktrsNFj/DSy5pQxQ9kVHRvBTct2zkxw243W95nFKmpiYBbIfcVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX8ZUeUS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso2953987a12.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743490103; x=1744094903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttfHQMhkIn+oSS1IOHBwzHwIzCdKvXbxdgLxXrmA4ZM=;
        b=KX8ZUeUSN43JsTB6kXj8LyChisESEmgJ4B3lD94rtz0ZcyaIO/9f/U4BIe+kFWzU4E
         8BfiK5Rmuw72q+zH0vjJZwfelMliX19N283lfTWc+hJkUfe0EE/GhaUi3ew+yqiio4Jg
         ekmg77raa+QzFvD1BpYXnkvRdToNRCUpjwhGSEaFC0wEKdFChy28ZdN7Q+wbskMlYmOu
         CzIazPacG5MAygGocRM+uh/WvBOk4NM3LvnU77SBLKx0s7QLMxq5v3GYOGnSncnhEXP7
         1YfNNZj+OQSFUTR7xRva6dfjIpGSVjziQ+xP8qDn0ex67Jy0nwEgCeihz2+0VUXbvNlW
         mP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743490103; x=1744094903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttfHQMhkIn+oSS1IOHBwzHwIzCdKvXbxdgLxXrmA4ZM=;
        b=G/64noGnOjHZUV3ej4e4nSgdytivQODC+9h53taan5fxakwEDv466njSM1XB+f235n
         ryASgI1r9b9Duyyv0h1GN1M/ba7As3DlGUZ83fzTNB3D1cDJvu5nKvng76rJhIUlOXPd
         nUEg/UC2D928R7h6g1GgZYWcLQVBJOse0RONnm2ozzXcu8nV9yJo3izngog7uNkkyxe1
         krCcbPIv7VVG3SsV8dUuMwPVsAAv7P8fPuD01MAph8dVbdIKtuBbhrUQKC1WIyScJyMl
         uX08rWHxFgs/ALORvrgQno0nYXBZSdH9sX0NXb7mQTB+PKE+Ba0ZURpypADdMsaSWep7
         i+6A==
X-Forwarded-Encrypted: i=1; AJvYcCWHEFA6TUC7krXLDvUCoKgmaL/jXVhv0oVKMN0pKTft10vMvqa15zhqjwJSnVIVvQL54yrLfWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5daQd2UGClXsLzzWkVZORjra50hFxfcen1pAzkB2eKiIKtOxn
	2kqNL7n8vZFa31QMOKEluCm36NngUmxxzvlgprrNP+vuD8lObSrYOa2JfBsEjhq4xEZBc7Lhm5/
	CK3gZxGb20cJmyiIj3GSyG1RNEHU=
X-Gm-Gg: ASbGncvnB2vY2yetFGFH1juNUdtMVF8VCUxkDtJ9ppl/KU+aScaLD2iLjP+nZA2KWO3
	BcsGx8qOruCkF83HPn0p02B1bs2W11Bwv6PtVdCwjZB/YUZEwcDf3aveWAKzuYaTZsBiHf61ibf
	7tiiWdGRiJt8VOyvxKrriPZD34FkO3
X-Google-Smtp-Source: AGHT+IEB6HdhgIFT+acktUH3yJ0tlpGqfL4v8YLv56HLTC9NILraErhCPjqlwi6UibzZen2nLqy50xBUUtaSoq9eu9M=
X-Received: by 2002:a05:6402:210e:b0:5de:aa54:dc30 with SMTP id
 4fb4d7f45d1cf-5edfcc04b36mr9010860a12.5.1743490102716; Mon, 31 Mar 2025
 23:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331114729.594603-1-ap420073@gmail.com> <20250331114729.594603-2-ap420073@gmail.com>
 <20250331103416.7b76c83c@kernel.org>
In-Reply-To: <20250331103416.7b76c83c@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 1 Apr 2025 15:48:11 +0900
X-Gm-Features: AQ5f1Jr7M1aS7CTQQ2IRS5FEZcpWMkH-1PKs1vQ6UWMSHcWrXTYemPxvUnq53FI
Message-ID: <CAMArcTVRQnxrLnXPQp4D+F1TMS7SeQLtWTsxaLt8vJ7Gdqfj=Q@mail.gmail.com>
Subject: Re: [RFC net-next 1/2] eth: bnxt: refactor buffer descriptor
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org, dw@davidwei.uk, 
	netdev@vger.kernel.org, kuniyu@amazon.com, sdf@fomichev.me, 
	aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 2:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>

Hi Jakub,
Thanks a lot for the review!

> On Mon, 31 Mar 2025 11:47:28 +0000 Taehee Yoo wrote:
> > There are two kinds of buffer descriptors in bnxt, struct
> > bnxt_sw_rx_bd and struct bnxt_sw_rx_agg_bd.(+ struct bnxt_tpa_info).
> > The bnxt_sw_rx_bd is the bd for ring buffer, the bnxt_sw_rx_agg_bd is
> > the bd for the aggregation ring buffer. The purpose of these bd are the
> > same, but the structure is a little bit different.
> >
> > struct bnxt_sw_rx_bd {
> >         void *data;
> >         u8 *data_ptr;
> >         dma_addr_t mapping;
> > };
> >
> > struct bnxt_sw_rx_agg_bd {
> >         struct page *page;
> >         unsigned int offset;
> >         dma_addr_t mapping;
> > }
> >
> > bnxt_sw_rx_bd->data would be either page pointer or page_address(page) =
+
> > offset. Under page mode(xdp is set), data indicates page pointer,
> > if not, it indicates virtual address.
> > Before the recent head_pool work from Jakub, bnxt_sw_rx_bd->data was
> > allocated by kmalloc().
> > But after Jakub's work, bnxt_sw_rx_bd->data is allocated by page_pool.
> > So, there is no reason to still keep handling virtual address anymore.
> > The goal of this patch is to make bnxt_sw_rx_bd the same as
> > the bnxt_sw_rx_agg_bd.
> > By this change, we can easily use page_pool API like
> > page_pool_dma_sync_for_{cpu | device}()
> > Also, we can convert from page to the netmem very smoothly by this chan=
ge.
>
> LGTM, could you split this into two patches, tho?
> One for the BD change and one for the syncing changes?

Okay, I will split this patch.

>
> > -     dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copybreak,
> > -                                bp->rx_dir);
> > -
> > +     page_pool_dma_sync_for_device(rxr->head_pool, page_to_netmem(page=
),
> > +                                   bp->rx_dma_offset, bp->rx_copybreak=
);
>
> I think we should add a separate helper for this instead of extending
> the existing page_pool_dma_sync_for_device(). Let's call it
> page_pool_dma_sync_for_device_frag() ?

Thanks. I will add a separate helper,
the page_pool_dma_sync_for_device_frag().

>
> The use case here is that the driver recycles a frag directly, rather
> than following the normal PP recycling path.

I'm not sure that I understand this use case correctly.
I think it's like when a packet is dropped or fully
copied by rx-copy-break, a driver can reuse frag directly.
To reuse a frag in a driver directly, a driver can use
page_pool_dma_sync_for_device_frag() before setting ring buffer.
If I misunderstand, please let me know.

Thanks a lot!
Taehee Yoo

