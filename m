Return-Path: <netdev+bounces-137195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9849A4C08
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8914E284796
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CE1DE3B8;
	Sat, 19 Oct 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRX+1TLo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9512B17C;
	Sat, 19 Oct 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326644; cv=none; b=Na0dtS1VzzKJHIMQ7Iwb0KyxHNLp3OsA+oM2QcuEip4m3VqXu4Vn8CK/TE9LXleMsE/mw0rAKD/+WFPUStzDvecYWqpPh+4Ixg1YrD+I89cot2A+gRu6iu6mmTr6T40/Eh6kCihu/fBFnDSWuXs7wuJDHVHGpeZDekWcEzPhuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326644; c=relaxed/simple;
	bh=i88wpcZPo7AneGKUWcwyca6Z4rUOqTyjuBUMHJFJ4Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtAkpde7XWyCOvLv62x3Y5bIWytxXi/Xsu/I5VNNaie4YR85CIUQImf3/JM3NjVlZJy0UTnbh54Vc0ibxJLRkse62eC5rFCUmdh0oAPDwhmjkg8Sd1mc9DqzvaRH8oP5RMsb/rE7q5RNUjQ2VYgM96oAiFhIx0w5b3SYjaR4ZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRX+1TLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666AAC4CEC5;
	Sat, 19 Oct 2024 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729326644;
	bh=i88wpcZPo7AneGKUWcwyca6Z4rUOqTyjuBUMHJFJ4Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRX+1TLoTldHw4iCZcKFxbAjkBl9XYAQTjLSR1qCOt17D0pVZDnh9CJ1rdKLn/GJV
	 CDmyUFUnB5gqmDmSmAC7obpH/Om+5PiqFIYKpLadZ+ZnEG5Cf7o5mNF0xkxsiesE7R
	 BEz98oEsfXmsgx4/3KIz7MlYW96guBdkj/RFzZp1+SaLv1WUKeaPzYMJajcNPIq0kF
	 G6I5Z4VSek9xK0ymLIxN8/KlREjMsSsmZxLPQV0gTXIAgbDzuSr/bP9Ta4mxDi8YYE
	 cFKAEt8z3Gl8VF1pRYB9CAhzlqK9BtfgzWXO0fBgKF7ELfSz6nvECs1UkM9qV+ueez
	 sBktwICsJ4VuA==
Date: Sat, 19 Oct 2024 09:30:40 +0100
From: Simon Horman <horms@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ido Schimmel <idosch@idosch.org>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH v3 net-next] net: vlan: Use vlan_prio instead of vlan_qos
 in mapping
Message-ID: <20241019083040.GI1697@kernel.org>
References: <20241018141233.2568-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018141233.2568-1-yajun.deng@linux.dev>

+ Ido and Guilliame

On Fri, Oct 18, 2024 at 10:12:33PM +0800, Yajun Deng wrote:
> The vlan_qos member is used to save the vlan qos, but we only save the
> priority. Also, we will get the priority in vlan netlink and proc.
> We can just save the vlan priority using vlan_prio, so we can use vlan_prio
> to get the priority directly.
> 
> For flexibility, we introduced vlan_dev_get_egress_priority() helper
> function. After this patch, we will call vlan_dev_get_egress_priority()
> instead of vlan_dev_get_egress_qos_mask() in irdma.ko and rdma_cm.ko.
> Because we don't need the shift and mask operations anymore.
> 
> There is no functional changes.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Hi Ido and Guilliame,

I'm wondering if you could take a look over this and provide
any feedback you might have.

Thanks!

> ---
> v3: Remove the restriction that the maximum vlan priority is 7.
> v2: Add more detailed comments and tests.

v2 is here: https://lore.kernel.org/netdev/20241012132826.2224-1-yajun.deng@linux.dev/

> v1: https://lore.kernel.org/all/20241009132302.2902-1-yajun.deng@linux.dev/
> ---
>  include/linux/if_vlan.h  | 26 +++++++++++++++++++-------
>  net/8021q/vlan.h         |  4 ++--
>  net/8021q/vlan_dev.c     | 23 ++++++++++++-----------
>  net/8021q/vlan_netlink.c |  4 ++--
>  net/8021q/vlanproc.c     |  4 ++--
>  5 files changed, 37 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index c1645c86eed9..7cc36853c017 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -150,12 +150,12 @@ extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
>  /**
>   *	struct vlan_priority_tci_mapping - vlan egress priority mappings
>   *	@priority: skb priority
> - *	@vlan_qos: vlan priority: (skb->priority << 13) & 0xE000
> + *	@vlan_prio: vlan priority
>   *	@next: pointer to next struct
>   */
>  struct vlan_priority_tci_mapping {
>  	u32					priority;
> -	u16					vlan_qos;
> +	u8					vlan_prio;
>  	struct vlan_priority_tci_mapping	*next;
>  };
>  
> @@ -204,8 +204,8 @@ static inline struct vlan_dev_priv *vlan_dev_priv(const struct net_device *dev)
>  	return netdev_priv(dev);
>  }
>  
> -static inline u16
> -vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
> +static inline u8
> +vlan_dev_get_egress_priority(struct net_device *dev, u32 skprio)
>  {
>  	struct vlan_priority_tci_mapping *mp;
>  
> @@ -214,15 +214,21 @@ vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
>  	mp = vlan_dev_priv(dev)->egress_priority_map[(skprio & 0xF)];
>  	while (mp) {
>  		if (mp->priority == skprio) {
> -			return mp->vlan_qos; /* This should already be shifted
> -					      * to mask correctly with the
> -					      * VLAN's TCI */
> +			return mp->vlan_prio;
>  		}
>  		mp = mp->next;
>  	}
>  	return 0;
>  }
>  
> +static inline u16
> +vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
> +{
> +	u8 vlan_prio = vlan_dev_get_egress_priority(dev, skprio);
> +
> +	return (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
> +}
> +
>  extern bool vlan_do_receive(struct sk_buff **skb);
>  
>  extern int vlan_vid_add(struct net_device *dev, __be16 proto, u16 vid);
> @@ -269,6 +275,12 @@ static inline __be16 vlan_dev_vlan_proto(const struct net_device *dev)
>  	return 0;
>  }
>  
> +static inline u8 vlan_dev_get_egress_priority(struct net_device *dev,
> +					      u32 skprio)
> +{
> +	return 0;
> +}
> +
>  static inline u16 vlan_dev_get_egress_qos_mask(struct net_device *dev,
>  					       u32 skprio)
>  {
> diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
> index 5eaf38875554..b28875c4ac86 100644
> --- a/net/8021q/vlan.h
> +++ b/net/8021q/vlan.h
> @@ -126,9 +126,9 @@ void vlan_filter_drop_vids(struct vlan_info *vlan_info, __be16 proto);
>  
>  /* found in vlan_dev.c */
>  void vlan_dev_set_ingress_priority(const struct net_device *dev,
> -				   u32 skb_prio, u16 vlan_prio);
> +				   u32 skb_prio, u8 vlan_prio);
>  int vlan_dev_set_egress_priority(const struct net_device *dev,
> -				 u32 skb_prio, u16 vlan_prio);
> +				 u32 skb_prio, u8 vlan_prio);
>  void vlan_dev_free_egress_priority(const struct net_device *dev);
>  int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32 mask);
>  void vlan_dev_get_realdev_name(const struct net_device *dev, char *result,
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index 458040e8a0e0..5d153f1a7963 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -155,35 +155,36 @@ static int vlan_dev_change_mtu(struct net_device *dev, int new_mtu)
>  }
>  
>  void vlan_dev_set_ingress_priority(const struct net_device *dev,
> -				   u32 skb_prio, u16 vlan_prio)
> +				   u32 skb_prio, u8 vlan_prio)
>  {
>  	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
>  
> -	if (vlan->ingress_priority_map[vlan_prio & 0x7] && !skb_prio)
> +	vlan_prio = vlan_prio & 0x7;
> +	if (vlan->ingress_priority_map[vlan_prio] && !skb_prio)
>  		vlan->nr_ingress_mappings--;
> -	else if (!vlan->ingress_priority_map[vlan_prio & 0x7] && skb_prio)
> +	else if (!vlan->ingress_priority_map[vlan_prio] && skb_prio)
>  		vlan->nr_ingress_mappings++;
>  
> -	vlan->ingress_priority_map[vlan_prio & 0x7] = skb_prio;
> +	vlan->ingress_priority_map[vlan_prio] = skb_prio;
>  }
>  
>  int vlan_dev_set_egress_priority(const struct net_device *dev,
> -				 u32 skb_prio, u16 vlan_prio)
> +				 u32 skb_prio, u8 vlan_prio)
>  {
>  	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
>  	struct vlan_priority_tci_mapping *mp = NULL;
>  	struct vlan_priority_tci_mapping *np;
> -	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
>  
> +	vlan_prio = vlan_prio & 0x7;
>  	/* See if a priority mapping exists.. */
>  	mp = vlan->egress_priority_map[skb_prio & 0xF];
>  	while (mp) {
>  		if (mp->priority == skb_prio) {
> -			if (mp->vlan_qos && !vlan_qos)
> +			if (mp->vlan_prio && !vlan_prio)
>  				vlan->nr_egress_mappings--;
> -			else if (!mp->vlan_qos && vlan_qos)
> +			else if (!mp->vlan_prio && vlan_prio)
>  				vlan->nr_egress_mappings++;
> -			mp->vlan_qos = vlan_qos;
> +			mp->vlan_prio = vlan_prio;
>  			return 0;
>  		}
>  		mp = mp->next;
> @@ -197,14 +198,14 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
>  
>  	np->next = mp;
>  	np->priority = skb_prio;
> -	np->vlan_qos = vlan_qos;
> +	np->vlan_prio = vlan_prio;
>  	/* Before inserting this element in hash table, make sure all its fields
>  	 * are committed to memory.
>  	 * coupled with smp_rmb() in vlan_dev_get_egress_qos_mask()
>  	 */
>  	smp_wmb();
>  	vlan->egress_priority_map[skb_prio & 0xF] = np;
> -	if (vlan_qos)
> +	if (vlan_prio)
>  		vlan->nr_egress_mappings++;
>  	return 0;
>  }
> diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
> index cf5219df7903..f62d8320c5b4 100644
> --- a/net/8021q/vlan_netlink.c
> +++ b/net/8021q/vlan_netlink.c
> @@ -261,11 +261,11 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  		for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
>  			for (pm = vlan->egress_priority_map[i]; pm;
>  			     pm = pm->next) {
> -				if (!pm->vlan_qos)
> +				if (!pm->vlan_prio)
>  					continue;
>  
>  				m.from = pm->priority;
> -				m.to   = (pm->vlan_qos >> 13) & 0x7;
> +				m.to   = pm->vlan_prio;
>  				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
>  					    sizeof(m), &m))
>  					goto nla_put_failure;
> diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
> index fa67374bda49..a5a5b8fbb054 100644
> --- a/net/8021q/vlanproc.c
> +++ b/net/8021q/vlanproc.c
> @@ -266,8 +266,8 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
>  		const struct vlan_priority_tci_mapping *mp
>  			= vlan->egress_priority_map[i];
>  		while (mp) {
> -			seq_printf(seq, "%u:%d ",
> -				   mp->priority, ((mp->vlan_qos >> 13) & 0x7));
> +			seq_printf(seq, "%u:%u ",
> +				   mp->priority, mp->vlan_prio);
>  			mp = mp->next;
>  		}
>  	}
> -- 
> 2.25.1
> 
> 

