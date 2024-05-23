Return-Path: <netdev+bounces-97684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248978CCB4F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 06:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4612832E1
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 04:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94B13A889;
	Thu, 23 May 2024 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enwxCiJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDA12B151
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437719; cv=none; b=MrFJSoeppGCULwjarvFMMzzHAiVPDU09XBOjKAuOwQ5N3qtccH2xZoWqE63Sm9Xb5R0CPeIKPo35DxKZBPTJyh102DXq3MvTI+nGjOjP8PWXvunYPPlO2K3blubU7lklKZdfl4MaQi6P/9itYoTqrTYCj8y9x2Zp69LJWWy58wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437719; c=relaxed/simple;
	bh=zvCTIHs5YqJAlk7Ohu27hGvHT/jfiV6FMeApCgHcMnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngtX8Muu/K1E185ybmwzXzv3rJF8/jKEpTpTN86VEqFTvTAz8K2wig8G852dWGohj0Xs0ae86+JPnOt1Sjy8D06Ak1rqlGao3lcF5fau6jIY+JQ97YQ9PRQO9Qs6ZKk4hq2/mGan4+LnCf5HQY5FFJcsRUOzZXYT4ggzoQ9qAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=enwxCiJ8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-627dde150d0so16820897b3.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716437717; x=1717042517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MET5FIAW2m/C0sBmsEV+FEl5MEocq9FyxllKEm3F0/Q=;
        b=enwxCiJ8Pu4y3afNPKnwX0iF3xdSNja5ztO3S+9Z+o6RywUPrmIKXYu9wIaRgzJIU+
         gpZMZZ2HNWAnCaBkfTldPnyGXUoJQ4oBLs0YNkHj3WZtI2VbBuMdkGjA0OjWJx4+J2n+
         8dF5ZYSm7/jpwAcpRwa4i+0oobw4z/8EPzff9sd0b1cfMWleZbJPvLg+Jo+czAUpaRL3
         LvZc7C2OD5VbIIBut2ufSIh+1Iut9NJOc/LbebapTgQPoyOfe+CTwlq5Xwi39+WWpuD2
         P2R2sjCVHrgU73gqEHFUWrpYgGLiHSMpYFs5AybrxAYxDMzB5qWQB2AwIlSdyVjVdBSn
         ZbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437717; x=1717042517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MET5FIAW2m/C0sBmsEV+FEl5MEocq9FyxllKEm3F0/Q=;
        b=fdMDPC4vNbC1Kai9ZVRdj5XwV0wnDWSvCTdxktJnkUNVI9qgZxnUszWWgotbTRYN/Y
         HFwpm8UG541tQr/O2dP8AJXqbXK/QvOHbiNwHN1gzme8omg80d9iXQ8B0TbgYPZLd7K0
         5hVH3i9ul4swDIfzRwEpOTZrDs5wph/+m1HqB3QDWVDpj4hSxVJewkIGp4amzVNyWi1Y
         FHPQdjauSjzDIBYsSHKKNiyiHm8UtI8U0cV0i3Bfgfirt8pVOhlZvMt7ecknQj6wTQcE
         9a8Q1zYsdOR+KcCGUmLOz0VLfRZIe2+ThBlGTAiViYg4l86UQa9j/py7T4Wt2q0WqtqY
         I18g==
X-Forwarded-Encrypted: i=1; AJvYcCUpksRHv03J7ZZ6tAXCCs2uvXDSpbbwez55GwtC07AX1++SnJmJhlI3XMr25AiJJR5LNjbfcYHFQ1DY4YvTMuyCQwOY8me/
X-Gm-Message-State: AOJu0YxGbH48e/1a/496G3D7ZlogO/9IT+lQeY2eYgimjRhA1Yclkzm8
	cPXnRaW0ezA0+zNt9Y3vT5UhOF6CKgo8fK0gTVedS+B2Ljt7wPS+eD4lvkbUjUfR4A6DpyoN8fc
	wJ3jnTaEZpxd7XxBekXFgg16pEGctUe12vqAl9g==
X-Google-Smtp-Source: AGHT+IHkorZjav4Gf4d1OozhsH8Pxc0dMg8/LiEOsXhzjkpYSCLGHEfn/HFnM6PbS2MvI8LGr5ycTQTnUTfx3eftbnY=
X-Received: by 2002:a81:4f4d:0:b0:61b:748:55a1 with SMTP id
 00721157ae682-627e46ca1a9mr40027607b3.13.1716437712376; Wed, 22 May 2024
 21:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510090846.328201-1-jtornosm@redhat.com>
In-Reply-To: <20240510090846.328201-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Thu, 23 May 2024 12:15:01 +0800
Message-ID: <CAMSo37V5uqJ229iFk-t9DBs-1M5pkWNidM6xZocp4Osi+AOc1g@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Isaac Ganoung <inventor500@vivaldi.net>
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Fri, 10 May 2024 at 17:09, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> The idea was to keep only one reset at initialization stage in order to
> reduce the total delay, or the reset from usbnet_probe or the reset from
> usbnet_open.
>
> I have seen that restarting from usbnet_probe is necessary to avoid doing
> too complex things. But when the link is set to down/up (for example to
> configure a different mac address) the link is not correctly recovered
> unless a reset is commanded from usbnet_open.
>
> So, detect the initialization stage (first call) to not reset from
> usbnet_open after the reset from usbnet_probe and after this stage, always
> reset from usbnet_open too (when the link needs to be rechecked).
>
> Apply to all the possible devices, the behavior now is going to be the same.
>
> cc: stable@vger.kernel.org # 6.6+
> Fixes: 56f78615bcb1 ("net: usb: ax88179_178a: avoid writing the mac address before first reading")
> Reported-by: Isaac Ganoung <inventor500@vivaldi.net>
> Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
Sorry, I just have a time to test this patch, and it does not help for the issue
I reported here:
https://lore.kernel.org/all/CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com/

Here is the serial console log after I cherry picked this change:
https://gist.github.com/liuyq/6255f2ccd98fa98ac0ed296a61f49883

Could you please help to check it again?
Please let me know if there is anything I could provide for the investigation.

Thanks,
Yongqin Liu
>  drivers/net/usb/ax88179_178a.c | 37 ++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 377be0d9ef14..a0edb410f746 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -174,6 +174,7 @@ struct ax88179_data {
>         u32 wol_supported;
>         u32 wolopts;
>         u8 disconnecting;
> +       u8 initialized;
>  };
>
>  struct ax88179_int_data {
> @@ -1672,6 +1673,18 @@ static int ax88179_reset(struct usbnet *dev)
>         return 0;
>  }
>
> +static int ax88179_net_reset(struct usbnet *dev)
> +{
> +       struct ax88179_data *ax179_data = dev->driver_priv;
> +
> +       if (ax179_data->initialized)
> +               ax88179_reset(dev);
> +       else
> +               ax179_data->initialized = 1;
> +
> +       return 0;
> +}
> +
>  static int ax88179_stop(struct usbnet *dev)
>  {
>         u16 tmp16;
> @@ -1691,6 +1704,7 @@ static const struct driver_info ax88179_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1703,6 +1717,7 @@ static const struct driver_info ax88178a_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1715,7 +1730,7 @@ static const struct driver_info cypress_GX3_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1728,7 +1743,7 @@ static const struct driver_info dlink_dub1312_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1741,7 +1756,7 @@ static const struct driver_info sitecom_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1754,7 +1769,7 @@ static const struct driver_info samsung_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1767,7 +1782,7 @@ static const struct driver_info lenovo_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1780,7 +1795,7 @@ static const struct driver_info belkin_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1793,7 +1808,7 @@ static const struct driver_info toshiba_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1806,7 +1821,7 @@ static const struct driver_info mct_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1819,7 +1834,7 @@ static const struct driver_info at_umc2000_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1832,7 +1847,7 @@ static const struct driver_info at_umc200_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1845,7 +1860,7 @@ static const struct driver_info at_umc2000sp_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> --
> 2.44.0
>


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

