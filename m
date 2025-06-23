Return-Path: <netdev+bounces-200156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBBAE3730
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDB7188F6CA
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F0F1388;
	Mon, 23 Jun 2025 07:45:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290C3C3C
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664725; cv=none; b=Zooat1Dxo4FdEiYnA6N6ta+umFWCwWlg3j2AWhnB2vrgVuTxLvX0dnrVzv4oTukBwZSgEvjJShMBp4S5r8p+78Wr3crNvMPfRoUtzyU6Z9YuY7UNVwPtvl5FBg5opwLJgQDqubONscZimSxc1TRciOS2nimywVnj1KyNYRFf7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664725; c=relaxed/simple;
	bh=mmBksMTTd27HyDcg6ireOZHAyB0klljVc3tmVvzCzns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZIsJ4RpUfFCOvhcpIwiDUGGvIotMCtxBX3D0SF8YgE8D/eqf6WEPar7Lk7cqi8ifWXfQ6ScmVBAzRNzbNxCs7Upy/kNpjszLOQld/l1UAidDpISjAFg6OqT3KZ2dPFpBPIKuEmRbl0/yQsgUMnvh5/0d0u3GOGduQmJ9f6fO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uTbrk-0000dH-Dy; Mon, 23 Jun 2025 09:45:20 +0200
Message-ID: <dbc2fcc9-5cd9-43c9-a9f9-9d5d16bb81b4@pengutronix.de>
Date: Mon, 23 Jun 2025 09:45:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bridge: dump mcast querier state per vlan
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
 <d8d5a8f4-33a8-4a62-b48e-fb82b8de245b@blackwall.org>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <d8d5a8f4-33a8-4a62-b48e-fb82b8de245b@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 6/20/25 14:44, Nikolay Aleksandrov wrote:
> On 6/20/25 15:16, Fabian Pfitzner wrote:
>> Dump the multicast querier state per vlan.
>> This commit is almost identical to [1].
>>
>> The querier state can be seen with:
>>
>> bridge -d vlan global
>>
>> The options for vlan filtering and vlan mcast snooping have to be enabled
>> in order to see the output:
>>
>> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
>>
>> The querier state shows the following information for IPv4 and IPv6
>> respectively:
>>
>> 1) The ip address of the current querier in the network. This could be
>>     ourselves or an external querier.
>> 2) The port on which the querier was seen
>> 3) Querier timeout in seconds
>>
>> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>>
>> v1->v2
>> 	- refactor code
>> 	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
>>
>> v2->v3
>> 	- move code into a shared function
>> 	- use shared function in bridge and ip utility
>> 	- link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
>> ---
>>   bridge/vlan.c      |  3 +++
>>   include/bridge.h   |  3 +++
>>   ip/iplink_bridge.c | 57 +---------------------------------------------
>>   lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 63 insertions(+), 56 deletions(-)
>>
> Hi,
> The subject should contain the target for this patch which is iproute2-next,
> e.g. [PATCH iproute2-next v3]. Since there would be another version, I'd split
> it in 2 patches - 1 that moves the existing code to lib/bridge.c and the second
> which adds the vlan querier print code.
>
> Also a few comments below..
I'll split it into three commits then:
1. Move existing code into shared function
2. Call shared function in bridge/vlan.c as well
3. Refactor code according to Ido's code proposal from v1
>
>> diff --git a/bridge/vlan.c b/bridge/vlan.c
>> index 14b8475d..0233eaf6 100644
>> --- a/bridge/vlan.c
>> +++ b/bridge/vlan.c
>> @@ -852,6 +852,9 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>>   		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>>   			   rta_getattr_u8(vattr));
>>   	}
>> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
>> +		dump_mcast_querier_state(vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
> Add a local variable for the attribute and make this line shorter (<= 80chars).
>
>> +	}
>>   	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>>   		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>>   		print_uint(PRINT_ANY, "mcast_igmp_version",
>> diff --git a/include/bridge.h b/include/bridge.h
>> index 8bcd1e38..9e9447c6 100644
>> --- a/include/bridge.h
>> +++ b/include/bridge.h
>> @@ -3,9 +3,12 @@
>>   #define __BRIDGE_H__ 1
>>
>>   #include <linux/if_bridge.h>
>> +#include <linux/rtnetlink.h>
>>
>>   void bridge_print_vlan_flags(__u16 flags);
>>   void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
>>   void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);
>>
>> +void dump_mcast_querier_state(const struct rtattr* vtb);
>> +
>>   #endif /* __BRIDGE_H__ */
>> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
>> index 31e7cb5e..68a277ef 100644
>> --- a/ip/iplink_bridge.c
>> +++ b/ip/iplink_bridge.c
>> @@ -682,62 +682,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>>   			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>>
>>   	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
>> -		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
>> -		SPRINT_BUF(other_time);
>> -
>> -		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
>> -		memset(other_time, 0, sizeof(other_time));
>> -
>> -		open_json_object("mcast_querier_state_ipv4");
>> -		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
>> -			print_string(PRINT_FP,
>> -				NULL,
>> -				"%s ",
>> -				"mcast_querier_ipv4_addr");
>> -			print_color_string(PRINT_ANY,
>> -				COLOR_INET,
>> -				"mcast_querier_ipv4_addr",
>> -				"%s ",
>> -				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
>> -		}
>> -		if (bqtb[BRIDGE_QUERIER_IP_PORT])
>> -			print_uint(PRINT_ANY,
>> -				"mcast_querier_ipv4_port",
>> -				"mcast_querier_ipv4_port %u ",
>> -				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
>> -		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
>> -			print_string(PRINT_ANY,
>> -				"mcast_querier_ipv4_other_timer",
>> -				"mcast_querier_ipv4_other_timer %s ",
>> -				sprint_time64(
>> -					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
>> -									other_time));
>> -		close_json_object();
>> -		open_json_object("mcast_querier_state_ipv6");
>> -		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
>> -			print_string(PRINT_FP,
>> -				NULL,
>> -				"%s ",
>> -				"mcast_querier_ipv6_addr");
>> -			print_color_string(PRINT_ANY,
>> -				COLOR_INET6,
>> -				"mcast_querier_ipv6_addr",
>> -				"%s ",
>> -				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
>> -		}
>> -		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
>> -			print_uint(PRINT_ANY,
>> -				"mcast_querier_ipv6_port",
>> -				"mcast_querier_ipv6_port %u ",
>> -				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
>> -		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
>> -			print_string(PRINT_ANY,
>> -				"mcast_querier_ipv6_other_timer",
>> -				"mcast_querier_ipv6_other_timer %s ",
>> -				sprint_time64(
>> -					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
>> -									other_time));
>> -		close_json_object();
>> +		dump_mcast_querier_state(tb[IFLA_BR_MCAST_QUERIER_STATE]);
>>   	}
>>
>>   	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>> diff --git a/lib/bridge.c b/lib/bridge.c
>> index a888a20e..13b0d633 100644
>> --- a/lib/bridge.c
>> +++ b/lib/bridge.c
>> @@ -45,3 +45,59 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
>>
>>   	close_json_object();
>>   }
>> +
>> +void dump_mcast_querier_state(const struct rtattr *vtb)
> Stay consistent with the rest of lib/bridge.c and add bridge_ in front of the name.
> And maybe bridge_print_mcast_querier_state?
>
>> +{
>> +	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
>> +	const char *querier_ip;
>> +	SPRINT_BUF(other_time);
>> +	__u64 tval;
>> +
>> +	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
>> +	memset(other_time, 0, sizeof(other_time));
>> +
>> +	open_json_object("mcast_querier_state_ipv4");
>> +	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
>> +		querier_ip = format_host_rta(AF_INET,
>> +						bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
>> +		print_string(PRINT_FP, NULL, "%s ",
>> +				"mcast_querier_ipv4_addr");
> formatting is off, "mcast_querier_ipv4_addr" should start under PRINT_FP
> use tabs as much as possible (before going over) and if
> needed finish alignment with spaces, e.g.:
Hmm, for some reason my editor replaced the spaces with tabs when I 
copied Ido's proposal.
Did not notice that... Sorry. I'll send a new patch.
>
> 		querier_ip = format_host_rta(AF_INET,
> 					     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
> or
>
> 		print_string(PRINT_FP, NULL, "%s ",
> 			     "mcast_querier_ipv4_addr");
>
>> +		print_color_string(PRINT_ANY, COLOR_INET,
>> +					"mcast_querier_ipv4_addr", "%s ",
>> +					querier_ip);
> same about formatting
>
>> +	}
>> +	if (bqtb[BRIDGE_QUERIER_IP_PORT])
>> +		print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
>> +				"mcast_querier_ipv4_port %u ",
>> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> formatting
>
>> +	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
>> +		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
>> +		print_string(PRINT_ANY,
>> +				"mcast_querier_ipv4_other_timer",
>> +				"mcast_querier_ipv4_other_timer %s ",
>> +				sprint_time64(tval, other_time));
> formatting
>
>> +	}
>> +	close_json_object();
>> +	open_json_object("mcast_querier_state_ipv6");
>> +	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
>> +		querier_ip = format_host_rta(AF_INET6,
>> +						bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
>> +		print_string(PRINT_FP, NULL, "%s ",
>> +				"mcast_querier_ipv6_addr");
>> +		print_color_string(PRINT_ANY, COLOR_INET6,
>> +					"mcast_querier_ipv6_addr", "%s ",
>> +					querier_ip);
> formatting
>> +	}
>> +	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
>> +		print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
>> +				"mcast_querier_ipv6_port %u ",
>> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> formatting
>> +	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
>> +		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
>> +		print_string(PRINT_ANY,
>> +				"mcast_querier_ipv6_other_timer",
>> +				"mcast_querier_ipv6_other_timer %s ",
>> +				sprint_time64(tval, other_time));
> formatting
>
>> +	}
>> +	close_json_object();
>> +}
>> --
>> 2.39.5
>>
>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


