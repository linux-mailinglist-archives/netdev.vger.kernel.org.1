Return-Path: <netdev+bounces-51817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB57FC544
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF9B1C20F1A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F944F882;
	Tue, 28 Nov 2023 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI+3OrOW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7D46BAE;
	Tue, 28 Nov 2023 20:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCE8C433C7;
	Tue, 28 Nov 2023 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701203074;
	bh=AxZmt6ng+cjEW/8ifHbtAk94LDFE5Mh7uTAVhNosjrA=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=AI+3OrOWNKfQ4WaArgVY2zE3iQgt2mmwbWLoqzyj6bk3hFwZwi7oVmN5iR8Q6vqgV
	 AGplDW3Kj9cNGKv//2OTPuVXRAhvDF3RIorjKHVpGbEv4QFzY02cPHj3u7avWd9kM8
	 h9MQFqIPSMBisM4Dwn7Bx1XEYY9b+QSUCLXKpXRqHUwXCZEY+isJn4mii2/tyJx3uy
	 6bwXIx0HA7o3493ViblidvG1NQb3071cXrTGY4UaAIxCpGn5QRblfZB1PiRU0Zu/KB
	 fq1brk+hB0ov3M0wWnXJ6nwLVSpGCJPiIriInlLL12KXG1s9Rd/H50ZuztbjxTNoHW
	 JEbrHvo5/OA0Q==
Message-ID: <21095bde37a8090686dfb372e5fffa58.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cb983f0d30f019120cf49f24efb655cf794084d3.1700498124.git.daniel@makrotopia.org>
References: <b277c5f084ff35849efb8250510b2536053d1316.1700498124.git.daniel@makrotopia.org> <cb983f0d30f019120cf49f24efb655cf794084d3.1700498124.git.daniel@makrotopia.org>
Subject: Re: [PATCH v2 3/4] clk: mediatek: Add pcw_chg_shift control
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
	David S.Miller <davem@davemloft.net>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Eric Dumazet <edumazet@google.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Garmin.Chang <Garmin.Chang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	James Liao <jamesjj.liao@mediatek.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m@web.codeaurora.org,
	ediatek@lists.infradead.org, netdev@vger.kernel.org
Date: Tue, 28 Nov 2023 12:24:31 -0800
User-Agent: alot/0.10

Quoting Daniel Golle (2023-11-20 09:19:05)
> Introduce pcw_chg_shfit control to optionally use that instead of the
> hardcoded PCW_CHG_MASK macro.
> This will needed for clocks on the MT7988 SoC.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Is Sam Shih the author? This has the wrong From: line then.

> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

