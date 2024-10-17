Return-Path: <netdev+bounces-136530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7BA9A203A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841A81F26AD1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500C71D8DEE;
	Thu, 17 Oct 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZ7FKcI+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DF1D270B
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161619; cv=none; b=DM4DF7+2IcGOL4llClnsQy5b1/aVqBB4UWQ46AK/RFWY9LXaf7z4xNiitkJRvrGTGqRjCuzd8ENQuMURLX3RNTlzDzkFOKmwZYjXmPBJs9RJC7PiIvT3tbRW+f8fhLHryz+Co8j4MsKNlJAZ1XRlRZmBW6Y6a7OG/0ZlP3LnP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161619; c=relaxed/simple;
	bh=oS5RulJnnfXWpbk1+WC5Yi2McRnC00O2jQ9Zjx4jtPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFB55Ht2lkPiUgzs3KOpRuDt/2QwJ9Zpkobflqu6UuScRzqfG9Ghf70veLmT8eOy8/adCI/CIVGX84mc43NZjzhTqIdIJUx6SoDR+sooTcfJvvHGjC4VpspiRcf1lMbdla1wwsOkam02UpWHKJU/+Jvl/upnYyrT8fvsDhdBn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZ7FKcI+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e66ba398so22520e87.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729161614; x=1729766414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57XVhfBsmyDrMP54LAebKlJtIP1yRTReXKcCOlcalQY=;
        b=JZ7FKcI+CG+HRyAgIYZSgR855mcTH1iijoiS7HBc84NoZeVYEAcYqXya5Ycgba+PNH
         nqBZ/uaialXAmaIEvuq26MYROT6JYdEkOB2AzkcjnBm/7k+6RBjajaTLz+IL369qsfSs
         +2Tb9Py6kywGtlBd7MEudtekfC5hPn5uVRkufGEfJd2exgyF9GwqwfFCejH5PXTCoV/x
         O40gURMmHoI/MyrNwdRWijXXOTXwA7n7Zll6hp2Hl+/wPiJgJSq1N1d3TvWpQlTJMpJd
         89VP0/Ln+AXBSZhQLwk8QKcM4/X+k+51ZDSjYu0LfvjNBR0b8ZFCnt+EE4kLq4CvofQs
         G1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729161614; x=1729766414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57XVhfBsmyDrMP54LAebKlJtIP1yRTReXKcCOlcalQY=;
        b=DV83jQpsZc7MyIzUgtXMvV2xqx2UicSrLfA5zzVJmEFewGMD6unwRDnC33KDze5x2b
         yBKA40/cnV0wT8V5/Dds+W59hpbyIwaix8xDwM+7C9vsigm/Lju7FuQTd11q9sQDdeV8
         Io9Ll8PpXoSp83qDixHaKyvm92gqhmrF6FZn3VVza0/x1orppzyDYn+sN33g9HSwKhX6
         Z7SDuEjav5EcylPkJXf4q0TIsHZHji/plMG9G0GRmNexaSBgFCwYkEhB5wDeV4qlJR4X
         1wVGg348pIS0B1vEx6RCzU7pKzqvWmlphVOvxZ4LsZMpJ3dTOxkTirtmu9rMuXkIZBxw
         yQnA==
X-Gm-Message-State: AOJu0YxyBgOD8ZpPB2p6XNPNHOGRJmSzkMqgTIwEu4nn9fnGAudmIG6G
	cTTieWpf9AEUFTAcWzpVCEAsWWL/Lrk9c9fWf7I1rsf+eefxhT0gdSwpqaOKa4FvUBZcJXCAeON
	Wnej02D4Re1DVC6lHLu72lvBXs/TS5KbqQ59m
X-Google-Smtp-Source: AGHT+IGgfdR7CkqWQJrvEf3cQmsscfZTPcYwzwsk6mWAF6V4gb2F7eKmTa8VkUVf/5ygkylpwJ9sZAUrg0tn/Kjmu5Q=
X-Received: by 2002:a05:6512:3b8c:b0:539:d0c4:5b53 with SMTP id
 2adb3069b0e04-53a0d20607emr356098e87.4.1729161613866; Thu, 17 Oct 2024
 03:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017094315.6948-1-fw@strlen.de>
In-Reply-To: <20241017094315.6948-1-fw@strlen.de>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 17 Oct 2024 12:39:57 +0200
Message-ID: <CANP3RGeeR9vso0MyjRhFuTmx5K7ttt0bisHucce0ONeJotXOZw@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: migrate: work around 0 if_id on migrate
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Nathan Harold <nharold@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:33=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Looks like there are userspace applications which rely on the ability to
> migrate xfrm-interface policies while not providing the interface id.
>
> This worked because old code contains a match workaround:
>    "if_id =3D=3D 0 || pol->if_id =3D=3D if_id".
>
> The packetpath lookup code uses the id_id as a key into rhashtable; after
> switch of migrate lookup over to those functions policy lookup fails.
>
> Add a workaround: if no policy to migrate is found and userspace provided
> no if_id  (normal for non-interface policies!) do a full search of all
> policies and try to find one that matches the selector.
>
> This is super-slow, so print a warning when we find a policy, so
> hopefully such userspace requests are fixed up over time to not rely on
> magic-0-match.
>
> In case of setups where userspace frequently tries to migrate non-existen=
t
> policies with if_id 0 such migrate requests will take much longer to
> complete.
>
> Other options:
>  1. also add xfrm interface usage counter so we know in advance if the
>     slowpath could potentially find the 'right' policy or not.
>
>  2. Completely revert policy insertion patches and go back to linear
>     insertion complexity.
>
> 1) seems premature, I'd expect userspace to try migration of policies it
>    has inserted in the past, so either normal fastpath or slowpath
>    should find a match anyway.
>
> 2) seems like a worse option to me.
>
> Cc: Nathan Harold <nharold@google.com>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
> Reported-by: Yan Yan <evitayan@google.com>
> Tested-by: Yan Yan <evitayan@google.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/xfrm/xfrm_policy.c | 101 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index d555ea401234..29554173831a 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4425,6 +4425,81 @@ EXPORT_SYMBOL_GPL(xfrm_audit_policy_delete);
>  #endif
>
>  #ifdef CONFIG_XFRM_MIGRATE
> +static bool xfrm_migrate_selector_match(const struct xfrm_selector *sel_=
cmp,
> +                                       const struct xfrm_selector *sel_t=
gt)
> +{
> +       if (sel_cmp->proto =3D=3D IPSEC_ULPROTO_ANY) {
> +               if (sel_tgt->family =3D=3D sel_cmp->family &&
> +                   xfrm_addr_equal(&sel_tgt->daddr, &sel_cmp->daddr,
> +                                   sel_cmp->family) &&
> +                   xfrm_addr_equal(&sel_tgt->saddr, &sel_cmp->saddr,
> +                                   sel_cmp->family) &&
> +                   sel_tgt->prefixlen_d =3D=3D sel_cmp->prefixlen_d &&
> +                   sel_tgt->prefixlen_s =3D=3D sel_cmp->prefixlen_s) {
> +                       return true;
> +               }
> +       } else {
> +               if (memcmp(sel_tgt, sel_cmp, sizeof(*sel_tgt)) =3D=3D 0)
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +/* Ugly workaround for userspace that wants to migrate policies for
> + * xfrm interfaces but does not provide the interface if_id.
> + *
> + * Old code used to search the lists and handled if_id =3D=3D 0 as 'does=
 match'.
> + * New xfrm_migrate code uses the packet-path lookup which uses the if_i=
d
> + * as part of hash key and won't find correct policies.
> + *
> + * Walk entire policy list to see if there is a matching selector withou=
t
> + * checking if_id.
> + */
> +static u32 xfrm_migrate_policy_find_slow(const struct xfrm_selector *sel=
,
> +                                        u8 dir, u8 type, struct net *net=
)
> +{
> +       const struct xfrm_policy *policy, *cand =3D NULL;
> +       const struct hlist_head *chain;
> +       u32 if_id =3D 0;
> +
> +       chain =3D policy_hash_direct(net, &sel->daddr, &sel->saddr, sel->=
family, dir);
> +       hlist_for_each_entry(policy, chain, bydst) {
> +               if (policy->type !=3D type)
> +                       continue;
> +
> +               if (xfrm_migrate_selector_match(sel, &policy->selector)) =
{
> +                       if_id =3D policy->if_id;
> +                       cand =3D policy;
> +                       break;
> +               }
> +       }
> +
> +       spin_lock_bh(&net->xfrm.xfrm_policy_lock);
> +
> +       list_for_each_entry(policy, &net->xfrm.policy_all, walk.all) {
> +               if (xfrm_policy_is_dead_or_sk(policy))
> +                       continue;
> +
> +               if (policy->type !=3D type)
> +                       continue;
> +
> +               /* candidate has better priority */
> +               if (cand && policy->priority >=3D cand->priority)
> +                       continue;
> +
> +               if (dir !=3D xfrm_policy_id2dir(policy->index))
> +                       continue;
> +
> +               if (xfrm_migrate_selector_match(sel, &policy->selector)) =
{
> +                       if_id =3D policy->if_id;
> +                       cand =3D policy;
> +               }
> +       }
> +       spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
> +
> +       return if_id;
> +}
> +
>  static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_se=
lector *sel,
>                                                     u8 dir, u8 type, stru=
ct net *net, u32 if_id)
>  {
> @@ -4579,6 +4654,19 @@ static int xfrm_migrate_check(const struct xfrm_mi=
grate *m, int num_migrate,
>         return 0;
>  }
>
> +static void xfrm_migrate_warn_workaround(void)
> +{
> +       char name[sizeof(current->comm)];
> +       static bool warned;
> +
> +       if (warned)
> +               return;
> +
> +       warned =3D true;
> +       pr_warn_once("warning: `%s' is migrating xfrm interface policies =
with if_id 0, this is slow.\n",
> +                    get_task_comm(name, current));
> +}
> +
>  int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>                  struct xfrm_migrate *m, int num_migrate,
>                  struct xfrm_kmaddress *k, struct net *net,
> @@ -4606,11 +4694,24 @@ int xfrm_migrate(const struct xfrm_selector *sel,=
 u8 dir, u8 type,
>         /* Stage 1 - find policy */
>         pol =3D xfrm_migrate_policy_find(sel, dir, type, net, if_id);
>         if (IS_ERR_OR_NULL(pol)) {
> +               if (if_id =3D=3D 0) {
> +                       if_id =3D xfrm_migrate_policy_find_slow(sel, dir,=
 type, net);
> +
> +                       if (if_id) {
> +                               pol =3D xfrm_migrate_policy_find(sel, dir=
, type, net, if_id);
> +                               if (!IS_ERR_OR_NULL(pol)) {
> +                                       xfrm_migrate_warn_workaround();
> +                                       goto found;
> +                               }
> +                       }
> +               }
> +
>                 NL_SET_ERR_MSG(extack, "Target policy not found");
>                 err =3D IS_ERR(pol) ? PTR_ERR(pol) : -ENOENT;
>                 goto out;
>         }
>
> +found:
>         /* Stage 2 - find and update state(s) */
>         for (i =3D 0, mp =3D m; i < num_migrate; i++, mp++) {
>                 if ((x =3D xfrm_migrate_state_find(mp, net, if_id))) {
> --
> 2.45.2
>

Q: Considering the performance impact... would it make sense to hide
this behind a sysctl or a kconfig?

Yan Yan: Also, while I know we found this issue in Android... do we
actually need the fix?  Wasn't the adjustment to netd sufficient?
Android <16 doesn't support >6.6 anyway, and Android 16 should already
have the netd fix...

