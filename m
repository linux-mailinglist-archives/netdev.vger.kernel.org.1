Return-Path: <netdev+bounces-214698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609AB2AEBA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05B8680990
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B272343D62;
	Mon, 18 Aug 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgGYGdIC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0C342CB3;
	Mon, 18 Aug 2025 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536333; cv=none; b=rvcOL+J+UeQi9/2gcyVhEmC/GzB19R5R0U7gcU3J+IAyoULD75Pug2X59RwXuuFA3BAA4nuL0UrDsLpBCBuytuxDgtLWpEq+ydOr4JXncUmyU820tPrBWk6AcP+/CdrEjfU6mOi4TWxYTgSkeiuxgglRomhS6xs6Tnei2y5xdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536333; c=relaxed/simple;
	bh=yWyVHQOvQU2w7KIA7i1Pm6CZHe3bHTcgVkvCbGBK2YU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aY16cniHK3GA/UZ1Ehb+yzw/9TZUajwmR++8483toLcn0s2GY4KeZ1CapvYZiOhltLr+LSbz1jNxnLNnUwjZ0AQ91vcT8TWqO/dysjYDyq3UGKiJAJaIdlKhk7ER4MMRHZVyOZI6vLGnBWbASWQr3gXCxMSu6jaaSCWFVxzbwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgGYGdIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D507C4CEEB;
	Mon, 18 Aug 2025 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536333;
	bh=yWyVHQOvQU2w7KIA7i1Pm6CZHe3bHTcgVkvCbGBK2YU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KgGYGdICY051XEaNkiGNiiB0uMNI3jnjQFXGPGIhjSKAgWg2QafWPvnC2gRfaiUqj
	 /4LuzTbP+FRADhTPs6wu6yOjO+5sUy0c7sgCv8mzV5eK3bZOWhjld8EbukFphiU7v+
	 9sKFR4uK8Lad3lbsSBd1osRCpWS+l3sPjr1EjJM+qkLOwPuNJb+Gtvb10y3N8OvPNE
	 LikcA2B68SxDhej98j6E81GsI8s0E5ohDqcuvu3Xzge/Li49JSRz2IcMFP9/Cb55wW
	 bOKmWE+y/1eR2L5wDQaw1Meb/J2NVvb85YMy4+LVo8xP3y7G6SdLwL718AqBINe22b
	 m0wyQdaujP1iA==
Date: Mon, 18 Aug 2025 09:58:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: luoguangfei <15388634752@163.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macb: fix unregister_netdev call order in
 macb_remove()
Message-ID: <20250818095852.52b94214@kernel.org>
In-Reply-To: <20250817003925.3362-1-15388634752@163.com>
References: <20250817003925.3362-1-15388634752@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 08:39:25 +0800 luoguangfei wrote:
> The warning happens because the PHY is being exited while the netdev
> is still registered. The correct order is to unregister the netdev
> before shutting down the PHY and cleaning up the MDIO bus.
> 
> Fix this by moving unregister_netdev() ahead of phy_exit() in
> macb_remove().
> 
> Signed-off-by: luoguangfei <15388634752@163.com>

Please add an appropriate Fixes tag, pointing to the oldest commit
where issues could be reproduced.
-- 
pw-bot: cr

