Return-Path: <netdev+bounces-307280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B70PG5pMVWo4mgAAu9opvQ
	(envelope-from <netdev+bounces-307280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 22:37:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4F74F167
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 22:37:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=aVhe5oLf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307280-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5FDA3092954
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 20:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9935DA6E;
	Mon, 13 Jul 2026 20:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374135DA5D
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 20:36:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975009; cv=none; b=Ig9shX94V7ca37uGcLn54Yg+EsXfulDVO/QGcffEdJUT0NV5tiK5DBKpFgjEo4Fo7NF7zoSWANHcxle7IX/t5pKQSgWQIEWBA1Bzg1fJrU3g07TNnnddc1cQKyhxxMMss5f1kcgphFqtV0DmsATKZKdPuZefTiAU10j31yGpMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975009; c=relaxed/simple;
	bh=5jnI160PD6NoJyLE84124ODRex2IYM8wMXi/A/p2b50=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KvxVmGFOdSEW1NOPDqcSXC80goSbSnd/WeLZaB8pZLFxlwr1xPzAjvh5Vm3y4S1TmvdwhI9xgJd5GILaMhNjm/9M5hcrmvzRJTdzXoasoAdnECfDa4+KlpH0RsCEU+Q5K+TMMHvkWcq66F4JwZ8S5wCrQjaADbJUuMdtny88mFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=aVhe5oLf; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc6dd436c6so2674525ad.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783975006; x=1784579806; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cli8DuotM7hy9fOe+TOwORbYCRQrrtgQLQxvRHzLU+g=;
        b=aVhe5oLfkRZyP9bAUZD1GTDcAou+wQazra1nC6w/k1DCyx0iL1Gf80A9GKJhRV30ui
         UUWiofo9E/QzPTi6pZna/h0smVAQRrWGpoPJ2mLe1fNbS4vbDkff0P7jLRQE1OdoHSLd
         VmnVRBgA+SXc7KFW4cO3hnRKTF1ntiBQkfBSDIb0FOgsVnECdG2OyA/zvpKEv5V6wxub
         yxgRt3+zDlXUUrL74S5pRKCqlmPiZaME02oteAAUza9mWJEEjB6122QDjpCxIyaa/JMc
         MtUZgi2HJC2wKuMh7fVrJz69pT39PgV71P8FD+9l2Ed5GmgOOOSdJ0vZL1zjL3a5Up0Z
         KETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783975006; x=1784579806;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cli8DuotM7hy9fOe+TOwORbYCRQrrtgQLQxvRHzLU+g=;
        b=svBKyGX4qFbEG/vue6KzskaKhrjSdK7xZP8ak+06R1CLe+XfhDXkE4ayYyJke+Joy9
         ClO1hr2cZz2qQzUPN1Qz9kNFJUxlzl7y7B3wpOkCqf1XcPOeN+CuQt/zLwK9cwev6q9J
         zcsauiNFGRyQu0JujMeLDLDI4ijOTR+eaD6L/uW3BmhKw+yInsysdXufJx+vbEYDFPs+
         n8RghWO57wAoHFunF2HAn4IVhkUhVyHZjlodjguZhHB5yTo9HCynjSEbHA8O+nrGvN33
         82WZQTVAZCde6KbvLGX60xh3QHHa1S00DHh6PlqtXc6ypKQ6kICrFJye+cV9+sLG4tz/
         bwQw==
X-Gm-Message-State: AOJu0YyCyP3O01WqGdkXmmnwa9w3NtRmOyUPKpJz2YwwZjTZ/9SZNpLq
	X4YA2G6yw4PLAp4q9yK+TOsrCcthYFgX74qdM1T12CZP6WAJO1PefTQ/tk+1I5CkpunqAPTD/xn
	LW/kAT/E=
X-Gm-Gg: AfdE7clRAMbURMFg6ZBhuIRI5RxpuMBqDYlLhoH77HiVUDWUH27U4FOeCmbsCxit/6Q
	FOvXuanNuHtOa/odp51ceCHmA9hxJM4VTGxDHOWuR/tg0LzOafR0ZyXhBOhUsHfsNAsivhHRptq
	0wCEbaYBPoXrBGAWIJ6vU4yJXGn8wggqCc+XF+Vfrx8o+etc7+mfiATFawopNsrCV4VSTkZuLTe
	HgjfKvHFum9Ai6LN7ZLuMbeTlIvhtltxHm9f6rQSy58fUfE/q9K+NivFV2jEqrCzCvpNuflJeNf
	sqae/aw1o2SgBDgC/JI6gon7yaOsaJuru7+u0ll+GOLZIb22jYTEs1SAhWz2I16jlNNeaKIc4St
	asgPSmu9T8lKZBhUQSGd1mxJmHXV8TKSymI0TqX2edj6xjNqcAP7JfrO9rRhH3A/xcj5Qab/+7a
	UHrHq9ieEWYtB8TxkXWyuD64NXssUhI8ex9xVTnESHoQ==
X-Received: by 2002:a17:902:d552:b0:2cb:2b53:559f with SMTP id d9443c01a7336-2ce9f3a4910mr103562475ad.35.1783975006505;
        Mon, 13 Jul 2026 13:36:46 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm104314865ad.65.2026.07.13.13.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 13:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 16:36:44 -0400
Message-Id: <DJXQCZA5YIMR.I9BWPXFXAMQ7@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 03/15] bpf: Add bpf_struct_ops accessor
 helpers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-4-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-4-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-307280-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FE4F74F167

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Add the helper functions bpf_struct_ops_map_kdata() and
> bpf_struct_ops_map_cfi_stubs() in bpf_struct_ops.c. They will be called
> from cgroup.c in the upcoming patch to create a struct_ops to cgroup
> attachment link.
>
> bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
> in cgroup.c.
>
> The link update validation is also refactored into a new function
> bpf_struct_ops_link_update_check() such that it can be reused by the
> caller in cgroup.c in the upcoming patch.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h         | 28 ++++++++++++++++++++
>  kernel/bpf/bpf_struct_ops.c | 53 +++++++++++++++++++++++++++----------
>  2 files changed, 67 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7ac8873839f4..047ffc029666 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2252,6 +2252,12 @@ u32 bpf_struct_ops_id(const void *kdata);
>  int bpf_struct_ops_for_each_prog(const void *kdata,
>  				 int (*cb)(struct bpf_prog *prog, void *data),
>  				 void *data);
> +void *bpf_struct_ops_map_kdata(struct bpf_map *map);
> +u32 bpf_struct_ops_kdata_map_id(void *kdata);
> +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
> +bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
> +int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf=
_map *old_map,
> +				     struct bpf_map *expected_old_map);
> =20
>  #ifdef CONFIG_NET
>  /* Define it here to avoid the use of forward declaration */
> @@ -2316,6 +2322,28 @@ static inline void bpf_map_struct_ops_info_fill(st=
ruct bpf_map_info *info, struc
>  static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_des=
c *st_ops_desc)
>  {
>  }
> +static inline void *bpf_struct_ops_map_kdata(struct bpf_map *map)
> +{
> +	return NULL;
> +}
> +static inline u32 bpf_struct_ops_kdata_map_id(void *kdata)
> +{
> +	return 0;
> +}
> +static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> +{
> +	return NULL;
> +}
> +static inline bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
> +{
> +	return false;
> +}
> +static inline int bpf_struct_ops_link_update_check(struct bpf_map *new_m=
ap,
> +						   struct bpf_map *old_map,
> +						   struct bpf_map *expected_old_map)
> +{
> +	return -EOPNOTSUPP;
> +}
> =20
>  #endif
> =20
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index c422ce41873e..3d650a7e9f68 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1236,7 +1236,23 @@ int bpf_struct_ops_for_each_prog(const void *kdata=
,
>  }
>  EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
> =20
> -static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
> +void *bpf_struct_ops_map_kdata(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> +	return st_map->kvalue.data;
> +}
> +
> +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> +	return st_map->st_ops_desc->st_ops->cfi_stubs;
> +}
> +
> +bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
>  {
>  	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
> =20
> @@ -1289,6 +1305,26 @@ static int bpf_struct_ops_map_link_fill_link_info(=
const struct bpf_link *link,
>  	return 0;
>  }
> =20
> +int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
> +				     struct bpf_map *old_map,
> +				     struct bpf_map *expected_old_map)
> +{
> +	struct bpf_struct_ops_map *st_map, *old_st_map;
> +
> +	if (!old_map)
> +		return -ENOLINK;
> +	if (expected_old_map && old_map !=3D expected_old_map)
> +		return -EPERM;
> +
> +	st_map =3D container_of(new_map, struct bpf_struct_ops_map, map);
> +	old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, map);
> +	/* The new and old struct_ops must be the same type. */
> +	if (st_map->st_ops_desc !=3D old_st_map->st_ops_desc)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map,
>  					  struct bpf_map *expected_old_map)
>  {
> @@ -1307,23 +1343,12 @@ static int bpf_struct_ops_map_link_update(struct =
bpf_link *link, struct bpf_map
>  		return -EOPNOTSUPP;
> =20
>  	mutex_lock(&update_mutex);
> -
>  	old_map =3D st_link->map;
> -	if (!old_map) {
> -		err =3D -ENOLINK;
> -		goto err_out;
> -	}
> -	if (expected_old_map && old_map !=3D expected_old_map) {
> -		err =3D -EPERM;
> +	err =3D bpf_struct_ops_link_update_check(new_map, old_map, expected_old=
_map);
> +	if (err)
>  		goto err_out;
> -	}
> =20
>  	old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, map);
> -	/* The new and old struct_ops must be the same type. */
> -	if (st_map->st_ops_desc !=3D old_st_map->st_ops_desc) {
> -		err =3D -EINVAL;
> -		goto err_out;
> -	}
> =20
>  	err =3D st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st=
_map->kvalue.data, link);
>  	if (err)


