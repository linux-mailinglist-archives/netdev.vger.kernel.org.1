Return-Path: <netdev+bounces-199746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4AAAE1B1F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9933A4A5E1F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4AA28A735;
	Fri, 20 Jun 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mbJ99bY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757130E83F
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423447; cv=none; b=nYx9pvk88oGyXHCFcd+vN4ByHJ6BlAqadLVCOm4AbuJFaE74YYQ1/g4vPh5RN0So/olRxwexxIRY0+KrHzYGfWDkCfEPhyfoqmJTU3YbnuOMQKqaFJu6xEfwHizFlVQXdeJLdOxOMIgde5Ia4aPI8svBbYe/XAUnY90z3REmEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423447; c=relaxed/simple;
	bh=Q7AJCTZ5rLCW4KFJK07/psNA/meUZ4daYdiWK+pUJ7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBA2zQdxEkO6LEzX6oIPiufoS/8//wpg0YoVedgER+lwHD3IZXU1f9YMsHnElJePqwmDWH43sp1KPyvlq4BiFgVUSHGfZTQfNUEgtndqOlnlVVYi5nihIoZebXLTlvx+EL6jT8fRJ2yCVPpg3K1LD6TGziAnFLtOy8zyAZljxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mbJ99bY6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so3208461a12.3
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750423444; x=1751028244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EG9FcB8Q0IvOTBGOenT1zDNKlCLORzQAxF8MGgqcv4=;
        b=mbJ99bY6CxxalY9pk+Y1MODoq40VTBibmqcmhMTts2rXV7yoKDWjG1+fiOi3BId9T6
         DzooAiPCrzjyairn8XArYY8vsj9zrS1L7vm0ZaiIALO82wA/wF3wKlQ9/7+rlc/80Fuu
         FBoukprDuOqmC01xWHwodC5ZBAEHEY62+XtRKkHf+kLmHyMAbDCS7IdKAXZEMXVM8hun
         yQaazmwoWtc2+Sh8sK752Ix2PoZSC5xLdfCf898o75i2N1LlLoXW0FqPkY/qhOqqHiX5
         ipU2Zl7wFQ2sNz15ECXI1zHr0t4HaautU50d3zLoD6vUfQtCTXru3BZhoXxprkhv3d8a
         M5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750423444; x=1751028244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EG9FcB8Q0IvOTBGOenT1zDNKlCLORzQAxF8MGgqcv4=;
        b=ceEzUOlCJ6BldS5o9LJKWXw8Q+dhthMdhd9DJoXVLq11F8PWwuDay4P/46B4jiwOGV
         e5UKUBYZsdBi3J8j/q3X2/a2CnhdvtnZ/hVsfkSYRvqtLFSsqlT86Ua3t/zgdgrirl8K
         VrnGFzP+v7cdCCjTzs5N5hyQ+B0idaggEyQ6HLPLTQtX0IFfAVoZoKkIqy574O+ajVhJ
         3UHdwGqlTVskkHMKUsX/qb933E2tle7kXIdkABhHklGVA2bPvGIDcHER0eMCR3jCEbtO
         bahemq16IptnWEAY4NVH0MLIKEmJB0ptfhjRe/hk4LOU2GSMtjqWeRCbGl+Ta4Ckacme
         5bBw==
X-Forwarded-Encrypted: i=1; AJvYcCUrnAW0nHpfM2kdIe0cl4QG1T+65ZtuGSjWX8ow8SHNlncKuXyBoA7QYkVoOtrmlyonNF5oESk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEcz39m7FF8bsNpkEYmvBWF3yiU8IW7PNYbTPeK2qdai/djGeZ
	/fxEeSNMvssu5tCjHo2+SPW9rbWkitsubO/U4lCjmEpxp/G7v5/8HyGimKuzXqEgcww=
X-Gm-Gg: ASbGncvL86uasYFHSpxtgA3wAe9ciHjFCpiKVjK1cm0e2hr+Ikte4NL7pRKe/ja8FKU
	khNW55nbn+GQTPHmYIqEal23gISJVyTDYcdEZNIS/CRNdBqWHoboNrIA2f3SIDuyH4VNJYUR81Y
	YcL1GZPX+tI83xsx4jIYIK0nCwpB3FFDIAQJ2tBHaNMl6+Qt0sSdhU7jqXIHu7BgleidoXuz6Nc
	+xzx5LBbQLo+x+XRS/new62ZKiIM2vDocDzisLyS3UpMLBDUjrvVBsiYxV8+0knZl4THLMt4OYG
	qJMajg5OvE8m/RAxsci8yYaGlItP+JgW5c6k6/daFW+q+82lBNOuOWyTN0sonwF4TbmWyXKOb+w
	+Wpza6EjOhaA/aXWGKQ==
X-Google-Smtp-Source: AGHT+IHXpQOnRW/S/YtZ5szU+d2WggG4z/q062bO8tBuw5oUwTLDA+GgY3DAtOvQndTO40pBMTYz4Q==
X-Received: by 2002:a17:907:6d17:b0:ae0:13e5:1883 with SMTP id a640c23a62f3a-ae057b89b6bmr249393566b.40.1750423443324;
        Fri, 20 Jun 2025 05:44:03 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b752asm156141766b.127.2025.06.20.05.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 05:44:02 -0700 (PDT)
Message-ID: <d8d5a8f4-33a8-4a62-b48e-fb82b8de245b@blackwall.org>
Date: Fri, 20 Jun 2025 15:44:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bridge: dump mcast querier state per vlan
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 15:16, Fabian Pfitzner wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> The options for vlan filtering and vlan mcast snooping have to be enabled
> in order to see the output:
> 
> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
> 
> v2->v3
> 	- move code into a shared function
> 	- use shared function in bridge and ip utility
> 	- link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
> ---
>  bridge/vlan.c      |  3 +++
>  include/bridge.h   |  3 +++
>  ip/iplink_bridge.c | 57 +---------------------------------------------
>  lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+), 56 deletions(-)
> 

Hi,
The subject should contain the target for this patch which is iproute2-next,
e.g. [PATCH iproute2-next v3]. Since there would be another version, I'd split
it in 2 patches - 1 that moves the existing code to lib/bridge.c and the second
which adds the vlan querier print code.

Also a few comments below..

> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index 14b8475d..0233eaf6 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -852,6 +852,9 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>  		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>  			   rta_getattr_u8(vattr));
>  	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		dump_mcast_querier_state(vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);

Add a local variable for the attribute and make this line shorter (<= 80chars).

> +	}
>  	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>  		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>  		print_uint(PRINT_ANY, "mcast_igmp_version",
> diff --git a/include/bridge.h b/include/bridge.h
> index 8bcd1e38..9e9447c6 100644
> --- a/include/bridge.h
> +++ b/include/bridge.h
> @@ -3,9 +3,12 @@
>  #define __BRIDGE_H__ 1
> 
>  #include <linux/if_bridge.h>
> +#include <linux/rtnetlink.h>
> 
>  void bridge_print_vlan_flags(__u16 flags);
>  void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
>  void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);
> 
> +void dump_mcast_querier_state(const struct rtattr* vtb);
> +
>  #endif /* __BRIDGE_H__ */
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 31e7cb5e..68a277ef 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -682,62 +682,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
> 
>  	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> -		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> -		SPRINT_BUF(other_time);
> -
> -		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
> -		memset(other_time, 0, sizeof(other_time));
> -
> -		open_json_object("mcast_querier_state_ipv4");
> -		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> -			print_string(PRINT_FP,
> -				NULL,
> -				"%s ",
> -				"mcast_querier_ipv4_addr");
> -			print_color_string(PRINT_ANY,
> -				COLOR_INET,
> -				"mcast_querier_ipv4_addr",
> -				"%s ",
> -				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
> -		}
> -		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> -			print_uint(PRINT_ANY,
> -				"mcast_querier_ipv4_port",
> -				"mcast_querier_ipv4_port %u ",
> -				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> -		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
> -			print_string(PRINT_ANY,
> -				"mcast_querier_ipv4_other_timer",
> -				"mcast_querier_ipv4_other_timer %s ",
> -				sprint_time64(
> -					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
> -									other_time));
> -		close_json_object();
> -		open_json_object("mcast_querier_state_ipv6");
> -		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> -			print_string(PRINT_FP,
> -				NULL,
> -				"%s ",
> -				"mcast_querier_ipv6_addr");
> -			print_color_string(PRINT_ANY,
> -				COLOR_INET6,
> -				"mcast_querier_ipv6_addr",
> -				"%s ",
> -				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
> -		}
> -		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> -			print_uint(PRINT_ANY,
> -				"mcast_querier_ipv6_port",
> -				"mcast_querier_ipv6_port %u ",
> -				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> -		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
> -			print_string(PRINT_ANY,
> -				"mcast_querier_ipv6_other_timer",
> -				"mcast_querier_ipv6_other_timer %s ",
> -				sprint_time64(
> -					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
> -									other_time));
> -		close_json_object();
> +		dump_mcast_querier_state(tb[IFLA_BR_MCAST_QUERIER_STATE]);
>  	}
> 
>  	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
> diff --git a/lib/bridge.c b/lib/bridge.c
> index a888a20e..13b0d633 100644
> --- a/lib/bridge.c
> +++ b/lib/bridge.c
> @@ -45,3 +45,59 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
> 
>  	close_json_object();
>  }
> +
> +void dump_mcast_querier_state(const struct rtattr *vtb)

Stay consistent with the rest of lib/bridge.c and add bridge_ in front of the name.
And maybe bridge_print_mcast_querier_state?

> +{
> +	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +	const char *querier_ip;
> +	SPRINT_BUF(other_time);
> +	__u64 tval;
> +
> +	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
> +	memset(other_time, 0, sizeof(other_time));
> +
> +	open_json_object("mcast_querier_state_ipv4");
> +	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +		querier_ip = format_host_rta(AF_INET,
> +						bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
> +		print_string(PRINT_FP, NULL, "%s ",
> +				"mcast_querier_ipv4_addr");

formatting is off, "mcast_querier_ipv4_addr" should start under PRINT_FP
use tabs as much as possible (before going over) and if
needed finish alignment with spaces, e.g.:

		querier_ip = format_host_rta(AF_INET,
					     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
or

		print_string(PRINT_FP, NULL, "%s ",
			     "mcast_querier_ipv4_addr");

> +		print_color_string(PRINT_ANY, COLOR_INET,
> +					"mcast_querier_ipv4_addr", "%s ",
> +					querier_ip);

same about formatting

> +	}
> +	if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +		print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
> +				"mcast_querier_ipv4_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));

formatting

> +	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
> +		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
> +		print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_other_timer",
> +				"mcast_querier_ipv4_other_timer %s ",
> +				sprint_time64(tval, other_time));

formatting

> +	}
> +	close_json_object();
> +	open_json_object("mcast_querier_state_ipv6");
> +	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +		querier_ip = format_host_rta(AF_INET6,
> +						bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
> +		print_string(PRINT_FP, NULL, "%s ",
> +				"mcast_querier_ipv6_addr");
> +		print_color_string(PRINT_ANY, COLOR_INET6,
> +					"mcast_querier_ipv6_addr", "%s ",
> +					querier_ip);
formatting
> +	}
> +	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +		print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
> +				"mcast_querier_ipv6_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
formatting
> +	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
> +		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
> +		print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_other_timer",
> +				"mcast_querier_ipv6_other_timer %s ",
> +				sprint_time64(tval, other_time));

formatting

> +	}
> +	close_json_object();
> +}
> --
> 2.39.5
> 


