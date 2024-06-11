Return-Path: <netdev+bounces-102663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57083904223
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CF41C20862
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AC42058;
	Tue, 11 Jun 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOmWxx9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EC40C03
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125687; cv=none; b=CozFYh0kz3yHHZ/6dnYkSmu8+370jQVIZrdNGaYJixazDSR4HM0HpJyn6mb+cb18ldk2HM95hJY4Xv3DMkKqUwruRJMVbfKtY6sLdRIgYywpqavB7lILC9hWrulzJLsv7wYgjLx0EBaqUJwxsNQ5hkKPbs6PfCyBp0XHDrwIJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125687; c=relaxed/simple;
	bh=pKy4Pk8ZHE2nRNSTiu5deOtsdjvCKZLzJ8SmCTUjTqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9QQRTdgGlM774rOUgdioM2UuqT1ODlRguh3xSwVGT24JJ4mjRG8LS0VlJ1AXOxXTfo4y4RQSuqimIQLuX83mP+ycNPZEOrxNj4p2hB7+9hEGX9ft+COHRat8CL2RBHSKAyzNeL0EKD61iGJD8l2qhUdS0tqx2URD+Rqk+sLOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOmWxx9S; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df771b6cc9cso1353400276.3
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718125684; x=1718730484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXo8pEkXRpwKQYWOfGMMwODf8NlqSeScoCLf+FueFMw=;
        b=fOmWxx9SthWZF7XLu9pJXewSNtn2cXsbMDn2NNbr4kvcygdmUrO0vQl6j8sJ6OF/De
         YJIMKbvoBeqDDG/7U6ySM8h9LbFPf6c5ZJKTCUpfhw+xPdk19Vu4kN5b6Bg5ruYJ88zx
         n4oJWqs8YUgZ+C896CWDffXV9JkTelulXVxl7WMmLzl4vt769q3ndXivlYJ4qv7XKDMQ
         KB8Z4DPvGRoA8zDRSN7pIQ/amMBC0nWn7tpHv4RWmxgeAD6rGcoHI2/NG5nBK7vOFYNO
         T3zxAp2sSA9j8YbdqKKAdTfPd4z6T7WRRobf827LmQ6HWkhKxBF4yXH/fElOJ1qivbXW
         HSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718125684; x=1718730484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXo8pEkXRpwKQYWOfGMMwODf8NlqSeScoCLf+FueFMw=;
        b=mmVLiRppaIoD8KzH6oi64G3FYMCrNjvzwQks2nxcEO/XvTRxOU3yJlSMij4n7H7vnE
         RYd9qXatVPgw3XokhbRXj1ZWv2hCi/HQJzUR0kRJ97H5/yBN63Zt2vbS/Imx+3Q3rnmv
         DatzokgTenDVvxsDTIfVQTa9x2aBUssWL8GoXnWTvnW019p+CvfeA+czvrGp/xiynNob
         rZ93DezWGFhbyLlw6nn1aGjXI1jX0M2w+QQR+owsqDLnfPsGM80YGz3R1EvZwdnDG9KI
         fPyb0hiVoNr/HlZ4a+IfHX/3ldl6LD6W5nFIClSThE6E0y7Ex1zgL9XOfTStoCIwxpcH
         jjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUL2bykPL0Ae0pv/E8XShijepsSwsE2jl2RbKjzkEzy87sh+1cqd5RdOInhqfMnFNTh0u+4mX6X4zzygQhiJfW40RGKItb
X-Gm-Message-State: AOJu0Yw/NqwyDyagEojR0pn/GVMrXA+qW9DeLKFXR/r0YKCKRw/vVW59
	SQd1Pueq8l/5/Y6NANtNkhYXQoP5g1NT1YbchTL5T8WZ1c/hwgAudO6UMWq4igu1XojrTNDdOf7
	OchavXSAd+5nRicYrfV6vkqKihn0=
X-Google-Smtp-Source: AGHT+IFl3Hyjm40cxzyuOhV7i3dTrEXJVzGGYqGHdtYfR4+bYbTnT8WDGJTgQZ9aEnEaCfeKcd89GCE8rZ1w8RKcOz4=
X-Received: by 2002:a5b:1ce:0:b0:dfb:22:5712 with SMTP id 3f1490d57ef6-dfb00228993mr11496327276.63.1718125683974;
 Tue, 11 Jun 2024 10:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528032914.2551267-1-eyal.birger@gmail.com> <ZmfkZLBpWmv20hGE@Antony2201.local>
In-Reply-To: <ZmfkZLBpWmv20hGE@Antony2201.local>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 11 Jun 2024 10:07:52 -0700
Message-ID: <CAHsH6GtXWmOUGycPU4xJoSVDEGXPb+ziKb88YJvZXchsAm2fWA@mail.gmail.com>
Subject: Re: [PATCH ipsec-next,v4] xfrm: support sending NAT keepalives in ESP
 in UDP states
To: Antony Antony <antony@phenome.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, pablo@netfilter.org, paul.wouters@aiven.io, 
	nharold@google.com, mcr@sandelman.ca, devel@linux-ipsec.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antony,

On Mon, Jun 10, 2024 at 10:45=E2=80=AFPM Antony Antony <antony@phenome.org>=
 wrote:
>
> Hi Eyal,
>
> On Mon, May 27, 2024 at 08:29:14PM -0700, Eyal Birger wrote:
> > Add the ability to send out RFC-3948 NAT keepalives from the xfrm stack=
.
> >
> > To use, Userspace sets an XFRM_NAT_KEEPALIVE_INTERVAL integer property =
when
> > creating XFRM outbound states which denotes the number of seconds betwe=
en
> > keepalive messages.
> >
> > Keepalive messages are sent from a per net delayed work which iterates =
over
> > the xfrm states. The logic is guarded by the xfrm state spinlock due to=
 the
> > xfrm state walk iterator.
> >
> > Possible future enhancements:
> >
> > - Adding counters to keep track of sent keepalives.
> > - deduplicate NAT keepalives between states sharing the same nat keepal=
ive
> >   parameters.
> > - provisioning hardware offloads for devices capable of implementing th=
is.
> > - revise xfrm state list to use an rcu list in order to avoid running t=
his
> >   under spinlock.
> >
> > Suggested-by: Paul Wouters <paul.wouters@aiven.io>
> > Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> >
> > ---
> > v4: rebase and explicitly check that keepalive is only configured on
> >     outbound SAs
> > v3: add missing ip6_checksum header
> > v2: change xfrm compat to include the new attribute
> > ---
> >  include/net/ipv6_stubs.h      |   3 +
> >  include/net/netns/xfrm.h      |   1 +
> >  include/net/xfrm.h            |  10 ++
> >  include/uapi/linux/xfrm.h     |   1 +
> >  net/ipv6/af_inet6.c           |   1 +
> >  net/ipv6/xfrm6_policy.c       |   7 +
> >  net/xfrm/Makefile             |   3 +-
> >  net/xfrm/xfrm_compat.c        |   6 +-
> >  net/xfrm/xfrm_nat_keepalive.c | 292 ++++++++++++++++++++++++++++++++++
> >  net/xfrm/xfrm_policy.c        |   8 +
> >  net/xfrm/xfrm_state.c         |  17 ++
> >  net/xfrm/xfrm_user.c          |  15 ++
> >  12 files changed, 361 insertions(+), 3 deletions(-)
> >  create mode 100644 net/xfrm/xfrm_nat_keepalive.c
> >
> > diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
> > index 485c39a89866..11cefd50704d 100644
> > --- a/include/net/ipv6_stubs.h
> > +++ b/include/net/ipv6_stubs.h
> > @@ -9,6 +9,7 @@
> >  #include <net/flow.h>
> >  #include <net/neighbour.h>
> >  #include <net/sock.h>
> > +#include <net/ipv6.h>
> >
> >  /* structs from net/ip6_fib.h */
> >  struct fib6_info;
> > @@ -72,6 +73,8 @@ struct ipv6_stub {
> >                            int (*output)(struct net *, struct sock *, s=
truct sk_buff *));
> >       struct net_device *(*ipv6_dev_find)(struct net *net, const struct=
 in6_addr *addr,
> >                                           struct net_device *dev);
> > +     int (*ip6_xmit)(const struct sock *sk, struct sk_buff *skb, struc=
t flowi6 *fl6,
> > +                     __u32 mark, struct ipv6_txoptions *opt, int tclas=
s, u32 priority);
> >  };
> >  extern const struct ipv6_stub *ipv6_stub __read_mostly;
> >
> > diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
> > index 423b52eca908..d489d9250bff 100644
> > --- a/include/net/netns/xfrm.h
> > +++ b/include/net/netns/xfrm.h
> > @@ -83,6 +83,7 @@ struct netns_xfrm {
> >
> >       spinlock_t xfrm_policy_lock;
> >       struct mutex xfrm_cfg_mutex;
> > +     struct delayed_work     nat_keepalive_work;
> >  };
> >
> >  #endif
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 7c9be06f8302..e208907b1a00 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -229,6 +229,10 @@ struct xfrm_state {
> >       struct xfrm_encap_tmpl  *encap;
> >       struct sock __rcu       *encap_sk;
> >
> > +     /* NAT keepalive */
> > +     u32                     nat_keepalive_interval; /* seconds */
> > +     time64_t                nat_keepalive_expiration;
> > +
> >       /* Data for care-of address */
> >       xfrm_address_t  *coaddr;
> >
> > @@ -2200,4 +2204,10 @@ static inline int register_xfrm_state_bpf(void)
> >  }
> >  #endif
> >
> > +int xfrm_nat_keepalive_init(unsigned short family);
> > +void xfrm_nat_keepalive_fini(unsigned short family);
> > +int xfrm_nat_keepalive_net_init(struct net *net);
> > +int xfrm_nat_keepalive_net_fini(struct net *net);
> > +void xfrm_nat_keepalive_state_updated(struct xfrm_state *x);
> > +
> >  #endif       /* _NET_XFRM_H */
> > diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> > index 18ceaba8486e..7744441c8d5f 100644
> > --- a/include/uapi/linux/xfrm.h
> > +++ b/include/uapi/linux/xfrm.h
> > @@ -321,6 +321,7 @@ enum xfrm_attr_type_t {
> >       XFRMA_IF_ID,            /* __u32 */
> >       XFRMA_MTIMER_THRESH,    /* __u32 in seconds for input SA */
> >       XFRMA_SA_DIR,           /* __u8 */
> > +     XFRMA_NAT_KEEPALIVE_INTERVAL,   /* __u32 in seconds for NAT keepa=
live */
> >       __XFRMA_MAX
> >
> >  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK     /* Compatibility */
> > diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> > index 8041dc181bd4..2b893858b9a9 100644
> > --- a/net/ipv6/af_inet6.c
> > +++ b/net/ipv6/af_inet6.c
> > @@ -1060,6 +1060,7 @@ static const struct ipv6_stub ipv6_stub_impl =3D =
{
> >       .nd_tbl =3D &nd_tbl,
> >       .ipv6_fragment =3D ip6_fragment,
> >       .ipv6_dev_find =3D ipv6_dev_find,
> > +     .ip6_xmit =3D ip6_xmit,
> >  };
> >
> >  static const struct ipv6_bpf_stub ipv6_bpf_stub_impl =3D {
> > diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> > index 42fb6996b077..f03dbc011e65 100644
> > --- a/net/ipv6/xfrm6_policy.c
> > +++ b/net/ipv6/xfrm6_policy.c
> > @@ -285,8 +285,14 @@ int __init xfrm6_init(void)
> >       ret =3D register_pernet_subsys(&xfrm6_net_ops);
> >       if (ret)
> >               goto out_protocol;
> > +
> > +     ret =3D xfrm_nat_keepalive_init(AF_INET6);
> > +     if (ret)
> > +             goto out_nat_keepalive;
> >  out:
> >       return ret;
> > +out_nat_keepalive:
> > +     unregister_pernet_subsys(&xfrm6_net_ops);
> >  out_protocol:
> >       xfrm6_protocol_fini();
> >  out_state:
> > @@ -298,6 +304,7 @@ int __init xfrm6_init(void)
> >
> >  void xfrm6_fini(void)
> >  {
> > +     xfrm_nat_keepalive_fini(AF_INET6);
> >       unregister_pernet_subsys(&xfrm6_net_ops);
> >       xfrm6_protocol_fini();
> >       xfrm6_policy_fini();
> > diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> > index 547cec77ba03..512e0b2f8514 100644
> > --- a/net/xfrm/Makefile
> > +++ b/net/xfrm/Makefile
> > @@ -13,7 +13,8 @@ endif
> >
> >  obj-$(CONFIG_XFRM) :=3D xfrm_policy.o xfrm_state.o xfrm_hash.o \
> >                     xfrm_input.o xfrm_output.o \
> > -                   xfrm_sysctl.o xfrm_replay.o xfrm_device.o
> > +                   xfrm_sysctl.o xfrm_replay.o xfrm_device.o \
> > +                   xfrm_nat_keepalive.o
> >  obj-$(CONFIG_XFRM_STATISTICS) +=3D xfrm_proc.o
> >  obj-$(CONFIG_XFRM_ALGO) +=3D xfrm_algo.o
> >  obj-$(CONFIG_XFRM_USER) +=3D xfrm_user.o
> > diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> > index 703d4172c7d7..91357ccaf4af 100644
> > --- a/net/xfrm/xfrm_compat.c
> > +++ b/net/xfrm/xfrm_compat.c
> > @@ -131,6 +131,7 @@ static const struct nla_policy compat_policy[XFRMA_=
MAX+1] =3D {
> >       [XFRMA_IF_ID]           =3D { .type =3D NLA_U32 },
> >       [XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> >       [XFRMA_SA_DIR]          =3D NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_=
IN, XFRM_SA_DIR_OUT),
> > +     [XFRMA_NAT_KEEPALIVE_INTERVAL]  =3D { .type =3D NLA_U32 },
> >  };
> >
> >  static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
> > @@ -280,9 +281,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, =
const struct nlattr *src)
> >       case XFRMA_IF_ID:
> >       case XFRMA_MTIMER_THRESH:
> >       case XFRMA_SA_DIR:
> > +     case XFRMA_NAT_KEEPALIVE_INTERVAL:
> >               return xfrm_nla_cpy(dst, src, nla_len(src));
> >       default:
> > -             BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_SA_DIR);
> > +             BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_NAT_KEEPALIVE_INTERVAL)=
;
> >               pr_warn_once("unsupported nla_type %d\n", src->nla_type);
> >               return -EOPNOTSUPP;
> >       }
> > @@ -437,7 +439,7 @@ static int xfrm_xlate32_attr(void *dst, const struc=
t nlattr *nla,
> >       int err;
> >
> >       if (type > XFRMA_MAX) {
> > -             BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_SA_DIR);
> > +             BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_NAT_KEEPALIVE_INTERVAL)=
;
> >               NL_SET_ERR_MSG(extack, "Bad attribute");
> >               return -EOPNOTSUPP;
> >       }
> > diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepaliv=
e.c
> > new file mode 100644
> > index 000000000000..82f0a301683f
> > --- /dev/null
> > +++ b/net/xfrm/xfrm_nat_keepalive.c
> > @@ -0,0 +1,292 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * xfrm_nat_keepalive.c
> > + *
> > + * (c) 2024 Eyal Birger <eyal.birger@gmail.com>
> > + */
> > +
> > +#include <net/inet_common.h>
> > +#include <net/ip6_checksum.h>
> > +#include <net/xfrm.h>
> > +
> > +static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv4);
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv6);
> > +#endif
> > +
> > +struct nat_keepalive {
> > +     struct net *net;
> > +     u16 family;
> > +     xfrm_address_t saddr;
> > +     xfrm_address_t daddr;
> > +     __be16 encap_sport;
> > +     __be16 encap_dport;
> > +     __u32 smark;
> > +};
> > +
> > +static void nat_keepalive_init(struct nat_keepalive *ka, struct xfrm_s=
tate *x)
> > +{
> > +     ka->net =3D xs_net(x);
> > +     ka->family =3D x->props.family;
> > +     ka->saddr =3D x->props.saddr;
> > +     ka->daddr =3D x->id.daddr;
> > +     ka->encap_sport =3D x->encap->encap_sport;
> > +     ka->encap_dport =3D x->encap->encap_dport;
> > +     ka->smark =3D xfrm_smark_get(0, x);
> > +}
> > +
> > +static int nat_keepalive_send_ipv4(struct sk_buff *skb,
> > +                                struct nat_keepalive *ka)
> > +{
> > +     struct net *net =3D ka->net;
> > +     struct flowi4 fl4;
> > +     struct rtable *rt;
> > +     struct sock *sk;
> > +     __u8 tos =3D 0;
> > +     int err;
> > +
> > +     flowi4_init_output(&fl4, 0 /* oif */, skb->mark, tos,
> > +                        RT_SCOPE_UNIVERSE, IPPROTO_UDP, 0,
> > +                        ka->daddr.a4, ka->saddr.a4, ka->encap_dport,
> > +                        ka->encap_sport, sock_net_uid(net, NULL));
> > +
> > +     rt =3D ip_route_output_key(net, &fl4);
> > +     if (IS_ERR(rt))
> > +             return PTR_ERR(rt);
> > +
> > +     skb_dst_set(skb, &rt->dst);
> > +
> > +     sk =3D *this_cpu_ptr(&nat_keepalive_sk_ipv4);
> > +     sock_net_set(sk, net);
> > +     err =3D ip_build_and_send_pkt(skb, sk, fl4.saddr, fl4.daddr, NULL=
, tos);
> > +     sock_net_set(sk, &init_net);
> > +     return err;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +static int nat_keepalive_send_ipv6(struct sk_buff *skb,
> > +                                struct nat_keepalive *ka,
> > +                                struct udphdr *uh)
> > +{
> > +     struct net *net =3D ka->net;
> > +     struct dst_entry *dst;
> > +     struct flowi6 fl6;
> > +     struct sock *sk;
> > +     __wsum csum;
> > +     int err;
> > +
> > +     csum =3D skb_checksum(skb, 0, skb->len, 0);
> > +     uh->check =3D csum_ipv6_magic(&ka->saddr.in6, &ka->daddr.in6,
> > +                                 skb->len, IPPROTO_UDP, csum);
> > +     if (uh->check =3D=3D 0)
> > +             uh->check =3D CSUM_MANGLED_0;
> > +
> > +     memset(&fl6, 0, sizeof(fl6));
> > +     fl6.flowi6_mark =3D skb->mark;
> > +     fl6.saddr =3D ka->saddr.in6;
> > +     fl6.daddr =3D ka->daddr.in6;
> > +     fl6.flowi6_proto =3D IPPROTO_UDP;
> > +     fl6.fl6_sport =3D ka->encap_sport;
> > +     fl6.fl6_dport =3D ka->encap_dport;
> > +
> > +     sk =3D *this_cpu_ptr(&nat_keepalive_sk_ipv6);
> > +     sock_net_set(sk, net);
> > +     dst =3D ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
> > +     if (IS_ERR(dst))
> > +             return PTR_ERR(dst);
> > +
> > +     skb_dst_set(skb, dst);
> > +     err =3D ipv6_stub->ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0)=
;
> > +     sock_net_set(sk, &init_net);
> > +     return err;
> > +}
> > +#endif
> > +
> > +static void nat_keepalive_send(struct nat_keepalive *ka)
> > +{
> > +     const int nat_ka_hdrs_len =3D max(sizeof(struct iphdr),
> > +                                     sizeof(struct ipv6hdr)) +
> > +                                 sizeof(struct udphdr);
> > +     const u8 nat_ka_payload =3D 0xFF;
> > +     int err =3D -EAFNOSUPPORT;
> > +     struct sk_buff *skb;
> > +     struct udphdr *uh;
> > +
> > +     skb =3D alloc_skb(nat_ka_hdrs_len + sizeof(nat_ka_payload), GFP_A=
TOMIC);
> > +     if (unlikely(!skb))
> > +             return;
> > +
> > +     skb_reserve(skb, nat_ka_hdrs_len);
> > +
> > +     skb_put_u8(skb, nat_ka_payload);
> > +
> > +     uh =3D skb_push(skb, sizeof(*uh));
> > +     uh->source =3D ka->encap_sport;
> > +     uh->dest =3D ka->encap_dport;
> > +     uh->len =3D htons(skb->len);
> > +     uh->check =3D 0;
> > +
> > +     skb->mark =3D ka->smark;
> > +
> > +     switch (ka->family) {
> > +     case AF_INET:
> > +             err =3D nat_keepalive_send_ipv4(skb, ka);
> > +             break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     case AF_INET6:
> > +             err =3D nat_keepalive_send_ipv6(skb, ka, uh);
> > +             break;
> > +#endif
> > +     }
> > +     if (err)
> > +             kfree_skb(skb);
> > +}
> > +
> > +struct nat_keepalive_work_ctx {
> > +     time64_t next_run;
> > +     time64_t now;
> > +};
> > +
> > +static int nat_keepalive_work_single(struct xfrm_state *x, int count, =
void *ptr)
> > +{
> > +     struct nat_keepalive_work_ctx *ctx =3D ptr;
> > +     bool send_keepalive =3D false;
> > +     struct nat_keepalive ka;
> > +     time64_t next_run;
> > +     u32 interval;
> > +     int delta;
> > +
> > +     interval =3D x->nat_keepalive_interval;
> > +     if (!interval)
> > +             return 0;
> > +
> > +     spin_lock(&x->lock);
> > +
> > +     delta =3D (int)(ctx->now - x->lastused);
> > +     if (delta < interval) {
> > +             x->nat_keepalive_expiration =3D ctx->now + interval - del=
ta;
> > +             next_run =3D x->nat_keepalive_expiration;
> > +     } else if (x->nat_keepalive_expiration > ctx->now) {
> > +             next_run =3D x->nat_keepalive_expiration;
> > +     } else {
> > +             next_run =3D ctx->now + interval;
> > +             nat_keepalive_init(&ka, x);
> > +             send_keepalive =3D true;
> > +     }
> > +
> > +     spin_unlock(&x->lock);
> > +
> > +     if (send_keepalive)
> > +             nat_keepalive_send(&ka);
> > +
> > +     if (!ctx->next_run || next_run < ctx->next_run)
> > +             ctx->next_run =3D next_run;
> > +     return 0;
> > +}
> > +
> > +static void nat_keepalive_work(struct work_struct *work)
> > +{
> > +     struct nat_keepalive_work_ctx ctx;
> > +     struct xfrm_state_walk walk;
> > +     struct net *net;
> > +
> > +     ctx.next_run =3D 0;
> > +     ctx.now =3D ktime_get_real_seconds();
> > +
> > +     net =3D container_of(work, struct net, xfrm.nat_keepalive_work.wo=
rk);
> > +     xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
> > +     xfrm_state_walk(net, &walk, nat_keepalive_work_single, &ctx);
> > +     xfrm_state_walk_done(&walk, net);
> > +     if (ctx.next_run)
> > +             schedule_delayed_work(&net->xfrm.nat_keepalive_work,
> > +                                   (ctx.next_run - ctx.now) * HZ);
> > +}
> > +
> > +static int nat_keepalive_sk_init(struct sock * __percpu *socks,
> > +                              unsigned short family)
> > +{
> > +     struct sock *sk;
> > +     int err, i;
> > +
> > +     for_each_possible_cpu(i) {
> > +             err =3D inet_ctl_sock_create(&sk, family, SOCK_RAW, IPPRO=
TO_UDP,
> > +                                        &init_net);
> > +             if (err < 0)
> > +                     goto err;
> > +
> > +             *per_cpu_ptr(socks, i) =3D sk;
> > +     }
> > +
> > +     return 0;
> > +err:
> > +     for_each_possible_cpu(i)
> > +             inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
> > +     return err;
> > +}
> > +
> > +static void nat_keepalive_sk_fini(struct sock * __percpu *socks)
> > +{
> > +     int i;
> > +
> > +     for_each_possible_cpu(i)
> > +             inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
> > +}
> > +
> > +void xfrm_nat_keepalive_state_updated(struct xfrm_state *x)
> > +{
> > +     struct net *net;
> > +
> > +     if (!x->nat_keepalive_interval)
> > +             return;
> > +
> > +     net =3D xs_net(x);
> > +     schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
> > +}
> > +
> > +int __net_init xfrm_nat_keepalive_net_init(struct net *net)
> > +{
> > +     INIT_DELAYED_WORK(&net->xfrm.nat_keepalive_work, nat_keepalive_wo=
rk);
> > +     return 0;
> > +}
> > +
> > +int xfrm_nat_keepalive_net_fini(struct net *net)
> > +{
> > +     cancel_delayed_work_sync(&net->xfrm.nat_keepalive_work);
> > +     return 0;
> > +}
> > +
> > +int xfrm_nat_keepalive_init(unsigned short family)
> > +{
> > +     int err =3D -EAFNOSUPPORT;
> > +
> > +     switch (family) {
> > +     case AF_INET:
> > +             err =3D nat_keepalive_sk_init(&nat_keepalive_sk_ipv4, PF_=
INET);
> > +             break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     case AF_INET6:
> > +             err =3D nat_keepalive_sk_init(&nat_keepalive_sk_ipv6, PF_=
INET6);
> > +             break;
> > +#endif
> > +     }
> > +
> > +     if (err)
> > +             pr_err("xfrm nat keepalive init: failed to init err:%d\n"=
, err);
> > +     return err;
> > +}
> > +EXPORT_SYMBOL_GPL(xfrm_nat_keepalive_init);
> > +
> > +void xfrm_nat_keepalive_fini(unsigned short family)
> > +{
> > +     switch (family) {
> > +     case AF_INET:
> > +             nat_keepalive_sk_fini(&nat_keepalive_sk_ipv4);
> > +             break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     case AF_INET6:
> > +             nat_keepalive_sk_fini(&nat_keepalive_sk_ipv6);
> > +             break;
> > +#endif
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(xfrm_nat_keepalive_fini);
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index 298b3a9eb48d..580c27ac7778 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -4288,8 +4288,14 @@ static int __net_init xfrm_net_init(struct net *=
net)
> >       if (rv < 0)
> >               goto out_sysctl;
> >
> > +     rv =3D xfrm_nat_keepalive_net_init(net);
> > +     if (rv < 0)
> > +             goto out_nat_keepalive;
> > +
> >       return 0;
> >
> > +out_nat_keepalive:
> > +     xfrm_sysctl_fini(net);
> >  out_sysctl:
> >       xfrm_policy_fini(net);
> >  out_policy:
> > @@ -4302,6 +4308,7 @@ static int __net_init xfrm_net_init(struct net *n=
et)
> >
> >  static void __net_exit xfrm_net_exit(struct net *net)
> >  {
> > +     xfrm_nat_keepalive_net_fini(net);
> >       xfrm_sysctl_fini(net);
> >       xfrm_policy_fini(net);
> >       xfrm_state_fini(net);
> > @@ -4363,6 +4370,7 @@ void __init xfrm_init(void)
> >  #endif
> >
> >       register_xfrm_state_bpf();
> > +     xfrm_nat_keepalive_init(AF_INET);
> >  }
> >
> >  #ifdef CONFIG_AUDITSYSCALL
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 649bb739df0d..abadc857cd45 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -715,6 +715,7 @@ int __xfrm_state_delete(struct xfrm_state *x)
> >               if (x->id.spi)
> >                       hlist_del_rcu(&x->byspi);
> >               net->xfrm.state_num--;
> > +             xfrm_nat_keepalive_state_updated(x);
> >               spin_unlock(&net->xfrm.xfrm_state_lock);
> >
> >               if (x->encap_sk)
> > @@ -1453,6 +1454,7 @@ static void __xfrm_state_insert(struct xfrm_state=
 *x)
> >       net->xfrm.state_num++;
> >
> >       xfrm_hash_grow_check(net, x->bydst.next !=3D NULL);
> > +     xfrm_nat_keepalive_state_updated(x);
> >  }
> >
> >  /* net->xfrm.xfrm_state_lock is held */
> > @@ -2871,6 +2873,21 @@ int __xfrm_init_state(struct xfrm_state *x, bool=
 init_replay, bool offload,
> >                       goto error;
> >       }
> >
> > +     if (x->nat_keepalive_interval) {
> > +             if (x->dir !=3D XFRM_SA_DIR_OUT) {
> > +                     NL_SET_ERR_MSG(extack, "NAT keepalive is only sup=
ported for outbound SAs");
> > +                     err =3D -EINVAL;
> > +                     goto error;
> > +             }
> > +
> > +             if (!x->encap || x->encap->encap_type !=3D UDP_ENCAP_ESPI=
NUDP) {
> > +                     NL_SET_ERR_MSG(extack,
> > +                                    "NAT keepalive is only supported f=
or UDP encapsulation");
> > +                     err =3D -EINVAL;
> > +                     goto error;
> > +             }
> > +     }
> > +
> >  error:
> >       return err;
> >  }
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index e83c687bd64e..a552cfa623ea 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -833,6 +833,10 @@ static struct xfrm_state *xfrm_state_construct(str=
uct net *net,
> >       if (attrs[XFRMA_SA_DIR])
> >               x->dir =3D nla_get_u8(attrs[XFRMA_SA_DIR]);
> >
> > +     if (attrs[XFRMA_NAT_KEEPALIVE_INTERVAL])
> > +             x->nat_keepalive_interval =3D
> > +                     nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]);
> > +
> >       err =3D __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], ext=
ack);
> >       if (err)
> >               goto error;
> > @@ -1288,6 +1292,13 @@ static int copy_to_user_state_extra(struct xfrm_=
state *x,
> >       }
> >       if (x->dir)
> >               ret =3D nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> > +
> > +     if (x->nat_keepalive_interval) {
> > +             ret =3D nla_put_u32(skb, XFRMA_NAT_KEEPALIVE_INTERVAL,
> > +                               x->nat_keepalive_interval);
> > +             if (ret)
> > +                     goto out;
> > +     }
> >  out:
> >       return ret;
> >  }
> > @@ -3165,6 +3176,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1]=
 =3D {
> >       [XFRMA_IF_ID]           =3D { .type =3D NLA_U32 },
> >       [XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> >       [XFRMA_SA_DIR]          =3D NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_=
IN, XFRM_SA_DIR_OUT),
> > +     [XFRMA_NAT_KEEPALIVE_INTERVAL] =3D { .type =3D NLA_U32 },
>
> What would happen if the value is set to 0? Should it be allowed? I don't
> see any use for it. If not, should we make the range from 1 to UINT32_MAX=
?
> This way, we can avoid any potential issues with the value 0, ensuring
> proper functionality.

The xfrm_state only has x->nat_keepalive_interval so if you set the value t=
o
'0' it would be the same as not setting it.

>
> I also wonder about limiting the maxium value to x->lft.hard_add_expires_=
seconds.
> Adding XFRMA_NAT_KEEPALIVE_INTERVAL > x->lft.hard_add_expires_seconds doe=
s
> not make sesne to me. Just another sanity check.

I don't understand the relation between the NAT-T keepalive and
"hard_add_expires_seconds". That number seems to be derived from the acquir=
e
expiration sysctl whereas NAT-T is related to the network between hosts and
firewall timeouts there. As such, i'm not sure what the appropriate upper b=
ound
for this configuration would be or whether it's needed.

>
> >  };
> >  EXPORT_SYMBOL_GPL(xfrma_policy);
> >
> > @@ -3474,6 +3486,9 @@ static inline unsigned int xfrm_sa_len(struct xfr=
m_state *x)
> >       if (x->dir)
> >               l +=3D nla_total_size(sizeof(x->dir));
> >
> > +     if (x->nat_keepalive_interval)
> > +             l +=3D nla_total_size(sizeof(x->nat_keepalive_interval));
> > +
> >       return l;
> >  }
> >
> > --
> > 2.34.1
>
> One curious question: What happens if the NAT gateway in between returns =
an
> ICMP unreachable error as a response? If the IKE daemon was sending it,
> IKEd would notice the ICMP errors and possibly take action. This is
> something to consider. For example, this might be important to handle whe=
n
> offloading on an Android phone use case. Somehow, the IKE daemon should b=
e
> woken up to handle these errors; otherwise, you risk unnecessary battery
> drain. Or if you are server, flodding lot of nat-keep-alive.
>
> 07:33:30.839377 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto UD=
P (17), length 29)
>     192.1.3.33.4500 > 192.1.2.23.4500: [no cksum] isakmp-nat-keep-alive
> 07:33:30.840014 IP (tos 0xc0, ttl 63, id 17350, offset 0, flags [none], p=
roto ICMP (1), length 57)
>     192.1.2.23 > 192.1.3.33: ICMP 192.1.2.23 udp port 4500 unreachable, l=
ength 37
>         IP (tos 0x0, ttl 63, id 0, offset 0, flags [DF], proto UDP (17), =
length 29)
>     192.1.3.33.4500 > 192.1.2.23.4500: [no cksum] isakmp-nat-keep-alive

That's an interesting observation. Do IKE daemons currently handle this
situation?
If the route between hosts isn't available, any traffic related to the xfrm
state would fail in a similar way, which the IKE daemon could observe as we=
ll.
Is there such handling done today?

>
> I ran a few quick tests and the patch works well.

Thanks!
Eyal.

