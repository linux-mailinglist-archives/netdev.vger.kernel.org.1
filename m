Return-Path: <netdev+bounces-93586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9583E8BC5AD
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 04:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9CD1B2096C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEA3D962;
	Mon,  6 May 2024 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGOIxuFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7FEAD2
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714961546; cv=none; b=pVWkP9ul898jzME22OdklCIhcbSgVakQvohGDPMKnEpPKFW4WHnzFQmFP0ALUpCoaU8g4UrFsboJzpMNHKUpZgaYlJDcALH4kqoVVwN29NIzDi+GFIvk2yDXMb/XUCmh+XGFjUMr+PsrIYiUsYPnyWOe9gZzX4+y8Y7AgJqgP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714961546; c=relaxed/simple;
	bh=7PTNVKHA9b+mb2usCmB0BpCyl0VjN2RzAfXwDdo0igA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3ZaG1+/Y/lUojnNlNJLoTYeFw6Lm9JW1vfG/5S3UTk52Uvn2otjLswtGsdVK4k51bP5bv97eXaLduQeUpNjhw3JK44/dGUSztt3Dk/+BtHt1g0zf3mnndDFRSI6cb8O3kGvnOFDEXtAoWwzBPAvJ9CYX6ggHXdP5o8DX9iA94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGOIxuFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79692C4DDE3
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 02:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714961545;
	bh=7PTNVKHA9b+mb2usCmB0BpCyl0VjN2RzAfXwDdo0igA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AGOIxuFSnlAj/Nt3pV+Bddhnx76Lkw5GOBDLtSbCEoLCrEiW2mxyfiwLqd5n/M+qA
	 2BUXGVEmAfcA0ODS7BY3mvI/S7ZA0Rb0Sogp0gsRrNpBVpHhp9hvp558ZbzwTIPGUm
	 8Xrr+6DLD//w6lPLwb0OO1u6N0prBx/R2TkdaKdWkfIdzMJPTYMcnrX0yj9DuLk++7
	 amJlWg5VL1PrBhVm52X3lVYTTdWQYr34utHXvrXVYIw+gAtAfQiyNQXD5VfRZj4dwd
	 9ytV/C41uDi00qnlGdXmULjX+9gO2hIU+MEXndfe2QCpAr/leS3tRvfXOt4/oUA6If
	 G/9fXqi/6F3yw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f17ac14daso1576192e87.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 19:12:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5OJCmdkMSEohrbwQkU5bsmFzWxvq1UunkeXQ6jdtMuuONJWei2OvcYj34uPJ+OWhiCh+wCImSBAL3FoMYMuz/LxZ5Fzmp
X-Gm-Message-State: AOJu0YzPa797QB6bx9g07LM4ndcE5045XFNSL0bZs6+iZa595+9Y+2ZI
	nKAku9sDLXlM8HZyTEjrGywtWWszh67L7iFo959HLuMJnN2Kp+x3GqmUxCaX7A7hrbxkWBVlTvx
	zmXZ19DN2RivkdHLCC7pyGc0UDn0=
X-Google-Smtp-Source: AGHT+IHUZDaf9bVxxudHC6E2fcDxm6z+akqtgtC0sj4m3y9y4TWxAQDYanNLhhttBwaLpe+6nvMM3ObT9UxydlwNSzQ=
X-Received: by 2002:a19:c505:0:b0:51d:44a3:6cc9 with SMTP id
 w5-20020a19c505000000b0051d44a36cc9mr5524327lfe.58.1714961543833; Sun, 05 May
 2024 19:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714046812.git.siyanteng@loongson.cn> <30ba385282572a2a5803b762decde061f81b8cc0.1714046812.git.siyanteng@loongson.cn>
In-Reply-To: <30ba385282572a2a5803b762decde061f81b8cc0.1714046812.git.siyanteng@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 6 May 2024 10:12:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ziP-7p=tyKXB-wG9=KgbHjXkfuF=nfdvbSLZoe9aTTQ@mail.gmail.com>
Message-ID: <CAAhV-H5ziP-7p=tyKXB-wG9=KgbHjXkfuF=nfdvbSLZoe9aTTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 15/15] net: stmmac: dwmac-loongson: Add
 loongson module author
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yanteng,

On Thu, Apr 25, 2024 at 9:11=E2=80=AFPM Yanteng Si <siyanteng@loongson.cn> =
wrote:
>
> Add Yanteng Si as MODULE_AUTHOR of  Loongson DWMAC PCI driver.
>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index dea02de030e6..f0eebed751f3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -638,4 +638,5 @@ module_pci_driver(loongson_dwmac_driver);
>
>  MODULE_DESCRIPTION("Loongson DWMAC PCI driver");
>  MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
> +MODULE_AUTHOR("Yanteng Si <siyanteng@loongson.cn>");
>  MODULE_LICENSE("GPL v2");
The patch splitting is toooo strange for this line. Since Qing Zhang
is the major author of GMAC, and you are the major author of GNET, I
think this line can be in Patch-13.

Huacai

> --
> 2.31.4
>

