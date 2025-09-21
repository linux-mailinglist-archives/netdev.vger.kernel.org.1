Return-Path: <netdev+bounces-225065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58DBB8E00C
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5AD1898617
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A61258CF7;
	Sun, 21 Sep 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKc6gR3K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAA257452;
	Sun, 21 Sep 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473595; cv=none; b=OFcirRpuo+PPp1HF2PCVMYUfvo4Wh//WBmPZp+KaQpwTSzdxMavRXXBNtWVenRitsYw1BVQSJLswoqnPLjwoNYCB5NRlJNDkh4+oKxrn8ecn/nRRusOU2gu+JTUCYMJFGZzdEcGkXHGHG1BRB41EFeehrez0lXImO/iipefWDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473595; c=relaxed/simple;
	bh=OmcqAy6h/ICDeDYAwPRkFiDSOLcTRi9vj0g9g+5IZ6s=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=gbyi1/5uUVuJBsDKqiXSCVB2XYFLJulRXO4paPya2VcIZO6pkzpQRVPUyA4DHGkR2uMCILjC6OxuccI4LrXsJgm/WKIkjqVP+ZMKKRWxR6LLsvpekieoL1nbkn3bmZ6QDhoMhs6XRPiw1kRcBbqS9vbkyrt3yynvkC+Ipguc+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKc6gR3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A102AC4CEE7;
	Sun, 21 Sep 2025 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473594;
	bh=OmcqAy6h/ICDeDYAwPRkFiDSOLcTRi9vj0g9g+5IZ6s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GKc6gR3KcSeCvEA+k+1FuykK6Icfz8SrdmL58SfGBXBWxCVlPrfgm2DmBoUmAhMF5
	 eGEcQLx4DJVGfPu0JNhCxAZMaqth7NjamyXpUDRdA+B+IvQSUb3nTGslgSwpWND4Jo
	 Ph+GAnap95cL2c6v26NUV37mii01ivbbay3LcavM8QVFPPwP1keXi6HMZMca8k+G1S
	 smDICQwe4cXSdIeJBsqpmmaF+tnyoxO9Esqa7sQkB7YlcKCKs4MftDc/B6L367MoBW
	 EqNkXmtfVyWuLQxczQoozKtXCJLsmYbzIlZGw8fk+uEhw6a4x1HpmJtg9Q5Qv+alNz
	 OJaiTaUHw6Ydg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-3-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-3-laura.nao@collabora.com>
Subject: Re: [PATCH v6 02/27] clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and FENC
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:13 -0700
Message-ID: <175847359329.4354.2697873457619753075@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:22)
> MT8196 uses a combination of set/clr registers to control the PLL
> enable state, along with a FENC bit to check the preparation status.
> Add new set of PLL clock operations with support for set/clr enable and
> FENC status logic.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

