Return-Path: <netdev+bounces-129103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C36E97D7D6
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0511C21D39
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507EC17E8E2;
	Fri, 20 Sep 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ChTG6X4Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9117E46E
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847147; cv=none; b=aoYW3cJsdgcp9AhSTwhSnd0a9eDa/GOiwZpxnvLvHLG8iV4B7FWHb3KUGpgSRVxrBm4R/Zs2faOYq/8YYcxw4RZD6hRVqdYvqj74y4qnsOmf7m7Ai1FDFnJohgGfJh8ya6Plj3j4k13Jc2XaymY5kelptBZ2SMNCvD3uN/Naquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847147; c=relaxed/simple;
	bh=1J1hqLm9xA+OQQZDj0jnEio4g2PcMhOq1NOUGddQ79g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CA/FKaXMfSuLV6Cmbp+TGMLfOwH8cOXzDuqK3VPxsDxbXixTB9n6ZdQPXAmpZe/PDoXIKzvRpCe3754MgvuMpFEN7RjfXMA3niYpup6CNsQ0kla7MJXaVU7bdiLgJ8Pv8RR+8YKmllqXVlTU2qSZU9E+l32wBCq1pePqHenbOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ChTG6X4Z; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ddd138e0d0so19908097b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1726847144; x=1727451944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze9k/H9h8tpqWFV2vebOD7wrjLmr2B/OxxtbbLC4Qc0=;
        b=ChTG6X4ZIN24X6pHzVlQQtzjl93AymOCODFyYEVXYY13nMbJ0rtKcvRWlmGb5jj24/
         z1okd55Kd5425Sw0GaWNsinu9bEU9CyKyyOskXr2CDP5KPfE1J50PI3Owd2pmi56aCTE
         4g6LYIDvYMEV0fuJSFAqYpJPO0pEwUYPuI9/Ype73bMGOx3XCMujpfweWxMxxVGnHUyp
         5cXBFsn5WuA0L1Y9lAo858b0xndDSh460HJrFCcYGt6sfXwvAKTcjHI2sWPUlCmmMmGf
         0cQYmkaVRA37SSAgA9XmlOAkijk5MWSduVCTpmCjAS7MI7jBq6ugYrJ1dFrT5RdUj2nk
         Vj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726847144; x=1727451944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze9k/H9h8tpqWFV2vebOD7wrjLmr2B/OxxtbbLC4Qc0=;
        b=ZhwnkK7MAEGESrFoMhIzxGVSetu+XLPlFWjxk1Q4anhYLJUH1/l42sgElje6ESnU/L
         7yfkPC0gPhqi3rlYoOViRAFrgTEuOjsFBKNXj4dqjkRuR5NY7t11KKGdSx/4oYhZkmts
         lAQSsxZRhjhKTnqhD9JD+D1t5YJlMpCjE6g0TS01nhIraK+IboGMzW/HDHPp5TJPRwPC
         E1Q3I8neJTGnAY3BWIC1RjjdPHtvyn0TZrEHLBAqpXYROtVpUgbudR7/iQGbMk5JMPfZ
         DeEQ8Fphr3sM1if1A1cXbvFmyUckt/dPh+MWOI1F38BshMfDF/AbJIZwwPtpYVpLQNMG
         vITA==
X-Forwarded-Encrypted: i=1; AJvYcCX06V3UoZtFISI7m+qetyQtIo9K2Qo+JHwMpy4YXga8vj8R96+4EXvZ1dyarv9UbMXyApKfBuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycxpagoMUrIXIaYcOEsAFEXzvSqe7wTtjghcZ1x7LbDBmHF1CI
	hv9q3U1tJRmwZ8uGUj6kuId7tPDVlY4SqtLvWzYs1OMi5MEKmFaVARtWnJIEoHpyVa88dHjGZGZ
	VQY2D/HYB3fdaFs5wPbPmJXPsdZ0alJIxnfgFUA==
X-Google-Smtp-Source: AGHT+IHj2uOTgTw3Vtf0yRDLdSBn1U6D+q4fLLlnQlqc1Yc+uEtLEz4TtmwbE74OhR1TFSWZR9n5x0WZdcCI/rEmFgE=
X-Received: by 2002:a05:690c:47ca:b0:6e0:44a:257c with SMTP id
 00721157ae682-6e0044a2773mr4505677b3.8.1726847144157; Fri, 20 Sep 2024
 08:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919043707.206400-1-fujita.tomonori@gmail.com>
 <CAH5fLgiJyvSztvCDz8KZ4kF0--a0mqi7M4WowB==CCs2FmVk8A@mail.gmail.com> <20240920.135339.42277957091918023.fujita.tomonori@gmail.com>
In-Reply-To: <20240920.135339.42277957091918023.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Fri, 20 Sep 2024 17:45:32 +0200
Message-ID: <CALNs47us3fuD_Aa3vtK4F0Bz_RK9qyf5mvPoOccJGv+J4t=QjA@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: qt2025: Fix warning: unused import DeviceId
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 3:54=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Hi,
>
> On Thu, 19 Sep 2024 08:17:42 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > It may be nice to change the macro to always use the expression so
> > that this warning doesn't happen again.
>
> Like the C code does, a valuable is defined only when the driver is
> built as module because the valuable is used to create the information
> for module loading. So the macro adds `#[cfg(MODULE)]` like the
> following:
>
> #[cfg(MODULE)]
> #[no_mangle]
> static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_=
id; 2] =3D [
>     ::kernel::bindings::mdio_device_id {
>         phy_id: 0x00000001,
>         phy_id_mask: 0xffffffff,
>     },
>     ::kernel::bindings::mdio_device_id {
>         phy_id: 0,
>         phy_id_mask: 0,
>     },
> ];
>
> We can remove `#[cfg(MODULE)]` however an unused valuable to added to
> the kernel image when the driver is compiled as built-in. Seems that
> with `#[no_mangle]`, the compiler doesn't give a warning about unused
> valuable though.
>
> Is there a nice way to handle such case?

Maybe just something like the following?

    #[cfg(not(MODULE))]
    const _: [::kernel::bindings::mdio_device_id; 2] =3D [ /* .. */ ];

- Trevor

