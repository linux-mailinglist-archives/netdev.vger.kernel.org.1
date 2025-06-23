Return-Path: <netdev+bounces-200181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22AAAE397E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 11:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257CA3A7589
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6791232392;
	Mon, 23 Jun 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="geSi1W42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8E233134
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669624; cv=none; b=YGUf/lhXT1lD+mjPTF2cDNTabm2vlyqymU6ZV1eNLPepkruqd1K7jFrKyYX0xM21aMx9qK7U2aPN1WjRSBhvLqWpNaeKqxA2DMmh+I/brh4DXW/jiCDTEgXrW/NfZPYkP/dOI32b5cLLMqtusjBnmK6LdOCaeTs8C6z3i1On6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669624; c=relaxed/simple;
	bh=EflMIV+kkp7UhsZ9tUS4w48sTU3134OYm+F+GPclhF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/ZBrgF87lqUISSSpPGlARFZOU7GPjOU31w/2YFkbu5tQnIT1Bvwgi2/uKqei0z9VPbIqpJ6CkcHtc5X2avUOL+qny61uGm114ivGRXHZPdxKePCQeh9pC35j3YdepvMzGGhKf9CoCBaa7GygykKykFiSOAsw/czpLWx2JCNDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=geSi1W42; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so6956153a12.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750669621; x=1751274421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwpLh1YokKB/zuRQcdVqUx5WgOSKBlw+lHCDlHkU3ak=;
        b=geSi1W42ZP3Fvlk8cLscl6JoGCkivwbFmkzdyGRvF5IIqgrmSA4P0dUcJiaqeytmOs
         aeNj31HUCmAwt2ivN0X25mFwYYD8YvHlVmRxFN6bEMdawfnvFLgehM8Bo0SPonEXuR1D
         NX5nzVbIv2+vgUL9Q8IFygtymPDN+IskuTSBCZf1dg6mU5qWyuZ1BgDZTzUHvsb9iKqN
         n6rV/yLjRpZMwRfGwcsBfSjXFuAoyi9mM6ky428IeVDwwSnbUbujlEByLbr2G34GoSl9
         DXH3eRT09PsLrK+WQdKSFKZz82wcQQDJmc9qqb4r2GbfeCjccR8gquWfwYtHH5okyWva
         Oinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669621; x=1751274421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwpLh1YokKB/zuRQcdVqUx5WgOSKBlw+lHCDlHkU3ak=;
        b=AKDXA5ZAG7RxLlV8QCv+XmvQ2358bvrHN9XnPGXLXZ3x0fomEoEq5Snfr2DE8cMDEH
         tewQfKN2Hwxw5o6VV31H2iDODnx+E7esz9bdyGJABBwnoY48g9J0RspT/N+isRmJOcwY
         4TfMfi3WgglziWjcE8NTByY3LiKvH00CxOw0LMuUqtXfHk3kDlUCzL+UVcS5R0iiqPrc
         4lnVGbTw26+lv9NZ90/jzqqkayNG8Efa4fNUwG6KNjDowxtFyQ4hgyjxK4C/uDyuXnH2
         j4BvZarQZKxCRYMcfiHu0ML7orodvJwocKyWDMZPZGa7OEhC5mtqYlz1ISXb906R3J5+
         i/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWmnimQ7DF6bO7tDDZWQLz4J55RMA3jIUQUuAgAaa5YbvY16sZGs1WmC+W+xhAKtVgQNlvayfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRShIUaKHS73JVOkpBcbnLNkKW96EaQrsjvmQppFO69r/XBZBd
	hbATD4/SJWradifDv3UegCUJSppDWzImoqWStz+3cVsuoAO2wU46koW4Yn0I4nYTXaM=
X-Gm-Gg: ASbGncvwJhWm1nXObpWgKDlaGNgSabm00B40UoI/uZ7dFrIJZJvNzjaq7RiVUrfWFvY
	mmu1kO5M341Qd2/GyyIS2ujysw/5EnqWqAhQrutcGjfalPRLRBU6GauVTBjrAEhid4EGgrF0YK1
	M+zMuMaye3dDhGlJaT/x7oFRZrYm/83Ol4cOT+cG8lfSrP6EXZfOoviAXuSHCBFqIkuyhpEEiTU
	mMF4IJEMCaYh5JrmVsaN3d4XC/jv0CF3+RzlVP2j0aahH22Jbf2i1n5KVDP+2Xx4ZpL7pUDDQDc
	dxH8P+4YTvw88d9T+HM6eeheL632Wr/YKRVjWXQ9+nlNL24lyiXUO9NgQV5j3+opdwTCZ7d8x/m
	qzKHpQZODp9j0NVXlaA==
X-Google-Smtp-Source: AGHT+IFoNeREHCLZ5lXZKiX4iyr7z14GOgxcoVyAK+9phPgUtXE2KzB2nCOBwExmYB7dNfFG0ZnKiA==
X-Received: by 2002:a17:907:7fa7:b0:ad9:db54:ba47 with SMTP id a640c23a62f3a-ae057f65a32mr1036698966b.43.1750669620951;
        Mon, 23 Jun 2025 02:07:00 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7d1basm671019666b.25.2025.06.23.02.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:07:00 -0700 (PDT)
Message-ID: <fe7f1941-77c5-41a7-b892-ec4f42d45e9f@blackwall.org>
Date: Mon, 23 Jun 2025 12:06:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v4 2/3] bridge: dump mcast querier per vlan
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
 <20250623084518.1101527-3-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623084518.1101527-3-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 11:45, Fabian Pfitzner wrote:
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
>  bridge/vlan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index 14b8475d..d2770eff 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -852,6 +852,10 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>  		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>  			   rta_getattr_u8(vattr));
>  	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		struct rtattr *attr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE];
> +		bridge_print_mcast_querier_state(attr);
> +	}
>  	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>  		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>  		print_uint(PRINT_ANY, "mcast_igmp_version",
> --
> 2.39.5
> 

Same warning here,

WARNING: Missing a blank line after declarations
#112: FILE: bridge/vlan.c:857:
+		struct rtattr *attr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE];
+		bridge_print_mcast_querier_state(attr);


