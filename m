Return-Path: <netdev+bounces-223112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CAB57FC0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315191881903
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E2343202;
	Mon, 15 Sep 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HSCFE0PE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036243431E6
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947978; cv=none; b=Dklag4I3OvKjAohTaT/3tqEnsjduz84zAO2QldoCfM3NysSYHANu+xMbtKaEKfbBUqmCw470J1Pdd/mDm1z+HgsnGy4vElV0/n/x+/Q6OKG8g/GNjhshvWvGFp5TzetRDtCe+aQdjdDcd0ijtHglQblqAHy3yYFrv57Q1FUflso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947978; c=relaxed/simple;
	bh=WeK4i4Jh3cBb561KX1nwe20i3BOnkgL/ygYdLv2NCYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwPGhOBemxCXux0fBJ6iTIA5wrQkzZrdNzyD8nHWsVKyupk657JlBlK/+qq9I5td/VVwIZUpSKuWeeT47/KA6PEQMO991RInZYsAl3QhqzU1B/Bgr80h0bpynwtiw0JOuvz1kxQZsmKGV7qwl+t7M4WenibZf8aNQsIZga7iJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HSCFE0PE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-353dece5805so16667481fa.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757947974; x=1758552774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXtnHQvalCqNSAIEBbkaX6u5GPHgZxAhrHUKI+Mi9HE=;
        b=HSCFE0PE6q4PTmqA6X/BCa7iMs8Urp4zkN0O5RAAAg7GUe9wnjaNz+iOXRSEr67kC4
         D57Q3vpmN7y4n8ZgsGx11mHwbWLEQ11GP754y90jfYkmfqrnbUPKGSEBU5YrNb8Riaqx
         2sSnpE7jzJZTfVSGXoP4Gt9qeFg8Msv2gkjfT+tW26jRpW4rh6cfFMGxKA8Pxs+gau4p
         JxuH3HsbU3l6eXRWGhKlX6SWt84nUQfJiNx5UnnFhKL4BsMQrSFbLXAl2wetzDdkAiDs
         auuo5bfqTT66oqbxAu4Cr8aB0t8s5422xuNoFa6v3EbmwJ6b+I6qR40py1H5ZM7CoX3G
         cQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757947974; x=1758552774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXtnHQvalCqNSAIEBbkaX6u5GPHgZxAhrHUKI+Mi9HE=;
        b=FCm2wi2oLaY1EXwYyIkGFj//TMt76p1k85q+ue4B4cMnknw+UaNHwN42uxlQNbYexT
         pjo7aoJ08QyVMU0X2aL/nHkYdl7WpeFqHoSR0q3sZVNUfGQtVlpw6IgGxMKODv8/LTWi
         W5P8F32OcmRix4ZpVhi/j2obzV2n+i12GBKkr58gC0QCczNbieZJeB3KeL4cBNd8by5e
         iKbtaEveqwtcUtFB7nRvjl82od9p52ZVjC74Muw8n3sstvuaEINrk4oLVBd3Hb0NfYLr
         qESaeLrijjskGtkShAxDOnSa3/Fq/BijlozdJr+S0USIDEBPCBjm/1+tffWmdN+XCgQW
         0gHg==
X-Forwarded-Encrypted: i=1; AJvYcCXDnylCoSiZK00W+cffciPefw11/OC26oyE9vUpWsFg3r6w8SUovIsV7sJzCzQyGfX9ZACWAPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGCPC+QyKrSNUL9+7e6iO9/hfL+QZOgN/wZWu5A5xWTLwGwhpK
	qf92tGyzR4N5/z0s+pSydus4KXpwihc7lLOWkXLq3VKE9MOJGby/mRK0n/t8HeSzxzs=
X-Gm-Gg: ASbGnctQbrhHBXqDcfx/6rYIeOd7QtDkmpt3oN2Hd4hE0Ws1mU/7YjWFQyKkaywdpXT
	c5mWUcJhbQ/sO2nCJbKyIu1JMPrsqNtAVTo1lH0q/P0J9zz8HzAmkJ9uzxXK5OlwDGpejPPBbHe
	SmiWPNbiniQgVuhkeuuUOy+gXubdHecECiZOTslYHOiq3vemvD/h2sh4bvFCCl8Ks/S4NUBMjKt
	uxaTD6VTl5SJksGuzx96JSWuTNdwEEzoskwKJ5RlU66M43YcwBVQbStwiudWnZ9B2xOQy2ZWHaU
	rB7fEqyjrZnb6R9KDmQKjQ0FIxq02pbkebK8bHMam1EvcS1OdJK2IHr2j0SVt8TTdFa2QsVJLoX
	80apbdNWtS0ZLdQqaCWidp9hH5bzWr0WQU/rdfVA9pixXySlCXoypeQWx4X46vb/WR0H79jmK61
	J7Dg==
X-Google-Smtp-Source: AGHT+IG+orucVwZeNIbd1O9h4HAaSyMkRPvIOwJ8WpY44zfXZ+27B6OG3/RXMcEbPihljWBO6esHNQ==
X-Received: by 2002:a05:651c:2206:b0:337:e460:bef6 with SMTP id 38308e7fff4ca-3513c029619mr42710901fa.10.1757947973620;
        Mon, 15 Sep 2025 07:52:53 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f51desm26894961fa.25.2025.09.15.07.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:52:53 -0700 (PDT)
Message-ID: <f41661e4-a7c2-4565-8167-3eb452402133@blackwall.org>
Date: Mon, 15 Sep 2025 17:52:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip: iplink_bridge: Support fdb_local_vlan_0
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Andy Roulin <aroulin@nvidia.com>
References: <8ca075b0d6052511b57b07796a64c5be831b3b53.1757945582.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8ca075b0d6052511b57b07796a64c5be831b3b53.1757945582.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 17:21, Petr Machata wrote:
> Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---

Please CC me as well on bridge patches.

>   ip/iplink_bridge.c    | 19 +++++++++++++++++++
>   man/man8/ip-link.8.in | 14 ++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 76e69086..f7f010fd 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -36,6 +36,7 @@ static void print_explain(FILE *f)
>   		"		  [ group_fwd_mask MASK ]\n"
>   		"		  [ group_address ADDRESS ]\n"
>   		"		  [ no_linklocal_learn NO_LINKLOCAL_LEARN ]\n"
> +		"		  [ fdb_local_vlan_0 FDB_LOCAL_VLAN_0 ]\n"
>   		"		  [ fdb_max_learned FDB_MAX_LEARNED ]\n"
>   		"		  [ vlan_filtering VLAN_FILTERING ]\n"
>   		"		  [ vlan_protocol VLAN_PROTOCOL ]\n"
> @@ -427,6 +428,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
>   				bm.optval |= mofn_bit;
>   			else
>   				bm.optval &= ~mofn_bit;
> +		} else if (strcmp(*argv, "fdb_local_vlan_0") == 0) {
> +			__u32 bit = 1 << BR_BOOLOPT_FDB_LOCAL_VLAN_0;
> +			__u8 value;
> +
> +			NEXT_ARG();
> +			if (get_u8(&value, *argv, 0))
> +				invarg("invalid fdb_local_vlan_0", *argv);
> +			bm.optmask |= bit;
> +			if (value)
> +				bm.optval |= bit;
> +			else
> +				bm.optval &= ~bit;
>   		} else if (matches(*argv, "help") == 0) {
>   			explain();
>   			return -1;
> @@ -637,6 +650,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
>   		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
>   		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
> +		__u32 fdb_vlan_0_bit = 1 << BR_BOOLOPT_FDB_LOCAL_VLAN_0;
>   		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
>   		struct br_boolopt_multi *bm;

nit: the block vars seem arranged in reverse xmas tree, could you please keep it?

>   
> @@ -661,6 +675,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   				   "mdb_offload_fail_notification",
>   				   "mdb_offload_fail_notification %u ",
>   				   !!(bm->optval & mofn_bit));
> +		if (bm->optval & fdb_vlan_0_bit)
> +			print_uint(PRINT_ANY,
> +				   "fdb_local_vlan_0",
> +				   "fdb_local_vlan_0 %u ",
> +				   !!(bm->optval & fdb_vlan_0_bit));
>   	}
>   
>   	if (tb[IFLA_BR_MCAST_ROUTER])
> diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
> index e3297c57..8bc11257 100644
> --- a/man/man8/ip-link.8.in
> +++ b/man/man8/ip-link.8.in
> @@ -1725,6 +1725,8 @@ the following additional arguments are supported:
>   ] [
>   .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
>   ] [
> +.BI fdb_local_vlan_0 " FDB_LOCAL_VLAN_0 "
> +] [
>   .BI fdb_max_learned " FDB_MAX_LEARNED "
>   ] [
>   .BI vlan_filtering " VLAN_FILTERING "
> @@ -1852,6 +1854,18 @@ or off
>   When disabled, the bridge will not learn from link-local frames (default:
>   enabled).
>   
> +.BI fdb_local_vlan_0 " FDB_LOCAL_VLAN_0 "
> +When disabled, local FDB entries (i.e. those for member port addresses and
> +address of the bridge itself) are kept at VLAN 0 as well as any member VLANs.
> +When the option is enabled, they are only kept at VLAN 0.
> +
> +When this option is enabled, when making a forwarding decision, the bridge looks
> +at VLAN 0 for a matching entry that is permanent, but not added by user. However
> +in all other ways the entry only exists on VLAN 0. This affects dumping, where
> +the entries are not shown on non-0 VLANs, and FDB get and flush do not find the
> +entry on non-0 VLANs. When the entry is deleted, it affects forwarding on all
> +VLANs.
> +

Please add what is the default.

>   .BI fdb_max_learned " FDB_MAX_LEARNED "
>   - set the maximum number of learned FDB entries. If
>   .RI ( FDB_MAX_LEARNED " == 0) "


