Return-Path: <netdev+bounces-160211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B064AA18DAE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6083C7A41A7
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3854B20F099;
	Wed, 22 Jan 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTFLAOSU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0B1CEE8D
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535248; cv=none; b=LNsJ3aZ4+RRV9BKBD5nyH2YVLJyLxCHcojMajEMwovUcUiv6t17GB8wE/fRIgCAbRUBjJtLOpp+m6pz5rnBay4NR6yIyoxU8af6x4e/exe0awyc+Pi7UlPc8cIGspnxQcFDUtnMGIM/J0LCv7nWmWp9e2xFsWdCVIoldAfm+yek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535248; c=relaxed/simple;
	bh=TQH4K3NRbfBbxJPgJV7AffUYU8Z26EqOkvHJ59VSYw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa7AOt9HCEP50yL+yojZvsTYeN8x8060bBXInCeshWjEMAfDmzSl5xBfFfX0wcqUDgT5n0124HFxXeqovSgaucnPt836pZAwOwXtDfDhfST/IEC1Lpc5dG8IQtfU2/c01Y4j4kyJ7SoO2mt4OsnrJC9ogqYCXrqmfF+j2sZPUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTFLAOSU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so1123764266b.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 00:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737535243; x=1738140043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu+LVE84DVbEyr2FWAPyBdnPSvbEYb4f0ACc7oG9dCk=;
        b=BTFLAOSUnyD5djko1ER69orh0XYvgOywwYEOKt4hlFQOKTOWkiHOl8RnI0KII7UJc7
         9VCMgWm2uB8IXeKCI3Ro27c2Tb0SXHpksTJAzr8MUD4IKFB/DDvLkGLKwtVXD+BdQhXu
         d13d8iE2aF2GFjidAZ2iQUlgPNZgEhnbh2aiwdc4CJComl6vg29H/pq5t6LLU8uk/xo0
         dOOCEQl2UCGgX6Lr5LL/wl0+l3gBtn0Xg1KMFUGeLV42Vx//rAsdVV+WbNTxB1Nit4i3
         1THL5855xFSYTeCTkfOM4dB4186J7n1lFIonP4IX4o8gIyDzub+6wm2VcDmK2odeFka0
         wf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737535243; x=1738140043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu+LVE84DVbEyr2FWAPyBdnPSvbEYb4f0ACc7oG9dCk=;
        b=jP7Vn2wi3om7NvRmH9LTNjBaWUDDJTMGH5PLNbKSi24bQYih2Z/J4g+oQ+FaR/rI0r
         OuT1ku3dP55b9+KptLfjho9/tPpPGtSYaXKs8BC0of0r2hTVw/2stmjpoeKozskKCtNC
         07S4H8zDxcchpMFMUD9Q5qfGMt5Dl7qGJz0L30jX11Ztdlfo3sZ/22QgNZOEtUi6l5Jz
         GHdadrTghr3dzmtVEEYFDfmYL6yiz9YqKayBvRSdDV5OpzZVN2W0cUL3EVm1Nt4cmW8J
         eKhsWkU5N7vUqkY7u4cylAgfeL1RtVFbRz8/GNNLjScq2QIrm2wtQv21khekPeZv5Kkf
         ORGA==
X-Forwarded-Encrypted: i=1; AJvYcCVuoNz3u8ZGikpfTbT/bJc52Zys9AhluocS8AbMVL9U7Fwbk5QQVVgPGcYGz7sE0tfbYxborwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiyLNNBiJX/O+okBxPOuJWyUkngwku32q/8cLVVLkjBxkfYPEl
	/c3fxEemZ5TEqL24XozFXnwnu+P5ymsWr3uV1HOSJQVFJZo8qLCox0kCKjBhoAahlZViDMFoznP
	7PMbSuv6GPBMIz2Gxo4pf6ydNsM0wNw==
X-Gm-Gg: ASbGncvW9274dmv1R4afLUvOENkUOo2peV03A4emtDOOWXUSN5ka2hxx4gxFKGi0xlC
	S8WGUK5hxB8KXfmNjz02emTKtT7LM+XXJwwR5BuIER4yLOROAo2yaiVx2VhiT56B7+ejdA3MZ7e
	JhTRNjECbL
X-Google-Smtp-Source: AGHT+IHuZTkz1YUidNljwO8g/Q0Ux7Fb4wu7cHKbAt/FGuJ3/9HWJSZap2tszlCqGlKdSvgSgDDau2lhJ2MkJ9f4Gtc=
X-Received: by 2002:a17:907:3f9a:b0:aae:ee49:e000 with SMTP id
 a640c23a62f3a-ab38b106513mr1775887466b.18.1737535243351; Wed, 22 Jan 2025
 00:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-3-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-3-kuba@kernel.org>
From: Zhu Logan <zyjzyj2000@gmail.com>
Date: Wed, 22 Jan 2025 09:40:30 +0100
X-Gm-Features: AbW1kvbVMHqN-9mzPV_XvHkRFdF-rdrQfxxqYFlBHRVwoIZU0GKWqze0Yhfc4Xc
Message-ID: <CAD=hENcKJfTPNofaoC3+fTGLJtwBAu7F09Ky8qQbu8gNgOMXfA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] eth: forcedeth: remove local wrappers for
 napi enable/disable
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	dan.carpenter@linaro.org, rain.1986.08.12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> The local helpers for calling napi_enable() and napi_disable()
> don't serve much purpose and they will complicate the fix in
> the subsequent patch. Remove them, call the core functions
> directly.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I am fine with this.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
> CC: rain.1986.08.12@gmail.com
> CC: zyjzyj2000@gmail.com
> ---
>  drivers/net/ethernet/nvidia/forcedeth.c | 30 +++++++------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethern=
et/nvidia/forcedeth.c
> index 720f577929db..b00df57f2ca3 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -1120,20 +1120,6 @@ static void nv_disable_hw_interrupts(struct net_de=
vice *dev, u32 mask)
>         }
>  }
>
> -static void nv_napi_enable(struct net_device *dev)
> -{
> -       struct fe_priv *np =3D get_nvpriv(dev);
> -
> -       napi_enable(&np->napi);
> -}
> -
> -static void nv_napi_disable(struct net_device *dev)
> -{
> -       struct fe_priv *np =3D get_nvpriv(dev);
> -
> -       napi_disable(&np->napi);
> -}
> -
>  #define MII_READ       (-1)
>  /* mii_rw: read/write a register on the PHY.
>   *
> @@ -3114,7 +3100,7 @@ static int nv_change_mtu(struct net_device *dev, in=
t new_mtu)
>                  * Changing the MTU is a rare event, it shouldn't matter.
>                  */
>                 nv_disable_irq(dev);
> -               nv_napi_disable(dev);
> +               napi_disable(&np->napi);
>                 netif_tx_lock_bh(dev);
>                 netif_addr_lock(dev);
>                 spin_lock(&np->lock);
> @@ -3143,7 +3129,7 @@ static int nv_change_mtu(struct net_device *dev, in=
t new_mtu)
>                 spin_unlock(&np->lock);
>                 netif_addr_unlock(dev);
>                 netif_tx_unlock_bh(dev);
> -               nv_napi_enable(dev);
> +               napi_enable(&np->napi);
>                 nv_enable_irq(dev);
>         }
>         return 0;
> @@ -4731,7 +4717,7 @@ static int nv_set_ringparam(struct net_device *dev,
>
>         if (netif_running(dev)) {
>                 nv_disable_irq(dev);
> -               nv_napi_disable(dev);
> +               napi_disable(&np->napi);
>                 netif_tx_lock_bh(dev);
>                 netif_addr_lock(dev);
>                 spin_lock(&np->lock);
> @@ -4784,7 +4770,7 @@ static int nv_set_ringparam(struct net_device *dev,
>                 spin_unlock(&np->lock);
>                 netif_addr_unlock(dev);
>                 netif_tx_unlock_bh(dev);
> -               nv_napi_enable(dev);
> +               napi_enable(&np->napi);
>                 nv_enable_irq(dev);
>         }
>         return 0;
> @@ -5277,7 +5263,7 @@ static void nv_self_test(struct net_device *dev, st=
ruct ethtool_test *test, u64
>         if (test->flags & ETH_TEST_FL_OFFLINE) {
>                 if (netif_running(dev)) {
>                         netif_stop_queue(dev);
> -                       nv_napi_disable(dev);
> +                       napi_disable(&np->napi);
>                         netif_tx_lock_bh(dev);
>                         netif_addr_lock(dev);
>                         spin_lock_irq(&np->lock);
> @@ -5334,7 +5320,7 @@ static void nv_self_test(struct net_device *dev, st=
ruct ethtool_test *test, u64
>                         /* restart rx engine */
>                         nv_start_rxtx(dev);
>                         netif_start_queue(dev);
> -                       nv_napi_enable(dev);
> +                       napi_enable(&np->napi);
>                         nv_enable_hw_interrupts(dev, np->irqmask);
>                 }
>         }
> @@ -5594,7 +5580,7 @@ static int nv_open(struct net_device *dev)
>         ret =3D nv_update_linkspeed(dev);
>         nv_start_rxtx(dev);
>         netif_start_queue(dev);
> -       nv_napi_enable(dev);
> +       napi_enable(&np->napi);
>
>         if (ret) {
>                 netif_carrier_on(dev);
> @@ -5632,7 +5618,7 @@ static int nv_close(struct net_device *dev)
>         spin_lock_irq(&np->lock);
>         np->in_shutdown =3D 1;
>         spin_unlock_irq(&np->lock);
> -       nv_napi_disable(dev);
> +       napi_disable(&np->napi);
>         synchronize_irq(np->pci_dev->irq);
>
>         del_timer_sync(&np->oom_kick);
> --
> 2.48.1
>

