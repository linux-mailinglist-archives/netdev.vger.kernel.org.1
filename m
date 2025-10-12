Return-Path: <netdev+bounces-228633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B33BD0593
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03D73A554D
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4DC2EC08B;
	Sun, 12 Oct 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KH+mFXOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AF2EAB64
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282593; cv=none; b=BFFL1pO/WPpuUwHVBYUK9+xN8X3eLhz6H6avLSAf2ICoaYJunnGv033rFDnrAlwHjbAytt60Ir1ptZk7Sh3IgeIQT9gpQVPA/UT+hbKTBnCskIB5slaNrqV0EB6ViKb5ilTg6iTWznhhrjwMQyyxi9NqBG/QKs2zeTh0BYS3FVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282593; c=relaxed/simple;
	bh=la2PVQYVaGAj8tszJ/WH+Ad8avpsWZF6NPrc+WITEk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajoE4lWs3WfC6h+59s6i6ccvMqIKR5FQweUZscbHglEtdoF48cdNTtIc1/imvffmR0Q+JSo/B6UOwOrfzJPtyOYUki5Gmb6nNGDzwajQqhtwwsDFxjHqkxkCGEd5o5aUuwWeBTVCl/aMJ1pXSRjUj8TYrTiLAd490W00HUwhcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KH+mFXOP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso3185701a12.0
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1760282584; x=1760887384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXfpnO7SbBLsRwLc5gdSwu/WOnokwHg5rYacTWBcVC0=;
        b=KH+mFXOPHW+273b709xLt3p3x1rRSa8RJXi/FESn+bcfyxmGXNGvC5VbUJpwt+YYbn
         hO3gJL9sJtxrzxkYv8wQ2lwcQPmKpp6v4JwYBogX5MXYMGTXZvPJkkM6MQy1b2OwnP+l
         ze6F5Wilv04ogguhfHyN2hU6JqJft8ipl6Jaci6G5FVGNFTd/cmXxZpa3YqQxVL3s20B
         jSJS2Eot10w8jqCA+ie18sSZb1UAh8/aXGASKdFFy8u3OkH0MQ4e0W1gxcUmVFje5EwD
         9eo+aqLT0vHgct4y5wVmd7WtUw0gHoCa1ME7GVgKdwxHaIZgAXNGVj0C2LE4xuoDvuuf
         4w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760282584; x=1760887384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXfpnO7SbBLsRwLc5gdSwu/WOnokwHg5rYacTWBcVC0=;
        b=iqg1wPthJdYDbp4w7MWfbtJ6DGjIbHCUhPdo3ljoYSG6Lcq8vD73Ks+9tiocZcNtJW
         XGC6VvO/oaZojf4FU5v6oZKdLqryMNejsphGilAWN0pcnUBtKqCCGDcGKB5Tibvk22OT
         ojUvZlc359Pl47KoVUHSPJmHajmUKwtXYpYC0nrZCTX2JC02mhzZfaapA9V0dCjKFNio
         AbLYJLxU37X8JM4kMx6cDOHUcDNk9jreI9sb5SoERBSV0sfIa+aovLi6YBwOpwCGIZJj
         64YrPArV446lq5MiC2ep52iGxN+wDw3AOO0lePeffJmRA4mtflkYpE1jSKa556SxJ+EB
         NBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVInZRtQuFeNCfhGXfHoTIqdsqAxUADRZ81qyt4gSlO/YNKL40xmMKZ/jnW4R2ww1ve/m4b2aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUmjEae7sQZsDk/AhAKjyBUccI/waoPU5j+uAzjwiI00dvBzE
	boW8alHKqgtbyQNApYq84RhSupuQ/6BR6mF+Rq2LkSQXiFyrJBDczXWgrfAQE2ETferT2I9zWF7
	dzuMyb0x2yXhApJ45G5mncKGrB7MAEaD60QH4yZr5
X-Gm-Gg: ASbGncs6XfhkCssVoqV2yDyZ00CcLWzLcWfXzmAt0i+zLN1ubcsLK0jDPMuT6T08atc
	P64pttxHUR8zi68d7ZnXVV7q1RIgZkZG/wJVVUVVjXRZLPclqzQkfwMknxH408bsd5nTKXWzxnt
	HUWkuu4Fx1/azShg0WdSijcyICTg5cHVpJT15+E7iGAJqs/D2W5syLCmV6p6Nke44fK/CtsFuon
	nKEQP+9v8MDRuSUYkb4qWHrDb+yzII5eyV0TKHpQINIOefG8cERg2VotLzQkkFsGj0eiZZzkpAJ
	UA==
X-Google-Smtp-Source: AGHT+IHun/1TsT8YW8w8em8UILkzw5pjHrm66fe1XZXIzrJWtz62ZJaoSF5OG6StcB0cPHBcuh2RROJEeqbut3/osBY=
X-Received: by 2002:a17:903:94f:b0:290:26fb:2b91 with SMTP id
 d9443c01a7336-2902724dc96mr230849715ad.0.1760282584253; Sun, 12 Oct 2025
 08:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com> <20251006193103.2684156-3-edumazet@google.com>
In-Reply-To: <20251006193103.2684156-3-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 12 Oct 2025 11:22:53 -0400
X-Gm-Features: AS18NWBvyYHhHzceAFsyFzO8GvU2k5ugbgTaAiEt7Vu2sP5euyPjefosjwYkBWo
Message-ID: <CAM0EoM=4FyGjjXdT=3f8FE18o+b2=_TZEbaure63MrU96szzAQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/5] net/sched: act_mirred: add loop detection
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:31=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> We want to revert commit 0f022d32c3ec ("net/sched: Fix mirred deadlock
> on device recursion") because it adds code in the fast path, even when
> act_mirred is not used.
>
> Use an additional device pointers array in struct netdev_xmit
> and implement loop detection in tcf_mirred_is_act_redirect().

Patch series looks good!
This has the potential of (later on) fixing issue that are currently
broken after the TTL bits were taken away.
Small suggestion, the commit message was a bit confusing to me. How about:

Commit 0f022d32c3ec ("net/sched: Fix mirred deadlock on device
recursion") it adds code in the fast path, even when act_mirred is not
used. We revert in the next patch.

Prepare by adding an additional device pointers array in struct
netdev_xmit and implement loop detection in
tcf_mirred_is_act_redirect().

Please give us time to run tests on this set!

cheers,
jamal

>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/netdevice_xmit.h |  9 ++++-
>  net/sched/act_mirred.c         | 62 +++++++++++++---------------------
>  2 files changed, 31 insertions(+), 40 deletions(-)
>
> diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmi=
t.h
> index 813a19122ebbb2c6a04176330b1055b7c2b9c902..cc232508e695eefe95ea6e55a=
21978be11d5da83 100644
> --- a/include/linux/netdevice_xmit.h
> +++ b/include/linux/netdevice_xmit.h
> @@ -2,6 +2,12 @@
>  #ifndef _LINUX_NETDEVICE_XMIT_H
>  #define _LINUX_NETDEVICE_XMIT_H
>
> +#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> +#define MIRRED_NEST_LIMIT      4
> +#endif
> +
> +struct net_device;
> +
>  struct netdev_xmit {
>         u16 recursion;
>         u8  more;
> @@ -9,7 +15,8 @@ struct netdev_xmit {
>         u8  skip_txqueue;
>  #endif
>  #if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> -       u8 sched_mirred_nest;
> +       u8                      sched_mirred_nest;
> +       struct net_device       *sched_mirred_dev[MIRRED_NEST_LIMIT];
>  #endif
>  #if IS_ENABLED(CONFIG_NF_DUP_NETDEV)
>         u8 nf_dup_skb_recursion;
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 5f01f567c934d3669d9a3058cff861a8fe5f88b6..f27b583def78e4afecc711285=
4b93d59c2520201 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -29,31 +29,6 @@
>  static LIST_HEAD(mirred_list);
>  static DEFINE_SPINLOCK(mirred_list_lock);
>
> -#define MIRRED_NEST_LIMIT    4
> -
> -#ifndef CONFIG_PREEMPT_RT
> -static u8 tcf_mirred_nest_level_inc_return(void)
> -{
> -       return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest)=
;
> -}
> -
> -static void tcf_mirred_nest_level_dec(void)
> -{
> -       __this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
> -}
> -
> -#else
> -static u8 tcf_mirred_nest_level_inc_return(void)
> -{
> -       return current->net_xmit.sched_mirred_nest++;
> -}
> -
> -static void tcf_mirred_nest_level_dec(void)
> -{
> -       current->net_xmit.sched_mirred_nest--;
> -}
> -#endif
> -
>  static bool tcf_mirred_is_act_redirect(int action)
>  {
>         return action =3D=3D TCA_EGRESS_REDIR || action =3D=3D TCA_INGRES=
S_REDIR;
> @@ -439,44 +414,53 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff=
 *skb,
>  {
>         struct tcf_mirred *m =3D to_mirred(a);
>         int retval =3D READ_ONCE(m->tcf_action);
> -       unsigned int nest_level;
> +       struct netdev_xmit *xmit;
>         bool m_mac_header_xmit;
>         struct net_device *dev;
> -       int m_eaction;
> +       int i, m_eaction;
>         u32 blockid;
>
> -       nest_level =3D tcf_mirred_nest_level_inc_return();
> -       if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
> +#ifdef CONFIG_PREEMPT_RT
> +       xmit =3D &current->net_xmit;
> +#else
> +       xmit =3D this_cpu_ptr(&softnet_data.xmit);
> +#endif
> +       if (unlikely(xmit->sched_mirred_nest >=3D MIRRED_NEST_LIMIT)) {
>                 net_warn_ratelimited("Packet exceeded mirred recursion li=
mit on dev %s\n",
>                                      netdev_name(skb->dev));
> -               retval =3D TC_ACT_SHOT;
> -               goto dec_nest_level;
> +               return TC_ACT_SHOT;
>         }
>
>         tcf_lastuse_update(&m->tcf_tm);
>         tcf_action_update_bstats(&m->common, skb);
>
>         blockid =3D READ_ONCE(m->tcfm_blockid);
> -       if (blockid) {
> -               retval =3D tcf_blockcast(skb, m, blockid, res, retval);
> -               goto dec_nest_level;
> -       }
> +       if (blockid)
> +               return tcf_blockcast(skb, m, blockid, res, retval);
>
>         dev =3D rcu_dereference_bh(m->tcfm_dev);
>         if (unlikely(!dev)) {
>                 pr_notice_once("tc mirred: target device is gone\n");
>                 tcf_action_inc_overlimit_qstats(&m->common);
> -               goto dec_nest_level;
> +               return retval;
>         }
> +       for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> +               if (xmit->sched_mirred_dev[i] !=3D dev)
> +                       continue;
> +               pr_notice_once("tc mirred: loop on device %s\n",
> +                              netdev_name(dev));
> +               tcf_action_inc_overlimit_qstats(&m->common);
> +               return retval;
> +       }
> +
> +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D dev;
>
>         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit);
>         m_eaction =3D READ_ONCE(m->tcfm_eaction);
>
>         retval =3D tcf_mirred_to_dev(skb, m, dev, m_mac_header_xmit, m_ea=
ction,
>                                    retval);
> -
> -dec_nest_level:
> -       tcf_mirred_nest_level_dec();
> +       xmit->sched_mirred_nest--;
>
>         return retval;
>  }
> --
> 2.51.0.618.g983fd99d29-goog
>

