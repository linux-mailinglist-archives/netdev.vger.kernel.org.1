Return-Path: <netdev+bounces-191613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B935ABC741
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB3616ABD6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A421C84C0;
	Mon, 19 May 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJe0Z0rx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F1F126F0A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747679538; cv=none; b=sbbjXz4ptMr1IOanyZ0VjBpDWDQ9zVXeHCwZLQhrSuSltfi/yUtLJvwhimApg7wv2s1dlQ/nXyNepGB0txz+LoT/Qv2sjfEbHyIkPnauTqkLASxmTfm9hLOZti7jek5WIsZ5JyFCFhXJpQSHBDW7OD83zReOT6U5kzfd3+wLFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747679538; c=relaxed/simple;
	bh=P0+BvqT6Ysl7rrk0C5kjhOP/Ds4FsTeqcC13DrzqPwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIiEuKb3kkROwS6kfKrF9RFMXv5T9hsMl1FLRDKPzk4QrrmW57TYssnlrhELbpLxNi3aIUIy3AeeiX9LepGf7gnzfBaLMFF3uc1b1XfwJdHq8WPIaoaguM2kPw7yOeGETpVGgl9kPGyRIafYk6F3+RaA4ZPcCkEQ5DUZmynYXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJe0Z0rx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-443d4bff5dfso114155e9.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747679534; x=1748284334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLUT3QeRgGdo7f8VdpZlNNkkvkkzawS11uAKz4Rzhok=;
        b=qJe0Z0rxfoYam93epo33SB03mIssykBVLVkosahDlgB130RCvPpkDbQpg2r133rSmG
         M3JbKIdjCaF3MLTXKhTMdnvzxmdSKycUT+5aCnLhRRjV2cot4V5MbblGhKKTf1tcudLK
         sQEm4q23NmLSbWJfGnWQ6YS9gja3oJcnjXt1C7hMF36LXiO/NTwdKmhxnX5iKgwTkukj
         bGoLjHu4ZXWoqvqFOCjoyKNChkTFxgGX70/fLSWbXGOdFB+m0Z0qpJe9nWY44abiw1EP
         BtAMlrqvSLSMbbqi2t70w5gxZoMEQDpJLw8soHR01s+uH58HZgrJcEAtnu1aq0kdCIdd
         ftQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747679534; x=1748284334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLUT3QeRgGdo7f8VdpZlNNkkvkkzawS11uAKz4Rzhok=;
        b=WrvT8JPkIdU3r3SSgddr1JY75x0qXNWxJED78J+25jS/M4FiBxOUaJF2KyQW3CrHjN
         +ThcS5kfYIOUTdt00a3BUmhG3Cu66UqsZJQ1v6OKfG6527zRg596JwNfCFgZr/Tvetgc
         fL7xiy7XldpoNcNQ7ELEzFizn6f5il79ayXhqGryRYhToq4K2yifMxaFRo1susgzPo3c
         1w+zd0Q6eL6Kjx7gVcFwKQg7vAjGReGeb04TgyCPCETSjZUwqMbra84o9PLa893NFA2p
         q4WmYlbK0wKNUfFvcPmE+jbYELAsKsutNw2zoYd7yY3Ts3cjPoNackxIbxjlz/Octo8H
         sMgw==
X-Forwarded-Encrypted: i=1; AJvYcCUGzBZmeYgrI9B1dKBnXoxq2mlbiw1DVWgT9lXMal2blc3aGNI9gQEhrjriJ3gOUe1jlo9RSJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpSUPeg6eBQnevTIyKzSM8HUO3C4v5CkpqSpDla9rdsP1FVaF
	7zQrO1Z4wUutXKoq638ybodDcHsP9lycyHYh/GY3htGcMpcz7X8hBPRIj7AY4VWJBIxRVNJsEKo
	zr9zc//6oAmYMJO4mvFst2W5QRGGpBE3/WqRt1R5F
X-Gm-Gg: ASbGncstSv2zoABjtIhgigxSsfDl0A4R61EewTshJEGZjq1TD4pqQpikbt4p6Fg/LEn
	+PonGjSJ17Gpy/Qd4GdaL5HpXmLw9/0U4Yowo2Nz2RaoSP3oGoTZA8gs0jGeI4pUFuPlJnSevui
	AR6brhTB+VOkleMDhhqGG+Wmh+xTLiApQXdDGgRF3F9gmIRyzDKolcaTOQSu95zz48BMNpQDoow
	g==
X-Google-Smtp-Source: AGHT+IFeQBMSJPGO6v2VuM8ztRxqMzIqpj33vzCux4RHIlkwC3+m/YPs7WMFqhoM7/7BuqtI2xAWugCPRVwZNdXYQS8=
X-Received: by 2002:a05:600c:8417:b0:43b:df25:8c4 with SMTP id
 5b1f17b1804b1-443ae3dbb82mr3982765e9.4.1747679533912; Mon, 19 May 2025
 11:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517001110.183077-1-hramamurthy@google.com>
 <20250517001110.183077-8-hramamurthy@google.com> <20250516185225.137d0966@kernel.org>
In-Reply-To: <20250516185225.137d0966@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Mon, 19 May 2025 11:32:02 -0700
X-Gm-Features: AX0GCFtcDw89GhEYpTmvUrwgGsrlQLb2hyDI-d2hTEgfQI3bhERRmIlPbeST0F8
Message-ID: <CAG-FcCNVAMsvrtZscdoFEFerdTcM9OeSL_GM49ou8ftFraXpMw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/8] gve: Add support for SIOC[GS]HWTSTAMP IOCTLs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org, 
	thostet@google.com, jfraker@google.com, richardcochran@gmail.com, 
	jdamato@fastly.com, vadim.fedorenko@linux.dev, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 6:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 17 May 2025 00:11:09 +0000 Harshitha Ramamurthy wrote:
> > Subject: [PATCH net-next v2 7/8] gve: Add support for SIOC[GS]HWTSTAMP =
IOCTLs
>
> Sorry for the very shallow review, the subject jumped out at me.
> You're not implementing the shouty ioctl, you're adding ndos.
>
I see, I will change the title and commit message to be more related
with the ndos.
> > +     if (kernel_config->tx_type !=3D HWTSTAMP_TX_OFF) {
> > +             dev_err(&priv->pdev->dev, "TX timestamping is not support=
ed\n");
>
> please use extack
>
> > +             return -ERANGE;
> > +     }
> > +
> > +     if (kernel_config->rx_filter !=3D HWTSTAMP_FILTER_NONE) {
> > +             kernel_config->rx_filter =3D HWTSTAMP_FILTER_ALL;
> > +             if (!priv->nic_ts_report) {
> > +                     err =3D gve_init_clock(priv);
> > +                     if (err) {
> > +                             dev_err(&priv->pdev->dev,
> > +                                     "Failed to initialize GVE clock\n=
");
>
> and here. Remember to remove the \n when converting.
Thanks, I will update these to use extack in V3.

