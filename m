Return-Path: <netdev+bounces-216489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBDBB340BB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB3C1884AE5
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87382571BA;
	Mon, 25 Aug 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJpATx04"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7D611E;
	Mon, 25 Aug 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128696; cv=none; b=Z5jLATQHo/MIqGxW/QJT4iHugxdV7oTqhcMWs/bA/S/DAxhlda5SNc5XGg5N3YEPzccMfJqRoOQLRYpC31L8kNkJGcDrJ6IZZobsDZZXxbyjPbvlNeT9bmE7bTbR/A3aNZdkzGRvMHuAf1kn6/Kyhpd3YhjMhrDRXj2VSOXZRos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128696; c=relaxed/simple;
	bh=0s2ARpnB+llo0wyd0ziQYoULmmUP14SJmnC18+wGgKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgcgRTu/80XPek969QFZCb0p35S2h9Cd7PGB+Fa+5ofWHWr+zyHYx91oZYOp19DvIyd1jNwDAk+GUa3TDAT0mn4Ie18A1AvXe44o5DhCF6LDinKh+TK+9AhTDedlhN1MRpkoEoiMMASQrX0aeryniwHwn+krinSg9bFSWmPYjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJpATx04; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c6df24f128so1635355f8f.3;
        Mon, 25 Aug 2025 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756128693; x=1756733493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THJ34UQf7q4UAMHR0Y6f+KxcTpSVXQ6YuCTVQKzaewc=;
        b=jJpATx04sfrsC2/Fd2OEJSkn+knJvQvtQAHY158HLiDUTzhvPwBd9gzwXqupgP8y3/
         n/Zt+arsrkqyZcZUfXYXouOdKOb9O60OvTjVIHUqX4rlXcyhDk9zT7Vu8wt5xZegL402
         0asL8orvcfYX+glvVluBfxwDVTxyp+EZ6/HKKFhkzkZ4obmgtbfMoSARzl5msTrfCe8w
         52cxPKLwkMFflC9ESbsc8aFIZEVId2UVp5V5ub2MGrTggogoQ0Cw/71N2SdZe1JeSm5j
         Ql9IzXfY3MzhShbnQhvgeZiGQJv2wxgdfO8daUkEdQU6bIubyQoCLWn+/RB+Yq+KtXxD
         m41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128693; x=1756733493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=THJ34UQf7q4UAMHR0Y6f+KxcTpSVXQ6YuCTVQKzaewc=;
        b=WtJE9FhUvyJ2gXUnL3QU5fGmbB9CnkH9iji3e9ZR96eGixAYQujLb19AIuF7WR6YP5
         GLcXr0GV0wZ/aWDr4S47OpqG3zk0mHLCcw7nGuq8QlZT72oJ5V4USHX93sRzw36KTmrr
         LUiLfiPC5aabH8rHkEqs5SF1kRn30OoESo4+/a/CFhQ4lQTj6uTDCl/rKOmquclDsvFd
         MXYpzNcEwqjIsZK4cqQvtNrrcrBNeDorHBYDi1ffD+IEIkTuWI+dr046tTrUTwh5aw+d
         vV+gHVhPbeG/tzU3UH8ASGH7k8Wd3zU39kRANG2hI1wsO2zap/5lpcdCL+xHvM7UeTYz
         QIsw==
X-Forwarded-Encrypted: i=1; AJvYcCVUA2CwWzpxlOhYUPuFVnlXps29/VakxZBZN8k0QGNGyeDMmoTGFZJwQ0fXOkfTGGVcSuvuFzYZ@vger.kernel.org, AJvYcCWe/unw6AD74MO/uGOVjf0q4H+bAVq2PaYToVprrHyZ4vdB/7U1L2w3kgxsII4LEoZYArHK17a9lueh9iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYV8ccKzIj1G7dMaVrabfBFXzF+gvVGfnEGFZGfxR+/V9yRyzb
	0fiCqXLdxyOThjPybNz1nTqasOZS6C3A8+7E+MnPwPD4CtAyv6uyke9G
X-Gm-Gg: ASbGncsn3WyY9usLsN+ugl95ZJe553DNCsvnoa+LKJS+4TuRCs4LiKwbsAvNg1tTddt
	SgF3c/euWseppQFlHjtobWHZU/ui8cPx/yGuLQgCF8TTXNXk889o0OuWe408sgBt/wCdMVKQFCz
	duKNyNnhNh8qXfD6krt8aFzgmW/JfzbXuiTrYzSIGClmE/EAvsM+/Z8HYkGCGCGT/p5u9rtlXy5
	Z+aSUsjgYMR3ZnpHRP2PbHk7+qayX5cLch/Qp5nNMUECF3Z/RjqGMSY0IhpZZyMugrAEZYjjk9n
	06J54hJFnwLyerqomX65G7Y/FCxpnvMs+Sq/HiZ0myuw8Cd03xMilfP/8AN/5u/s6S52vIiO2rk
	4j0+q1JOs6U5K/Am+7RunfiWLq6VNE7kFvD/Vw4FiZBOdycA7
X-Google-Smtp-Source: AGHT+IFwbHbTWb3A6JUwGyRydrcfpSylptDxshC1FrrrgqAyc1UO4KxsbwNIhLafGu4oyluystJNaA==
X-Received: by 2002:a05:6000:2404:b0:3b7:9dc1:74a9 with SMTP id ffacd0b85a97d-3c5dd2d7ea7mr10778441f8f.42.1756128692899;
        Mon, 25 Aug 2025 06:31:32 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711abd15asm11783778f8f.56.2025.08.25.06.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:31:32 -0700 (PDT)
Message-ID: <7935b433-4249-4f3f-bf22-bb377a6f6224@gmail.com>
Date: Mon, 25 Aug 2025 15:31:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, ecree.xilinx@gmail.com,
 dsahern@kernel.org, ncardwell@google.com, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, willemdebruijn.kernel@gmail.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250821073047.2091-1-richardbgobert@gmail.com>
 <20250821073047.2091-4-richardbgobert@gmail.com>
 <4feda9bd-0aba-4136-a1ca-07e713c991b7@redhat.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <4feda9bd-0aba-4136-a1ca-07e713c991b7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 8/21/25 9:30 AM, Richard Gobert wrote:
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 68dc47d7e700..9941c39b5970 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3772,10 +3772,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>  	 * IPv4 header has the potential to be fragmented.
>>  	 */
>>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
>> -		struct iphdr *iph = skb->encapsulation ?
>> -				    inner_ip_hdr(skb) : ip_hdr(skb);
>> -
>> -		if (!(iph->frag_off & htons(IP_DF)))
>> +		if (!(ip_hdr(skb)->frag_off & htons(IP_DF)) ||
>> +		    (skb->encapsulation &&
>> +		     !(inner_ip_hdr(skb)->frag_off & htons(IP_DF))))
>>  			features &= ~NETIF_F_TSO_MANGLEID;
> 
> FWIW, I think the above is the problematic part causing GSO PARTIAL issues.
> 
> By default UDP tunnels do not set the DF bit, and most/all devices
> implementing GSO_PARTIAL clear TSO for encapsulated packet when MANGLEID
> is not available.
> 
> I think the following should workaround the problem (assuming my email
> client did not corrupt the diff), but I also fear this change will cause
> very visible regressions in existing setups.
> 

Thanks for the thorough review!

To solve this issue, we can decide that MANGLEID cannot cause
incrementing IDs to become fixed for outer headers of encapsulated
packets (which is the current behavior), then just revert this diff.
I'll update the documentation in segmentation-offloads.rst to reflect this.
Do you think that would be a good solution?

> Note that the current status is incorrect - GSO partial devices are
> mangling the outer IP ID for encapsulated packets even when the outer
> header IP DF is not set.
> 
> /P

WDYM? Currently, when the DF-bit isn't set, it means that the IDs must
be incrementing. Otherwise, the packets wouldn't have been merged by GRO.
GSO partial (and also regular GSO/TSO) generate incrementing IDs, so the
IDs cannot be mangled. With my patch, if the IDs were originally fixed,
regardless of the DF-bit, TSO/GSO partial will not occur unless MANGLEID
is enabled.

> ---
> diff --git a/tools/testing/selftests/drivers/net/hw/tso.py
> b/tools/testing/selftests/drivers/net/hw/tso.py
> index 3370827409aa..b0c71a0d8028 100755
> --- a/tools/testing/selftests/drivers/net/hw/tso.py
> +++ b/tools/testing/selftests/drivers/net/hw/tso.py
> @@ -214,8 +214,8 @@ def main() -> None:
>              # name,       v4/v6  ethtool_feature
> tun:(type,    partial, args)
>              ("",            "4", "tx-tcp-segmentation",           None),
>              ("",            "6", "tx-tcp6-segmentation",          None),
> -            ("vxlan",        "", "tx-udp_tnl-segmentation",
> ("vxlan",  True,  "id 100 dstport 4789 noudpcsum")),
> -            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",
> ("vxlan",  False, "id 100 dstport 4789 udpcsum")),
> +            ("vxlan",        "", "tx-udp_tnl-segmentation",
> ("vxlan",  True,  "id 100 dstport 4789 noudpcsum df set")),
> +            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",
> ("vxlan",  False, "id 100 dstport 4789 udpcsum df set")),
>              ("gre",         "4", "tx-gre-segmentation",
> ("gre",    False,  "")),
>              ("gre",         "6", "tx-gre-segmentation",
> ("ip6gre", False,  "")),
>          )
> 


