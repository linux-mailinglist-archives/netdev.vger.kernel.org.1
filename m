Return-Path: <netdev+bounces-194711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40512ACC126
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF1516ABAA
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B91267F76;
	Tue,  3 Jun 2025 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIWvsQmK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF95849C;
	Tue,  3 Jun 2025 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935393; cv=none; b=K4IHyglzWSSSbkj0w5zWZsn8jjJLo0NR8YlDvo5+C2vpr12QXvCmdKRKsMEhDYndfSL1mCKmrD5P/xXcpugTrUMS0l3usfzcD7QKzI4lFedO3xJLGrt04xsn1UjTFDmIEPY9BZGzD6KCfOFEheKQB8eCYJyCj9DmlEa7t1meHnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935393; c=relaxed/simple;
	bh=liSBMkhtYRvVo/I68B65sk7/MBVBJ0KQsB2GKGJwAyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9fIVeJ1h4TXc4/rn6Y3L7s4Tf/CgIK9fAzBrZnJATFJIN1U3dXrej+bjYrl+7WdfyMGLmIa+yGVHoLt+/3vqUf2XHTGLtiUJPlUQfi/sgji5JTaY8DzcuNeJj55ZSa/v13ssDQxweAfXpBkhk/y7CjzoP0UAcgiKcewP2YxwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIWvsQmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1468AC4CEED;
	Tue,  3 Jun 2025 07:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748935393;
	bh=liSBMkhtYRvVo/I68B65sk7/MBVBJ0KQsB2GKGJwAyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIWvsQmK9inIdht0I2MPla+pCpAekj2unXR9xa63WlyTXxcY5XmqCPBOA1EauWuA5
	 lJUseeubcbn52QwHshyc8A/wjJJ4yzXnxxXLbSucUIM+yjfYrkZlJunGK8J6nb3aqf
	 GmBp1DlzwWT5SPj48bXgxpRtBgfQkI5Za/8EZxrzsKU2PtJxtLhHg+1b17GchjgNcf
	 WA08VrP1mNBavjZqwoYFBFB1Ta5pNKKm47zgsksuEFlVPBqHlcyyONAQmwnV0H7TQ5
	 fpa3+xkyg3ziCazjEZjOeZyoG1GjUijQ+PT/YDd0SwwtegO9J9FTC8wsJlFIoOPHXg
	 BOI1aH3boMCzw==
Date: Tue, 3 Jun 2025 08:23:08 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org, Guolin Yang <guolin.yang@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4] vmxnet3: correctly report gso type for UDP tunnels
Message-ID: <20250603072308.GW1484967@horms.kernel.org>
References: <20250530152701.70354-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530152701.70354-1-ronak.doshi@broadcom.com>

On Fri, May 30, 2025 at 03:27:00PM +0000, Ronak Doshi wrote:
> Commit 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing
> in a tunnel") added checks in linux stack to not accept non-tunnel
> GRO packets landing in a tunnel. This exposed an issue in vmxnet3
> which was not correctly reporting GRO packets for tunnel packets.
> 
> This patch fixes this issue by setting correct GSO type for the
> tunnel packets.
> 
> Currently, vmxnet3 does not support reporting inner fields for LRO
> tunnel packets. The issue is not seen for egress drivers that do not
> use skb inner fields. The workaround is to enable tnl-segmentation
> offload on the egress interfaces if the driver supports it. This
> problem pre-exists this patch fix and can be addressed as a separate
> future patch.
> 
> Fixes: dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload support")
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>
> 
> Changes v1-->v2:
>   Do not set encapsulation bit as inner fields are not updated
> Changes v2-->v3:
>   Update the commit message explaining the next steps to address
>   segmentation issues that pre-exists this patch fix.
> Changes v3->v4:
>   Update the commit message to clarify the workaround.
> ---
>  drivers/net/vmxnet3/vmxnet3_drv.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
> index c676979c7ab9..287b7c20c0d6 100644
> --- a/drivers/net/vmxnet3/vmxnet3_drv.c
> +++ b/drivers/net/vmxnet3/vmxnet3_drv.c
> @@ -1568,6 +1568,30 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
>  	return (hlen + (hdr.tcp->doff << 2));
>  }
>  
> +static void
> +vmxnet3_lro_tunnel(struct sk_buff *skb, __be16 ip_proto)
> +{
> +	struct udphdr *uh = NULL;
> +
> +	if (ip_proto == htons(ETH_P_IP)) {
> +		struct iphdr *iph = (struct iphdr *)skb->data;
> +
> +		if (iph->protocol == IPPROTO_UDP)
> +			uh = (struct udphdr *)(iph + 1);
> +	} else {
> +		struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
> +
> +		if (iph->nexthdr == IPPROTO_UDP)
> +			uh = (struct udphdr *)(iph + 1);
> +	}

Hi Ronak,

Possibly a naive question, but does skb->data always contain an iphdr
or ipv6hdr? Or perhaps more to the point, is it safe to assume IPv6
is ip_proto is not ETH_P_IP?

> +	if (uh) {
> +		if (uh->check)
> +			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
> +		else
> +			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
> +	}
> +}
> +
>  static int
>  vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
>  		       struct vmxnet3_adapter *adapter, int quota)
> @@ -1881,6 +1905,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
>  			if (segCnt != 0 && mss != 0) {
>  				skb_shinfo(skb)->gso_type = rcd->v4 ?
>  					SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> +				if (encap_lro)
> +					vmxnet3_lro_tunnel(skb, skb->protocol);
>  				skb_shinfo(skb)->gso_size = mss;
>  				skb_shinfo(skb)->gso_segs = segCnt;
>  			} else if ((segCnt != 0 || skb->len > mtu) && !encap_lro) {
> -- 
> 2.45.2
> 
> 

