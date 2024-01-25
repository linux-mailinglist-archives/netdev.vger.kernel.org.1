Return-Path: <netdev+bounces-65960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194783CA90
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1365A1F22561
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19079132C04;
	Thu, 25 Jan 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMqDvRkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93846133983
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206138; cv=none; b=CSZn+83FJQmpmj0+ei5cOxF06cF7+l8eyMZ8qwtY6Ksw8gq1WSmh6w7AYmpJar/7fTDfi4espneLLefmRa0lllfJpkL8hseBZWFYY3soAYbhRzHLwbW8Fqmsg4NLqcBNLW2p4+otfG1taYYXDGcjVyPesMmmX87jsFX24KPvsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206138; c=relaxed/simple;
	bh=aWSjQTXbIbd774DSmCLgZ2MsmMwoHmQxMu9sJOrVHOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t6E5JKm3Bwt9ucZwk2/li9JgoWhXeH/5JP5UZ0MKCs4K0mxfFPhbljXY6/3J47TkVul2UdMIYwpDYA3W/ct7MNSo/AHzWvkDEb/ml+lRsY2Q0VbzhldGgaVc79y5FHz7YfNluS0PAWWoVU/w3Yp0vkSvBkjru++AvVo/03v3IAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMqDvRkJ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3606ad581a5so27332465ab.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706206135; x=1706810935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJ3VuES/VMVNydBsbPcUwynWCEEm3/5x7aKAQxVmOpo=;
        b=LMqDvRkJ4wBqGq9L3JkhdgCJTXPp1QvBcWNCH8iDhFgmr+UIOv5amdHw+NojDtSuRS
         HqshiuC0N6/FZK2Ue7CapGqaQEfZ3/66Mkb4Cf0UcQMMLfk3MJS5pU8se/iorK4uKTwN
         uSyX4B8JQo8HY9TGhr3vuU4gs2THMQFdT1sguYyahbfVBciX4I3hfrfLqzOWtBeNzB3F
         Qp/Tjvo4Jp17lga0etMKW9lzYDegLWCViMeGgtqlyU590bWPivt1U8x6MbVJFW9abeOq
         1aZyv522IKcDy1ECoYoZMoG0Jf+vKLFbbsUi0pHmd/hxsNIvfymulhoBLQGqp0Jpezuz
         1vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706206135; x=1706810935;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ3VuES/VMVNydBsbPcUwynWCEEm3/5x7aKAQxVmOpo=;
        b=nHykujxj4lbEpXG2jpyeBcPxUGBX/wvVDD+fXf6NcDy80qEkLwgZDZ1QxZivHVKz2v
         bNujH6NPhg6Y8R6mYd8GrjNBeeRDY6pU97qn2Yf/9Hr9Tcop1OZ7cTre+VNjSZ2q0ySN
         1SL663JpfCsmNjV9BsZh+KBIX9yB5h/h8ytffB53mBgc2LNAPbp7c4sxURUwTkpY9ud2
         2beWRDmbPU1iFo6ZIYfT4jVUuWncUW7Gw6uJDWMoRZjN94a31L/dF92cVtxJ8h09a8e9
         SRBqlwEMSdFnAyt05fMPBQAI+BEiW7K73XHhhViNTPxZAXJvDpzBWo+nNWr6jeqSpy+8
         YXLA==
X-Gm-Message-State: AOJu0Yxu2E+s7bqGhbB/MNN1/drerbD+pIeWMV4YlPF9TPm2f0g0oEZG
	T8Vb69roHJMG9CVqHk78fL4kDku8gTuVqO5pjq1pmSiurcQsU+i4EXf7U8ci
X-Google-Smtp-Source: AGHT+IGhYxuXotz9g5VGliXyHwlpMz5BTEICzFNaDYaAdFhRh0pA3aLpNgRZKA97ZNSyak9nkdUn4w==
X-Received: by 2002:a05:6e02:68f:b0:35f:9f2f:d67a with SMTP id o15-20020a056e02068f00b0035f9f2fd67amr99299ils.44.1706206135650;
        Thu, 25 Jan 2024 10:08:55 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:98eb:fac3:d51e:322b? ([2601:282:1e82:2350:98eb:fac3:d51e:322b])
        by smtp.googlemail.com with ESMTPSA id j12-20020a056e02154c00b003627b70d918sm3105687ilu.66.2024.01.25.10.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 10:08:55 -0800 (PST)
Message-ID: <4f3dc357-8c90-49fd-96ea-bc28932ea509@gmail.com>
Date: Thu, 25 Jan 2024 11:08:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ip/bond: add coupled_control support
Content-Language: en-US
To: Aahil Awatramani <aahila@google.com>, Mahesh Bandewar
 <maheshb@google.com>, David Dillow <dillow@google.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org
References: <20240125003816.1403636-1-aahila@google.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240125003816.1403636-1-aahila@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 5:38 PM, Aahil Awatramani wrote:
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index d17271fb..ff4ceeaf 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1503,6 +1503,7 @@ enum {
>  	IFLA_BOND_AD_LACP_ACTIVE,
>  	IFLA_BOND_MISSED_MAX,
>  	IFLA_BOND_NS_IP6_TARGET,
> +	IFLA_BOND_COUPLED_CONTROL,
>  	__IFLA_BOND_MAX,
>  };
>  

at best uapi changes should be a separate patch which gets dropped when
we sync headers with the kernel.

> diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
> index 214244da..68bc157a 100644
> --- a/ip/iplink_bond.c
> +++ b/ip/iplink_bond.c
> @@ -176,7 +184,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
>  {
>  	__u8 mode, use_carrier, primary_reselect, fail_over_mac;
>  	__u8 xmit_hash_policy, num_peer_notif, all_slaves_active;
> -	__u8 lacp_active, lacp_rate, ad_select, tlb_dynamic_lb;
> +	__u8 lacp_active, lacp_rate, ad_select, tlb_dynamic_lb, coupled_control;
>  	__u16 ad_user_port_key, ad_actor_sys_prio;
>  	__u32 miimon, updelay, downdelay, peer_notify_delay, arp_interval, arp_validate;
>  	__u32 arp_all_targets, resend_igmp, min_links, lp_interval;
> @@ -367,6 +375,13 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
>  
>  			lacp_active = get_index(lacp_active_tbl, *argv);
>  			addattr8(n, 1024, IFLA_BOND_AD_LACP_ACTIVE, lacp_active);
> +		} else if (strcmp(*argv, "coupled_control") == 0) {
> +			NEXT_ARG();
> +			if (get_index(coupled_control_tbl, *argv) < 0)
> +				invarg("invalid coupled_control", *argv);
> +
> +			coupled_control = get_index(coupled_control_tbl, *argv);

parse_on_off

> +			addattr8(n, 1024, IFLA_BOND_COUPLED_CONTROL, coupled_control);
>  		} else if (matches(*argv, "ad_select") == 0) {
>  			NEXT_ARG();
>  			if (get_index(ad_select_tbl, *argv) < 0)
> @@ -659,6 +674,15 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			     lacp_rate);
>  	}
>  
> +	if (tb[IFLA_BOND_COUPLED_CONTROL]) {
> +		const char *coupled_control = get_name(coupled_control_tbl,
> +						   rta_getattr_u8(tb[IFLA_BOND_COUPLED_CONTROL]));
> +		print_string(PRINT_ANY,
> +			     "coupled_control",
> +			     "coupled_control %s ",
> +			     coupled_control);

print_on_off

> +	}
> +
>  	if (tb[IFLA_BOND_AD_SELECT]) {
>  		const char *ad_select = get_name(ad_select_tbl,
>  						 rta_getattr_u8(tb[IFLA_BOND_AD_SELECT]));

pw-bot: cr

