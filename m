Return-Path: <netdev+bounces-88025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E68A55E6
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE3F1F21C3C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D4374E37;
	Mon, 15 Apr 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3q7TmhH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0E74E11
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193460; cv=none; b=noBgdKL659YyDqe5YhbyDtnnras6kGICUwc42rQ4EOnM3QZL/p2ZvyY43Iuh5073aUZmw/P+DP/Id9kIUNNNHmME+6IiVO0X/rOkWR9L4mKYiikkraY5FWaHvwga8joQL+jtPTLLm7osR+HdXAbjvCQCnK8dNZkjt9IY0WtdITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193460; c=relaxed/simple;
	bh=LYd98pn3PtdxSBhO8EuBiON0XmezL6SZW2cEu7gJQBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crmFtQ0qJvQOi11ObsH/CYFAZ6Trd7V9evcqEuY6dnLE73jqYyWFbnBMj6Dxmm4gcYu+Nh3Y7aGPLtRJ/8rSksTL1U7qwe4FWr47M0EUe3HV2a+do5SFYWfNXnRDk1+ZoYXrsn4ErDxdFt2TZoOPZ8nCcd8d0hUE6ABxopUQGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3q7TmhH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346b94fa7ecso3230192f8f.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193455; x=1713798255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40pylgvxF23nEwl+KNR2yaTtWuwPDSSlPVOVODZEU48=;
        b=Q3q7TmhHXj3sk7XnuS6Tr/XUU6oO0roW+YMjOCxvcH2XpsWZlh1XQfY0f8COkcRCxI
         18KIU0AXOMzBZyrnA4+IG4kjEF2J5TbGQwEGgSWj//Naewd/JpYSCMHlqL4/sz4A6dDz
         MWiimDaogYdcrEW34ZwOpFtgaKDZG7KRW1emX2JG4Z8/JjMJmOqDi1Tf5fwbMlJi3K7I
         65zZuusPiQnbUXGFlU+D67CY4PuWaPw+4nrno8vSJTVK/MVpm9N9EPaa+Qox9oSnKuvl
         VB8AIiSOTixiMQsurW4/iDSfJ35RK08NVXDDaeevGEbD+wGDB1egIxez9mseueTf8X+6
         DcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193455; x=1713798255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40pylgvxF23nEwl+KNR2yaTtWuwPDSSlPVOVODZEU48=;
        b=a6N6WI8JoySDeqE46EVfTGpfvLDLIOQnJgnDMa0lME45wluZmc0P/cIgf3xNeveM3A
         nh8b96JmxrxbfupkT1vMdW60tUydb+XD0Gio/3OlL/5WRpD0DSf1/pur/10lkktKheVA
         e4j3ZYLzsc+Sui6WDt/0m8tTfoIR5MUhhH6WGIMCnYgC611DajVqobJP8r2218q0mhSh
         z2PYmGdmvM+04vo/tx5PbpDXcNLOnQL48wBLrKKrZdZUjr1+h0olO1acQLHOirAwgUwC
         3xor0w3zS1eVmKIvTXBOXS+3WOkVh2vKVbC8PITgwxykCrdOXA37cBBtJd493ZYT/HtV
         z//A==
X-Gm-Message-State: AOJu0YyHZR0PAzrWyBzwtn7gop+WZGNzkJUPnsWfKLuK1bfY4XI9hPxb
	HfsyXYa9qbCl/za0G9ioYQRx88/b2o+9lxuSkXCtfC45DSifCrOM7bX7SB9SLTEWD/j1LJeZfbS
	xJlBJV3i6oD8ofNf4UAEyVQiGmZA=
X-Google-Smtp-Source: AGHT+IGhw/8vB4HVhC2Km3IiQnXPD339dmoURt/Mg4hj4e8cG9kC1Vzqe6ubASYa0vXCHKVxvpJWpedmz6YZsmeSNZM=
X-Received: by 2002:a05:6000:1d86:b0:347:e6ef:ea97 with SMTP id
 bk6-20020a0560001d8600b00347e6efea97mr1720521wrb.24.1713193454978; Mon, 15
 Apr 2024 08:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com> <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com> <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com> <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
In-Reply-To: <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 15 Apr 2024 08:03:38 -0700
Message-ID: <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:19=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/4/12 23:05, Alexander Duyck wrote:
>
> ...
>
> >>
> >> From the below macro, this hw seems to be only able to handle 4K memor=
y for
> >> each entry/desc in qt->sub0 and qt->sub1, so there seems to be a lot o=
f memory
> >> that is unused for PAGE_SIZE > 4K as it is allocating memory based on =
page
> >> granularity for each rx_buf in qt->sub0 and qt->sub1.
> >>
> >> +#define FBNIC_RCD_AL_BUFF_OFF_MASK             DESC_GENMASK(43, 32)
> >
> > The advantage of being a purpose built driver is that we aren't
> > running on any architectures where the PAGE_SIZE > 4K. If it came to
>
> I am not sure if 'being a purpose built driver' argument is strong enough
> here, at least the Kconfig does not seems to be suggesting it is a purpos=
e
> built driver, perhaps add a 'depend on' to suggest that?

I'm not sure if you have been following the other threads. One of the
general thoughts of pushback against this driver was that Meta is
currently the only company that will have possession of this NIC. As
such Meta will be deciding what systems it goes into and as a result
of that we aren't likely to be running it on systems with 64K pages.

> > that we could probably look at splitting the pages within the
> > descriptors by simply having a single page span multiple descriptors.
>
> My point is that we might be able to meet the above use case with a prope=
r
> API without driver manipulating the reference counting by calling
> page_pool_fragment_page() directly.

My suggestion would be to look at putting your proposed API together
as something that can be used by another driver. Once we hit that I
can then look at incorporating it into fbnic. One issue right now is
that the current patch set is meant to make use of existing APIs
instead of needing to rely on creating new ones as this isn't a device
others will have access to so it will make it harder to test any
proposed API based only on fbnic.

