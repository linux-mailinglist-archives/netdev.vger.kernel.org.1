Return-Path: <netdev+bounces-135085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A799C298
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F741F23B77
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765DA14E2CD;
	Mon, 14 Oct 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6tKQPj9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5C2B9A6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893322; cv=none; b=cEikzRrUfEZ3DuZhwWWeiqVfgbUSI5xpNt4DI+FbfMUAUpV9YS5Epb33cszRH07rBZ5ic0Oltbe8DoUJJwmvTodXyQDiVmQwjLuFnD7E8bgH/hXpJ/6nCrQb9Hm+TKf56NEbWVeYY91pmTrgr1MgseUi47YW/lE9MZ02NGgNdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893322; c=relaxed/simple;
	bh=TaWs/ibx85c0CtG18bNpX/cgoj6kclzeopbcQX6fQ8s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snLCxxFKoW5324qToolp9YGvfPcIgMBYLjnnYm/5kuTUcGymH8ZOhjCDS/cEK8yX0hgWFs0kHV+0mQAwNtM7xpPk+0VpNcBo8SokjBOd6Cc6R3EqbyEmLyJ0+j2lDXXLQNNX6ROe1oGfOVMTNHiogikW+BDuPMvxr5G/MpeVHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6tKQPj9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728893319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaWs/ibx85c0CtG18bNpX/cgoj6kclzeopbcQX6fQ8s=;
	b=N6tKQPj9zsCMEWw4zeDBVfEkkUuyo34Q39WKbRi0IW6zq6906OlXgg3B/Rwlx1uEZRfLDy
	RJ4I1kJGNG9R9QrIx6jtdt2JVHg0nsjddrJZP/V/5SkqOVCwlW9NHCXBoSMsAJ9tObzuJA
	a4+h9G79WLCpvdvhiUJ288jySze9LLE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Nj0139MoPw-H_krMTGnBvw-1; Mon, 14 Oct 2024 04:08:36 -0400
X-MC-Unique: Nj0139MoPw-H_krMTGnBvw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99ea3e1448so111960566b.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 01:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893315; x=1729498115;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaWs/ibx85c0CtG18bNpX/cgoj6kclzeopbcQX6fQ8s=;
        b=hkLPp+NVab0bjsztfy6r7nMevB4L6xX1dPSNc8C8TQdcKc5M64k53aJZSRJbfILnG8
         0PAP5VsP/RZn/8z4G592AndV2uoGpDKj6/Oa3sRh8c62Nz2oOcYnSishKjY2GdE3sSpv
         meMo5+5mEg5MUueLPniO7yUIXHrOvK6br7Q1QAlff/C51nL6Y+uHy2hv3amwd+gO6PoG
         NyE9cyV5IcLNwjD+GNSaoDRRkHre8SUS+aCyhdowcMi0uEYUB/glU13mcCxVNuboNB+6
         /kMBXmCXUya2JW7s4lWyqP21teM475tIvXcuFHyWMK9M7xtBby7/CketnxpTzUVlYShW
         As4g==
X-Forwarded-Encrypted: i=1; AJvYcCWOqSkg0KTuMDqToCi3cXSJgviq46zrVX6FpQLZX/x9Fwe6synO38NgSZe4stihXGwJcm+Pllw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTajpuWdy+YAqDDtyPE/f0JXFDdAVqtb1Zix1xRcn8HoguHyH3
	ehJteZG8xxaWXsK9qeWJt1Wrn0LpLdOhNOHFptboLrkDtrP1NUoS9miBvYxklGXbGwCzZZIg1gq
	FC27Cl588afTDkzl148zJABs1gjcjr/i4aseAj/rUHyvdVF+j6xD5Hw==
X-Received: by 2002:a17:907:944b:b0:a9a:296:b501 with SMTP id a640c23a62f3a-a9a0296b7f7mr310400866b.26.1728893315337;
        Mon, 14 Oct 2024 01:08:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1q2sRlNJ7gBIJ0qtGA/4lKRT5VNcFbD+svupkTpAqykus1uvSFx9KVJU4QLRIETgW7hI7mw==
X-Received: by 2002:a17:907:944b:b0:a9a:296:b501 with SMTP id a640c23a62f3a-a9a0296b7f7mr310398866b.26.1728893314974;
        Mon, 14 Oct 2024 01:08:34 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3? (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99e3e338e5sm325954766b.209.2024.10.14.01.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:08:34 -0700 (PDT)
Message-ID: <dc9d7bd817e5c8bc88b0b8dfffcf83b2676cc225.camel@redhat.com>
Subject: Re: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Richard
 Cochran <richardcochran@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,  Keith
 Busch <kbusch@kernel.org>, Li Zetao <lizetao1@huawei.com>,
 linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,  linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Mon, 14 Oct 2024 10:08:32 +0200
In-Reply-To: <CAMRc=McAfEPM0b0m6oYUO9_RC=qTd1vsg4wMn1Hb4jYQbx4irA@mail.gmail.com>
References: <20241014075329.10400-1-pstanner@redhat.com>
	 <20241014075329.10400-5-pstanner@redhat.com>
	 <CAMRc=McAfEPM0b0m6oYUO9_RC=qTd1vsg4wMn1Hb4jYQbx4irA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 09:59 +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 14, 2024 at 9:53=E2=80=AFAM Philipp Stanner <pstanner@redhat.=
com>
> wrote:
> >=20
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace those functions with calls to pcim_iomap_region().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>=20
> This is part of a larger series so I acked it previously but at
> second
> glance it doesn't look like it depends on anything that comes before?
> Should it have been sent separately to the GPIO tree? Should I pick
> it
> up independently?

Thx for the offer, but it depends on pcim_iounmap_region(), which only
becomes a public symbol through patch No.1 of this series :)

P.

>=20
> Bart
>=20


