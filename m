Return-Path: <netdev+bounces-226489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85844BA0FF7
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973901BC6CC1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2E314A75;
	Thu, 25 Sep 2025 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHP89Sjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F61DBB13
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824590; cv=none; b=uVlCaVu4CJ7io57ZXmMOQHA+7gSVktDoBTXEf8vY5cwQjVkeNY4i4BCNXBGFxpO1jcrdjnJ4Pno4VLhTNb2cW8/yimobbQzVMc/R6f/ecxk6/j1oAgfaPGL1CngnFzk3ZwtwTO7rWn5ZaZvq4hkvRbw5C7SL3MPveucpeTcmmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824590; c=relaxed/simple;
	bh=BvzO5IGPXAH8AszZvtVkeqN60wUfOELdmpWbB1Tyrks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0xB+y/r1DkbjFqwbP4Xop8kiiB1OUW1Mexp2NAF2vyrqunxHXqcmGay9rMsZjoFu+GPgQRAZFcMETvLp6Po9mfkm4S16q+C630SqcGFpLqpn/er0K4BNKCIPBq//0iELmdjSqFKfGhkJmGmZzOGrDcCez6BzWsDIVOk36AMBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHP89Sjh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26c209802c0so14276355ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758824588; x=1759429388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lth8QcyLx7F4pyBD6VMqUXYvqxSLPBEAdQsdCe6N6Dk=;
        b=gHP89SjhaeVcCCZb4T2BDpt5HAvZxzfVByhAuLOl0ZQ2hEgGd3h8KJM6f0avtl3hT6
         Byu4FlF3gyt+VPKOJ5dVQPzwv1o0uDYs+9AelQGY34UHqK3NipYrEfSEYdwfA5O1bJBk
         z7CMJ/apx+zVcHuzrBdbJ0JAOB4ZGEwRcmiH0AAM+GWA41g8PLtvLBDb7jrzh4v/khB7
         e5B1hVvwISLOXoa1U1jXcLHvMbi4gFJcMU0gjwLidVKHXnYpx/JI/NhXv2frOEU55X/L
         27rxKP/MK6aOArRzwrYXz5ZAsAbV05uElDZABQ3/PaSGE5+hIgattPwuGcWXMfMHMcVr
         sAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824588; x=1759429388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lth8QcyLx7F4pyBD6VMqUXYvqxSLPBEAdQsdCe6N6Dk=;
        b=fI5v439zMHOz0/yZqN5pn9vOdkT4qUMo1Vzq3AP4ITC4zwej3GZbnD/3ReGv+ICQzk
         ctRkDQrJFnsNc1LfPzed31BVxLJ9e/NgJLeevePyRlTs9ZJvYYpoQ3LHFiyrVXj1G1RS
         Co0/1ElFQ8Oh4G6FEaohW1AR4akeheJXK9lDvLJpuU1uHpY/zqM/OmsnE8OPQ+sfbrpt
         +t+IcpW4uxKVam8MA72xyJcOU8pAjiumyQnxGuq71UKhB0DEg9KNWc7SCP+HQxTUNKvV
         ENYj6/kQAbzL08QRuGoVswwBT+2OOOfX3dTr8tmg1HDaYtkohBIdgNfn61li5bsitQVO
         A9jA==
X-Forwarded-Encrypted: i=1; AJvYcCVR2Z/0qAqet+zzTMCXHB9BwtIISBMUVvPzYO3y3UWujlNjCZG53N/HdGQS+u1wGax3wIlLSik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeU2yJzg+XBVOzdlfOLr+gSH4oSDj3FzJoOQDWefaLQkkK/jP
	cEhNw8yc/fWtM8ayS30IwkYu/NgUAPXB1UfoAi6/yCHDmizt8kcZ2pg=
X-Gm-Gg: ASbGnctVaWSqy7dsKq9SVIeKxe4NSn2qbjiMFyMQwpgMjJMLb3J3sLUI9ne2wV07p6W
	zkdZSUw/Wxq1vZ55ta+PanAm51ckI+FjAFzX88iYEy8RaqB91SU7IMWX29CDUCVvj3oo1F7b6MC
	TjvkD2cIBZYC912B/mMMue1TyLfH5YiWiSfFh+7v8+zTiMnMci1Vil1SbQjTUK9iPdnmpLxxbz7
	uQyt0ST8mIfSYM9XPqdvuP2NkD/8leaygJsaB3AF2v19+Z2RX2zzK5/MyBZBtQDNxbVnvQufGUP
	tEYhz15xzgc07D8a9ssJDC8SuZB2mJ9BOwJA6WQ4m6V23ds8P9j7ZMfSwjk3x4JsMUrOwR+/wNc
	rQFyo9avTHlGJ+ksDDkufbLAYrYfuhDl5mAjYfHyvm3PHSSW5tPo8fDgXc82vUTMLH56n4Fb7/n
	6qJlWZSP2J4kd/Zg+fNRZz3fSqsrLLRt8nZtpK4+fXKX2MLLB66P+sp1lR0G+6kBJvH9i/Xvep9
	lxK
X-Google-Smtp-Source: AGHT+IHbywIdyU5hPvvl0ByoJgbnxSrHP20+PyoZRGg7GmIPpNtUuU/sZqQgcx7kwOHToZ4FpfpD6g==
X-Received: by 2002:a17:903:244c:b0:24b:25f:5f81 with SMTP id d9443c01a7336-27ed4a1a44bmr55472705ad.17.1758824588171;
        Thu, 25 Sep 2025 11:23:08 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3347500a554sm3089696a91.29.2025.09.25.11.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:23:07 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:23:07 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org, Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH net-next 01/17] net/ipv6: Introduce payload_len helpers
Message-ID: <aNWIi0Ni-kwUmYul@mini-arch>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
 <20250923134742.1399800-2-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250923134742.1399800-2-maxtram95@gmail.com>

On 09/23, Maxim Mikityanskiy wrote:
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> The next commits will transition away from using the hop-by-hop
> extension header to encode packet length for BIG TCP. Add wrappers
> around ip6->payload_len that return the actual value if it's non-zero,
> and calculate it from skb->len if payload_len is set to zero (and a
> symmetrical setter).
> 
> The new helpers are used wherever the surrounding code supports the
> hop-by-hop jumbo header for BIG TCP IPv6, or the corresponding IPv4 code
> uses skb_ip_totlen (e.g., in include/net/netfilter/nf_tables_ipv6.h).
> 
> No behavioral change in this commit.
> 
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---
>  include/linux/ipv6.h                       | 20 ++++++++++++++++++++
>  include/net/ipv6.h                         |  2 --
>  include/net/netfilter/nf_tables_ipv6.h     |  4 ++--
>  net/bridge/br_netfilter_ipv6.c             |  2 +-
>  net/bridge/netfilter/nf_conntrack_bridge.c |  4 ++--
>  net/ipv6/ip6_input.c                       |  2 +-
>  net/ipv6/ip6_offload.c                     |  7 +++----
>  net/ipv6/output_core.c                     |  7 +------
>  net/netfilter/ipvs/ip_vs_xmit.c            |  2 +-
>  net/netfilter/nf_conntrack_ovs.c           |  2 +-
>  net/netfilter/nf_log_syslog.c              |  2 +-
>  net/sched/sch_cake.c                       |  2 +-
>  12 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 43b7bb828738..44c4b791eceb 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -126,6 +126,26 @@ static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
>  	       skb_network_header_len(skb);
>  }
>  
> +static inline unsigned int ipv6_payload_len(const struct sk_buff *skb, const struct ipv6hdr *ip6)
> +{
> +	u32 len = ntohs(ip6->payload_len);
> +
> +	return (len || !skb_is_gso(skb) || !skb_is_gso_tcp(skb)) ?
> +	       len : skb->len - skb_network_offset(skb) - sizeof(struct ipv6hdr);

Any reason not to return skb->len - skb_network_offset(skb) - sizeof(struct ipv6hdr)
here unconditionally? Will it not work in some cases?

