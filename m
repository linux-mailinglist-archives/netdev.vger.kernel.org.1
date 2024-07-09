Return-Path: <netdev+bounces-110325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E7192BE49
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7781C22E5B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974119D097;
	Tue,  9 Jul 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXZA6c3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39419D089
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538888; cv=none; b=J0mOt2EqidvJCMy1HHqCpoWaWdNA+3ycA1HlNlv57Vkr9oIfkTLt/0AQUjO16HK70iUjzdUAmQ/OaolVua4z0snpBtHiKF4+6E0gGvfsxKxuAT9usFLXQlYmSGl7M/xLSS8oGGD/+eH1nq/ZRn575ntAo6EKgKrqAABMCJNH1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538888; c=relaxed/simple;
	bh=bmzpuGZtae1sxfRhz5O/nUTK5nTCIQFyLTiHDi+hhK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/OEzrJEiyk9KMaAdBVBETGqkurHFN9swzk8HhWP9Ja7l/izc1LpIRcJTuQAJ3CH5gTz9jtSIFxtsrcoMIV64/Qpm/t6R5JKCzy/QLRi/YtVhBr14vuwhT6fiBWkSMmuJGu71PDbwWtDmb7vJCBQevqkYuUP1+SS+jNLyzJBfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXZA6c3J; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso16766a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720538885; x=1721143685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oz7iFbPy9x6jKPSlipqwYKyt0mKn37mM+Pcl7G9Qsw=;
        b=vXZA6c3JadF4p09aB/0gYpLfNPayplZ+t4HOf1olBMO5mZTxiEUDgT76YPWTlhJc5H
         ymXBew2fbDEJVCMiMUNVH1Ey2Th29WPshbirnaLOjqyzl/M534dJQCSmMJilLPTnf7MR
         DMNiBMU3trKcf2FOr3SXRVgs3J1J1ZFrqxlwUIrnjRqZdGkrrFBtFBAXS4rshDoFFJFA
         ZqdIUrAKqbjst9bzqDihLG9v1rMGVG36DoxVwchKfIYtmPNfGjg2dA7QFWnscqNJpB9e
         UM4SndO+NmXU02iKNJQMkmQIhvRXAzziRKfVk4jQ0urLOjedsriV64KNGqibHh2rDCJN
         IMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538885; x=1721143685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oz7iFbPy9x6jKPSlipqwYKyt0mKn37mM+Pcl7G9Qsw=;
        b=leZ0iiDjilMNmoiXw/d4dcS4B+2ySdJ5X+DopdsKB5uG6e1kmW9ckpMUu+UqB2HUok
         /ylarzcQLfsAbC22VzOmXYCGnDqELuIEaUOIdtVjSoVnOCisIzD4mOo37/dPsyfeCHEn
         9axtB+8Lconvk1lPfdcgM9LPZ9P612WaThxinqelefhJp8sDfxn31I3yI348zmv/wvme
         dk1SmOKeD2AUaCeGviHLDvOWaDUydYXI7F0QeZJf1HUvaDhOOhvmWvAEJmETO+pMAvLK
         zKRrazjZBs0ZjBvRpOupuAJEZUcIIwe8g09xH+NqcdAAxhjY2StCOs20hIgkIwi53p1O
         K0vA==
X-Forwarded-Encrypted: i=1; AJvYcCXIm4ZRPfHsicXaL+8xFNCfWnPs8MlvP+eYdBENwhanvs1NIgETpu3NyoWxnjPThgPq5dtA//CY0FJZW7ZGw76KO3ax0d3h
X-Gm-Message-State: AOJu0YzSB8VKGmlc3TAw21H3GFA4T2UgjZjpcPBgI+cgTnO3csm1nZBP
	EI/kzDzoBOFg2Ohsy2hzCBsVu+xIm4KRU0xYe8uhYp2myCEuAG/Zx4NAwMjp4TuxPJuZgmknZDY
	TAvxsZqt21EYul6Xaz35kElBBPz4aVnSy2f13
X-Google-Smtp-Source: AGHT+IF8CSkJvGGed5ndBA8XHwTEBAtbw5PQvIIvxORIqaGScYuzTZyQcKM6+zPcofzAMZGxN+ajQBZQkcxwNirf8P8=
X-Received: by 2002:a50:9fc1:0:b0:58b:21f2:74e6 with SMTP id
 4fb4d7f45d1cf-594cf64511dmr259393a12.0.1720538881433; Tue, 09 Jul 2024
 08:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709125433.4026177-1-leitao@debian.org>
In-Reply-To: <20240709125433.4026177-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jul 2024 08:27:45 -0700
Message-ID: <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, keescook@chromium.org, horms@kernel.org, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:54=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
>
> bloat-o-meter for vmlinux:
>
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
>
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> Changelog:
>
> v2:
>  * Rebased Alexander's patch on top of f750dfe825b90 ("ethtool: provide
>    customized dim profile management").
>  * Removed the ALIGN() of SMP_CACHE_BYTES for sizeof_priv.
>
> v1:
>  * https://lore.kernel.org/netdev/90fd7cd7-72dc-4df6-88ec-fbc8b64735ad@in=
tel.com
>
>  include/linux/netdevice.h | 12 +++++++-----
>  net/core/dev.c            | 30 ++++++------------------------
>  net/core/net-sysfs.c      |  2 +-
>  3 files changed, 14 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 93558645c6d0..f0dd499244d4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2199,10 +2199,10 @@ struct net_device {
>         unsigned short          neigh_priv_len;
>         unsigned short          dev_id;
>         unsigned short          dev_port;
> -       unsigned short          padded;
> +       int                     irq;
> +       u32                     priv_len;
>
>         spinlock_t              addr_list_lock;
> -       int                     irq;
>
>         struct netdev_hw_addr_list      uc;
>         struct netdev_hw_addr_list      mc;
> @@ -2406,7 +2406,10 @@ struct net_device {
>
>         /** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB).=
 */
>         struct dim_irq_moder    *irq_moder;
> -};
> +
> +       u8                      priv[] ____cacheline_aligned
> +                                      __counted_by(priv_len);
> +} ____cacheline_aligned;
>  #define to_net_dev(d) container_of(d, struct net_device, dev)
>
>  /*
> @@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct net=
 *net)
>   */
>  static inline void *netdev_priv(const struct net_device *dev)
>  {
> -       return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIG=
N);
> +       return (void *)dev->priv;

Minor remark : the cast is not needed, but this is fine.

Reviewed-by: Eric Dumazet <edumazet@google.com>

It would be great to get rid of NETDEV_ALIGN eventually.

Thanks.

