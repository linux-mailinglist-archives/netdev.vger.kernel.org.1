Return-Path: <netdev+bounces-78078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C522874009
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AF4285B70
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1013E7CA;
	Wed,  6 Mar 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR4TTvJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437875FDCC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751492; cv=none; b=JDWnOV05cdWQ/vTSve7EaFc6U2NrnkC0J7bjE4FP5XcmZkbRgM2sdVjSv0QpN5X6lgbdFb9Zba25buyXM6HnvAbUEygENYNSEivpGHkvAfBkJ5joEyz2CsGYROh/wF4sRo4p6kUuMUa0ry5y80n2SB2gRjy8W2508Mz5GIepQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751492; c=relaxed/simple;
	bh=IgcMuzowbx13b/VDfzALNcxrKiMYWWvK4ZP8KEZSlh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4zpXgU9xkcq1/sePRCGguxvsUUBpWYgZA++xP1b69qNTbyemA/4jLv/kqAU10CLmjfwLtRArOZpe5EkGQLfpl38viNndnSyRjFuGyZfJx5bpwkrhljZw3A2v4BjcAopndVg0wyDOH4BYEV7V4rg5Z1AmUaVjxQauY4CMOyg2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR4TTvJL; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d995bd557eso15813241.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709751489; x=1710356289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiuUx03aYdT5jdCOZD6zdtQ1RZVEVEdME28C1cRHT2E=;
        b=CR4TTvJL3jU7uiAvbkB/8r7+N8ytf6XTyU0tg76b+RcG6xKlhg5WKM82jEO2r0LF53
         c79pdh7Jew9HsOMOp7X0b3vT1gKAHc1JBU5vKWWzqqGLJItdwdxaTBvleG3mL+L1vwwR
         4gIsQ4VTH/7nO3oBK8hma0qvGehdQJaItNW625WEnquS3akdPYbCq+iB4KodVo4kpbYZ
         Q6qni2vdYYwfeh6NAwqai/BbsU1GfcEbGabMRg0EloSZ2eG5E+Sn2e/G2jQVBmqo9a0c
         2zEAMTpXc0b8Qdn2ojMACvKF0Rg46l2tFv2p0n6BfcZRoaChH40rH9uTlKlusC6veFpl
         iFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709751489; x=1710356289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiuUx03aYdT5jdCOZD6zdtQ1RZVEVEdME28C1cRHT2E=;
        b=KJaAXqras11bFSqj+ggr8uTN/hV3dIcZrKc7u1bshaMu6jmYrZ6MuogXgtGT4tc7OK
         yHxRMfb6DMv9xvwomRjkGyoIo/C/cMsrlqKg2RpqsdeV6MDivaj7IoUuZTsu9zaf5Lhj
         GvfiQtMQs5fobw7PSLP2qsRbBhPfNoP6cCWigUswhkYPlH6oLgGmjOuX98cSmRlqrlze
         7lfaew+cVm78fAmGYWDF9NCwKZqPjQf+wdVL92Tm/8a00KiUQvK31yOVmuUxgZCo4WJE
         a4GwQ3x+E8XwD20q71/lfbB3SPrn6jn2Go1kIYUIyGX+I6YQMe/0F3idOw33v6ZP64Fi
         dxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyh6qPC3M6U4wgJSBlCuxc6pnDj2JYBPd0gqTn7T574P60rAfp6NR0BQ9kYNpw99tbcAquPP7ImIJPqtH4+VK0o3jTqz31
X-Gm-Message-State: AOJu0YzGy29G5UVQiH3k4xGFabvo+DeU9Mmfq0O3btzgCbdKSZcJGVXf
	/i/Rt2nKQwEzaa/NAyIursWqji5djJmwxl41GTSphVTVKwGtySLNKvTWttPg95VqrRkbtHDv614
	2G2leJckWu3/qSvLgqMupRrFSIEtnyMohJNo=
X-Google-Smtp-Source: AGHT+IGcU8C8p26idkkeuHenqTIRuNE7QSc53y7YfGDxWDuS0b4KWa1g6ZzrgQeBSRgskD3fUyxZVx4kaVU0FFvu8qg=
X-Received: by 2002:a67:ba1a:0:b0:472:fcf4:d411 with SMTP id
 l26-20020a67ba1a000000b00472fcf4d411mr89243vsn.27.1709751489058; Wed, 06 Mar
 2024 10:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
 <CAHsH6Gtx6Jrs5TWWraDqSzfAuEth=13fvC73+afXCmYJBvbm3w@mail.gmail.com> <Zei4DjGVpg6Tgr0P@Antony2201.local>
In-Reply-To: <Zei4DjGVpg6Tgr0P@Antony2201.local>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 6 Mar 2024 10:57:57 -0800
Message-ID: <CAHsH6GsmFA=J76BhiH=ZRAwQ77wg2=uQH9e+UsphmwO92KfXZA@mail.gmail.com>
Subject: Re: [DKIM] Re: [devel-ipsec] [PATCH ipsec-next] xfrm: Add Direction
 to the SA in or out
To: Antony Antony <antony@phenome.org>
Cc: antony.antony@secunet.com, netdev@vger.kernel.org, devel@linux-ipsec.org, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antony,

On Wed, Mar 6, 2024 at 10:38=E2=80=AFAM Antony Antony <antony@phenome.org> =
wrote:
>
> Hi Eyal,
>
> On Sun, Mar 03, 2024 at 02:30:46PM -0800, Eyal Birger via Devel wrote:
> ..
> > On Sun, Mar 3, 2024 at 1:09=E2=80=AFPM Antony Antony <antony.antony@sec=
unet.com>
> > wrote:
> > >
> > > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > > xfrm_state, SA, enhancing usability by delineating the scope of value=
s
> > > based on direction. An input SA will now exclusively encompass values
> > > pertinent to input, effectively segregating them from output-related
> > > values. This change aims to streamline the configuration process and
> > > improve the overall clarity of SA attributes.
> >
> > Nice! Minor comments below.
>
> Thanks for your feedback. See my response below. I don't understand how
> would I add ".strict_start_type".
>
> > >
> > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > ---
> > >  include/net/xfrm.h        |  1 +
> > >  include/uapi/linux/xfrm.h |  8 ++++++++
> > >  net/xfrm/xfrm_compat.c    |  6 ++++--
> > >  net/xfrm/xfrm_device.c    |  5 +++++
> > >  net/xfrm/xfrm_state.c     |  1 +
> > >  net/xfrm/xfrm_user.c      | 43 +++++++++++++++++++++++++++++++++++--=
--
> > >  6 files changed, 58 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > > index 1d107241b901..91348a03469c 100644
> > > --- a/include/net/xfrm.h
> > > +++ b/include/net/xfrm.h
> > > @@ -289,6 +289,7 @@ struct xfrm_state {
> > >         /* Private data of this transformer, format is opaque,
> > >          * interpreted by xfrm_type methods. */
> > >         void                    *data;
> > > +       enum xfrm_sa_dir        dir;
> > >  };
> > >
> > >  static inline struct net *xs_net(struct xfrm_state *x)
> > > diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> > > index 6a77328be114..2f1d67239301 100644
> > > --- a/include/uapi/linux/xfrm.h
> > > +++ b/include/uapi/linux/xfrm.h
> > > @@ -141,6 +141,13 @@ enum {
> > >         XFRM_POLICY_MAX =3D 3
> > >  };
> > >
> > > +enum xfrm_sa_dir {
> > > +       XFRM_SA_DIR_UNSET =3D 0,
> > > +       XFRM_SA_DIR_IN  =3D 1,
> > > +       XFRM_SA_DIR_OUT =3D 2,
> > > +       XFRM_SA_DIR_MAX =3D 3,
> >
> > nit: comma is redundant after a "MAX" no?
>
> I removed it. Actually XFRM_SA_DIR_MAX also as Leon pointed out it is not
> necessary.

Great.

>
> >
> > > +};
> > > +
> > >  enum {
> > >         XFRM_SHARE_ANY,         /* No limitations */
> > >         XFRM_SHARE_SESSION,     /* For this session only */
> > > @@ -315,6 +322,7 @@ enum xfrm_attr_type_t {
> > >         XFRMA_SET_MARK_MASK,    /* __u32 */
> > >         XFRMA_IF_ID,            /* __u32 */
> > >         XFRMA_MTIMER_THRESH,    /* __u32 in seconds for input SA */
> > > +       XFRMA_SA_DIR,           /* __u8 */
> > >         __XFRMA_MAX
> > >
> > >  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK       /* Compatibility */
> > > diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> > > index 655fe4ff8621..de0e1508f870 100644
> > > --- a/net/xfrm/xfrm_compat.c
> > > +++ b/net/xfrm/xfrm_compat.c
> > > @@ -129,6 +129,7 @@ static const struct nla_policy compat_policy[XFRM=
A_MAX+1] =3D {
> > >         [XFRMA_SET_MARK_MASK]   =3D { .type =3D NLA_U32 },
> > >         [XFRMA_IF_ID]           =3D { .type =3D NLA_U32 },
> > >         [XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> > > +       [XFRMA_SA_DIR]          =3D { .type =3D NLA_U8 },
> > >  };
> > >
> > >  static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
> > > @@ -277,9 +278,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst=
, const struct nlattr *src)
> > >         case XFRMA_SET_MARK_MASK:
> > >         case XFRMA_IF_ID:
> > >         case XFRMA_MTIMER_THRESH:
> > > +       case XFRMA_SA_DIR:
> > >                 return xfrm_nla_cpy(dst, src, nla_len(src));
> > >         default:
> > > -               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_MTIMER_THRESH);
> > > +               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_SA_DIR);
> > >                 pr_warn_once("unsupported nla_type %d\n", src->nla_ty=
pe);
> > >                 return -EOPNOTSUPP;
> > >         }
> > > @@ -434,7 +436,7 @@ static int xfrm_xlate32_attr(void *dst, const str=
uct nlattr *nla,
> > >         int err;
> > >
> > >         if (type > XFRMA_MAX) {
> > > -               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_MTIMER_THRESH);
> > > +               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_SA_DIR);
> > >                 NL_SET_ERR_MSG(extack, "Bad attribute");
> > >                 return -EOPNOTSUPP;
> > >         }
> > > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > > index 3784534c9185..11339d7d7140 100644
> > > --- a/net/xfrm/xfrm_device.c
> > > +++ b/net/xfrm/xfrm_device.c
> > > @@ -253,6 +253,11 @@ int xfrm_dev_state_add(struct net *net, struct x=
frm_state *x,
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir !=3D XFRM_SA_=
DIR_IN) {
> > > +               NL_SET_ERR_MSG(extack, "Mismatch in SA and offload di=
rection");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > >         is_packet_offload =3D xuo->flags & XFRM_OFFLOAD_PACKET;
> > >
> > >         /* We don't yet support UDP encapsulation and TFC padding. */
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index bda5327bf34d..0d6f5a49002f 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -1744,6 +1744,7 @@ static struct xfrm_state *xfrm_state_clone(stru=
ct xfrm_state *orig,
> > >         x->lastused =3D orig->lastused;
> > >         x->new_mapping =3D 0;
> > >         x->new_mapping_sport =3D 0;
> > > +       x->dir =3D orig->dir;
> > >
> > >         return x;
> > >
> > > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > > index ad01997c3aa9..fe4576e96dd4 100644
> > > --- a/net/xfrm/xfrm_user.c
> > > +++ b/net/xfrm/xfrm_user.c
> > > @@ -360,6 +360,16 @@ static int verify_newsa_info(struct xfrm_usersa_=
info *p,
> > >                 }
> > >         }
> > >
> > > +       if (attrs[XFRMA_SA_DIR]) {
> > > +               u8 sa_dir =3D nla_get_u8(attrs[XFRMA_SA_DIR]);
> > > +
> > > +               if (!sa_dir || sa_dir >=3D XFRM_SA_DIR_MAX)  {
> > > +                       NL_SET_ERR_MSG(extack, "XFRMA_SA_DIR attribut=
e is out of range");
> > > +                       err =3D -EINVAL;
> > > +                       goto out;
> > > +               }
> > > +       }
> > > +
> > >  out:
> > >         return err;
> > >  }
> > > @@ -627,6 +637,7 @@ static void xfrm_update_ae_params(struct xfrm_sta=
te *x, struct nlattr **attrs,
> > >         struct nlattr *et =3D attrs[XFRMA_ETIMER_THRESH];
> > >         struct nlattr *rt =3D attrs[XFRMA_REPLAY_THRESH];
> > >         struct nlattr *mt =3D attrs[XFRMA_MTIMER_THRESH];
> > > +       struct nlattr *dir =3D attrs[XFRMA_SA_DIR];
> > >
> > >         if (re && x->replay_esn && x->preplay_esn) {
> > >                 struct xfrm_replay_state_esn *replay_esn;
> > > @@ -661,6 +672,9 @@ static void xfrm_update_ae_params(struct xfrm_sta=
te *x, struct nlattr **attrs,
> > >
> > >         if (mt)
> > >                 x->mapping_maxage =3D nla_get_u32(mt);
> > > +
> > > +       if (dir)
> > > +               x->dir =3D nla_get_u8(dir);
> >
> > It's not clear to me why this belongs in xfrm_update_ae_params().
> > IOW, why isn't this done in xfrm_state_construct(), like if_id?
>
> I am in favor adding direction to all NL messages which include xfrm_stat=
e
> for consitancy. Also when offload is enabled and xuo flags falg
> XFRM_OFFLOAD_INBOUND is set. I am hopping in the long term offload can al=
so
> x->dir instead of this xuo->flags.

I see. Thanks for the explanation.

>
>
> > >  }
> > >
> > >  static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark =
*m)
> > > @@ -1182,8 +1196,13 @@ static int copy_to_user_state_extra(struct xfr=
m_state *x,
> > >                 if (ret)
> > >                         goto out;
> > >         }
> > > -       if (x->mapping_maxage)
> > > +       if (x->mapping_maxage) {
> > >                 ret =3D nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapp=
ing_maxage);
> > > +               if (ret)
> > > +                       goto out;
> > > +       }
> > > +       if (x->dir)
> > > +               ret =3D nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> > >  out:
> > >         return ret;
> > >  }
> > > @@ -2399,7 +2418,8 @@ static inline unsigned int xfrm_aevent_msgsize(=
struct xfrm_state *x)
> > >                + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur=
))
> > >                + nla_total_size(sizeof(struct xfrm_mark))
> > >                + nla_total_size(4) /* XFRM_AE_RTHR */
> > > -              + nla_total_size(4); /* XFRM_AE_ETHR */
> > > +              + nla_total_size(4) /* XFRM_AE_ETHR */
> > > +              + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
> > >  }
> > >
> > >  static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, c=
onst struct km_event *c)
> > > @@ -2453,6 +2473,11 @@ static int build_aevent(struct sk_buff *skb, s=
truct xfrm_state *x, const struct
> > >                 goto out_cancel;
> > >
> > >         err =3D xfrm_if_id_put(skb, x->if_id);
> > > +       if (err)
> > > +               goto out_cancel;
> > > +       if (x->dir)
> > > +               err =3D nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> > > +
> > >         if (err)
> > >                 goto out_cancel;
> > >
> > > @@ -3046,6 +3071,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+=
1] =3D {
> > >         [XFRMA_SET_MARK_MASK]   =3D { .type =3D NLA_U32 },
> > >         [XFRMA_IF_ID]           =3D { .type =3D NLA_U32 },
> > >         [XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> > > +       [XFRMA_SA_DIR]          =3D { .type =3D NLA_U8 },
> >
> > Maybe add a ".strict_start_type"?
>
> Isn't this for the first element? I don't understand your suggestion.
> Are you advising to add to [XFRMA_SA_DIR]? Would you like explain a bit
> more?

See comment on strict_start_type in include/net/netlink.h

Basically for this you'd add:

[XFRMA_UNSPEC]          =3D { .strict_start_type =3D XFRMA_SA_DIR },

To the start of the xfrma_policy array.

Eyal.

