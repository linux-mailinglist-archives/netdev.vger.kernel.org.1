Return-Path: <netdev+bounces-307290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GmjGHktfVWr7nQAAu9opvQ
	(envelope-from <netdev+bounces-307290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:57:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6D74F5E6
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=bb0Ru0yS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307290-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307290-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C597302A79C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800B35E1BF;
	Mon, 13 Jul 2026 21:57:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102735E1B5
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:57:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979844; cv=none; b=jvF2omiAUfGMBUN+YU619l9CZzeUW+xDrEmE+VZWZiK31Ek74zGXXdwioPFiSZXrJBNI4/FPsa2q+a4w0WuFAjF0eSBr+JHERp0c9BCys7ITTto/Eb19aV4SI7BoIRRFwEhL8xXBxENybpi5ikwc/OyUFm3Ek57a/VyDoHgHT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979844; c=relaxed/simple;
	bh=coTO6PwuDxPx0SSZlTNrbu8MbSA08SuMKb4lakXTOBw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YUgzHRpEPE4qdCx2m8xlKWHphy6midAawtxMMzUibQpUmS6uklTD6zN+X5SSeZJ5/KCZZgpwVzyQngRnvKkyU9sWjH11NuNEAhdIo8UE9TPhnxUNIDJdMRYHSbcCcybGtqf/ybdDJKnhqphCzWH7o2WIlm5VelB0b2FAN8/lfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bb0Ru0yS; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8487088510aso3460309b3a.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783979841; x=1784584641; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UrqBoQyrxvBcos5JbUmwXjWeYzr52NLOmMrsaM2Ub/k=;
        b=bb0Ru0ySsnkiOLTtWS5HDN9DQ1SqhJ1n4BYvijkz8/uPRIIfhcvcvjIe9t3LkeesoH
         TAK0Qbheuv+7gAgIHKKMSgfCtiWu+aBqtFyO3+V1eFFuI3HvFbgeKxC4RkYz1a7D0PBb
         NgxoxachohereFVr38xS/NCgypn8lfXqNaaBUHV+pL9Dby0+exIj+HEZQpDkg/lJ9xpt
         NglAYV+WKWg2oNKuMRObWZWZ/Z5ISNT0akjdY8xz8oHoZFpQVrVrnZSuCSTErfqp3rE+
         ULJHzPbmMqF/sbNTZtigAinBwA8/Wlr662VWMLPylskLUvo9jkVcGYxFDXksSXR1YF4g
         m29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979841; x=1784584641;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrqBoQyrxvBcos5JbUmwXjWeYzr52NLOmMrsaM2Ub/k=;
        b=gmqHfFAPFqjJ19fEgZJgDNjNe1RMp2A8RIItG1xIhKMo/8W5YV74QQEmOMBDyv1eaY
         6kN0Le1k9LKusdF/AD8Xm5Y+0pCUCbcxea13EzlHjSUNyqXwuv5qbyHa20Ayul2ZzZ9h
         UiPh9zNNwyALGwR+2KJGknu4rpx89IEM5BK76PtXe1W8zXqvVDfm6NDpBVpf+UfxoU0u
         mcRTzDYCaFuaEaSJeqEZ2gWiRRqpFyZrv9AOWFwMYXnSlYTCdV/b5rRQWOVXt6Yr4xTu
         ym2qHfFe6D15hgiT+eczmpqi0vhS75I7jsJ0mgxCM+aXmTOHWCsyyahfEXu8kk514AxD
         aBAA==
X-Gm-Message-State: AOJu0YxH8HC0fE4dJHXKQPU810hXrsgx2LP1E3Oku6rRzrRVahmlTZAn
	VVf//CYD7pEivA3OKA0YQkeaXoChEkXHK+Lwum4j6oLjGxLHiSSVHe4lWAtAZaPDxA4=
X-Gm-Gg: AfdE7cnlAQ7LHE0qHxZp3+CeQjj1C9VWVmfGLLPn1VcqRn0BISva4r+S8xbjGDIM02g
	zAFCRaFRgvoiS1Jx13VPG/7aIh+ENmnS9/dk4d10ZVQgcagwZsbzisDkWYxjsSx9HGyGl+3Fnib
	x6FBQoNDyw2d7EvdTOinviZ9fo783gczLJiH3dEtnMzS3K4eZZF5NLkzMCN0RkLSbDawK+FWSlD
	y4kJqgo1wwemDzpUcDAW23NxeFoD/e+znLpVPsqrMdLXcA56unkdJyyromzt/Il291+E4kNnvCt
	lti257IF+YMY1+pSLfdYq1UaOH9YbJxWJSl9zDT/DSgPEgHaZRyECpiXsJzumwn3P14sg1+GlDV
	IiP3xsiJCBdg2nL3YuHz0U+wqJB5rfscPUCyfSdi6YU1fB7C8w5XZvr89I4a2rhsAVUenVgkQzJ
	NaiH0Ti2rKmoDXQAyihTroVMwMhE5ZBMlfbbnKfDNESQ==
X-Received: by 2002:a05:6a00:983:b0:848:79aa:5d37 with SMTP id d2e1a72fcca58-84a5162f3admr637079b3a.55.1783979840901;
        Mon, 13 Jul 2026 14:57:20 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643cd6sm9131766a12.26.2026.07.13.14.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 14:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:57:19 -0400
Message-Id: <DJXS2O9LFN5T.8BCWIJOB6N4M@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 08/15] bpf: Add a few bpf_cgroup_array_*
 helper functions
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-9-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-9-ameryhung@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307290-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,etsalapatis-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01E6D74F5E6

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> In the upcoming patch, the array can store a struct_ops map.
> The array could have a cfi_stubs acting as a dummy instead of
> the dummy_bpf_prog. The array logic will need to skip the cfi_stubs
> also in order to support storing struct_ops map in the array.
>
> bpf_cgroup_array_length(), bpf_cgroup_array_copy_to_user(), and
> bpf_cgroup_array_delete_safe_at() are added as a preparation work
> to allow skipping the cfi_stubs in the upcoming patch. This patch
> only skips the dummy_bpf_prog which is the same as the existing behavior.
> The current bpf_prog_array_*() callers are changed to call the new
> bpf_cgroup_array_*(). This is a no-op change.
>
> Unlike bpf_prog_array_copy_to_user(), bpf_cgroup_array_copy_to_user()
> does not need a temporary buffer. The cgroup caller already holds
> cgroup_mutex and dereferences the effective array with
> rcu_dereference_protected(), so it does not copy to userspace
> from an RCU read-side critical section. Details in commit 0911287ce32b.
>
> Another addition is the bpf_cgroup_array_free(). This prepares
> the array to have a different rcu gp for the struct_ops use case,
> for example, a struct_ops could have mix of sleepable ops and
> non-sleepable ops. In this patch, bpf_cgroup_array_free() only
> goes through the regular rcu gp. This is a no-op change also.
>
> bpf_prog_dummy() is also added to return the global dummy_bpf_prog.
>
> bpf_cgroup_array_dummy() is added to decide the sentinel based on atype.
> It now always returns bpf_prog_dummy(). In the upcoming patch,
> it can return a cfi_stubs if the atype belongs to a struct_ops.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One style issue below.

> ---
>  include/linux/bpf.h |  1 +
>  kernel/bpf/cgroup.c | 79 +++++++++++++++++++++++++++++++++++++++------
>  kernel/bpf/core.c   |  5 +++
>  3 files changed, 76 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 047ffc029666..e371a4733135 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2561,6 +2561,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_=
array,
>  			struct bpf_prog *include_prog,
>  			u64 bpf_cookie,
>  			struct bpf_prog_array **new_array);
> +struct bpf_prog *bpf_prog_dummy(void);
> =20
>  struct bpf_run_ctx {};
> =20
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 7abbe12e108f..081d81de1816 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -319,6 +319,67 @@ static void bpf_cgroup_link_auto_detach(struct bpf_c=
group_link *link)
>  	link->cgroup =3D NULL;
>  }
> =20
> +static void bpf_cgroup_array_free(struct bpf_prog_array *array)
> +{
> +	if (!array || array =3D=3D &bpf_empty_prog_array)
> +		return;
> +	kfree_rcu(array, rcu);
> +}
> +
> +static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
> +{
> +	return bpf_prog_dummy();
> +}
> +
> +static int bpf_cgroup_array_length(struct bpf_prog_array *array,
> +				   enum cgroup_bpf_attach_type atype)
> +{
> +	struct bpf_prog_array_item *item;
> +	int cnt =3D 0;
> +
> +	for (item =3D array->items; item->prog; item++)
> +		if (item->prog !=3D bpf_cgroup_array_dummy(atype))
> +			cnt++;

The outer parenthesis needs braces since its body is an if-statement.

> +
> +	return cnt;
> +}
> +
> +static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
> +					 __u32 __user *prog_ids, int cnt,
> +					 enum cgroup_bpf_attach_type atype)
> +{
> +	struct bpf_prog_array_item *item;
> +	int i =3D 0;
> +	u32 id;
> +
> +	for (item =3D array->items; item->prog && i < cnt; item++) {
> +		if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))
> +			continue;
> +		id =3D item->prog->aux->id;
> +		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
> +			return -EFAULT;
> +		i++;
> +	}
> +	return item->prog ? -ENOSPC : 0;
> +}
> +
> +static int bpf_cgroup_array_delete_safe_at(struct bpf_prog_array *array,
> +					   int index, enum cgroup_bpf_attach_type atype)
> +{
> +	struct bpf_prog_array_item *item;
> +
> +	for (item =3D array->items; item->prog; item++) {
> +		if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))
> +			continue;
> +		if (!index) {
> +			WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
> +			return 0;
> +		}
> +		index--;
> +	}
> +	return -ENOENT;
> +}
> +
>  /**
>   * cgroup_bpf_release() - put references of all bpf programs and
>   *                        release all cgroup bpf data
> @@ -356,7 +417,7 @@ static void cgroup_bpf_release(struct work_struct *wo=
rk)
>  		old_array =3D rcu_dereference_protected(
>  				cgrp->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> -		bpf_prog_array_free(old_array);
> +		bpf_cgroup_array_free(old_array);
>  	}
> =20
>  	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> @@ -530,7 +591,7 @@ static void activate_effective_progs(struct cgroup *c=
grp,
>  	/* free prog array after grace period, since __cgroup_bpf_run_*()
>  	 * might be still walking the array
>  	 */
> -	bpf_prog_array_free(old_array);
> +	bpf_cgroup_array_free(old_array);
>  }
> =20
>  /**
> @@ -570,7 +631,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
>  	return 0;
>  cleanup:
>  	for (i =3D 0; i < NR; i++)
> -		bpf_prog_array_free(arrays[i]);
> +		bpf_cgroup_array_free(arrays[i]);
> =20
>  	for (p =3D cgroup_parent(cgrp); p; p =3D cgroup_parent(p))
>  		cgroup_bpf_put(p);
> @@ -625,7 +686,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
> =20
>  		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
>  			if (unlikely(desc->bpf.inactive)) {
> -				bpf_prog_array_free(desc->bpf.inactive);
> +				bpf_cgroup_array_free(desc->bpf.inactive);
>  				desc->bpf.inactive =3D NULL;
>  			}
>  			continue;
> @@ -644,7 +705,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
>  	css_for_each_descendant_pre(css, &cgrp->self) {
>  		struct cgroup *desc =3D container_of(css, struct cgroup, self);
> =20
> -		bpf_prog_array_free(desc->bpf.inactive);
> +		bpf_cgroup_array_free(desc->bpf.inactive);
>  		desc->bpf.inactive =3D NULL;
>  	}
> =20
> @@ -1166,7 +1227,7 @@ static void purge_effective_progs(struct cgroup *cg=
rp, struct bpf_prog_list *pl,
>  				lockdep_is_held(&cgroup_mutex));
> =20
>  		/* Remove the program from the array */
> -		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
> +		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),
>  			  "Failed to purge a prog from array at index %d", pos);
>  	}
>  }
> @@ -1296,7 +1357,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>  		if (effective_query) {
>  			effective =3D rcu_dereference_protected(cgrp->bpf.effective[atype],
>  							      lockdep_is_held(&cgroup_mutex));
> -			total_cnt +=3D bpf_prog_array_length(effective);
> +			total_cnt +=3D bpf_cgroup_array_length(effective, atype);
>  		} else {
>  			total_cnt +=3D prog_list_length(&cgrp->bpf.progs[atype], NULL);
>  		}
> @@ -1326,8 +1387,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>  		if (effective_query) {
>  			effective =3D rcu_dereference_protected(cgrp->bpf.effective[atype],
>  							      lockdep_is_held(&cgroup_mutex));
> -			cnt =3D min_t(int, bpf_prog_array_length(effective), total_cnt);
> -			ret =3D bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
> +			cnt =3D min_t(int, bpf_cgroup_array_length(effective, atype), total_c=
nt);
> +			ret =3D bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype=
);
>  		} else {
>  			struct hlist_head *progs;
>  			struct bpf_prog_list *pl;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..1837bb7bb4e9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2740,6 +2740,11 @@ void bpf_prog_array_free_sleepable(struct bpf_prog=
_array *progs)
>  	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
>  }
> =20
> +struct bpf_prog *bpf_prog_dummy(void)
> +{
> +	return &dummy_bpf_prog.prog;
> +}
> +
>  int bpf_prog_array_length(struct bpf_prog_array *array)
>  {
>  	struct bpf_prog_array_item *item;


