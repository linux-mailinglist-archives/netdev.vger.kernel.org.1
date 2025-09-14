Return-Path: <netdev+bounces-222875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AFBB56BF9
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADEB24E0F5F
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CED2DA767;
	Sun, 14 Sep 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEhYgwgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E631E7C11;
	Sun, 14 Sep 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880198; cv=none; b=C65BB1p7Wga7PKYKiAIpTQ1Efo8xOeWwwVm7LEebEYPagu1T/1H62M8u3dkqqc2bJNG3maeD0xCFYmpkCX/EmbxrqjaZAhpzPR4RdTVmRVVVINTz7Dh4fvPTjSkTDJC1a5dAFK07FppHz/aSZmr6Ey0iorXQhUUWxWJVPv+qV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880198; c=relaxed/simple;
	bh=Up5mNGbVdutmUKRPqcvr/modVA2MQ1GkNefzzaxOAN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUwRZ6zNxXSurHd8bjvauDTgNcoPDV4BwTMnwWNiZIyXsG8VrTNdCl8wJt4+y1y0ChgfEFJigR8fApk5OIGfx9Jl3Wn9aHARrU2H2PnIhaUF+N2DIeLNDba0x1nTCNYmAsZfT2SoDUi9XWYMV7aM1x00zo5EaMoWu/uGP0jtl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEhYgwgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE446C4CEF0;
	Sun, 14 Sep 2025 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757880198;
	bh=Up5mNGbVdutmUKRPqcvr/modVA2MQ1GkNefzzaxOAN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WEhYgwgIRp0o8muOoLGd1q3wv2NbLq0sKGmG9jqdVdzVEnTncs29oHjF4CwmBIB3W
	 hw9JzATBFyfscZJFR0mBOw6BQVCZui9gmkcTaMZ6iXprPrxHfGqGuh4hYeUAoGKuuq
	 vyeTUtilLX9vD7QN2hYipEw5kND2xHKtrQeLhAzrAJgdP/oBTG2IgqFp0LijkVtRdV
	 HR5V+XMUR9hRIWGrCJisFrX8hjPx6rjZbyyiKJdGVSNdrEAmJIbJzicJedUFbyZbAA
	 nmVDm0Abc07QZ6ifSW330YQF081QJNoPQ9ZGY0eRa0/oeacBlIXPYIZityHGeIkmAH
	 DQi2QHHoZd8Jw==
Date: Sun, 14 Sep 2025 13:03:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] dpll: fix clock quality level reporting
Message-ID: <20250914130317.09369dd0@kernel.org>
In-Reply-To: <11fbd6f4-0cab-48cb-83e8-f62adc0ed493@redhat.com>
References: <20250912093331.862333-1-ivecera@redhat.com>
	<6c98a19e-473a-4935-a3aa-51c53618b2a9@linux.dev>
	<11fbd6f4-0cab-48cb-83e8-f62adc0ed493@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Sep 2025 13:09:03 +0200 Ivan Vecera wrote:
> >> +=C2=A0=C2=A0=C2=A0 DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX +=
 1) =3D { 0 };
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dpll_device_ops *ops =3D d=
pll_device_ops(dpll);
> >> -=C2=A0=C2=A0=C2=A0 DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX) =
=3D { 0 }; =20
> >=20
> > I believe __DPLL_CLOCK_QUALITY_LEVEL_MAX should be used in both places =
=20
>=20
> I don't think so. I consider __DPLL_CLOCK_QUALITY_LEVEL_MAX to be an
> auxiliary value that should not be used directly.
>=20
> But it would be possible to rename it to DPLL_CLOCK_QUALITY_LEVEL_COUNT
> and use this.
>=20
> Thoughts?

I think we should leave it as is. The naming convention is a bit weird
but it's what has been done for Netlink historically

