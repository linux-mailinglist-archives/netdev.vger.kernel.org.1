Return-Path: <netdev+bounces-86953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979A8A1284
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5021E2822EA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF681474CB;
	Thu, 11 Apr 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="NJZMC215"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5D1474BE
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833686; cv=none; b=caTr3eLD6FZ80dOgZpKLvuSBWiPEcUYV7/3sLRJzn+LRay20Sa8nZai9M8cti4NqYh13YHeG5qL6D3pBYGFrbxDaaWIeUtE8ckV66HPB6by8unC9afpZsk4pIMsD0stqcwcXkUg2caJ/gKUPyGvLcuOk1p1ievrf7GiTqyEM3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833686; c=relaxed/simple;
	bh=RuMYFYuBb5XxiaIP3H6TNLBzHa9P8K0nb+lCeDfw/Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrYKX+k2MBOX8qiAi4fXSHsrfoZWybtDL9MXjkNaX772YchBwnM4GmoopPrESRnF1D9t2e2iNrZVS+hx8fQ4ODBtCpK83ojDNDZvpyL2Hng7xd/Ww/Jm8ZUWo5fzlJtgBn2LtuVhjIvFoIeEAFRxMhEmt7CRzf1l/fRJckjzmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=NJZMC215; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 9fd4cbc6-f7f3-11ee-bfb8-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9fd4cbc6-f7f3-11ee-bfb8-005056ab378f;
	Thu, 11 Apr 2024 13:07:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=YTv4ze7VDLCa+fODBZq8DBRIDcfym44N2nDgJzDzdlw=;
	b=NJZMC215NXJKNNqMTRbvl3fQPobmjo7upMcbn9kj27b9rkyGI9iPjuZ2wCXUfT6ZG2riKF5JCcFv4
	 LMuTsVCjHHurIdUMVHV6dtIfuJhuzps7ZwZKFuziR+9npv2iPjiy1mNn6NZcSzouyRZl4Bqpm7hiuZ
	 vhjoiu7ax+b6Qf7w=
X-KPN-MID: 33|T5ZSsD42tOgVakfVNbQ4YUAPhqgickUhnu5z84TsAzl8OAASNbbP8gtGnKyHWXZ
 dVZ3mO9LPvJC4fTFFIfzIKQlhfMeD1l3CGCRSywOtOfY=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|z32Kub4s6KAsHf0At9Q+plLy+HfI1hzNc85/q22ABOPk/W7jJxS/kkOLCP/Cz1e
 WhgWHWXjiCq8haG/FlJYaEA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id bd6a6e01-f7f3-11ee-a211-005056ab1411;
	Thu, 11 Apr 2024 13:07:53 +0200 (CEST)
Date: Thu, 11 Apr 2024 13:07:52 +0200
From: Antony Antony <antony@phenome.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v8] xfrm: Add Direction to the SA in or out
Message-ID: <ZhfEiIamqwROzkUd@Antony2201.local>
References: <9e2ddbac8c3625b460fa21a3bfc8ebc4db53bd00.1712684076.git.antony.antony@secunet.com>
 <20240411103740.GM4195@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411103740.GM4195@unreal>

On Thu, Apr 11, 2024 at 01:37:40PM +0300, Leon Romanovsky via Devel wrote:
> On Tue, Apr 09, 2024 at 07:37:20PM +0200, Antony Antony via Devel wrote:
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> > 
> > This feature sets the groundwork for future patches, including
> > the upcoming IP-TFS patch.
> > 
> > v7->v8:
> >  - add extra validation check on replay window and seq
> >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> 
> Why? Update is add and delete operation, and one can update any field
> he/she wants, including direction.

Update operations are not strictly necessary without IKEv2. However, during
IKEv2 negotiation, updating "in" SA becomes essential.

Here's what I figured out. initially getting confused watching "ip xfrm 
monitor". During the IKE negotiation, specifically at the IKE_AUTH
exchange, userspace calls ALLOCSPI for the "in" SA. The kernel creates an
xfrm_state with the allocated SPI but without cryptographic parameters, as
user space hasn't added any SAs, either "in" or "out", at this point. Also,
userspace hasn't derived crypto and other parameters for the SAs. The 
negotiation then proceeds. Upon successful negotiation, the "in" SA can only be
updated, which is why *swan will send an xfrm update for the "in" SA and
add_sa for the "out" SA.

Also, as I understand it, ALLOCSPI states are with:
km.state = XFRM_STATE_VOID

So you won't see it in "ip xfrm state" or in "ip xfrm monitor", just see he 
Update message.  The km.state for ALLOCSPI state can also be XFRM_STATE_ACQ.  
I haven't seen this exactly in operation. Note in v10 of this patch set I 
fixed ALLOCSPI to work with DIR and UPDSA.

> 
> > 
> > v6->v7:
> >  - add replay-window check non-esn 0 and ESN 1.
> >  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
> > 
> > v5->v6:
> >  - XFRMA_SA_DIR only allowed with HW OFFLOAD
> > 
> > v4->v5:
> >  - add details to commit message
> > 
> > v3->v4:
> >  - improve HW OFFLOAD DIR check add the other direction
> > 
> > v2->v3:
> >  - delete redundant XFRM_SA_DIR_USE
> >  - use u8 for "dir"
> >  - fix HW OFFLOAD DIR check
> > 
> > v1->v2:
> >  - use .strict_start_type in struct nla_policy xfrma_policy
> >  - delete redundant XFRM_SA_DIR_MAX enum
> 
> Please put changelog after --- trailer.

ack! I will be more carefull.

thanks,
-antony

> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> >  include/net/xfrm.h        |  1 +
> >  include/uapi/linux/xfrm.h |  6 +++
> >  net/xfrm/xfrm_compat.c    |  7 +++-
> >  net/xfrm/xfrm_device.c    |  6 +++
> >  net/xfrm/xfrm_state.c     |  4 ++
> >  net/xfrm/xfrm_user.c      | 85 +++++++++++++++++++++++++++++++++++++--
> >  6 files changed, 103 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 57c743b7e4fe..7c9be06f8302 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -291,6 +291,7 @@ struct xfrm_state {
> >  	/* Private data of this transformer, format is opaque,
> >  	 * interpreted by xfrm_type methods. */
> >  	void			*data;
> > +	u8			dir;
> >
> };
> >  
> >  static inline struct net *xs_net(struct xfrm_state *x)
> > diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> > index 6a77328be114..18ceaba8486e 100644
> > --- a/include/uapi/linux/xfrm.h
> > +++ b/include/uapi/linux/xfrm.h
> > @@ -141,6 +141,11 @@ enum {
> >  	XFRM_POLICY_MAX	= 3
> >  };
> >  
> > +enum xfrm_sa_dir {
> > +	XFRM_SA_DIR_IN	= 1,
> > +	XFRM_SA_DIR_OUT = 2
> > +};
> > +
> >  enum {
> >  	XFRM_SHARE_ANY,		/* No limitations */
> >  	XFRM_SHARE_SESSION,	/* For this session only */
> > @@ -315,6 +320,7 @@ enum xfrm_attr_type_t {
> >  	XFRMA_SET_MARK_MASK,	/* __u32 */
> >  	XFRMA_IF_ID,		/* __u32 */
> >  	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
> > +	XFRMA_SA_DIR,		/* __u8 */
> >  	__XFRMA_MAX
> >  
> >  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
> > diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> > index 655fe4ff8621..007dee03b1bc 100644
> > --- a/net/xfrm/xfrm_compat.c
> > +++ b/net/xfrm/xfrm_compat.c
> > @@ -98,6 +98,7 @@ static const int compat_msg_min[XFRM_NR_MSGTYPES] = {
> >  };
> >  
> >  static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
> > +	[XFRMA_UNSPEC]          = { .strict_start_type = XFRMA_SA_DIR },
> >  	[XFRMA_SA]		= { .len = XMSGSIZE(compat_xfrm_usersa_info)},
> >  	[XFRMA_POLICY]		= { .len = XMSGSIZE(compat_xfrm_userpolicy_info)},
> >  	[XFRMA_LASTUSED]	= { .type = NLA_U64},
> > @@ -129,6 +130,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
> >  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
> >  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
> >  	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
> > +	[XFRMA_SA_DIR]          = { .type = NLA_U8}
> >  };
> >  
> >  static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
> > @@ -277,9 +279,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
> >  	case XFRMA_SET_MARK_MASK:
> >  	case XFRMA_IF_ID:
> >  	case XFRMA_MTIMER_THRESH:
> > +	case XFRMA_SA_DIR:
> >  		return xfrm_nla_cpy(dst, src, nla_len(src));
> >  	default:
> > -		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
> > +		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
> >  		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
> >  		return -EOPNOTSUPP;
> >  	}
> > @@ -434,7 +437,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
> >  	int err;
> >  
> >  	if (type > XFRMA_MAX) {
> > -		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
> > +		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
> >  		NL_SET_ERR_MSG(extack, "Bad attribute");
> >  		return -EOPNOTSUPP;
> >  	}
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > index 6346690d5c69..2455a76a1cff 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> >  		return -EINVAL;
> >  	}
> >  
> > +	if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
> > +	    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN)) {
> > +		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> > +		return -EINVAL;
> > +	}
> > +
> >  	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
> >  
> >  	/* We don't yet support UDP encapsulation and TFC padding. */
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 0c306473a79d..f7771a69ae2e 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -1744,6 +1744,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
> >  	x->lastused = orig->lastused;
> >  	x->new_mapping = 0;
> >  	x->new_mapping_sport = 0;
> > +	x->dir = orig->dir;
> >  
> >  	return x;
> >  
> > @@ -1857,6 +1858,9 @@ int xfrm_state_update(struct xfrm_state *x)
> >  	if (!x1)
> >  		goto out;
> >  
> > +	if (x1->dir != x->dir)
> > +		goto out;
> > +
> >  	if (xfrm_state_kern(x1)) {
> >  		to_put = x1;
> >  		err = -EEXIST;
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index 810b520493f3..4e5256155c73 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -360,6 +360,55 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
> >  		}
> >  	}
> >  
> > +	if (attrs[XFRMA_SA_DIR]) {
> > +		u8 sa_dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
> > +
> > +		if (sa_dir != XFRM_SA_DIR_IN && sa_dir != XFRM_SA_DIR_OUT)  {
> > +			NL_SET_ERR_MSG(extack, "XFRMA_SA_DIR attribute is out of range");
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		if (sa_dir == XFRM_SA_DIR_OUT)  {
> > +			if (p->replay_window > 0) {
> > +				NL_SET_ERR_MSG(extack, "Replay window should not be set for OUT SA");
> > +				err = -EINVAL;
> > +				goto out;
> > +			}
> > +
> > +			if (attrs[XFRMA_REPLAY_VAL]) {
> > +				struct xfrm_replay_state *rp;
> > +
> > +				rp = nla_data(attrs[XFRMA_REPLAY_VAL]);
> > +				if (rp->oseq ||  rp->seq || rp->bitmap) {
> > +					NL_SET_ERR_MSG(extack,
> > +						       "Replay seq, oseq, or bitmap should not be set for OUT SA with ESN");
> > +					err = -EINVAL;
> > +					goto out;
> > +				}
> > +			}
> > +
> > +			if (attrs[XFRMA_REPLAY_ESN_VAL]) {
> > +				struct xfrm_replay_state_esn *esn;
> > +
> > +				esn = nla_data(attrs[XFRMA_REPLAY_ESN_VAL]);
> > +				if (esn->replay_window > 1) {
> > +					NL_SET_ERR_MSG(extack,
> > +						       "Replay window should be 1 for  OUT SA with ESN");
> > +					err = -EINVAL;
> > +					goto out;
> > +				}
> > +
> > +				if (esn->seq || esn->seq_hi || esn->bmp_len) {
> > +					NL_SET_ERR_MSG(extack,
> > +						       "Replay seq, seq_hi, bmp_len should not be set for OUT SA with ESN");
> > +					err = -EINVAL;
> > +					goto out;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> >  out:
> >  	return err;
> >  }
> > @@ -627,6 +676,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
> >  	struct nlattr *et = attrs[XFRMA_ETIMER_THRESH];
> >  	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
> >  	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
> > +	struct nlattr *dir = attrs[XFRMA_SA_DIR];
> >  
> >  	if (re && x->replay_esn && x->preplay_esn) {
> >  		struct xfrm_replay_state_esn *replay_esn;
> > @@ -661,6 +711,9 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
> >  
> >  	if (mt)
> >  		x->mapping_maxage = nla_get_u32(mt);
> > +
> > +	if (dir)
> > +		x->dir = nla_get_u8(dir);
> >  }
> >  
> >  static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
> > @@ -1182,8 +1235,13 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
> >  		if (ret)
> >  			goto out;
> >  	}
> > -	if (x->mapping_maxage)
> > +	if (x->mapping_maxage) {
> >  		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
> > +		if (ret)
> > +			goto out;
> > +	}
> > +	if (x->dir)
> > +		ret = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> >  out:
> >  	return ret;
> >  }
> > @@ -2402,7 +2460,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
> >  	       + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
> >  	       + nla_total_size(sizeof(struct xfrm_mark))
> >  	       + nla_total_size(4) /* XFRM_AE_RTHR */
> > -	       + nla_total_size(4); /* XFRM_AE_ETHR */
> > +	       + nla_total_size(4) /* XFRM_AE_ETHR */
> > +	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
> >  }
> >  
> >  static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
> > @@ -2459,6 +2518,12 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
> >  	if (err)
> >  		goto out_cancel;
> >  
> > +	if (x->dir) {
> > +		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> > +		if (err)
> > +			goto out_cancel;
> > +	}
> > +
> >  	nlmsg_end(skb, nlh);
> >  	return 0;
> >  
> > @@ -3018,6 +3083,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
> >  #undef XMSGSIZE
> >  
> >  const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
> > +	[XFRMA_UNSPEC]		= { .strict_start_type = XFRMA_SA_DIR },
> >  	[XFRMA_SA]		= { .len = sizeof(struct xfrm_usersa_info)},
> >  	[XFRMA_POLICY]		= { .len = sizeof(struct xfrm_userpolicy_info)},
> >  	[XFRMA_LASTUSED]	= { .type = NLA_U64},
> > @@ -3049,6 +3115,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
> >  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
> >  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
> >  	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
> > +	[XFRMA_SA_DIR]          = { .type = NLA_U8 }
> >  };
> >  EXPORT_SYMBOL_GPL(xfrma_policy);
> >  
> > @@ -3189,8 +3256,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)
> >  
> >  static inline unsigned int xfrm_expire_msgsize(void)
> >  {
> > -	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
> > -	       + nla_total_size(sizeof(struct xfrm_mark));
> > +	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
> > +	       nla_total_size(sizeof(struct xfrm_mark)) +
> > +	       nla_total_size(sizeof_field(struct xfrm_state, dir));
> >  }
> >  
> >  static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
> > @@ -3217,6 +3285,12 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
> >  	if (err)
> >  		return err;
> >  
> > +	if (x->dir) {
> > +		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >  	nlmsg_end(skb, nlh);
> >  	return 0;
> >  }
> > @@ -3324,6 +3398,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
> >  	if (x->mapping_maxage)
> >  		l += nla_total_size(sizeof(x->mapping_maxage));
> >  
> > +	if (x->dir)
> > +		l += nla_total_size(sizeof(x->dir));
> > +
> >  	return l;
> >  }
> >  
> > -- 
> > 2.30.2
> > 

