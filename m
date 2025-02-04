Return-Path: <netdev+bounces-162519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F07A272CF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48D4161A0D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571220D4EA;
	Tue,  4 Feb 2025 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0mHdaj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEA29CEB
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674547; cv=none; b=VilmzNNvCUkrccM8TBQbx7YFVGJLV/F0YGY5As4NkgqkCnonwkM1Kn5B/8p9VUAISz33D6HakGK1rFTqy+Lvnb+B0N/6z6CLt4NoBRcCJF164VcqYf0CUqHDEsWBBz127o7veUosFpxMzPd6IHGXGu1T4h2ZiYrrkAQFsf6FGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674547; c=relaxed/simple;
	bh=cn2yvlKLZgiUAM5mpQ/1PbFMu/I8esNVr0HlqR/7NXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2ICJmes/dFIRpxil0ZaoesGaTIHTAGvKbOBww8yuynu2Q4IWDEPsXpnYwqWGtfAaR2JxgoiB65C6LE5FgVSS3y4VsZ+n2CHSAxuqdotMWYZiddVhWRTC+FmT0gTeP7EaHpre+786qpQgbwKrh6VhQsw+Byfvfp39TjUTrbCLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0mHdaj8; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f6b65c89c4so1244592eaf.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738674544; x=1739279344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhSWoiKUo1O3tJHTwsYWKFVLgeiP8FqmYKEJRxXqPdE=;
        b=W0mHdaj8US0UzjIWWGmM4b+ra36zbe3uuWh3yI2OjE0/iqCj3Q7d8D9Z29UNS6GOAW
         SnMwZ7HubjpV/tbUMa5sSlpU8o14LVl8vNX1kYHUp7JCiwj/A3OvBSyTOlG47zyb1Se9
         A3SspEdqqT/pRsMnIb9YBg38VM5H3jW2ukPPMenp1FS1AomdOp9HyAv8DWeUDPn3VOq4
         PWX5kb7ZaqUEOApPW0AdUh8fy4hQGS9kxiRbqwQ74LIAGegMRg7jQbYFRfMXWUXLkSKj
         llAGMc7qoDTAnypfT9l7Dk+s0GuCie9UUf87IM0RMs4R0LncLAjr7fD/I9wDMCroItpv
         rFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738674544; x=1739279344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhSWoiKUo1O3tJHTwsYWKFVLgeiP8FqmYKEJRxXqPdE=;
        b=VQKye0PxVqGNKMsN5kTHdsK/dN4e95lJEr0wRMyc5Au7g1eLGbjEZbsrXjWXE57R/y
         Iq2PpAA04pZ5AnIeIJI3d+cnD3JWBeFUrhF+COQHXWwjuiSkFcVSiuZsKq3xFfOfnDT4
         vKT08SK+pZ2ZnfDxEWwpyUiSRbIm9TavNmneLURRyZ0BCT5NQwEOCQRWG0LVz+ukQvM5
         NZxQfZxLDVsknwF3v5opLOtf/H5E5dOOGS/dsqw3g6fZBVhk9ilc1QvYJe3lOYhbH+zH
         pLnuumN7CmjZ7utdRF4cx+Oz8vq5+7caN47LSBLV4jowzEj7IUzsd70uiIbJorFwLFG+
         9HSw==
X-Forwarded-Encrypted: i=1; AJvYcCUupKsgRtodEF2hxK4f8exgxkhpIrRWhiCt0weG6DY7GIzjXqL8iWQMuEFQA/mfUTTCZ209eM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TebxCZqnh6NeyBW65A9VpoR7DrfN84L6X1+q6MS7JzswwH3m
	K3ED+5xecxGIpx1Oz+q6/vpU4iPn5all6Ilh4ZxU+6Wa7C0k5tQ=
X-Gm-Gg: ASbGncs+fRTiOM6kgwAra2sClzTwWKcymEdre7GxuqvhFKhF02AYKu7frdz1mvpE+jv
	JbRDXKr+7N29vWoSjOM2caN/vnfTDBYTJpewpkBLFQXVRHSL6g4WIkuF/f9d6ClSxpSlKZNSeu2
	+3mpERCHOe4lK1XCbOb2XFZhRGwX2RZnOzJQ9JEV1c24PrUyn9Ri5huf2TKiJNI3gqUoueZMrb/
	jomali8XUIhj9FQQN7H4wMMdkaMKXYO/jzb9oKNJ7kF5yEhciQel2Dwf9eI1JxLdJBHwPUqOO0M
	m4kT/+/VdNkV
X-Google-Smtp-Source: AGHT+IGWN3stU86xbQSqlpqRWstc0T/qwmAZx2NScz1pGIhPeP4zyRxphT7d0qUJqIvKImV6eh1nDw==
X-Received: by 2002:a05:6870:ff8c:b0:29e:362b:2162 with SMTP id 586e51a60fabf-2b32f098fccmr13966645fac.20.1738674544313;
        Tue, 04 Feb 2025 05:09:04 -0800 (PST)
Received: from t-dallas ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b3565b895fsm3969576fac.33.2025.02.04.05.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 05:09:03 -0800 (PST)
Date: Tue, 4 Feb 2025 21:09:02 +0800
From: Ted Chen <znscnchen@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/3] vxlan: vxlan_vs_find_vni(): Find
 vxlan_dev according to vni and remote_ip
Message-ID: <Z6IRbns62vv7eJIg@t-dallas>
References: <20250201113207.107798-1-znscnchen@gmail.com>
 <20250201113400.107815-1-znscnchen@gmail.com>
 <Z59ddOmNCCIlFwm9@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z59ddOmNCCIlFwm9@shredder>

On Sun, Feb 02, 2025 at 01:56:36PM +0200, Ido Schimmel wrote:
> On Sat, Feb 01, 2025 at 07:34:00PM +0800, Ted Chen wrote:
> > vxlan_vs_find_vni() currently searches the vni hash table in a vs and
> > returns a vxlan_dev associated with the specified "vni". While this works
> > when the remote_ips are stored in the vxlan fdb, it fails to handle the
> > case where the remote_ip is just configured in the vxlan device outside of
> > the vxlan fdb, because multiple vxlan devices with different remote_ip may
> > share a single vni when the remote_ip is configured in the vxlan device
> > (i.e., not stored in the vxlan fdb). In that case, further check of
> > remote_ip to identify vxlan_dev more precisely.
> > 
> > Signed-off-by: Ted Chen <znscnchen@gmail.com>
> > ---
> >  drivers/net/vxlan/vxlan_core.c | 32 ++++++++++++++++++++++++++------
> >  1 file changed, 26 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> > index 05c10acb2a57..3ca74a97c44f 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -94,8 +94,10 @@ static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
> >  
> >  static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
> >  					   int ifindex, __be32 vni,
> > +					   const struct sk_buff *skb,
> >  					   struct vxlan_vni_node **vninode)
> >  {
> > +	union vxlan_addr saddr;
> >  	struct vxlan_vni_node *vnode;
> >  	struct vxlan_dev_node *node;
> >  
> > @@ -116,14 +118,31 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
> >  			continue;
> >  		}
> >  
> > -		if (IS_ENABLED(CONFIG_IPV6)) {
> > -			const struct vxlan_config *cfg = &node->vxlan->cfg;
> > +		const struct vxlan_config *cfg = &node->vxlan->cfg;
> >  
> > +		if (IS_ENABLED(CONFIG_IPV6)) {
> >  			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
> >  			    cfg->remote_ifindex != ifindex)
> >  				continue;
> >  		}
> >  
> > +		if (vni && !vxlan_addr_any(&cfg->remote_ip) &&
> > +		    !vxlan_addr_multicast(&cfg->remote_ip)) {
> > +			/* Get address from the outer IP header */
> > +			if (vxlan_get_sk_family(vs) == AF_INET) {
> > +				saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
> > +				saddr.sa.sa_family = AF_INET;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +			} else {
> > +				saddr.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
> > +				saddr.sa.sa_family = AF_INET6;
> > +#endif
> > +			}
> > +
> > +			if (!vxlan_addr_equal(&cfg->remote_ip, &saddr))
> > +				continue;
> 
> This breaks existing behavior. Before this patch, a VXLAN device with a
> remote address could receive traffic from any VTEP (in the same
> broadcast domain).
> 
> I think this patch misinterprets the "remote" keyword as P2P when it is
> not the case. It is merely the VTEP to which packets are sent when no
Yes. Thanks for pointing that out. 
I didn't see target addresses were appended into the FDB when an unicast
remote_ip had been configured.

e.g.
Usually when (2)(3) are invoked, (1) is not called to configure a unicast
remote_ip to the VTEP (though it's allowed to call (1)).

(1) ip link add vxlan42 type vxlan id 42 \
                local 10.0.0.1 remote 10.0.0.2 dstport 4789
(2) bridge fdb append to 00:00:00:00:00:00 dst 10.0.0.3 dev vxlan42
(3) bridge fdb append to 00:00:00:00:00:00 dst 10.0.0.4 dev vxlan42

So, this patch just leverages the case when remote_ip is configured in the
VTEP to stand for P2P.

Do you think there's a better way to identify P2P more precisely?

> other VTEP was found in the FDB. A VXLAN device that was configured with
> the "remote" keyword can still send packets to other VTEPs and it should
> therefore be able to receive packets from them.
> 
> > +		}
> > +
> >  		if (vninode)
> >  			*vninode = vnode;
> >  		return node->vxlan;
> > @@ -134,6 +153,7 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
> >  
> >  /* Look up VNI in a per net namespace table */
> >  static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
> > +					const struct sk_buff *skb,
> >  					__be32 vni, sa_family_t family,
> >  					__be16 port, u32 flags)
> >  {
> > @@ -143,7 +163,7 @@ static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
> >  	if (!vs)
> >  		return NULL;
> >  
> > -	return vxlan_vs_find_vni(vs, ifindex, vni, NULL);
> > +	return vxlan_vs_find_vni(vs, ifindex, vni, skb, NULL);
> >  }
> >  
> >  /* Fill in neighbour message in skbuff. */
> > @@ -1701,7 +1721,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
> >  
> >  	vni = vxlan_vni(vh->vx_vni);
> >  
> > -	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
> > +	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, skb, &vninode);
> >  	if (!vxlan) {
> >  		reason = SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND;
> >  		goto drop;
> > @@ -1855,7 +1875,7 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
> >  		return -ENOENT;
> >  
> >  	vni = vxlan_vni(hdr->vx_vni);
> > -	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, NULL);
> > +	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, skb, NULL);
> >  	if (!vxlan)
> >  		return -ENOENT;
> >  
> > @@ -2330,7 +2350,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
> >  		struct vxlan_dev *dst_vxlan;
> >  
> >  		dst_release(dst);
> > -		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
> > +		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, skb, vni,
> >  					   addr_family, dst_port,
> >  					   vxlan->cfg.flags);
> >  		if (!dst_vxlan) {
> > -- 
> > 2.39.2
> > 
> > 

