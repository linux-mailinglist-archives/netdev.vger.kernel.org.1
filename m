Return-Path: <netdev+bounces-53426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60027802E9A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC552280A87
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921618E27;
	Mon,  4 Dec 2023 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2QviLJc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE814F73
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 09:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF40C433C8;
	Mon,  4 Dec 2023 09:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701682259;
	bh=WLGwhwAcCCBIJIOMjah0fWzcGI0FcfR3oru0iYFcjLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J2QviLJcwtcg3ovSPHhFw/MTNgYS5Irv15+2Y3qMFhcNNAUGTyPXTxgrISLGYbx+B
	 FYU2wM/ymmVnmhzVLhdISlUPdI4yD32wAlTuFsDb1EPZ+uQzFXBimDeS8nIlDh3lvD
	 tcC3s7fAL0siBYkXvByA4oIWCW06Kn5n/h65KlWX/nQklZp6YsRuMon7024v+7C9ce
	 Tsa8Y3scyNO7s5i/Vynzcf00DdVzPvh4Z97NTV+Q5wJIyRNLA8D68SafoMPSugFAOM
	 GFo2d950VElHAM8zwPCkIRU1imB9H+GbYaE7sQNhOqw/QKuStsFHC+Z6IzMo/iIjoC
	 nRGxu08CR9IFQ==
Message-ID: <96c4f619-857c-4a28-ac86-5a07214842a8@kernel.org>
Date: Mon, 4 Dec 2023 11:30:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH v7 net-next 6/8] net: ethernet: ti:
 am65-cpsw-qos: Add Frame Preemption MAC Merge support
Content-Language: en-US
To: "Varis, Pekka" <p-varis@ti.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Cc: "Vadapalli, Siddharth" <s-vadapalli@ti.com>,
 "Gunasekaran, Ravi" <r-gunasekaran@ti.com>,
 "Raghavendra, Vignesh" <vigneshr@ti.com>,
 "Govindarajan, Sriramakrishnan" <srk@ti.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <c773050ad0534fb3a5a9edcf5302d297@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c773050ad0534fb3a5a9edcf5302d297@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Pekka,

On 01/12/2023 18:01, Varis, Pekka wrote:
> 
> 
>> -----Original Message-----
>> From: Roger Quadros <rogerq@kernel.org>
>>
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state via
>> ethtool.
>>
>> As hardware does not support interrupt notification for verification events
>> we resort to polling on link up. On link up we try a couple of times for
>> verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
> 
> Should be 128 not 124

User space setting is without FCS.

> 
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 157 ++++++++++++++++++
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 175 ++++++++++++++++++++
>>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 102 ++++++++++++
>>  5 files changed, 441 insertions(+)
>>
>> Changelog:
>>
>> v7:
>> - use else if
>> - drop FIXME comment
>> - fix lldp kselftest failure by limiting max_verify_time to spec limit of 128ms.
>> - now passes all ethtool_mm.sh kselftests (patch 8 required)
>>
>> v6:
>> - get mutex around am65_cpsw_iet_commit_preemptible_tcs() in
>>   am65_cpsw_iet_change_preemptible_tcs()
>> - use "preemption" instead of "pre-emption"
>> - call am65_cpsw_setup_mqprio() from within am65_cpsw_setup_taprio()
>> - Now works with kselftest except the last test which fails
>>
>> v5:
>> - No change
>>
>> v4:
>> - Rebase and include in the same series as mqprio support.
>>
>> v3:
>> - Rebase on top of v6.6-rc1 and mqprio support [1]
>> - Support ethtool_ops :: get_mm_stats()
>> - drop unused variables cmn_ctrl and verify_cnt
>> - make am65_cpsw_iet_link_state_update() and
>>   am65_cpsw_iet_change_preemptible_tcs() static
>>
>> [1] https://lore.kernel.org/all/20230918075358.5878-1-rogerq@kernel.org/
>>
>> v2:
>> - Use proper control bits for PMAC enable
>> (AM65_CPSW_PN_CTL_IET_PORT_EN)
>>   and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
>> - Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
>>   AM65_CPSW_PN_CTL_IET_PORT_EN set.
>> - Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
> 
> Should be 128 not 124
> 
>> - Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
>>   1G link if link is inactive.
>> - resize the RX FIFO based on pmac_enabled, not tx_enabled.
>>
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> index b9e1d568604b..5571385b4baf 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/pm_runtime.h>
>>
>>  #include "am65-cpsw-nuss.h"
>> +#include "am65-cpsw-qos.h"
>>  #include "cpsw_ale.h"
>>  #include "am65-cpts.h"
>>
>> @@ -740,6 +741,159 @@ static int am65_cpsw_set_ethtool_priv_flags(struct
>> net_device *ndev, u32 flags)
>>  	return 0;
>>  }
>>
>> +static void am65_cpsw_port_iet_rx_enable(struct am65_cpsw_port *port,
>> +bool enable) {
>> +	u32 val;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +	if (enable)
>> +		val |= AM65_CPSW_PN_CTL_IET_PORT_EN;
>> +	else
>> +		val &= ~AM65_CPSW_PN_CTL_IET_PORT_EN;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_CTL);
>> +	am65_cpsw_iet_common_enable(port->common);
>> +}
>> +
>> +static void am65_cpsw_port_iet_tx_enable(struct am65_cpsw_port *port,
>> +bool enable) {
>> +	u32 val;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	if (enable)
>> +		val |= AM65_CPSW_PN_IET_MAC_PENABLE;
>> +	else
>> +		val &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL); }
>> +
>> +static int am65_cpsw_get_mm(struct net_device *ndev, struct
>> +ethtool_mm_state *state) {
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
>> +	u32 port_ctrl, iet_ctrl, iet_status;
>> +	u32 add_frag_size;
>> +
>> +	mutex_lock(&priv->mm_lock);
>> +
>> +	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +
>> +	state->tx_enabled = !!(iet_ctrl &
>> AM65_CPSW_PN_IET_MAC_PENABLE);
>> +	state->pmac_enabled = !!(port_ctrl &
>> AM65_CPSW_PN_CTL_IET_PORT_EN);
>> +
>> +	iet_status = readl(port->port_base +
>> AM65_CPSW_PN_REG_IET_STATUS);
>> +
>> +	if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
>> +		state->verify_status =
>> ETHTOOL_MM_VERIFY_STATUS_DISABLED;
>> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
>> +		state->verify_status =
>> ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
>> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
>> +		state->verify_status =
>> ETHTOOL_MM_VERIFY_STATUS_FAILED;
>> +	else
>> +		state->verify_status =
>> ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
>> +
>> +	add_frag_size =
>> AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
>> +	state->tx_min_frag_size =
>> +ethtool_mm_frag_size_add_to_min(add_frag_size);
>> +
>> +	/* Errata i2208: RX min fragment size cannot be less than 124 */
>> +	state->rx_min_frag_size = 124;
> 
> /* Errata i2208: RX min fragment size cannot be less than 128 */
> state->rx_min_frag_size = 128;

ethtool man page says
"           tx-min-frag-size
                  Shows the minimum size (in octets) of transmitted non-
                  final fragments which can be received by the link
                  partner. Corresponds to the standard addFragSize
                  variable using the formula:

                  tx-min-frag-size = 64 * (1 + addFragSize) - 4"

Which means user needs to put a -4 offset i.e. drop FCS size.

Drivers show rx-min-frag-size also without the FCS.

e.g.
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/mscc/ocelot_mm.c#L260

-- 
cheers,
-roger

