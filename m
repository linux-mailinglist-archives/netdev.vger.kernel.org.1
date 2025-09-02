Return-Path: <netdev+bounces-219259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C8B40D12
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203F65E1983
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6211340D82;
	Tue,  2 Sep 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8MJklrJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65A32F77E;
	Tue,  2 Sep 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837329; cv=none; b=dy8UhQgkSLguE2EbtWdU34AUHLLF9cfPjF/jIZnqm2LlOm0mZNBtD/2zzDpkc/1tNLnHW4jWxOrtsNzPWvROzwpjN/kmXhudeKngSAM44tW6S4UL4Xr8uCLeDkg9bLdxCJEQziJWE0y3hrOOu88fTc6o88CJzhwQRXyJIRn4tNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837329; c=relaxed/simple;
	bh=09Y+YelbLpY/NYBRRZVlF/i6Xbbbg9GU3IZ9se5ijiM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IRQ0FQ6szW1uNuN/Rp5uYBo/m5Y/RTMxYBvPspR6JVOAD3ihmHfOoiLMNdnZOtaxwPHUfkOFRfa8vASNh8Yy0WAlLbMMqIC04JzOlpq5LG0rNQrnOj4LhVw+E7bGnhx0wSid+wu5RrRLnzM4C9aX+8pAxScGK++4f0wrUpMSFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8MJklrJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70ddab8117cso45948186d6.0;
        Tue, 02 Sep 2025 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756837327; x=1757442127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Su3MdH72LTe3eDBMYiwtYP+/SNjyccRO488QAGWI4aQ=;
        b=N8MJklrJu3A+SNfmxO7XKZtcI1E7HBgGRKHZsI2YozpYyzB1Ex/2rqrXu1KwdEBGTj
         W76XvkpbZdMPFRCVt6RovgFmzLlEIIHUgrETGah9kfheTmNYBdpMdy9rL4jkcncLAmOz
         493zKCs/Hc18RcJBnBUaLf4FJYxizr5jPjF0QzveOPPeyUmt8X4c+c4WZ4T8uAmFiw9Q
         fXV7xYioaNtHW3qy9WQKRbsQWBajcC1/DvePjJLckFoc/ZCL+eI0WsjRuv2NjXjwpVad
         W3oeIqHz1K7Y5Ud5NeW+LUvaHDTikJYvjf4MRmUyoVX03fFF/thjw98qFHnaUaGPsCxf
         3z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837327; x=1757442127;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Su3MdH72LTe3eDBMYiwtYP+/SNjyccRO488QAGWI4aQ=;
        b=aj/MXlZQJZrt1BLjsMrPwdY/J768jaBl2stelvOu0BUL3lDCo0cd0zdMuHIilFezJp
         DCxKfDzB8crfaPHas2FcB6u2zyIctTNJnfG7TfVl4O2WLGe83zOl88Owoj8cDgGvUrtP
         YUeO9IYffaKh9WdObCsqFCquf0D3JMIJMCbezIM7Sum+8ANghqaHZ2GF8KSjSVRuMXST
         CxLUFCXFFEk8DZacYjDI8uhb8uQb6x4I0YcWBF33xg/dPdKnXeHuF8C+lgHmmFk/E2CE
         ro0Qio3bXZHP7PygMx4QErmp0W877j4FWqmpciv/9uoo6Elr3+eXY1NnpNyC0/TIYpbz
         GnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeQCHUg5+8t5NaMzgnLz7CfRw4w++GMB/Gnr6M389Vo59qN9V/GYvMVY3jnb5vgmx2OhVd2nCYUo82WfI=@vger.kernel.org, AJvYcCXlxkbuXEFJV6MCFKwCUBQ7eSqlo48+gUt1nFOiBdmYNFYNKxTASNkR/foTgb3ME82vTVNl/fmH@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYV8YHr9dEIGRD1BWCzAhAngB+VF2Ka0/6qtT8v1MkBwgMklz
	i9sCH58UU5veoQiMMg4Mw6NLb4Bu+i5XRA5rAFYgqOMcj6t/KYSw8Zr/
X-Gm-Gg: ASbGncusYjb2STym3bQ7JK+02wWhUiMgYXzz4J6WOWOPYOLb4LTLamouNgZAlFz6NWi
	AWlVE6c/2bL+GRwb3POZ2a5nBzEpXnUqMs55Vd1Lf1LmAsMOEGAKXqNXaoKZuUHVGRPg3dLQzLJ
	CmhwPqW5yrmz0D4BXcrDgi1N3rxq7ju+u5xE0kzniKjN5wZpJ5xIl1gTlYPNPe0GDt9NBtxRq7v
	5rMFMP3FCzlIm4H67sInAUc2rfe5l3OOGh//pXFhAK4Xzup0qFWUCbqrfnn4duAo7PSZxZ13R9E
	58UvzreD9au07PiT/IciyPGH1823Y7m1hwckd0wGOHNQ+t/uz9q8WO3GLhHwB/zflEpFo1lhH7S
	KfXp/QSky2O2vO/PgY3jJ5p996a4fbz3Heivee6FqOt+wm4R58ea4FKqGBnF3o86w4r1ujtThv9
	KB4dOKzZrUv6en
X-Google-Smtp-Source: AGHT+IFIvzEBQgnK6eetlN2bpnuSxB8UJE/Yn9qspLPCCF+FJvqURpnC/Qa5bquc7GYU7oLhEsXXJw==
X-Received: by 2002:a05:6214:529b:b0:71c:53c0:569e with SMTP id 6a1803df08f44-71c53c05b4emr62015486d6.51.1756837326593;
        Tue, 02 Sep 2025 11:22:06 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-720b46661b9sm15949666d6.47.2025.09.02.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:22:06 -0700 (PDT)
Date: Tue, 02 Sep 2025 14:22:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 ecree.xilinx@gmail.com, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 willemdebruijn.kernel@gmail.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.2f9db40362380@gmail.com>
In-Reply-To: <20250901113826.6508-4-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
 <20250901113826.6508-4-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v4 3/5] net: gso: restore ids of outer ip headers
 correctly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> be mangled. Outer IDs can always be mangled.
> 
> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> both inner and outer IDs to be mangled.
> 
> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  .../networking/segmentation-offloads.rst        |  9 ++++-----
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  8 ++++++--
>  drivers/net/ethernet/sfc/ef100_tx.c             | 17 +++++++++++++----
>  include/linux/netdevice.h                       |  9 +++++++--
>  include/linux/skbuff.h                          |  6 +++++-
>  net/core/dev.c                                  |  4 +++-
>  net/ipv4/af_inet.c                              | 13 ++++++-------
>  net/ipv4/tcp_offload.c                          |  5 +----
>  8 files changed, 45 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
> index 085e8fab03fd..d5dccfc6b82b 100644
> --- a/Documentation/networking/segmentation-offloads.rst
> +++ b/Documentation/networking/segmentation-offloads.rst
> @@ -46,7 +46,9 @@ GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
>  ID and all segments will use the same IP ID.  If a device has
>  NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
>  and we will either increment the IP ID for all frames, or leave it at a
> -static value based on driver preference.
> +static value based on driver preference. For outer headers of encapsulated
> +packets, the device drivers must guarantee that the IPv4 ID field is
> +incremented in the case that a given header does not have the DF bit set.

Please split this into three paragraphs on FIXEDID, FIXED_INNER and
MANGLEID.

Specifically the use of FIXEDID to mean uncapped or outer should be
explicitly mentioned (as discussed previously).

Also, I understood that MANGLEID now means that both inner and outer
IP ID can be mangled. But this comment appears to say otherwise.
Maybe it helps to be more explicit also about behavior without DF.

>  Partial Generic Segmentation Offload
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11..505c4ce7cef8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c

> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
> index e6b6be549581..24971346df00 100644
> --- a/drivers/net/ethernet/sfc/ef100_tx.c
> +++ b/drivers/net/ethernet/sfc/ef100_tx.c

Not sure whether these driver changes need to be separate patches.

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f3a3b761abfb..3d19c888b839 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5290,13 +5290,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
>  
>  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
>  {
> -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
> +	netdev_features_t feature;
> +
> +	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
> +		gso_type |= __SKB_GSO_TCP_FIXEDID;
> +
> +	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
>  
>  	/* check flags correspondence */
>  	BUILD_BUG_ON(SKB_GSO_TCPV4   != (NETIF_F_TSO >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_DODGY   != (NETIF_F_GSO_ROBUST >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_TCP_ECN != (NETIF_F_TSO_ECN >> NETIF_F_GSO_SHIFT));
> -	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
> +	BUILD_BUG_ON(__SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_TCPV6   != (NETIF_F_TSO6 >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_FCOE    != (NETIF_F_FSO >> NETIF_F_GSO_SHIFT));
>  	BUILD_BUG_ON(SKB_GSO_GRE     != (NETIF_F_GSO_GRE >> NETIF_F_GSO_SHIFT));
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index ca8be45dd8be..cf95b325f9b4 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -674,7 +674,7 @@ enum {
>  	/* This indicates the tcp segment has CWR set. */
>  	SKB_GSO_TCP_ECN = 1 << 2,
>  
> -	SKB_GSO_TCP_FIXEDID = 1 << 3,
> +	__SKB_GSO_TCP_FIXEDID = 1 << 3,
>  
>  	SKB_GSO_TCPV6 = 1 << 4,
>  
> @@ -707,6 +707,10 @@ enum {
>  	SKB_GSO_FRAGLIST = 1 << 18,
>  
>  	SKB_GSO_TCP_ACCECN = 1 << 19,
> +
> +	/* These don't correspond with netdev features. */

Can use clarification. Something like

    /* These indirectly together map onto the same netdev feature:
     * If NETIF_F_TSO_MANGLE is set it may mangle both inner and outer.
     */
> +	SKB_GSO_TCP_FIXEDID = 1 << 30,
> +	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
>  };
>  
>  #if BITS_PER_LONG > 32
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 93a25d87b86b..f57c8dbf307f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3769,7 +3769,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  		features &= ~dev->gso_partial_features;
>  
>  	/* Make sure to clear the IPv4 ID mangling feature if the
> -	 * IPv4 header has the potential to be fragmented.
> +	 * IPv4 header has the potential to be fragmented. For
> +	 * encapsulated packets, the outer headers are guaranteed to
> +	 * have incrementing IDs if DF is not set.

This is saying that if !DF then both inner and outer must be
incrementing?

Maybe the outer headers are [also] garuanteed to have incrementing IDs.

>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
>  		struct iphdr *iph = skb->encapsulation ?
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 76e38092cd8a..fc7a6955fa0a 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1393,14 +1393,13 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>  
>  	segs = ERR_PTR(-EPROTONOSUPPORT);
>  
> -	if (!skb->encapsulation || encap) {
> -		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
> -		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
> +	/* fixed ID is invalid if DF bit is not set */
> +	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
> +	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
> +		goto out;
>  
> -		/* fixed ID is invalid if DF bit is not set */
> -		if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
> -			goto out;
> -	}
> +	if (!skb->encapsulation || encap)
> +		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
>  
>  	ops = rcu_dereference(inet_offloads[proto]);
>  	if (likely(ops && ops->callbacks.gso_segment)) {
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 1949eede9ec9..e6612bd84d09 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>  	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>  	struct tcphdr *th = tcp_hdr(skb);
> -	bool is_fixedid;
>  
>  	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
> @@ -485,10 +484,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>  				  iph->daddr, 0);
>  
> -	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
> -
>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
> -			(is_fixedid * SKB_GSO_TCP_FIXEDID);
> +			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);

This was only just introduced. And is still needed?


