Return-Path: <netdev+bounces-177245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727FA6E67A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC9418969DA
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF31EE7A8;
	Mon, 24 Mar 2025 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwRc6W8X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1121E3DC9;
	Mon, 24 Mar 2025 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854559; cv=none; b=e3U+Ek9sU8iLWNVkfJU1IRh9MYombDfusLp1mBP3U5CliRU6jIMXFJSatoDB01rSlOcKWSu5irmtH3bN0gZE+H0essZMcwa0sqaaCNFyUh70I/PzRHYgN6OMNhrnCaWYJxaMSs/MLBeeDEtNx4OZD9DAE7dBJy1EmFobIA5TUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854559; c=relaxed/simple;
	bh=7hssLqXra0EtdFlVqqKTDr+8oGTjg6jkdSrUMz3mwCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuRgEz2M8sJvxzdjWpnahItw57zy/rZ9ZQRs20oYNI38QdPJqOjzgEJvDxhlUoGCc24TbAQ8DPoQyx8ir6XWz6jHQIZjsXEkEJ9oCH9F0FDIPdiDYwtsl4QkiMdCA8aVBDIknq5BDvD266ncfnpbT0LVRZWNYj+08SqZIE5IDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwRc6W8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F4BC4CEDD;
	Mon, 24 Mar 2025 22:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742854558;
	bh=7hssLqXra0EtdFlVqqKTDr+8oGTjg6jkdSrUMz3mwCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QwRc6W8Xl+JhPwMgvjkDRnSQo1DNMTM4pHLJBaT9E2QQDNi5aBSdiPQwxLuZvHDSE
	 jkPBpHAMlZqFLyjG2E8hv065Z+MXU/2lGMGEFIFmRli7ULpd2fbpKhouW+nrpOxUQ8
	 CKIExxe3RlBvnoHT8XHszGoGpVwa2muHMBkSK7BW8Ob5Sv5c9TChhg3yoyys8wGE6c
	 BlFMWixD6/Cl6BHn6u0i2u91HyNTMKqU44RuxxE19MXWiorxMgCjb4Z32sf/ZPzjpj
	 TffG8NbexdoNmuj061PpDJoHbdtfbWPcl28OfZ+5Rj3AQAr3cy0VS214pVtmS746HN
	 Y+YJU2jE2IEHw==
Date: Mon, 24 Mar 2025 15:15:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 1/3] net: phy: realtek: Clean up RTL8211E ExtPage
 access
Message-ID: <20250324151551.76869d80@kernel.org>
In-Reply-To: <20250317200532.93620-2-michael@fossekall.de>
References: <20250317200532.93620-1-michael@fossekall.de>
	<20250317200532.93620-2-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry for the delay, unfortunately this no longer applies:

Applying: net: phy: realtek: Clean up RTL8211E ExtPage access
error: patch failed: drivers/net/phy/realtek/realtek_main.c:28
error: drivers/net/phy/realtek/realtek_main.c: patch does not apply
Patch failed at 0001 net: phy: realtek: Clean up RTL8211E ExtPage access
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Given that some nits before you send v5 below..

On Mon, 17 Mar 2025 21:05:30 +0100 Michael Klein wrote:
> - Factor out RTL8211E extension page access code to
>   rtl8211e_modify_ext_page()/rtl8211e_read_ext_page() and add some
>   related #define:s
> - Group RTL8211E_* and RTL8211F_* #define:s
> - Clean up rtl8211e_config_init()

Sounds like this should be split into at least 2 patches.

>  static int rtl821x_probe(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
> @@ -600,7 +617,8 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
>  
>  static int rtl8211e_config_init(struct phy_device *phydev)
>  {
> -	int ret = 0, oldpage;
> +	const u16 delay_mask = RTL8211E_CTRL_DELAY |
> +		RTL8211E_TX_DELAY | RTL8211E_RX_DELAY;

This would probably be easier to read if alinged.

	const u16 delay_mask = RTL8211E_CTRL_DELAY |
			       RTL8211E_TX_DELAY | 
			       RTL8211E_RX_DELAY;
-- 
pw-bot: cr

