Return-Path: <netdev+bounces-76928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACA86F76A
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 23:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AA1C20B11
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53D1E4B2;
	Sun,  3 Mar 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7xiO5jk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CE1E484
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505061; cv=none; b=lOBg+T263XIQIfwV6m/PnRK+Mbmmdqqmwx07p81c29wV7JZL5B9QVTY8hm/1m5Y10/QSaamYwob9ISxJ2F35ASJUcIU4kQLslnmU59f2YapeyKDEGMRuBE740F4uSOYI/xEgniNJp3RQTUkCxVio/7w0fnHcOeohtYnpCHv7+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505061; c=relaxed/simple;
	bh=Zld+uT67DrWsN8T3pKtxlhStY+kqBB+W5TTPk1yGGVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpYg/bXJIus+GYGvI/SP/iViXt93fDzTXClyHP8S3Q3TXw5SWjwGwqDRagB6oOvJaLXm2hkOLlY4o42+QmrAkzH5ncXXJwHnNbmA1sSGPpiRDC9+mY5y0y0RaQWLGV2gwQeNTuYcj1OUyml9k+/qqJJSxpUJReQA7XEz2t0VblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7xiO5jk; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7da763255b7so1313142241.2
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709505058; x=1710109858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVL9HCAIPjY77ss6GEyMAA2w2wK0Qdn62uFxR9vuci8=;
        b=S7xiO5jkDOffmoqYfLO7zAkgcBRs/8Z5Q7xJR1sOuK5/HbtD3bwQ19+0zNztBfSdRH
         fyZgDdnD6e2hJxWzSoIrINl7+MOFA8sozKw8xmtIXx8U738GZsoIOlmVWrRziMtFe/D+
         2g5TrqjhjwRdu4TKlpbnMFvsY+JlVOalATUCS9BD/3TgVlpxm82xLnJQbFL1rBMmNEtB
         kmhAswwd1BwJhjbeRlqVBNSCXBJDMcXzfLMM4+XnLdfZ7PBGNYZZNK7XgAsFSrcYk+Pk
         f3JctVGRhFfLBam7mLOiOOuYj8x73KJToIEd0BVe56moIHbS7Lg3lGFXuMDv5wxtNdc2
         M5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709505058; x=1710109858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVL9HCAIPjY77ss6GEyMAA2w2wK0Qdn62uFxR9vuci8=;
        b=TfVDPR9IV6/e27yulyCM0Me7YZ+4X+CKJQsB4U1FIzo2WqJjcl1jFOLW2J6DYAAY9P
         cyj6zkQQ4hZ2sFO2aW3Apf93pzjuqNASQBri1tqJ+Nbb5P3Kl6l3szpqW2MtjguMjqsX
         Oa/jkOGc1xvASHiYqSA8dkdoNVvzwclRsZDrv2DyEMBmC0lSjBw1iHfiIrzD843Yeq4u
         xxUz+GeNQDUBAy2Hmxjtn1CFQDFzGpb/YLqE7/phoq021MnvieFaupSmuZDaau9L2ASC
         A0eVdso7DLC11cZyTJTuHhiZY3wztLM4iDye6T0R6Ngyy3TxvU9Y6BwZlefUZGYTxU2W
         aG/w==
X-Forwarded-Encrypted: i=1; AJvYcCVuaz9MdTN9KFM9VObqgLVT2WV1MtLkDeXM8/VGW9CxJX6wUcTpRSA11rSH+x2qNKe85qYEQAEExlJnlpofy/Qb/8VhY1Eh
X-Gm-Message-State: AOJu0Ywf2FQOcEUJDM8r2bXJx/GVBv1bON0vYw8QQEtFHJR1mjXX0cSE
	WMWS0DlJlR5o/vzoX0MUdK2fjPzeUjJwGIJvuI9zTL8UZ4tWQ9dUSrfvg/JYEFI1E9r1RxqENqm
	x/E8KiJXuNFauYoVSm1nPYe9V7eH1lfQbzh8=
X-Google-Smtp-Source: AGHT+IFEL3Xk5n+Qho2Hn+fMEhJU66AnfujWSYXL6KWCPPHAnWu9Py/AcjCY05anJHMBpVNOHP/afBMW5TI4M59AVDg=
X-Received: by 2002:a67:fdd3:0:b0:472:771e:79bd with SMTP id
 l19-20020a67fdd3000000b00472771e79bdmr3469582vsq.28.1709505058142; Sun, 03
 Mar 2024 14:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
In-Reply-To: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 3 Mar 2024 14:30:46 -0800
Message-ID: <CAHsH6Gtx6Jrs5TWWraDqSzfAuEth=13fvC73+afXCmYJBvbm3w@mail.gmail.com>
Subject: Re: [PATCH ipsec-next] xfrm: Add Direction to the SA in or out
To: antony.antony@secunet.com
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antony,

On Sun, Mar 3, 2024 at 1:09=E2=80=AFPM Antony Antony <antony.antony@secunet=
.com> wrote:
>
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.

Nice! Minor comments below.

>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
>  include/net/xfrm.h        |  1 +
>  include/uapi/linux/xfrm.h |  8 ++++++++
>  net/xfrm/xfrm_compat.c    |  6 ++++--
>  net/xfrm/xfrm_device.c    |  5 +++++
>  net/xfrm/xfrm_state.c     |  1 +
>  net/xfrm/xfrm_user.c      | 43 +++++++++++++++++++++++++++++++++++----
>  6 files changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 1d107241b901..91348a03469c 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -289,6 +289,7 @@ struct xfrm_state {
>         /* Private data of this transformer, format is opaque,
>          * interpreted by xfrm_type methods. */
>         void                    *data;
> +       enum xfrm_sa_dir        dir;
>  };
>
>  static inline struct net *xs_net(struct xfrm_state *x)
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 6a77328be114..2f1d67239301 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -141,6 +141,13 @@ enum {
>         XFRM_POLICY_MAX =3D 3
>  };
>
> +enum xfrm_sa_dir {
> +       XFRM_SA_DIR_UNSET =3D 0,
> +       XFRM_SA_DIR_IN  =3D 1,
> +       XFRM_SA_DIR_OUT =3D 2,
> +       XFRM_SA_DIR_MAX =3D 3,

nit: comma is redundant after a "MAX" no?

> +};
> +
>  enum {
>         XFRM_SHARE_ANY,         /* No limitations */
>         XFRM_SHARE_SESSION,     /* For this session only */
> @@ -315,6 +322,7 @@ enum xfrm_attr_type_t {
>         XFRMA_SET_MARK_MASK,    /* __u32 */
>         XFRMA_IF_ID,            /* __u32 */
>         XFRMA_MTIMER_THRESH,    /* __u32 in seconds for input SA */
> +       XFRMA_SA_DIR,           /* __u8 */
>         __XFRMA_MAX
>
>  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK       /* Compatibility */
> diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> index 655fe4ff8621..de0e1508f870 100644
> --- a/net/xfrm/xfrm_compat.c
> +++ b/net/xfrm/xfrm_compat.c
> @@ -129,6 +129,7 @@ static const struct nla_policy compat_policy[XFRMA_MA=
X+1] =3D {
>         [XFRMA_SET_MARK_MASK]   =3D { .type =3D NLA_U32 },
>         [XFRMA_IF_ID]           =3D { .type =3D NLA_U32 },
>         [XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> +       [XFRMA_SA_DIR]          =3D { .type =3D NLA_U8 },
>  };
>
>  static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
> @@ -277,9 +278,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, co=
nst struct nlattr *src)
>         case XFRMA_SET_MARK_MASK:
>         case XFRMA_IF_ID:
>         case XFRMA_MTIMER_THRESH:
> +       case XFRMA_SA_DIR:
>                 return xfrm_nla_cpy(dst, src, nla_len(src));
>         default:
> -               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_MTIMER_THRESH);
> +               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_SA_DIR);
>                 pr_warn_once("unsupported nla_type %d\n", src->nla_type);
>                 return -EOPNOTSUPP;
>         }
> @@ -434,7 +436,7 @@ static int xfrm_xlate32_attr(void *dst, const struct =
nlattr *nla,
>         int err;
>
>         if (type > XFRMA_MAX) {
> -               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_MTIMER_THRESH);
> +               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_SA_DIR);
>                 NL_SET_ERR_MSG(extack, "Bad attribute");
>                 return -EOPNOTSUPP;
>         }
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 3784534c9185..11339d7d7140 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -253,6 +253,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_=
state *x,
>                 return -EINVAL;
>         }
>
> +       if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir !=3D XFRM_SA_DIR_=
IN) {
> +               NL_SET_ERR_MSG(extack, "Mismatch in SA and offload direct=
ion");
> +               return -EINVAL;
> +       }
> +
>         is_packet_offload =3D xuo->flags & XFRM_OFFLOAD_PACKET;
>
>         /* We don't yet support UDP encapsulation and TFC padding. */
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index bda5327bf34d..0d6f5a49002f 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1744,6 +1744,7 @@ static struct xfrm_state *xfrm_state_clone(struct x=
frm_state *orig,
>         x->lastused =3D orig->lastused;
>         x->new_mapping =3D 0;
>         x->new_mapping_sport =3D 0;
> +       x->dir =3D orig->dir;
>
>         return x;
>
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index ad01997c3aa9..fe4576e96dd4 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -360,6 +360,16 @@ static int verify_newsa_info(struct xfrm_usersa_info=
 *p,
>                 }
>         }
>
> +       if (attrs[XFRMA_SA_DIR]) {
> +               u8 sa_dir =3D nla_get_u8(attrs[XFRMA_SA_DIR]);
> +
> +               if (!sa_dir || sa_dir >=3D XFRM_SA_DIR_MAX)  {
> +                       NL_SET_ERR_MSG(extack, "XFRMA_SA_DIR attribute is=
 out of range");
> +                       err =3D -EINVAL;
> +                       goto out;
> +               }
> +       }
> +
>  out:
>         return err;
>  }
> @@ -627,6 +637,7 @@ static void xfrm_update_ae_params(struct xfrm_state *=
x, struct nlattr **attrs,
>         struct nlattr *et =3D attrs[XFRMA_ETIMER_THRESH];
>         struct nlattr *rt =3D attrs[XFRMA_REPLAY_THRESH];
>         struct nlattr *mt =3D attrs[XFRMA_MTIMER_THRESH];
> +       struct nlattr *dir =3D attrs[XFRMA_SA_DIR];
>
>         if (re && x->replay_esn && x->preplay_esn) {
>                 struct xfrm_replay_state_esn *replay_esn;
> @@ -661,6 +672,9 @@ static void xfrm_update_ae_params(struct xfrm_state *=
x, struct nlattr **attrs,
>
>         if (mt)
>                 x->mapping_maxage =3D nla_get_u32(mt);
> +
> +       if (dir)
> +               x->dir =3D nla_get_u8(dir);

It's not clear to me why this belongs in xfrm_update_ae_params().
IOW, why isn't this done in xfrm_state_construct(), like if_id?

>  }
>
>  static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
> @@ -1182,8 +1196,13 @@ static int copy_to_user_state_extra(struct xfrm_st=
ate *x,
>                 if (ret)
>                         goto out;
>         }
> -       if (x->mapping_maxage)
> +       if (x->mapping_maxage) {
>                 ret =3D nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_=
maxage);
> +               if (ret)
> +                       goto out;
> +       }
> +       if (x->dir)
> +               ret =3D nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
>  out:
>         return ret;
>  }
> @@ -2399,7 +2418,8 @@ static inline unsigned int xfrm_aevent_msgsize(stru=
ct xfrm_state *x)
>                + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
>                + nla_total_size(sizeof(struct xfrm_mark))
>                + nla_total_size(4) /* XFRM_AE_RTHR */
> -              + nla_total_size(4); /* XFRM_AE_ETHR */
> +              + nla_total_size(4) /* XFRM_AE_ETHR */
> +              + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
>  }
>
>  static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const=
 struct km_event *c)
> @@ -2453,6 +2473,11 @@ static int build_aevent(struct sk_buff *skb, struc=
t xfrm_state *x, const struct
>                 goto out_cancel;
>
>         err =3D xfrm_if_id_put(skb, x->if_id);
> +       if (err)
> +               goto out_cancel;
> +       if (x->dir)
> +               err =3D nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> +
>         if (err)
>                 goto out_cancel;
>
> @@ -3046,6 +3071,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] =
=3D {
>         [XFRMA_SET_MARK_MASK]   =3D { .type =3D NLA_U32 },
>         [XFRMA_IF_ID]           =3D { .type =3D NLA_U32 },
>         [XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> +       [XFRMA_SA_DIR]          =3D { .type =3D NLA_U8 },

Maybe add a ".strict_start_type"?

>
>  };
>  EXPORT_SYMBOL_GPL(xfrma_policy);
>
> @@ -3186,8 +3212,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)
>
>  static inline unsigned int xfrm_expire_msgsize(void)
>  {
> -       return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
> -              + nla_total_size(sizeof(struct xfrm_mark));
> +       return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
> +              nla_total_size(sizeof(struct xfrm_mark)) +
> +              nla_total_size(sizeof_field(struct xfrm_state, dir));
>  }
>
>  static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const=
 struct km_event *c)
> @@ -3214,6 +3241,11 @@ static int build_expire(struct sk_buff *skb, struc=
t xfrm_state *x, const struct
>         if (err)
>                 return err;
>
> +       if (x->dir)
> +               err =3D nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> +       if (err)
> +               return err;
> +
>         nlmsg_end(skb, nlh);
>         return 0;
>  }
> @@ -3321,6 +3353,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_=
state *x)
>         if (x->mapping_maxage)
>                 l +=3D nla_total_size(sizeof(x->mapping_maxage));
>
> +       if (x->dir)
> +               l +=3D nla_total_size(sizeof(x->dir));
> +
>         return l;
>  }
>
> --
> 2.30.2
>
>

