Return-Path: <netdev+bounces-174053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCFAA5D2EB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 00:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C190A18937E3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 23:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520151F09B4;
	Tue, 11 Mar 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpjThCiG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AE1E832A
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734284; cv=none; b=OCnrdb2LNulqvNGkJcv5fOsswue4i5okLJqaqVgUjiooD2cNSO38Wu3bNIOS3+/Y8/NYcm5Gg+lCbbjPY40KlG2773YuMxfVgeiddMP13aZk07Ztw4XkvC73Vcgp4UdjznJi2hw0dLCETGXbEsxJN1psBKOMCMEW8WR6jy87klQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734284; c=relaxed/simple;
	bh=COk0MdfHW6RlRh6RZLXeO1qkIUN7/KaupGrEVi/7eoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cepEJC9GVt6tyavTl8vTdb2MfE8pvCtNYyGyi8wSINSv2DbCD2KGA6e41TBKBiPulASlMUvEI/toFvO+5fhcW2OrG9EM/N070gCDSsbJS4eR/xfxCadyb+Lj1idUGxJgJotdXHriyNKNoV1DoQuPTZHxxnUXpbpqWHPUZGxnh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpjThCiG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so474423066b.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741734281; x=1742339081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DoyGMSDjtwoW9bneNJ6irZbWj3vs1n/EVCtg3b03ss=;
        b=bpjThCiGI609q+aZeUrZ009YjAvqny+Zf0t1LPQloMyNNzDsSs4GaOgLi8CBhsU0ZN
         AmENz9l5fZcgigAkZCaI+wKLiOr7oMocIZiImo1Qg1bgApYGGczRTl53BuzXr1365YNh
         LSC+7ILvXhePHgLb+6kp9kH/CCmerxkr3VDTuj3zSNXUmk5QO7JLEeqWRXMPPRubFOVX
         kInASBszxh7HH4xTX/8dLeWivarpB+Y0SczMjQOfNRIbPSNNKzJT5DYJiivgvX06PiMI
         JqzQofUKWxC15eWUdKK4ILtHrO+NoZTUYIiNg7pjdqnqFCuty2Y/8zZ+kDsd63zao8ed
         Iu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741734281; x=1742339081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DoyGMSDjtwoW9bneNJ6irZbWj3vs1n/EVCtg3b03ss=;
        b=nItEO4AXeBicFEc2O1dQ1P3rumFKaf4X5i3z+jJbmCvi0au6QD35ivb0kRmHAcukGh
         rJdMzI1v7lPUx/CQ8NuClbBpV4iCcwy8CEAL84bHcNN7DxFnegeVmKoq9X35d91O56fo
         u7tkNy+acqWFjJvM0TtzKcRxiML9rrcXlcqIoQZsq5CbZIt3T0ULnRp1+Rx9I/q8SIKy
         rOgfxAPv306i8D5vSfy7K+ArdCVSF/rwPOsHP+Lt/E+JOUV6X1m0qgpCGYn4U9WWkW3/
         0RQsMy8PuGTcKBCfFmcJmNpO+bdCRTVvAzq+Xh80U/D1Vwr8Mo3a4DcaoaTSb+5Yc8N+
         8D1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlfci9wfY4taDFv+CiqgMgZJPJ5ZIXL7bKcfxqGwhAjYn3OuYz0sJm5catA0JZaRSfH+whr7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZQDdDs/obEcJdZLWzfi4S/tQUK5shH8mbL0b1ow5TNvycAIO
	cg3vT1lREYW5u67TNrWrypQHWpk1MDu6Gsz6e3z+a2kPATUc0448tD6ndKWFszlg3bIRdcxEXWZ
	iFXTtO9JrTHpVzC9kiPonArvlz6B5f27rP7M=
X-Gm-Gg: ASbGncuaLEOovxfUd5D2x6UIoErdMIjTqADry8I2k2Z9aL5PkWhSezOZ6YpJStcWwrg
	Y+i9cKyqS2STKO6yznY0+b37ysbiEIi42iJRxAPhUMNtfzsrAKGqJ9Poz3CYkFknpX8vMezEJzh
	hb0Quc7SfhHfTXYbM550j0MAo=
X-Google-Smtp-Source: AGHT+IEEErcM9pJk/8Vm0zIXdAghB0zs19W7Ia23xbCKyYZq80ALNxWU3yKq/7e6z2NCSnIIVbvMwR4EbtkAF6VyDR4=
X-Received: by 2002:a17:907:1b2a:b0:ac1:ad15:4a8a with SMTP id
 a640c23a62f3a-ac25274a090mr2868341366b.10.1741734280505; Tue, 11 Mar 2025
 16:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311224412.it.153-kees@kernel.org>
In-Reply-To: <20250311224412.it.153-kees@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Tue, 11 Mar 2025 16:04:24 -0700
X-Gm-Features: AQ5f1JrfM-joKuFJFF8VvgPkeBvNEFKE_wMOY97xBob5wcZPk8JkS9B0dZxzBdw
Message-ID: <CAGG=3QUJ4NztStM3GDxLqMyT4_O+8WuhaYCiK4rin-i40qwCcA@mail.gmail.com>
Subject: Re: [PATCH v2] net: macb: Add __nonstring annotations for
 unterminated strings
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:44=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C

s/__nonstring to and correctly/__nonstring to correctly/ ?

> string" and thereby eliminate the warning.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v1: https://lore.kernel.org/lkml/20250310222415.work.815-kees@kernel.org=
/
>  v2: switch to __nonstring annotation
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/cadence/macb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 2847278d9cd4..003483073223 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1027,7 +1027,7 @@ struct gem_stats {
>   * this register should contribute to.
>   */
>  struct gem_statistic {
> -       char stat_string[ETH_GSTRING_LEN];
> +       char stat_string[ETH_GSTRING_LEN] __nonstring;
>         int offset;
>         u32 stat_bits;
>  };
> @@ -1068,6 +1068,7 @@ static const struct gem_statistic gem_statistics[] =
=3D {
>         GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
>         GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
>         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
> +

Is this an errant inclusion? :-)

Reviewed-by: Bill Wendling <morbo@google.com>

>         GEM_STAT_TITLE_BITS(TXURUNCNT, "tx_underrun",
>                             GEM_BIT(NDS_TXERR)|GEM_BIT(NDS_TXFIFOERR)),
>         GEM_STAT_TITLE_BITS(SNGLCOLLCNT, "tx_single_collision_frames",
> --
> 2.34.1
>
>

