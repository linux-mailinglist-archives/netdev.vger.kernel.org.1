Return-Path: <netdev+bounces-200624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88941AE653F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE754A7C23
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563A2797BA;
	Tue, 24 Jun 2025 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kyQX8jbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C2291C03
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768834; cv=none; b=TbPXpvXtsvXi4ogLJW8i10Puk1P+f16YJOnntlgd3JfzWJfYSQ9zAHtld7/Bs/uUFv/dFZT8L4OIPqWWRNQsHU7K4eUaPSr31D8BZzQIorva/8TP5rDhuDaN2zcFm7/RD15/k/zifvTrQ+hedtLW5nQtwwb1vm5zw/fI1TvV1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768834; c=relaxed/simple;
	bh=EK5fpWiETs7JEsGfpFKK7kvWd05z/Eb4sAehelWB+2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euOVxEH+tRbBn5WNZmXq2yn0eyTo2W9IcT1+K8Af2S1DzPS88B85+mTwSfKNeUDXYbx68rOinuJRYKjoGq/WcrnUZGBm4hiYiSYC7Y35p15vC55FVv17KeCFxwjJIBWANdCR13lC1OyFMR/qW7uoogDHJp7H2sB6aMrFHsmbz8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=kyQX8jbW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so676279a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750768831; x=1751373631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4fdhcxdSvG4YFNR1XNWXsS8m7a9YlfMp0AeYu52oVQ=;
        b=kyQX8jbWIQqdonxxzbDS1T6oAGw5q0kijd9NtdFFA/dH428GUo5v4VtMExEitiFVxe
         +DTGFBHiDTnocNhkeBQe4+yXnQ+dV3k6YGfrBjmHp4thYncTrZk9TuDvGCqhDSSqfcC8
         u8PgKqHkXzvFaqdsA/sr1rv3tCDmDylDkcJW7y6g5QokDTIncSP7047RxrCEs/Rc9hZ2
         p93FvtNAPnKob5qdp8mwF+R2BK4UKVUtM2lJeLVvqU1OHlE5Y7MOttX2MAiPENtJa9Zb
         4o2Nj96H+J1jDzLCP+Qz7eHr1pXbDJeeiHmZb+Bbz5ykVqxGURBJMs51pg/nM8B3vngR
         c0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750768831; x=1751373631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4fdhcxdSvG4YFNR1XNWXsS8m7a9YlfMp0AeYu52oVQ=;
        b=o9VVNAhPbC2EQ4IIDoAjGv2/w/uaeLN9RFabHDed+YOrMNUATSSxf5yQotKBf7565W
         /bparppArzaGZ/kJq3YpZWuMR8arwHhg6JK4JS8wKYST5fv2r9LzZ0VnrIhjuYCL7vRT
         XYiSzBDsFPe2MRITUvbIQl6xw4hBMTkDW3auQ0c79CZiU7yWGyEdVlctJyf9bJX1k19V
         1c6QaJiHDUn2Gh04ZAo1OFuaq7phSVQMJJkiwKed8CxwFNJc/Mi3zHwORc/vvZE3MTwJ
         RvZoFQbYdUp/koTmrQZXy3rT7xGanBDvbEgflQshigHrZGo2zvTcguMMrKFn/YoHwqHD
         BGfg==
X-Forwarded-Encrypted: i=1; AJvYcCVXeJfpQCBjktw8/DKDN96+2J2fqlIIIFOQQUW/pciOK4UNAx02gvaj5vVa/ICBJWu2nRC7ZJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkq+WRhVaueXn3gn0NaZfQRlQLoAmy6veNIZjqzmpeH1qvsjUK
	h5uDKih2VkVWYyNu+dY6bOUtbbpwV/v7KWm9nUCbKRR5AGXZQJ+rYA9aU3rcEBTKXns=
X-Gm-Gg: ASbGncto2BpL977DsKixnf3leGXwied8JxuEQXTHFAYIezcZA30Z9Sgv98fV1JB22ev
	NcMm2QzMSxG3SJcGcKiPy3e0A6nnUTjSplpuEmZ14gv5P918mEiGekxU2MYyFYHi8aJBK4Y1RrR
	/4dea6PuVWC4j7Iy8sx44/xqF04Ez5aa4q0lqvXTffG8QOn5qZqcpwxFrGyYEsLUuAKr2nhsQep
	sTscZ5LIa3aHH2dqOC7I7+0MJ9bro5HmvTSC1YP7WOyyiFPPSGcQgV32FXReZvMd4bHUus5VQDI
	BxsvKIVzGNIGqnfBdcmLNgVLepV/dtIH42x3j0tp2mjyBL9XVAXg63JZKTZrzwNXT0pLGId9G+w
	676C2ctlSg3T9wNLzifubHVNXMKNy
X-Google-Smtp-Source: AGHT+IHdjgal16iaGYR282K8gG/RsOmIUsT0teCb0iFZSsjNBjWmjpdFG17QSTWFxT+Hy2d/ZCC8Kw==
X-Received: by 2002:a05:6402:520d:b0:60c:3a86:e117 with SMTP id 4fb4d7f45d1cf-60c3a86e394mr1304707a12.34.1750768830669;
        Tue, 24 Jun 2025 05:40:30 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1b8e14sm969638a12.35.2025.06.24.05.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:40:30 -0700 (PDT)
Message-ID: <ef528c8e-9931-4746-b72f-31110fc3aebe@blackwall.org>
Date: Tue, 24 Jun 2025 15:40:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v5 2/3] bridge: dump mcast querier per vlan
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-3-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623093316.1215970-3-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 12:33, Fabian Pfitzner wrote:
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
>  bridge/vlan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index 14b8475d..3c240207 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -852,6 +852,11 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>  		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>  			   rta_getattr_u8(vattr));
>  	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		struct rtattr *attr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE];
> +
> +		bridge_print_mcast_querier_state(attr);
> +	}
>  	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>  		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>  		print_uint(PRINT_ANY, "mcast_igmp_version",
> --
> 2.39.5
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


