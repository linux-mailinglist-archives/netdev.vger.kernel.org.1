Return-Path: <netdev+bounces-225069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD23B8E03A
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EDB1898749
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBFE272E46;
	Sun, 21 Sep 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjG5m9OK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FE258CF7;
	Sun, 21 Sep 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473614; cv=none; b=sGdvsKPBN087dLkRTUhKi7EIXXRPMI62zdVYNZHhdKgQiYpcOhyznLTk8IWrJHAOgFCjFvvyoP5sBheVtWK+yGf7Udt/K3aNCvlH48TGttg4MStWLot/f6FvONa4HnmFEzYoWlGiNiSgv1JbmDKGpF7+shR5wQDxEyo68ccO7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473614; c=relaxed/simple;
	bh=PJ33OKXzP02F+Zwi+qtD66apY4JkrF1rf2QHlzvAMs0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=KHWBJBc3q668Hv8lr7XfS3lD5vZImFIXmGNtembgtBPPrAOzP+IBjqAL1/3/F+orDdCTK0NAfcTc7uqvp61mdOjv56J9L7NnHpx9PlcWztOw4PY4Ovm5porK+TfMcIshoeS2wZ52aPlptEbLWKBUyIXwgiV11/8CxeOeAOAnzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjG5m9OK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023A4C4CEE7;
	Sun, 21 Sep 2025 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473614;
	bh=PJ33OKXzP02F+Zwi+qtD66apY4JkrF1rf2QHlzvAMs0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jjG5m9OKipv0wXYbguYj+nPCt05D3kplw6rzavR7mHmJPKZmWUU8yRMjs/ET/fFRN
	 W74y0bo6ElE4RTJMyCaY9GDLmyT7KiJhmEORSWYkIHMk5w3nSISyNTlfBU89lhJhx3
	 3kFFUEmnizdyAGeK7koZ8Ro68wTcb6hF0MorLzIcYHz/inNJ31FnL/JFxxSTDxMINT
	 gP/gG98KMQMG7c0IofmKMHmymnNLUIRIak4q1KHu53wo9PzmmK1JrFFp1cAUwWesZS
	 HM7mrzbKA6xn4mGtFDiFmxDtYmeyosxbf9SjKhR8DmnTbSeiHwMhGE+Gdis5Kcj5Gk
	 2bXFZgg8GWLvA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-7-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-7-laura.nao@collabora.com>
Subject: Re: [PATCH v6 06/27] clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:32 -0700
Message-ID: <175847361261.4354.11188825521023748179@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:26)
> MT8196 uses a HW voter for gate enable/disable control, with
> set/clr/sta registers located in a separate regmap. Refactor
> mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer to
> it in struct mtk_clk_gate. This allows reuse of the static gate data
> (including HW voter register offsets) without adding extra function
> arguments, and removes redundant duplication in the runtime data struct.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

