Return-Path: <netdev+bounces-154022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E889FAD79
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 12:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F27166AAB
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994CA1990DB;
	Mon, 23 Dec 2024 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d2zfIiW8"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82E194AF9;
	Mon, 23 Dec 2024 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952022; cv=none; b=KPI5CbZHqDcL0+f1mHxml+Vgr4ByiQMwemj0UQev7mHxmdkTn8D0RoyiROgtn3sjNPGRQC3V+iSOfbi0BWJ6o9tqQ58W08N5brWidFRDs8loySTGyu5xhfVZ4Wj5t20DQCbGnbrrJmTJQAx8PQpN+CCOpz0ba26K4hHr30rQ8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952022; c=relaxed/simple;
	bh=uAlo+ULnWIqf2cgYUKQAKueI8CJurgRHKq0A+C/3s9Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EoRZcV09bZ2sV5njYAmrxYNohyrA9pJYSQ9Zryk5gF/pnL7d6V2lxQdfo/oG11XUBbBSlyJ0OQhOeCKkv8dEocaTCb/KK1vkNERaYFPfHxZN5pjwVGavGsMboohwj3U2dsMXvsj7Q9JxcdgfgJnTZn8Db6ZKAvTvHTdCEAMvWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d2zfIiW8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734952013;
	bh=uAlo+ULnWIqf2cgYUKQAKueI8CJurgRHKq0A+C/3s9Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d2zfIiW8g5ELhktY/4rR2tCQf6VaZRSJfHPzLl5tE5D3Frym7FD3B29n7ZITHh7A+
	 lTcXaAlCHlYtD2aQOCtBMln7AGGyYvDhKBzK9ziApJTulk043ash0OyhooayOU0wUD
	 QzZEPMdMO7z9VywpZA6CEMiwvyYZI+HnHbXiXX9jp0eyBRfv/UoEzfi5OCnymIZCf7
	 pYJM8gDAWJMJVdw7lSWauAv1yTjhVHtZ7eRDNrHLvVBHQTwJlyTVDET4qrupKU2pPl
	 lLyig2oxxfyNccj+qfOvsvPcsPjDnujK7SKVWFHtgMzauLgX1VCqxFUZcuIPnuTKS5
	 SyL7kwWKJXYog==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 07B7917E362C;
	Mon, 23 Dec 2024 12:06:51 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Andrew Halaney <ahalaney@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
References: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
Subject: Re: (subset) [PATCH v2 0/2] net: stmmac: dwmac-mediatek: Fix
 inverted logic for mediatek,mac-wol
Message-Id: <173495201194.34262.3657458124783082964.b4-ty@collabora.com>
Date: Mon, 23 Dec 2024 12:06:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Sat, 09 Nov 2024 10:16:31 -0500, Nícolas F. R. A. Prado wrote:
> This series fixes the inverted handling of the mediatek,mac-wol DT
> property. This was done with backwards compatibility in v1, but based on
> the feedback received, all boards should be using MAC WOL, so many of
> them were incorrectly described and didn't have working WOL tested
> anyway. So for v2, the approach is simpler: just fix the driver handling
> and update the DTs to enable MAC WOL everywhere.
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[2/2] arm64: dts: mediatek: Set mediatek,mac-wol on DWMAC node for all boards
      commit: f8a032834abceed9db3f20a5eb56064b21c84613

Cheers,
Angelo



