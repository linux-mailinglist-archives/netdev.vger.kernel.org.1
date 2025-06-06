Return-Path: <netdev+bounces-195469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD00AD0538
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388C8174BC8
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AE14F104;
	Fri,  6 Jun 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vOTwQrp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EE76026
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223944; cv=none; b=CS05EN5OK/Qe68VVD/R7Vt8QmrAbw8BnbEVb3/2Jc9bFATmLjW9TY//bNnz/1IFQHMDFw2RkJiD/HlWNq7F6UWqqdeHp1Ev9wue7rPd4WCCHE/guS+glI5Yw9ZtY6DkFbx3suESHer2HTjySAg46nJuHnpNvoW4pZKAkXlvHsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223944; c=relaxed/simple;
	bh=zZ/XSyk1z6lGCNVa7psQFj9g2yrERWD9C1btTseUfJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8crw6llaPTzzZs3JmNsbd6eNwnI+K08gCwZwm3eX6/9vPPDTWEEw4Pg7qet8037gN4ALCTdgM/pvVJLi+MVilMm+dyLQLUamEJqyw/O80z87Y0hNqftKHJvT+W6LVF5ye+Whuzh49vrmrL/I0C+Yn7i0P2ELyJHjldB59VhGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vOTwQrp+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so20386861fa.0
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749223938; x=1749828738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptTubaHs6F0tOFTUEqppwJQTcLhSKYj91WPsm4hKTeg=;
        b=vOTwQrp+oP70Dd9l+eGmRnBij4efFGG9eyCjT/OMgYozlyDKq+NFBhFWrmBZqnDJZi
         nsLpGEMlbv/HHj4uYutd9pt6FAgTxoLegNHZrI02J/AbCVnilQN1PB+W3OIKulYKuFJj
         In4tFDSmdCRK45DKZJ1LOc8yO3MO7NT2opoTt0/ef5wZ9txpqxrj0uu8nLlxz6Ouj3yK
         CQ2Ptule413MOExTVNo5GmQrgTGHuQviKa56Np2xxZB7M1BbipY04XpJJL4Ubt6BFo+y
         K6rGWc0jQ5f7ydT2VmPyBaGJV3CfikloSSYgD7GTjgxFo1mdTBvGpaUn/CbBCe+/yGi+
         GJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749223938; x=1749828738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptTubaHs6F0tOFTUEqppwJQTcLhSKYj91WPsm4hKTeg=;
        b=eUwDCI34ilPVpkgvaXOYG1qA0rEDNThoHj/sXyf2K7P6X/hLvbksLae9iE6XEjuB0R
         AhyZrsDw0zA1kJYYdw+tFhZhxYnWfSBlUlPXYLHuQwEi3BVFOWVuxwp0qvt1HdNkamMD
         gp5jD5JlHfI0r+IxixF05kmieX9+/U9FSx3/cS51pOLCfZu82hKFZGhWpgVLc3idszyf
         9GIUtta8/+Ewqnhzamt56Uda0vhzDnlGK4EoFdt62+K2PkWKd3zIgqupMOhSyz/7TJqC
         gMrHpSbLaGA4NEwGE4VOWqQi8WuGEqoV3vA+yvXQjuJeTzZB0OGD08UDaAzn3yJTH0bl
         8TpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX9th9EGW8eZp648G6/JtLwxLKZqTDpEcREKtSh3aoKK6p+F9qc2BM+uDhij8IOhSZ9wLsWKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdfutGtx8SmTvj4a0nIkQ5ytFq1dj7YIdiFvRHrEQSkYB6DBv
	/JV4sUqDvwPnaIoMXGBVOeWIrsfY51RpjD8TfoA5a2EZUVvwSI/jwwompzfs27RPy0QiYWfcFQV
	p7zQG
X-Gm-Gg: ASbGncvxeASIudpRZmjYqpb1wWEPHZK6m8Hg8c53QlloAHcvtombR4IxH3NZtELVPn2
	yRpItA0ZRbEoTe3UxoXkHJVjhIQfMrR82I1Bg/psT5AksprKEwuooFaTFth34YApOX+hOs1AQe1
	UZVbHIq9j7MNcitn8O2pMlkle+Md8ipMVimydJsso9qRQ55ZrlI6cp9uVKDyOZGklNUCT1g6j2z
	NWZ8qULokIK6FkfqlCYJRoZxzxamSA6kU+sZMRZh54lKV2DcuinjUIj6icDNLBsVmD217KjxL5F
	72ot0IrX00zoixAhTeZPN/L+guVNXZgoazRk20H+Lm4KgDCUL7OuYOUpy0vPI8emRqFgoZgVxK1
	4KYtgNkuKFYEApVX5vKhD0FTyOOwDuGE=
X-Google-Smtp-Source: AGHT+IEOgyKjn+GJZzYRSeNDrTLNgk6sFYD4wN1ihgkalKovrX7EyLPRFRRhwo1dEPW9uk8NDS5ejA==
X-Received: by 2002:a2e:9b04:0:b0:308:f0c9:c4cf with SMTP id 38308e7fff4ca-32adfc2d652mr10580261fa.33.1749223937529;
        Fri, 06 Jun 2025 08:32:17 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.185.kyiv.nat.volia.net. [176.111.185.185])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1ccc311sm2127191fa.76.2025.06.06.08.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:32:14 -0700 (PDT)
Message-ID: <90f37ee7-fd3b-4807-aff7-313a07327901@blackwall.org>
Date: Fri, 6 Jun 2025 18:32:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 3/4] lib: bridge: Add a module for
 bridge-related helpers
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>
References: <cover.1749220201.git.petrm@nvidia.com>
 <5cc3cf81133b2f1484fbdadd29dc3678913ce419.1749220201.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <5cc3cf81133b2f1484fbdadd29dc3678913ce419.1749220201.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/25 18:04, Petr Machata wrote:
> `ip stats' displays a range of bridge_slave-related statistics, but not
> the VLAN stats. `bridge vlan' actually has code to show these. Extract the
> code to libutil so that it can be reused between the bridge and ip stats
> tools.
> 
> Rename them reasonably so as not to litter the global namespace.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>   bridge/vlan.c    | 50 +++++-------------------------------------------
>   include/bridge.h | 11 +++++++++++
>   lib/Makefile     |  3 ++-
>   lib/bridge.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 65 insertions(+), 46 deletions(-)
>   create mode 100644 include/bridge.h
>   create mode 100644 lib/bridge.c
> 

lol, Ido didn't we just have a discussion in another thread about adding
a bridge lib? :-)

https://www.spinics.net/lists/netdev/msg1096403.html

I'm not strictly against adding a lib, I think this approach might
actually save us from the tools going out of sync and we can avoid
repeating to people they have to update both places when they forget.

Cheers,
  Nik

> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index ea4aff93..14b8475d 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -15,6 +15,7 @@
>   #include "json_print.h"
>   #include "libnetlink.h"
>   #include "br_common.h"
> +#include "bridge.h"
>   #include "utils.h"
>   
>   static unsigned int filter_index, filter_vlan;
> @@ -705,47 +706,6 @@ static int print_vlan(struct nlmsghdr *n, void *arg)
>   	return 0;
>   }
>   
> -static void print_vlan_flags(__u16 flags)
> -{
> -	if (flags == 0)
> -		return;
> -
> -	open_json_array(PRINT_JSON, "flags");
> -	if (flags & BRIDGE_VLAN_INFO_PVID)
> -		print_string(PRINT_ANY, NULL, " %s", "PVID");
> -
> -	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
> -		print_string(PRINT_ANY, NULL, " %s", "Egress Untagged");
> -	close_json_array(PRINT_JSON, NULL);
> -}
> -
> -static void __print_one_vlan_stats(const struct bridge_vlan_xstats *vstats)
> -{
> -	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
> -	print_lluint(PRINT_ANY, "rx_bytes", "RX: %llu bytes",
> -		     vstats->rx_bytes);
> -	print_lluint(PRINT_ANY, "rx_packets", " %llu packets\n",
> -		     vstats->rx_packets);
> -
> -	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
> -	print_lluint(PRINT_ANY, "tx_bytes", "TX: %llu bytes",
> -		     vstats->tx_bytes);
> -	print_lluint(PRINT_ANY, "tx_packets", " %llu packets\n",
> -		     vstats->tx_packets);
> -}
> -
> -static void print_one_vlan_stats(const struct bridge_vlan_xstats *vstats)
> -{
> -	open_json_object(NULL);
> -
> -	print_hu(PRINT_ANY, "vid", "%hu", vstats->vid);
> -	print_vlan_flags(vstats->flags);
> -	print_nl();
> -	__print_one_vlan_stats(vstats);
> -
> -	close_json_object();
> -}
> -
>   static void print_vlan_stats_attr(struct rtattr *attr, int ifindex)
>   {
>   	struct rtattr *brtb[LINK_XSTATS_TYPE_MAX+1];
> @@ -783,7 +743,7 @@ static void print_vlan_stats_attr(struct rtattr *attr, int ifindex)
>   			print_string(PRINT_FP, NULL,
>   				     "%-" textify(IFNAMSIZ) "s  ", "");
>   		}
> -		print_one_vlan_stats(vstats);
> +		bridge_print_vlan_stats(vstats);
>   	}
>   
>   	/* vlan_port is opened only if there are any vlan stats */
> @@ -1025,7 +985,7 @@ static void print_vlan_opts(struct rtattr *a, int ifindex)
>   		print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
>   	}
>   	print_range("vlan", vinfo->vid, vrange);
> -	print_vlan_flags(vinfo->flags);
> +	bridge_print_vlan_flags(vinfo->flags);
>   	print_nl();
>   	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
>   	print_stp_state(state);
> @@ -1051,7 +1011,7 @@ static void print_vlan_opts(struct rtattr *a, int ifindex)
>   	}
>   	print_nl();
>   	if (show_stats)
> -		__print_one_vlan_stats(&vstats);
> +		bridge_print_vlan_stats_only(&vstats);
>   	close_json_object();
>   }
>   
> @@ -1334,7 +1294,7 @@ static void print_vlan_info(struct rtattr *tb, int ifindex)
>   		open_json_object(NULL);
>   		print_range("vlan", last_vid_start, vinfo->vid);
>   
> -		print_vlan_flags(vinfo->flags);
> +		bridge_print_vlan_flags(vinfo->flags);
>   		close_json_object();
>   		print_nl();
>   	}
> diff --git a/include/bridge.h b/include/bridge.h
> new file mode 100644
> index 00000000..8bcd1e38
> --- /dev/null
> +++ b/include/bridge.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __BRIDGE_H__
> +#define __BRIDGE_H__ 1
> +
> +#include <linux/if_bridge.h>
> +
> +void bridge_print_vlan_flags(__u16 flags);
> +void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
> +void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);
> +
> +#endif /* __BRIDGE_H__ */
> diff --git a/lib/Makefile b/lib/Makefile
> index aa7bbd2e..0ba62942 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -5,7 +5,8 @@ CFLAGS += -fPIC
>   
>   UTILOBJ = utils.o utils_math.o rt_names.o ll_map.o ll_types.o ll_proto.o ll_addr.o \
>   	inet_proto.o namespace.o json_writer.o json_print.o json_print_math.o \
> -	names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o ppp_proto.o
> +	names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o \
> +	ppp_proto.o bridge.o
>   
>   ifeq ($(HAVE_ELF),y)
>   ifeq ($(HAVE_LIBBPF),y)
> diff --git a/lib/bridge.c b/lib/bridge.c
> new file mode 100644
> index 00000000..0a46b6a2
> --- /dev/null
> +++ b/lib/bridge.c
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <net/if.h>
> +
> +#include "bridge.h"
> +#include "utils.h"
> +
> +void bridge_print_vlan_flags(__u16 flags)
> +{
> +	if (flags == 0)
> +		return;
> +
> +	open_json_array(PRINT_JSON, "flags");
> +	if (flags & BRIDGE_VLAN_INFO_PVID)
> +		print_string(PRINT_ANY, NULL, " %s", "PVID");
> +
> +	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
> +		print_string(PRINT_ANY, NULL, " %s", "Egress Untagged");
> +	close_json_array(PRINT_JSON, NULL);
> +}
> +
> +void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats)
> +{
> +	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
> +	print_lluint(PRINT_ANY, "rx_bytes", "RX: %llu bytes",
> +		     vstats->rx_bytes);
> +	print_lluint(PRINT_ANY, "rx_packets", " %llu packets\n",
> +		     vstats->rx_packets);
> +
> +	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
> +	print_lluint(PRINT_ANY, "tx_bytes", "TX: %llu bytes",
> +		     vstats->tx_bytes);
> +	print_lluint(PRINT_ANY, "tx_packets", " %llu packets\n",
> +		     vstats->tx_packets);
> +}
> +
> +void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
> +{
> +	open_json_object(NULL);
> +
> +	print_hu(PRINT_ANY, "vid", "%hu", vstats->vid);
> +	bridge_print_vlan_flags(vstats->flags);
> +	print_nl();
> +	bridge_print_vlan_stats_only(vstats);
> +
> +	close_json_object();
> +}


