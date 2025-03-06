Return-Path: <netdev+bounces-172598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A32A5578E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32F91765D7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA608276052;
	Thu,  6 Mar 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="eojZz75y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5139B270EB8
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293554; cv=none; b=nn2rDcdy6v9B1/25lFm6//q6JFMcJqOWGFr2lK2tydD+Oq9rRoCyGvPvgh/R3XlGiXQExWF3tdz6q1zHH77Y25Q4jw+GfwSM3C5V9+/e1Za2FZJRuXOMWPhZCvpyaPXEkmGvijxtyR5XK1YA343sAgUns4h1gVdFHlME0cqtLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293554; c=relaxed/simple;
	bh=kXlwnVm/MmDRRUROUu6959pIgE0xYihWzk7uz8o+OKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwsoM9wFjw9pYwMLguja/vLWmJpOK9+psxgOUu1H64ogdvFsbz+fFG/h/LPaYs/Twy36FxdFPxmuUo31vOoKGaISf90nvnSR3zNYo2wTeFy/3EnlDoKbiCZQo7VeDnywa/oDpVEGyYBYOERZ17+7f4MEBkExJiYXrqFgwQhc4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=eojZz75y; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1741293552;
 bh=+Q3pBznN8M0b0cdvrfOAVu+/YpKDnQ8zfRnmStTM8EY=;
 b=eojZz75yBe6hvYVwFNIRKF2F9RHHdkZdgbpWs325h0MRIsdMJRQ9IAreHpvryLN/HlipjZtWa
 fEtyR140//fSgQBBdB5lnqN6XeWoIm85H5bktpcepZ9Wp325GodstsvVyVzIW5XNlOeg82k+gi+
 SS7Towx8Rslou0WUKgWv7tov+NVlUDrWw1QP282YMDM8Dry4pRY4nr4Fw8yiAtLFj8bAreQetMv
 uMJCeh4r6PaFfxO99/bFn7giIz6xbc5yc8Lzs2yNZknQqjYlKpvbNXbiGMKtWoGJXizrlPeMCwq
 IJHYpsp83g4eggPTHoYYl6syJSAc1QWGCz0UinMDeJDw==
X-Forward-Email-ID: 67ca07e7deafcb1458af9232
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] Use DELAY_ENABLE macro for RK3328, RK3566/RK3568 and RK3588
Date: Thu,  6 Mar 2025 20:38:51 +0000
Message-ID: <20250306203858.1677595-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Almost all Rockchip GMAC variants use the DELAY_ENABLE macro to help
enable or disable use of MAC rx/tx delay. However, RK3328, RK3566/RK3568
and RK3588 GMAC driver does not.

Use of the DELAY_ENABLE macro help ensure the MAC rx/tx delay is
disabled, instead of being enabled and using a zero delay, when
RGMII_ID/RXID/TXID is used.

RK3328 driver was merged around the same time as when DELAY_ENABLE was
introduced so it is understandable why it was missed. Both RK3566/RK3568
and RK3588 support were introduced much later yet they also missed using
the DELAY_ENABLE macro (so did vendor kernel at that time).

This series fixes all these cases to unify how GMAC delay feature is
enabled or disabled across the different GMAC variants.

Jonas Karlman (3):
  net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3328
  net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3566/RK3568
  net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3588

 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.48.1


