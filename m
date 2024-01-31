Return-Path: <netdev+bounces-67690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3FE844988
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53914285CCE
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8638FB5;
	Wed, 31 Jan 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="af9ysE3P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742538FB9
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735620; cv=none; b=QgKz0MCydvWxAv1OsEKzxmHuCEU8Voq4BXwFDtV0y/y+VOh6Qj2RmZF/ndehnkr56khsIM84drJwzetIGgNJZoNXRYSyKBFe2GIpD0lvBTpYeVbNPQel1ps6kHFmEUZmN8Nh8MH6SkMvBaxf5uSgB5urtKVIJ9SIa3rcBO4Zd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735620; c=relaxed/simple;
	bh=5RtUtA6iC7L+SsF5+uVtaofowEY66SQbGNXwHaBBAdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkvlWeH/blgtJdfbZg+bXBUoEB36hYQ02Kc1ZHL/GkZekgamIXRntXol8UKrImqdIl1ohiSc4PrEUi0DUsg4yVJliTj7TthmkeUgIivdi1jI4R7dS6NqxnDtT+VKG95NhavhB2rgF+mu/ow5eCbYlDxzVuLSxNUkcBqtZGNbvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=af9ysE3P; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d54def6fso114955276.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706735617; x=1707340417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB7RuzqvkNk+xgcEIYwgMzKi4EvlmFvGjeJXIKiMWDk=;
        b=af9ysE3P05NP2GmVLAPqYelGBE7MqBHUU25Bk+HTsZR+7wlht/KjPjkCYucVoCAMpf
         MMqbnXfkaNN73uhHRK79K6Lfn8VElc+SdXPe+xeknigHsKI5lJamt3dO7021wTyjVUKx
         zQ5FwmrFOrKRxYoASPoUjjiY+gXj9up8kv4JgswZkB0Cwtv5eFsuK7243ZcxhwWohU3r
         NmqcHVaZvYw0hNSfeJXtZtXs4Ybw8cXDpaXGzA8mItc+WTkiRSKE5Po4xNMuPP2MlY6S
         f4u9Cde/tpfIm9Rv4UY7GbECs6xG/WNLMYMrvnvyleXEcuyac1Q8hAMrpVf/RzZpArBF
         kpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735617; x=1707340417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UB7RuzqvkNk+xgcEIYwgMzKi4EvlmFvGjeJXIKiMWDk=;
        b=blmnbUYusRkpEoyznEem++4dJHLYWkNqSuzYFbWFT+fnU9voq3NVEb6fI6HUwvhitD
         zgKbL3+74cJYBSglOHjrtPGTxYNtjbyX185uThyXgV7+Sx+7sLmhTBV7QUht2TcqC78S
         C+romb08sdIdSOYMR5PRm+MvkcMQSFzw0Qf4RW3LnIjKE+Vi2mmqKpFFFg0bGo4KZrn3
         qsQDBTlyTENG1PVod/uYIpK6BanWE3NOzUy4/zpvjzzOc0O6QLSLUtVRC3TVEmnzKZnc
         RJce1MQowY40Xn1m2QZXPKBUrY1nXMkRevNhMBBU3ScRxgHUGo/6KqLdBZQ2VN87JbzE
         k6FA==
X-Gm-Message-State: AOJu0YzWxYh3b1A9dKMjyPkXS0iYZxNiIZXvkAwDixhZlaXof1LeMMRq
	ztBEeYcjZRzepiLmC1CRBogLlz2XxofsAOGApo0QoLrY5juX9p93bjDhF4ECDxiR+lDew2vdhYg
	cXy9H33wesx284SC0JnPkDtVPXWsC8gX3bIWSgc1N0ziNjNjpjA==
X-Google-Smtp-Source: AGHT+IHTcxPgOS1kWjGfMODm3ZE2ppWGTS+5dK+ue7Bk5nNR+FqTWOHUR7oyrWK5Fz/J88Jw6o7kkaMjiXO85aepStY=
X-Received: by 2002:a25:9384:0:b0:dbd:c442:9e60 with SMTP id
 a4-20020a259384000000b00dbdc4429e60mr355024ybm.36.1706735617018; Wed, 31 Jan
 2024 13:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706714667.git.dcaratti@redhat.com> <91b858e0551f900a415b2d6ed80a54d7f5ef3c33.1706714667.git.dcaratti@redhat.com>
In-Reply-To: <91b858e0551f900a415b2d6ed80a54d7f5ef3c33.1706714667.git.dcaratti@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 31 Jan 2024 16:13:25 -0500
Message-ID: <CAM0EoMkE3kzL28jg-nZiwQ0HnrFtm9HNBJwU1SJk7Z++yHzrMw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: cls_flower: add support for
 matching tunnel control flags
To: Davide Caratti <dcaratti@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Ilya Maximets <i.maximets@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:16=E2=80=AFAM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> extend cls_flower to match flags belonging to 'TUNNEL_FLAGS_PRESENT' mask
> inside skb tunnel metadata.
>
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  include/uapi/linux/pkt_cls.h |  3 +++
>  net/sched/cls_flower.c       | 45 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index ea277039f89d..e3394f9d06b7 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -554,6 +554,9 @@ enum {
>         TCA_FLOWER_KEY_SPI,             /* be32 */
>         TCA_FLOWER_KEY_SPI_MASK,        /* be32 */
>
> +       TCA_FLOWER_KEY_ENC_FLAGS,       /* be16 */
> +       TCA_FLOWER_KEY_ENC_FLAGS_MASK,  /* be16 */
> +
>         __TCA_FLOWER_MAX,
>  };
>
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index efb9d2811b73..d244169c8471 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -74,6 +74,7 @@ struct fl_flow_key {
>         struct flow_dissector_key_l2tpv3 l2tpv3;
>         struct flow_dissector_key_ipsec ipsec;
>         struct flow_dissector_key_cfm cfm;
> +       struct flow_dissector_key_enc_flags enc_flags;
>  } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as =
longs. */
>
>  struct fl_flow_mask_range {
> @@ -731,6 +732,10 @@ static const struct nla_policy fl_policy[TCA_FLOWER_=
MAX + 1] =3D {
>         [TCA_FLOWER_KEY_SPI_MASK]       =3D { .type =3D NLA_U32 },
>         [TCA_FLOWER_L2_MISS]            =3D NLA_POLICY_MAX(NLA_U8, 1),
>         [TCA_FLOWER_KEY_CFM]            =3D { .type =3D NLA_NESTED },
> +       [TCA_FLOWER_KEY_ENC_FLAGS]      =3D NLA_POLICY_MASK(NLA_BE16,
> +                                                         TUNNEL_FLAGS_PR=
ESENT),
> +       [TCA_FLOWER_KEY_ENC_FLAGS_MASK] =3D NLA_POLICY_MASK(NLA_BE16,
> +                                                         TUNNEL_FLAGS_PR=
ESENT),
>  };
>
>  static const struct nla_policy
> @@ -1748,6 +1753,21 @@ static int fl_set_key_cfm(struct nlattr **tb,
>         return 0;
>  }
>
> +static int fl_set_key_enc_flags(struct nlattr **tb, __be16 *flags_key,
> +                               __be16 *flags_mask, struct netlink_ext_ac=
k *extack)
> +{
> +       /* mask is mandatory for flags */
> +       if (!tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]) {

if (NL_REQ_ATTR_CHECK(extack,...))

> +               NL_SET_ERR_MSG(extack, "missing enc_flags mask");
> +               return -EINVAL;
> +       }
> +
> +       *flags_key =3D nla_get_be16(tb[TCA_FLOWER_KEY_ENC_FLAGS]);
> +       *flags_mask =3D nla_get_be16(tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]);
> +
> +       return 0;
> +}
> +
>  static int fl_set_key(struct net *net, struct nlattr **tb,
>                       struct fl_flow_key *key, struct fl_flow_key *mask,
>                       struct netlink_ext_ack *extack)
> @@ -1986,6 +2006,10 @@ static int fl_set_key(struct net *net, struct nlat=
tr **tb,
>                 ret =3D fl_set_key_flags(tb, &key->control.flags,
>                                        &mask->control.flags, extack);
>
> +       if (tb[TCA_FLOWER_KEY_ENC_FLAGS])

And here..

cheers,
jamal

> +               ret =3D fl_set_key_enc_flags(tb, &key->enc_flags.flags,
> +                                          &mask->enc_flags.flags, extack=
);
> +
>         return ret;
>  }
>
> @@ -2098,6 +2122,8 @@ static void fl_init_dissector(struct flow_dissector=
 *dissector,
>                              FLOW_DISSECTOR_KEY_IPSEC, ipsec);
>         FL_KEY_SET_IF_MASKED(mask, keys, cnt,
>                              FLOW_DISSECTOR_KEY_CFM, cfm);
> +       FL_KEY_SET_IF_MASKED(mask, keys, cnt,
> +                            FLOW_DISSECTOR_KEY_ENC_FLAGS, enc_flags);
>
>         skb_flow_dissector_init(dissector, keys, cnt);
>  }
> @@ -3185,6 +3211,22 @@ static int fl_dump_key_cfm(struct sk_buff *skb,
>         return err;
>  }
>
> +static int fl_dump_key_enc_flags(struct sk_buff *skb,
> +                                struct flow_dissector_key_enc_flags *key=
,
> +                                struct flow_dissector_key_enc_flags *mas=
k)
> +{
> +       if (!memchr_inv(mask, 0, sizeof(*mask)))
> +               return 0;
> +
> +       if (nla_put_be16(skb, TCA_FLOWER_KEY_ENC_FLAGS, key->flags))
> +               return -EMSGSIZE;
> +
> +       if (nla_put_be16(skb, TCA_FLOWER_KEY_ENC_FLAGS_MASK, mask->flags)=
)
> +               return -EMSGSIZE;
> +
> +       return 0;
> +}
> +
>  static int fl_dump_key_options(struct sk_buff *skb, int enc_opt_type,
>                                struct flow_dissector_key_enc_opts *enc_op=
ts)
>  {
> @@ -3481,6 +3523,9 @@ static int fl_dump_key(struct sk_buff *skb, struct =
net *net,
>         if (fl_dump_key_cfm(skb, &key->cfm, &mask->cfm))
>                 goto nla_put_failure;
>
> +       if (fl_dump_key_enc_flags(skb, &key->enc_flags, &mask->enc_flags)=
)
> +               goto nla_put_failure;
> +
>         return 0;
>
>  nla_put_failure:
> --
> 2.43.0
>

