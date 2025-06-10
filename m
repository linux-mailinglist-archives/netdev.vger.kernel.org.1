Return-Path: <netdev+bounces-196127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93332AD3977
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E68189362C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55425B2E8;
	Tue, 10 Jun 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwVRxNTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BD25B30D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562423; cv=none; b=Jt4cCwKsqnyqWvwP6XXN/dKTw89IxJmpNifFhQUARIGvBGmOuYM0xx9DZii0bNKJ3AKEhPiLWpRukU3J/o9yVh1FReJQl1SQEBlXuz+2pK9zVPSAve4AIyjxpzxQI49lRxhvIDEIDDP7cjLETtchKpA6dHOXblkfaBxAnUW0IuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562423; c=relaxed/simple;
	bh=d0ILdc17F3hDXmqW9dvG8xwm0xe6WhIKaAEZqIjnUyA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NdmRdQU8pdAk1WOhYXjzClXXMMzElRtj1WGc/0y959DAjFotV0yGcMhNLC+1N+zzAT77Ia1ivSy4LSgKdVJSY/K43hNZ769CT5HQq8+WJ9aebXMPnBXhdcc6I3RgF6v/L51lzzhMn89plsd/wz9oTKTxRxqxmV+Cq9OoD0LAYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwVRxNTI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-710ffc7a051so33347447b3.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749562421; x=1750167221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MTQ7F94zQvvImf3C4yGrCAHxPf7R8m0OICLYFFUztQ=;
        b=MwVRxNTICDp7kYzmsiRmtIpoq4shi1LSyNXpY2eTBb+veXthze9N7ZUM6R/+FCbm13
         GdU5CWhymAOHtkblrvwd15yTSWvZUxV6n+PiXZfT0WIR5Rh3Jv3VknLsrLr3oYaZnBhs
         TD/mjfjORk4NbvMFL3dp3SKayIAuH6JrHj2B0X0Jg1ReM5jSJHwGzcupdXA6HpMYThHO
         eEb1H6WzafheimBycjWUhTHw8XfkYOWYNm9VUuFw2raIw1qXrZdt8sL9+q6H6xfCWIjR
         MGBSS0Ardl8/feiNLtyO4iri27XcXoLmi0V9L1DSj8vUayIJ2dGk/MQnoRBc3aQhGwhr
         JKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749562421; x=1750167221;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0MTQ7F94zQvvImf3C4yGrCAHxPf7R8m0OICLYFFUztQ=;
        b=MLxpPFw3o419aCRcwt8+A6zTUcG/3fyNjkXMh2uZm2HPUxpGgZAuh685ZOPesuIOyz
         lXsdoxSvGEbnyGoNFN4MVFlI9OfbPpgmM2ZtuEwkqRWJ9ebI0ITYJU0nKYQ6TdLSa3rq
         q9lpsTiJHjBilfP9fEuUproma0AFXY1S26z85BzAP9TqbVpPdeRxnjVHpBshrQHtHchD
         d28D1DPwALPmp6uIrTpKXr8LeyViHonToVeutYsqlpTSxxN3bamYmf5BiDVqO4ToeBVm
         yU9VMaZ/vjHK/kOZTKI17G2hwxhNGNBoIaVIbOsB8/oanFivzNrBQXGZoAMXtqtMQWxJ
         6/PA==
X-Forwarded-Encrypted: i=1; AJvYcCXOGcW+04vkGREGhXiVaMnijSklIpWu38GHGapPH1tTZzE77cl3Ow4pfd41aDXZpdr8Xj0ghLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVy81otuU7XOxhHJ/yK3ZZ82YbRf4nIQup+tydFMo3WK+qCxT
	JjcnN+b3UXeovSgsO0nehgkhjVk3wE3bJGDVH9wJCYNtPDVzK1K/uouO
X-Gm-Gg: ASbGncs2y9pPl/lh2Hzklpl28hcV5cY763XEcNDd33zmeVm8vMWdUNp8LcunsYlxG35
	bom53KriDxgD6vo1HsDeQCqYOkUDJ7cgdsvq8EwE/ihNO9App90huJ7gFg40w/D7H1XTSoUouG2
	AAcbbKz9m0yQ9U0iqTkLsJp2szFPWOjz0rhf0kpupreyCa2UQga+kPqyVq2Jft0HcygxRq6rfOD
	h996MxLUP7BdzJNE6jz3qE1tQKLDr7ASHglaCNADPKdqHm1r6NCiyKW/zEM94LiqBQQ81n38vyl
	IbsNAaz2tBwEaQRuEJMiLSTkBgfW3taJOncWXLifaDxhIDCKJhZ14BqajIcQ5/c9t/3dGkxPb9u
	PwHvcy2F31lpfJrIRLyNlFlOywjBPliQf5fEZlUUqMQ==
X-Google-Smtp-Source: AGHT+IFQqoFPZdc1EHQWYGJAa1JD5mqcEJnQ35MjM/VBhasrDa3U5O38CRxu7n6w7cmdySxfksI3Mw==
X-Received: by 2002:a05:690c:4902:b0:710:f6fa:e8fb with SMTP id 00721157ae682-710f77372cfmr242993757b3.35.1749562420769;
        Tue, 10 Jun 2025 06:33:40 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-710f98b8ba8sm16354027b3.12.2025.06.10.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:33:40 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:33:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com
Cc: willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 andrew@lunn.ch, 
 ecree.xilinx@gmail.com
Message-ID: <68483433b45e2_3cd66f29440@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250609173442.1745856-3-kuba@kernel.org>
References: <20250609173442.1745856-1-kuba@kernel.org>
 <20250609173442.1745856-3-kuba@kernel.org>
Subject: Re: [RFC net-next 2/6] net: ethtool: support including Flow Label in
 the flow hash for RSS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Some modern NICs support including the IPv6 Flow Label in
> the flow hash for RSS queue selection. This is outside
> the old "Microsoft spec", but was included in the OCP NIC spec:
> 
>   [ ] RSS include ow label in the hash (configurable)
> 
> https://www.opencompute.org/documents/ocp-server-nic-core-features-specification-ocp-spec-format-1-1-pdf

Or perhaps https://www.opencompute.org/w/index.php?title=Core_Offloads#Receive_Side_Scaling

One thing to make very clear is that in this design the flow label is
an extra field to include. It does not replace the L4 fields.

This is perhaps mistaken. The IPv6 flow label definition is

"Packet classifiers can
 use the triplet of Flow Label, Source Address, and Destination
 Address fields to identify the flow to which a particular packet
 belongs."

https://datatracker.ietf.org/doc/html/rfc6437#section-2

So explicitly also hashing in the L4 fields should not be needed.

Generally the flow label includes the L4 ports in its initial value.
Though PLB, through sk_rethink_txhash, will remove that.

Similarly an IPv6 tunneled packet should no longer need hashing of
it inner layer(s) if the outer flow label is sufficiently computed by
the source to identify a single flow. AFAIK that was the entire point
of this field.

That said, it is always safe to include the L4 fields as well. And in
the end what matters is configuring what the hardware already
supports.
 
> RSS Flow Label hashing allows TCP Protective Load Balancing (PLB)
> to recover from receiver congestion / overload.
> Rx CPU/queue hotspots are relatively common for data ingest
> workloads, and so far we had to try to detect the condition
> at the RPC layer and reopen the connection. PLB lets us change
> the Flow Label and therefore Rx CPU on RTO, with minimal packet
> reordering. PLB reaction times are much faster, and can happen
> at any point in the connection, not just at RPC boundaries.
> 
> Due to the nature of host processing (relatively long queues,
> other kernel subsystems masking IRQs for 100s of msecs)
> the risk of reordering within the host is higher than in
> the network. But for applications which need it - it is far
> preferable to potentially persistent overload of subset of
> queues.
> 
> It is expected that the hash communicated to the host
> may change if the Flow Label changes. This may be surprising
> to some host software, but I don't expect the devices
> can compute two Toeplitz hashes, one with the Flow Label
> for queue selection and one without for the rx hash
> communicated to the host. Besides, changing the hash
> may potentially help to change the path thru host queues.
> User can disable NETIF_F_RXHASH if they require a stable
> flow hash.
> 
> The name RXH_IP6_FL was chosen based on what we call
> Flow Label variables in IPv6 processing (fl). I prefer
> fl_lbl but that appears to be an fbnic-only spelling.
> We could spell out RXH_IP6_FLOW_LABEL but existing
> RXH_ defines are a lot more terse.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: ecree.xilinx@gmail.com
> ---
>  include/uapi/linux/ethtool.h |  1 +
>  net/ethtool/ioctl.c          | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 707c1844010c..fed36644eb1d 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2380,6 +2380,7 @@ enum {
>  #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
>  #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
>  #define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
> +#define	RXH_IP6_FL	(1 << 9) /* IPv6 flow label */
>  #define	RXH_DISCARD	(1 << 31)
>  
>  #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index e8ca70554b2e..181ec2347547 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1013,6 +1013,28 @@ static bool flow_type_hashable(u32 flow_type)
>  	return false;
>  }
>  
> +static bool flow_type_v6(u32 flow_type)
> +{
> +	switch (flow_type) {
> +	case TCP_V6_FLOW:
> +	case UDP_V6_FLOW:
> +	case SCTP_V6_FLOW:
> +	case AH_ESP_V6_FLOW:
> +	case AH_V6_FLOW:
> +	case ESP_V6_FLOW:
> +	case IPV6_FLOW:
> +	case GTPU_V6_FLOW:
> +	case GTPC_V6_FLOW:
> +	case GTPC_TEID_V6_FLOW:
> +	case GTPU_EH_V6_FLOW:
> +	case GTPU_UL_V6_FLOW:
> +	case GTPU_DL_V6_FLOW:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* When adding a new type, update the assert and, if it's hashable, add it to
>   * the flow_type_hashable switch case.
>   */
> @@ -1066,6 +1088,9 @@ ethtool_srxfh_check(struct net_device *dev, const struct ethtool_rxnfc *info)
>  	const struct ethtool_ops *ops = dev->ethtool_ops;
>  	int rc;
>  
> +	if (info->data & RXH_IP6_FL && !flow_type_v6(info->flow_type))
> +		return -EINVAL;
> +
>  	if (ops->get_rxfh) {
>  		struct ethtool_rxfh_param rxfh = {};
>  
> -- 
> 2.49.0
> 



