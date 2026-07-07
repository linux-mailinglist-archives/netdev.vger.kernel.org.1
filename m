Return-Path: <netdev+bounces-305561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v0ykCmlATWp+xQEAu9opvQ
	(envelope-from <netdev+bounces-305561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:07:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B951C71E7E5
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:07:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=H01hJZr8;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305561-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305561-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F84F3039018
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E44225791;
	Tue,  7 Jul 2026 18:07:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE332C0303
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 18:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447650; cv=none; b=TGWyEgOakWnneGQkFUI50I2zHpu3UaSqRVMIy4j/vyv8DNaIgKxTO6bAMOOzm6VRRfVItsMClGVyankfN5K70wzY/qaEFrrVkXx0CcSgqNeX/h7Q1QWw+Z0sdcLYtC0VD2vZuf0tkKScDmWAFwZCsgZO6IUigfM6kf4VAC3sPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447650; c=relaxed/simple;
	bh=vcki7oBvw1sLDftOfNNiIqiR2vQwgZTYBbexjDEXxW8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b2s76TvkOTp8RMNU40E/aBd2d09ku/hi+f9M8+dtweQ/p30OooE5oafTfcgc2aafoW/DP4NUawFrfgY2AROU00INRr2DaedDKEQyngMawRN7wsAxnleE6injPUFHY+Gu+sgCfAD/SxuMz/l04a/1ouYGGT7duxgq/32rDnx32GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=H01hJZr8; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84832ec2615so1053271b3a.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783447647; x=1784052447; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=adKQv1s51c2HukqV2OIYDY9VO+GH/YDmDfRrvcoAyQU=;
        b=H01hJZr8VyCBCGj5J1vtlVRNng2MuJ3ofUzY3I21S4QNPA2Ezgkt2Qrbb4tPK0VFiZ
         DNnb1rp2kgKNUR9EVJXDT7tnwr015KsYldyL5bQHW9q0Y6Z1V0nTH97tSB3G273mh0KG
         3CGre1kkLn897Q/iSTebbdFcEr+FBJzRuttY9oATs4286NuQLolf7e1K/+WyQ2k9jjPy
         uLjyKDmb9ptWit/U2SW/+ZQ2nFaOPywERmjbXOFfAQ30b+vleur8wogZ7PqZufzm4fLa
         7EZGgTPKrHl44I6vaQ70+W5AWyoDsIceIZHZlKIO6vLsZ1ytwn6R9aZ4qdKI/Hx7Tn4H
         QNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447647; x=1784052447;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adKQv1s51c2HukqV2OIYDY9VO+GH/YDmDfRrvcoAyQU=;
        b=idtKDBHWKSpkAGzxxmAaCLDr/XUxJLVFan5NEYvTbEtWFcbAeQkTAnOKIY1zOjNpTN
         mZ/1z+Ah+JB0RABsNplGkGI4e5iL51BEKhCRIp6CHq50ocuGWyljCRvSyySDzuuGXZLK
         ZdcpJaL3MEKqhF4U/TDPd0OLVnRvKlzh89Okp2gXbnIyVgJazAaTVOZvTwkKoY8wyG4H
         l2C0O8WWGnsThn3klfQNB7c1TE55nt8kPTTGl//C36TF4qIjoa8CtrsKNw1izGrZBhaD
         v+hb3Vv47Bdg8KkWgDhxsGsUyiGsorLz6eyhVfSmXTvMFhV/4GIkizgYycbzkw5sulKR
         3xcQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+YeUem/SVMtEIgxplX0lyo4vylfDfdttUBnjFrOnrIy3amIoomfEELSfrAH9h3B9PHMIDme4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfJPZ/R6WETAGn+lzKBzlIrl+9CuNAENsnfmDFu/zkmStY1HP
	nRR0jIA/Q751skXGemOJeFMd8/bxH9Uh0i0BrKeGMDxsb1nQhKTCb1bAmtURmq64Zdo=
X-Gm-Gg: AfdE7clxtQc1U4b6MQegcuiBlgzgWNqkEL9CW7A5hqlkaJCGZQTkzX8cZRvSZyH8mi0
	tH5uteiCQQbqMKRBSDiRwCpYkF/MpdRIQXnIf3QxM1XAoI8Xgdm29heW+5SQPADtAUKs+XYuYqE
	RMw6izzWIzW06+X6Qma2hkHcQpLnQj0o7He0J0UxoPxS60m+zkSL757GPX4+ZiZdpQ2/YSneRMk
	BtunQjlAKwBeqiKKdPim9ffRKk+gM+VUhYK9eRziRY34oAhjYeIgMlPt8pcv1xcz2BDXOWDbrSI
	sdOLtHPdKYvQwSu38TG+hjuHUuiJo6/6zPjkLDMZ/6m9kls76RjU0mZmFdQh1K9VbK71R6Gz9gI
	/KM+boazMTFj8xEpyfOS8OCtPKTSUmXoX207g5eU6mEgmR+Kk03LnckBzQRaRgVjJSo2Gc7tlaC
	HlIxdnXR6rYv+sjaAUOYOx/Wbb3+heshMemF0f5cRDvg==
X-Received: by 2002:a05:6a20:cf88:b0:3c0:9c19:6589 with SMTP id adf61e73a8af0-3c09c196d09mr5103844637.67.1783447646809;
        Tue, 07 Jul 2026 11:07:26 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf76dbsm16476255ad.21.2026.07.07.11.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 11:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 14:07:24 -0400
Message-Id: <DJSJFDD2MQ4Q.2ECD6WSD2AFAA@etsalapatis.com>
Cc: <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>,
 <hawk@kernel.org>, <yatsenko@meta.com>, <leon.hwang@linux.dev>,
 <kpsingh@kernel.org>, <a.s.protopopov@gmail.com>, <ameryhung@gmail.com>,
 <rongtao@cestc.cn>, <eyal.birger@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <toke@redhat.com>, <dsahern@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
 <20260704092159.1256823-2-avinash.duduskar@gmail.com>
In-Reply-To: <20260704092159.1256823-2-avinash.duduskar@gmail.com>
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
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,m:avinashduduskar@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305561-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B951C71E7E5

On Sat Jul 4, 2026 at 5:21 AM EDT, Avinash Duduskar wrote:
> bpf_fib_lookup() returns the FIB-resolved egress ifindex straight
> from the fib result. When the egress is a VLAN device, the returned
> ifindex is the VLAN netdev's, which has no XDP xmit handler; XDP
> programs that want to forward the frame (e.g. xdp-forward) must
> instead target the underlying physical device and push the VLAN tag
> themselves. Today the program has no way to learn either the
> underlying ifindex or the VLAN tag without maintaining its own
> VLAN-to-ifindex map in userspace and refreshing it on netlink
> events.
>
> Add BPF_FIB_LOOKUP_VLAN. When the caller sets this flag and the fib
> result is a VLAN device whose immediate parent is a real (non-VLAN)
> device in the same network namespace, populate the existing output
> fields params->h_vlan_proto and params->h_vlan_TCI from the VLAN
> device and replace params->ifindex with the parent's ifindex.
> params->h_vlan_TCI carries the VID only, with PCP and DEI bits zero; a
> consumer wanting to set egress priority writes PCP itself.
> params->smac is the VLAN device's own address, which can differ from
> the parent's.
>
> Only the immediate parent is resolved, via vlan_dev_priv(dev)->real_dev
> and not vlan_dev_real_dev(), which walks to the bottom of a stack. When
> the immediate parent is not a real device in the same namespace, the
> lookup returns BPF_FIB_LKUP_RET_VLAN_FAILURE and leaves params->ifindex
> at the input. This covers a stacked VLAN (QinQ), where the immediate
> parent is itself a VLAN device and one h_vlan_proto/h_vlan_TCI pair
> cannot describe two tags, and a parent in another network namespace (a
> VLAN device can be moved while its parent stays), whose ifindex would
> be meaningless in the caller's namespace. A program that wants the VLAN
> device's own ifindex re-issues the lookup without BPF_FIB_LOOKUP_VLAN,
> so the unreducible case stays distinct from a physical egress. That
> distinction matters for XDP: a program cannot xmit on a VLAN device, so
> a success carrying the VLAN ifindex would make it redirect to a device
> with no ndo_xdp_xmit and drop the frame at xdp_do_flush(). The swap and
> the vlan fields are written only on the reduce path; other output
> fields keep their existing behaviour, so a frag-needed result still
> reports the route mtu in params->mtu_result.
>
> BPF_FIB_LOOKUP_VLAN is only useful to XDP, which cannot redirect to a
> VLAN device. A tc program can redirect to the VLAN device directly, so
> bpf_skb_fib_lookup() rejects the flag with -EINVAL; bpf_xdp_fib_lookup()
> accepts it. When the flag is not set, behaviour is unchanged:
> h_vlan_proto and h_vlan_TCI are zeroed and ifindex is left at the FIB
> result.
>
> The new block is compiled only under CONFIG_VLAN_8021Q since
> vlan_dev_priv() is not defined otherwise; without that config
> is_vlan_dev() is constant false and the flag is accepted but never
> acts. That is safe because no VLAN device can exist there, so every
> egress is already physical.
>
> This lets an XDP redirect target the physical device and learn the
> tag to push in a single lookup, which xdp-forward's optional VLAN
> mode (xdp-project/xdp-tools#504) wants from the kernel side.
>
> The helper's input semantics are unchanged; the reverse direction
> (supplying a tag as lookup input) is added in the following patch.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/uapi/linux/bpf.h       | 31 ++++++++++++++++++++++++++++++-
>  net/core/filter.c              | 33 +++++++++++++++++++++++++++++----
>  tools/include/uapi/linux/bpf.h | 31 ++++++++++++++++++++++++++++++-
>  3 files changed, 89 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 89b36de5fdbb..e00f0392e728 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3532,6 +3532,29 @@ union bpf_attr {
>   *			Use the mark present in *params*->mark for the fib lookup.
>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>   *			as it only has meaning for full lookups.
> + *		**BPF_FIB_LOOKUP_VLAN**
> + *			If the fib lookup resolves to a VLAN device whose
> + *			parent is a real (non-VLAN) device, set
> + *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
> + *			the VLAN device and replace *params*->ifindex with the
> + *			parent's ifindex. *params*->h_vlan_TCI carries the VID
> + *			only, with PCP and DEI bits zero; a consumer wanting to
> + *			set egress priority writes PCP itself. *params*->smac is
> + *			the VLAN device's own address, which can differ from the
> + *			parent's. Only the immediate parent is resolved; if it
> + *			is itself a VLAN device (QinQ) or in another namespace,
> + *			the egress cannot be reduced to a physical device plus
> + *			one tag and the lookup returns
> + *			**BPF_FIB_LKUP_RET_VLAN_FAILURE** with *params*->ifindex
> + *			left at the input. Re-issue without
> + *			**BPF_FIB_LOOKUP_VLAN** to obtain the VLAN device's own
> + *			ifindex. The swap and the vlan fields
> + *			are written only on success; other output fields keep
> + *			the helper's existing behaviour, so a frag-needed result
> + *			still reports the route mtu in *params*->mtu_result.
> + *			This flag is only valid for XDP programs; tc programs
> + *			receive -EINVAL since they can redirect to the VLAN
> + *			device directly.
>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7327,6 +7350,7 @@ enum {
>  	BPF_FIB_LOOKUP_TBID    =3D (1U << 3),
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
> +	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
>  };
> =20
>  enum {
> @@ -7340,6 +7364,7 @@ enum {
>  	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
>  	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
>  	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
> +	BPF_FIB_LKUP_RET_VLAN_FAILURE, /* VLAN egress, parent unresolvable */
>  };
> =20
>  struct bpf_fib_lookup {
> @@ -7393,7 +7418,11 @@ struct bpf_fib_lookup {
> =20
>  	union {
>  		struct {
> -			/* output */
> +			/*
> +			 * output with BPF_FIB_LOOKUP_VLAN: set from the
> +			 * resolved egress VLAN device (see the flag); zeroed
> +			 * on other successful lookups.
> +			 */
>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
>  		};
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce..b5a45485a54b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6201,10 +6201,29 @@ static const struct bpf_func_proto bpf_skb_get_xf=
rm_state_proto =3D {
>  #endif
> =20
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> -static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu=
)
> +static int bpf_fib_set_fwd_params(struct net_device *dev,
> +				  struct bpf_fib_lookup *params,
> +				  u32 flags, u32 mtu, u32 in_ifindex)
>  {
>  	params->h_vlan_TCI =3D 0;
>  	params->h_vlan_proto =3D 0;
> +
> +#if IS_ENABLED(CONFIG_VLAN_8021Q)
> +	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
> +		struct net_device *real_dev =3D vlan_dev_priv(dev)->real_dev;
> +
> +		if (!is_vlan_dev(real_dev) &&
> +		    net_eq(dev_net(real_dev), dev_net(dev))) {
> +			params->h_vlan_proto =3D vlan_dev_vlan_proto(dev);
> +			params->h_vlan_TCI =3D htons(vlan_dev_vlan_id(dev));
> +			params->ifindex =3D real_dev->ifindex;
> +		} else {
> +			params->ifindex =3D in_ifindex;
> +			return BPF_FIB_LKUP_RET_VLAN_FAILURE;
> +		}
> +	}
> +#endif
> +
>  	if (mtu)
>  		params->mtu_result =3D mtu; /* union with tot_len */
> =20
> @@ -6216,6 +6235,7 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lo=
okup *params, u32 mtu)
>  static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *p=
arams,
>  			       u32 flags, bool check_mtu)
>  {
> +	u32 in_ifindex =3D params->ifindex;
>  	struct neighbour *neigh =3D NULL;
>  	struct fib_nh_common *nhc;
>  	struct in_device *in_dev;
> @@ -6347,7 +6367,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>  	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
> =20
>  set_fwd_params:
> -	return bpf_fib_set_fwd_params(params, mtu);
> +	return bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
>  }
>  #endif
> =20
> @@ -6357,6 +6377,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>  {
>  	struct in6_addr *src =3D (struct in6_addr *) params->ipv6_src;
>  	struct in6_addr *dst =3D (struct in6_addr *) params->ipv6_dst;
> +	u32 in_ifindex =3D params->ifindex;
>  	struct fib6_result res =3D {};
>  	struct neighbour *neigh;
>  	struct net_device *dev;
> @@ -6486,13 +6507,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, s=
truct bpf_fib_lookup *params,
>  	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
> =20
>  set_fwd_params:
> -	return bpf_fib_set_fwd_params(params, mtu);
> +	return bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
>  }
>  #endif
> =20
>  #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTP=
UT | \
>  			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
> -			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK)
> +			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK | \
> +			     BPF_FIB_LOOKUP_VLAN)
> =20
>  BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
>  	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
> @@ -6541,6 +6563,9 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, sk=
b,
>  	if (flags & ~BPF_FIB_LOOKUP_MASK)
>  		return -EINVAL;
> =20
> +	if (flags & BPF_FIB_LOOKUP_VLAN)
> +		return -EINVAL;
> +
>  	if (params->tot_len)
>  		check_mtu =3D true;
> =20
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 89b36de5fdbb..e00f0392e728 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3532,6 +3532,29 @@ union bpf_attr {
>   *			Use the mark present in *params*->mark for the fib lookup.
>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>   *			as it only has meaning for full lookups.
> + *		**BPF_FIB_LOOKUP_VLAN**
> + *			If the fib lookup resolves to a VLAN device whose
> + *			parent is a real (non-VLAN) device, set
> + *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
> + *			the VLAN device and replace *params*->ifindex with the
> + *			parent's ifindex. *params*->h_vlan_TCI carries the VID
> + *			only, with PCP and DEI bits zero; a consumer wanting to
> + *			set egress priority writes PCP itself. *params*->smac is
> + *			the VLAN device's own address, which can differ from the
> + *			parent's. Only the immediate parent is resolved; if it
> + *			is itself a VLAN device (QinQ) or in another namespace,
> + *			the egress cannot be reduced to a physical device plus
> + *			one tag and the lookup returns
> + *			**BPF_FIB_LKUP_RET_VLAN_FAILURE** with *params*->ifindex
> + *			left at the input. Re-issue without
> + *			**BPF_FIB_LOOKUP_VLAN** to obtain the VLAN device's own
> + *			ifindex. The swap and the vlan fields
> + *			are written only on success; other output fields keep
> + *			the helper's existing behaviour, so a frag-needed result
> + *			still reports the route mtu in *params*->mtu_result.
> + *			This flag is only valid for XDP programs; tc programs
> + *			receive -EINVAL since they can redirect to the VLAN
> + *			device directly.
>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7327,6 +7350,7 @@ enum {
>  	BPF_FIB_LOOKUP_TBID    =3D (1U << 3),
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
> +	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
>  };
> =20
>  enum {
> @@ -7340,6 +7364,7 @@ enum {
>  	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
>  	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
>  	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
> +	BPF_FIB_LKUP_RET_VLAN_FAILURE, /* VLAN egress, parent unresolvable */
>  };
> =20
>  struct bpf_fib_lookup {
> @@ -7393,7 +7418,11 @@ struct bpf_fib_lookup {
> =20
>  	union {
>  		struct {
> -			/* output */
> +			/*
> +			 * output with BPF_FIB_LOOKUP_VLAN: set from the
> +			 * resolved egress VLAN device (see the flag); zeroed
> +			 * on other successful lookups.
> +			 */
>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
>  		};


