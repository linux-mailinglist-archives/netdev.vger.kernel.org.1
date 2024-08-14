Return-Path: <netdev+bounces-118511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2114951D20
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4290C1F21960
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5A1B32B7;
	Wed, 14 Aug 2024 14:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF292746F;
	Wed, 14 Aug 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645855; cv=none; b=uOxpzERlersB/grDTlP5uI+6B0cF4BHDKJt5qsvQ0tFkkdo2k5AiyxcAeEzWBbo0Xsw7IRKeOoJB7PhOR177Yxk+vfyLzGr4WmycdWdOhJ9nce7fRB8ITr2xFhZArqnjgfx0I5Iw3utP5xhTe1aoUQSRa/t2NNzBu7eE85EK6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645855; c=relaxed/simple;
	bh=k14aztThmsIOgo6M/dLqBI/UJ9VeerQMLri1JSVdeco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1tZsygeIFq8JNtBSZTzg8cFekrQv+S6El11nYmuI909SdRCoCUrxKH38k4334VqjQ+ImsLhB/WuFMpC+T2NJCIf5w+096+jGIJTeru5n30O728C6qBS1MIE9A9Q0X/EKOgB6SbF2BGF56ZgmH2BbpZyziX7KAb+Y8i9fnRov/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkVzb251hz9sPd;
	Wed, 14 Aug 2024 16:30:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kn59J-QRY_Ri; Wed, 14 Aug 2024 16:30:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkVzb0mSCz9rvV;
	Wed, 14 Aug 2024 16:30:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 06B1C8B775;
	Wed, 14 Aug 2024 16:30:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dM9j0ybAINzu; Wed, 14 Aug 2024 16:30:50 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C27B8B764;
	Wed, 14 Aug 2024 16:30:49 +0200 (CEST)
Message-ID: <bb8df262-436b-4714-bc26-cb2ae2051991@csgroup.eu>
Date: Wed, 14 Aug 2024 16:30:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 07/14] net: ethtool: Introduce a command to
 list PHYs on an interface
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-8-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-8-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> As we have the ability to track the PHYs connected to a net_device
> through the link_topology, we can expose this list to userspace. This
> allows userspace to use these identifiers for phy-specific commands and
> take the decision of which PHY to target by knowing the link topology.
> 
> Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> devices on only one interface.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   Documentation/networking/ethtool-netlink.rst |  41 +++
>   include/uapi/linux/ethtool_netlink.h         |  19 ++
>   net/ethtool/Makefile                         |   3 +-
>   net/ethtool/netlink.c                        |   9 +
>   net/ethtool/netlink.h                        |   5 +
>   net/ethtool/phy.c                            | 308 +++++++++++++++++++
>   6 files changed, 384 insertions(+), 1 deletion(-)
>   create mode 100644 net/ethtool/phy.c
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index a6ea3716315f..d9f0c0dba1e5 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -2182,6 +2182,46 @@ string.
>   The ``ETHTOOL_A_MODULE_FW_FLASH_DONE`` and ``ETHTOOL_A_MODULE_FW_FLASH_TOTAL``
>   attributes encode the completed and total amount of work, respectively.
>   
> +PHY_GET
> +=======
> +
> +Retrieve information about a given Ethernet PHY sitting on the link. The DO
> +operation returns all available information about dev->phydev. User can also
> +specify a PHY_INDEX, in which case the DO request returns information about that
> +specific PHY.
> +As there can be more than one PHY, the DUMP operation can be used to list the PHYs
> +present on a given interface, by passing an interface index or name in
> +the dump request.
> +
> +Request contents:
> +
> +  ====================================  ======  ==========================
> +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> +  ====================================  ======  ==========================
> +
> +Kernel response contents:
> +
> +  ===================================== ======  ===============================
> +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> +  ``ETHTOOL_A_PHY_INDEX``               u32     the phy's unique index, that can
> +                                                be used for phy-specific
> +                                                requests
> +  ``ETHTOOL_A_PHY_DRVNAME``             string  the phy driver name
> +  ``ETHTOOL_A_PHY_NAME``                string  the phy device name
> +  ``ETHTOOL_A_PHY_UPSTREAM_TYPE``       u32     the type of device this phy is
> +                                                connected to
> +  ``ETHTOOL_A_PHY_UPSTREAM_INDEX``      u32     the PHY index of the upstream
> +                                                PHY
> +  ``ETHTOOL_A_PHY_UPSTREAM_SFP_NAME``   string  if this PHY is connected to
> +                                                its parent PHY through an SFP
> +                                                bus, the name of this sfp bus
> +  ``ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME`` string  if the phy controls an sfp bus,
> +                                                the name of the sfp bus
> +  ===================================== ======  ===============================
> +
> +When ``ETHTOOL_A_PHY_UPSTREAM_TYPE`` is PHY_UPSTREAM_PHY, the PHY's parent is
> +another PHY.
> +
>   Request translation
>   ===================
>   
> @@ -2289,4 +2329,5 @@ are netlink only.
>     n/a                                 ``ETHTOOL_MSG_MM_GET``
>     n/a                                 ``ETHTOOL_MSG_MM_SET``
>     n/a                                 ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``
> +  n/a                                 ``ETHTOOL_MSG_PHY_GET``
>     =================================== =====================================
> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
> index c5af23139e63..6ad32843b32a 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -58,6 +58,7 @@ enum {
>   	ETHTOOL_MSG_MM_GET,
>   	ETHTOOL_MSG_MM_SET,
>   	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
> +	ETHTOOL_MSG_PHY_GET,
>   
>   	/* add new constants above here */
>   	__ETHTOOL_MSG_USER_CNT,
> @@ -111,6 +112,8 @@ enum {
>   	ETHTOOL_MSG_MM_GET_REPLY,
>   	ETHTOOL_MSG_MM_NTF,
>   	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
> +	ETHTOOL_MSG_PHY_GET_REPLY,
> +	ETHTOOL_MSG_PHY_NTF,
>   
>   	/* add new constants above here */
>   	__ETHTOOL_MSG_KERNEL_CNT,
> @@ -1050,6 +1053,22 @@ enum {
>   	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
>   };
>   
> +enum {
> +	ETHTOOL_A_PHY_UNSPEC,
> +	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
> +	ETHTOOL_A_PHY_INDEX,			/* u32 */
> +	ETHTOOL_A_PHY_DRVNAME,			/* string */
> +	ETHTOOL_A_PHY_NAME,			/* string */
> +	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u32 */
> +	ETHTOOL_A_PHY_UPSTREAM_INDEX,		/* u32 */
> +	ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,	/* string */
> +	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
> +
> +	/* add new constants above here */
> +	__ETHTOOL_A_PHY_CNT,
> +	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
> +};
> +
>   /* generic netlink info */
>   #define ETHTOOL_GENL_NAME "ethtool"
>   #define ETHTOOL_GENL_VERSION 1
> diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
> index 9a190635fe95..9b540644ba31 100644
> --- a/net/ethtool/Makefile
> +++ b/net/ethtool/Makefile
> @@ -8,4 +8,5 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
>   		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
>   		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
>   		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
> -		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o
> +		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o \
> +		   phy.o
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 7b95571a6efb..153d34dbc48a 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -1232,6 +1232,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
>   		.policy	= ethnl_module_fw_flash_act_policy,
>   		.maxattr = ARRAY_SIZE(ethnl_module_fw_flash_act_policy) - 1,
>   	},
> +	{
> +		.cmd	= ETHTOOL_MSG_PHY_GET,
> +		.doit	= ethnl_phy_doit,
> +		.start	= ethnl_phy_start,
> +		.dumpit	= ethnl_phy_dumpit,
> +		.done	= ethnl_phy_done,
> +		.policy = ethnl_phy_get_policy,
> +		.maxattr = ARRAY_SIZE(ethnl_phy_get_policy) - 1,
> +	},
>   };
>   
>   static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index 4db16048f8d4..4a702dc853bf 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -484,6 +484,7 @@ extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADE
>   extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
>   extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
>   extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD + 1];
> +extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
>   
>   int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
>   int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
> @@ -492,6 +493,10 @@ int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
>   int ethnl_tunnel_info_start(struct netlink_callback *cb);
>   int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
>   int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info);
> +int ethnl_phy_start(struct netlink_callback *cb);
> +int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info);
> +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
> +int ethnl_phy_done(struct netlink_callback *cb);
>   
>   extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
>   extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> new file mode 100644
> index 000000000000..560dd039c662
> --- /dev/null
> +++ b/net/ethtool/phy.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2023 Bootlin
> + *
> + */
> +#include "common.h"
> +#include "netlink.h"
> +
> +#include <linux/phy.h>
> +#include <linux/phy_link_topology.h>
> +#include <linux/sfp.h>
> +
> +struct phy_req_info {
> +	struct ethnl_req_info		base;
> +	struct phy_device_node		*pdn;
> +};
> +
> +#define PHY_REQINFO(__req_base) \
> +	container_of(__req_base, struct phy_req_info, base)
> +
> +const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1] = {
> +	[ETHTOOL_A_PHY_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
> +};
> +
> +/* Caller holds rtnl */
> +static ssize_t
> +ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
> +		     struct netlink_ext_ack *extack)
> +{
> +	struct phy_req_info *req_info = PHY_REQINFO(req_base);
> +	struct phy_device_node *pdn = req_info->pdn;
> +	struct phy_device *phydev = pdn->phy;
> +	size_t size = 0;
> +
> +	ASSERT_RTNL();
> +
> +	/* ETHTOOL_A_PHY_INDEX */
> +	size += nla_total_size(sizeof(u32));
> +
> +	/* ETHTOOL_A_DRVNAME */
> +	if (phydev->drv)
> +		size += nla_total_size(strlen(phydev->drv->name) + 1);
> +
> +	/* ETHTOOL_A_NAME */
> +	size += nla_total_size(strlen(dev_name(&phydev->mdio.dev)) + 1);
> +
> +	/* ETHTOOL_A_PHY_UPSTREAM_TYPE */
> +	size += nla_total_size(sizeof(u32));
> +
> +	if (phy_on_sfp(phydev)) {
> +		const char *upstream_sfp_name = sfp_get_name(pdn->parent_sfp_bus);
> +
> +		/* ETHTOOL_A_PHY_UPSTREAM_SFP_NAME */
> +		if (upstream_sfp_name)
> +			size += nla_total_size(strlen(upstream_sfp_name) + 1);
> +
> +		/* ETHTOOL_A_PHY_UPSTREAM_INDEX */
> +		size += nla_total_size(sizeof(u32));
> +	}
> +
> +	/* ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME */
> +	if (phydev->sfp_bus) {
> +		const char *sfp_name = sfp_get_name(phydev->sfp_bus);
> +
> +		if (sfp_name)
> +			size += nla_total_size(strlen(sfp_name) + 1);
> +	}
> +
> +	return size;
> +}
> +
> +static int
> +ethnl_phy_fill_reply(const struct ethnl_req_info *req_base, struct sk_buff *skb)
> +{
> +	struct phy_req_info *req_info = PHY_REQINFO(req_base);
> +	struct phy_device_node *pdn = req_info->pdn;
> +	struct phy_device *phydev = pdn->phy;
> +	enum phy_upstream ptype;
> +
> +	ptype = pdn->upstream_type;
> +
> +	if (nla_put_u32(skb, ETHTOOL_A_PHY_INDEX, phydev->phyindex) ||
> +	    nla_put_string(skb, ETHTOOL_A_PHY_NAME, dev_name(&phydev->mdio.dev)) ||
> +	    nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_TYPE, ptype))
> +		return -EMSGSIZE;
> +
> +	if (phydev->drv &&
> +	    nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, phydev->drv->name))
> +		return -EMSGSIZE;
> +
> +	if (ptype == PHY_UPSTREAM_PHY) {
> +		struct phy_device *upstream = pdn->upstream.phydev;
> +		const char *sfp_upstream_name;
> +
> +		/* Parent index */
> +		if (nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_INDEX, upstream->phyindex))
> +			return -EMSGSIZE;
> +
> +		if (pdn->parent_sfp_bus) {
> +			sfp_upstream_name = sfp_get_name(pdn->parent_sfp_bus);
> +			if (sfp_upstream_name &&
> +			    nla_put_string(skb, ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,
> +					   sfp_upstream_name))
> +				return -EMSGSIZE;
> +		}
> +	}
> +
> +	if (phydev->sfp_bus) {
> +		const char *sfp_name = sfp_get_name(phydev->sfp_bus);
> +
> +		if (sfp_name &&
> +		    nla_put_string(skb, ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,
> +				   sfp_name))
> +			return -EMSGSIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
> +				   struct nlattr **tb,
> +				   struct netlink_ext_ack *extack)
> +{
> +	struct phy_link_topology *topo = req_base->dev->link_topo;
> +	struct phy_req_info *req_info = PHY_REQINFO(req_base);
> +	struct phy_device *phydev;
> +
> +	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PHY_HEADER],
> +				      extack);
> +	if (!phydev)
> +		return 0;
> +
> +	if (IS_ERR(phydev))
> +		return PTR_ERR(phydev);
> +
> +	if (!topo)
> +		return 0;
> +
> +	req_info->pdn = xa_load(&topo->phys, phydev->phyindex);
> +
> +	return 0;
> +}
> +
> +int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct phy_req_info req_info = {};
> +	struct nlattr **tb = info->attrs;
> +	struct sk_buff *rskb;
> +	void *reply_payload;
> +	int reply_len;
> +	int ret;
> +
> +	ret = ethnl_parse_header_dev_get(&req_info.base,
> +					 tb[ETHTOOL_A_PHY_HEADER],
> +					 genl_info_net(info), info->extack,
> +					 true);
> +	if (ret < 0)
> +		return ret;
> +
> +	rtnl_lock();
> +
> +	ret = ethnl_phy_parse_request(&req_info.base, tb, info->extack);
> +	if (ret < 0)
> +		goto err_unlock_rtnl;
> +
> +	/* No PHY, return early */
> +	if (!req_info.pdn->phy)
> +		goto err_unlock_rtnl;
> +
> +	ret = ethnl_phy_reply_size(&req_info.base, info->extack);
> +	if (ret < 0)
> +		goto err_unlock_rtnl;
> +	reply_len = ret + ethnl_reply_header_size();
> +
> +	rskb = ethnl_reply_init(reply_len, req_info.base.dev,
> +				ETHTOOL_MSG_PHY_GET_REPLY,
> +				ETHTOOL_A_PHY_HEADER,
> +				info, &reply_payload);
> +	if (!rskb) {
> +		ret = -ENOMEM;
> +		goto err_unlock_rtnl;
> +	}
> +
> +	ret = ethnl_phy_fill_reply(&req_info.base, rskb);
> +	if (ret)
> +		goto err_free_msg;
> +
> +	rtnl_unlock();
> +	ethnl_parse_header_dev_put(&req_info.base);
> +	genlmsg_end(rskb, reply_payload);
> +
> +	return genlmsg_reply(rskb, info);
> +
> +err_free_msg:
> +	nlmsg_free(rskb);
> +err_unlock_rtnl:
> +	rtnl_unlock();
> +	ethnl_parse_header_dev_put(&req_info.base);
> +	return ret;
> +}
> +
> +struct ethnl_phy_dump_ctx {
> +	struct phy_req_info	*phy_req_info;
> +	unsigned long ifindex;
> +	unsigned long phy_index;
> +};
> +
> +int ethnl_phy_start(struct netlink_callback *cb)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> +
> +	ctx->phy_req_info = kzalloc(sizeof(*ctx->phy_req_info), GFP_KERNEL);
> +	if (!ctx->phy_req_info)
> +		return -ENOMEM;
> +
> +	ret = ethnl_parse_header_dev_get(&ctx->phy_req_info->base,
> +					 info->attrs[ETHTOOL_A_PHY_HEADER],
> +					 sock_net(cb->skb->sk), cb->extack,
> +					 false);
> +	ctx->ifindex = 0;
> +	ctx->phy_index = 0;
> +
> +	if (ret)
> +		kfree(ctx->phy_req_info);
> +
> +	return ret;
> +}
> +
> +int ethnl_phy_done(struct netlink_callback *cb)
> +{
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +
> +	if (ctx->phy_req_info->base.dev)
> +		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
> +
> +	kfree(ctx->phy_req_info);
> +
> +	return 0;
> +}
> +
> +static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
> +				  struct netlink_callback *cb)
> +{
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	struct phy_req_info *pri = ctx->phy_req_info;
> +	struct phy_device_node *pdn;
> +	int ret = 0;
> +	void *ehdr;
> +
> +	pri->base.dev = dev;
> +
> +	if (!dev->link_topo)
> +		return 0;
> +
> +	xa_for_each_start(&dev->link_topo->phys, ctx->phy_index, pdn, ctx->phy_index) {
> +		ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_PHY_GET_REPLY);
> +		if (!ehdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret = ethnl_fill_reply_header(skb, dev, ETHTOOL_A_PHY_HEADER);
> +		if (ret < 0) {
> +			genlmsg_cancel(skb, ehdr);
> +			break;
> +		}
> +
> +		pri->pdn = pdn;
> +		ret = ethnl_phy_fill_reply(&pri->base, skb);
> +		if (ret < 0) {
> +			genlmsg_cancel(skb, ehdr);
> +			break;
> +		}
> +
> +		genlmsg_end(skb, ehdr);
> +	}
> +
> +	return ret;
> +}
> +
> +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	struct net *net = sock_net(skb->sk);
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rtnl_lock();
> +
> +	if (ctx->phy_req_info->base.dev) {
> +		ret = ethnl_phy_dump_one_dev(skb, ctx->phy_req_info->base.dev, cb);
> +	} else {
> +		for_each_netdev_dump(net, dev, ctx->ifindex) {
> +			ret = ethnl_phy_dump_one_dev(skb, dev, cb);
> +			if (ret)
> +				break;
> +
> +			ctx->phy_index = 0;
> +		}
> +	}
> +	rtnl_unlock();
> +
> +	return ret;
> +}

