Return-Path: <netdev+bounces-166731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BEA371CF
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 03:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CB0188A280
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 02:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD9BE46;
	Sun, 16 Feb 2025 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3fylSSv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B543322A;
	Sun, 16 Feb 2025 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739672512; cv=none; b=EYVzQxgnCzajtbTW5P/2aK9mJVMTKLfIKvgUUjasuaigUpdjM3HPhqy04W8s1tJ0+qPFSdWEQ9Xtok+5GLgRhs6TSyUtU5iGqaKaA26J8FEjII5IPG5jzG6wRhOujxfLKxY+qzGB5rEQ3Yk6qe0FCl58xEK9NWHSdS2awFoaAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739672512; c=relaxed/simple;
	bh=89f6kjxXBtZAaNt6NCCVp/SV2zvdrtocy+P983Rdy88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwQU9BDEGVUVxK41J/sKV+IHNEtqZHS5ku+LOr34+V4Rl27OaootYW8MWbaJ1fAGUak4/vPl/Hp0XZygr2NTy9O0uI8t0jx0nIffUtniJAAYMTRnxY06LscCKpChxR5yrLOA+iiW5/UQkiljtWhbumJpHCrXJefjX9iwOaTy/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3fylSSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B80C4CEED;
	Sun, 16 Feb 2025 02:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739672511;
	bh=89f6kjxXBtZAaNt6NCCVp/SV2zvdrtocy+P983Rdy88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A3fylSSvAsnYH15ydUFS+r59N8y3bLbLFqbqACryAQfsbPwavz5g7jM0RcLMdcDtF
	 karFTM3aFOEIOi+smeCgIPWJx5TuDvcDft0+zLgshVCZeMvGd3cBnVar18mNGYIewZ
	 5giB+H993hrvDHnsuZyZw8GnSLVg6ZsFTAKEMiBZJTpCVLu8gyj0Q2qSfpiDRnJBpu
	 tfG+phyvg1zKmmtdze0tdfo5PK+eUswmvvgpuJLrtdv1LLUuDZRpr1VlK6GCKLnXia
	 BoQ4PpzouLkGmYqMKQUzrsUg0ZtZ6FAu1ZpKSBhE7o7lDhQ9oBu+pHMTqthW0lOYLu
	 vz4QuUvrxcFXA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so1718132a12.0;
        Sat, 15 Feb 2025 18:21:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbNGZb5S1JyHny9DU2Cg1MLFMWcIWlQlW21gJthmRhHhyH8IUB/fd3zJAvXHxNr7NvqA8M9oU5@vger.kernel.org, AJvYcCXHi0ix+UyMTUEqvbKzGswtiSMIALtIRDIol+xC4v7epc5YlobduebAUNqewjbQymGGX9o7swTXnm/WyA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOA7HoAuTLzcvP5oaLNvNuyW8Sc6gKxQFqa8wjyD1XWuM9qCJk
	BE2gnf52rOy7yuQuMNiCx1a4PQa1iNt1mKrKXufKj6ViLNloyCNqidHffA4MTmQnrzrkV6KMOc1
	xzqRPL/A3IP0HWgo6a7UebxwUGq8=
X-Google-Smtp-Source: AGHT+IHv+Clf+CXzjqX5DyVc7sIti2vAtNeryj4NmNK9lHofxSOPkE/OLkVPxMWDbiNC8PccJdCN2jloNFjeFePjtcU=
X-Received: by 2002:a05:6402:27d3:b0:5de:c9d0:673b with SMTP id
 4fb4d7f45d1cf-5e03600514bmr5012067a12.1.1739672510048; Sat, 15 Feb 2025
 18:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215164412.2040338-1-eleanor15x@gmail.com>
In-Reply-To: <20250215164412.2040338-1-eleanor15x@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 16 Feb 2025 10:21:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6G47+vitTq1ua1Mse3kyABAoX0FWQRNYkpt2HzGb4E-g@mail.gmail.com>
X-Gm-Features: AWEUYZlrH4zag26LnBQs_GejJWjGU1nYIl_mCem3RB06CTfTw7Cw4lFJKwa6J0E
Message-ID: <CAAhV-H6G47+vitTq1ua1Mse3kyABAoX0FWQRNYkpt2HzGb4E-g@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Use str_enabled_disabled() helper
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	jserv@ccns.ncku.edu.tw, visitorckw@gmail.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 12:44=E2=80=AFAM Yu-Chun Lin <eleanor15x@gmail.com>=
 wrote:
>
> As kernel test robot reported, the following warning occurs:
>
> cocci warnings: (new ones prefixed by >>)
> >> drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:582:6-8: opportun=
ity for str_enabled_disabled(on)
>
> Replace ternary (condition ? "enabled" : "disabled") with
> str_enabled_disabled() from string_choices.h to improve readability,
> maintain uniform string usage, and reduce binary size through linker
> deduplication.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502111616.xnebdSv1-lkp@i=
ntel.com/
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> index 96bcda0856ec..3efee70f46b3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/ethtool.h>
>  #include <linux/io.h>
> +#include <linux/string_choices.h>
>  #include "stmmac.h"
>  #include "stmmac_pcs.h"
>  #include "stmmac_ptp.h"
> @@ -633,7 +634,7 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
>                 }
>
>                 netdev_dbg(priv->dev, "Auxiliary Snapshot %s.\n",
> -                          on ? "enabled" : "disabled");
> +                          str_enabled_disabled(on));
>                 writel(tcr_val, ptpaddr + PTP_TCR);
>
>                 /* wait for auxts fifo clear to finish */
> --
> 2.43.0
>
>

