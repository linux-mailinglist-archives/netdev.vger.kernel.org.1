Return-Path: <netdev+bounces-307370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MrnyIBLcVWrRuQAAu9opvQ
	(envelope-from <netdev+bounces-307370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192D751A34
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:49:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=Er57vmrK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307370-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307370-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A626D3054E98
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A903E317C;
	Tue, 14 Jul 2026 06:48:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A932B13A
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:48:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011728; cv=none; b=iliMr64OOrYK03ig3sbYlGA4ISFGB1O8FGZKl/YU5dHYsKqmHUDw+39XlFQAgyb7V/xtIPXGheWy/OSl0BnEiOX+LorflOIvU7nAySMmFYzSO0jjTNkujau1Y0rINigYMIzWs2S8ik464A9tJ3jq7IY36yicpE0n/4unx/jiJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011728; c=relaxed/simple;
	bh=NJ8VYfB8Jr5+sg1VMglKWIejQlRsy56IfKkfUaf39dU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R3v2GMRCsxMXrMyCXkZukdgxD1n/v8ummdysu8r1q26FM2w1sH3wVKFw8k2LXxEwUf/pd97Fd78R3URij6eGjZN4ugUmhQ607e188zH02Xy1pFYor4AOpbJghl6Yq8Q72d5zG8djpzjkbOVNkouSWD6ff90SpBCNfPrjVDZts6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Er57vmrK; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381891a9525so4332948a91.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784011725; x=1784616525; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ekJ6euKjcodMZqS6RtCgnihmtB9IxwOQ6iil8jfqkrc=;
        b=Er57vmrKymvXXhz56y48gdhAupzThGT6qQszoAc9gHjsl3Hc2h+pgeD/QjhoER8xT1
         7NwerSpBe6TYwbiASIgBeF//NMRFQZuD3qqW2G2dAObMPo5G27FGwdIcIV3r8XeZJ4TE
         kRScjrlkWv1qk7AsNCIP7mtNF4No0KXaU5DF4/5cA6vwADFBhz2YNHz/aWfja3Q6qJ5Y
         qk9R69m90dXBWOlF/xyDwBncmT0ASAcT1NaFgOVP7jrRbP6YQu/QBnetvAcwhZo1CYjD
         mxGEdNP3nYQIiMYfnv/j7Lz0L6TX+hvPL1dFqRxkAZkswUSVDDkgMXEnGNPOMHLr5+oU
         Mxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011725; x=1784616525;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekJ6euKjcodMZqS6RtCgnihmtB9IxwOQ6iil8jfqkrc=;
        b=nPsb1tDbua+8ZtH3Xb9UR1ghq4HlDdn2Waa3zQsoJ9U9Ac1Xk45CpMrWK2JT7bMPhs
         jzETVNB7ZtlIWNBlohCKjOZhymsFMxMQK02RGICALLvFewq3LaLk1ab3Cm797ypmcrsw
         h916s1LAA31erwXtO3lx8sbEHYWrC9lSJaPd/R1d4ncikQ73ccEbd3E+epL9TERKaQUi
         DaP2A3Qh7rX0BI1kSKA6vRJbEkJY/s8WXREO504CqvIqcW/oiPKsPTe0eHmR+1IJyWSR
         YfLizBdfBOYiNkQq7Ul1VM3qPr5C+88K1llWkeLbvx//W9Z/pV1/zEISz974sIykmPfd
         O5/Q==
X-Gm-Message-State: AOJu0YwXrj6DTm+ZRTBz6vIRInenRizsI6JO1mDwQyZWNDgkfWur+BIi
	l9hRG18X/iFg//QwH+vmN7l4Z4wo67y1PLoiP1vROg0goOQPQNtWzs3lW+kcuILf5KY=
X-Gm-Gg: AfdE7cnZvm66bV2yBW8LSFv0Gzd0oRPFCvcCjUcXwoLm6uDINf3eVxVob/O7gk/HoV1
	dJ7qJSO5wzlymenVfyubCT1SodEe/7dsoleru3xEWguExiy6AsNpwAZLztCc/es8pJ7oG+S/AVp
	jn6atHWYcXqTiWddAQX+Cjbig3zsnrQ+n7KggS/xZI0Pt9iTi3EDCjONFaZtXRn/ZNgYfsiQs6K
	6bjwmlb5ob6pSfiqHhavh9PV6GSY6TBIsMEMwibComU1iiqhf6psnRGf7ool7QcWkUQxndHMalD
	XG8k7B/9EUu4Ko3AWp+ObZJR+MPkc16bMk8u+KhUlMx4+uwV7TO0u/DiNcg+Fic58SamT4480Fr
	e7Tn3wXNt9gRDhU7DebntrrJC6l9OfoW6eJmOsDvpqC7O/Ejw34aTwtQ0bCmxJWR/01h8oqwKI+
	htF3rR47uKqJ5DPjAm273FxSIJ3nzbWBbiJ58OHWcmRA==
X-Received: by 2002:a17:90b:4a4a:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38e1ae31638mr1112432a91.16.1784011725467;
        Mon, 13 Jul 2026 23:48:45 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e173084c9sm966663a91.13.2026.07.13.23.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 02:48:44 -0400
Message-Id: <DJY3DJSWEMPW.3ODE44OQVL7J3@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 13/15] libbpf: Support attaching struct_ops
 to a cgroup
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-14-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-14-ameryhung@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307370-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3192D751A34

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Add bpf_map__attach_cgroup_opts() to attach a struct_ops map to a cgroup
> through a BPF link.
>
> Also extend struct bpf_prog_query_opts with a type_id field so a
> BPF_STRUCT_OPS query on a cgroup can select the struct_ops type to
> enumerate.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/lib/bpf/bpf.c      |  2 ++
>  tools/lib/bpf/bpf.h      |  3 +-
>  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  3 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 96819c082c77..a9de7f107cf7 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -934,6 +934,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>  	case BPF_CGROUP_GETSOCKOPT:
>  	case BPF_CGROUP_SETSOCKOPT:
>  	case BPF_LSM_CGROUP:
> +	case BPF_STRUCT_OPS:
>  		relative_fd =3D OPTS_GET(opts, cgroup.relative_fd, 0);
>  		relative_id =3D OPTS_GET(opts, cgroup.relative_id, 0);
>  		if (relative_fd && relative_id)
> @@ -1056,6 +1057,7 @@ int bpf_prog_query_opts(int target, enum bpf_attach=
_type type,
>  	attr.query.attach_type		=3D type;
>  	attr.query.query_flags		=3D OPTS_GET(opts, query_flags, 0);
>  	attr.query.count		=3D OPTS_GET(opts, count, 0);
> +	attr.query.type_id		=3D OPTS_GET(opts, type_id, 0);
>  	attr.query.prog_ids		=3D ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
>  	attr.query.link_ids		=3D ptr_to_u64(OPTS_GET(opts, link_ids, NULL));
>  	attr.query.prog_attach_flags	=3D ptr_to_u64(OPTS_GET(opts, prog_attach_=
flags, NULL));
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 7534a593edae..490e8cb4ba53 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -637,9 +637,10 @@ struct bpf_prog_query_opts {
>  	__u32 *link_ids;
>  	__u32 *link_attach_flags;
>  	__u64 revision;
> +	__u32 type_id;
>  	size_t :0;
>  };
> -#define bpf_prog_query_opts__last_field revision
> +#define bpf_prog_query_opts__last_field type_id
> =20
>  /**
>   * @brief **bpf_prog_query_opts()** queries the BPF programs and BPF lin=
ks
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7162146280a8..50a83b9217e4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -14104,6 +14104,70 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
>  	return &link->link;
>  }
> =20
> +struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map, =
int cgroup_fd,
> +					     const struct bpf_cgroup_opts *opts)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
> +	struct bpf_link_struct_ops *link;
> +	__u32 relative_id, zero =3D 0;
> +	int err, fd, relative_fd;
> +
> +	if (!OPTS_VALID(opts, bpf_cgroup_opts))
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	if (!bpf_map__is_struct_ops(map)) {
> +		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	if (map->fd < 0) {
> +		pr_warn("map '%s': can't attach BPF map without FD (was it created?)\n=
", map->name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	if (!(map->def.map_flags & BPF_F_LINK)) {
> +		pr_warn("map '%s': can't attach to cgroup without BPF_F_LINK\n", map->=
name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	relative_id =3D OPTS_GET(opts, relative_id, 0);
> +	relative_fd =3D OPTS_GET(opts, relative_fd, 0);
> +
> +	if (relative_fd && relative_id) {
> +		pr_warn("map '%s': relative_fd and relative_id cannot be set at the sa=
me time\n",
> +			map->name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	link_create_opts.cgroup.expected_revision =3D OPTS_GET(opts, expected_r=
evision, 0);
> +	link_create_opts.cgroup.relative_fd =3D relative_fd;
> +	link_create_opts.cgroup.relative_id =3D relative_id;
> +	link_create_opts.flags =3D OPTS_GET(opts, flags, 0);
> +
> +	link =3D calloc(1, sizeof(*link));
> +	if (!link)
> +		return libbpf_err_ptr(-ENOMEM);
> +
> +	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
> +	if (err && err !=3D -EBUSY) {
> +		free(link);
> +		return libbpf_err_ptr(err);
> +	}
> +
> +	link->link.detach =3D bpf_link__detach_struct_ops;
> +
> +	fd =3D bpf_link_create(map->fd, cgroup_fd, BPF_STRUCT_OPS, &link_create=
_opts);
> +	if (fd < 0) {
> +		free(link);
> +		return libbpf_err_ptr(fd);
> +	}
> +
> +	link->link.fd =3D fd;
> +	link->map_fd =3D map->fd;
> +
> +	return &link->link;
> +}
> +
>  /*
>   * Swap the back struct_ops of a link with a new struct_ops map.
>   */
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..0e5f4e9bba41 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -960,6 +960,9 @@ bpf_program__attach_cgroup_opts(const struct bpf_prog=
ram *prog, int cgroup_fd,
>  struct bpf_map;
> =20
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> +LIBBPF_API struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf=
_map *map,
> +							int cgroup_fd,
> +							const struct bpf_cgroup_opts *opts);
>  LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
> =20
>  struct bpf_iter_attach_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b731df19ae69..5131fdb979b7 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -461,4 +461,5 @@ LIBBPF_1.8.0 {
>  		bpf_program__attach_tracing_multi;
>  		bpf_program__clone;
>  		btf__new_empty_opts;
> +		bpf_map__attach_cgroup_opts;
>  } LIBBPF_1.7.0;


