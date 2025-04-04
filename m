Return-Path: <netdev+bounces-179280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11274A7BAE8
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A623D1B60523
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04C1C8614;
	Fri,  4 Apr 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Nwvupd46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0F19EED2
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762703; cv=none; b=h1cD8DcsQ055qq7h62bBrGxFD+em/0oj7ARJwX9OwL3FIgeOm6JUA5UnbeUlAWQlRqsJzNu9JgeDH+yKju4wFK3mIJokydPFVTUGucqIiqh2aJ+RuACvkwyMb7uOKZPKQ+HIH/BLspJwh+CveUcXa2QGumf4MH8WPc7fKtrTw60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762703; c=relaxed/simple;
	bh=7ozkB2elpsrhUxZSzD6GvHEl4JI4PDIoKFELcLTngaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHYkYAoutjeYuRQuoGJa5qL2pK2m62QQNglV1ErVkjrx+298jJciqQxFDAIEVTIxfTEbe4oJYXWI/ZZvJJUlzbD6cvGMQsQc1XYpsWV/5HZoimHZ3hQ09rcmT9pgzOqrdzgYGDxh+gvC6xfjs6hZ9xmKLtIjSnd93gFX64kbLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Nwvupd46; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso18736515e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762700; x=1744367500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YlrZjIzlMMZTKcihX5IOw2xYR7bBg8eVU4isxrabryI=;
        b=Nwvupd46iP0sGEkHYn4tLabMBW7IcWo9KHy0xfOS0kuz9ZFgL1C8vDxoAjdfw0i+yj
         YPrrSycZwJxhuagi5UgneiDN78yUTPN7VN492/4GOil8K8k7j5JPat5/wXGx1zBlbhj/
         lGSN18lO23u9JM5UWg9bjq+oTiSICXLD9cny7rx3RVtKPZENM6CsgvSdaBVVgKP6aZcv
         d/y6+KS04gxYAsleAmRHZXEb35jWFR6lr31GansmInynphmB024MzO+3+lbKBimCmj7X
         oXrSNvtjy8fz/4iMN3zQYFN0bQzIoZJPPAodfKtcAAI3jTPL9ymIiPYRdVXG5mcTBf4B
         xvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762700; x=1744367500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlrZjIzlMMZTKcihX5IOw2xYR7bBg8eVU4isxrabryI=;
        b=QHM8EUeQ3Ybdk8/8+ljplcSoJeTelIwf6QEfd+43rGAp6ECXq7vD8KSXgBwxcrpBw0
         Flm9Zsao6jRpAmvLGLCjXNlOOrJ+fTq7niaPlNU+A7wHvjITZbwdkjRB8c/hC3q7jtIp
         AhL1ewhiHLb4/0lyQj4IBd5P0nrBV1vnWA2s/mhEtmWEfwXhQUEL4HHSMeH9hs1ScHjI
         WMIFOQ+lc04i1/2Wgrtn2HPtLS60Wjf2TnYCnNNAPED3hgkLI4/36csszwhQpSV4QCc/
         8VSaOq2//UpCt2kk3yOGIDblB9lGAbfhSt1QXmPVFXnPc9dtO7gen6/Ra88UgWktNFv/
         o3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT7agsiEjmVzrmq6dJMKxmIzXd/AngLbAc7dZLkazgyQHqVK6kTkfCQmoG7CvB3JO6GGLQZHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkFWFKr/lg52Cvcik6pq98IR8M6gkGjayL2WirP1m9nGg5MfY
	L6fZ5SxAERXEt7/qJQ6DxwDshkXAVGyaPek8jpF/rImpviZoArw3LH5voGBWvXdvNIT5ISVlj06
	jVFg12g==
X-Gm-Gg: ASbGnct7OvPFU8K/pmq04UqHBvv0O+oi2vGk5sav8a0tjtvhPbCBsVvk4MG3IynmZ9p
	141MqFj5nvp+CdgWohxHKHDGJInqEQQAAzL0j/hAIUcqk6j7M/8cnkD+tEofnaeKx9P14Zy0TYh
	T2+GPSDaF04ZEmNiX+JnnQ/yOpM0v2832h1HyZy7rbwF7Zw22axe0h9nY6A/n+3IND1btT+XM74
	VopRiiAd5SUcLAFsbw/WKwt+cZa0GtG0ZycFpLpQxOgjqg/rO4RfldI2dk1XosFhk1BceEa7u2I
	zYr7ch06GQIPpMJqazkY9+aAHaV2U2/t7wDiPbRsPuznytmjHSc3vo64pSkNTguHP+IgkyxUp7W
	I
X-Google-Smtp-Source: AGHT+IFpeEq9Etzmksl9rec0U5azAlixFSTuSVQqjhR22+D60oXRiVa4Z5GAQ3IPpHah93f5T4O1oA==
X-Received: by 2002:a05:600c:3d05:b0:43c:fdbe:439b with SMTP id 5b1f17b1804b1-43ed0b76649mr21725665e9.4.1743762700248;
        Fri, 04 Apr 2025 03:31:40 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b816csm4028934f8f.57.2025.04.04.03.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:31:39 -0700 (PDT)
Message-ID: <a85262ab-a636-43ca-a358-f713c2ac0877@blackwall.org>
Date: Fri, 4 Apr 2025 13:31:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 iproute2-next 2/2] iplink_bridge: Add
 mdb_offload_fail_notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>
References: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
 <20250403235452.1534269-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403235452.1534269-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:54, Joseph Huang wrote:
> Add mdb_offload_fail_notification option support.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in |  7 +++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 1fe89551..2233e47d 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -62,6 +62,7 @@ static void print_explain(FILE *f)
>  		"		  [ nf_call_iptables NF_CALL_IPTABLES ]\n"
>  		"		  [ nf_call_ip6tables NF_CALL_IP6TABLES ]\n"
>  		"		  [ nf_call_arptables NF_CALL_ARPTABLES ]\n"
> +		"		  [ mdb_offload_fail_notification MDB_OFFLOAD_FAIL_NOTIFICATION ]\n"
>  		"\n"
>  		"Where: VLAN_PROTOCOL := { 802.1Q | 802.1ad }\n"
>  	);
> @@ -413,6 +414,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
>  
>  			addattr8(n, 1024, IFLA_BR_NF_CALL_ARPTABLES,
>  				 nf_call_arpt);
> +		} else if (matches(*argv, "mdb_offload_fail_notification") == 0) {

Please don't use matches(), use strcmp instead.

> +			__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
> +			__u8 mofn;
> +
> +			NEXT_ARG();
> +			if (get_u8(&mofn, *argv, 0))
> +				invarg("invalid mdb_offload_fail_notification", *argv);
> +			bm.optmask |= 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
> +			if (mofn)
> +				bm.optval |= mofn_bit;
> +			else
> +				bm.optval &= ~mofn_bit;
>  		} else if (matches(*argv, "help") == 0) {
>  			explain();
>  			return -1;
> @@ -623,6 +636,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
>  		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
>  		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
> +		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
>  		struct br_boolopt_multi *bm;
>  
>  		bm = RTA_DATA(tb[IFLA_BR_MULTI_BOOLOPT]);
> @@ -641,6 +655,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  				   "mst_enabled",
>  				   "mst_enabled %u ",
>  				   !!(bm->optval & mst_bit));
> +		if (bm->optmask & mofn_bit)
> +			print_uint(PRINT_ANY,
> +				   "mdb_offload_fail_notification",
> +				   "mdb_offload_fail_notification %u ",
> +				   !!(bm->optval & mofn_bit));
>  	}
>  
>  	if (tb[IFLA_BR_MCAST_ROUTER])
> diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
> index efb62481..3a7d1045 100644
> --- a/man/man8/ip-link.8.in
> +++ b/man/man8/ip-link.8.in
> @@ -1753,6 +1753,8 @@ the following additional arguments are supported:
>  .BI nf_call_ip6tables " NF_CALL_IP6TABLES "
>  ] [
>  .BI nf_call_arptables " NF_CALL_ARPTABLES "
> +] [
> +.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
>  ]
>  
>  .in +8
> @@ -1977,6 +1979,11 @@ or disable
>  .RI ( NF_CALL_ARPTABLES " == 0) "
>  arptables hooks on the bridge.
>  
> +.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
> +- turn mdb offload fail notification on
> +.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " > 0) "
> +or off
> +.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " == 0). "
>  
>  .in -8
>  


