Return-Path: <netdev+bounces-74743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC6862A45
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 13:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0434DB20CA8
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E80C111A2;
	Sun, 25 Feb 2024 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="g5QIlaJY"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B9EED5
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708863522; cv=none; b=TD8FAaJLj/Wj/KPWybTPEBRu1XYnDTOytaIQ6OSemzr1HwClfo1hPHpcUACpQEIAmI4vfU3qGeK0cTEs9xyVhS7XYMjovXcbiHKiNMe/cnIicA7LD9PcoEJwtuH9UY9yt75qcTuR8WJ+nkziIA1FYP0Yr6muEQtD4o3kLEiyrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708863522; c=relaxed/simple;
	bh=dRwq209/bP4dppP2f0zWS0TiYhMaJJ8/pm2MSyyhx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQulutT024C8kCpBO7s4Ph3ArRVda9JOWzc+XNGR7ReLxOlZaEU8YVCCqzud1p19KvWuVLDaCSuiE0VKYmIsClipEiLFztX4+kokWI/cFf2eziCoIQ2TQTSMOPMiye3/CoEpdNpi2mzVBXqb17KibS1SX84yKC0Enj0pB3SZV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=g5QIlaJY; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: d2e72d91-d3d7-11ee-bbc7-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d2e72d91-d3d7-11ee-bbc7-005056abad63;
	Sun, 25 Feb 2024 13:17:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=WeI0wsWJ5uEkliavfI7x5E00QQdgPbWFDhSTfhj53Ys=;
	b=g5QIlaJYB+xnaLVODl3siOPdJemHHrbl0ZANiwjIlHMTcCisJNSqKmR20S72LDOQFKRpg2k108bZA
	 zzHG68C+kneDyzjcUyNXpOmVOk2+rJBm0MkhRbSgFWrL0f7x2j+BNadFHT5cjAIHB4ONhBSlQ7a0JE
	 pHbj2SmFqKf886bw=
X-KPN-MID: 33|9d/D6IMUrKRiHQN2NOnsq/fQnhiKcDj0nbxUoo3PKOE2Om30ISQMmprbwEr0Ey9
 qfS3xzwSuNaBVA61F1gjuWXW+eN7sClD0Jwf97REz3e0=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|BHXNf6BDUIUx00g3SH1TbUDz89FCnNSuWAYMSb4xfyzf/rtPljuy4DtezQJ55s5
 Db42lYJrmhK+f1hsYfyuKYQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d705b9a1-d3d7-11ee-9ef7-005056ab7584;
	Sun, 25 Feb 2024 13:17:28 +0100 (CET)
Date: Sun, 25 Feb 2024 13:17:27 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v1 6/8] iptfs: xfrm: Add
 mode_cbs module functionality
Message-ID: <Zdsv19c9nTqDF0TB@Antony2201.local>
References: <20240219085735.1220113-1-chopps@chopps.org>
 <20240219085735.1220113-7-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219085735.1220113-7-chopps@chopps.org>

Hi Chris,

I was testing this version.
And I ran into issues when migrating states. IP-TFS values are set to 0.
I noticed 2-3 issues both in this patch and 8/8

On Mon, Feb 19, 2024 at 03:57:33AM -0500, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add a set of callbacks xfrm_mode_cbs to xfrm_state. These callbacks
> enable the addition of new xfrm modes, such as IP-TFS to be defined
> in modules.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  include/net/xfrm.h     | 38 ++++++++++++++++++++++++++++++++++
>  net/xfrm/xfrm_device.c |  3 ++-
>  net/xfrm/xfrm_input.c  | 14 +++++++++++--
>  net/xfrm/xfrm_output.c |  2 ++
>  net/xfrm/xfrm_policy.c | 18 +++++++++-------
>  net/xfrm/xfrm_state.c  | 47 ++++++++++++++++++++++++++++++++++++++++++
>  net/xfrm/xfrm_user.c   | 10 +++++++++
>  7 files changed, 122 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 1d107241b901..f1d5e99f0a47 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -204,6 +204,7 @@ struct xfrm_state {
>  		u16		family;
>  		xfrm_address_t	saddr;
>  		int		header_len;
> +		int		enc_hdr_len;
>  		int		trailer_len;
>  		u32		extra_flags;
>  		struct xfrm_mark	smark;
> @@ -289,6 +290,9 @@ struct xfrm_state {
>  	/* Private data of this transformer, format is opaque,
>  	 * interpreted by xfrm_type methods. */
>  	void			*data;
> +
> +	const struct xfrm_mode_cbs	*mode_cbs;
> +	void				*mode_data;
>  };
>  
>  static inline struct net *xs_net(struct xfrm_state *x)
> @@ -441,6 +445,40 @@ struct xfrm_type_offload {
>  int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
>  void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
>  
> +struct xfrm_mode_cbs {
> +	struct module	*owner;
> +	/* Add/delete state in the new xfrm_state in `x`. */
> +	int	(*create_state)(struct xfrm_state *x);
> +	void	(*delete_state)(struct xfrm_state *x);
> +
> +	/* Called while handling the user netlink options. */
> +	int	(*user_init)(struct net *net, struct xfrm_state *x,
> +			     struct nlattr **attrs,
> +			     struct netlink_ext_ack *extack);
> +	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);
> +	int     (*clone)(struct xfrm_state *x, struct xfrm_state *orig);
> +
> +	u32	(*get_inner_mtu)(struct xfrm_state *x, int outer_mtu);
> +
> +	/* Called to handle received xfrm (egress) packets. */
> +	int	(*input)(struct xfrm_state *x, struct sk_buff *skb);
> +
> +	/* Placed in dst_output of the dst when an xfrm_state is bound. */
> +	int	(*output)(struct net *net, struct sock *sk, struct sk_buff *skb);
> +
> +	/**
> +	 * Prepare the skb for output for the given mode. Returns:
> +	 *    Error value, if 0 then skb values should be as follows:
> +	 *    transport_header should point at ESP header
> +	 *    network_header should point at Outer IP header
> +	 *    mac_header should point at protocol/nexthdr of the outer IP
> +	 */
> +	int	(*prepare_output)(struct xfrm_state *x, struct sk_buff *skb);
> +};
> +
> +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs);
> +void xfrm_unregister_mode_cbs(u8 mode);
> +
>  static inline int xfrm_af2proto(unsigned int family)
>  {
>  	switch(family) {
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 3784534c9185..8b848540ea47 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -42,7 +42,8 @@ static void __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
>  		skb->transport_header = skb->network_header + hsize;
>  
>  	skb_reset_mac_len(skb);
> -	pskb_pull(skb, skb->mac_len + x->props.header_len);
> +	pskb_pull(skb,
> +		  skb->mac_len + x->props.header_len - x->props.enc_hdr_len);
>  }
>  
>  static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index bd4ce21d76d7..824f7b7f90e0 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -437,6 +437,9 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
>  		WARN_ON_ONCE(1);
>  		break;
>  	default:
> +		if (x->mode_cbs && x->mode_cbs->input)
> +			return x->mode_cbs->input(x, skb);
> +
>  		WARN_ON_ONCE(1);
>  		break;
>  	}
> @@ -479,6 +482,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  
>  		family = x->props.family;
>  
> +		/* An encap_type of -3 indicates reconstructed inner packet */
> +		if (encap_type == -3)
> +			goto resume_decapped;
> +
>  		/* An encap_type of -1 indicates async resumption. */
>  		if (encap_type == -1) {
>  			async = 1;
> @@ -660,11 +667,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  
>  		XFRM_MODE_SKB_CB(skb)->protocol = nexthdr;
>  
> -		if (xfrm_inner_mode_input(x, skb)) {
> +		err = xfrm_inner_mode_input(x, skb);
> +		if (err == -EINPROGRESS)
> +			return 0;
> +		else if (err) {
>  			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
>  			goto drop;
>  		}
> -
> +resume_decapped:
>  		if (x->outer_mode.flags & XFRM_MODE_FLAG_TUNNEL) {
>  			decaps = 1;
>  			break;
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index 662c83beb345..8f98e42d4252 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -472,6 +472,8 @@ static int xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb)
>  		WARN_ON_ONCE(1);
>  		break;
>  	default:
> +		if (x->mode_cbs && x->mode_cbs->prepare_output)
> +			return x->mode_cbs->prepare_output(x, skb);
>  		WARN_ON_ONCE(1);
>  		break;
>  	}
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 53b7ce4a4db0..f3cd8483d427 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2713,13 +2713,17 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
>  
>  		dst1->input = dst_discard;
>  
> -		rcu_read_lock();
> -		afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
> -		if (likely(afinfo))
> -			dst1->output = afinfo->output;
> -		else
> -			dst1->output = dst_discard_out;
> -		rcu_read_unlock();
> +		if (xfrm[i]->mode_cbs && xfrm[i]->mode_cbs->output) {
> +			dst1->output = xfrm[i]->mode_cbs->output;
> +		} else {
> +			rcu_read_lock();
> +			afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
> +			if (likely(afinfo))
> +				dst1->output = afinfo->output;
> +			else
> +				dst1->output = dst_discard_out;
> +			rcu_read_unlock();
> +		}
>  
>  		xdst_prev = xdst;
>  
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index bda5327bf34d..2b58e35bea63 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -513,6 +513,36 @@ static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
>  	return NULL;
>  }
>  
> +static struct xfrm_mode_cbs xfrm_mode_cbs_map[XFRM_MODE_MAX];
> +
> +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs)
> +{
> +	if (mode >= XFRM_MODE_MAX)
> +		return -EINVAL;
> +
> +	xfrm_mode_cbs_map[mode] = *mode_cbs;
> +	return 0;
> +}
> +EXPORT_SYMBOL(xfrm_register_mode_cbs);
> +
> +void xfrm_unregister_mode_cbs(u8 mode)
> +{
> +	if (mode >= XFRM_MODE_MAX)
> +		return;
> +
> +	memset(&xfrm_mode_cbs_map[mode], 0, sizeof(xfrm_mode_cbs_map[mode]));
> +}
> +EXPORT_SYMBOL(xfrm_unregister_mode_cbs);
> +
> +static const struct xfrm_mode_cbs *xfrm_get_mode_cbs(u8 mode)
> +{
> +	if (mode >= XFRM_MODE_MAX)
> +		return NULL;
> +	if (mode == XFRM_MODE_IPTFS && !xfrm_mode_cbs_map[mode].create_state)
> +		request_module("xfrm-iptfs");
> +	return &xfrm_mode_cbs_map[mode];
> +}
> +
>  void xfrm_state_free(struct xfrm_state *x)
>  {
>  	kmem_cache_free(xfrm_state_cache, x);
> @@ -521,6 +551,8 @@ EXPORT_SYMBOL(xfrm_state_free);
>  
>  static void ___xfrm_state_destroy(struct xfrm_state *x)
>  {
> +	if (x->mode_cbs && x->mode_cbs->delete_state)
> +		x->mode_cbs->delete_state(x);
>  	hrtimer_cancel(&x->mtimer);
>  	del_timer_sync(&x->rtimer);
>  	kfree(x->aead);
> @@ -678,6 +710,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
>  		x->replay_maxage = 0;
>  		x->replay_maxdiff = 0;
>  		spin_lock_init(&x->lock);
> +		x->mode_data = NULL;
>  	}
>  	return x;
>  }
> @@ -1745,6 +1778,11 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
>  	x->new_mapping = 0;
>  	x->new_mapping_sport = 0;
>  
> +	if (x->mode_cbs && x->mode_cbs->clone) {

I notice x->mode_cbs,  it should check old state?

+ if (orig->mode_cbs && orig->mode_cbs->clone) {

> +		if (!x->mode_cbs->clone(x, orig))

iptfs_clone()  return 0 on success. So
"!". x->mode_cbs->clone -> iptfs_clone()
also use orig?
+		if (orig->mode_cbs->clone(x, orig))


> +			goto error;
> +	}
> +
>  	return x;
>  
>   error:
> @@ -2765,6 +2803,9 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
>  	case XFRM_MODE_TUNNEL:
>  		break;
>  	default:
> +		if (x->mode_cbs && x->mode_cbs->get_inner_mtu)
> +			return x->mode_cbs->get_inner_mtu(x, mtu);
> +
>  		WARN_ON_ONCE(1);
>  		break;
>  	}
> @@ -2850,6 +2891,12 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
>  			goto error;
>  	}
>  
> +	x->mode_cbs = xfrm_get_mode_cbs(x->props.mode);
> +	if (x->mode_cbs && x->mode_cbs->create_state) {
> +		err = x->mode_cbs->create_state(x);
> +		if (err)
> +			goto error;
> +	}
>  error:
>  	return err;
>  }
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index d4c88d29703e..92d11f2306e7 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -779,6 +779,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
>  			goto error;
>  	}
>  
> +	if (x->mode_cbs && x->mode_cbs->user_init) {
> +		err = x->mode_cbs->user_init(net, x, attrs, extack);
> +		if (err)
> +			goto error;
> +	}
> +
>  	return x;
>  
>  error:
> @@ -1192,6 +1198,10 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
>  		if (ret)
>  			goto out;
>  	}
> +	if (x->mode_cbs && x->mode_cbs->copy_to_user)
> +		ret = x->mode_cbs->copy_to_user(x, skb);
> +	if (ret)
> +		goto out;
>  	if (x->mapping_maxage)
>  		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
>  out:
> -- 
> 2.43.0
> 
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

