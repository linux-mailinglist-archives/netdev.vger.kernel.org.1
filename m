Return-Path: <netdev+bounces-225070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5142BB8E04C
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B24E1898900
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B933261B72;
	Sun, 21 Sep 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlYZlSPR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0350258EF0;
	Sun, 21 Sep 2025 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473619; cv=none; b=fveOKTAVzNm7oNAGj41ML9L2Eub2ewHtZ6VC2dGVfGm2NrSKg6O6LBij5cbj5mmGnjDS2j+3L8O5ZgbKXW7hDGxGfsOzG0M6LMBdacfFTnmARvINabkchi6RceiM2G4M+5JDTiKB1lulOQnFWS51EATGqyvnXATIMMCpqOVtvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473619; c=relaxed/simple;
	bh=mhSkOie36LNjLhZ1e/3xKgbbnV6rCK0CBBCBJjtXEl4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Uh+RkfVFetXfSl9I41dyKd6aXfASXMLiCT4jwz73XT/WpAe7Sp5cAVIAPl+14JQop1nNaZURbVrdOda87cwQUDus7FnBdPLmj+Zp+PGTuQpHCV7HSequuV2bkDdTFBQAJnqTUK+MvjGN4/ZGePZPCI4UApGXZlhJJmOxuVChDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlYZlSPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB25C4CEE7;
	Sun, 21 Sep 2025 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473619;
	bh=mhSkOie36LNjLhZ1e/3xKgbbnV6rCK0CBBCBJjtXEl4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nlYZlSPRA3rDVi0b9Jl1NP7yoCrtiWufi9T0NPvDbUYQIEeDzKC76OOanlNKGwm9G
	 rj4pGCUXYzQePp/DqDQCb8P3AB1Q/79U+4m7vHDvSHhBARqOG80HpeEN0uJAfpDLaf
	 7VDIvTnmgLmlhJzBznGrv/rhZgwQkfh/rw3VhKezofbZXNbB2kteoLUs+dvmRisrjC
	 URMKmVv6OyR1/RPynpnavFzyxK5p3F51mhwvMT9PMYIsbXH7UTHAOnTeKIUVVIgRMN
	 7UiKXcKf3W+FCRRuJZ3FvVyAOc+tPFcFgcxMT4c2v9K3GFFOi1Ivm4vRt8Ldf7UaR3
	 japFcjxedCUhg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-8-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-8-laura.nao@collabora.com>
Subject: Re: [PATCH v6 07/27] clk: mediatek: clk-gate: Add ops for gates with HW voter
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:37 -0700
Message-ID: <175847361789.4354.2149769507345484400@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:27)
> MT8196 use a HW voter for gate enable/disable control. Voting is
> performed using set/clr regs, with a status bit used to verify the vote
> state. Add new set of gate clock operations with support for voting via
> set/clr regs.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

