Return-Path: <netdev+bounces-251575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIXwOb7eb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:59:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C04AEB5
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A97CD9C2697
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84344B663;
	Tue, 20 Jan 2026 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6v14FbM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124293A8FF6
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932375; cv=none; b=drX02/EMnxvkBBhuGoTjXG2otNTsQKdITcqUtS8UTyVU8+ThK4EuUPSi4PutDiK8AATP6sPExhhy/8Fjnfg/1JqPMXtcm8nq777H0H8RHt8/6lEY0h3xkbOSlNEdHIi5bNDVjBP9/hUMy4D+bu78Eq0vxGb4N4GGIjhTdm9altk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932375; c=relaxed/simple;
	bh=+/G9xnytSRdZiIOFd28QuZ//L1BeR3Jjgm+HN2Txu7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2WmlHfoViSRgj4LnTtVlB10+61Dg7s9/gjfXU8FTPpw0S7HNSHZnm/T7aaKz/drx0Ume/ZtGpVLDXBl85ohigIMdVxAsG9TVcc1gn1RZpIGa3630SlpPWAM2C8oViXaCP248yB0dnzMNWCcMk0YGeSEemd5xsD7RE8RDsWq8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6v14FbM; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso2003328eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768932373; x=1769537173; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eyerjoEVUHP/2q8LWOmqlYZ45AxY0BTKpTeutlV7DCY=;
        b=X6v14FbMISveJc9MaMemnxJdDrd5a3dcH4k0SJjN0DpmanHG5wJ2qrkBB0rj8au1jh
         CA3uqMlOuMv434IC1VgLuVf8TdohvCS0BdEKOKFEq5Xxdgcm+VlQvs06u/bzmy5e7+I4
         Clwez2UPNB+nNCakIZxG/ISeURsfMoqDc82FazHMurVXXrxoDy3bcrT3M0xkcOBmShZC
         OZwDOsv5KpDw6gcBb2+22awH2cdkt0aRcq1/i83LOngI+5bqRrKKEu+xFAPmgsoxsvX8
         zqD4DT5+7Q50m2Cul6gMQY6GlWNS8G8asRYHZXACxdpE6Z/R4ct3nV7oLHQBEgIkZ9Gf
         4wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932373; x=1769537173;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyerjoEVUHP/2q8LWOmqlYZ45AxY0BTKpTeutlV7DCY=;
        b=R0nHdas4vSusHWsTmie28j+KoqglX909pQtgv2wzuYLiYUaeJvLc+aWfiIaRDDWSGJ
         bGMxe984Utzop31Jy/ainwOnH0Inx5zn4uuNMCJ5JmvsjirzgPZWQeQTPpJ/QP1Af5Gj
         wB197vg3042F72fM4ybqEjVkZ62p5shhv4IGWIErL7KpyQJaqTsls5TaloJjimxBDTfF
         8K96KMrqlFJepbUhxuVPXaOImBLimyqpcIhSkdm9QO4LVgJjsr8Evuv1SDLliclVV9LV
         1fAGQJtm/w/6ER5TUN0JFMXkj8nFNxXCEnwa0enGfDJClSiHbCj3B4Fen8Lk7by6BJwR
         FRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDRUvYY1aJqZkZ15+eTv2obA5H5L+sVXXyN4JaCc/wmushxzEaiM/CVG9jzTUZq6zF6nPFsZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxInH3iD4WpOsg8N57TLW/VHqs8V2NY6C3X+Scs7JUSPtKv1PiQ
	PZAX9XGMgMZCLZbm4Ad+mt5XqzXxitTSOsr7G1JjsWdh55zifw6MWyEF
X-Gm-Gg: AZuq6aL5K9LUjnAk7WEglNEBvecda5d9u8IKVIHpChhhFlCQgJIzat4wwddMv6bb8pp
	YaN3P/xM5ZDDBcyD+qPGklzUKWRNhFC37sPQ90FVW08l2evyA/HQyWCPHKoc+yPPW6VWBH/lbOy
	VnRGOjT4IeTobZkAtMhDyqvSX4q+YTxlqaelDDv4/bm9ZlqnVDgFKVGZzAXAdxpgAxL8SYIY3es
	v2TrjGshlVIzkHGXTtdns4akxEd39EldZp8YMug8qmvlZapcg12JH7yq89OfIqyXNRR3H4KWI1L
	cewLDFXGJEiQpIEt/zEmGC0ocaY1BmireCUM8HVNtzVSFd8Qa51dhyUl34L5Jj4l4HzVD6I/ZMR
	WV6uqPDHp88FGQhoG1jQjdGprvtfpo8heu8BgJxMIQlqhw00DNSt9vsLxjSEWo70wtJadFatcYj
	iD4K5Kho0NXVPTelElbl9W02Bz1OupuGAYbwpmm/oiHOFEQzDvteLyuwPTEFMyrl7iZpmWhrtKR
	UlM7OM=
X-Received: by 2002:a05:7300:fb94:b0:2ae:614a:3307 with SMTP id 5a478bee46e88-2b6fd7eee95mr1965930eec.42.1768932371383;
        Tue, 20 Jan 2026 10:06:11 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm20058248eec.32.2026.01.20.10.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:06:11 -0800 (PST)
Message-ID: <34ff0901e3c96cbfab8b7325012e44d6d290a9be.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Require ARG_PTR_TO_MEM with memory
 flag
From: Eduard Zingerman <eddyz87@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	 <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuran Liu
	 <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni
	 <haoran.ni.cs@gmail.com>
Date: Tue, 20 Jan 2026 10:06:07 -0800
In-Reply-To: <20260120-helper_proto-v3-2-27b0180b4e77@gmail.com>
References: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
	 <20260120-helper_proto-v3-2-27b0180b4e77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251575-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,goodmis.org,efficios.com,davemloft.net,redhat.com,dxuuu.xyz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 856C04AEB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 16:28 +0800, Zesen Liu wrote:
> Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
> MEM_RDONLY.
>=20
> Using ARG_PTR_TO_MEM alone without flags does not make sense because:
>=20
> - If the helper does not change the argument, missing MEM_RDONLY causes t=
he
> verifier to incorrectly reject a read-only buffer.
> - If the helper does change the argument, missing MEM_WRITE causes the
> verifier to incorrectly assume the memory is unchanged, leading to errors
> in code optimization.
>=20
> Co-developed-by: Shuran Liu <electronlsr@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---

At the moment, for helper arguments processing I see that MEM_RDONLY
influences verifier only when argument type is ARG_PTR_TO_DYNPTR or
ARG_PTR_TO_BTF_ID. Hence, I think this change is safe to apply,
effects are limited to the check_mem_arg_rw_flag_ok() below.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9de0ec0c3ed9..a89f5bc7eff7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10351,10 +10351,27 @@ static bool check_btf_id_ok(const struct bpf_fu=
nc_proto *fn)
>  	return true;
>  }
> =20
> +static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> +		enum bpf_arg_type arg_type =3D fn->arg_type[i];
> +
> +		if (base_type(arg_type) !=3D ARG_PTR_TO_MEM)
> +			continue;
> +		if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int check_func_proto(const struct bpf_func_proto *fn)
>  {
>  	return check_raw_mode_ok(fn) &&
>  	       check_arg_pair_ok(fn) &&
> +	       check_mem_arg_rw_flag_ok(fn) &&
>  	       check_btf_id_ok(fn) ? 0 : -EINVAL;
>  }
> =20

