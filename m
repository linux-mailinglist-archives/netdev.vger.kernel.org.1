Return-Path: <netdev+bounces-297274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LnlsMch0KGr9EwMAu9opvQ
	(envelope-from <netdev+bounces-297274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:17:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814C6640E7
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:17:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=JS4NESIi;
	dkim=pass header.d=redhat.com header.s=google header.b=tmdqwAyV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297274-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297274-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24948305C580
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E937A4B9;
	Tue,  9 Jun 2026 20:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932C36F918
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:14:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036078; cv=none; b=CY0fw1z/YEw6DUNXLy4CCeCO8cz6vymFt3G2I4XNFCCcVK/nhJaK3zlT67ENxUDTcfVHojkUQkqWaF7mKcsrJO90eqZLqySJtgkcL5KdFOkh+rVSJgwH1SnUw9TJ+D2v0vUqF/6zfbkRaAPj9olm8Fv5ucLr/Z10ivtVzIiEJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036078; c=relaxed/simple;
	bh=hprTfB754mLY1EMoptmcabMyk8Qi2IBNgYxDZtI+sD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fTCn1MLNk5g6n0/pLX6LiopqMroyJ0VxE/rW2fGW6xjqXWgtb9NjUGT6OdhH1lOUc+/xkWS7Gp9+fR2eHEWuDjegV+XGfsqlc+iNr/8ioGHsnD+BFUWy+AA6++apgd5aGmCxcuQe10rVOCojCC1ByHgyk5gA8jbQQ5TGd2XOxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS4NESIi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tmdqwAyV; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781036076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hprTfB754mLY1EMoptmcabMyk8Qi2IBNgYxDZtI+sD0=;
	b=JS4NESIi8uIDfQb+NZsLbDIbpI5JPVMx+3iW7ayX7HnzYCT/XbKmU4m5OK2hZzPflMeEL0
	VABktHeiOvgwUWWm9rvkmS6F4FbxDxaROESohspd41pepmfqi99VD+At/AXyKp+swteOlI
	iJumZofZ6+HPRV6u825Lk76CHD66xO8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-F9DL9Gc8PJGN90lKvwzZ_Q-1; Tue, 09 Jun 2026 16:14:34 -0400
X-MC-Unique: F9DL9Gc8PJGN90lKvwzZ_Q-1
X-Mimecast-MFC-AGG-ID: F9DL9Gc8PJGN90lKvwzZ_Q_1781036073
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b0682d2fso56659795e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781036073; x=1781640873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hprTfB754mLY1EMoptmcabMyk8Qi2IBNgYxDZtI+sD0=;
        b=tmdqwAyV8sweQ+4yf72Tfz1NqU+yJbIV5m7Wcc6lUrH/KqEhlpdHmf2zHMgU67fCZn
         zmedDU1OTZ/P7jn9LkWfOATk1HrVodlYM3sEEVbDIJczdmKsjZlfHxdjyk1pao1cmiAR
         7quodlGILi7ydUjojrvZo0/QO7F5mxJiJwCkj8n9h3dllKE40cc13tl4VFALvVnd8L/C
         SK/QvYd3qOwkOwPu7/q3ViDmRUcpKEc06OoM4MgLMB1fJghefDDX1HMd75iekgdDD+Fs
         0PCidiUQMbgJzvk1+UPEx8FMZkkUzS7zUjqy3NVKbir6+r+6wlDzPkCQAWgVoP641IIZ
         1TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036073; x=1781640873;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hprTfB754mLY1EMoptmcabMyk8Qi2IBNgYxDZtI+sD0=;
        b=gsM8bsxKUH1brpxH7IRNr2k+zjIFPQ4NuAR1myJ2aI9smMP9VLWK2qXRuHkQS6kz22
         awglki1GYyLLrDndwAmchQL9cbLDPY3MLgnQs0wvDiJOU8kYmAi6fqxcKyNjA6+wPEWn
         BJv5MHtLospi7CmqbhFeKwoYMgs5ojMvpLDIKao36G3Ng3/viAKwXb6mUOcCwtWZlech
         yrIAQYy9wg83mtF1WdbgDtxr7w+2c1lKssPJ2SovDqM1GBTwU4UlRaN1faJ3eJh9S2OM
         N0W11rtMx4A5jgWiwpfEb59aS0+32Jn6IsSa1zgXfcrgKy0QPwo7Z7B2SLI07lS6Qc9a
         eE0g==
X-Forwarded-Encrypted: i=1; AFNElJ8Me4MO3KgMnL1HHuYHUgPG2h98Fo0dgMDeIxfNQEp04qpSiode1W9j10CUlQhUH5NctpxBrwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypY0agTCgOmw6957eE3kx+BrrbmgH2vuG6gSLNTXnsxleNd/tq
	QtRvQgGiDxJQPWRx8x9t1Y7tu298vPFUDixeZ7NCwNfzb4exHbYaaeCeQXTbX/4dYa5MjB4VSEt
	bMzWNxPqUhxZzyBbWxfWwuF4uveHK4JePS3DsRdRCyEXrPHbMKe2D0Kzanw==
X-Gm-Gg: Acq92OEj1qqExxxflPShZVrz4ttuR2aRNxR2HGhBWu2pHeqBD6gJutpZkq4xQk+94Qh
	5E++do0Mkv9HC+Wovg2iOt8J54rfVuAKZK7B97S9bRAc0woPSC1IEWYPlJwDbF8/kbcGnbi9xNs
	xtftDib68RS3uOglTu5r+xwCRxr1pVEUSDsn3+PcBT2eu/z3XZF9VA3N4Wfevbk80JbeTNCrOIT
	LDlmsrc3U6e/pmauORYBv1hqm8UYY9piOO3bo6gSpKsAy1nFnP5lXGvsb9KQjjmEg/eOMVxtcgP
	JQCs4smyaa15Shg/ANIef16sJnpnHc3W32tGEzR9a0W6WakSKtFDJE8mojn6KQNlv80Jurfsz5/
	J9gi2YyoZKiaimVCkaAjpKYvn5n5P4efsiuVcLNtj9F6X9TfJLQnitshi99E=
X-Received: by 2002:a05:600c:a086:b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-490c259f616mr361087345e9.10.1781036073025;
        Tue, 09 Jun 2026 13:14:33 -0700 (PDT)
X-Received: by 2002:a05:600c:a086:b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-490c259f616mr361086915e9.10.1781036072659;
        Tue, 09 Jun 2026 13:14:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm460746815e9.3.2026.06.09.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:14:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ADE4C7BC400; Tue, 09 Jun 2026 22:14:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, KP Singh <kpsingh@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260609172052.81613-1-avinash.duduskar@gmail.com>
References: <20260609172052.81613-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 09 Jun 2026 22:14:30 +0200
Message-ID: <87a4t3a2u1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297274-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hawk@kernel.org,m:kpsingh@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2814C6640E7

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
> result is a VLAN device, populate the existing output fields
> params->h_vlan_proto and params->h_vlan_TCI from the VLAN device,
> and replace params->ifindex with the underlying real device's
> ifindex. params->h_vlan_TCI carries the VID only, with PCP and DEI
> bits zero; a consumer wanting to set egress priority writes PCP
> itself. Only the immediate parent is resolved; stacked VLANs (QinQ)
> are not walked. When the flag is not set, behaviour is unchanged:
> h_vlan_proto and h_vlan_TCI are zeroed and ifindex is left at the
> FIB result.
>
> This lets an XDP redirect target the physical device and learn the
> tag to push in a single lookup, which xdp-forward's optional VLAN
> mode (xdp-project/xdp-tools#504) wants from the kernel side.
>
> The change extends bpf_fib_set_fwd_params() to take the egress dev
> and the lookup flags so the VLAN swap happens in the same place the
> vlan output fields are zeroed by default. Both IPv4 and IPv6
> callers pass through. The helper's input semantics are unchanged.
> Under !CONFIG_VLAN_8021Q, is_vlan_dev() returns false and the new
> block is a no-op.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Other than the bots' comment, I think we should make this bidirectional.
I.e., it should also be possible to supply the vlan tag from the packet
when doing the lookup.

This requires a second flag, which has to be exclusive with
BPF_FIB_LOOKUP_TBID, as the tbid field unfortunately overlaps with the
VLAN fields (so they can't be used together as input).

-Toke


