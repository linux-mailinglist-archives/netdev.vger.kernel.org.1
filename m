Return-Path: <netdev+bounces-161976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF4A24DB3
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 12:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F5C1629E0
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8921D63CA;
	Sun,  2 Feb 2025 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+O613uu"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389B1D5154
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738497404; cv=none; b=Td//6VtWTIcL1tTya6rg5AxUZwQEkJK4f/WiF8xPRcei/tUiofPe+3c8WDNb5Tzs+3xxf9S0kEOZ02Rrra39fxjAzPsacdQvztVWWtOCNk9JpoF4hhBHk1wSO63wsFPbxEnBSskEdBXcMJq5GwzDW8o32IogQCQ9MQSRH6R2irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738497404; c=relaxed/simple;
	bh=fRIUKn7OrTqxa7o+dvQk15KIpG2ZEFeu6muH7LJrp34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx0s+VUpXT0fphNhFGhcj0LBu0exRM5p5ILOAjnEqjxsyTHdMHIr336STXs8d8jRuvozGM3Xf3SXN7/nUGu0nDT6T+5LYeoS4DPnqF7PCVFHcUjExDAwpctjzjF3f6/rhuPsZ8Zrs88+RV6KkamsqPPpgUc7AR1Q0dOzXCmQrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+O613uu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6E0825400D6;
	Sun,  2 Feb 2025 06:56:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 02 Feb 2025 06:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738497400; x=1738583800; bh=SWR9Td9xl2hHBybqQqYI9NIWC64LXbAh4sV
	trWv8gd4=; b=p+O613uu8Kv2JR5eKxiFlWWn/gEBXXAUgk1mYtODngi/8PG7E9d
	OXghtknaDDhPWpZqwqO2LY0zOWD6kZnL1n2m3yAa2r1/a/NwDJuwrSmYc5UUXx0N
	PhhuIStL3WtJ/8voMBdvcdrluybqdTi3w1rkl7Yr1D9plVFvVIBX+dzQV+q/5lFq
	n7TxgmElSGmAq2A806AQa37N4GybZIKDSvUfi6Ds0ncaUZ67LyFrCtMr1IISMpKb
	k4ccbQei7QtqnUAkwwhjCOkcgYKT3A9k5TxYqjhfzqIDf0yOi3qFNxKe3dgE7mCl
	Hl21WX+CVNJQgHn5KHunSi3o4FD+fwHTprQ==
X-ME-Sender: <xms:eF2fZ3_z_vt8kuydbYyWnoIDDKIPgICO2XmPDsUxl29yqUlB8uuGvA>
    <xme:eF2fZzvjWz11u7qoRspoMbK5SRlNCZs1p_yu07vhVd7sDBSzZDxUmIvGvcvU_fzRj
    rdU7vWh7oL0LPA>
X-ME-Received: <xmr:eF2fZ1AaC0ok1-S7XO_c4NyisXXXl3-b7V7tauFmAM6x7vghMSX6RYKnVDLDMBVFUNq97JniNDlPTRRkzMsPePN9MOWkVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiinhhstghntghhvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eF2fZzeAAWf_jvfldOU82o8LtL2lQx1jRyrBd7nmGP91aExHV5NXrA>
    <xmx:eF2fZ8PFzFWaoKsvvPxHFyew3vdXABkp_gtvv-jiP6ULRh84CZLO4g>
    <xmx:eF2fZ1kCiGwc-GBJmfUe94fyns66BInWPwyEMj2WqAF4-ovdfVLI0w>
    <xmx:eF2fZ2uHrjKwFSxp2wTXrWmvYgA9Sla3LwAk9TVcY5uP54sNig3D9Q>
    <xmx:eF2fZ4A2nJrIZSQp0gE7dCjYQD62Js5mJywY8_YYHR8cvRcbmvX1jQG0>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 06:56:39 -0500 (EST)
Date: Sun, 2 Feb 2025 13:56:36 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Ted Chen <znscnchen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/3] vxlan: vxlan_vs_find_vni(): Find
 vxlan_dev according to vni and remote_ip
Message-ID: <Z59ddOmNCCIlFwm9@shredder>
References: <20250201113207.107798-1-znscnchen@gmail.com>
 <20250201113400.107815-1-znscnchen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201113400.107815-1-znscnchen@gmail.com>

On Sat, Feb 01, 2025 at 07:34:00PM +0800, Ted Chen wrote:
> vxlan_vs_find_vni() currently searches the vni hash table in a vs and
> returns a vxlan_dev associated with the specified "vni". While this works
> when the remote_ips are stored in the vxlan fdb, it fails to handle the
> case where the remote_ip is just configured in the vxlan device outside of
> the vxlan fdb, because multiple vxlan devices with different remote_ip may
> share a single vni when the remote_ip is configured in the vxlan device
> (i.e., not stored in the vxlan fdb). In that case, further check of
> remote_ip to identify vxlan_dev more precisely.
> 
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 05c10acb2a57..3ca74a97c44f 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -94,8 +94,10 @@ static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
>  
>  static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
>  					   int ifindex, __be32 vni,
> +					   const struct sk_buff *skb,
>  					   struct vxlan_vni_node **vninode)
>  {
> +	union vxlan_addr saddr;
>  	struct vxlan_vni_node *vnode;
>  	struct vxlan_dev_node *node;
>  
> @@ -116,14 +118,31 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
>  			continue;
>  		}
>  
> -		if (IS_ENABLED(CONFIG_IPV6)) {
> -			const struct vxlan_config *cfg = &node->vxlan->cfg;
> +		const struct vxlan_config *cfg = &node->vxlan->cfg;
>  
> +		if (IS_ENABLED(CONFIG_IPV6)) {
>  			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
>  			    cfg->remote_ifindex != ifindex)
>  				continue;
>  		}
>  
> +		if (vni && !vxlan_addr_any(&cfg->remote_ip) &&
> +		    !vxlan_addr_multicast(&cfg->remote_ip)) {
> +			/* Get address from the outer IP header */
> +			if (vxlan_get_sk_family(vs) == AF_INET) {
> +				saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
> +				saddr.sa.sa_family = AF_INET;
> +#if IS_ENABLED(CONFIG_IPV6)
> +			} else {
> +				saddr.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
> +				saddr.sa.sa_family = AF_INET6;
> +#endif
> +			}
> +
> +			if (!vxlan_addr_equal(&cfg->remote_ip, &saddr))
> +				continue;

This breaks existing behavior. Before this patch, a VXLAN device with a
remote address could receive traffic from any VTEP (in the same
broadcast domain).

I think this patch misinterprets the "remote" keyword as P2P when it is
not the case. It is merely the VTEP to which packets are sent when no
other VTEP was found in the FDB. A VXLAN device that was configured with
the "remote" keyword can still send packets to other VTEPs and it should
therefore be able to receive packets from them.

> +		}
> +
>  		if (vninode)
>  			*vninode = vnode;
>  		return node->vxlan;
> @@ -134,6 +153,7 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
>  
>  /* Look up VNI in a per net namespace table */
>  static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
> +					const struct sk_buff *skb,
>  					__be32 vni, sa_family_t family,
>  					__be16 port, u32 flags)
>  {
> @@ -143,7 +163,7 @@ static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
>  	if (!vs)
>  		return NULL;
>  
> -	return vxlan_vs_find_vni(vs, ifindex, vni, NULL);
> +	return vxlan_vs_find_vni(vs, ifindex, vni, skb, NULL);
>  }
>  
>  /* Fill in neighbour message in skbuff. */
> @@ -1701,7 +1721,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  
>  	vni = vxlan_vni(vh->vx_vni);
>  
> -	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
> +	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, skb, &vninode);
>  	if (!vxlan) {
>  		reason = SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND;
>  		goto drop;
> @@ -1855,7 +1875,7 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
>  		return -ENOENT;
>  
>  	vni = vxlan_vni(hdr->vx_vni);
> -	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, NULL);
> +	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, skb, NULL);
>  	if (!vxlan)
>  		return -ENOENT;
>  
> @@ -2330,7 +2350,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
>  		struct vxlan_dev *dst_vxlan;
>  
>  		dst_release(dst);
> -		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
> +		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, skb, vni,
>  					   addr_family, dst_port,
>  					   vxlan->cfg.flags);
>  		if (!dst_vxlan) {
> -- 
> 2.39.2
> 
> 

