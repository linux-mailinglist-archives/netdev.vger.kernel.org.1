Return-Path: <netdev+bounces-159880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C9A174CA
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 23:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0241887A9D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B651EE7BD;
	Mon, 20 Jan 2025 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEIFyTLS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22071B4237;
	Mon, 20 Jan 2025 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737413278; cv=none; b=fvPG75P8Ytsu59M5vSdu2W2vUMxH2K0c4hX6dl1x3s2TmHSKRfJbxvJp74g0ay0+c21gnQ/X7K35WtGqAh1+HQV7wR3uKzPjqXhuLvZl2iOQe2673uEUg45+b5E+X3KcmBfUs3S1pCo+7AzF46rRQSDYDTVgbJuJkfpkQ0PGX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737413278; c=relaxed/simple;
	bh=QyZRW0aHLnRL4baKegmUiwVOGVOdCibS0JRvsvWR6EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDeuJ1AiIKY7A8V+QxITx/JWenGQE1GseruOg1g9p1HI5dQfrerZBC3IVCl0QNsWpeVEQZsqZkiXSRHTQNfLamMIZ3NQszffRik4rYxg9T+zj1e2iB70M5NUF6TvQR/Tpg7BtjDMVyUeDQI5tZK3GziBMzg5C8g4DmrT0ao6whE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEIFyTLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A03C4CEDD;
	Mon, 20 Jan 2025 22:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737413277;
	bh=QyZRW0aHLnRL4baKegmUiwVOGVOdCibS0JRvsvWR6EE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tEIFyTLSbyyIciXePnaAAvJVcSmeq1aHf4oWl26CgPw17MoOMjNU7dDi6g5TNNxFh
	 qSP+jXom52oa4Hazce7vIH5GrorN1w4PP8n4G0A79X1YTO6FsYQCDkURQXTpQ+Ge8n
	 HTNcy6Ok7sib8lvgbeg43BntZEFaWxGtkC3Cn5KQxsgutavxQeGF/wOsW6/MVaW5I2
	 xt2RGlqDE99TPwNw47P6MtmT7goUV9zNK3sGuQFeq7RLDhgduvm1yyM8JhBWcFjHAc
	 YwXAQgXd7RzIvln36GvYi3EZ6nd6Bz13tYw9A5lPC/CTtPnvL45mgWikK/5x+ZDJKq
	 5u5GUMRFasvwg==
Date: Mon, 20 Jan 2025 14:47:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Milos Reljin <milos_reljin@outlook.com>
Cc: andrei.botila@oss.nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 milos.reljin@rt-rk.com
Subject: Re: [PATCH] net: phy: c45-tjaxx: add delay between MDIO write and
 read in soft_reset
Message-ID: <20250120144756.60f0879f@kernel.org>
In-Reply-To: <AM8P250MB0124A0783965B48A29EFAE6AE11A2@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
References: <AM8P250MB0124A0783965B48A29EFAE6AE11A2@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 14:55:39 +0000 Milos Reljin wrote:
> Add delay before first MDIO read following MDIO write in soft_reset
> function. Without this, soft_reset fails and PHY init cannot complete.

A bit more info about the problem would be good.

Does the problem happen every time for you, if not how often?

What PHY chip do you see this with exactly? The driver supports
at least two. If you can repro with a evaluation / development /
reference board of some sort please also mention which.
-- 
pw-bot: cr

