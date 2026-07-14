Return-Path: <netdev+bounces-307363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IHriKYnVVWqIuAAAu9opvQ
	(envelope-from <netdev+bounces-307363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:22:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E99EC751729
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:22:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=fK3l6X0p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307363-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307363-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A29FF303D30A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3581A3D5222;
	Tue, 14 Jul 2026 06:21:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15537268D
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:21:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010097; cv=none; b=DtXTFsE1VnLM7NgXOsT1HlgjkK/xECPOG5NDd2pyczLej2WJA5xJruZGIDS2k2gfMntEfZ22bRq1+LsVzG2JO1Cbv5LKV+zPTv7lG/3ZaxZDdwMT16M0HyWbAj9oxGmbZWLcMkpponXG/ovu1FKJ4ZPfQJPsLESNCQg68roPNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010097; c=relaxed/simple;
	bh=kI0U3ZyHCl4ZIBI+Rr7RnAlEPLW2BgHXVl5FvAw7IaI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TZ9sI/SCkmdwcKfu1omovERlhaVOl92F405ZwmEAz0fV+y3mkxJT/W5zdOh3ujueESK4nJbJh4MuX0/Y5yrwqwrdDwnB9MavOVKWcIhT5R+bxGdvHAqh32nlLLxs8SZPSy9AIGm4LGVdZngG+3Vbd9lC0JLMwj5vHOasXKFAf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=fK3l6X0p; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8486ac3f347so666027b3a.1
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784010093; x=1784614893; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WlLst3Qz7KRr8yuur9ZCrQd60mwFUbPMcGahtbRfpRw=;
        b=fK3l6X0p4gXL59+n6bCL6rLuuAcmKPJgevOWN083V9S8aXl03QRxmC++00YXyfFTO7
         fqWSV3WShkcRMadIZ3Zk5MiAhUReDd90Gfx/c3t+CwZC7keGdh9bEKCsjrl0+UhF54jZ
         q9WrRI5DPQfMO2AZ+UucEyZ1Cfyq+lshJX9jYNrB2kR4Vs7yodCvbqrPbHjEyxMBuA2q
         z22Ff8pahZW9JiE7MRW0P1pqXc1aH0Nx1++ltLwue6pniRu+FnBY0NdxzIzdnCFLL7SK
         D6eLQD1UOBpYVumKrJKUL7ra6qgrZCwJbXTjbnlvsGFfC95MwHC4383v/HKBbHxB0Pmw
         oOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010093; x=1784614893;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlLst3Qz7KRr8yuur9ZCrQd60mwFUbPMcGahtbRfpRw=;
        b=WcnTAqk3oIeUlMCDbGVk7gUG+u+u3h3SkKsEjIdE6bldTkanQ9zVY62d46um+wWgeE
         7D4BB5D5ZsrDnvx1oEFsH2ibE79l1LwLAFd4pewP3GdLzJRWlNeFk5aJ0UtPG0iVeuVb
         S9oiXQY5qas3bR7sYpbo3IftrewEZk3eU/ctzSoibRyfUJVyn/pV0rVwnhjWAP6e3tdh
         I9bLjWXJSgmlN1E5/Ucwz+gX+5ftj2hxtFcCl+ateg8ggwQhPJZHOghikhVmdUbUSN/i
         Sq/EjZnDJUs7LPwa1fuNtjWG7XFrogFJsZmiwbAI6jOQ9cZGyM/Rmzjf1njsql1CzRxg
         FRWw==
X-Gm-Message-State: AOJu0YxERCmViEDnQblaOsT9Ud/Entiz5CIwyTDJYtqJKCBSWt91/9W2
	xYqpruCEsqW1xZAhpH55O/p9NJSPxCXCSo9O63okmOX2SItTRTTRlxxUuVD4ZFUDTzo=
X-Gm-Gg: AfdE7cm4nDdaHkJjpGHbli3AsGZ19pgNNlmcfNcaLOKETaPqzKOC4vLHRzJ9kqE2VRN
	g7/fRUWNsuff4REF9ngWsrQ2wWsWI0O8om/bw4NxLxGKjMV+hcn+oi4/7EwWlCzsjQjNOEQ4H1p
	JbRtcqjT/th5SSoppUXpH/+bSnh9pW3i2Db6xNyFAN9MBBWix5gZ0u84kNw6egnR3ClXig5IAxf
	F07I0/EPuaUNTN9+KeAvgAGQ7SepWGR4bxBh33yWa14lrGL81WFRY0ftRqsP9rmtgZyfK8wbxHJ
	YqVVyw4T0V6UW1Vw0sBAf3BTZhF6QMkpEHLF4K/NlARuoqof4ExLKGcgDdJRhQHO49LVAlNOCSF
	HMHM/h1TYQ6TGvvxPHM6EQTi3SSoTbvFk6oDA4yky3M1nLC5+UtkoKoTQz8KoNVGfPnMiRMOfmj
	F14MiDwO5AgvqTMpWMmOG4emKHyeWSEg76bhb0s38raQ==
X-Received: by 2002:a05:6a00:4f95:b0:848:55a6:fbe with SMTP id d2e1a72fcca58-8488ad099ccmr11197739b3a.35.1784010093302;
        Mon, 13 Jul 2026 23:21:33 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f271ddbsm952780b3a.18.2026.07.13.23.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 02:21:31 -0400
Message-Id: <DJY2SPXTF9HL.10SSKCT9OMMBV@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 09/15] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-10-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-10-ameryhung@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307363-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E99EC751729

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch adds necessary infrastructure to attach a struct_ops
> map to a cgroup. The initial need was to support migrating
> the legacy BPF_PROG_TYPE_SOCK_OPS to a struct_ops.
> Recently, there are other struct_ops use cases that
> need to attach struct_ops to a cgroup. For example,
> the recent BPF OOM and memcg discussion in LSFMMBPF 2026.
>
> The motivation is to create a consistent expectation
> for attaching struct_ops to cgroup instead of each subsystem
> creating its own infrastructure. This logic includes
> hierarchy expectation, ordering expectation,
> attachment API, and rcu gp.
>
> There is already an existing implementation for attaching
> multiple bpf progs to a cgroup. There are also tools
> built around it for querying. Attaching a struct_ops map
> (which is a group of bpf programs) could also adhere to
> a similar API and potentially reuse most of the existing
> implementation.
>
> A couple of ideas have been tried. One of them
> is to use mprog.c. In terms of the amount of changes,
> I eventually came to the same conclusion as in
> commit 120933984460 ("bpf: Implement mprog API on top of existing cgroup =
progs").
> I then shifted the focus to reusing the current
> {update,compute,activate,purge}_effective_progs() which has
> the main logic that implements the mprog API.
>
> Since then, I tried to add a 'struct cgroup *cgroup' member
> to the existing 'struct bpf_struct_ops_link' and link_create
> will create a 'struct bpf_struct_ops_link' object to be stored
> in the pl->link. This turns out to have more changes on
> both cgroup.c and bpf_struct_ops.c than I like.
>
> This patch directly reuses the 'struct bpf_cgroup_link' which
> cgroup.c already understands. Add 'struct bpf_map *map'
> to 'struct bpf_cgroup_link'. In the future, as more subsystems
> are extended by struct_ops, we may consider to make
> 'struct bpf_map *map' as a primary citizen of a link
> like 'struct bpf_prog *prog' and directly add
> 'struct bpf_map *map' to the generic 'struct bpf_link'.
>
> The pl->link could be the traditional 'prog' link or the
> new 'map' link. The places that need to handle them differently
> have already been refactored into the new prog_list_*() added in
> the earlier patch. In those new prog_list_*(), this patch will
> check "pl->link && pl->link->map", learn that it is a 'map' link
> and handle it correctly.
>
> The bpf_prog_array also needs to handle that its item can store
> the traditional 'prog' or it can store a struct_ops map.
> The places that need to handle them differently have also
> been refactored into the new bpf_cgroup_array_*() added
> in the earlier patch. The two differences are:
>   - different sentinel (dummy_bpf_prog in prog vs cfi_stub in struct_ops)
>   - the array for struct_ops may need to go through different
>     rcu gp.
> The bpf_cgroup_array_*() functions use the cgroup_bpf_attach_type (ie aty=
pe)
> to distinguish the array is storing prog or storing struct_ops map.
>
> This patch also implements a separate struct bpf_link_ops
> "cgroup_struct_ops_link_ops" to have a separate link_ops implementation
> that only handles the cgroup's struct_ops link.
>
> Questions:
> - Although this patch did not change it, it is not obvious to me how
>   the replace_effective_progs() and purge_effective_progs() handle
>   cases when there are existing BPF_F_PREORDER progs attached
>   in the hlist.
>
> Misc notes:
> - CGROUP_TCP_SOCK_OPS is added to the 'enum cgroup_bpf_attach_type'.
>   The actual implementation of the tcp_bpf_ops (a struct_ops)
>   will be added in the next patch.
>
> - free_after_mult_rcu_gp is added to 'struct bpf_struct_ops' such that
>   the bpf_prog_array can have a mix of sleepable and
>   non-sleepable prog in a struct_ops. This can tell
>   how the bpf_prog_array should be freed.
>
> - For a struct_ops that supports cgroup attachment, it does not need to
>   implement its own reg/unreg function. reg/unreg to a cgroup is
>   done by the common infrastructure added in this patch.
>
> - The cgroup's struct_ops link only supports BPF_F_ALLOW_MULTI.
>   This is enforced internally in cgroup_bpf_struct_ops_attach.
>   This should be consistent with the current prog's link
>   behavior in cgroup_bpf_link_attach.
>
>   In the future, we may allow each subsystem to choose differently.
>
> - A cgroup_atype member is added to 'struct bpf_struct_ops'.
>   When a subsystem struct_ops needs to support cgroup attachment,
>   it needs to add a value to 'enum cgroup_bpf_attach_type'
>   and then assign it to the newly added cgroup_atype member
>   in the bpf_struct_ops.
>
> - During LINK_CREATE in syscall, the patch uses the same
>   BPF_STRUCT_OPS (in attr->link_create.attach_type).
>   The bpf_struct_ops_link_create learns the map and
>   from the map it learns the st_ops. If the st_ops->cgroup_atype
>   is not 0, it will create a cgroup's link.
>
> - When a subsystem registers a struct_ops that supports cgroup
>   attachment, the struct_ops infrastructure will also ask the
>   cgroup infrastructure to remember a few things. This is done
>   by calling cgroup_bpf_struct_ops_register().
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Hi Amery,

> ---
>  include/linux/bpf-cgroup-defs.h |   1 +
>  include/linux/bpf-cgroup.h      |  28 +++
>  include/linux/bpf.h             |  19 +-
>  include/uapi/linux/bpf.h        |   4 +-
>  kernel/bpf/bpf_struct_ops.c     |  29 +++
>  kernel/bpf/btf.c                |  23 +-
>  kernel/bpf/cgroup.c             | 375 ++++++++++++++++++++++++++++++--
>  kernel/bpf/syscall.c            |   1 +
>  tools/include/uapi/linux/bpf.h  |   4 +-
>  9 files changed, 463 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-d=
efs.h
> index c9e6b26abab6..0147b8bec973 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -47,6 +47,7 @@ enum cgroup_bpf_attach_type {
>  	CGROUP_INET6_GETSOCKNAME,
>  	CGROUP_UNIX_GETSOCKNAME,
>  	CGROUP_INET_SOCK_RELEASE,
> +	CGROUP_TCP_SOCK_OPS,
>  	CGROUP_LSM_START,
>  	CGROUP_LSM_END =3D CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
>  	MAX_CGROUP_BPF_ATTACH_TYPE
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 4d0cc65976a1..8a75a6cd7309 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -100,6 +100,8 @@ struct bpf_cgroup_storage {
>  struct bpf_cgroup_link {
>  	struct bpf_link link;
>  	struct cgroup *cgroup;
> +	struct bpf_map *map;
> +	wait_queue_head_t wait_hup;
>  };
> =20
>  struct bpf_prog_list {
> @@ -110,6 +112,18 @@ struct bpf_prog_list {
>  	u32 flags;
>  };
> =20
> +#define bpf_cgroup_struct_ops_foreach(var, item, cgrp, atype)		\
> +	for (item =3D rcu_dereference((cgrp)->bpf.effective[atype])->items;\
> +	     ((var) =3D READ_ONCE(item->kdata));				\
> +	     item++)
> +
> +static inline bool cgroup_bpf_is_struct_ops_atype(enum cgroup_bpf_attach=
_type atype)
> +{
> +	return atype =3D=3D CGROUP_TCP_SOCK_OPS;
> +}
> +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cfi_st=
ubs, bool mult_trace);
> +int cgroup_bpf_struct_ops_attach(struct bpf_map *map, const union bpf_at=
tr *attr);
> +
>  void __init cgroup_bpf_lifetime_notifier_init(void);
> =20
>  int __cgroup_bpf_run_filter_skb(struct sock *sk,
> @@ -479,6 +493,20 @@ static inline int bpf_percpu_cgroup_storage_update(s=
truct bpf_map *map,
>  	return 0;
>  }
> =20
> +static inline bool cgroup_bpf_is_struct_ops_atype(int atype)
> +{
> +	return false;
> +}
> +static inline void cgroup_bpf_struct_ops_register(int atype, u32 type_id=
, void *cfi_stubs,
> +						  bool mult_trace)
> +{
> +}
> +static inline int cgroup_bpf_struct_ops_attach(struct bpf_map *map,
> +					       const union bpf_attr *attr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #define cgroup_bpf_enabled(atype) (0)
>  #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx) (=
{ 0; })
>  #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype) ({ 0; })
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e371a4733135..df95ae690da5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2100,11 +2100,18 @@ struct btf_member;
>   *	   unloaded while in use.
>   * @name: The name of the struct bpf_struct_ops object.
>   * @func_models: Func models
> + * @cgroup_atype: A value in enum cgroup_bpf_attach_type for cgroup atta=
chment.
> + *		  0 means the struct_ops type does not support cgroup attachment.
> + *		  If cgroup_atype is non-zero, the @reg and @unreg must be NULL
> + *		  because the attachment/detachment will be handled by the bpf core.
>   * @free_after_tasks_rcu_gp: Set to true if it needs the bpf core to wai=
t for
>   *                           a tasks_rcu gp before freeing the struct_op=
s map
>   *                           and its progs. It is unnecessary if the @un=
reg
>   *                           has waited for the correct rcu gp or the @u=
nreg
>   *                           has ensured all struct_ops prog has finishe=
d running.
> + * @free_after_mult_rcu_gp: Same as @free_after_tasks_rcu_gp but waiting=
 for
> + *                          both tasks_trace_rcu and regular rcu grace p=
eriod.
> + *                          It is usually needed if the struct_ops has s=
leepable prog.
>   */
>  struct bpf_struct_ops {
>  	const struct bpf_verifier_ops *verifier_ops;
> @@ -2123,7 +2130,9 @@ struct bpf_struct_ops {
>  	struct module *owner;
>  	const char *name;
>  	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
> +	int cgroup_atype;
>  	bool free_after_tasks_rcu_gp;
> +	bool free_after_mult_rcu_gp;
>  };
> =20
>  /* Every member of a struct_ops type has an instance even a member is no=
t
> @@ -2258,6 +2267,7 @@ void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *=
map);
>  bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
>  int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf=
_map *old_map,
>  				     struct bpf_map *expected_old_map);
> +int bpf_struct_ops_map_cgroup_atype(struct bpf_map *map);
> =20
>  #ifdef CONFIG_NET
>  /* Define it here to avoid the use of forward declaration */
> @@ -2330,6 +2340,10 @@ static inline u32 bpf_struct_ops_kdata_map_id(void=
 *kdata)
>  {
>  	return 0;
>  }
> +static inline int bpf_struct_ops_map_cgroup_atype(struct bpf_map *map)
> +{
> +	return 0;
> +}
>  static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
>  {
>  	return NULL;
> @@ -2519,7 +2533,10 @@ u64 bpf_event_output(struct bpf_map *map, u64 flag=
s, void *meta, u64 meta_size,
>   * since other cpus are walking the array of pointers in parallel.
>   */
>  struct bpf_prog_array_item {
> -	struct bpf_prog *prog;
> +	union {
> +		struct bpf_prog *prog;
> +		void *kdata;
> +	};
>  	union {
>  		struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]=
;
>  		u64 bpf_cookie;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c91b5a4bda03..c982801ec7db 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1756,7 +1756,7 @@ union bpf_attr {
>  			__u32	prog_cnt;
>  			__u32	count;
>  		};
> -		__u32		:32;
> +		__u32		type_id;
>  		/* output: per-program attach_flags.
>  		 * not allowed to be set during effective query.
>  		 */
> @@ -6818,6 +6818,8 @@ struct bpf_link_info {
>  		} xdp;
>  		struct {
>  			__u32 map_id;
> +			__u32 :32;
> +			__u64 cgroup_id;
>  		} struct_ops;
>  		struct {
>  			__u32 pf;
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 3d650a7e9f68..06d72cdca601 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -13,6 +13,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/poll.h>
> +#include <linux/bpf-cgroup.h>
> =20
>  struct bpf_struct_ops_value {
>  	struct bpf_struct_ops_common_value common;
> @@ -1076,6 +1077,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(un=
ion bpf_attr *attr)
>  		goto errout;
>  	}
> =20
> +	if (st_ops_desc->st_ops->cgroup_atype && !(attr->map_flags & BPF_F_LINK=
)) {
> +		ret =3D -EOPNOTSUPP;
> +		goto errout;
> +	}
> +
>  	vt =3D st_ops_desc->value_type;
>  	if (attr->value_size !=3D vt->size) {
>  		ret =3D -EINVAL;
> @@ -1116,6 +1122,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
> =20
>  	mutex_init(&st_map->lock);
>  	bpf_map_init_from_attr(map, attr);
> +	map->free_after_mult_rcu_gp =3D st_ops_desc->st_ops->free_after_mult_rc=
u_gp;
>  	map->free_after_rcu_gp =3D true;
> =20
>  	return map;
> @@ -1244,6 +1251,14 @@ void *bpf_struct_ops_map_kdata(struct bpf_map *map=
)
>  	return st_map->kvalue.data;
>  }
> =20
> +int bpf_struct_ops_map_cgroup_atype(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> +	return st_map->st_ops_desc->st_ops->cgroup_atype;
> +}
> +
>  void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
>  {
>  	struct bpf_struct_ops_map *st_map;
> @@ -1419,6 +1434,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr=
)
>  	struct bpf_link_primer link_primer;
>  	struct bpf_struct_ops_map *st_map;
>  	struct bpf_map *map;
> +	int cgroup_atype;
>  	int err;
> =20
>  	map =3D bpf_map_get(attr->link_create.map_fd);
> @@ -1432,6 +1448,19 @@ int bpf_struct_ops_link_create(union bpf_attr *att=
r)
>  		goto err_out;
>  	}
> =20
> +	cgroup_atype =3D st_map->st_ops_desc->st_ops->cgroup_atype;
> +	if (cgroup_atype) {
> +		err =3D cgroup_bpf_struct_ops_attach(map, attr);
> +		bpf_map_put(map);
> +		return err;
> +	}
> +
> +	if (memchr_inv(&attr->link_create.cgroup, 0, sizeof(attr->link_create.c=
group)) ||
> +	    attr->link_create.target_fd) {
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
>  	link =3D kzalloc_obj(*link, GFP_USER);
>  	if (!link) {
>  		err =3D -ENOMEM;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64572f85edc8..d591f306ace5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -20,6 +20,7 @@
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/bpf.h>
> +#include <linux/bpf-cgroup.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/skmsg.h>
>  #include <linux/perf_event.h>
> @@ -9836,6 +9837,7 @@ btf_add_struct_ops(struct btf *btf, struct bpf_stru=
ct_ops *st_ops,
>  		   struct bpf_verifier_log *log)
>  {
>  	struct btf_struct_ops_tab *tab, *new_tab;
> +	int cgroup_atype;
>  	int i, err;
> =20
>  	tab =3D btf->struct_ops_tab;
> @@ -9847,8 +9849,10 @@ btf_add_struct_ops(struct btf *btf, struct bpf_str=
uct_ops *st_ops,
>  		btf->struct_ops_tab =3D tab;
>  	}
> =20
> +	cgroup_atype =3D st_ops->cgroup_atype;
>  	for (i =3D 0; i < tab->cnt; i++)
> -		if (tab->ops[i].st_ops =3D=3D st_ops)
> +		if (tab->ops[i].st_ops =3D=3D st_ops ||
> +		    (cgroup_atype && cgroup_atype =3D=3D tab->ops[i].st_ops->cgroup_at=
ype))
>  			return -EEXIST;
> =20
>  	if (tab->cnt =3D=3D tab->capacity) {
> @@ -9868,6 +9872,23 @@ btf_add_struct_ops(struct btf *btf, struct bpf_str=
uct_ops *st_ops,
>  	if (err)
>  		return err;
> =20
> +	if (cgroup_atype) {
> +		if (!cgroup_bpf_is_struct_ops_atype(cgroup_atype) ||

Can we add a comment here as to why free_after_tasks_rcu_gp is always
invalid here (which IIUC is because it's=20
free_after_mult_rcu_gp)?

> +		    st_ops->reg || st_ops->unreg || st_ops->free_after_tasks_rcu_gp) {
> +			bpf_struct_ops_desc_release(&tab->ops[btf->struct_ops_tab->cnt]);
> +			return -EINVAL;
> +		}
> +
> +		/* There is no need to unregister from cgroup when the
> +		 * btf_free(). No struct_ops map and its cgroup link
> +		 * can be created once its btf is gone.
> +		 */

Network-style comment, should be regular kernel-style.

In terms of the content: What happens if the struct_ops are in a module,
then we load/unload/reload? IIUC even if the signatures are identical,
the btf_id could be different so it's not like we can always reuse the
previous cgroup registration.

> +		cgroup_bpf_struct_ops_register(cgroup_atype,
> +					       tab->ops[btf->struct_ops_tab->cnt].type_id,
> +					       st_ops->cfi_stubs,
> +					       st_ops->free_after_mult_rcu_gp);
> +	}
> +
>  	btf->struct_ops_tab->cnt++;
> =20
>  	return 0;
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 081d81de1816..745e826c9f61 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -24,6 +24,29 @@
>  DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATT=
ACH_TYPE);
>  EXPORT_SYMBOL(cgroup_bpf_enabled_key);
> =20
> +static u32 struct_ops_type_id[MAX_CGROUP_BPF_ATTACH_TYPE];
> +static void *struct_ops_cfi_stubs[MAX_CGROUP_BPF_ATTACH_TYPE];
> +static bool struct_ops_mult_rcu[MAX_CGROUP_BPF_ATTACH_TYPE];


Can we make a struct out of those? Right now we're carrying them loose
into the module even though every index corresponds to a single
registered struct_oips.

> +
> +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cfi_st=
ubs, bool mult_rcu)
> +{
> +	struct_ops_type_id[atype] =3D type_id;
> +	struct_ops_cfi_stubs[atype] =3D cfi_stubs;
> +	struct_ops_mult_rcu[atype] =3D mult_rcu;
> +}
> +
> +static enum cgroup_bpf_attach_type find_atype_by_struct_ops_id(u32 type_=
id)
> +{
> +	enum cgroup_bpf_attach_type atype;
> +
> +	for (atype =3D 0; atype < MAX_CGROUP_BPF_ATTACH_TYPE; atype++) {
> +		if (cgroup_bpf_is_struct_ops_atype(atype) &&
> +		    struct_ops_type_id[atype] =3D=3D type_id)
> +			return atype;
> +	}
> +	return CGROUP_BPF_ATTACH_TYPE_INVALID;
> +}
> +
>  /*
>   * cgroup bpf destruction makes heavy use of work items and there can be=
 a lot
>   * of concurrent destructions.  Use a separate workqueue so that cgroup =
bpf
> @@ -306,6 +329,19 @@ static void bpf_cgroup_storages_link(struct bpf_cgro=
up_storage *storages[],
>  		bpf_cgroup_storage_link(storages[stype], cgrp, attach_type);
>  }
> =20
> +static void cgroup_struct_ops_link_detach_wake(struct bpf_cgroup_link *l=
ink, bool wake_poll)
> +{
> +	cgroup_put(link->cgroup);
> +	link->cgroup =3D NULL;
> +
> +	bpf_map_put(link->map);
> +	/* READ_ONCE in cgroup_struct_ops_link_poll */
> +	WRITE_ONCE(link->map, NULL);
> +
> +	if (wake_poll)
> +		wake_up_interruptible_poll(&link->wait_hup, EPOLLHUP);
> +}
> +
>  /* Called when bpf_cgroup_link is auto-detached from dying cgroup.
>   * It drops cgroup and bpf_prog refcounts, and marks bpf_link as defunct=
. It
>   * doesn't free link memory, which will eventually be done by bpf_link's
> @@ -313,21 +349,37 @@ static void bpf_cgroup_storages_link(struct bpf_cgr=
oup_storage *storages[],
>   */
>  static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
>  {
> -	if (link->link.prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> -		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
> -	cgroup_put(link->cgroup);
> -	link->cgroup =3D NULL;
> +	if (link->map) {
> +		cgroup_struct_ops_link_detach_wake(link, true);
> +	} else {
> +		if (link->link.prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> +			bpf_trampoline_unlink_cgroup_shim(link->link.prog);
> +		cgroup_put(link->cgroup);
> +		link->cgroup =3D NULL;
> +	}

Nit: If we write this as:
	if (link->map) {
		cgroup_struct_ops_link_detach_wake(link, true);
		return
	}

it's slightly less churn.

> +}
> +
> +static void bpf_cgroup_array_free_rcu(struct rcu_head *rcu)
> +{
> +	kfree(container_of(rcu, struct bpf_prog_array, rcu));
>  }
> =20
> -static void bpf_cgroup_array_free(struct bpf_prog_array *array)
> +static void bpf_cgroup_array_free(struct bpf_prog_array *array,
> +				  enum cgroup_bpf_attach_type atype)
>  {
>  	if (!array || array =3D=3D &bpf_empty_prog_array)
>  		return;
> -	kfree_rcu(array, rcu);
> +	if (struct_ops_mult_rcu[atype])
> +		/* RCU tasks trace grace period implies RCU grace period. */
> +		call_rcu_tasks_trace(&array->rcu, bpf_cgroup_array_free_rcu);
> +	else
> +		kfree_rcu(array, rcu);
>  }
> =20
>  static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
>  {
> +	if (cgroup_bpf_is_struct_ops_atype(atype))
> +		return struct_ops_cfi_stubs[atype];
>  	return bpf_prog_dummy();
>  }
> =20
> @@ -355,7 +407,12 @@ static int bpf_cgroup_array_copy_to_user(struct bpf_=
prog_array *array,
>  	for (item =3D array->items; item->prog && i < cnt; item++) {
>  		if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))

Retroactive nit for bpf_cgroup_array_dummy: The name is pretty confusing, s=
omething
that explain that this is really a tombstone value would be nicer.
Especially since we're repurposing the cfi_stubs for per-attach type
tombstones.

>  			continue;
> -		id =3D item->prog->aux->id;
> +
> +		if (cgroup_bpf_is_struct_ops_atype(atype))
> +			id =3D bpf_struct_ops_id(item->kdata);
> +		else
> +			id =3D item->prog->aux->id;
> +
>  		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
>  			return -EFAULT;
>  		i++;
> @@ -417,7 +474,7 @@ static void cgroup_bpf_release(struct work_struct *wo=
rk)
>  		old_array =3D rcu_dereference_protected(
>  				cgrp->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> -		bpf_cgroup_array_free(old_array);
> +		bpf_cgroup_array_free(old_array, atype);
>  	}
> =20
>  	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> @@ -461,17 +518,26 @@ static struct bpf_prog *prog_list_prog(struct bpf_p=
rog_list *pl)
> =20
>  static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_pro=
g_array_item *item)
>  {
> -	item->prog =3D prog_list_prog(pl);
> -	bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
> +	if (pl->link && pl->link->map) {
> +		item->kdata =3D bpf_struct_ops_map_kdata(pl->link->map);
> +	} else {
> +		item->prog =3D prog_list_prog(pl);
> +		bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
> +	}

Same nit as above, an if-return avoid reformatting existing code.

>  }
> =20
>  static void prog_list_replace_item(struct bpf_prog_list *pl, struct bpf_=
prog_array_item *item)
>  {
> -	WRITE_ONCE(item->prog, pl->link->link.prog);
> +	if (pl->link && pl->link->map)

Can we somehow encapsulate the pl->link && pl->link->map to give it a
more descriptive name? It's mentioned in previous commit descriptions
what it is for, but as it stands it takes some thought to realize it's
checking if this is a struct_ops item or a regular prog.

> +		WRITE_ONCE(item->kdata, bpf_struct_ops_map_kdata(pl->link->map));
> +	else
> +		WRITE_ONCE(item->prog, pl->link->link.prog);
>  }
> =20
>  static u32 prog_list_id(struct bpf_prog_list *pl)
>  {
> +	if (pl->link && pl->link->map)

Ditto.

> +		return pl->link->map->id;
>  	return prog_list_prog(pl)->aux->id;
>  }
> =20
> @@ -591,7 +657,7 @@ static void activate_effective_progs(struct cgroup *c=
grp,
>  	/* free prog array after grace period, since __cgroup_bpf_run_*()
>  	 * might be still walking the array
>  	 */
> -	bpf_cgroup_array_free(old_array);
> +	bpf_cgroup_array_free(old_array, atype);
>  }
> =20
>  /**
> @@ -631,7 +697,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
>  	return 0;
>  cleanup:
>  	for (i =3D 0; i < NR; i++)
> -		bpf_cgroup_array_free(arrays[i]);
> +		bpf_cgroup_array_free(arrays[i], i);
> =20
>  	for (p =3D cgroup_parent(cgrp); p; p =3D cgroup_parent(p))
>  		cgroup_bpf_put(p);
> @@ -686,7 +752,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
> =20
>  		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
>  			if (unlikely(desc->bpf.inactive)) {
> -				bpf_cgroup_array_free(desc->bpf.inactive);
> +				bpf_cgroup_array_free(desc->bpf.inactive, atype);
>  				desc->bpf.inactive =3D NULL;
>  			}
>  			continue;
> @@ -705,7 +771,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
>  	css_for_each_descendant_pre(css, &cgrp->self) {
>  		struct cgroup *desc =3D container_of(css, struct cgroup, self);
> =20
> -		bpf_cgroup_array_free(desc->bpf.inactive);
> +		bpf_cgroup_array_free(desc->bpf.inactive, atype);
>  		desc->bpf.inactive =3D NULL;
>  	}
> =20
> @@ -940,7 +1006,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	if (pl) {
>  		old_prog =3D pl->prog;
>  	} else {
> -		pl =3D kmalloc_obj(*pl);
> +		pl =3D kzalloc_obj(*pl);
>  		if (!pl) {
>  			bpf_cgroup_storages_free(new_storage);
>  			return -ENOMEM;
> @@ -1337,7 +1403,17 @@ static int __cgroup_bpf_query(struct cgroup *cgrp,=
 const union bpf_attr *attr,
>  	if (effective_query && prog_attach_flags)
>  		return -EINVAL;
> =20
> -	if (type =3D=3D BPF_LSM_CGROUP) {
> +	if (type =3D=3D BPF_STRUCT_OPS) {
> +		u32 type_id =3D attr->query.type_id;
> +
> +		atype =3D find_atype_by_struct_ops_id(type_id);
> +		if (atype =3D=3D CGROUP_BPF_ATTACH_TYPE_INVALID)
> +			return -ENOENT;
> +		from_atype =3D to_atype =3D atype;
> +		flags =3D 0;
> +		if (!cgroup_bpf_enabled(atype))
> +			goto skip_count;
> +	} else if (type =3D=3D BPF_LSM_CGROUP) {
>  		if (!effective_query && attr->query.prog_cnt &&
>  		    prog_ids && !prog_attach_flags)
>  			return -EINVAL;
> @@ -1363,6 +1439,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>  		}
>  	}
> =20
> +skip_count:
>  	/* always output uattr->query.attach_flags as 0 during effective query =
*/
>  	flags =3D effective_query ? 0 : flags;
>  	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
> @@ -2820,6 +2897,270 @@ const struct bpf_verifier_ops cg_sockopt_verifier=
_ops =3D {
>  const struct bpf_prog_ops cg_sockopt_prog_ops =3D {
>  };
> =20
> +static int __cgroup_struct_ops_link_detach(struct bpf_link *link, bool w=
ake_poll)
> +{
> +	struct bpf_cgroup_link *cg_link =3D container_of(link, struct bpf_cgrou=
p_link, link);
> +	enum cgroup_bpf_attach_type atype;
> +	struct bpf_prog_list *pl;
> +	struct bpf_map *map;
> +	struct cgroup *cgrp;
> +
> +	cgroup_lock();
> +
> +	cgrp =3D cg_link->cgroup;
> +	if (!cgrp) {
> +		cgroup_unlock();
> +		return 0;
> +	}
> +
> +	map =3D cg_link->map;
> +	atype =3D bpf_struct_ops_map_cgroup_atype(map);
> +
> +	hlist_for_each_entry(pl, &cgrp->bpf.progs[atype], node) {
> +		if (pl->link =3D=3D cg_link)
> +			break;
> +	}

What happens if the link isn't found here? Update deals this with
-ENOENT. Even though it's only possible if there's a bug I think
we should at least have a warning.

> +
> +	/* mark deleted so compute_effective_progs() skips it */
> +	pl->link =3D NULL;
> +	if (update_effective_progs(cgrp, atype)) {
> +		pl->link =3D cg_link;
> +		purge_effective_progs(cgrp, pl, atype);
> +	}
> +
> +	hlist_del(&pl->node);
> +	cgroup_struct_ops_link_detach_wake(cg_link, wake_poll);
> +	cgrp->bpf.revisions[atype]++;
> +
> +	kfree(pl);
> +	static_branch_dec(&cgroup_bpf_enabled_key[atype]);
> +
> +	cgroup_unlock();
> +
> +	return 0;
> +}
> +
> +static int cgroup_struct_ops_link_detach(struct bpf_link *link)
> +{
> +	return __cgroup_struct_ops_link_detach(link, true);
> +}
> +
> +static void cgroup_struct_ops_link_dealloc(struct bpf_link *link)
> +{
> +	struct bpf_cgroup_link *cg_link =3D container_of(link, struct bpf_cgrou=
p_link, link);
> +
> +	__cgroup_struct_ops_link_detach(link, false);
> +	kfree(cg_link);
> +}
> +
> +static void cgroup_struct_ops_link_show_fdinfo(const struct bpf_link *li=
nk, struct seq_file *seq)
> +{
> +	struct bpf_cgroup_link *cg_link =3D
> +		container_of(link, struct bpf_cgroup_link, link);
> +
> +	cgroup_lock();
> +	if (!cg_link->cgroup) {
> +		cgroup_unlock();
> +		return;
> +	}
> +
> +	seq_printf(seq, "map_id:\t%u\n", cg_link->map->id);
> +	seq_printf(seq, "cgroup_id:\t%llu\n", cgroup_id(cg_link->cgroup));
> +	cgroup_unlock();
> +}
> +
> +static int cgroup_struct_ops_link_fill_link_info(const struct bpf_link *=
link,
> +						 struct bpf_link_info *info)
> +{
> +	struct bpf_cgroup_link *cg_link =3D container_of(link, struct bpf_cgrou=
p_link, link);
> +
> +	cgroup_lock();
> +	if (!cg_link->cgroup) {
> +		cgroup_unlock();
> +		return 0;
> +	}
> +
> +	info->struct_ops.map_id =3D cg_link->map->id;
> +	info->struct_ops.cgroup_id =3D cgroup_id(cg_link->cgroup);
> +	cgroup_unlock();
> +	return 0;
> +}
> +
> +static int cgroup_struct_ops_link_update(struct bpf_link *link, struct b=
pf_map *new_map,
> +					 struct bpf_map *expected_old_map)
> +{
> +	struct bpf_cgroup_link *cg_link =3D container_of(link, struct bpf_cgrou=
p_link, link);
> +	enum cgroup_bpf_attach_type atype;
> +	struct bpf_prog_list *pl;
> +	struct bpf_map *old_map;
> +	struct cgroup *cgrp;
> +	bool found =3D false;
> +	int err;
> +
> +	if (!bpf_struct_ops_valid_to_reg(new_map))
> +		return -EINVAL;
> +
> +	cgroup_lock();
> +
> +	cgrp =3D cg_link->cgroup;
> +	if (!cgrp) {
> +		err =3D -ENOLINK;
> +		goto out;
> +	}
> +
> +	old_map =3D cg_link->map;
> +	err =3D bpf_struct_ops_link_update_check(new_map, old_map, expected_old=
_map);
> +	if (err)
> +		goto out;
> +
> +	atype =3D bpf_struct_ops_map_cgroup_atype(new_map);
> +
> +	hlist_for_each_entry(pl, &cgrp->bpf.progs[atype], node) {
> +		if (pl->link =3D=3D cg_link) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		err =3D -ENOENT;
> +		goto out;
> +	}
> +
> +	bpf_map_inc(new_map);
> +	WRITE_ONCE(cg_link->map, new_map);
> +	replace_effective_prog(cgrp, atype, pl);
> +	bpf_map_put(old_map);
> +	cgrp->bpf.revisions[atype]++;
> +
> +out:
> +	cgroup_unlock();
> +	return err;
> +}
> +
> +static __poll_t cgroup_struct_ops_link_poll(struct file *file, struct po=
ll_table_struct *pts)
> +{
> +	struct bpf_cgroup_link *link =3D file->private_data;
> +
> +	poll_wait(file, &link->wait_hup, pts);
> +
> +	return READ_ONCE(link->map) ? 0 : EPOLLHUP;
> +}
> +
> +static const struct bpf_link_ops cgroup_struct_ops_link_ops =3D {
> +	.dealloc =3D cgroup_struct_ops_link_dealloc,
> +	.detach =3D cgroup_struct_ops_link_detach,
> +	.show_fdinfo =3D cgroup_struct_ops_link_show_fdinfo,
> +	.fill_link_info =3D cgroup_struct_ops_link_fill_link_info,
> +	.update_map =3D cgroup_struct_ops_link_update,
> +	.poll =3D cgroup_struct_ops_link_poll,
> +};
> +
> +int cgroup_bpf_struct_ops_attach(struct bpf_map *map, const union bpf_at=
tr *attr)
> +{
> +	u32 flags =3D attr->link_create.flags;
> +	u32 pl_flags =3D (flags & BPF_F_PREORDER) | BPF_F_ALLOW_MULTI;
> +	enum cgroup_bpf_attach_type atype;
> +	struct bpf_link_primer link_primer;
> +	struct bpf_cgroup_link *link;
> +	struct bpf_prog_list *pl =3D NULL;
> +	struct hlist_head *progs;
> +	struct cgroup *cgrp;
> +	int err;
> +
> +	if (flags & ~BPF_F_LINK_ATTACH_MASK)
> +		return -EINVAL;
> +
> +	/*
> +	 * Attaching struct_ops to cgroup is through link only. All relative
> +	 * position must be corresponding to a link id or fd.
> +	 */
> +	if (attr->link_create.cgroup.relative_fd && !(flags & BPF_F_LINK))
> +		return -EINVAL;
> +
> +	link =3D kzalloc_obj(*link, GFP_USER);
> +	if (!link)
> +		return -ENOMEM;
> +
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
> +		      &cgroup_struct_ops_link_ops, NULL,
> +		      attr->link_create.attach_type);
> +
> +	err =3D bpf_link_prime(&link->link, &link_primer);
> +	if (err) {
> +		kfree(link);
> +		return err;
> +	}
> +
> +	cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
> +	if (IS_ERR(cgrp)) {
> +		err =3D PTR_ERR(cgrp);
> +		goto cleanup;
> +	}
> +
> +	bpf_map_inc(map);
> +	link->map =3D map;
> +	link->cgroup =3D cgrp;
> +	init_waitqueue_head(&link->wait_hup);
> +
> +	atype =3D bpf_struct_ops_map_cgroup_atype(map);
> +	progs =3D &cgrp->bpf.progs[atype];
> +
> +	cgroup_lock();
> +
> +	if (attr->link_create.cgroup.expected_revision &&
> +	    attr->link_create.cgroup.expected_revision !=3D cgrp->bpf.revisions=
[atype]) {
> +		err =3D -ESTALE;
> +		goto unlock;
> +	}
> +
> +	if (prog_list_length(progs, NULL) >=3D BPF_CGROUP_MAX_PROGS) {
> +		err =3D -E2BIG;
> +		goto unlock;
> +	}
> +
> +	pl =3D kzalloc_obj(*pl);
> +	if (!pl) {
> +		err =3D -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	pl->link =3D link;
> +	pl->flags =3D pl_flags;
> +	cgrp->bpf.flags[atype] =3D BPF_F_ALLOW_MULTI;
> +
> +	err =3D insert_pl_to_hlist(pl, progs, NULL, link,
> +				 flags | BPF_F_ALLOW_MULTI, attr->link_create.cgroup.relative_fd);
> +	if (err)
> +		goto unlock;
> +
> +	err =3D update_effective_progs(cgrp, atype);
> +	if (err) {
> +		hlist_del(&pl->node);
> +		goto unlock;
> +	}
> +
> +	cgrp->bpf.revisions[atype]++;
> +	static_branch_inc(&cgroup_bpf_enabled_key[atype]);
> +
> +	cgroup_unlock();
> +
> +	return bpf_link_settle(&link_primer);
> +
> +unlock:
> +	cgroup_unlock();
> +
> +cleanup:
> +	kfree(pl);
> +	if (link->cgroup) {
> +		cgroup_put(link->cgroup);
> +		link->cgroup =3D NULL;
> +		bpf_map_put(link->map);
> +		link->map =3D NULL;
> +	}
> +	bpf_link_cleanup(&link_primer);
> +	return err;
> +}
> +
>  /* Common helpers for cgroup hooks. */
>  const struct bpf_func_proto *
>  cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b07acf37ad1d..b439c0b0eadd 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4813,6 +4813,7 @@ static int bpf_prog_query(const union bpf_attr *att=
r,
>  	case BPF_CGROUP_GETSOCKOPT:
>  	case BPF_CGROUP_SETSOCKOPT:
>  	case BPF_LSM_CGROUP:
> +	case BPF_STRUCT_OPS:
>  		return cgroup_bpf_prog_query(attr, uattr, uattr_size);
>  	case BPF_LIRC_MODE2:
>  		return lirc_prog_query(attr, uattr);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index c91b5a4bda03..c982801ec7db 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1756,7 +1756,7 @@ union bpf_attr {
>  			__u32	prog_cnt;
>  			__u32	count;
>  		};
> -		__u32		:32;
> +		__u32		type_id;
>  		/* output: per-program attach_flags.
>  		 * not allowed to be set during effective query.
>  		 */
> @@ -6818,6 +6818,8 @@ struct bpf_link_info {
>  		} xdp;
>  		struct {
>  			__u32 map_id;
> +			__u32 :32;
> +			__u64 cgroup_id;
>  		} struct_ops;
>  		struct {
>  			__u32 pf;


