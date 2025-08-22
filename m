Return-Path: <netdev+bounces-216085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247CB31FBA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29BFBC1283
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB842472BC;
	Fri, 22 Aug 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7jHDy08"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253332135B9
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877881; cv=none; b=VtZ2IEwQreYrodYPKTqqWq+Zlz+ntcCThy4aIxP9mziKVB5u7KgvU348hVFsnNi+gIKdofLtPUxtF5mVMslp2mz+yjiG0meUbd0YqRf3qxcz4B3vg5mGm3/7cIwZ5c4AheRwHq07ouEHq50idTyg1YQasWV9VVVIuD5ZKAxtH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877881; c=relaxed/simple;
	bh=X4F2MhZwl8vDoLP4la59CQespvjwyzGte81DfvYqiQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMSJKnPTk+Hdu2aP9RprbGUO/pGGkemuH7ZgpsmLWR67xarl6ObFnu5EnQEGgkFxUpwJ/bI3xOoQTUNovftzJJW/Z19ODom7oGuS0diQqwS1C26hODt77Z8qDKwcuSzIHJJcN7gN1KHbEYN0iDZ6aVMxG7YsgvySDOq9Kw3cskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7jHDy08; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BvzPxkykRVHqIEzV8JDMXRhoyfWSdFzz+8/KZrTRO4=;
	b=c7jHDy0813OoLOaiFOJHLC4qOvxZZysdul1F96syv3HZ9IfDvouUey3hbkRZB68YqleqLr
	WjDWhUjZw6pP4+nT3XaUmN8MKy6V5ycS2UtIYAULj4+66ddU3Wb64ZJwKglg4v7pTxXiYo
	qm5HhyGrDV/a9wsso8YKtj9OjJTkhkQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-aAbV3AFoNf2Ipibgn7uo7g-1; Fri, 22 Aug 2025 11:51:16 -0400
X-MC-Unique: aAbV3AFoNf2Ipibgn7uo7g-1
X-Mimecast-MFC-AGG-ID: aAbV3AFoNf2Ipibgn7uo7g_1755877875
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41b779aso1338812f8f.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 08:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755877875; x=1756482675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BvzPxkykRVHqIEzV8JDMXRhoyfWSdFzz+8/KZrTRO4=;
        b=Ug9bjg/qQ9f5TC9+vzgQeOU7rZphXLm6hXgw5De0g99PhnawnnbzqkFtJljFN68S1S
         ieZsZr7rkVJU9yQCtIxI85MuvgDgr8kQMi2jMB3nRu/auwbPcoL8EXoYJ1/Y28hYvtrA
         EfCk1xc/i4x8O5gsiAhM6HidXOyIkG27vmNWmsq1EcQCtB7amxyKZcNPf24RCmYmdRpT
         os5jse+gUTHXqVGpo8apR4FIW+WfO+z17EzES/A6qdc5Vr4tSYmqwWTdZnR1geUHAvPF
         ZYw0lYl8z+pYv4xzca2im8F+vueed680snvUoHHdK3BDjhkkAM4GpFnxezv9U9uM3vY6
         DNxw==
X-Forwarded-Encrypted: i=1; AJvYcCWGkkHgaw4jm98RukP2h4CqYc+dPwgTIhiTP0o7bY6iE8d7qhLNKJhBLi5086Yhois4EA/cNgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUSJzRLniyaLYLkqz6b9kYsDmsbCz6feH1zZr/R3gA5hw6ouK4
	DPTEIc1rQMcK/obsoxmHnTsG9736vRsJFB/2IzT9vNZ27Dw/CGwVYBWOD6ac9f7YdcEbqJhSHX9
	GIA6VZf/E5/fI01NCtcOEjOMAfFba0bl4pfbXTMUWdeALZ5lNAtkmJlcQVw==
X-Gm-Gg: ASbGncvpSABfYTfLrs6vpc+99n73El0BfVoR3hzWcpN+kktEEppszSFDgO/b+tegWPE
	SkG2DmXCublOPkv66BnkGmn4ZsDYTmvGDJxB9UtqxgTwNps779BiId65g5P+CUue0TYW1T82Rcw
	wiVIm08yaD6kmvo8yr4eezFwm6D6IUoN83GPS/dqBppQDRnWDWNL707/JtVJLWLS0kRhVSBXFbX
	ROES42bwTqXRfr3XoFopT8dTbMquHqccutSiwT80+ecgR0+cZEzRdgJyovokqYqo9mt9Q07+c3T
	RcUCD2DwcvfYnnMQ5VgKICmdNp0p6q7yARqYqHQyaLD3UDBsuu5zHvBT2qc+Kh/5HhY5ZU/oE1m
	1gY+sHAOAVjE=
X-Received: by 2002:a05:6000:4210:b0:3c4:39cc:36f with SMTP id ffacd0b85a97d-3c5dbf688dfmr2862480f8f.15.1755877875272;
        Fri, 22 Aug 2025 08:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhYN11+67rMBgz16ClnCnqW00MFOHXeorVtm9b6qqSJQjhx17u8yhR+uioZgE7EVgCclCrTQ==
X-Received: by 2002:a05:6000:4210:b0:3c4:39cc:36f with SMTP id ffacd0b85a97d-3c5dbf688dfmr2862428f8f.15.1755877874506;
        Fri, 22 Aug 2025 08:51:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1aa3sm15223353f8f.32.2025.08.22.08.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:51:14 -0700 (PDT)
Message-ID: <4feda9bd-0aba-4136-a1ca-07e713c991b7@redhat.com>
Date: Fri, 22 Aug 2025 17:51:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250821073047.2091-4-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 9:30 AM, Richard Gobert wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 68dc47d7e700..9941c39b5970 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3772,10 +3772,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	 * IPv4 header has the potential to be fragmented.
>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
> -		struct iphdr *iph = skb->encapsulation ?
> -				    inner_ip_hdr(skb) : ip_hdr(skb);
> -
> -		if (!(iph->frag_off & htons(IP_DF)))
> +		if (!(ip_hdr(skb)->frag_off & htons(IP_DF)) ||
> +		    (skb->encapsulation &&
> +		     !(inner_ip_hdr(skb)->frag_off & htons(IP_DF))))
>  			features &= ~NETIF_F_TSO_MANGLEID;

FWIW, I think the above is the problematic part causing GSO PARTIAL issues.

By default UDP tunnels do not set the DF bit, and most/all devices
implementing GSO_PARTIAL clear TSO for encapsulated packet when MANGLEID
is not available.

I think the following should workaround the problem (assuming my email
client did not corrupt the diff), but I also fear this change will cause
very visible regressions in existing setups.

Note that the current status is incorrect - GSO partial devices are
mangling the outer IP ID for encapsulated packets even when the outer
header IP DF is not set.

/P
---
diff --git a/tools/testing/selftests/drivers/net/hw/tso.py
b/tools/testing/selftests/drivers/net/hw/tso.py
index 3370827409aa..b0c71a0d8028 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -214,8 +214,8 @@ def main() -> None:
             # name,       v4/v6  ethtool_feature
tun:(type,    partial, args)
             ("",            "4", "tx-tcp-segmentation",           None),
             ("",            "6", "tx-tcp6-segmentation",          None),
-            ("vxlan",        "", "tx-udp_tnl-segmentation",
("vxlan",  True,  "id 100 dstport 4789 noudpcsum")),
-            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",
("vxlan",  False, "id 100 dstport 4789 udpcsum")),
+            ("vxlan",        "", "tx-udp_tnl-segmentation",
("vxlan",  True,  "id 100 dstport 4789 noudpcsum df set")),
+            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",
("vxlan",  False, "id 100 dstport 4789 udpcsum df set")),
             ("gre",         "4", "tx-gre-segmentation",
("gre",    False,  "")),
             ("gre",         "6", "tx-gre-segmentation",
("ip6gre", False,  "")),
         )


