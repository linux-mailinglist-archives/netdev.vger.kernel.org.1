Return-Path: <netdev+bounces-196565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625D2AD5532
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C6117F6F9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F295278165;
	Wed, 11 Jun 2025 12:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD078F34
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644125; cv=none; b=sbX/6xMcxhvBiUew5C8xkOvjdPeFnwMeEUe13PXvBVrW20PkLj4+qeQ+5xi8WHytwloeuLI7Lf+2u5lZ/vV1yH2ZStYJXkeVZQoaV4m3mi4v4N3wGOu7EG0dpBInY2st7omkiawtXmDhTmUOoh0Ym3du38q2h4NTfvs48264khg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644125; c=relaxed/simple;
	bh=ANm72Ell2Mcs7VfR4kBTV+tqXgsR0+Fzxi0xOPgxmU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8H3Fq79WpaQwNyF/2gW0Zy/JRb4O7SG3uC+zFzS9tTAKwCMfQ/8k19ZlFtdwEtGIt/G6q6A5nvEFuEoQ3TJ48ijV+ep/Ufjmq9TG7OnHOMevmcJL7v+fQ8rjW2GJLvXQGyNV8+03Ym8MTKP5hqUQZOJgxz7ukXzl9Bywft2iNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uPKMS-0004Ti-EM; Wed, 11 Jun 2025 14:15:20 +0200
Message-ID: <72a195be-b6c7-4d1a-8e3b-e3467ae4b2ea@pengutronix.de>
Date: Wed, 11 Jun 2025 14:15:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: dump mcast querier state per vlan
To: Ido Schimmel <idosch@nvidia.com>, razor@blackwall.org
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
 bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
References: <20250604105322.1185872-1-f.pfitzner@pengutronix.de>
 <aEFmoU9_ci0rqQTQ@shredder>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <aEFmoU9_ci0rqQTQ@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 6/5/25 11:42, Ido Schimmel wrote:
> + Nik
>
> On Wed, Jun 04, 2025 at 12:53:23PM +0200, Fabian Pfitzner wrote:
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
>> This patch is a bit redundant compared to [1]. It makes sense to put it
>> into a helper function, but i am not sure where to place this function.
>> Maybe somewhere under /lib?
> Not sure it's appropriate to put this in lib. Given this duplication is
> not new (see ip/iplink_bridge_slave.c and bridge/link.c, for example)
> and that the code isn't complex, I would keep it as-is.
>
>>   bridge/vlan.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/bridge/vlan.c b/bridge/vlan.c
>> index ea4aff93..b928c653 100644
>> --- a/bridge/vlan.c
>> +++ b/bridge/vlan.c
>> @@ -892,6 +892,64 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>>   		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>>   			   rta_getattr_u8(vattr));
>>   	}
>> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
>> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
>> +		SPRINT_BUF(other_time);
>> +
>> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
>> +		memset(other_time, 0, sizeof(other_time));
>> +
>> +		open_json_object("mcast_querier_state_ipv4");
>> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
>> +			print_string(PRINT_FP,
>> +				NULL,
>> +				"%s ",
>> +				"mcast_querier_ipv4_addr");
> Is there a reason for this misalignment and the overly long lines?
> How about something like [1] instead (compile tested only)?
Thanks. I tested your changes successfully.
Made a v2: 
https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/ 

>
>> +			print_color_string(PRINT_ANY,
>> +				COLOR_INET,
>> +				"mcast_querier_ipv4_addr",
>> +				"%s ",
>> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
>> +		}
>> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
>> +			print_uint(PRINT_ANY,
>> +				"mcast_querier_ipv4_port",
>> +				"mcast_querier_ipv4_port %u ",
>> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
>> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
>> +			print_string(PRINT_ANY,
>> +				"mcast_querier_ipv4_other_timer",
>> +				"mcast_querier_ipv4_other_timer %s ",
>> +				sprint_time64(
>> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
>> +									other_time));
>> +		close_json_object();
>> +		open_json_object("mcast_querier_state_ipv6");
>> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
>> +			print_string(PRINT_FP,
>> +				NULL,
>> +				"%s ",
>> +				"mcast_querier_ipv6_addr");
>> +			print_color_string(PRINT_ANY,
>> +				COLOR_INET6,
>> +				"mcast_querier_ipv6_addr",
>> +				"%s ",
>> +				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
>> +		}
>> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
>> +			print_uint(PRINT_ANY,
>> +				"mcast_querier_ipv6_port",
>> +				"mcast_querier_ipv6_port %u ",
>> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
>> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
>> +			print_string(PRINT_ANY,
>> +				"mcast_querier_ipv6_other_timer",
>> +				"mcast_querier_ipv6_other_timer %s ",
>> +				sprint_time64(
>> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
>> +									other_time));
>> +		close_json_object();
>> +	}
>>   	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>>   		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>>   		print_uint(PRINT_ANY, "mcast_igmp_version",
> [1]
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index ea4aff931a22..2afdc7c72890 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -892,6 +892,61 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>   		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>   			   rta_getattr_u8(vattr));
>   	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +		const char *querier_ip;
> +		SPRINT_BUF(other_time);
> +		__u64 tval;
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX,
> +				    vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +			querier_ip = format_host_rta(AF_INET,
> +						     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
> +			print_string(PRINT_FP, NULL, "%s ",
> +				     "mcast_querier_ipv4_addr");
> +			print_color_string(PRINT_ANY, COLOR_INET,
> +					   "mcast_querier_ipv4_addr", "%s ",
> +					   querier_ip);
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +			print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
> +				   "mcast_querier_ipv4_port %u ",
> +				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
> +			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
> +			print_string(PRINT_ANY,
> +				     "mcast_querier_ipv4_other_timer",
> +				     "mcast_querier_ipv4_other_timer %s ",
> +				     sprint_time64(tval, other_time));
> +		}
> +		close_json_object();
> +		open_json_object("mcast_querier_state_ipv6");
> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +			querier_ip = format_host_rta(AF_INET6,
> +						     bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
> +			print_string(PRINT_FP, NULL, "%s ",
> +				     "mcast_querier_ipv6_addr");
> +			print_color_string(PRINT_ANY, COLOR_INET6,
> +					   "mcast_querier_ipv6_addr", "%s ",
> +					   querier_ip);
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +			print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
> +				   "mcast_querier_ipv6_port %u ",
> +				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
> +			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
> +			print_string(PRINT_ANY,
> +				     "mcast_querier_ipv6_other_timer",
> +				     "mcast_querier_ipv6_other_timer %s ",
> +				     sprint_time64(tval, other_time));
> +		}
> +		close_json_object();
> +	}
>   	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>   		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>   		print_uint(PRINT_ANY, "mcast_igmp_version",
>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


