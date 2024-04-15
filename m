Return-Path: <netdev+bounces-88001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB73C8A52C8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969B9282A59
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9874BF2;
	Mon, 15 Apr 2024 14:12:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6574BE1
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190364; cv=none; b=flT5jQhNsqi7sYYtul1DTRg1WilUabyyci2JgbEyjHuwY9Brp+Bx90+eJ2F3jFyLs33+m7hDXC0DCYtg5NER8gsM0MGENKWkX+TZ32ev1VkDueNrxZ5xJCuQPhfFBWBwYTeQoKhkLYd3QMXXdwW87EFJS+gwO2vgf82LAbvsTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190364; c=relaxed/simple;
	bh=O/I97LF3LnrtCTgfQUEnvmBh5yo+lBqlYwOF+4BTuS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k0IcKFEBHAIhmClnkfI2JZpV20ln7SxVwQIE52JTEUlGnoXW6S/qA5aAXbLlolQlrE5/bRFxLFa7SV8hAwzYJxwhg5IwqnYuY5Mu3TpZ6zOqoRhDAodvF5vHRg1Zi7fb71ZrDalGp7xc04/Rl1wZRK+ZGVuyzehuKf6YCK2ZoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-ZHKRZ3-NMGKXRXLh0PdHHQ-1; Mon, 15 Apr 2024 10:12:37 -0400
X-MC-Unique: ZHKRZ3-NMGKXRXLh0PdHHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9EF610499A6;
	Mon, 15 Apr 2024 14:12:36 +0000 (UTC)
Received: from hog (unknown [10.39.192.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9668C2166B32;
	Mon, 15 Apr 2024 14:12:35 +0000 (UTC)
Date: Mon, 15 Apr 2024 16:12:30 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org,
	Paul Wouters <paul@nohats.ca>,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH ipsec-next 1/3] xfrm: Add support for per cpu xfrm state
 handling.
Message-ID: <Zh01zlwo0H1BmMug@hog>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <20240412060553.3483630-2-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240412060553.3483630-2-steffen.klassert@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-12, 08:05:51 +0200, Steffen Klassert wrote:
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 0c306473a79d..b41b5dd72d8e 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
[...]
> @@ -1096,6 +1098,9 @@ static void xfrm_state_look_at(struct xfrm_policy *=
pol, struct xfrm_state *x,
>  =09=09=09       struct xfrm_state **best, int *acq_in_progress,
>  =09=09=09       int *error)
>  {
> +=09unsigned int pcpu_id =3D get_cpu();
> +=09put_cpu();

That looks really strange to me. Is it safe? If it is, I guess you
could just use smp_processor_id(), since you don't get anything out of
the extra preempt_disable/enable pair.

(same in xfrm_state_find)


[...]
> @@ -2458,6 +2478,8 @@ static int build_aevent(struct sk_buff *skb, struct=
 xfrm_state *x, const struct
>  =09err =3D xfrm_if_id_put(skb, x->if_id);
>  =09if (err)
>  =09=09goto out_cancel;
> +=09if (x->pcpu_num !=3D UINT_MAX)
> +=09=09err =3D nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);

Missing the corresponding change to xfrm_aevent_msgsize?


[...]
> @@ -3049,6 +3078,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] =
=3D {
>  =09[XFRMA_SET_MARK_MASK]=09=3D { .type =3D NLA_U32 },
>  =09[XFRMA_IF_ID]=09=09=3D { .type =3D NLA_U32 },
>  =09[XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> +=09[XFRMA_SA_PCPU]=09=09=3D { .type =3D NLA_U32 },

What about xfrm_compat? Don't we need to add XFRMA_SA_PCPU to
compat_policy, and then some changes to the translators?


[...]
> @@ -3216,6 +3246,11 @@ static int build_expire(struct sk_buff *skb, struc=
t xfrm_state *x, const struct
>  =09err =3D xfrm_if_id_put(skb, x->if_id);
>  =09if (err)
>  =09=09return err;
> +=09if (x->pcpu_num !=3D UINT_MAX) {
> +=09=09err =3D nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);

Missing the corresponding change to xfrm_expire_msgsize?


[...]
> @@ -3453,6 +3490,8 @@ static int build_acquire(struct sk_buff *skb, struc=
t xfrm_state *x,
>  =09=09err =3D xfrm_if_id_put(skb, xp->if_id);
>  =09if (!err && xp->xdo.dev)
>  =09=09err =3D copy_user_offload(&xp->xdo, skb);
> +=09if (!err && x->pcpu_num !=3D UINT_MAX)
> +=09=09err =3D nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);

Missing the corresponding change to xfrm_acquire_msgsize?

--=20
Sabrina


