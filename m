Return-Path: <netdev+bounces-55271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E18680A0B8
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CE31F20FBA
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9FD15EA1;
	Fri,  8 Dec 2023 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpklkUH6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CB14297
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13ADC433C9;
	Fri,  8 Dec 2023 10:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702031191;
	bh=lfmKDEwOUmTPXvoRPl2q9XIJwvMLL80I1RUkkz2lXGQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UpklkUH6smOcihHKs+Qn9wUKplMyZJ6ZJ0+DdC6kl7Al/lcpFkEJ0QsYRx76L+G8P
	 GgbJZNwtZcqElRAOO8N7I24PiexGTo8U82I0cYv8srMmFtHLqEz/PcFIjjEThOFiGG
	 FJhxibbvD/mOpOD5Ehmn9lI/ezsombl8VoWEtY3r/wT6j7jKNRuNkgxUPtJHdF0cgy
	 5rwjBhlOC7grjf8hPARu5dzYevYI2iWpNx6xs2051vbuMhx9d9ei6CRK36gNuO+Tgd
	 wQInii5PfIDa4dIus1eYJkQrvEovl9BgW70jf4Q6CKY4PSUPZANYSYILQvWKCge/2q
	 LOCdnDLZFmcUw==
Message-ID: <7d8fb848-a491-414b-adb8-d26a16a499a4@kernel.org>
Date: Fri, 8 Dec 2023 12:26:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
 netdev@vger.kernel.org
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231204123531.tpjbt7byzdnrhs7f@skbuf>
 <8caf8252-4068-4d17-b919-12adfef074e5@kernel.org>
In-Reply-To: <8caf8252-4068-4d17-b919-12adfef074e5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/12/2023 12:13, Roger Quadros wrote:
> 
> 
> On 04/12/2023 14:35, Vladimir Oltean wrote:
>> On Fri, Dec 01, 2023 at 03:58:00PM +0200, Roger Quadros wrote:
>>> Add driver support for viewing / changing the MAC Merge sublayer
>>> parameters and seeing the verification state machine's current state
>>> via ethtool.
>>>
>>> As hardware does not support interrupt notification for verification
>>> events we resort to polling on link up. On link up we try a couple of
>>> times for verification success and if unsuccessful then give up.
>>>
>>> The Frame Preemption feature is described in the Technical Reference
>>> Manual [1] in section:
>>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>>
>>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>>
>>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>
>> Actually...
>>
>> ld.lld: error: undefined symbol: am65_cpsw_iet_common_enable
>>>>> referenced by am65-cpsw-ethtool.c:755 (drivers/net/ethernet/ti/am65-cpsw-ethtool.c:755)
>>>>>               drivers/net/ethernet/ti/am65-cpsw-ethtool.o:(am65_cpsw_set_mm) in archive vmlinux.a
>>
>> ld.lld: error: undefined symbol: am65_cpsw_iet_commit_preemptible_tcs
>>>>> referenced by am65-cpsw-ethtool.c:876 (drivers/net/ethernet/ti/am65-cpsw-ethtool.c:876)
>>>>>               drivers/net/ethernet/ti/am65-cpsw-ethtool.o:(am65_cpsw_set_mm) in archive vmlinux.a
>>
>> cat $KBUILD_OUTPUT/.config | grep AM65
>> CONFIG_TI_K3_AM65_CPSW_NUSS=y
>> # CONFIG_TI_K3_AM65_CPSW_SWITCHDEV is not set
>> # CONFIG_TI_K3_AM65_CPTS is not set
>> CONFIG_MMC_SDHCI_AM654=y
>> CONFIG_PHY_AM654_SERDES=m
>>
>> am65-cpsw-qos.c is built only if CONFIG_TI_AM65_CPSW_TAS is enabled, yet am65-cpsw-ethtool.c,
>> built by CONFIG_TI_K3_AM65_CPSW_NUSS, depends on it.
> 
> Wondering how to fix this the right way. Should set/get_mm fail if CONFIG_TI_AM65_CPSW_TAS is not enabled?
> 

How about this fix?

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index 1ac4b9b53c93..688291d6038f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -775,6 +775,9 @@ static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *st
 	u32 port_ctrl, iet_ctrl, iet_status;
 	u32 add_frag_size;
 
+	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&priv->mm_lock);
 
 	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
@@ -827,6 +830,9 @@ static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	u32 val, add_frag_size;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
+		return -EOPNOTSUPP;
+
 	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 6df3c2c5a04b..946e89fbb314 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -100,6 +100,8 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
 void am65_cpsw_qos_link_down(struct net_device *ndev);
 int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
 void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
+void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
+void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
 #else
 static inline int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev,
 					     enum tc_setup_type type,
@@ -124,10 +126,12 @@ static inline int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev,
 
 static inline void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
 { }
+static inline void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
+{ }
+static inline void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common)
+{ }
 #endif
 
-void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
-void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
 
 #define AM65_CPSW_REG_CTL			0x004
 #define AM65_CPSW_PN_REG_CTL			0x004


-- 
cheers,
-roger

