Return-Path: <netdev+bounces-225068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B024AB8E02E
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21101898749
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C925D202;
	Sun, 21 Sep 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfe4nYY0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E1258CF7;
	Sun, 21 Sep 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473611; cv=none; b=CyekkeKqBVNuq0dDF0YG2vfX53HRXaEGhZvs/15BcL2Rs0xUGxMkVnBz9z8bSSZaGdZB0HRH0qxUkwutZM1yQoKjoyh3OXbBXdsWXHzvdsIfJdIxeAwPNG/wmeaXQRKER2XGhnhOAhikA3BpHF7HeK74ZrHg6QQhVlL2wXgzYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473611; c=relaxed/simple;
	bh=HoiCOQ20nTneneIaxwbn1XHFftteJQcuwFtemtIOqt0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=V2y/WYzYaflwh7Ryi8+Kmr6X6i5ZILN1xPpadFVcXhPK4Y3ezFlBO9/KSN5ySZG/XL+1Rvbitz11gtVVmOS7Sli0ua87RKHTZK82roL4jW6ymuPllrWF7jCm1QOsRkFTa9tB6iV8Ykhc3fAU0qDpES9WjfbU7v2iSJLmCZ8G5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfe4nYY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562E9C4CEE7;
	Sun, 21 Sep 2025 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473609;
	bh=HoiCOQ20nTneneIaxwbn1XHFftteJQcuwFtemtIOqt0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Jfe4nYY0pNIG5vQ0EIKKopwcXzYM1EgFqjnMpcUDDYMoO1eveSIJ3ECoTl7MKIHrv
	 WXDu4Lqe7bQav8VPJCUW13/IEV71pt/2LKHKhq0ly4ee5GJeXCGbiwebc1IMmrtaS9
	 ZEPNeHiOgA1U6APoahn5Xq/33OVuH3NioD+R6i4ra03d+MtEbzxY34mli4rTxA1Man
	 QZMQj0LAPwb5bYPaDhTJTv5F3bMk9KRA+RQ2XtVRShd4GQ3Qav48A2sqS1GhlxXrYE
	 /ZW/WQPSVONNl4H7EJXKKMdso2OE0H7gQ+KvgZMog7TZ0s5oXlBUdD5giJJYMUz7EQ
	 Aa548QbsqGY7A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-6-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-6-laura.nao@collabora.com>
Subject: Re: [PATCH v6 05/27] clk: mediatek: clk-mux: Add ops for mux gates with HW voter and FENC
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:28 -0700
Message-ID: <175847360800.4354.17347591921715136589@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:25)
> MT8196 use a HW voter for mux gate enable/disable control, along with a
> FENC status bit to check the status. Voting is performed using
> set/clr/upd registers, with a status bit used to verify the vote state.
> Add new set of mux gate clock operations with support for voting via
> set/clr/upd regs and FENC status logic.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

