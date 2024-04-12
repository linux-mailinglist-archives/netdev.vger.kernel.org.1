Return-Path: <netdev+bounces-87343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981DC8A2CC3
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 12:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB4B1C215ED
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9578B4087B;
	Fri, 12 Apr 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="pqCCGp4T"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFE3FE3D
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918715; cv=none; b=pQgKIGoBHqtNl734WlwFtqJ4+FUWlkUPmqcTjC/xp9j/5N4pd+acKJA1f7Wufqa7t59T2qjRLF19XnYVCUpHrU7+Y9UHbSgozPuRfrR12yYUtiw9A7IvlsdHRNEnwUAkBia6O8dG2/Hd4UV7EvKa5aJYJ+yajxglwQduGJLT77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918715; c=relaxed/simple;
	bh=TL3+HKHj8vYVuB+ezHzJlXHWMOcfcrRPJCRDwdtfgO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kA35AedEJ3BhVy55KIEYjX29xC2tWyBnOPkJ8BTtm02f5yLTyGAgk//7e9vWg4k7AkQ3lg/9d+J26G/z4+aB2ceB/soqn0jYpl7hgn/BqMeULYYkBzABTi7VasOdROB7ibNxnO2pL8dDIhPFUs5Kp6EhlfcGIDWWjhC886u42tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=pqCCGp4T; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id C123B5A0001;
	Fri, 12 Apr 2024 12:37:26 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGOnB6RfgOkv; Fri, 12 Apr 2024 12:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1712918245;
	bh=TL3+HKHj8vYVuB+ezHzJlXHWMOcfcrRPJCRDwdtfgO8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pqCCGp4Tw2dYBpF7lTuQBbtIvqt+dRi6bNrIFq6nFKV6YGzKNA9GdBcU3cJf/yrm+
	 Jz2MFlICMKxnbGwy9/i2dXXgVNJSKCNY8Hafv+cDbn03zdrCTzN7cfwshT+2INnPyQ
	 TNJmcTnoEfCZ4j4uOgsoKVcCBMIp+VBd9TldxQ+I5dxgxlKITXAQTrgg1xnXmI4d4g
	 L6cU9Bwu3twAwW6YUBSAJjbCt3IHSApktWv9tmjavaSDVaqXPwhzBwJGWNRc9FvsqS
	 0cYlAXuugc5LjjyyKiLkuPuR+xB5hwJQ4wi4ux+mBF6kK4+2yqMeDDTKMlK5JpBpSO
	 gYACqH0ppG4SQ==
Received: from [IPV6:2a01:8b81:5400:f500:db2d:e45a:3f36:b976] (unknown [IPv6:2a01:8b81:5400:f500:db2d:e45a:3f36:b976])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 518F65A0002;
	Fri, 12 Apr 2024 12:37:25 +0200 (CEST)
Message-ID: <3b63e04b-d883-4ef4-8450-c0ec91ecc709@strongswan.org>
Date: Fri, 12 Apr 2024 12:37:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec-next 1/3] xfrm: Add support for per cpu xfrm state
 handling.
To: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 devel@linux-ipsec.org, Paul Wouters <paul@nohats.ca>,
 Antony Antony <antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <20240412060553.3483630-2-steffen.klassert@secunet.com>
From: Tobias Brunner <tobias@strongswan.org>
Content-Language: en-US, de-CH-frami
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
In-Reply-To: <20240412060553.3483630-2-steffen.klassert@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.04.24 08:05, Steffen Klassert wrote:
> Currently all flows for a certain SA must be processed by the same
> cpu to avoid packet reordering and lock contention of the xfrm
> state lock.
> 
> To get rid of this limitation, the IETF is about to standardize
> per cpu SAs. This patch implements the xfrm part of it:
> 
> https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/
> 
> This adds the cpu as a lookup key for xfrm states and a config option
> to generate acquire messages for each cpu.
> 
> With that, we can have on each cpu a SA with identical traffic selector
> so that flows can be processed in parallel on all cpu.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  include/net/xfrm.h        |  5 ++--
>  include/uapi/linux/xfrm.h |  2 ++
>  net/key/af_key.c          |  7 +++---
>  net/xfrm/xfrm_state.c     | 49 ++++++++++++++++++++++++++++++---------
>  net/xfrm/xfrm_user.c      | 43 ++++++++++++++++++++++++++++++++--
>  5 files changed, 88 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 57c743b7e4fe..2ba4c077ccf9 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -185,6 +185,7 @@ struct xfrm_state {
>  	refcount_t		refcnt;
>  	spinlock_t		lock;
>  
> +	u32			pcpu_num;
>  	struct xfrm_id		id;
>  	struct xfrm_selector	sel;
>  	struct xfrm_mark	mark;
> @@ -1639,7 +1640,7 @@ struct xfrmk_spdinfo {
>  	u32 spdhmcnt;
>  };
>  
> -struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq);
> +struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
>  int xfrm_state_delete(struct xfrm_state *x);
>  int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync);
>  int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid);
> @@ -1754,7 +1755,7 @@ int verify_spi_info(u8 proto, u32 min, u32 max, struct netlink_ext_ack *extack);
>  int xfrm_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi,
>  		   struct netlink_ext_ack *extack);
>  struct xfrm_state *xfrm_find_acq(struct net *net, const struct xfrm_mark *mark,
> -				 u8 mode, u32 reqid, u32 if_id, u8 proto,
> +				 u8 mode, u32 reqid, u32 if_id, u32 pcpu_num, u8 proto,
>  				 const xfrm_address_t *daddr,
>  				 const xfrm_address_t *saddr, int create,
>  				 unsigned short family);
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 6a77328be114..1703b6fc868e 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -315,6 +315,7 @@ enum xfrm_attr_type_t {
>  	XFRMA_SET_MARK_MASK,	/* __u32 */
>  	XFRMA_IF_ID,		/* __u32 */
>  	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
> +	XFRMA_SA_PCPU,		/* __u32 */
>  	__XFRMA_MAX
>  
>  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
> @@ -430,6 +431,7 @@ struct xfrm_userpolicy_info {
>  #define XFRM_POLICY_LOCALOK	1	/* Allow user to override global policy */
>  	/* Automatically expand selector to include matching ICMP payloads. */
>  #define XFRM_POLICY_ICMP	2
> +#define XFRM_POLICY_CPU_ACQUIRE	4
>  	__u8				share;
>  };
>  
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index f79fb99271ed..b9a1eb3ff461 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -1354,7 +1354,7 @@ static int pfkey_getspi(struct sock *sk, struct sk_buff *skb, const struct sadb_
>  	}
>  
>  	if (hdr->sadb_msg_seq) {
> -		x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq);
> +		x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq, 0);

Shouldn't this be UINT_MAX instead of 0?  (Not sure if it makes a
difference in practice, but it would be consistent with XFRM.)

>  		if (x && !xfrm_addr_equal(&x->id.daddr, xdaddr, family)) {
>  			xfrm_state_put(x);
>  			x = NULL;
> @@ -1362,7 +1362,8 @@ static int pfkey_getspi(struct sock *sk, struct sk_buff *skb, const struct sadb_
>  	}
>  
>  	if (!x)
> -		x = xfrm_find_acq(net, &dummy_mark, mode, reqid, 0, proto, xdaddr, xsaddr, 1, family);
> +		x = xfrm_find_acq(net, &dummy_mark, mode, reqid, 0, 0, proto,
> +				  xdaddr, xsaddr, 1, family);

Same as above.

>  
>  	if (x == NULL)
>  		return -ENOENT;
> @@ -1417,7 +1418,7 @@ static int pfkey_acquire(struct sock *sk, struct sk_buff *skb, const struct sadb
>  	if (hdr->sadb_msg_seq == 0 || hdr->sadb_msg_errno == 0)
>  		return 0;
>  
> -	x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq);
> +	x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq, 0);

Same as above.

>  	if (x == NULL)
>  		return 0;
>  
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 0c306473a79d..b41b5dd72d8e 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -677,6 +677,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
>  		x->lft.hard_packet_limit = XFRM_INF;
>  		x->replay_maxage = 0;
>  		x->replay_maxdiff = 0;
> +		x->pcpu_num = UINT_MAX;
>  		spin_lock_init(&x->lock);
>  	}
>  	return x;
> @@ -972,6 +973,7 @@ xfrm_init_tempstate(struct xfrm_state *x, const struct flowi *fl,
>  	x->props.mode = tmpl->mode;
>  	x->props.reqid = tmpl->reqid;
>  	x->props.family = tmpl->encap_family;
> +	x->type_offload = NULL;

This seems unrelated.  And is it actually necessary?  xfrm_state_alloc()
uses kmem_cache_zalloc(), so this should be NULL anyway.

>  }
>  
>  static struct xfrm_state *__xfrm_state_lookup_all(struct net *net, u32 mark,
> @@ -1096,6 +1098,9 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
>  			       struct xfrm_state **best, int *acq_in_progress,
>  			       int *error)
>  {
> +	unsigned int pcpu_id = get_cpu();
> +	put_cpu();
> +
>  	/* Resolution logic:
>  	 * 1. There is a valid state with matching selector. Done.
>  	 * 2. Valid state with inappropriate selector. Skip.
> @@ -1115,13 +1120,18 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
>  							&fl->u.__fl_common))
>  			return;
>  
> +		if (x->pcpu_num != UINT_MAX && x->pcpu_num != pcpu_id)
> +			return;
> +
>  		if (!*best ||
> +		    ((*best)->pcpu_num == UINT_MAX && x->pcpu_num == pcpu_id) ||
>  		    (*best)->km.dying > x->km.dying ||
>  		    ((*best)->km.dying == x->km.dying &&
>  		     (*best)->curlft.add_time < x->curlft.add_time))
>  			*best = x;
>  	} else if (x->km.state == XFRM_STATE_ACQ) {
> -		*acq_in_progress = 1;
> +		if (!*best || (*best && x->pcpu_num == pcpu_id))
> +			*acq_in_progress = 1;
>  	} else if (x->km.state == XFRM_STATE_ERROR ||
>  		   x->km.state == XFRM_STATE_EXPIRED) {
>  		if ((!x->sel.family ||
> @@ -1150,6 +1160,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  	unsigned short encap_family = tmpl->encap_family;
>  	unsigned int sequence;
>  	struct km_event c;
> +	unsigned int pcpu_id = get_cpu();
> +	put_cpu();
>  
>  	to_put = NULL;
>  
> @@ -1223,7 +1235,10 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  	}
>  
>  found:
> -	x = best;
> +	if (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) ||
> +	    (best && (best->pcpu_num == pcpu_id)))
> +		x = best;
> +
>  	if (!x && !error && !acquire_in_progress) {
>  		if (tmpl->id.spi &&
>  		    (x0 = __xfrm_state_lookup_all(net, mark, daddr,
> @@ -1255,6 +1270,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  		xfrm_init_tempstate(x, fl, tmpl, daddr, saddr, family);
>  		memcpy(&x->mark, &pol->mark, sizeof(x->mark));
>  		x->if_id = if_id;
> +		if ((pol->flags & XFRM_POLICY_CPU_ACQUIRE) && best)
> +			x->pcpu_num = pcpu_id;
>  
>  		error = security_xfrm_state_alloc_acquire(x, pol->security, fl->flowi_secid);
>  		if (error) {
> @@ -1333,6 +1350,9 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  			x = NULL;
>  			error = -ESRCH;
>  		}
> +
> +		if (best)
> +			x = best;

Since `x` could be assigned to a (more specific in terms of CPU ID)
state in state XFRM_STATE_ACQ at this point, it might warrant a comment
that clarifies why it is unconditionally overridden with `best`.  That
is, so this other matching "fallback" SA is used for this packet while
the CPU-specific acquire is handled, which might not be immedialy
obvious when reading the code.

>  	}
>  out:
>  	if (x) {
> @@ -1464,12 +1484,14 @@ static void __xfrm_state_bump_genids(struct xfrm_state *xnew)
>  	unsigned int h;
>  	u32 mark = xnew->mark.v & xnew->mark.m;
>  	u32 if_id = xnew->if_id;
> +	u32 cpu_id = xnew->pcpu_num;
>  
>  	h = xfrm_dst_hash(net, &xnew->id.daddr, &xnew->props.saddr, reqid, family);
>  	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
>  		if (x->props.family	== family &&
>  		    x->props.reqid	== reqid &&
>  		    x->if_id		== if_id &&
> +		    x->pcpu_num		== cpu_id &&
>  		    (mark & x->mark.m) == x->mark.v &&
>  		    xfrm_addr_equal(&x->id.daddr, &xnew->id.daddr, family) &&
>  		    xfrm_addr_equal(&x->props.saddr, &xnew->props.saddr, family))
> @@ -1492,7 +1514,7 @@ EXPORT_SYMBOL(xfrm_state_insert);
>  static struct xfrm_state *__find_acq_core(struct net *net,
>  					  const struct xfrm_mark *m,
>  					  unsigned short family, u8 mode,
> -					  u32 reqid, u32 if_id, u8 proto,
> +					  u32 reqid, u32 if_id, u32 pcpu_num, u8 proto,
>  					  const xfrm_address_t *daddr,
>  					  const xfrm_address_t *saddr,
>  					  int create)
> @@ -1509,6 +1531,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
>  		    x->id.spi       != 0 ||
>  		    x->id.proto	    != proto ||
>  		    (mark & x->mark.m) != x->mark.v ||
> +		    x->pcpu_num != pcpu_num ||
>  		    !xfrm_addr_equal(&x->id.daddr, daddr, family) ||
>  		    !xfrm_addr_equal(&x->props.saddr, saddr, family))
>  			continue;
> @@ -1542,6 +1565,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
>  			break;
>  		}
>  
> +		x->pcpu_num = pcpu_num;
>  		x->km.state = XFRM_STATE_ACQ;
>  		x->id.proto = proto;
>  		x->props.family = family;
> @@ -1570,7 +1594,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
>  	return x;
>  }
>  
> -static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq);
> +static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
>  
>  int xfrm_state_add(struct xfrm_state *x)
>  {
> @@ -1596,7 +1620,7 @@ int xfrm_state_add(struct xfrm_state *x)
>  	}
>  
>  	if (use_spi && x->km.seq) {
> -		x1 = __xfrm_find_acq_byseq(net, mark, x->km.seq);
> +		x1 = __xfrm_find_acq_byseq(net, mark, x->km.seq, x->pcpu_num);
>  		if (x1 && ((x1->id.proto != x->id.proto) ||
>  		    !xfrm_addr_equal(&x1->id.daddr, &x->id.daddr, family))) {
>  			to_put = x1;
> @@ -1606,7 +1630,7 @@ int xfrm_state_add(struct xfrm_state *x)
>  
>  	if (use_spi && !x1)
>  		x1 = __find_acq_core(net, &x->mark, family, x->props.mode,
> -				     x->props.reqid, x->if_id, x->id.proto,
> +				     x->props.reqid, x->if_id, x->pcpu_num, x->id.proto,
>  				     &x->id.daddr, &x->props.saddr, 0);
>  
>  	__xfrm_state_bump_genids(x);
> @@ -1731,6 +1755,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
>  	x->props.flags = orig->props.flags;
>  	x->props.extra_flags = orig->props.extra_flags;
>  
> +	x->pcpu_num = orig->pcpu_num;
>  	x->if_id = orig->if_id;
>  	x->tfcpad = orig->tfcpad;
>  	x->replay_maxdiff = orig->replay_maxdiff;
> @@ -1999,13 +2024,14 @@ EXPORT_SYMBOL(xfrm_state_lookup_byaddr);
>  
>  struct xfrm_state *
>  xfrm_find_acq(struct net *net, const struct xfrm_mark *mark, u8 mode, u32 reqid,
> -	      u32 if_id, u8 proto, const xfrm_address_t *daddr,
> +	      u32 if_id, u32 pcpu_num, u8 proto, const xfrm_address_t *daddr,
>  	      const xfrm_address_t *saddr, int create, unsigned short family)
>  {
>  	struct xfrm_state *x;
>  
>  	spin_lock_bh(&net->xfrm.xfrm_state_lock);
> -	x = __find_acq_core(net, mark, family, mode, reqid, if_id, proto, daddr, saddr, create);
> +	x = __find_acq_core(net, mark, family, mode, reqid, if_id, pcpu_num,
> +			    proto, daddr, saddr, create);
>  	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
>  
>  	return x;
> @@ -2140,7 +2166,7 @@ xfrm_state_sort(struct xfrm_state **dst, struct xfrm_state **src, int n,
>  
>  /* Silly enough, but I'm lazy to build resolution list */
>  
> -static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq)
> +static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num)
>  {
>  	unsigned int h = xfrm_seq_hash(net, seq);
>  	struct xfrm_state *x;
> @@ -2148,6 +2174,7 @@ static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 s
>  	hlist_for_each_entry_rcu(x, net->xfrm.state_byseq + h, byseq) {
>  		if (x->km.seq == seq &&
>  		    (mark & x->mark.m) == x->mark.v &&
> +		    x->pcpu_num == pcpu_num &&
>  		    x->km.state == XFRM_STATE_ACQ) {
>  			xfrm_state_hold(x);
>  			return x;
> @@ -2157,12 +2184,12 @@ static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 s
>  	return NULL;
>  }
>  
> -struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq)
> +struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num)
>  {
>  	struct xfrm_state *x;
>  
>  	spin_lock_bh(&net->xfrm.xfrm_state_lock);
> -	x = __xfrm_find_acq_byseq(net, mark, seq);
> +	x = __xfrm_find_acq_byseq(net, mark, seq, pcpu_num);
>  	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
>  	return x;
>  }
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 810b520493f3..97e659f0812e 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -734,6 +734,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
>  	if (attrs[XFRMA_IF_ID])
>  		x->if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
>  
> +	if (attrs[XFRMA_SA_PCPU]) {
> +		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
> +		if (x->pcpu_num >= num_possible_cpus())
> +			goto error;
> +	}
> +
>  	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
>  	if (err)
>  		goto error;
> @@ -1182,6 +1188,11 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
>  		if (ret)
>  			goto out;
>  	}
> +	if (x->pcpu_num != UINT_MAX) {
> +		ret = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
> +		if (ret)
> +			goto out;
> +	}
>  	if (x->mapping_maxage)
>  		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
>  out:
> @@ -1579,6 +1590,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	u32 mark;
>  	struct xfrm_mark m;
>  	u32 if_id = 0;
> +	u32 pcpu_num = UINT_MAX;
>  
>  	p = nlmsg_data(nlh);
>  	err = verify_spi_info(p->info.id.proto, p->min, p->max, extack);
> @@ -1595,8 +1607,16 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (attrs[XFRMA_IF_ID])
>  		if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
>  
> +	if (attrs[XFRMA_SA_PCPU]) {
> +		pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
> +		if (pcpu_num >= num_possible_cpus()) {
> +			err = -EINVAL;
> +			goto out_noput;
> +		}
> +	}
> +
>  	if (p->info.seq) {
> -		x = xfrm_find_acq_byseq(net, mark, p->info.seq);
> +		x = xfrm_find_acq_byseq(net, mark, p->info.seq, pcpu_num);
>  		if (x && !xfrm_addr_equal(&x->id.daddr, daddr, family)) {
>  			xfrm_state_put(x);
>  			x = NULL;
> @@ -1605,7 +1625,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	if (!x)
>  		x = xfrm_find_acq(net, &m, p->info.mode, p->info.reqid,
> -				  if_id, p->info.id.proto, daddr,
> +				  if_id, pcpu_num, p->info.id.proto, daddr,
>  				  &p->info.saddr, 1,
>  				  family);
>  	err = -ENOENT;
> @@ -2458,6 +2478,8 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
>  	err = xfrm_if_id_put(skb, x->if_id);
>  	if (err)
>  		goto out_cancel;
> +	if (x->pcpu_num != UINT_MAX)
> +		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
>  
>  	nlmsg_end(skb, nlh);
>  	return 0;
> @@ -2722,6 +2744,13 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	xfrm_mark_get(attrs, &mark);
>  
> +	if (attrs[XFRMA_SA_PCPU]) {
> +		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
> +		err = -EINVAL;
> +		if (x->pcpu_num >= num_possible_cpus())
> +			goto free_state;
> +	}
> +
>  	err = verify_newpolicy_info(&ua->policy, extack);
>  	if (err)
>  		goto free_state;
> @@ -3049,6 +3078,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
>  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
>  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
>  	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
> +	[XFRMA_SA_PCPU]		= { .type = NLA_U32 },
>  };
>  EXPORT_SYMBOL_GPL(xfrma_policy);
>  
> @@ -3216,6 +3246,11 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
>  	err = xfrm_if_id_put(skb, x->if_id);
>  	if (err)
>  		return err;
> +	if (x->pcpu_num != UINT_MAX) {
> +		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
> +		if (err)
> +			return err;
> +	}
>  
>  	nlmsg_end(skb, nlh);
>  	return 0;
> @@ -3317,6 +3352,8 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
>  	}
>  	if (x->if_id)
>  		l += nla_total_size(sizeof(x->if_id));
> +	if (x->pcpu_num)
> +		l += nla_total_size(sizeof(x->pcpu_num));
>  
>  	/* Must count x->lastused as it may become non-zero behind our back. */
>  	l += nla_total_size_64bit(sizeof(u64));
> @@ -3453,6 +3490,8 @@ static int build_acquire(struct sk_buff *skb, struct xfrm_state *x,
>  		err = xfrm_if_id_put(skb, xp->if_id);
>  	if (!err && xp->xdo.dev)
>  		err = copy_user_offload(&xp->xdo, skb);
> +	if (!err && x->pcpu_num != UINT_MAX)
> +		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
>  	if (err) {
>  		nlmsg_cancel(skb, nlh);
>  		return err;


