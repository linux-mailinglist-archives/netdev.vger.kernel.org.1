Return-Path: <netdev+bounces-300104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id byCZEdJuMmqOzwUAu9opvQ
	(envelope-from <netdev+bounces-300104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:54:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911AF698233
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hIWmu4s9;
	dkim=pass header.d=redhat.com header.s=google header.b=ExKhtE1L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300104-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300104-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FEDC31D3071
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47553A1A3F;
	Wed, 17 Jun 2026 09:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDA39D6DD
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:43:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689381; cv=none; b=DbyD/T1tTXfpEA9C3giGKgM88zYxdH6ZIHJ28hITcKFSBMA17BeMlxSCchV65KKyef+mQsrk990WkXzRlDc25W3yxY2rx7caTRn13JHFQXoB7bv6f3FWoPG+c0S0wNp8f9C41VSe85+sBf9NT01aXMd+ludzCQ5qzJhjIZINOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689381; c=relaxed/simple;
	bh=6dk1V2FkwIjUDraVd9ebLKZ6skrFu0NoYQrzqg9QeDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LVxNizZBqzKL0CKi+6TMCBTG9dq5Psv4ZFw9aHeo0xGk4FFLMrSzinAGkKyi865Mh8QqBR5xAWvR/2HzJGOK4o0KFDzEyGW64OpXcZWqjBgctz8knKZ/wYnnIDFlnqCPp1WaeRKd7oRdeI3/Oq++v9vKtn7DzzOMkaG0x/TOoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hIWmu4s9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExKhtE1L; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781689379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozmBpImS8oeWooI3eg5F7+EjraI/5E3NnIle2PdR8uw=;
	b=hIWmu4s9Rxruex8hxqgHpz9ZxtezH5DE6NhzkCOXv7x4UslDLrRdMoS2+nf1IWYvniSiQu
	KUL4Cj1n0kc6VqV6nZTy+iEDxItCWUPIRLgtuD+slJd4t7Y/eU6UnBBKTJfGV34nwNz64X
	BNS+NZQHi7DA6t/JsyuOyBgrnnMjUyI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-0vaI-D4rNfOPpkMK8ePEMg-1; Wed, 17 Jun 2026 05:42:58 -0400
X-MC-Unique: 0vaI-D4rNfOPpkMK8ePEMg-1
X-Mimecast-MFC-AGG-ID: 0vaI-D4rNfOPpkMK8ePEMg_1781689377
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490c840efe6so7174575e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781689377; x=1782294177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozmBpImS8oeWooI3eg5F7+EjraI/5E3NnIle2PdR8uw=;
        b=ExKhtE1LQVvWuOJR+cmR/EVFSOQuYdEGrodZfVZ0P0/AEM35HQep2W4Jra0kkFagGy
         LRdD9nmY/mlIvtPM8vqcw6eV/WmOfAIi15FcYVp1ELeXhmth3kesItjJW01n0sR3Ja1f
         x3iVpwDU+SIci+9fo6+Oj+t797ibT8PVcHuHPZ1XoWqEoWcMtxiUeoeQjwMdP23WSAHu
         KBRooVSupDi91wmsKJM6r+MYHX/D7pv2GYy+GFzVIzZlKrD/PFYkfgtAhio3v3oE/vdr
         GSS7UkkbgJ6Ivx9av4ceOes3MM/4stPEybdw1NtTmc1DjQb9pahB9jcv54JrpLUrjS8n
         nNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689377; x=1782294177;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ozmBpImS8oeWooI3eg5F7+EjraI/5E3NnIle2PdR8uw=;
        b=MyP6D2T9R2vvflXW4SSjnadzxqy26EU4Nmbe7ebbxq8mGFVF9+pRqOF9e1rTmVkDIs
         xErFHB8CAjkUOAKKqFRAoqKYfaNqpO7xTjSC41IqVkB2ObMjK/G16x5BUhRnDcwdGSa0
         xw+xJaXKl3KzGrTrL1GhCqPPS1nSLwgic+B85Rk3nspuGUR12qEHpodlTPMSXtizuZ+9
         MuYrx0Q7Q3BKrGznCu4FawvA8gVyHzp/wGrawFCRgrW4MzzSMYMQIIvDXiPGWuFhlMKu
         7gD4miMqEi6nkJ24ca4tKx1GHQu6HYhAyt9SGLQk5fTwgnHcctow9NvCKKaioIJhRp7Y
         G4Wg==
X-Forwarded-Encrypted: i=1; AFNElJ8fALsG27sFwISpE6Srk619pqaOnfNNkz7xAcxZsuvz1v3uzcXpnMiWDEeR1MqdDM6L8RJyd30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5Q2J0BYDdp7L9nmVpK9q/wZdMbZUo0zqQk8yZDkcnh9VOPDw
	K+t8aProp4tlrmK5WeYRPCRCAL7VEaZTkb4NWPO+Ykh4KLu4SNyLlLvhC1r7ISwdPc/0Alxh9g+
	DTmBxvJMggoVA1SBfXOrwuX/VJ9sARlVyJIWWrsZFft3RkxYoA1o9iqur0A==
X-Gm-Gg: Acq92OGuF4fqWNERiv9E9bHyuBKPe4TmKPhoexLQVePHS57CXqPJ2u5b234sP4CEE0z
	hEJOOfjfJrJwomIDmJIXt1Z+yRyMp785Q3VEET+ZpOWV3jVek/J4dsWgSvIYfTyYQDFg7e11Slu
	VU9UP2JuC4C3d3vhXjEDGItYx4vRaIccplGa01bw8SL16vAaR1XUOajKjXG5fAuSM+0sY0PQAr6
	146zziBUYFQA+iF8ocRfv1NC/C+La6CthQT/LsgkXpq9DtGNNsxR5AF9/e1Nl/Mc13ATSjz8GRg
	KkejgkXKPV02yKaERj86YuzIhd4AAJWjAApIyiPSqedvvGfuKHhwYNjJ91LFtVrUvIYDpv3r2zR
	VHLchkQ9G2EezBOrjwsthHkoqrzriJ3kWW8QhaQ==
X-Received: by 2002:a05:600c:46cf:b0:490:b4cb:3866 with SMTP id 5b1f17b1804b1-492340e7632mr28942665e9.10.1781689376549;
        Wed, 17 Jun 2026 02:42:56 -0700 (PDT)
X-Received: by 2002:a05:600c:46cf:b0:490:b4cb:3866 with SMTP id 5b1f17b1804b1-492340e7632mr28942185e9.10.1781689375972;
        Wed, 17 Jun 2026 02:42:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa8b423sm146401065e9.11.2026.06.17.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:42:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D20C38074C9; Wed, 17 Jun 2026 11:42:53 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Mykyta
 Yatsenko <yatsenko@meta.com>, Leon Hwang <leon.hwang@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, Amery
 Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>, Rong Tao
 <rongtao@cestc.cn>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag
 to bpf_fib_lookup() helper
In-Reply-To: <20260616223426.3568080-4-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
 <20260616223426.3568080-4-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Jun 2026 11:42:53 +0200
Message-ID: <874ij1h59e.fsf@toke.dk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300104-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:eyal.birger@gmail.com,m:rongtao@cestc.cn,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,toke.dk:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 911AF698233

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> BPF_FIB_LOOKUP_VLAN resolves a VLAN egress. The reverse is also
> useful: an XDP program receiving a VLAN-tagged frame on a physical
> device wants the lookup to behave as if the packet had arrived on the
> corresponding VLAN subinterface, so iif-based policy routing and VRF
> table selection use the right ingress.
>
> Add BPF_FIB_LOOKUP_VLAN_INPUT. When set, params->h_vlan_proto and
> params->h_vlan_TCI are read as an input VLAN tag and the matching VLAN
> device of params->ifindex is resolved with __vlan_find_dev_deep_rcu().
> The device must be up and in the same network namespace as
> params->ifindex (a VLAN device can be moved to another netns while
> registered on its parent; receive would deliver into that other
> namespace, which a lookup here cannot represent). If params->ifindex
> is itself a VLAN device, its inner (QinQ) subinterface is matched.
> For a bond or team, a tag on a port matches no device and returns
> NOT_FWDED; pass the master's ifindex.
> The lookup then runs with the resolved device as the ingress;
> params->ifindex itself is not modified on the input side. When the
> resolved device is enslaved to a VRF, both the full lookup (via the
> l3mdev rule) and BPF_FIB_LOOKUP_DIRECT (via l3mdev_fib_table_rcu())
> select the VRF's table from the resolved ingress. That follows from
> feeding the resolved device to the flow as the ingress
> (fl4.flowi4_iif =3D dev->ifindex), which is what makes l3mdev resolve
> the VRF master from the subinterface rather than from
> params->ifindex.
>
> The two failure classes get different treatment on purpose. A
> h_vlan_proto other than 802.1Q/802.1ad is API misuse and returns
> -EINVAL, since it would otherwise reach the WARN in vlan_proto_idx()
> with a program-controlled value. An unmatched VID, a device that is
> down, or one in another namespace is a data outcome and returns
> BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
> fib_get_table() finds no table and mirroring real ingress, where the
> receive path drops such frames. A VID of 0 (a priority tag) is looked
> up literally and normally fails the same way; receive instead
> processes such frames untagged, so callers should not set the flag for
> priority tags. Proceeding on the physical device for any of these
> would be fail-open for the policy-routing cases above.
>
> The h_vlan fields share a union with tbid, so the flag cannot be
> combined with BPF_FIB_LOOKUP_TBID. It describes ingress, so it also
> cannot be combined with BPF_FIB_LOOKUP_OUTPUT. Both combinations
> return -EINVAL; restricting now keeps a later relaxation backward
> compatible. Combining with BPF_FIB_LOOKUP_VLAN is allowed: the tag is
> consumed on the ingress side and the egress tag is written on
> success.
>
> Under !CONFIG_VLAN_8021Q the __vlan_find_dev_deep_rcu() stub returns
> NULL, so every lookup with the flag returns NOT_FWDED, which is
> correct since no VLAN device can exist.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 34 ++++++++++++++-
>  net/core/filter.c              | 80 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h | 34 ++++++++++++++-
>  3 files changed, 141 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f77aa9472bf1..57e28da3336a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3552,6 +3552,35 @@ union bpf_attr {
>   *			reports the route mtu in *params*->mtu_result, and on
>   *			the tc path without tot_len the mtu check runs after
>   *			the swap, against the parent device.
> + *		**BPF_FIB_LOOKUP_VLAN_INPUT**
> + *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
> + *			as an input VLAN tag (e.g. parsed from the packet) and
> + *			run the lookup as if ingress had happened on the VLAN
> + *			subinterface carrying that tag for *params*->ifindex,
> + *			rather than on *params*->ifindex itself. The VID is the
> + *			low 12 bits of *params*->h_vlan_TCI;
> + *			*params*->h_vlan_proto must be ETH_P_8021Q or
> + *			ETH_P_8021AD in network byte order (any other value
> + *			returns **-EINVAL**). The
> + *			subinterface is the one configured for that tag on
> + *			*params*->ifindex; if *params*->ifindex is itself a
> + *			VLAN device, its inner (QinQ) subinterface is matched.
> + *			For a bond or team, a tag on a port matches no
> + *			device and returns NOT_FWDED; pass the master's
> + *			ifindex.
> + *			If no matching subinterface exists, or it is not up,
> + *			or it was moved to another network namespace, the
> + *			lookup returns **BPF_FIB_LKUP_RET_NOT_FWDED**,
> + *			mirroring real ingress, which drops a frame whose tag
> + *			is unconfigured or whose VLAN device is down. A VID of
> + *			0 (a priority-tagged frame) is looked up literally like
> + *			any other VID; receive instead processes such frames
> + *			untagged on the device itself, so do not set this flag
> + *			for priority tags.
> + *			Cannot be combined with **BPF_FIB_LOOKUP_TBID** (both
> + *			use the same input fields) or **BPF_FIB_LOOKUP_OUTPUT**
> + *			(this flag is ingress-only); doing so returns
> + *			**-EINVAL**.

This comment is also overly long - please trim.

>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7348,6 +7377,7 @@ enum {
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
>  	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
> +	BPF_FIB_LOOKUP_VLAN_INPUT =3D (1U << 7),
>  };
>=20=20
>  enum {
> @@ -7416,7 +7446,9 @@ struct bpf_fib_lookup {
>  		struct {
>  			/* output with BPF_FIB_LOOKUP_VLAN: set from the
>  			 * resolved egress VLAN device (see the flag); zeroed
> -			 * on other successful lookups.
> +			 * on other successful lookups. input with
> +			 * BPF_FIB_LOOKUP_VLAN_INPUT: the VLAN tag to scope
> +			 * the lookup by.
>  			 */
>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b37a12321fba..cfbdd842ce61 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6158,6 +6158,41 @@ static int bpf_fib_set_fwd_params(struct net_devic=
e *dev,
>=20=20
>  	return 0;
>  }
> +
> +/* With BPF_FIB_LOOKUP_VLAN_INPUT the caller passes the packet's VLAN ta=
g in
> + * params->h_vlan_proto and params->h_vlan_TCI; the lookup is done as if
> + * ingress had happened on the matching VLAN subinterface of *dev. Resol=
ve
> + * it and store it in *dev. params is not modified.
> + *
> + * A protocol other than 802.1Q/802.1AD is API misuse (it would otherwise
> + * reach the WARN in vlan_proto_idx()), so it is rejected with -EINVAL. =
An
> + * unmatched VID, a matching device that is down, or one that was moved
> + * to another netns (receive would deliver into that netns' stack, which
> + * a lookup here cannot represent) is a data outcome, reported as
> + * NOT_FWDED, the same way the DIRECT path reports a missing table. Under
> + * !CONFIG_VLAN_8021Q __vlan_find_dev_deep_rcu() returns NULL, so every
> + * call returns NOT_FWDED, which is correct since no subinterface can
> + * exist.
> + */

As in the previous patch, please drop this comment.

> +static int bpf_fib_vlan_input_dev(struct net_device **dev,
> +				  const struct bpf_fib_lookup *params)
> +{

Just return the dev pointer and use ERR_PTR for errors? That's what we
usually do for these kinds of functions.

-Toke


