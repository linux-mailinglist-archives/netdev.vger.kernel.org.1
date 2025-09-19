Return-Path: <netdev+bounces-224917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A121DB8B772
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF315A76E3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26CA2D2497;
	Fri, 19 Sep 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjuE7i6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FF2857D2
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758320577; cv=none; b=LKqwczdNLjj6yPK1V/s8IKHJew3SN5BJlYDlDCJBBf0KAbkxP4gyWCGo6o+NGENyQFCyjuxacw8AyMjdgGLE9s9qn9GBhxb+hRYzshl7iPFkI/WdXYcZCK9b3sBYQhlZTcjpcaowdHSX4z8r9+0NjVHgki7mIytx15RijCdnBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758320577; c=relaxed/simple;
	bh=IIFhRI+TsAvfZeudshXo/wh+vjAohK8Azb1V5DPNy1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt3MsCs6DAl+CE/4wtixjvLaalHgwIqydzapMIy70XKAaW4YO3vjES6WdaziVSb4emdGeD3crK94Xpc9bM7kTLRtTJfkBWFZeMz/PhrZ+I7h9IV7YB1azIZS81Hmnh0Zepfwkeq8aCYxaXy6sV7KJuST88hsvmalptqpqswxIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjuE7i6c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so2470824a91.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758320576; x=1758925376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVttn2DL6ng5pXY1yjZwV7ysZJbj/h4XmkfTp1L7SEY=;
        b=fjuE7i6cq82w5A2FP1tYBkDoCPnfg/eHw14jY1pUMVxStk+Fd027yGDAYhcZx9O+A0
         foeL5IQi7v8bWuzxXO97smPqN5oUGrC0pEtbnYVSidpJvxRW7hzMK7q6cZH45YLihJXv
         KvE8C6kw5kW5LcHMmIvLy9TcK45+NRae3k/LyfTl67ncAb4COUYw4KLO/p1OKZHuS1m4
         Z3apRnLo7tm9iwaq7Np+a01d/tjudplw96pcWLtXO5a3B6NmiLDiXEi9bzFgDa+c9WAj
         tKyw0LJmhCzjc7O8DEwGm2zzIjUMNlqANyAPJyuzO5zXJUluh37H5OZmPND5+us1DXPs
         dlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758320576; x=1758925376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVttn2DL6ng5pXY1yjZwV7ysZJbj/h4XmkfTp1L7SEY=;
        b=sba5JG2uGctyp6uFg+c4n9gQj65T6agO/ZkAYFF2ct8pWuufEvtzolQ91pa2DS+WJK
         uc+MNLixBKBxLZfi72bqeaNUihp8PcX+m05oPgrmk7imSckPxU7ve/s1NQEQ0/44xbxv
         r2mXvMev92I0kC5hWvJmKY3aNEMU3U+JYLHMdMbi7w/Emse4TQOr1EZlMZv8zcVNzK0w
         t1fz1VfOOLT2Q28QVro96aN+EOT2+p5T1fFsotN1tE3ZMbFx9i6zhSYNph3yi1BknOyV
         MzU7RvGwbGBBPYfEY3VLfWSB3h6oPdYt0HXo4p1LmOwFVpaL1v/Efcj5dMEdFvmokoG7
         DhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmst5c4BMdzOagyS0qsvhD2ayfekjYdRyu7Y/qjaQsklMuPvMksRuOBossicQcnXVSiPCrJn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/e5y4BDyR26F3y2HGY5ItarYyFUNwkHjtuYsn2J2RCrS3c92Y
	bcsIDi2q/t8OktxRiuvJ/tpqULrefySHFMdE9pHa9mDYs/5YxRreC3CP9KzxYTZ8fXpQfu/6lsp
	9T4LL1K84RA3sGwK0pU0UcTigmKaDjPM=
X-Gm-Gg: ASbGnct3OC2A447G0FKP6aHNpypmMh7DrqDc3+NOv0wYoX+p8DtOTy1n9sDEVe6a/bp
	M6cC51W8tc32NYChAj979uLQY454cZsbQQwEonysh0gAFdA7lS0Wh1L0P3WJM5imo2Zb0UW2z4n
	P4w/btODs2QGK16lmxdbf5yGuO/XxvHf2yfXBBQXGHoBIKVWYJgPchunFxRbGeRCW6rIVBlycXX
	OL97N7DIsTZi7VbbY2r/0E=
X-Google-Smtp-Source: AGHT+IFTIxD0jJKO5G+pCCu1K6n7tVBYK28In98bQte8IZQWbsnwJnU5AjMBK6qo5Bs//UE/GcpJn8fuw07r+SjjOXU=
X-Received: by 2002:a17:90b:5623:b0:32e:ca03:3ba with SMTP id
 98e67ed59e1d1-3309834c0afmr5496340a91.22.1758320575534; Fri, 19 Sep 2025
 15:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918080342.25041-1-alibuda@linux.alibaba.com> <20250918080342.25041-4-alibuda@linux.alibaba.com>
In-Reply-To: <20250918080342.25041-4-alibuda@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:22:41 -0700
X-Gm-Features: AS18NWAZO1oRArFwgyo_d1_MJyN-C4gXYDi5ATwBewZOaAmKd2Jx5fB2DEmP76o
Message-ID: <CAEf4BzY5oowUpq2x3Uz+TNi=8GJgc1FDzS-u5UqZwNXvkWtSEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: fix error when st-prefix_ops and
 ops from differ btf
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, sdf@google.com, 
	haoluo@google.com, yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com, 
	wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:03=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> When a struct_ops named xxx_ops was registered by a module, and
> it will be used in both built-in modules and the module itself,
> so that the btf_type of xxx_ops will be present in btf_vmlinux
> instead of in btf_mod, which means that the btf_type of
> bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.
>
> Here are four possible case:
>
> +--------+---------------+-------------+---------------------------------=
+
> |        | st_ops_xxx_ops| xxx_ops     |                                 =
|
> +--------+---------------+-------------+---------------------------------=
+
> | case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmlinux =
|
> +--------+---------------+-------------+---------------------------------=
+
> | case 1 | btf_vmlinux   | bpf_mod     | INVALID                         =
|
> +--------+---------------+-------------+---------------------------------=
+
> | case 2 | btf_mod       | btf_vmlinux | reg in mod but be used both in  =
|
> |        |               |             | vmlinux and mod.                =
|
> +--------+---------------+-------------+---------------------------------=
+
> | case 3 | btf_mod       | btf_mod     | be used and reg only in mod     =
|
> +--------+---------------+-------------+---------------------------------=
+
>
> At present, cases 0, 1, and 3 can be correctly identified, because
> st_ops_xxx_ops is searched from the same btf with xxx_ops. In order to
> handle case 2 correctly without affecting other cases, we cannot simply
> change the search method for st_ops_xxx_ops from find_btf_by_prefix_kind(=
)
> to find_ksym_btf_id(), because in this way, case 1 will not be
> recognized anymore.
>
> To address the issue, we always look for st_ops_xxx_ops first,
> figure out the btf, and then look for xxx_ops with the very btf to avoid

What's "very btf"? Commit message would benefit from a little bit of
proof-reading, if you can. It's a bit hard to follow, even if it's
more or less clear at the end what problem you are trying to solve.

Also, I'd suggest to send this fix as a separate patch and not block
it on the overall patch set, which probably will take longer. This fix
is independent, so we can land it much faster.

> such issue.
>
> Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fe4fc5438678..50ca13833511 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1013,35 +1013,34 @@ find_struct_ops_kern_types(struct bpf_object *obj=
, const char *tname_raw,
>         const struct btf_member *kern_data_member;
>         struct btf *btf =3D NULL;
>         __s32 kern_vtype_id, kern_type_id;
> -       char tname[256];
> +       char tname[256], stname[256];
>         __u32 i;
>
>         snprintf(tname, sizeof(tname), "%.*s",
>                  (int)bpf_core_essential_name_len(tname_raw), tname_raw);
>
> -       kern_type_id =3D find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
> -                                       &btf, mod_btf);
> -       if (kern_type_id < 0) {
> -               pr_warn("struct_ops init_kern: struct %s is not found in =
kernel BTF\n",
> -                       tname);
> -               return kern_type_id;
> -       }
> -       kern_type =3D btf__type_by_id(btf, kern_type_id);
> +       snprintf(stname, sizeof(stname), "%s%.*s", STRUCT_OPS_VALUE_PREFI=
X,
> +                (int)strlen(tname), tname);
>
> -       /* Find the corresponding "map_value" type that will be used
> -        * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
> -        * find "struct bpf_struct_ops_tcp_congestion_ops" from the
> -        * btf_vmlinux.
> +       /* Look for the corresponding "map_value" type that will be used
> +        * in map_update(BPF_MAP_TYPE_STRUCT_OPS) first, figure out the b=
tf
> +        * and the mod_btf.
> +        * For example, find "struct bpf_struct_ops_tcp_congestion_ops".
>          */
> -       kern_vtype_id =3D find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_P=
REFIX,
> -                                               tname, BTF_KIND_STRUCT);
> +       kern_vtype_id =3D find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT, =
&btf, mod_btf);
>         if (kern_vtype_id < 0) {
> -               pr_warn("struct_ops init_kern: struct %s%s is not found i=
n kernel BTF\n",
> -                       STRUCT_OPS_VALUE_PREFIX, tname);
> +               pr_warn("struct_ops init_kern: struct %s is not found in =
kernel BTF\n", stname);
>                 return kern_vtype_id;
>         }
>         kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
>
> +       kern_type_id =3D btf__find_by_name_kind(btf, tname, BTF_KIND_STRU=
CT);
> +       if (kern_type_id < 0) {
> +               pr_warn("struct_ops init_kern: struct %s is not found in =
kernel BTF\n", tname);
> +               return kern_type_id;
> +       }
> +       kern_type =3D btf__type_by_id(btf, kern_type_id);
> +
>         /* Find "struct tcp_congestion_ops" from
>          * struct bpf_struct_ops_tcp_congestion_ops {
>          *      [ ... ]
> @@ -1054,8 +1053,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, =
const char *tname_raw,
>                         break;
>         }
>         if (i =3D=3D btf_vlen(kern_vtype)) {
> -               pr_warn("struct_ops init_kern: struct %s data is not foun=
d in struct %s%s\n",
> -                       tname, STRUCT_OPS_VALUE_PREFIX, tname);
> +               pr_warn("struct_ops init_kern: struct %s data is not foun=
d in struct %s\n",
> +                       tname, stname);
>                 return -EINVAL;
>         }
>
> --
> 2.45.0
>

