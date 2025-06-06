Return-Path: <netdev+bounces-195466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59DAD04EE
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7BAC7A4014
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7F13DBA0;
	Fri,  6 Jun 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="N8fpqdCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B902126C17
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222683; cv=none; b=lz1NbdH4AVXpfMPp7zBZJGadASSi8co5hGKc+TPjhQwClvvVKoi+PYDDUNxAQ2ABVFgeGwh4tvxzH6Ul1TQ3R12S2jyBDE4rsM4JhqlL5PM/NdiJ0ScyqjNMMnSgKkXxjLNwHj2TDbjNvjiwmYpQv1mmdOviRAeoDGYilIcSM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222683; c=relaxed/simple;
	bh=B+R73Exjeh0Xd99cKtD7I7KglHFjMxwv1OWHBPlof30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRvRhrZJggW3S8ezl4W/xb9wMvOMH8Hy9rZfacP+aWlzwojBm1x1muMetxUU8fHfcZTqKtCZtTCdapdAgqDbZFCqA8Ta6YyyRpq5QcCB9JkWXGFu+wL7x3VMkOADiIxP9ac6yOS1kqpisRBQ8ttVORIX8M0Us1BgwbmQzHsxHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=N8fpqdCa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-551fc6d4a76so2281956e87.0
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749222679; x=1749827479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itzGHGnOEeIfDPuTwt7H7T7bTkJezQTKebuH/HLY0ME=;
        b=N8fpqdCa9BUKB4f6K4+LZDjchpaEyLKXHi29CDTGQ/BpNYnhU+Vbg0XAohjdGJ2khb
         1QjmR7LYqvS+DFZRjScEI3JVlFg4DgBxPllOvVIPaWS+13V0t62FuLK6mITOOdffetjB
         675qIZ6K9FNFouEErkSN2rz+q9C1EW7KMV7UACUKvFo5T5D3zdpRJUzA2K/GB2LDIQfp
         tJEuozXbW/6puwtAKsMzi4R0E3j1g0sBdJcQNZFyY/n6JM2QfgkWf3pxknmqbRUdQXYq
         0PU7hRaav3RvNmx/7K4P4L3Mj45Hg5WFtjGd0080CdMTue9Brxusmm8el1HhA/SbVm+S
         Ok/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749222679; x=1749827479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itzGHGnOEeIfDPuTwt7H7T7bTkJezQTKebuH/HLY0ME=;
        b=K/jmLUuznJG2ubV7npeDy6IqUyUHWH3UI9WuWQ3EhSl/MgOtqfRSRvB4qQcII0r9lp
         l1AsVpggYLrc7dO/UFDwpZhpFdjuVEUCUySWBGHMMVU8Rmgm8Jz53kHdLMj3ONRnrYvB
         wJ01CAwhLAyb/Jwggc6r//8dO9O8h0afualFuerjB/8Gv8OvEPvUNkAaXhTIHQHoFe2o
         04N3yEjFUU0H+2VWd3Z6BLmtGErVXxGKSUImnFnHoom3p1mAelxrhBYNTdPjWiny5MTS
         KNo+NFr0inZktAO5U/VvODQsaGFOqui/r0psEjzg0UEoyBvNSgsY+LqIXdCcBkvoEjqj
         9ccA==
X-Gm-Message-State: AOJu0YzneOVhcAULSZFMlGM26QY1/4WqETfgJsCXpwZ+ZbyTDJ6RVk5Q
	+P//Jx1Z7Fe9K5qIKw7p8YrNo2xmN7xbw2fubgxITq/m3sYBcL3Aec9lUKhZ1KdBfs8=
X-Gm-Gg: ASbGnct9aB2ouW/9Scoq0xAXcAAT7zgZvZcBFeJoQiEWRwmuZz6ndgqhp9MA9zujnSU
	5JH6D0C/TSr2SGm3bPBE/PRBAmKj7V4oR85TuKstb0TguZVTn1s0xJ0+IQUxPyafmgMxZwgh8b7
	a+3VfXCvQG2/TVtwIG/f4I0xLORTgiC+D1pBi9utWusn10f+huPB2IiKPepnRdYy7y9QwtnpcL0
	7lj0UShC7kWk4aq6q7QW6A560Pa5bbhlaIP3sgW5eawGTi/k90mJ8xjKbIUx5ionN1hts80zpPv
	VDAak/qWE990rb6KferEUk9wtr4LA5pav+t5AAtKEhvlGCaHkHlk7In+yZV4PimAQB8lM7kjUAE
	i6qe7DZtAFHGIguJIPCHC3bMV97np9Jw=
X-Google-Smtp-Source: AGHT+IH2awoiSA6mm25bVWfOeGii4cBXCRrxouY2YcXrG3O4Hkw8GwGB2ald7tppyTjCgz13j9DL1w==
X-Received: by 2002:a05:6512:3c8b:b0:553:279b:c55d with SMTP id 2adb3069b0e04-55366c2ff61mr976974e87.45.1749222678724;
        Fri, 06 Jun 2025 08:11:18 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.185.kyiv.nat.volia.net. [176.111.185.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553676d7651sm207508e87.72.2025.06.06.08.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:11:17 -0700 (PDT)
Message-ID: <4c58aaf8-bd4c-45f9-bd0f-8bb9bac5efc0@blackwall.org>
Date: Fri, 6 Jun 2025 18:11:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: dump mcast querier state per vlan
To: Ido Schimmel <idosch@nvidia.com>,
 Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
 bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
References: <20250604105322.1185872-1-f.pfitzner@pengutronix.de>
 <aEFmoU9_ci0rqQTQ@shredder>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aEFmoU9_ci0rqQTQ@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 12:42, Ido Schimmel wrote:
> + Nik
> 

Thanks

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
> 
> Not sure it's appropriate to put this in lib. Given this duplication is
> not new (see ip/iplink_bridge_slave.c and bridge/link.c, for example)
> and that the code isn't complex, I would keep it as-is.
>

+1
just do what we've already been doing, copy what you need

Cheers,
  Nik
  
>>
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
> 
> Is there a reason for this misalignment and the overly long lines?
> How about something like [1] instead (compile tested only)?
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
> 
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


