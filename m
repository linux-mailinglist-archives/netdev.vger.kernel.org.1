Return-Path: <netdev+bounces-266306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDvoHmx0sGnJjQIAu9opvQ
	(envelope-from <netdev+bounces-266306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:43:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DD257188
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E54304A6E0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FD3563FB;
	Tue, 10 Mar 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZsdVi2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041E351C3D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171779; cv=none; b=EG40Q9do16ingtH74Fr7ll1ua9JbBYuEDzLs7MNcG9MLq8nK93Ww77z7z+7JZGSaNMvR54HG4YdmshIC2pky/y5Bd2MyFzU3/8wDF32mpvm7n81Za3gZlouoAjVszJuwlW+763XYhAyiLhRWjj7XYj5MDGf6n6nRF1itF/CjYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171779; c=relaxed/simple;
	bh=Xp5cWeF4HbrybahqdWf5fNySKUbdzSzewb3UFHtW5Vg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uQ04yFqKprxSRyOOuOi7ttL6oXFBtKuHFhRgO31oFzmDnohPUjMOgOmdiaH5xWYoy5KTMbUYFWIEpkU5mXRHhccYXx9BZipLzkfUA/QEaLuuOcBQbyb+Ug6oQGJlLiHyABK+gURFrIN4N51CqD14+fTr6E+XJM4mmr9l2ccA+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZsdVi2A; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7985ce90542so128500887b3.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773171777; x=1773776577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZazdfSh9sc5uTQUQsfsPdnqHL0tjvmP+aKPck8iX0h0=;
        b=DZsdVi2A5yxF8CzURNMHL0mXHWUyP8/kYCG78NxLCdL9V0QD+aOCoEHVLnQUz0k/K9
         po1BzsfXAxei5f9g4eRE3Btdimv/kmFc2Iqlw36dSoRB+ZQCClBKvYufivrGliYeqrfo
         9JnkjLbJmJ1MnXngD6jLwjn4zrnV2yZ7DudaYNJgh5b7vExf0H2/GxnED8B60qt+TJqc
         MrjJJ1VsiX7gKt2EREGzBMXig5dGS4c+x9kq+/la2sMMjaWBjnr0DYbmcGc7NWmS973u
         5opU9RzgCibnKKPjARJs8A7Lzhi6CVxlNv5IZLWSO4idGAVh/cDMPXqgS6M/ppBh4YNX
         R8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773171777; x=1773776577;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZazdfSh9sc5uTQUQsfsPdnqHL0tjvmP+aKPck8iX0h0=;
        b=K9C7Er7F6rhXJjpLz7x5iOLNV6+Sc5yHMAtTM0u/egno+XB3iX76yQOo5vU2IL3K2d
         dqE50I2bvKczb31UP0H73v/dHJCFPGE7iktJHAlAkBNrzB1bLwKqMOOXmII59fNic7W7
         u3DfVAzpqpmNeiUjtS9zBpeBsi2yfPsh5OmuQu2L/SfzmC6Eu6oIZZSnGPCC4lw5UULQ
         FcHMexAYq4TgGakFIpDj67+EdlcSqzrLaImgxDVHQghDtDsZDQtiTVB/LExUDpp//Wpn
         aLdLzlHquensxD8+y9NN6IaWRZ3ht9GKtQqz7oEzIQn9SuYfRSiGdX10UoAJgnl/rO5a
         cOSA==
X-Forwarded-Encrypted: i=1; AJvYcCWpGwuroJwAVwbmeVtw45u5lZ6O4N9HPREepeISMDakrEQZNoXxhusQrqukALOZCb3fryguQSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7VQj48PcFE4VshCrcHZMDZ6yUW6CmtC21f6xfLsxr02O9lF7p
	S6CAZId3eeq80BmREp0v3jPSy34kMyt3i/y4x28z6Gn6wnVmeWA5poIZ
X-Gm-Gg: ATEYQzwVRUc4LRfSQm4W93d6rKwjF86C+RFAfAS99Cud1evcms3VAKNnLLt3Snea7q8
	EhZY/lY8oCHkT8yMMR1PyZ1BFt0jrdUP14g0+goultpSicQCmqaNC9tHZG8/ZzcauJkkzctwJld
	r7WhXpb/O8fptm/aJiv1KtkYpcVTKnv4OkrCoFyhrYG2YPeS9H2n1vnK62P1yNN2PK749YE7pvr
	xFVXQydp/Lvi9Rt1D7Hi6rlrK25AvcRDS10reRHiIb0Nj80zs3gIanPPJScPgoXgplbOU5stjjP
	0KEMFztw5NU6JwBo4SpMqzdnZJqvvAUkRN3QvucmIuUJ5yP63nnPKg4tiOCZ5fOm1muUp/X39+0
	Y6SrJxrUxPrhNMt3QFzykD7yCpOAGWbgetDFHSnfQl+p05j222838rSwKd/Fjrw98/qCnk97Qxu
	TeOvkHOkLDn1OlI8aqh2nj9XkudrjzkPUULHntWq1t9CA/NnAlR7voq0u2gbeZ17s0UZEO+hypw
	aT6Xtavls92WPU=
X-Received: by 2002:a05:690c:c0b:b0:798:68a4:15c5 with SMTP id 00721157ae682-798dd78020amr158895557b3.38.1773171777277;
        Tue, 10 Mar 2026 12:42:57 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7990a54d3f5sm21712357b3.22.2026.03.10.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:42:56 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:42:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Hudson, Nick" <nhudson@akamai.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Glasgall, Anna" <aglasgal@akamai.com>, 
 "Tottenham, Max" <mtottenh@akamai.com>, 
 "Hunt, Joshua" <johunt@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Paul Chaignon <paul.chaignon@gmail.com>, 
 Mykyta Yatsenko <yatsenko@meta.com>, 
 Tao Chen <chen.dylane@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Tobias Klauser <tklauser@distanz.ch>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.326800cb16195@gmail.com>
In-Reply-To: <58BD9063-C619-45C4-AB60-CCA40E391A52@akamai.com>
References: <20260219104710.1490304-1-nhudson@akamai.com>
 <20260219104710.1490304-2-nhudson@akamai.com>
 <willemdebruijn.kernel.5766d0a10c73@gmail.com>
 <7C8018C7-B0E2-435F-B155-60F29BCF5018@akamai.com>
 <willemdebruijn.kernel.7c6e5a81afba@gmail.com>
 <58BD9063-C619-45C4-AB60-CCA40E391A52@akamai.com>
Subject: Re: [RFC PATCH 1/1] bpf: Add tunnel decapsulation and GSO state
 updates per new flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D72DD257188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-266306-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,meta.com,distanz.ch,vger.kernel.org];
	FREEMAIL_TO(0.00)[akamai.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hudson, Nick wrote:
> =

> =

> > On 25 Feb 2026, at 15:45, Willem de Bruijn <willemdebruijn.kernel@gma=
il.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!=

> > =

> > Hudson, Nick wrote:
> >> =

> >> =

> >>> On 20 Feb 2026, at 21:08, Willem de Bruijn <willemdebruijn.kernel@g=
mail.com> wrote:
> >>> =

> >>> !------------------------------------------------------------------=
-|
> >>> This Message Is From an External Sender
> >>> This message came from outside your organization.
> >>> |------------------------------------------------------------------=
-!
> >>> =

> >>> Nick Hudson wrote:
> >>>> Enable BPF programs to properly handle GSO state when decapsulatin=
g
> >>>> tunneled packets by adding selective GSO flag clearing and a trust=
ed
> >>>> mode for GSO handling.
> >>>> =

> >>>> New decapsulation flags:
> >>>> =

> >>>> - BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
> >>>> (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
> >>>> - BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
> >>>> (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
> >>>> - BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
> >>>> IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
> >>>> - BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
> >>>> IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
> >>>> - BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
> >>>> SKB_GSO_DODGY when the BPF program is trusted and modifications
> >>>> are known to be valid
> >>>> =

> >>>> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> >>>> renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -=

> >>>> Run Everywhere) lookups in BPF programs.
> >>>> =

> >>>> By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
> >>>> gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses th=
is
> >>>> for trusted programs that guarantee GSO correctness.
> >>>> =

> >>>> Usage example (decapsulating UDP tunnel with IPv4 inner packet):
> >>>> bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
> >>>>                     BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
> >>>>                     BPF_F_ADJ_ROOM_DECAP_L4_UDP);
> >>> =

> >>> This patch is doing to much in one patch.
> >> =

> >> Sure, I=E2=80=99ll split it up.
> >> =

> >>> =

> >>> Also not convinced of the need for the NO_DODGY flag.
> >> =

> >> The reason for NO_DODGY is that, without it, the egress interface wi=
ll see the
> >> SKB_GSO_DODGY flag. In our use case, we want to avoid marking the eg=
ress tap as
> >> NETIF_F_GSO_ROBUST, so the skb will fail skb_gso_ok() with SKB_GSO_D=
ODGY set.
> >> When skb_gso_ok() fails, validate_xmit_skb() calls skb_gso_segment()=
.
> > =

> > I understand why you might want it. But the dodgy check has long been=

> > there for a reason: becauses these transformations are not blindly
> > accepted by the kernel. This use case does not change that.
> =

> The defence I came up with here is...
> =

>     - setting NETIF_F_GSO_ROBUST for the tun/tap device, as it is a dev=
ice level property, affects both host to guest and guest to host. the for=
mer is trusted. the latter is not. therefore this is not an option.
>     - the host to guest direction is fully trusted
>         - Physical NIC driver is trusted (kernel driver, hardware-valid=
ated GSO)
>         - BPF program is trusted (privileged, CAP_BPF, verified by kern=
el)
>         - Decapsulation is trusted operation for BPF code authors
>         - Bridge + TAP is internal kernel forwarding
> =

> Would protecting its use with a sysctl make it acceptable? (If it isn=E2=
=80=99t still)

Is the DODGY path and going through GSO a significant impact to your
workload?

So far we have always declined to add such custom opt-outs. This is
not at all the first affected user case.

Either way, let's separate this from the main functional decap patch.

