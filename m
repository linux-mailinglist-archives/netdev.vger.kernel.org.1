Return-Path: <netdev+bounces-160466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24AA19D64
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 04:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15663A6533
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 03:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14C126C0D;
	Thu, 23 Jan 2025 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlL4aVWT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32668528E;
	Thu, 23 Jan 2025 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603896; cv=none; b=ENEWSPqjEtjCaK3bxIN3PH9mSNm8c6YiHbgZfYVkXH6frA83sKb2avHq1lRHHkqQH0D+Ibgd1qd4iiuoIWOXLQG9GuWr9EKqQcAzCgyY0HAjI3axlniHY36/1ALUFuU05ewU6dCt8DcCJhGmD8gTs0+0Mlbj/QPHBWlIlM0jXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603896; c=relaxed/simple;
	bh=PpQcKerF0Oe+hQQJLUk0XoGagTqz8UzMMn4d2mozXPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoIVsjd1empxtZERFd5X7rNpNje/DoTsIYQNMuCmD6JnSp3YIuRxe35mFfHZCNW6ZruGbPRxsf28MdmSEH3P6TXEwGjC/r1apyWHV9jN24Ka5wQhWlEC4hMkFsAEuhL8ZYJM2xBin/F8C6YAlvqv4JNbYNqSgjmSBkF6NyQlSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlL4aVWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D78AC4CED2;
	Thu, 23 Jan 2025 03:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737603896;
	bh=PpQcKerF0Oe+hQQJLUk0XoGagTqz8UzMMn4d2mozXPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SlL4aVWTc3gRdp+DzgvygtOcetR5kZEsIyMOcO3PRmQZW2PvDnhO6MGm/JLCm9Ur9
	 OVduZiwJnn43HBf9zkFpkqjg3rUqCgU4P0GpB+W6qkqa3uL8Wyo1gIFe1heyirZzie
	 UQ/FXk5IXYGDJLxc+eO47fLjcsDhrgCsTbH8TJRU004DrC+aS/pTqup8HeOAMYTa5y
	 jxAxOkwhrybdBoFd23QMaMHCJQcWXsydRsxlYTJIogxsg/FWytGm+ByYkCx0fBsv2E
	 DoougQIM9X7/bq8EQWWmuCE1NlAA4sVkK9sFghlyflA/aXwxCHmnyNyTTS7nAEhQBY
	 kcg2LBGEi2Jug==
Date: Wed, 22 Jan 2025 19:44:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 si.yanteng@linux.dev, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
Message-ID: <20250122194455.764124ad@kernel.org>
In-Reply-To: <CAAhV-H6HDOvjr5sA3n+dUMTLm22_p9fAFaTgEUcrufR3XHrj9Q@mail.gmail.com>
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
	<CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
	<20250121101107.349a565b@kernel.org>
	<CAAhV-H6HDOvjr5sA3n+dUMTLm22_p9fAFaTgEUcrufR3XHrj9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2025 12:09:28 +0800 Huacai Chen wrote:
> Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset funct=
ion
>=20
> On Wed, Jan 22, 2025 at 2:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 21 Jan 2025 17:29:37 +0800 Huacai Chen wrote: =20
> > > Hi, Qunqin,
> > >
> > > The patch itself looks good to me, but something can be improved.
> > > 1. The title can be "net: stmmac: dwmac-loongson: Add fix_soc_reset()=
 callback"
> > > 2. You lack a "." at the end of the commit message.
> > > 3. Add a "Cc: stable@vger.kernel.org" because it is needed to backport
> > > to 6.12/6.13. =20
> >
> > Please don't top post. =20
> I know about inline replies, but in this case I agree with the code
> itself so I cannot reply after the code.

You're not trying hard enough. The message is Subject, body and code.
Reply in the place where the problem is or where the CC stable should
be added.

