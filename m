Return-Path: <netdev+bounces-249366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356ED1754E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD0830389BD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD5837BE7C;
	Tue, 13 Jan 2026 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkyw9TV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116B37FF70
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293217; cv=none; b=maWf3EWyf9SriJtwhu4nH1HGB/HKOXK8qEzr/oU5jiiIhxRFwwAhg8ouwog6yH3BXVDTYAtzsFhHg7vvAIY1BDy+imR4PHDamD6xzNA2oQtor6H71L9IxO586CO+ka3poE3ZGyOr07D5UupdgHlcJ6OQw2A0oyiMI2WQpiTJeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293217; c=relaxed/simple;
	bh=6Vf+z6DmApEpgd74IiDMlnggDpe5PHFGaES6iOjxScE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czZQdjsFu6dlS+6lO8YLWssWPpEwZdv+vgSE/W32Cp60THA+QDV341YzwVftlVHExdcUOfLU8Lbo3G0jxIrn6hHwIRZ0tCxNpSnyVOCTv3p9EkzOzZS1t+UZbSjs1E5u9Al75hcCa0p1THermIGxbQrXdkRPk/WZ3iQ2E14Ixog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkyw9TV6; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8888a1c50e8so91176066d6.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768293214; x=1768898014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v03HcVlyRDPNDKOnTijkifKECBVa5Hdrrwnb4NSOWas=;
        b=rkyw9TV66bVATOu8eEZuZL+43pGjXbyWaGmEpaDuYPMw1zBmP+GGI/YKmN4KasVmHT
         prYJ7oR3jA8MkE5bA/kut6uIaYAndlxZ2h43DfQ5xm2ti7UAt/dOFDAoQYnPBPusTZA0
         Uvv01gEGMkPY/cf9wNwTtHn/Yu5P5Y8yQhxpLiwDLxRPug/o0tGJDy93ptMxu4H90i2K
         P8h5EbfQdTAHCeTISMO0O4E2HQZ4ji8SlmlxfqSSokqN7Z4NTCyxEmyYyUgFgTYTf5YZ
         +PPA9RWB6uHxoAx1ue0+SmTUBYmd58KFFUFZFhijxH3zgk1HTCuUSdmSpASgrJaC21BL
         QO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293214; x=1768898014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v03HcVlyRDPNDKOnTijkifKECBVa5Hdrrwnb4NSOWas=;
        b=XVf86h6qP0zLGpRYPHH4hzqpDolFxctfEVyIhl8oOCHuTJy2LqRWIrj2Lio9q8bbpm
         UpdT9FKRW5hd1r2NB0bgfaYHKrCxQjCnLT6DbIzp1CIErnG6zEkZUV3gYRSyGADnkRKL
         aJcO5f2QpdI76kgg0TD0oTk4w+YeAsOoHn/6+QkIeR21cCKLaZlHqCeGoCd50AHR+LwP
         u0Q22FJUDY/WNh4tUKcUfogev5rQgGsEG+xk5y+SEjxbQmCe+7E/BkLmw91+9c7Hqwqi
         E6HpIaAxFZmSDJD4mvgoSembzzrfuGdMoZsfCtetZ2wB4/v0hleF3MIaNamp2KFSTZMG
         7WOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ91v9CEMGU8sbWKw4e/5LEnI53xuyyN+sH5/0PiuF3I0V4DogzauNlo+LC2srhZ0QcIcdmS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3qF9U+Q2tm9ZzeBpcu3EAw+hBgfPcp8bLd7OE++24g95jLzj
	jmWvyP5idesBr8sU1vsvm6gaNg/2hrlpz1ktEiYcWuZGkxiQ27tsDAYZHT0EGiHZtI+D4U1n0QO
	qTPEuT9QrKaiRT3qybKRO4kgk4NWCJ0qahIiO7XXV
X-Gm-Gg: AY/fxX7BIKEXs3Xt10o2zUMaa1R3gGMVVTQbQKQawhh/MJ4+vNNr4qQwHjU6ZgdN4Zt
	Fc4svIj3uOaWXbiQdKR9mtCNfJC2sPrFll/0oHcXz6uD3KWKnAxRUxbCAoae6zTYEi4z441Ku+c
	8btUsahcEdPUMX9ppn5Yqwlpheg7ZFqv9IdqKVjVWEMZjtctq0RmwCNPckFR8sAnZLewW4koNrJ
	ff2YfJHXVuMwNKicgDFjyrh3mwngwqVxuYhlQgFSrSxaQmd4b5mgWcNfCp/1chy4SuJnw==
X-Google-Smtp-Source: AGHT+IGHsDM2OG4WxVYJeIbbyxy6YsFnQb75Xk89C6cKf47+Dg+9lKm9iT4HecRG7Cg3Mk1bLBk2N2CHp+6xwBEBZz8=
X-Received: by 2002:a05:6214:5403:b0:88f:ca80:2b98 with SMTP id
 6a1803df08f44-89084188cadmr298898546d6.27.1768293213587; Tue, 13 Jan 2026
 00:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113075139.6735-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260113075139.6735-1-simon.schippers@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Jan 2026 09:33:21 +0100
X-Gm-Features: AZwV_Qje-LJ3n584sqc4vJ9B3gmC6uvzhfPanoikn82IWbeoqA-K8U4R2qr9FM0
Message-ID: <CANn89iKTB2w+Dh-Aka1o5bs9WKkUGo7RqraPYJ+3gpDzzS3fQw@mail.gmail.com>
Subject: Re: [PATCH net] usbnet: fix crash due to missing BQL accounting after resume
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bard Liao <yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 8:51=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> In commit 7ff14c52049e ("usbnet: Add support for Byte Queue Limits
> (BQL)"), it was missed that usbnet_resume() may enqueue SKBs using
> __skb_queue_tail() without reporting them to BQL. As a result, the next
> call to netdev_completed_queue() triggers a BUG_ON() in dql_completed(),
> since the SKBs queued during resume were never accounted for.
>
> This patch fixes the issue by adding a corresponding netdev_sent_queue()
> call in usbnet_resume() when SKBs are queued after suspend. Because
> dev->txq.lock is held at this point, no concurrent calls to
> netdev_sent_queue() from usbnet_start_xmit() can occur.
>
> The crash can be reproduced by generating network traffic
> (e.g. iperf3 -c ... -t 0), suspending the system, and then waking it up
> (e.g. rtcwake -m mem -s 5).
>
> When testing USB2 Android tethering (cdc_ncm), the system crashed within
> three suspend/resume cycles without this patch. With the patch applied,
> no crashes were observed after 90 cycles. Testing with an AX88179 USB
> Ethernet adapter also showed no crashes.
>
> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Tested-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---

We request/need Fixes: tag for net patches, in the footer.
And we prefer it to be the first tag.

Fixes: 7ff14c52049e ("usbnet: Add support for Byte Queue Limits (BQL)")
...
Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

>  drivers/net/usb/usbnet.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 36742e64cff7..35789ff4dd55 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1984,6 +1984,7 @@ int usbnet_resume(struct usb_interface *intf)
>                         } else {
>                                 netif_trans_update(dev->net);
>                                 __skb_queue_tail(&dev->txq, skb);
> +                               netdev_sent_queue(dev->net, skb->len);
>                         }
>                 }
>
> --
> 2.43.0
>

