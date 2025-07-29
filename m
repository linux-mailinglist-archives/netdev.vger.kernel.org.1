Return-Path: <netdev+bounces-210721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7A2B14866
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14F34E1721
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 06:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108D2586EC;
	Tue, 29 Jul 2025 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcTu401M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EB1F181F
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771554; cv=none; b=InZLXXnOylcNQ0+Adfjb1G17AiJsp0GSpbCu5lDj+Ay2eW/KfQXxxxwgUtNsKBpmLSzFqqB4nAX+rdJAFIxmem70Rq9gNUGHf8Llsx3xM1g1dliFWVHlL3OVPIInudrIi3JaG1BhCuwbU2q34GQuMay/NTKQum0s7lboJ/K6NWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771554; c=relaxed/simple;
	bh=PcTpL9aiWqsUnil6m9DsRT09aiu1VZaQCa31F05p/d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWw9K7i/rgRZFNIgdkye0ExMd1NHLcsg7NJoO7w9AwSWicQpoOaPEQKwJyj2FW2cy6SC6vzkwpRHbN4a3eXU4W96D7wJW8BW7wix/DdL1XqLTedfvxZ0q8DrPz7goyCAnClmH07WQRF84IROHM/SdRuKTLlVLcSzFNbvFndd9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcTu401M; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab39fb71dbso54500161cf.3
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753771552; x=1754376352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQoFGeyb1sa0etD/ehhA4Y9O6J1HPk2CYhsuhSG36cs=;
        b=kcTu401METupS5U0Cu/z1/ynmRaNgR/ZdoxLUk1GDzGkOvXMHOFuo6lf7mWDv11sla
         g0Rme4Q1IrJgeaww3xo2DcngwZpHMdG236QfQrl3okYutplMPGuxde0J6Lq8RP3WobBt
         0UP5NODZHz1K+DGQ9oj3PP3iO8UrIIEOviVZxfKvRmQ5myQFFjFHVvjuQB7RNjWFewN4
         TuSx2jXe5RiEvdao31obkOSU7WrNS30qbPw7SE/jhGaIst9zr++M555d88LYs9SycINV
         iktgMxKPHMZJQeMcIOtRDWVJ6kcdyBDfjEz9f2liFPzj+2xYFBSm0smE+3CB8VgHI95w
         e8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753771552; x=1754376352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQoFGeyb1sa0etD/ehhA4Y9O6J1HPk2CYhsuhSG36cs=;
        b=vQ1THjI100KRgcRV3m+jkzE+tyJ91UrFZTiUrQHfcIa8kc58YpbKiG1Yq90EVnG/+t
         FgZOqwvHn0V1yjFLg14VXolA+l+rR3C27AVQ6ukVTDicwekH/FA2/aiNPppyMr8MedJd
         xm8dCXS7Y65qURRdS79HKJypUNjoqNn3UdFUpFzmp1TXCO1lnInkGhgXMAL9I5Xywj4R
         3++e4t88/T9F8B4lQjkP2N4X62fzIA+hdkFwPkSRvCFX0gZH/OC4zA5VuHzFyHQUztih
         /MR8hiaXmnM0/bbnZwTZLtIcNSPtqFV6+nmzSFJVPY1fAz7nKjTBMs3O65MLaNlJXLLf
         KpHw==
X-Forwarded-Encrypted: i=1; AJvYcCUO3jBitSJgCuZ3kBh9ePpR9UAueTfgcwGj//5rsIUMgvW9cE2QC2sZCdhypD0N6oQ1THiTtJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu48c8Gd84CZQkiPpzr0hH/uYQF5wgLQ+W6lmTygUYy/1QQfRy
	hSHwaZAaMaXNiTafnCA841HsYtCwvNFPkBIFTUafX6VxWtSdUixLDosIjGQR4xAp5+OhSOJJJgb
	x1jjZw9R2FTMBQzzHxr22XlUM7l/VTw0fJ1bQAKkz
X-Gm-Gg: ASbGncto+QE1ciqJZuWmNMRx6My9FbjfwtmTv3mMxo5qZCgjkVaGPHhGp0v2TcXdfAb
	qqfAWJ5MjHXmcJBu1EzD8D0rUpZxYw0EbNLU18le3rmqAQzMZoY5y4zjDbQ89M5lXAiX69VgtcY
	II9DScZ9ZsKQrmNWjGFNkRJSzTluNzQtbFs3DFPv4M1DqHVuoCoK5m6HCFjwyzIbXfXPfBO0POM
	XcpjQ==
X-Google-Smtp-Source: AGHT+IHJGSa9BrDBGmv4AeJEGRr4VYK1jFw9YSODWnec8HNcZ0pj3L9SBPJOg6NsXnpbR5XSn3B/4FEGuMfMVsP4lIY=
X-Received: by 2002:a05:622a:130f:b0:494:b1f9:d683 with SMTP id
 d75a77b69052e-4ae8f14b8aemr192800181cf.49.1753771551558; Mon, 28 Jul 2025
 23:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729061034.3400624-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20250729061034.3400624-1-vineeth.karumanchi@amd.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Jul 2025 23:45:40 -0700
X-Gm-Features: Ac12FXzJv3RoIAVw7ZgeBTkccqUfjGYeQkbZlYWZf56ZMDuvnk7VBHW81XjCz40
Message-ID: <CANn89iLhSq4cq4sddOKuKkKsHGVCO7ocMiQ-16VVDyHjCixwgQ@mail.gmail.com>
Subject: Re: [RFC PATCH net] net: taprio: Validate offload support using
 NETIF_F_HW_TC in hw_features
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: git@amd.com, vinicius.gomes@intel.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:10=E2=80=AFPM Vineeth Karumanchi
<vineeth.karumanchi@amd.com> wrote:
>
> The current taprio offload validation relies solely on the presence of
> .ndo_setup_tc, which is insufficient. Some IP versions of a driver expose
> .ndo_setup_tc but lack actual hardware offload support for taprio.
>
> To address this, add a check for NETIF_F_HW_TC in netdev->hw_features.
> This ensures that taprio offload is only enabled on devices that
> explicitly advertise hardware traffic control capabilities.
>
> Note: Some drivers already set NETIF_F_HW_TC alongside .ndo_setup_tc.
> Follow-up patches will be submitted to update remaining drivers if this
> approach is accepted.

Hi Vineeth

Could you give more details ? "Some IP versions of a driver" and "Some
drivers" are rather vague.

Also what happens without your patch ? Freeze / crash, or nothing at all ?

>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Patches targeting net branch should include a Fixes: tag.

Thanks

> ---
>  net/sched/sch_taprio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 2b14c81a87e5..a797995bdc8d 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1506,7 +1506,7 @@ static int taprio_enable_offload(struct net_device =
*dev,
>         struct tc_taprio_caps caps;
>         int tc, err =3D 0;
>
> -       if (!ops->ndo_setup_tc) {
> +       if (!ops->ndo_setup_tc || !(dev->hw_features & NETIF_F_HW_TC)) {
>                 NL_SET_ERR_MSG(extack,
>                                "Device does not support taprio offload");
>                 return -EOPNOTSUPP;
> --
> 2.34.1
>

