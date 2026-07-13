Return-Path: <netdev+bounces-307289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gjNjMfpeVWrunQAAu9opvQ
	(envelope-from <netdev+bounces-307289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:56:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A89874F5DF
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=os7ekhiZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307289-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307289-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF38A3034568
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D787365A1D;
	Mon, 13 Jul 2026 21:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64993644C3
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:56:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979767; cv=none; b=WUVUpcSLJNd3EuvDux1nZ7gpzJpSZc3WwishdIl43mb5plSq59sHyaEWP4Mo6pNaxNvAsluaSXKdk+Hp1d472RJaO1D/rCc0fWNVGZwMi8gujJqvJPO++wZFr5ZN//CAFLolN0EE3ZVOL+RjQdBc5UcNEN9Z4+Qa/bQ2Y+em99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979767; c=relaxed/simple;
	bh=9yS1UvlUrfI9KheCLuEuSRoWZobPi0nd+1A15hyorw8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=mxImZ8b4qtdgLneHQyIa3S24hwTXMkE0NNFsyRxLUu4myU7T1v1SfoLYJq1FBSfTWQoaX7Fy/SMzsmL+J8rdEbUXWNeiPe5Hga8LhW/0V1EuZ9aIJ+aaxm6SL8m+FBcvZlLiO2+QDyAd9QAUzhVJPbv3dBBCHrZysFkErmTO1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=os7ekhiZ; arc=none smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-667923d86a7so579748d50.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783979765; x=1784584565; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D6Y7Xe1SbiMFbOzf01pbOyxaH8rw40mxymdbfU2kNyQ=;
        b=os7ekhiZDGavtmRRl9GwUziMCOAI/yo63YIAgHLVusNkcEPCq5Yx8wN+VM7+HebJum
         +3q4AL3BWnWAsCJ/94by+Tjh9Mwe/wjR5IRKu9DZPtQHytjSgjNovn3g8ZdfcS60LZ4x
         6bjqvHtzKLHhBEoxOtLFjaMwnbvfgEElTw4ysBHeBQNIHF5EtTglEn745iLCQvGWBxOQ
         PU1Xcy+8iloAwJlwp3pV+/gNtqO68PZ+YIwVjADkd6n84/sfdjGEPMEbSbQQgZFe729Y
         Cd1Vp2Jp/R6KR0Zt55KNFESmSizN5xqFB5hUOm7ftDS1eMjxOe7RFBjpyKDrmZWFoUjj
         AYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979765; x=1784584565;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6Y7Xe1SbiMFbOzf01pbOyxaH8rw40mxymdbfU2kNyQ=;
        b=fm1GfVzqlkvg1/rzrqGTJf0npzAXABjJDav85UUwqkF3SesHYCpmbAmjRVQbMat56k
         RjSlhiiGTWsh/0WgqjOzBc8GdfsKV3p/9DbGtCg4Gnw4cywALmIbmF1Ac3BbHNdcMKxH
         p1qT5jzmIi4PYmf+mInQxVOLgRUe3ZTSUMOkHfasetykGNg+9eEQ9siQy+3IL9GoyRjX
         16X0Q3/MxSLz5TimlHmY6vrHJScPe47UQUhFjGMliQHvbrmkyN+G3L476f9BOfNCg2hh
         LM7dHx5B/wIwf13zW71tAAvR9Hp/PJYsqZIWEtxUl0Zb6E0xS4e/fWxzU3pnRqXf+1VQ
         CbYQ==
X-Gm-Message-State: AOJu0YyYbF5m8mO2ciHaMSPdtY0lrQbPJ0t95D7awLiZ7J1ikdbJx0G3
	KJgac0Fr8qbHPel0b4vhdieRrZE3Cuox+s/F+MJJTSE9nqKQPLityLvZztCRB7UW1Tw=
X-Gm-Gg: AfdE7ckNNKQ2+zmis3RqjDXKitOjgwg+lF7UyemE9vW1JS0C3HA38VebL5eqjq7y/U2
	fBGEG4BzAL64//G5qgdGxnU4aOwHk0fo5rKKnenfWBKKGeoRjkme6QeKdUF/u2kIUK88S2Z4ZJz
	rIUKiiKDCRB2t7XWiisCFj/jTHzdLfKJsyH/31eWGUaPN6WVymT6TS9tJf1ev5/js1slG3LvUc0
	AtkFLHqFAD2ICGoOCnfJ8xaoNFFjXzWOt+lEHxb346lMrLTIf8Zz95dpPM8Cmdn/sRZTsNzGEHl
	ejohh7sf2FyQpPL5hFS3LO932mj6/kYv/tQttXqjSdzaRdT9qbR3lqkCppNni4ZXbODQieXpxX3
	IGwq2opif70B2j/o5KYiG0lHD2sIoc0RYD43aoKS+2fdSaQjdFasXg8HEXfNT3S9t+g7q0aZw6W
	vIIeVU5bmV6WEnd/11LNSbNDEJ5fRg83vj2C2mqUTv705pkfJ66uvW
X-Received: by 2002:a05:690e:dc6:b0:666:5727:4d70 with SMTP id 956f58d0204a3-667d978ecb3mr7088216d50.13.1783979764886;
        Mon, 13 Jul 2026 14:56:04 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6678775d59bsm14750206d50.4.2026.07.13.14.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 14:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:56:02 -0400
Message-Id: <DJXS1OUUJXX5.15RH1OEET2EB7@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Add prog_list_init_item(),
 prog_list_replace_item(), and prog_list_id()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-7-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-7-ameryhung@gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307289-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,etsalapatis-com.20251104.gappssmtp.com:dkim,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A89874F5DF

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Add three helpers to abstract operations on a bpf_prog_list entry.
>
> Right now, bpf_prog_array_item is initialized from prog_list_prog(pl),
> which returns either pl->prog or pl->link->link.prog. This will not work
> when struct_ops is attached to a cgroup because the attachment is backed
> by a struct_ops map instead of a BPF prog.
>
> The same applies to __cgroup_bpf_query(). Instead of always copying a
> prog id to userspace, struct_ops cgroup attachment will need to copy the
> struct_ops map id.
>
> Refactor bpf_prog_array_item initialization into prog_list_init_item()
> and prog_list_replace_item(), and refactor id lookup into prog_list_id().
> These helpers will be extended to support pl->link->map in a later patch.
>
> This is a no-op change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Followup on prog_list_prog() since I hadn't realized it was moved to the
helpers in this patchset: Maybe we can just make it not return NULL
since it's impossible instead of adding error handling to minimize
churn.

>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/cgroup.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b100c04cb9c8..b43f0bff184c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -399,6 +399,22 @@ static struct bpf_prog *prog_list_prog(struct bpf_pr=
og_list *pl)
>  	return NULL;
>  }
> =20
> +static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_pro=
g_array_item *item)
> +{
> +	item->prog =3D prog_list_prog(pl);
> +	bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
> +}
> +
> +static void prog_list_replace_item(struct bpf_prog_list *pl, struct bpf_=
prog_array_item *item)
> +{
> +	WRITE_ONCE(item->prog, pl->link->link.prog);
> +}
> +
> +static u32 prog_list_id(struct bpf_prog_list *pl)
> +{
> +	return prog_list_prog(pl)->aux->id;
> +}
> +
>  /* count number of elements in the list.
>   * it's slow but the list cannot be long
>   */
> @@ -492,9 +508,7 @@ static int compute_effective_progs(struct cgroup *cgr=
p,
>  				item =3D &progs->items[fstart];
>  				fstart++;
>  			}
> -			item->prog =3D prog_list_prog(pl);
> -			bpf_cgroup_storages_assign(item->cgroup_storage,
> -						   pl->storage);
> +			prog_list_init_item(pl, item);
>  			cnt++;
>  		}
> =20
> @@ -1015,7 +1029,7 @@ static void replace_effective_prog(struct cgroup *c=
grp,
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
>  		item =3D &progs->items[pos];
> -		WRITE_ONCE(item->prog, pl->link->link.prog);
> +		prog_list_replace_item(pl, item);
>  	}
>  }
> =20
> @@ -1318,15 +1332,13 @@ static int __cgroup_bpf_query(struct cgroup *cgrp=
, const union bpf_attr *attr,
>  		} else {
>  			struct hlist_head *progs;
>  			struct bpf_prog_list *pl;
> -			struct bpf_prog *prog;
>  			u32 id;
> =20
>  			progs =3D &cgrp->bpf.progs[atype];
>  			cnt =3D min_t(int, prog_list_length(progs, NULL), total_cnt);
>  			i =3D 0;
>  			hlist_for_each_entry(pl, progs, node) {
> -				prog =3D prog_list_prog(pl);
> -				id =3D prog->aux->id;
> +				id =3D prog_list_id(pl);
>  				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
>  					return -EFAULT;
>  				if (++i =3D=3D cnt)


