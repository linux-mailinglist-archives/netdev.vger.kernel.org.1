Return-Path: <netdev+bounces-157959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98FA0FF24
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73DC3A1645
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E662309B9;
	Tue, 14 Jan 2025 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTDRf8Nb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B21E535;
	Tue, 14 Jan 2025 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736824850; cv=none; b=GgTBx/9cT3KRwqZv0Y7iVgBsKJrEhJE9NxiuJhTAHNvu8YTmiOi4JKtCHvcK4ZYg95ucl4wRyiAmAd+6DZtAzUJeZySJLe7YtP3apS4aEgibntusSoocsSMXDwYmXsXghaa+QynApCUbGE0r0wvaV6B30UJQBOoz7mZCZPE2buQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736824850; c=relaxed/simple;
	bh=Oj268A4xi+IKftY/audnlMRxg7UoULqF6B3v8phaVG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRCPtGHBCC48x+bi7uxRN8NyxHKJceAYTp1xM23sSN4+wOcdRclhS7eEPV7mfMYYkUnSWKKy5bjUz0+iPC98D3VB2BySTzb6WjOUbvRITAR/rKw+526OeNjjMLNNkCL2J5/GKUrdThd1HUauPO/oDJBbiJeLSX4XOEV7Aw2pTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTDRf8Nb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso10244310a12.0;
        Mon, 13 Jan 2025 19:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736824847; x=1737429647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR6Yc5zBHeV1nQKHSgI++L0E9NIg0cDkHCvlCkHXgwg=;
        b=hTDRf8NbKpBhLZmSBw6HxoFFQodVIL0hfboS2HVQt0vpnQY/a/TdJasQlMAauQGDun
         h598guw82RK6jo3MEkcT0BV08EO8KvIwSL4MpRkddxw30Kaf15vVBDYcwIn1M7Bc0kv1
         ZcQUF16VyufYavXU69MNfR20XfVi+7/PYZkCdE0xNNEhBFvt2cpp6lda4N19Qu+zNsWL
         6Qpr4eUzFOzTRLSygn4BkszCMSnPB2XYm2L/pkGp35udNy8QHTNqygsKfTW6S9ImhYli
         yM1sj8TKGzSTIiia8WVrJ2nYm6szLBpJTnEaw46zcV4ofmWPMYZauAE3LsFl6Kyuambz
         lp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736824847; x=1737429647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR6Yc5zBHeV1nQKHSgI++L0E9NIg0cDkHCvlCkHXgwg=;
        b=rlrhxRbqf/B/bIb9p4IjQWhmWwDwEWvHKg4dk38uSgQYZeOaG10i/du7AkFYleE2LN
         CTbiDSV7/pvvNcYr9Sbo1LCZDLPoovTqzMe38e2N6yEbysT4NnLicHrHirQPNeT0cQ/N
         e01KC+XSYlNYMgfkoUdFxz9avscrztr9zmobSvIJiBbxgcbtwv0DhoP2aJT0RkltbrUU
         s4x6Jcg/HHMeWGctyToQWG0a2H/qeb3ZWfTDsKO2OQiTVCJbpQ9EkwkRBghc5CFEW9SI
         bbTvH+ZO1Zbv1vQCK6OU+dGO+s84r9cORMr2X6XncIP9bEl7qhjQaf0/fO/S113sxJvv
         Rhvw==
X-Forwarded-Encrypted: i=1; AJvYcCVF35KXYQXzDE/G2srFKD6T3t6F0zRHLIMRIyrZEkuWaSELMdw/OKsBcFnBjVk4N9GnSKDMS7gzuDY=@vger.kernel.org, AJvYcCW41JICwVeTOMG73MSgTD4UG1RbSykuju4P1xQLnbMuPOZlGzUtSJiC4HbSqMCP3mQ+OAbEevX5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AEjKBjCQfu5zn7Tzq5KaSM5x0/ZepPW3MsWz2BPR4evwX0dC
	aC3lzTHw6S1Ig8Bk/Hsaxp5emQ7pcJOJeNzBqhV/SBV+lL3AyemlY31kpl9+WAC6HCEZt+z5w7x
	1BGVElh9fMxd/sxYo7GFtPhUXjeA=
X-Gm-Gg: ASbGncsrIzUjvGX7LXCLGcT3gF+b0d6w/8Hh5trW42BZdLtoOxqJ1rVi2gAqrnWhLFB
	xIL3YTZeyWY1vtP72AW4Jiq5xoRwYv0ipa9CPERtl
X-Google-Smtp-Source: AGHT+IGmNw+iI5ASqebYMej/XhNoiOp6kuGH4xlsSUgj4d8iyk+ErK5urioQlrCsCqT+kO7WFEsICrSDHjsq0DxPeho=
X-Received: by 2002:a05:6402:3604:b0:5d3:cfd0:8d46 with SMTP id
 4fb4d7f45d1cf-5d972e6ade1mr22982841a12.30.1736824847009; Mon, 13 Jan 2025
 19:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111144513.1289403-1-ap420073@gmail.com> <20250113150834.729de40d@kernel.org>
In-Reply-To: <20250113150834.729de40d@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 14 Jan 2025 12:20:35 +0900
X-Gm-Features: AbW1kvZvzea8zsqaaioytTwT8637fMYt4XkvKsusryQf0wlAFhkXFOM4TlZtrHk
Message-ID: <CAMArcTXUNVw2wGcUjS+bfW47K0Yd88G478QwEk3yW2f9b=Kvjw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/10] bnxt_en: implement tcp-data-split and
 thresh option
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	netdev@vger.kernel.org, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, michael.chan@broadcom.com, andrew+netdev@lunn.ch, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk, 
	sdf@fomichev.me, asml.silence@gmail.com, brett.creeley@amd.com, 
	linux-doc@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 8:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 11 Jan 2025 14:45:03 +0000 Taehee Yoo wrote:
> > This series implements hds-thresh ethtool command.
> > This series also implements backend of tcp-data-split and
> > hds-thresh ethtool command for bnxt_en driver.
> > These ethtool commands are mandatory options for device memory TCP.
>
> Patch 9 doesn't apply cleanly, could you rebase and repost?

Hi Jakub,
Oh sorry for that, I will send v9 after rebase.

>
> Applying: net: ethtool: add hds_config member in
> ethtool_netdev_state Applying: net: ethtool: add support for configuring =
hds-thresh
> Applying: net: devmem: add ring parameter filtering
> Applying: net: ethtool: add ring parameter filtering
> Applying: net: disallow setup single buffer XDP when tcp-data-split is en=
abled.
> Applying: bnxt_en: add support for rx-copybreak ethtool command
> Applying: bnxt_en: add support for tcp-data-split ethtool command
> Applying: bnxt_en: add support for hds-thresh ethtool command
> Applying: netdevsim: add HDS feature
> Using index info to reconstruct a base tree...
> M       drivers/net/netdevsim/netdev.c
> M       drivers/net/netdevsim/netdevsim.h
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/netdevsim/netdevsim.h
> Auto-merging drivers/net/netdevsim/netdev.c
> Applying: selftest: net-drv: hds: add test for HDS feature
> --
> pw-bot: cr

Thanks a lot!
Taehee Yoo

