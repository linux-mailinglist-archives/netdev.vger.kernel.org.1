Return-Path: <netdev+bounces-78070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F21873FC7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8411C2312E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D8213E7F5;
	Wed,  6 Mar 2024 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="EfsEePAc"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BCB137922
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750362; cv=none; b=p1WTlmhmJ1gnZ5Biz2YsIZs74Hz3Y/yyET1b0gybiDnkuvTMlobN0TL2967ln0ne/jZ066hr1XO0J+E0fqrEk/JKfDhG32LqdJOC6SjSdQkRLBfCelYI0p47m0ZHAnAhMiW9n6OeUUj9i0HnP8ElsMX+Twkm26CsnJF9EvZ/Nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750362; c=relaxed/simple;
	bh=4GYSFtw+DSNrL4z26jMexmeJTA8eECVNcGcseKYEMyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW/9IV7NHQc+hTAH9/1jpW7HWyOTkLtgv4GOkQqbruwVjl8GMivheYaiwTufudBeJriEx0PfDjqbgNn8bACbQybJPB0sDo0e+g1Y5d1cUGSCyKP2i+X/wXkvszT5RLnUiYXyCbcAr/NRIVFeaQhy2kwTIj1cOgt5r/LbMZcTDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=EfsEePAc; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 8cadb367-dbe8-11ee-bfb6-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8cadb367-dbe8-11ee-bfb6-005056ab378f;
	Wed, 06 Mar 2024 19:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=TBzQS2gpShD9BM1H4ufqUQ5CYk2U0L9GJQHGOL0v70Q=;
	b=EfsEePAcDG3YzchgwsOkUDz48tnjF6kmslvjOPNQWF8jCYT3ZjkCDRfX5RatPDD9Ek/lmC9XIewlH
	 d5c/BIm/aCtrM2MScKXt1AZCW7tGp62kGlGyekjVKuSefonPBYRnQ2wvarDhH4SHc/YgtLXN54JAyr
	 ekLthGduVX5zLYpc=
X-KPN-MID: 33|4hUpY0HYzHPyjRlH+FXZnIa9+NG+LNqCNodxV83rsM4pV16J0/xvlZ8xNQs6r+n
 g9/xNsWbbwJYhlZopT20Cd1Zzr3YkqbnLGI1ajmn/Z+8=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|wEj69BV0zgmYXWpkmdAWofVolLE6gh3yORO1GloSk/LQ5FbXRv9iKfCgFZRkhPt
 5GHo8ZWxp06CoPL2sVU43eg==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ac70045f-dbe8-11ee-8d35-005056ab7447;
	Wed, 06 Mar 2024 19:38:08 +0100 (CET)
Date: Wed, 6 Mar 2024 19:38:06 +0100
From: Antony Antony <antony@phenome.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: antony.antony@secunet.com, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [DKIM] Re: [devel-ipsec] [PATCH ipsec-next] xfrm: Add Direction
 to the SA in or out
Message-ID: <Zei4DjGVpg6Tgr0P@Antony2201.local>
References: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
 <CAHsH6Gtx6Jrs5TWWraDqSzfAuEth=13fvC73+afXCmYJBvbm3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6Gtx6Jrs5TWWraDqSzfAuEth=13fvC73+afXCmYJBvbm3w@mail.gmail.com>

Hi Eyal,

On Sun, Mar 03, 2024 at 02:30:46PM -0800, Eyal Birger via Devel wrote:
..
> On Sun, Mar 3, 2024 at 1:09 PM Antony Antony <antony.antony@secunet.com> 
> wrote:
> >
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> 
> Nice! Minor comments below.

Thanks for your feedback. See my response below. I don't understand how 
would I add ".strict_start_type". 

> >
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> >  include/net/xfrm.h        |  1 +
> >  include/uapi/linux/xfrm.h |  8 ++++++++
> >  net/xfrm/xfrm_compat.c    |  6 ++++--
> >  net/xfrm/xfrm_device.c    |  5 +++++
> >  net/xfrm/xfrm_state.c     |  1 +
> >  net/xfrm/xfrm_user.c      | 43 +++++++++++++++++++++++++++++++++++----
> >  6 files changed, 58 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 1d107241b901..91348a03469c 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -289,6 +289,7 @@ struct xfrm_state {
> >         /* Private data of this transformer, format is opaque,
> >          * interpreted by xfrm_type methods. */
> >         void                    *data;
> > +       enum xfrm_sa_dir        dir;
> >  };
> >
> >  static inline struct net *xs_net(struct xfrm_state *x)
> > diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> > index 6a77328be114..2f1d67239301 100644
> > --- a/include/uapi/linux/xfrm.h
> > +++ b/include/uapi/linux/xfrm.h
> > @@ -141,6 +141,13 @@ enum {
> >         XFRM_POLICY_MAX = 3
> >  };
> >
> > +enum xfrm_sa_dir {
> > +       XFRM_SA_DIR_UNSET = 0,
> > +       XFRM_SA_DIR_IN  = 1,
> > +       XFRM_SA_DIR_OUT = 2,
> > +       XFRM_SA_DIR_MAX = 3,
> 
> nit: comma is redundant after a "MAX" no?

I removed it. Actually XFRM_SA_DIR_MAX also as Leon pointed out it is not 
necessary.

> 
> > +};
> > +
> >  enum {
> >         XFRM_SHARE_ANY,         /* No limitations */
> >         XFRM_SHARE_SESSION,     /* For this session only */
> > @@ -315,6 +322,7 @@ enum xfrm_attr_type_t {
> >         XFRMA_SET_MARK_MASK,    /* __u32 */
> >         XFRMA_IF_ID,            /* __u32 */
> >         XFRMA_MTIMER_THRESH,    /* __u32 in seconds for input SA */
> > +       XFRMA_SA_DIR,           /* __u8 */
> >         __XFRMA_MAX
> >
> >  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK       /* Compatibility */
> > diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> > index 655fe4ff8621..de0e1508f870 100644
> > --- a/net/xfrm/xfrm_compat.c
> > +++ b/net/xfrm/xfrm_compat.c
> > @@ -129,6 +129,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
> >         [XFRMA_SET_MARK_MASK]   = { .type = NLA_U32 },
> >         [XFRMA_IF_ID]           = { .type = NLA_U32 },
> >         [XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
> > +       [XFRMA_SA_DIR]          = { .type = NLA_U8 },
> >  };
> >
> >  static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
> > @@ -277,9 +278,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
> >         case XFRMA_SET_MARK_MASK:
> >         case XFRMA_IF_ID:
> >         case XFRMA_MTIMER_THRESH:
> > +       case XFRMA_SA_DIR:
> >                 return xfrm_nla_cpy(dst, src, nla_len(src));
> >         default:
> > -               BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
> > +               BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
> >                 pr_warn_once("unsupported nla_type %d\n", src->nla_type);
> >                 return -EOPNOTSUPP;
> >         }
> > @@ -434,7 +436,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
> >         int err;
> >
> >         if (type > XFRMA_MAX) {
> > -               BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
> > +               BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
> >                 NL_SET_ERR_MSG(extack, "Bad attribute");
> >                 return -EOPNOTSUPP;
> >         }
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > index 3784534c9185..11339d7d7140 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -253,6 +253,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> >                 return -EINVAL;
> >         }
> >
> > +       if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir != XFRM_SA_DIR_IN) {
> > +               NL_SET_ERR_MSG(extack, "Mismatch in SA and offload direction");
> > +               return -EINVAL;
> > +       }
> > +
> >         is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
> >
> >         /* We don't yet support UDP encapsulation and TFC padding. */
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index bda5327bf34d..0d6f5a49002f 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -1744,6 +1744,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
> >         x->lastused = orig->lastused;
> >         x->new_mapping = 0;
> >         x->new_mapping_sport = 0;
> > +       x->dir = orig->dir;
> >
> >         return x;
> >
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index ad01997c3aa9..fe4576e96dd4 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -360,6 +360,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
> >                 }
> >         }
> >
> > +       if (attrs[XFRMA_SA_DIR]) {
> > +               u8 sa_dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
> > +
> > +               if (!sa_dir || sa_dir >= XFRM_SA_DIR_MAX)  {
> > +                       NL_SET_ERR_MSG(extack, "XFRMA_SA_DIR attribute is out of range");
> > +                       err = -EINVAL;
> > +                       goto out;
> > +               }
> > +       }
> > +
> >  out:
> >         return err;
> >  }
> > @@ -627,6 +637,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
> >         struct nlattr *et = attrs[XFRMA_ETIMER_THRESH];
> >         struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
> >         struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
> > +       struct nlattr *dir = attrs[XFRMA_SA_DIR];
> >
> >         if (re && x->replay_esn && x->preplay_esn) {
> >                 struct xfrm_replay_state_esn *replay_esn;
> > @@ -661,6 +672,9 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
> >
> >         if (mt)
> >                 x->mapping_maxage = nla_get_u32(mt);
> > +
> > +       if (dir)
> > +               x->dir = nla_get_u8(dir);
> 
> It's not clear to me why this belongs in xfrm_update_ae_params().
> IOW, why isn't this done in xfrm_state_construct(), like if_id?

I am in favor adding direction to all NL messages which include xfrm_state 
for consitancy. Also when offload is enabled and xuo flags falg  
XFRM_OFFLOAD_INBOUND is set. I am hopping in the long term offload can also 
x->dir instead of this xuo->flags.


> >  }
> >
> >  static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
> > @@ -1182,8 +1196,13 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
> >                 if (ret)
> >                         goto out;
> >         }
> > -       if (x->mapping_maxage)
> > +       if (x->mapping_maxage) {
> >                 ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
> > +               if (ret)
> > +                       goto out;
> > +       }
> > +       if (x->dir)
> > +               ret = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> >  out:
> >         return ret;
> >  }
> > @@ -2399,7 +2418,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
> >                + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
> >                + nla_total_size(sizeof(struct xfrm_mark))
> >                + nla_total_size(4) /* XFRM_AE_RTHR */
> > -              + nla_total_size(4); /* XFRM_AE_ETHR */
> > +              + nla_total_size(4) /* XFRM_AE_ETHR */
> > +              + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
> >  }
> >
> >  static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
> > @@ -2453,6 +2473,11 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
> >                 goto out_cancel;
> >
> >         err = xfrm_if_id_put(skb, x->if_id);
> > +       if (err)
> > +               goto out_cancel;
> > +       if (x->dir)
> > +               err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> > +
> >         if (err)
> >                 goto out_cancel;
> >
> > @@ -3046,6 +3071,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
> >         [XFRMA_SET_MARK_MASK]   = { .type = NLA_U32 },
> >         [XFRMA_IF_ID]           = { .type = NLA_U32 },
> >         [XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
> > +       [XFRMA_SA_DIR]          = { .type = NLA_U8 },
> 
> Maybe add a ".strict_start_type"?

Isn't this for the first element? I don't understand your suggestion.
Are you advising to add to [XFRMA_SA_DIR]? Would you like explain a bit 
more?

> 
> >
> >  };
> >  EXPORT_SYMBOL_GPL(xfrma_policy);
> >
> > @@ -3186,8 +3212,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)
> >
> >  static inline unsigned int xfrm_expire_msgsize(void)
> >  {
> > -       return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
> > -              + nla_total_size(sizeof(struct xfrm_mark));
> > +       return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
> > +              nla_total_size(sizeof(struct xfrm_mark)) +
> > +              nla_total_size(sizeof_field(struct xfrm_state, dir));
> >  }
> >
> >  static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
> > @@ -3214,6 +3241,11 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
> >         if (err)
> >                 return err;
> >
> > +       if (x->dir)
> > +               err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> > +       if (err)
> > +               return err;
> > +
> >         nlmsg_end(skb, nlh);
> >         return 0;
> >  }
> > @@ -3321,6 +3353,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
> >         if (x->mapping_maxage)
> >                 l += nla_total_size(sizeof(x->mapping_maxage));
> >
> > +       if (x->dir)
> > +               l += nla_total_size(sizeof(x->dir));
> > +
> >         return l;
> >  }
> >
> > --
> > 2.30.2

