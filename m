Return-Path: <netdev+bounces-200180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF61AE3971
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 11:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DB7175525
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA3A22F74E;
	Mon, 23 Jun 2025 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tA9tnhD6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1A1F30BB
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669600; cv=none; b=D7ddqSyDtjeXdK+B4B13nniGqiq/6HJgM1yN9CyUGZZ1Zt0yC4Yc4WY47eG6e0++I7jzon62sUaK/RTiMGizNy6iDapqSn0tvyFwp9LHcLP/q9H70mTJgA9sv2eOxbsJH2Q4Md9uk5Ya2azytEMN3WZZ4pXxaP7Ph1bcUvzO1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669600; c=relaxed/simple;
	bh=NplCcx7sOXvlDjDGShpLbLZzNcDPmjan4xA+/QRgM+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB40kiwdEYVt+mvP8xwxwUbUNaWXytNW1orbVYWKFGK7IvRODUo3ExnnktA1Yub1uReD2Qgtvblj8sFotKW1DeE3kxbS2hY7fVzl4TdneuwP0lC0AqsMVumD3YXh/sS28ZkP/y0QXU7XWS8bx48JxzAuLCVTPjfrnjwwSL6kEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=tA9tnhD6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so7366179a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750669597; x=1751274397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ey45mjsLzFT2alZQ43V/e5P4ouEuI9k+6FzGtpkIa8o=;
        b=tA9tnhD6b5DTBr+bbLYUyVzpBKA7hAhGX9f9fzoyV+6zBf1ZIdCtn765Z+rz3VbLcV
         1ihPqqlbPnfBwSF675PMBQwWcd2u23j2JO2goXhrckl6EPIyVhAb70Ycj0djTCDsswN7
         pLjRJP744JuuXQZFn5Li8EsuHT6ytG4z3BeYL7n+paKA6cpq7koSyLUVr6KGbVsJyziG
         2IcjTyvtGOcY+I8U1dfdLKpiP7uv/BRx5JCxMA/9zQNJMPAZH3fQ3/X6beDvx8B1Y0te
         ZOROYXMzVc/tfihzrZ8p4YXLy6Rzgve/cXuD6WId69NweNh16Tij3lheOTbiAP1TrPMw
         5O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669597; x=1751274397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey45mjsLzFT2alZQ43V/e5P4ouEuI9k+6FzGtpkIa8o=;
        b=IUU5quj5vwjrmynFsttlxjyIVd52X3vBPpbyji9ZBLyR7oJLClMlLaN5lwUR4aN55I
         DBvqWksWdSl6AHPJu91cfYSpMqSbXJOEeidwgEd7svD65v303Cvc4cR6CejNs9+7bqs7
         b365DbFdHDIGarGzfu06g8ZiJpnt19aK9YVyqX2t4YJTbUPJv98bF6vrtL2I6B9GzJ5R
         cvi0UkLnbh/94Bi9JV/7SLCDb6olBoR2ywMRD49Z4Xy32Ene2952mF40pK3wzZKWWC4C
         +SzTZJqHZ/QhkvFjsPhP309c9WcQiRN5i7FUu52elFrqSHLRK33hmBPLIDJMGsjtd2Ce
         5NVg==
X-Forwarded-Encrypted: i=1; AJvYcCX4Jvpjtnyx8j27wTJkx0Zw/+KfDs229x6v6USUrVc6UxA9QpjNc7tPtTZblFigD8kwf1trXmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLW+ToSGe/zyDb8mm5M+NoodqmsX3NiBvB65de+w/JPSEtvUu
	0MR6KcCGNYp4Jh0HbCtR7jpDHvhsI+/M/KstTIL0ahAhyOZYYhP1d5zimM+5JJzUxTM=
X-Gm-Gg: ASbGnctI2bXBjhLjqHddEfa/PLBSgpqhj3U2DfxXIoDHxDww3Zn8azeO5ro3rbvpiF0
	jIeg8NIEXlJnJJ9xaNOVzd3R8GS9Ck/ZlgIoaU9zhTMxRsoTd5xtkn4/0b0DsGc4dGkimrW/Uhk
	9MpzvU5lPz2c0fN6iXG7A1Ohs1crv/MiG2rsodc7XU77gfnlQSkfxOfRbVJwe0X0VS4mXMzDoN4
	RZ0FffvrPq88LQ00Uiy/B0oRS203/+5Nl80H73TXop9YXWWmlx1r93LQrxFYmrHmfQLwtN7HwzK
	JpDq28cJVgO7oazxO7RxIGUXeyL66Wt5DZfMO8n8n2uvK83oRjNnlVDl/BOMrvVghoW7axIG3HC
	TnWPhQMtZoYCGYfFfKA==
X-Google-Smtp-Source: AGHT+IFGuDV0WJYvzUIRo4zGv+/lfxQm1RgBphY+vdx+pduqP9EOGUI2FTqk9mV29+Pn1Tk6nwgVgw==
X-Received: by 2002:a05:6402:28a8:b0:606:c5f9:8aea with SMTP id 4fb4d7f45d1cf-60a1cd1d83amr8899589a12.16.1750669596719;
        Mon, 23 Jun 2025 02:06:36 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18542a3esm5761882a12.23.2025.06.23.02.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:06:35 -0700 (PDT)
Message-ID: <ca883bc3-84e7-4ff9-81fa-cc7755b2bdb7@blackwall.org>
Date: Mon, 23 Jun 2025 12:06:34 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v4 1/3] bridge: move mcast querier dumping
 code into a shared function
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
 <20250623084518.1101527-2-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623084518.1101527-2-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 11:45, Fabian Pfitzner wrote:
> Put mcast querier dumping code into a shared function. This function
> will be called from the bridge utility in a later patch.
> 
> Adapt the code such that the vtb parameter is used
> instead of tb[IFLA_BR_MCAST_QUERIER_STATE].
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> I decided to not only move the code into a separate function, but also
> to adapt it to fit into the function. If I split it into a pure refactoring
> and an adapting commit, the former will not compile preventing git bisects.
> 
>  include/bridge.h   |  3 +++
>  ip/iplink_bridge.c | 58 ++------------------------------------------
>  lib/bridge.c       | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 56 deletions(-)
> 
> diff --git a/include/bridge.h b/include/bridge.h
> index 8bcd1e38..b2f978f4 100644
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
> +void bridge_print_mcast_querier_state(const struct rtattr* vtb);
> +
>  #endif /* __BRIDGE_H__ */
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 31e7cb5e..4e1f5147 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -682,62 +682,8 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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
> +		struct rtattr *vtb = tb[IFLA_BR_MCAST_QUERIER_STATE];
> +		bridge_print_mcast_querier_state(vtb);
>  	}
> 
>  	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])

Please run checkpatch against the patches before sending them.

WARNING: Missing a blank line after declarations
#175: FILE: ip/iplink_bridge.c:685:
+		struct rtattr *vtb = tb[IFLA_BR_MCAST_QUERIER_STATE];
+		bridge_print_mcast_querier_state(vtb);




