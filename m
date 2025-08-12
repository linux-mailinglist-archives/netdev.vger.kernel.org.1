Return-Path: <netdev+bounces-213104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9718AB23AC2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F933B9A91
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292CB26D4C9;
	Tue, 12 Aug 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoqmnRnW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583122B8D9
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034274; cv=none; b=ujd2Lbj/pNnwLMIUzXzJWsnVj9wYUgj7+Z8Yxw/6yRpLCeKxkxjAmv5Z9VuaGFV2hNIoNc6H5/QUXjWNvRinYJ5L6LKyxW4r/C29nlKmvDtpLRTd6eZWvjmlai1tNBEJ6A6rlRZHPanumMbB9D+FzhpqtcXwSQuBMABuXVMq27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034274; c=relaxed/simple;
	bh=gz1lj73eYuFjtyfUUaAKludpU02UXEkr5dp4LT4ZFtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pz2+p3tC9eWxLZlCxfvuET0VOzwu4dMoQY0o89danGqPbyTebvH1lkgTLhnR5wYyX+KbDck4UfTYqFYjXsjxh0jmNzCuWxPoaJicoQQj8C6QtfVaieiwqCWYFtK09cia2f7zR+F2oPhWyGyDA85eR7LNBMpKQ+520K5adzxM+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoqmnRnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258FAC4CEF0;
	Tue, 12 Aug 2025 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755034273;
	bh=gz1lj73eYuFjtyfUUaAKludpU02UXEkr5dp4LT4ZFtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MoqmnRnW/ZfjdfYcj3SyXkFegmO20kk9vePk3WTpKO8G1iguiitTBZZBn5+fA716V
	 xxYYxyoTaCnIiqbWVUbZtwGIeP8ycORnp4eRjx7FC3QRZCXhblgb0p76SZJ3Wtn1kr
	 RroWgCf2gKEjRoLOQprPZXzfasISTxTiZxWeZUo+J0VPkd7q9/ag3cZJLgee5SlUnr
	 nWq+EHHpFr7iYZhQ/ADSokJKlbMi4b6yxJvEyJbw5QmnJPmBU698h5N5AXA59tpauC
	 yJIfooJd5rsWMtc7M8eLgtRW7Y0+aIVGCv9CnYfod36EZ80x8qvpwyVSDXFkBInkDd
	 YhEpS68rPIX7w==
Date: Tue, 12 Aug 2025 14:31:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 michael@fossekall.de, daniel@makrotopia.org, netdev@vger.kernel.org,
 jan@3e8.eu
Subject: Re: [PATCH v3] net: phy: realtek: convert RTL8226-CG to c45 only
Message-ID: <20250812143112.2d912cc4@kernel.org>
In-Reply-To: <20250804105037.2609906-1-markus.stockhausen@gmx.de>
References: <20250804105037.2609906-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Aug 2025 06:50:37 -0400 Markus Stockhausen wrote:
> Short: Convert the RTL8226-CG to c45 so it can be used in its
> Realtek based ecosystems.

Sorry for the delay, looks like nobody who participated in v2
discussion is willing to venture a review tag.. :(

> Mainline already gained support with the rtl9300 mdio driver
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
> /drivers/net/mdio/mdio-realtek-rtl9300.c?h=v6.16

Could you replace this reference with 

 Mainline already gained support for the rtl9300 mdio driver
 in commit 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver").

Are you okay with this change going to the -next branch?
If yes please use [PATCH net-next] as subject prefix.
Otherwise please use [PATCH net] and let's add:

Fixes: 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver")

I'm slightly worried there may be regressions lurking here,
as IIUC the problem is with a combination of SoC+PHY, and
the change is purely on the PHY side, affecting all users.
-- 
pw-bot: cr

