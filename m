Return-Path: <netdev+bounces-79522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A465879B59
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 19:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF89B23DE0
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5352139584;
	Tue, 12 Mar 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="F6xyUY+i"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6804139571
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268178; cv=none; b=dkIVEs1hEIW7BGHrl3QABqUHIbXDH8iPZN8SUGv1LTHci1gBxeGtTH2rCkoDDgHDU8ucxuZxB7izs094rR6Pq4T7NcBlyJd6zLX+grb2C6L2tHAafOnbiC8BOu/xPIliJ0EXFh8ICfz+65LRSMLU0ce/ku4EKnDbOv5Cc6yfYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268178; c=relaxed/simple;
	bh=q9AMk+tqDIlOhmh/2y0xzIgC2QG9WHiNZMvrC14Ufkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8xqMTQQWdx1esFuw8TNKVrkOsNZzo5AID/MccZEegtUUZ1ajy7femll5weYNX1LQfhpZhDHJ++MBdJfdHg4xiaFtrF3vMSioZbP2yAzyX+d6GO8kCkzntue4lubEFMqExjjmzUsk2DZj5n4PTGb0845LS+09graZYN7yqT9Vps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=F6xyUY+i; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 71b2f8e3-e09e-11ee-8fdf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 71b2f8e3-e09e-11ee-8fdf-005056aba152;
	Tue, 12 Mar 2024 19:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=tbODMRyEuzhYIEfq6A9tQLu11HHO18QRy2+fWm9Do3Y=;
	b=F6xyUY+icOOKK+H0LKsUrwqOUAgRORi6UbkTQ7vgGtGa3uv6HpfXjcdBH5xaExg8DSEY1CfZWRWFU
	 P2eFk8R47Pn4LdcE2bhdF9MwLBz7D61rzN7AIfSdY3Ja8wH9rBs8Q8u29hc7INntQjksCNOR1seXS+
	 9gxNjkevSnrLtUTE=
X-KPN-MID: 33|M0mzwcXbUV1qfvDGPHogPfrpKJrVunCRoyE0RkA5Kyx4RpZrD/zd652AlwIduwv
 R3H/Hw3uuPzUH/Rt5xnujr7ixfx6Chy06ZGKI71zulm0=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|GRVNxKhLW51QnE7yxk7k7YTZt+JOF3qE7DOlGgQll/8caFl3YiWzJIPk3iCzNyq
 f8x8+QugigComGBMvtWRaMw==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 735902ac-e09e-11ee-9eff-005056ab7584;
	Tue, 12 Mar 2024 19:29:25 +0100 (CET)
Date: Tue, 12 Mar 2024 19:29:23 +0100
From: Antony Antony <antony@phenome.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Antony Antony <antony.antony@secunet.com>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject:  Re: [PATCH ipsec-next v2] xfrm: Add Direction to the SA in or out
Message-ID: <ZfCfA3ygjSRDnMme@Antony2201.local>
References: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
 <2a6015ddeb9dfff93ce6e2e25fec892a0d99acf1.1710100643.git.antony.antony@secunet.com>
 <20240311072545.GI12921@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311072545.GI12921@unreal>

Hi Leon,

On Mon, Mar 11, 2024 at 09:25:45AM +0200, Leon Romanovsky via Devel wrote:
> On Sun, Mar 10, 2024 at 09:03:47PM +0100, Antony Antony wrote:
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> > 
> > v1->v2:
> 
> Please try to avoid replying new patch versions as reply-to previous
> versions. It breaks the threading and makes it hard to track the patches.
> 
> >  - use .strict_start_type in struct nla_policy xfrma_policy
> >  - delete redundant XFRM_SA_DIR_MAX enum
> 
> Please put changelog after ---, it will allow us to make sure that
> commit message will be clean once the patch is applied.
> 
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> >  include/net/xfrm.h        |  1 +
> >  include/uapi/linux/xfrm.h |  7 +++++++
> >  net/xfrm/xfrm_compat.c    |  7 +++++--
> >  net/xfrm/xfrm_device.c    |  5 +++++
> >  net/xfrm/xfrm_state.c     |  1 +
> >  net/xfrm/xfrm_user.c      | 44 +++++++++++++++++++++++++++++++++++----
> >  6 files changed, 59 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 1d107241b901..91348a03469c 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -289,6 +289,7 @@ struct xfrm_state {
> >  	/* Private data of this transformer, format is opaque,
> >  	 * interpreted by xfrm_type methods. */
> >  	void			*data;
> > +	enum xfrm_sa_dir	dir;
> >  };
> > 
> >  static inline struct net *xs_net(struct xfrm_state *x)
> > diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> > index 6a77328be114..46a9770c720c 100644
> > --- a/include/uapi/linux/xfrm.h
> > +++ b/include/uapi/linux/xfrm.h
> > @@ -141,6 +141,12 @@ enum {
> >  	XFRM_POLICY_MAX	= 3
> >  };
> > 
> > +enum xfrm_sa_dir {
> > +	XFRM_SA_DIR_UNSET = 0,
> 
> It doesn't belong to UAPI. Kernel and user space use netlink attribute to understand
> if direction is set.

I found it is useful to check "x->dir != XFRM_SA_DIR_UNSET for e.g. in
iproute2:) We could check that in different ways. I removed it as you 
prefer.

> 
> > +	XFRM_SA_DIR_IN	= 1,
> > +	XFRM_SA_DIR_OUT	= 2
> > +};
> > +
> >  enum {
> >  	XFRM_SHARE_ANY,		/* No limitations */
> >  	XFRM_SHARE_SESSION,	/* For this session only */
> > @@ -315,6 +321,7 @@ enum xfrm_attr_type_t {
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
> > index 3784534c9185..11339d7d7140 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -253,6 +253,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> >  		return -EINVAL;
> >  	}
> > 
> > +	if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir != XFRM_SA_DIR_IN) {
> 
> It will break backward compatibility. In old iproute2 XFRM_OFFLOAD_INBOUND is set, but x->dir is not set yet.

I meant to check  "x->dir == XFRM_SA_DIR_OUT"

thanks,
-antony

