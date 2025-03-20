Return-Path: <netdev+bounces-176405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF9FA6A15A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E605C883358
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69220D519;
	Thu, 20 Mar 2025 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqGMKd+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D11EE02A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459347; cv=none; b=bLQ0j8XBjgbRyFU4QuySv+Ui2AW0w607YnfTBhuBlHE9jGB2CHjXU/0IQE9gNvzo89nbDgGdXzf5VJ/DeW0Rgi3wN7DNs7Axe5CstUETNFCb22JdrNkMxjRg+9iTNN0FiyCumqyIZmzYTqpvr7UUMz8CAF5qDioMtHrO0KTel3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459347; c=relaxed/simple;
	bh=5iLzZrp+LGOn/tFMRD8Tz+07XXtNhwK94xQ4Tc60hrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atbyKaX9KLUWyGbTEk0KerOC/tlBxiFUfGt8549VRK1Pz9SUNsN8iS6J1F15mzhwH3KUpYTH/wWD2zykCy12C/Z1DE6TjWKP+NTNL/Y2OPN/fOBFJonK0HcKQA7qnmpAJAEyoroR0edWdDCt0HUSrF7hlh20POPFjGsDqa+OPow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqGMKd+9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso827350a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742459344; x=1743064144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+lLTsLRQvhX2lXLqcBPhks1XwWaY9iMJXIMC/StTmlg=;
        b=mqGMKd+9u6J8SYJN37uuf2g7iSuASSNvvqOBNrUG5uefiE9iyEDhKD+YlcxKajITzz
         hWs7RVBgT+3lxWjVQip75pB82lvQmqKBSn5tc2bbkebH3zvBXUlL8iySvJ5473jxffxl
         GNqA6OI+2gpJOPUc81vsYNuc7gNZngPKBn8s0rZzaa0sJ+tywe+EWn2b9kn++ZfLcsrP
         fSXJlMwZJaoXRFVIkcyA57tMbGAYo8jYz3PT3jqnwDybBEc95+cfGdpMy2BQ6duT4qu9
         TV/qJ48+NPqbCkMHHnsb4qi12m7igJskWVfjoim4MZKS+EnaUuZSPVX4MAA6ckyDfsO+
         z25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459344; x=1743064144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lLTsLRQvhX2lXLqcBPhks1XwWaY9iMJXIMC/StTmlg=;
        b=BPvVcxLsJWY3v8SOLqbN7xZzN5U8z8VkCZ/n1NWOHUwptB7Qz1+5Hn+AtmYSAPWWOB
         miXYh9FDEjIn/1NdYLWMUtoLQsTzPxyCLTYgRD+ROOVXFt1CaQ+OYbTbyXJHRGVCx0kW
         hiSwMv2RGKOd6TGt4B27DWq/KnOD9622ba0gT55wvKm6bjSoNyoKG8Fwqbmh306ARSSm
         GnvR4I7xlElPf1sXkctIUdExhsmg1XHmU8fNGWbSWuZdyE/POj3mt7a4sLYs14Xxo+Lk
         jBlJl40xxJQzgFtSctIMRwwG+lA253oVouzjrx2FnQO+Cio2faZ5ah11WGQC577D8ayP
         OwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFPii28VeKpWu6EJFsJUKu1ZJ0UN0gOHFOu3WM/CN+USUeSQjrKyThTSRtxm1NEyFXoG3G6Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUpX5TtdROladAGhGOYnEVEeuoEPAmxd9lxWYMDIP68jVqx2k
	pif7PeUoQLZBytxtCMSOG/CeNGsh2YLF1FGCGol4xlgRX16rdRXGlfF3u0KdAD+GF+CZpShaq+b
	TMWvtEx6Hu/SOGr+DTCunMeTl3Nc=
X-Gm-Gg: ASbGncssa530vYWOciQafUa9BlZr4GbO12uCu6hw+P32vBoNKuesekHPP1YLjuPkuVe
	YAxkDOLdeE6eLFR68ipGAyI4yY0GGSmtD8h7sjRF2uhJyS3Qnbj7gGjD3LV0VnXpl1RN1h8/QMr
	z3fBZasfYQx20g/oe/Cpt/uOrKTZMQLcN5pQ3RnZcheh4xfVOTdtZCudCz+A==
X-Google-Smtp-Source: AGHT+IEbn/7WlMXZrMmB/3c4ildBPTSbhz/QEyzGvCllWlokLp0//uiEtLv+zROXfEWR9VuYKWiQ26ZHzY9fZJriG3s=
X-Received: by 2002:a05:6402:1ece:b0:5e5:b388:2a0e with SMTP id
 4fb4d7f45d1cf-5eb80cdca41mr6226924a12.7.1742459343670; Thu, 20 Mar 2025
 01:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319124508.3979818-1-maxim@isovalent.com> <fadfb5af-afdf-43c3-bc1b-58d5b1eb0d70@nvidia.com>
In-Reply-To: <fadfb5af-afdf-43c3-bc1b-58d5b1eb0d70@nvidia.com>
From: Maxim Mikityanskiy <maxtram95@gmail.com>
Date: Thu, 20 Mar 2025 10:28:37 +0200
X-Gm-Features: AQ5f1JqEMLJvQx6YqiJna8_tPX19S2ZcuTw5wqFIBMph0mU8OzIiLgTMAXgTy-4
Message-ID: <CAKErNvrbdaEom1LQZd6W+4M-Vjfg+YRzgEz3F7YWoCXB_U+dug@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS context
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 10:25, Gal Pressman <gal@nvidia.com> wrote:
>
> Hey Maxim!
>
> On 19/03/2025 14:45, Maxim Mikityanskiy wrote:
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> > index 773624bb2c5d..d68230a7b9f4 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> > @@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
> >       case ESP_V6_FLOW:
> >               return MLX5_TT_IPV6_IPSEC_ESP;
> >       case IPV4_FLOW:
> > +     case IP_USER_FLOW:
>
> They're the same, but I think IPV4_USER_FLOW is the "modern" define that
> should be used.

Yeah, I used IP_USER_FLOW for consistency with other places in this
file. If you prefer that, I can resubmit with IPV4_USER_FLOW.

>
> >               return MLX5_TT_IPV4;
> >       case IPV6_FLOW:
> > +     case IPV6_USER_FLOW:
> >               return MLX5_TT_IPV6;
> >       default:
> >               return -EINVAL;

