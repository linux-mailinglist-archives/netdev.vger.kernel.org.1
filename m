Return-Path: <netdev+bounces-151347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F89EE4AE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E122828D0
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A2210F47;
	Thu, 12 Dec 2024 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Gwf37Kv8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA71EC4D2
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001497; cv=none; b=UYxAF+L7ohi44HsqWkZKr/UXig61p+gS8n16J1dNxC39uB+d4kMfX3qbjihAvzgqpGSEoTw/xJiYm0MDkAicX4SqgqGAcgAp2CEtgIgdlCCGaYR2cnQIuoZQG+p2nM74UhDiyXHnaD0P115/OfP4MkYTsyb/9sUX6K1G9FZwysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001497; c=relaxed/simple;
	bh=3LoECToaAO1us1lNLhLHI4a+XL3SJL8jIA2LmdigVVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUWgIVWM3iZuBr5GB7erXVBUJDnIuPDIijlfPCEZkq/9l0XxD5GXe/v0dD0olhKY+g5ca+tBH3OOs70ve9D7PsNjQRn1Eq2IFLq0TT9DgfJSNzvo1ouhcMUWQc2cjpVGJKl0Mh0cMcFPmOwG4d5gKMO9pcUPGUdoWp3GPbQtIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Gwf37Kv8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so61477766b.1
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 03:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734001494; x=1734606294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqiC1sBrXF/9+8aXy6G6XjlIZQN7Op5ZoQNj2VOvs4U=;
        b=Gwf37Kv8LSoI7z/54ImJyhdOCmQvSfTqzvxyWvKBOyC8nmxXgU43vUe1h8SzTPgCNU
         ijk7C33CRlRC+sTXRNn/vla9X/LLUdB06brUadmAv9GlY0ud09+AM+CFwAtc+J+L7uJB
         y9lntoMYCrj20Uey3J9xcgX4TP7TqVEJ2RnIe+y83gR1GYGQK9Enyggn30Tf86sBgHWc
         bO0La7PZhG9x5uI3AxNi+hBYIPHxUkDhDaK/3BwnMgb5HuHMUI2B3znKz35+Hnbw7Vg+
         oqqtpn5OynMNf/u1MF956MH9qfDCpNX5u6uLsOR6M4J6akM1X0AxZpwJZoVNwG98hci6
         iGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001494; x=1734606294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqiC1sBrXF/9+8aXy6G6XjlIZQN7Op5ZoQNj2VOvs4U=;
        b=A2fcPydrvq+P2Zq9erpPDLSdIFbbUr6v9GsElE6Ed8iNyv+C9X73AcPXVCvnq5chQU
         5LXHBMLFN0Alb11jEh5fplFfE/e64hGwansZBl0dQiUfhPo+yAtBTxKau/bKk8s6PFro
         s/RzjeyTek/lKaMip3EHmGLRr/iaG0hLSJAGHkpEh1sxmplYoULFXk2oLcCnj/4d9s/n
         cZ1cjOkTB3/IRxrAJ2BcKJQfG3xhCWFLoGaDgby2Gu4ft6E7L7pCP0L0Sn7nNchPYFN/
         6QwCV5WevTMhZyI6+heVMLNQ24an/7+08zxqqnHMmZcTbmWSkRcoKRES034jEkCdYSH3
         G9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1eKwfiQNFQpDl1oHpRmOHZQUJfI9zYPhmMpStZQvAOCM3yQtzirCNw9f9LPr5fVpif3T05ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw972CU1YSc5Kz6etkDaL2BfCvEDS8/b4YqRrrEzowhzmv6/JRP
	GgAJkpbWi7fDFyAzCGTSm7M/KIA4KeB1JCwCDSSM2/ZbdWgcf1iabiMaX6iK2OsLwJqEgVV0BIe
	U
X-Gm-Gg: ASbGncssMJyzwNZon+X1QncwFJLfI3Zv+YoJlPtZHYRe2HecL8iPEL9CTYuJVQQEqnj
	ly0lHYAM0pRSzhV6WZo4N/A+NIGukoj/cq5BpAU71X2iJS7XWF3rzECi4r/PovxFzFNUYHfIGn4
	tvfy9B6YgvviTn0uIhEd3PEupgCbZJP0P97C2hzCdhBFWxNp2QXfE18X2QZHrfrpxPtiqYcDrro
	zmmohxubXK39vKsGDC3y85SPBerYw3riilCsyBdsx47u/3vJwzX3Zse1u0=
X-Google-Smtp-Source: AGHT+IFlaB5RZ24gUCVv8qgpzRSTZkltDq8S7WcmZLXJR4d0ofItD6HR1+fUdJYRvRlPRI9Kj+5zMg==
X-Received: by 2002:a17:906:31cc:b0:aa6:93c4:c68c with SMTP id a640c23a62f3a-aa6b13964d1mr688528766b.41.1734001493608;
        Thu, 12 Dec 2024 03:04:53 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6761d0ab3sm685087266b.201.2024.12.12.03.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 03:04:53 -0800 (PST)
Message-ID: <0e97175f-7713-42c6-ab34-e51757602b56@blackwall.org>
Date: Thu, 12 Dec 2024 13:04:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, bridge@lists.linux-foundation.org, roopa@nvidia.com,
 stephen@networkplumber.org, entwicklung@pengutronix.de
References: <20241211072223.87370-1-f.pfitzner@pengutronix.de>
 <f1aac209-9001-428d-b210-495fe3b28e75@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <f1aac209-9001-428d-b210-495fe3b28e75@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/12/24 12:46, Fabian Pfitzner wrote:
> Forgot to mention the Acked-by from [1] in the trailer:
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> [1] https://lore.kernel.org/netdev/12a687d5-cc87-4993-aec2-07ea799ce334@blackwall.org/#t
> 

Please don't send separate acks on behalf of other people. I was going to ack
the patch again. Also please don't top post on netdev.

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

> On 11.12.24 08:22, Fabian Pfitzner wrote:
>> Kernel support for dumping the multicast querier state was added in this
>> commit [1]. As some people might be interested to get this information
>> from userspace, this commit implements the necessary changes to show it
>> via
>>
>> ip -d link show [dev]
>>
>> The querier state shows the following information for IPv4 and IPv6
>> respectively:
>>
>> 1) The ip address of the current querier in the network. This could be
>>     ourselves or an external querier.
>> 2) The port on which the querier was seen
>> 3) Querier timeout in seconds
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>>
>> v1->v2
>>     - refactor code
>>     - link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pfitzner@pengutronix.de/
>> v2->v3
>>     - use print_color_string for addresses
>>     - link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.pfitzner@pengutronix.de/
>> v3->v4
>>     - drop new line between bqtb and other_time declarations
>>     - link to v3: https://lore.kernel.org/netdev/20241101115039.2604631-1-f.pfitzner@pengutronix.de/
>>
>>   ip/iplink_bridge.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
>> index f01ffe15..1fe89551 100644
>> --- a/ip/iplink_bridge.c
>> +++ b/ip/iplink_bridge.c
>> @@ -661,6 +661,65 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>>                  "mcast_querier %u ",
>>                  rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>>
>> +    if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
>> +        struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
>> +        SPRINT_BUF(other_time);
>> +
>> +        parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
>> +        memset(other_time, 0, sizeof(other_time));
>> +
>> +        open_json_object("mcast_querier_state_ipv4");
>> +        if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
>> +            print_string(PRINT_FP,
>> +                NULL,
>> +                "%s ",
>> +                "mcast_querier_ipv4_addr");
>> +            print_color_string(PRINT_ANY,
>> +                COLOR_INET,
>> +                "mcast_querier_ipv4_addr",
>> +                "%s ",
>> +                format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
>> +        }
>> +        if (bqtb[BRIDGE_QUERIER_IP_PORT])
>> +            print_uint(PRINT_ANY,
>> +                "mcast_querier_ipv4_port",
>> +                "mcast_querier_ipv4_port %u ",
>> +                rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
>> +        if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
>> +            print_string(PRINT_ANY,
>> +                "mcast_querier_ipv4_other_timer",
>> +                "mcast_querier_ipv4_other_timer %s ",
>> +                sprint_time64(
>> +                    rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
>> +                                    other_time));
>> +        close_json_object();
>> +        open_json_object("mcast_querier_state_ipv6");
>> +        if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
>> +            print_string(PRINT_FP,
>> +                NULL,
>> +                "%s ",
>> +                "mcast_querier_ipv6_addr");
>> +            print_color_string(PRINT_ANY,
>> +                COLOR_INET6,
>> +                "mcast_querier_ipv6_addr",
>> +                "%s ",
>> +                format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
>> +        }
>> +        if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
>> +            print_uint(PRINT_ANY,
>> +                "mcast_querier_ipv6_port",
>> +                "mcast_querier_ipv6_port %u ",
>> +                rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
>> +        if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
>> +            print_string(PRINT_ANY,
>> +                "mcast_querier_ipv6_other_timer",
>> +                "mcast_querier_ipv6_other_timer %s ",
>> +                sprint_time64(
>> +                    rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
>> +                                    other_time));
>> +        close_json_object();
>> +    }
>> +
>>       if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>>           print_uint(PRINT_ANY,
>>                  "mcast_hash_elasticity",
>> -- 
>> 2.39.5
>>
>>
>>


