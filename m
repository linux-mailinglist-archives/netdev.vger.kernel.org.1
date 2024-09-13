Return-Path: <netdev+bounces-128147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D309784A7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B45286C0B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC4433C8;
	Fri, 13 Sep 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPHbH+u9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB362DF44
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240619; cv=none; b=kOGniHD/nVB+lLTEpGtzXkd2Mn+A7bC9ni+JMp9skOJgt7unrBdAKstq1RGMFZ/jfr79R522J2o9F/7medtydC4uIISeldwlVMnyuzoL3VKvf61G432CbZvZ/SLBshiqvr0ZGTadx+qpFkQHGpNULvLqYAnRF/SoBNDOM8iQdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240619; c=relaxed/simple;
	bh=xAWkEscfYbcgnPVZ4edFBthl8XXEGTFdPUlCpw8X+X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5fZnKYW54TLSPMhlUkwtBtn45spRa5Pp8k1EcZ+qqRKdSEDoxh+sQou3Sgyl5ADHPFuZbDc+w/NBJUpr2So9jP5uOzV6p7TLzQIh2oDscNogWD7gNr7udYa/fCoegGLki6nr9PHDglEWZ6ox4gOzJ9VcqI6WakeQFgVhPXm4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPHbH+u9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso339735066b.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726240616; x=1726845416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YdprUc1vPVqWZrJP7Xy0uhlo+IsxLQcTd7Jlyz7yzs=;
        b=mPHbH+u98l781NDodvWjfVZRVyryKrkfh4bEfOpjuEzLcvTVrqtXui5zZ2m03BFsoH
         nRi95L/QBbG+xm/gZajtDB8riwMBVPngfybSQNOYWAGbBZ3MltWBSx5rrdc3NhQWaQL6
         0/aQluiBXLmNnEfxhFXDKa94Eb08BRkAr2G6EmcqZvwOsR6pwN0OLL8eqLUqr5ppl/I9
         l8kMZtg1JFmZyi+1BBZCI/SS6L5ZI3TURwXZUv8i6pT5Go6OKRyrvV+pPr+Pjd8Q2dJ8
         LALkIIHshGrsVqO5W8k2ynODB0sEjEczDoZ93qeqE1rJcY/r1Tdc3zplIK3/6idbdc1X
         MdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240616; x=1726845416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YdprUc1vPVqWZrJP7Xy0uhlo+IsxLQcTd7Jlyz7yzs=;
        b=ESClzJjtVZH5lbR/gHDBYYV3PLy9hyhVtapPH6w0jVK2Wenah1YfYUZFLurz1bUuO1
         u3YddIwHffY0bRQRcPKbaGKUq626c22AGe5Rrw5iTh5WciDR4R9MwbAiyctCIp4uesDl
         pmmYc+AjVanlJ8sYVx4KKegiQYlKD+2lxxQrDeHTSVGKu/xsSX5qG29ccB+sY5ScHe1D
         qFbCnDzASmmoB3LXJdf2pIVv+268KJQr0k9Pb04kZ0iyHI/3dC1UJl9up4qT8OUUy1Ca
         eMMz8RAwHZjlHjdEXNJX/YBEnW+ufi5Lgqr0MJDJR951Q3Txrpk+XJm/b+VH/U7GzXhb
         +Sjg==
X-Forwarded-Encrypted: i=1; AJvYcCWbTp4mIin8ObZxqO25tWFM73ASoI0y0t6jvpkqBvI5IlBkKQco4QkM896HFQ89tvYP8/hpi3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBntnaLolPnA5woTheS+aPetnigaIQM31Lyvfm1Qo23nAV/88
	D6EWg7STvGM0hLUbB81FUfIs9bS0JM5FbSsSvLEyPcdTo0t1+TmMDZb8WM1XgMFZe3RXOPYpQ4N
	SzKlYTpXpLBbDmgF6s60kEKNuzj/3uCrT2tby
X-Google-Smtp-Source: AGHT+IH64JnbnKqlgjuwZ2poHsHnkRBQt2ZGALlB0BUTFCR5X3gE/MmjgeDfm+uKTA7o3vUfN5CtY78gFaFyWIBw5kc=
X-Received: by 2002:a17:907:9723:b0:a8d:2bc7:6331 with SMTP id
 a640c23a62f3a-a8ffae3a217mr1348205966b.27.1726240615882; Fri, 13 Sep 2024
 08:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
In-Reply-To: <20240913150954.2287196-1-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 17:16:45 +0200
Message-ID: <CANn89iL-fgyZo=NbyDFA5ebSn4nqvNASFyXq2GVGpCpH049+Lg@mail.gmail.com>
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:10=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> The threadirqs kernel parameter can be used to force threaded IRQs even
> on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
> skip disabling local interrupts. This defaults to false on regular
> kernels, and is always true on PREEMPT_RT kernels.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1e740faf9e78..112e871bc2b0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6202,7 +6202,7 @@ EXPORT_SYMBOL(napi_schedule_prep);
>   */
>  void __napi_schedule_irqoff(struct napi_struct *n)
>  {
> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +       if (!force_irqthreads())
>                 ____napi_schedule(this_cpu_ptr(&softnet_data), n);
>         else
>                 __napi_schedule(n);
> --
> 2.35.1.1320.gc452695387.dirty
>

Seems reasonable, can you update the comment (kdoc) as well ?

It says :

 * On PREEMPT_RT enabled kernels this maps to __napi_schedule()
 * because the interrupt disabled assumption might not be true
 * due to force-threaded interrupts and spinlock substitution.

Also always specify net or net-next for networking patches.

Thanks.

