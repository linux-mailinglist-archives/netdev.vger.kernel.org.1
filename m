Return-Path: <netdev+bounces-179419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD9AA7C83E
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 10:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F34189E97D
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 08:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CAA1BD4F7;
	Sat,  5 Apr 2025 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RwJCZILD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51281A7044
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743841080; cv=none; b=bC4tbEV88Fkx77V+8M2cZO68Dn1ygTWsNV+Lsg+FzS6c9IqsNxNARUx4QVSg+xj8XflgEipXUv4oqOpsWmsRAK7rraHRWmiVJoHIglFo8OxwjhPtp8lhS6t7bI6zYRGSwFULnwKKnPIn5ZJ3lSQTboJ47oqlyY+e646Jvq3EXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743841080; c=relaxed/simple;
	bh=Sk5EfWtbpIrDoBOQs1tLfZu5DMGKFwD+3E8Z91flcBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnOGYOXJ0d4H5b2uegTGBZiji1aSi+hQZ5XyX1m2oGXGBPi812clv9mI9JgQi5RcIlHjWp3PQysanjU4xj55ZdVkPiuTaO7Uydj/PfLCvpudTxSSVAdBMHP10lFq+ybd1MKxEXv82Sn6C4fKqfOPQJCEmbbRnnotZUvvg2yuoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=RwJCZILD; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso18401035e9.1
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743841075; x=1744445875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmh8VzGlGccoq62Okq7lLmPwtkx48Yd7cBlyMiMYKeA=;
        b=RwJCZILDIJxmEheMbCSIeVmS+K4Tgo0gVCzciGgphupEFDa8Vd///nb/133l0BnwG7
         0efO0XdcplGYxO7WiWVg7cXrfB/7WhVXiaTNwNqSk+lynSrIHK/yTm4RfPieqipKu7/a
         izsbkp8wr+s7s+xQ/NMC0OMsk/M1WMM595v4pUB0FjJMlu76CLkBp6lkS7FxcUhsQTEI
         akDuxd3gWfEzgiZWiLKPs6grCvKgmSuimP43uVs5nFzARHrABFYRCE2JJH7VSisflgZ3
         f0tMTgEgon++Hg/1tRxH9SxA6KgrxcgaU6xRDbCkSHCEtYIjnci+Nn7TmCmatwswG91G
         vjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743841075; x=1744445875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmh8VzGlGccoq62Okq7lLmPwtkx48Yd7cBlyMiMYKeA=;
        b=D9ze+9qBOmGlYM20NtngcBhh+X0kSKg5q73f9Q9J4vEvw+N6N60Rjj1dabeUrvi9Vt
         eGZRYdPiRKMX+WglepYYBLZMmkVvOb81pUXm7epoZnNY5AnfeNhexKN+BXo/pCzlBNjk
         z3GbWcVTNqFjc9gGmsemqk+ANC7ssL6NTq2TgUySjLYhe7bw5wZSeyml7Do1bZc3Hneq
         Vpd3eLQNravdh1wqZFH3TBLpWGYzVC+8HbVD6C/CKt5F1EfZwN+mdKqOZSGs2J32Jjlq
         fMxTlj3RuzogRH7gyQDh+XHpVA/H/x4qyF2uUI+rldtnzlzLMGY6zEo48n+g97dW5Zda
         o1+A==
X-Forwarded-Encrypted: i=1; AJvYcCX/B1+lX2T1IXjJWJ5g6pm3hjJBEUBp4OGXuW2fRSijbVvFVH7ZwVbHLuLfwmBp8/EbeDE7bKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoa7/Tj1Wqzl8KhteZNCgJxsdCtx9vSiExOk17rLH6r8TYuxGR
	Jwelm6usQnkfFTdYcE1sDRj8hEFuZThfFFYCHBUTl4z6wIEN+F7cOnUVjYilOrVuh54ld+Jg6Pg
	tZcC7iQ==
X-Gm-Gg: ASbGncvouqLukng4wtSBU43rf99mInp/Hxz5sTlLbQMliEQinBBsBu1sHihUDK1D8aT
	FEwaisGK0OlH6QOqebfNUHYO5Fz5/kvxzI+2wSmPtTyHQhmFa91hTiItHv00KaqC+ttND3xEiPk
	HkDZhWUGYvfhrQmp+kMqsFlK034aEEMsZvVhMocX8prM66P5GCPBhGUETHrkL6UNrrOhIy43CJ8
	6DoJafHGRJ/YPADusMGcjb6JNl4PTaCy/BWviw+7jKtt+cOertrRywOMgLASBkwYZgpdB2S9UPU
	yhpXFnY2yTBz5NeCIxUL05aiqhfKs6lnx0VXmlKr3yRaEAQNA4B8MTutPTP0UHqyW+0UvCF2zKm
	A
X-Google-Smtp-Source: AGHT+IEXH45zB9LxZqysktVTid75uKBWXT5GBeIvYEtODK5u/9rwtAa53Qy+v47CfQV3MHceLwM1jg==
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43ecfa06fd2mr69792675e9.30.1743841070178;
        Sat, 05 Apr 2025 01:17:50 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec147c9dbsm71352615e9.0.2025.04.05.01.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 01:17:49 -0700 (PDT)
Message-ID: <d20cb48c-116c-44ca-84c5-db67d9f934ae@blackwall.org>
Date: Sat, 5 Apr 2025 11:17:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 iproute2-next 2/2] iplink_bridge: Add
 mdb_offload_fail_notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org,
 Joseph Huang <joseph.huang.2024@gmail.com>
References: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
 <20250404215328.1843239-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250404215328.1843239-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 00:53, Joseph Huang wrote:
> Add mdb_offload_fail_notification option support.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in |  7 +++++++
>  2 files changed, 26 insertions(+)
> 

Sorry, but a few more things I just noticed below,

> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 1fe89551..c730aa68 100644
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
> +		} else if (strcmp(*argv, "mdb_offload_fail_notification") == 0) {
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

Please keep this arranged in reverse xmas tree, i.e. longest to shortest line.

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


Please add also what is the default value.
Other than that the patches look good and you can drop the RFC.

Thanks,
 Nik

