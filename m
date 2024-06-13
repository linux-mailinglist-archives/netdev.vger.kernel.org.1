Return-Path: <netdev+bounces-103088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730129063C2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 08:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0331C20402
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 06:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E13135A4B;
	Thu, 13 Jun 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiWDty4P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925937C
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258958; cv=none; b=DOBKrgJMe4wc3GB51ROG7d8PtF1GioQnWr1rbDGNTMw7KAt/b1yhCkLEfS8ole3mLk1A/1jK0ZZ4GZPbN/P6YB3npohDAZ4NA1Gi9zJhgStajZhfh1skLLEjWVcyzphgVjGSBJpMB0xlCK5ra/reqfZpM+KR0IHmeJaHoYNah7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258958; c=relaxed/simple;
	bh=nXP6x59o/QNZ4r9qxDqq8GkcNNM5e+hJhAIhAS57ld8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuXIkognf07jiP/WtGK4yVWLIfHEYMO7GE+b52g6iRkTKtiCjNRRzoDtmpW3xBnFU3Lp30nIJyUyqJSzkHaIL769cscM8fMXlq0wh3rVj0BnAULKhEgFJtR0h6hz/7rxi9Bw3Hwt7YLxO48oA6t3k9XRmOTXqQFTXo5ek4yHLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiWDty4P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so851463e87.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718258955; x=1718863755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXP6x59o/QNZ4r9qxDqq8GkcNNM5e+hJhAIhAS57ld8=;
        b=NiWDty4PmH9AsNnaMhG1Kae7BltV/U/rSzTDwgnguf4asRnqRzQaQ4gHqX06ji5Vdz
         Dt17xf9Ra+I63sCC0VSN3OlNPIiqrpCIaMjbZ07MWR/5StQUEkUg0vIv6HvJiFAopK2r
         NH5v8lB1o2cJYxdpZPiaReHVqdu3JWfjLdVyLoLN/1iakewjX9zxRafa4AXKT4OzfDM4
         NikSWGDXF2QA/dMHkT8kBkcTE56VFZaWOleO86Rk6/jGJxpGbnm1ym6WFO1rc/yxvud3
         XVlW7Ov19MaPEALjTzEfa/8wJw/yINRYg1Jfqof5f4imtWl8Ol1ATy2Yhot9ar4djYlY
         RqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718258955; x=1718863755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXP6x59o/QNZ4r9qxDqq8GkcNNM5e+hJhAIhAS57ld8=;
        b=o4gEdoPkhKBG/M7y0hsWmBxUQqG9wzsoYjJNLf45v9lNIz/qs54V+P1lBU53IQ+arZ
         5ieMUSEXMM/RKwv7nGaaf3i1KGO17fesRpy71fDOg6xfcdI0Hf8VbCO+VujT7DBfryCa
         5a+wPu2dPsk2YUscR3fFSc4qWr9ownfNbL79hZwx9ZR6XIxE6ZwRGv1RRRePEwacVcoU
         qN5MQfqG+UIxdcKWOlQnAKE7ZliGBJMZMbYb+DcqvRYF5ODUlp9jHvs6uV/3UELBKzot
         kiml/W77TdYdUNMmJ8zvuI+vqLOOMvfHZuDfmYxKXsU0CfoeJpz1Ra2ukgDOiAggqF/E
         w5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWccWft3RnrXTpWryMtnjT3B3KJtfxEBb3GLcoFiqJfMyHitR6W8HeHqsClZgH7Kh6lQ+4xK07tRWyC8jdiqmJJqp0vKItd
X-Gm-Message-State: AOJu0YznBENjV8mBN3slcuTv3nsZpCDjQpU8TEyygqM3dd/AZspnTtl4
	IWm8ypESGxD5zsGyPovt+pD+naSahAyLVIGNYe4JABxZd8062L9YD91YF7Te/ftFdGLuF8m4qVZ
	uWg74j+BwUC5x8Luk8qh+4oMjGmg=
X-Google-Smtp-Source: AGHT+IF6r0ftz6+EysGMEi/2Jsw1545qR1NrhsvTWVUNCgHiLnJUnMcXubdtbhA0SjaAr9x7L4KsrJ2Zn8TJbuI6UUU=
X-Received: by 2002:a05:6512:3045:b0:52c:8909:bd35 with SMTP id
 2adb3069b0e04-52c9a3bfb2amr3775742e87.10.1718258954601; Wed, 12 Jun 2024
 23:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com> <ZmqFzpQOaQfp7Wjr@nanopsycho.orion>
In-Reply-To: <ZmqFzpQOaQfp7Wjr@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 14:08:36 +0800
Message-ID: <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jiri Pirko <jiri@resnulli.us>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:38=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrote:
> >From: Jason Xing <kernelxing@tencent.com>
> >
> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
> >BQL device") limits the non-BQL driver not creating byte_queue_limits
> >directory, I found there is one exception, namely, virtio-net driver,
> >which should also be limited in netdev_uses_bql(). Let me give it a
> >try first.
> >
> >I decided to introduce a NO_BQL bit because:
> >1) it can help us limit virtio-net driver for now.
> >2) if we found another non-BQL driver, we can take it into account.
> >3) we can replace all the driver meeting those two statements in
> >netdev_uses_bql() in future.
> >
> >For now, I would like to make the first step to use this new bit for dqs
> >use instead of replacing/applying all the non-BQL drivers in one go.
> >
> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
> >new non-BQL drivers as soon as we find one.
> >
> >After this patch, there is no byte_queue_limits directory in virtio-net
> >driver.
>
> Please note following patch is currently trying to push bql support for
> virtio_net:
> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnulli.us/

I saw this one this morning and I'm reviewing/testing it.

>
> When that is merged, this patch is not needed. Could we wait?

Please note this patch is not only written for virtio_net driver.
Virtio_net driver is one of possible cases.

After your patch gets merged (I think it will take some time), you
could simply remove that one line in virtio_net.c.

Thanks.

