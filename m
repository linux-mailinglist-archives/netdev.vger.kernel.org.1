Return-Path: <netdev+bounces-301357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dKixH+B0Omrd9QcAu9opvQ
	(envelope-from <netdev+bounces-301357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:58:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 198706B6ECA
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:58:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZNm8GqXv;
	dkim=pass header.d=redhat.com header.s=google header.b=tJnYl6on;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301357-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301357-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6837E303F4F3
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6E23D5673;
	Tue, 23 Jun 2026 11:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E733D522C
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 11:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215894; cv=none; b=JS4hoVIO7eG6/u77hR8Wj9hoqKw/KTjlY7aWXoF4IDTMiil3Yz6r5Ikb114VZLqVjsvEAyHOttgZVQ02DybEyx9W6pqxK0it8CvzA6AnXO/emyXs5WPB9f5BOwNZPLEQCLC6jhDcPXAI+o5jnTc79akoHX+60rUZPsnLxqpn2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215894; c=relaxed/simple;
	bh=ulixYUrLEOLsgmwRBAwj2pdvRxo8++O1KtAgstSzrgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GNTfSmOHtf15GNDaOrlljvKG5Yv07M99f4+9ySVikUNPrU//DX2unQd4tLHw8rWqPS/rxhFWufYHHa4rWOVg6qeRZ2IUbhpZEGGvejR3S9IFGfWd31E6Unixsu6HO67/bpZGr4Rxq0FE59bnyZpdDnhvdREx1xvTCaJsUlgaxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNm8GqXv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tJnYl6on; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782215892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuM2HWZfbdl/+3prcM1vbmw8CO7F/BsLiS5JqG/MJfw=;
	b=ZNm8GqXv2TF0x9LMsH/8Ex3clTgf8O2af2OAAkOJP8kbksufhEe40Yj1i/ugoIX0iJm3bc
	52WJkF44sNERY1GlHytuFUVEhOzcBqWk7vOCYKGIBc3Qk7bQmUf+nrG4o+oP5JSk6k7hc1
	FGsa+l+DpCG03QSbFd42yZtBBDA9gXs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-_jyG_5oEMUi-hTwhajLPDw-1; Tue, 23 Jun 2026 07:58:10 -0400
X-MC-Unique: _jyG_5oEMUi-hTwhajLPDw-1
X-Mimecast-MFC-AGG-ID: _jyG_5oEMUi-hTwhajLPDw_1782215889
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492488f8583so31387435e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782215889; x=1782820689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuM2HWZfbdl/+3prcM1vbmw8CO7F/BsLiS5JqG/MJfw=;
        b=tJnYl6on8ZypLfcdB9JFmp19XC4NuyoatYJHVEoDpea/rZScKEZiHPXr8wuFRF3Zhw
         Lojn34zRD/nX11/hmQ85jsBvenG/pIco1yABbi/IcwNEoZ02HPYZNjjwMSu+eeEPnPmc
         EKXmtrncONzC7yVapMV72zXwvN/XZagSeFob7YMIevoDVBb05F8INtzNHFnH1+Obwf0C
         r/YdDE3cx0IsQ9wa7Hrfl8cINX4hQ79Bahuu+R8jIb2NY8Sdq7hfs6PZL8eediVLCBZF
         T8T7rPvd2+1Em8X3UWuG9xgDCVbDzaKSpVAJ81vt0i51rz8RRHo1xZqWphI5Nc6MQNNM
         t/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782215889; x=1782820689;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuM2HWZfbdl/+3prcM1vbmw8CO7F/BsLiS5JqG/MJfw=;
        b=sk1pAB9VRG1617zvF9Nhc1NXCSoeEDt5nLttaciw7GguhY0CSuUJ2LSc5CfciCRRsg
         YDUrUB2qSTEbmY9r3d5GTLPdfSV2jSqLuzxo5+dSh1Bxna0EB/EXYk/OmkIYi6X1nMsh
         6la/rk7ZBzUhx3YRA9h7gQybJaKuTwQTv1ycHiD2eMnAx5gwWiJapmbAEy2cZQFS/+z9
         KTRhgvDj7nmznly/y5VZvYhQVqd6EycDX0yx72TodrdW4wvhY4tP2HqeIPKBZMlkk10G
         p7sCWVx4QW3zxr9W6QZj1WNMKknB8GsB3U6nwRqacEeBhPbyhcMSBl/nZtDloJ1sOOx9
         P3VA==
X-Forwarded-Encrypted: i=1; AFNElJ8JCgXgwjC4UucVxttBx8CGzGzmaGfToHM0R8L583b6e17eihJw7nRAlB16HTGIFOIVaHktFrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCIOHduAn1SF6Qc8v7iZOnjeO4aIXHkYNJTqp1vsgeGHGAFm/
	kxQau/Ctp5pEocgo3di3/6SWQM5ER44fxgzjd56qKcVzFSbUZIz2ctfKKjpV8zJjBMyZWz58Aii
	FNm1OjnGjUA/JdlrbIZkrVG7bgiUqrneyRra7EyHBf7j4yCnCoGMwPVbs7g==
X-Gm-Gg: AfdE7cnUA2JTUpxJAE+eZHSQhdK8wPtDyUidugayxwAanrppLyQzmep0Hq41jW4EJAT
	2Q5RZloRMk2+liNOVYgglW4GZ0QXasWr2yLCuLEEaKy9DhE2jXPGCKBGY/qUbwlJAauluG32DN9
	n1conj5KDvmNiCT9aMReAUv1PqDVdgfzJgL48oIx9ppBFOyrss3a64haZ1S8NrMTg2RbF/A0tKX
	Jil+1t50J0422s8hNinfk7uyvX7Z3nytHwYlruf/O6fqjHxCNkeHUS1SwTxe5i8cPSQ3tz4FlGP
	e2WqqY00euEbjj+EnItM+HPE44vmpx9GxKBz+7hihiIyxwArXwi4Ualgt20fG08XbXK2bDsZJEv
	NiY8yDJJhdlqUQlApfA0c0zfaqOEhoQ4MHLZWeg==
X-Received: by 2002:a05:600c:4e4a:b0:490:e281:287d with SMTP id 5b1f17b1804b1-4925b34a6c6mr35671055e9.1.1782215889335;
        Tue, 23 Jun 2026 04:58:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4a:b0:490:e281:287d with SMTP id 5b1f17b1804b1-4925b34a6c6mr35669755e9.1.1782215888259;
        Tue, 23 Jun 2026 04:58:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494496d8sm289617055e9.9.2026.06.23.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:58:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5BBDF808C7E; Tue, 23 Jun 2026 13:58:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260623025147.1001664-2-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
 <20260623025147.1001664-2-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 Jun 2026 13:58:05 +0200
Message-ID: <877bnpeaeq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301357-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dsahern@kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,toke.dk:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 198706B6ECA

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

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
> On the skb path without tot_len the deferred mtu check is done against
> the resolved egress device. To keep that the VLAN device rather than
> the parent after the swap, bpf_ipv4_fib_lookup()/bpf_ipv6_fib_lookup()
> hand the FIB-result device back to the caller; the XDP path always
> runs the route-mtu check and passes NULL. When the flag is not set,
> behaviour is unchanged: h_vlan_proto and h_vlan_TCI are zeroed and
> ifindex is left at the FIB result.
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
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 28 +++++++++++++-
>  net/core/filter.c              | 69 ++++++++++++++++++++++++----------
>  tools/include/uapi/linux/bpf.h | 28 +++++++++++++-
>  3 files changed, 104 insertions(+), 21 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 89b36de5fdbb..8d0058d88eb2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3532,6 +3532,26 @@ union bpf_attr {
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
>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7327,6 +7347,7 @@ enum {
>  	BPF_FIB_LOOKUP_TBID    =3D (1U << 3),
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
> +	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
>  };
>=20=20
>  enum {
> @@ -7340,6 +7361,7 @@ enum {
>  	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
>  	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
>  	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
> +	BPF_FIB_LKUP_RET_VLAN_FAILURE, /* VLAN egress, parent unresolvable */
>  };
>=20=20
>  struct bpf_fib_lookup {
> @@ -7393,7 +7415,11 @@ struct bpf_fib_lookup {
>=20=20
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
> index 2e96b4b847ce..8345295d84de 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6201,10 +6201,28 @@ static const struct bpf_func_proto bpf_skb_get_xf=
rm_state_proto =3D {
>  #endif
>=20=20
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> -static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
> +static int bpf_fib_set_fwd_params(struct net_device *dev,
> +				  struct bpf_fib_lookup *params,
> +				  u32 flags, u32 mtu)
>  {
>  	params->h_vlan_TCI =3D 0;
>  	params->h_vlan_proto =3D 0;
> +
> +#if IS_ENABLED(CONFIG_VLAN_8021Q)
> +	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {

If you move the ifdef into the if statement, the if statement can have
an else-branch that assigns params->ifindex, so you don't need the
restore dance (see below).

> +		struct net_device *real_dev =3D vlan_dev_priv(dev)->real_dev;
> +
> +		if (!is_vlan_dev(real_dev) &&
> +		    net_eq(dev_net(real_dev), dev_net(dev))) {
> +			params->h_vlan_proto =3D vlan_dev_vlan_proto(dev);
> +			params->h_vlan_TCI =3D htons(vlan_dev_vlan_id(dev));
> +			params->ifindex =3D real_dev->ifindex;
> +		} else {
> +			return BPF_FIB_LKUP_RET_VLAN_FAILURE;
> +		}
> +	}
> +#endif
> +
>  	if (mtu)
>  		params->mtu_result =3D mtu; /* union with tot_len */
>=20=20
> @@ -6214,8 +6232,10 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_l=
ookup *params, u32 mtu)
>=20=20
>  #if IS_ENABLED(CONFIG_INET)
>  static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *p=
arams,
> -			       u32 flags, bool check_mtu)
> +			       u32 flags, bool check_mtu,
> +			       struct net_device **fwd_dev)
>  {
> +	u32 in_ifindex =3D params->ifindex;
>  	struct neighbour *neigh =3D NULL;
>  	struct fib_nh_common *nhc;
>  	struct in_device *in_dev;
> @@ -6347,16 +6367,23 @@ static int bpf_ipv4_fib_lookup(struct net *net, s=
truct bpf_fib_lookup *params,
>  	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>=20=20
>  set_fwd_params:
> -	return bpf_fib_set_fwd_params(params, mtu);
> +	if (fwd_dev)
> +		*fwd_dev =3D dev;
> +	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu);
> +	if (err =3D=3D BPF_FIB_LKUP_RET_VLAN_FAILURE)
> +		params->ifindex =3D in_ifindex;
> +	return err;

I think it's better to just move the assignment of params->ifindex
entirely into bpf_fib_set_fwd_params(), instead of this restore dance.
That way this can be simplified to:

	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu);
	if (!err && fwd_dev)
		*fwd_dev =3D dev;
       	return err;

>  }
>  #endif
>=20=20
>  #if IS_ENABLED(CONFIG_IPV6)
>  static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *p=
arams,
> -			       u32 flags, bool check_mtu)
> +			       u32 flags, bool check_mtu,
> +			       struct net_device **fwd_dev)
>  {
>  	struct in6_addr *src =3D (struct in6_addr *) params->ipv6_src;
>  	struct in6_addr *dst =3D (struct in6_addr *) params->ipv6_dst;
> +	u32 in_ifindex =3D params->ifindex;
>  	struct fib6_result res =3D {};
>  	struct neighbour *neigh;
>  	struct net_device *dev;
> @@ -6486,13 +6513,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, s=
truct bpf_fib_lookup *params,
>  	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>=20=20
>  set_fwd_params:
> -	return bpf_fib_set_fwd_params(params, mtu);
> +	if (fwd_dev)
> +		*fwd_dev =3D dev;
> +	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu);
> +	if (err =3D=3D BPF_FIB_LKUP_RET_VLAN_FAILURE)
> +		params->ifindex =3D in_ifindex;
> +	return err;

Same as above.

-Toke


