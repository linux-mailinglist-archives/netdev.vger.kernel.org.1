Return-Path: <netdev+bounces-95031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD928C145E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599D31C21DF6
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A540770FE;
	Thu,  9 May 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K80TwnDD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899C7711E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277060; cv=none; b=Ez8kWnr6DmQ7VBcnnHtdnSh0RPzmTPi+sL0QYiYkfJY2JM+O9M6ugc0lJ8zu1JjSZ7+MwVkWzoDZcUOTfJHnAhrCOWwhvhet1Rejnl5MyifixykWF554GKOyyyjZmaTqeZj9QGmPoIKfaBkW1aczkSBI+4Ki0gPQrnRzrTL/yD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277060; c=relaxed/simple;
	bh=kNoTpj4oZDgdt4XFfpDAb2yvaTodna80/e7sziSUPPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ff4yKNdSdn3wrGIlnQOGYsoFcSEOimFpUvC01AxU493BUe1g/Fq/G2jPOgZulap8TX8Hec3bni7RzAJL0M71MtOVuFM7OCgzSsbCRyFPNi3bz+coYGvbzU3ogx+v7ctvpBcitnyk/0RKAb7CPX8YEDgIrZ03foS0LMR1ILZ+xww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K80TwnDD; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de61424f478so1170508276.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715277057; x=1715881857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6zRb5sNwk+KFH9dVAQ+NdMpZwMFMJ2qYTJfcaSsvKc=;
        b=K80TwnDDGieRXWraDDw54Xmsttee+7JPU1kIyV4ztr5WBzdG016xWb1s+a+maFUbgp
         9K1VGp6ganRjfEqxb6UQMK213dkvc3IMpuMzePpHh+yCXeDVh+2c2Z3zKPL52oMme3he
         4tK4dHUczUfxPQlzJVL807Aj5UOh4BXnexsbJsR/kQBt+nsAhbvgo9QLVESTgOjtnZIm
         X9LWgLuuhDN84MfWGmO5HVNw4O+LBiodXF4V9TUv4+/9UKZUNYOZYvn2RIvUzqMx5/sy
         ZyS3DTf09bjH01l7K8h9DpC25oO6MxnjowwuM01glDnuuPMmpY5xTJyGAfLsH0gQbJCA
         HuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715277057; x=1715881857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6zRb5sNwk+KFH9dVAQ+NdMpZwMFMJ2qYTJfcaSsvKc=;
        b=BB7srN3URzHnIvzAlvXfUgLxUqjMh8DSBiOIvliwRS/sLnpaZnA2hJBblUTi0xSXIC
         IXwbVYsWJRg2QyE6hpZz8bq/IAbXLaVAi912nytaq+LRuSKIcMJSqTdEYbJJ1nZdUbP5
         4qTyPl4y7JD/Mq39en0UwMo84vWtKKpB1ZJszDscC6+nxbdrFWq/ECwegb5h67Q4Nk+h
         3vlQDZAwlcLYsnQOwToonKqgFgcYNDAFcCSy9hzCSqBvZNWvJ27k9ajME8XFDYHtPl8e
         ZGPr7wp5+RQib2XRDsDxH2/zNxeYeP08UVLXUpZdCjZTp26iWE7P6TNiBnNPzzbQYVne
         rmJA==
X-Forwarded-Encrypted: i=1; AJvYcCWhHTH3BR3HJggwMZ13A2woUlJN1USu15mzK9KF6XvKG6MPniLRQNPxm3f4J4/y0j4c9zj7sh7GEAcnWzJuTZG+N44bC+IX
X-Gm-Message-State: AOJu0Yz0T/w9K33I5UUodIbVOxctKU222CuSaYIH+6l6MQvz4ugz/hZk
	xfX2N+iphD2r/joRUhcUnRfIbt2jQl3gN++u4AHOct385L71xz/HgVMy3S3Zk4kcXTiBsBxmtw6
	AaCPMb39ckdn+UMIjJjHC6jbkjrZv96eENXUcKCeP4zT/zHDk3yE=
X-Google-Smtp-Source: AGHT+IFyUPdT/SN1s7lwcLhlDt/Dw64AWw5sRppACAlFRsmsBPK6GHYzG26Xa0BZfbovBx326mQw9rWd2yszux2TE+0=
X-Received: by 2002:a25:d6c3:0:b0:dc6:e4f8:7e22 with SMTP id
 3f1490d57ef6-dee4f396411mr218322276.62.1715277057500; Thu, 09 May 2024
 10:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
 <20240509-gemini-ethernet-fix-tso-v1-1-10cd07b54d1c@linaro.org>
 <CANn89iKgi6yEEenSy1M-PVRYWz=Ri9UorV7irCywOZ8xTbNk_A@mail.gmail.com>
 <CACRpkdYyyQ_=2FmEe7FjDT-2BrhO5GezdXk35werHwBNA=uO=Q@mail.gmail.com>
 <CANn89i+JphFK4TCVjXxbxCicJwrxFC=+ngjnheZWK3KvCJ4Ocg@mail.gmail.com>
 <CANn89i+neubYmpc5VNamXoSjWkw+7-wQ6S-Q5jQjqWtEhiwgfg@mail.gmail.com> <CANn89iL1GK3cqY=bowYu0idtJ3o3FMJh5hkLAY9Lt4RE+Q560Q@mail.gmail.com>
In-Reply-To: <CANn89iL1GK3cqY=bowYu0idtJ3o3FMJh5hkLAY9Lt4RE+Q560Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 May 2024 19:50:46 +0200
Message-ID: <CACRpkdbannQiJwBZtx-_qkgG7vOFv47bqC-oMiTGqXwWsymPvA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ethernet: cortina: Restore TSO support
To: Eric Dumazet <edumazet@google.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:

> > +       if (mss >=3D ETH_FRAME_LEN) {
>
> Also this last check makes little sense, because normal MTU/MSS would
> trigger this condition.
>
> Forcing software checksumming would make TSO useless.
>
> I suspect this code is there because of the old buggy TSO
> implementation of this driver.

I think you're right, when the packets are "pure" TCP let's say.
The TSO should just split those.

I think the check is needed for e.g. UDP with large payload
(such as ping -s 9000....) or those custom packets with funny extra bytes
and ethertype that the DSA switch uses. We determined that the HW
IP checksummer actually get hiccups when the frame is larger than
1518 bytes  so that is why this bypass path is needed.

I think I will try to make one "clean path" for just pure TCP and no
funky business, and an exceptional path for any other package.

Yours,
Linus Walleij

