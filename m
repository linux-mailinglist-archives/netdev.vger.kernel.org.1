Return-Path: <netdev+bounces-216460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B6B33D42
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C62205177
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4124C2DCF6E;
	Mon, 25 Aug 2025 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O7Cv3ims"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3A2E0419
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119230; cv=none; b=skjA1tN8dn0elNa20Xc/Y6q49wfbfSsco1jLaiEx/KZFFPiq+O1rpFtkQh68KE3MGe9RvfUHT+DTRSi8ipDX3a4vsgzjhkw7CIuYegKCh7/JNjOO7OQLm3vTkKjSUYUkVEd5ciMuZLz1tRenR6IkJ8MakcjLmPfGH5VPIndWoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119230; c=relaxed/simple;
	bh=QqJu6QjgWVorILPoRw/+xHaerh+Bd01I8TBlH3G1MSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mlmbB6jdm2vnlcKIqmt/U3goqafJVO+ahv0PGDrW89ZAHBxCdMGhm7Zh3NEIlskLYAg8NlB29iISBUQU8XnbDfPdTP7ajRM+ZwIX+YNN82FHjdQ4kfLNgoRxA4kLzF3D84GT8qB2ELquBBBUBen0oeCiXMIhnALp6NBwrWpuokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O7Cv3ims; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250825105340euoutp02871302c09bed6ee6310f513faf2f3407~e-SBgq3zY0072500725euoutp02L
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 10:53:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250825105340euoutp02871302c09bed6ee6310f513faf2f3407~e-SBgq3zY0072500725euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756119220;
	bh=/fa4+ZI2ynYvAnmTSBhg899GLSJbeJtzYjuSjpeEGlo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=O7Cv3imsFNC7IeAXaIsQOTVSs76RWqKfhuY1jXd2FZM3Ej/vljQpDs3xEZkUN5oVS
	 yD3dDR5BV5Iy+WZgQeEsmHuWRu5jXr5enJzwDjpRONP0YLo+IUG8+2kMY+tteupH4e
	 6arTUTVUhfF3zVlfow0G8gUAI3YCMMvTsmHj+HwI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250825105339eucas1p13cf980f9b7f4ba4f465f5953b97f149c~e-SA9vcu40800108001eucas1p1m;
	Mon, 25 Aug 2025 10:53:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250825105337eusmtip19068233323fe8c45892597caf271a2e6~e-R-X77KD1201812018eusmtip19;
	Mon, 25 Aug 2025 10:53:37 +0000 (GMT)
Message-ID: <809848c9-2ffa-4743-adda-b8b714b404de@samsung.com>
Date: Mon, 25 Aug 2025 12:53:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH net-next v3] net: ethernet: stmmac: dwmac-rk: Make the
 clk_phy could be used for external phy
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>, Chaoyi Chen
	<kernel@airkyi.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Jonas Karlman <jonas@kwiboo.se>, David Wu
	<david.wu@rock-chips.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <d0fe6d16-181f-4b38-9457-1099fb6419d0@rock-chips.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250825105339eucas1p13cf980f9b7f4ba4f465f5953b97f149c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250825072312eucas1p2d4751199c0ea069c7938218be60e5e93
X-EPHeader: CA
X-CMS-RootMailID: 20250825072312eucas1p2d4751199c0ea069c7938218be60e5e93
References: <20250815023515.114-1-kernel@airkyi.com>
	<CGME20250825072312eucas1p2d4751199c0ea069c7938218be60e5e93@eucas1p2.samsung.com>
	<a30a8c97-6b96-45ba-bad7-8a40401babc2@samsung.com>
	<d0fe6d16-181f-4b38-9457-1099fb6419d0@rock-chips.com>

On 25.08.2025 11:57, Chaoyi Chen wrote:
> On 8/25/2025 3:23 PM, Marek Szyprowski wrote:
>> On 15.08.2025 04:35, Chaoyi Chen wrote:
>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>
>>> For external phy, clk_phy should be optional, and some external phy
>>> need the clock input from clk_phy. This patch adds support for setting
>>> clk_phy for external phy.
>>>
>>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>> ---
>>>
>>> Changes in v3:
>>> - Link to V2: 
>>> https://lore.kernel.org/netdev/20250812012127.197-1-kernel@airkyi.com/
>>> - Rebase to net-next/main
>>>
>>> Changes in v2:
>>> - Link to V1: 
>>> https://lore.kernel.org/netdev/20250806011405.115-1-kernel@airkyi.com/
>>> - Remove get clock frequency from DT prop
>>>
>>>    drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 11 +++++++----
>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c 
>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>>> index ac8288301994..5d921e62c2f5 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>>> @@ -1412,12 +1412,15 @@ static int rk_gmac_clk_init(struct 
>>> plat_stmmacenet_data *plat)
>>>            clk_set_rate(plat->stmmac_clk, 50000000);
>>>        }
>>>    -    if (plat->phy_node && bsp_priv->integrated_phy) {
>>> +    if (plat->phy_node) {
>>>            bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>>>            ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>>> -        if (ret)
>>> -            return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
>>> -        clk_set_rate(bsp_priv->clk_phy, 50000000);
>>> +        /* If it is not integrated_phy, clk_phy is optional */
>>> +        if (bsp_priv->integrated_phy) {
>>> +            if (ret)
>>> +                return dev_err_probe(dev, ret, "Cannot get PHY 
>>> clock\n");
>>> +            clk_set_rate(bsp_priv->clk_phy, 50000000);
>>> +        }
>
> I think  we should set bsp_priv->clk_phy to NULL here if we failed to 
> get the clock.
>
> Could you try this on your board? Thank you.

Right, the following change also fixes this issue:

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c 
b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 9fc41207cc45..2d19d48be01f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1415,6 +1415,8 @@ static int rk_gmac_clk_init(struct 
plat_stmmacenet_data *plat)
         if (plat->phy_node) {
                 bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
                 ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
+               if (ret)
+                       bsp_priv->clk_phy = NULL;
                 /* If it is not integrated_phy, clk_phy is optional */
                 if (bsp_priv->integrated_phy) {
                         if (ret)


 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


