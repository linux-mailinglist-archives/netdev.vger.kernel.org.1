Return-Path: <netdev+bounces-233245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA7BC0F2D3
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0CF56146A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB52312816;
	Mon, 27 Oct 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSjIdFqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7183128BE
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580469; cv=none; b=fgtKYwmPBYWgXUvNldt1G7UnhLMvsKFo2C97NgfTAhXYHG9KiwD3hS2jvC5n8i/8Gf4Mazb8htLUwlodVSQkpm6slzMgCcOmhB/lKpA9p9/MPPFmTEb5aw4bw5uhr7Z+IaRnKjT5ESXDdpw22kCkxDBC0dNs7kcahiUpdr2OGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580469; c=relaxed/simple;
	bh=VrcGekrA0V4MeKOK1C3SdiVffncJbm6tZX8UDVo5Re8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtKtds5P3hU4O56V+DPb6tMal99AtvbaIywED43QxQzuUJPcfg7EYtCN5MN3bZgiA2WTKMZGDNSfEh7q5uAUs1OY7+uIwp2OWlU6JkcOjYVM4uDEgrRRwLRVpCkWt82quvqfQoEm7RxG3S8NtDYc2gcGpCbvl26hLo+0GVn8/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSjIdFqO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290d48e9f1fso370865ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761580467; x=1762185267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOV2usxAVtrzpjNrsCDY6+oTbSzm7HQ0OagyrYKBhwU=;
        b=KSjIdFqOe/MCbCS1S8E1ShV7EwZ6B9Xct+/1VqAOiFwfYRVGFGGJU5LpJqlNmeopxs
         Xt2bDvTfovAyE1q2eZmGQCW2f50j1dHma/hTKMCo/NkoAjTDhvzZwmRXpyj/cdkh+bpI
         arT4Ke9r85cPXF1Oyt0YE6iILlV4BlCdBkV4FYOc2HI7vuoUTx81r9Iv46JHW7GUoSTL
         3m69QTJmyP8ft23JyVSDU13hY+Y8FjKVc1DCja7FKIiXSflegGMWb5KXEK0QfEbQfEEA
         hd15ZOHqan/iWXsC6f3LzdDLLx1OvXhJU4+NFVyA5kNFzsnaNBSaRMkUpYh6YmG0xfHg
         x3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580467; x=1762185267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOV2usxAVtrzpjNrsCDY6+oTbSzm7HQ0OagyrYKBhwU=;
        b=e6RtE7y7ckJfIshWBuiNvoSmD40glSwiliToiQdjObctlK2jW8MQvh4gpUnPSrx3Zs
         I/gMkGrRYF/rxhqjjVCPredL0Yhk2TiiSTYrP/7IaLamFd8O9VrZJAa9K4N8HI2t0Lre
         RF4/YLbPZ2/wlKw3MUkmfhJirflnqyartS1wqm4dBFT/ufJa13UbRqOZCbkTrVGKiyzU
         FwI3Hv56UsnBJFjBoL2VVokmi7K4Vd17VjeRmmHT5s5bvUOclXi5TLjXGsI+sJQQf8iv
         qDjMfX1QtNj6gd+kxx6CAVEuHahuEiKq1srGsd3MVZKNjSS6bn7yR37OpcQN8Xehwu2n
         CiLg==
X-Forwarded-Encrypted: i=1; AJvYcCUc08Y0Vy/WRi4KARqNH7Ay/uRqabx4vrqjlSZYGA1X3NbW2+hVaUXEXlNS5N7n4swKVDIuDuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMo+rpuHksxfUs+9YOsICwusOUC0Aj3aQ1GHt7qQtfkNzF6+w
	0K48lIc/3Auo0dIEjRrjB6HyLecA07KjS3UC/Yn7WUE1qGyELOiRD0l+oOnRkG2knQmEwqpz5OE
	T1y5o67TnmLaKrxeg0WG9VBBuWSmypoKEKfw8mtKd
X-Gm-Gg: ASbGncvsuafBvNCT2F/RY0MgDCtwDGK+yV7TlsD/cCy8zkmfsl14JP7zCFeT0guwLTz
	1ZYK0x7VtqdDKpIU64ZcfUfmR7syEGDuLoeqCqrGCaxqWdG/9qHgl/v5rV8/e7fQsDPRQ3AkGMa
	rbZ2eITnKLUI8ksjvBHdXLFYK8kiGO7uzPP4H91yL5npb8spHoOkPe+hF/CrrGhasTXNAxI3Zgy
	vqvDmF+Yrk2a2oCWk2XnAR6H7fQhkpB+KKj5j6J1lLxytJjd8NyBsE39MZR7SAQdfgg
X-Google-Smtp-Source: AGHT+IGd2VC+1ri7Tm8Icu43HfhHP31Eha9krNlCyWKJpXSqm52Nv3U4r4IDiw+4iGHBWYRgukstDdR1FrBi6TFHiUE=
X-Received: by 2002:a17:902:c40c:b0:25b:d970:fe45 with SMTP id
 d9443c01a7336-294ca876b46mr835215ad.1.1761580466893; Mon, 27 Oct 2025
 08:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org>
In-Reply-To: <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 27 Oct 2025 08:53:49 -0700
X-Gm-Features: AWmQ_bkZ-boZ1PO-DZE1ghKe_XcmKdU5EzkIpPpXzyaf8mX9qkr6Gzs7ALPdxQ0
Message-ID: <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
To: Nathan Chancellor <nathan@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Kees Cook <kees@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Russell King <linux@armlinux.org.uk>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Michal Kubiak <michal.kubiak@intel.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Sat, Oct 25, 2025 at 1:53=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Prior to clang 22.0.0 [1], ARM did not have an architecture specific
> kCFI bundle lowering in the backend, which may cause issues. Select
> CONFIG_ARCH_USES_CFI_GENERIC_LLVM_PASS to enable use of __nocfi_generic.
>
> Link: https://github.com/llvm/llvm-project/commit/d130f402642fba3d065aacb=
506cb061c899558de [1]
> Link: https://github.com/ClangBuiltLinux/linux/issues/2124
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/arm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2e3f93b690f4..4fb985b76e97 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -44,6 +44,8 @@ config ARM
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_CMPXCHG_LOCKREF
>         select ARCH_USE_MEMTEST
> +       # https://github.com/llvm/llvm-project/commit/d130f402642fba3d065=
aacb506cb061c899558de
> +       select ARCH_USES_CFI_GENERIC_LLVM_PASS if CLANG_VERSION < 220000

Instead of working around issues with the generic pass, would it make
more sense to just disable arm32 CFI with older Clang versions
entirely? Linus, any thoughts?

Sami

