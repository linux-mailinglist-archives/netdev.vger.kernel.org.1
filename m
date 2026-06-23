Return-Path: <netdev+bounces-301358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VZrvMpJ1Omoe9gcAu9opvQ
	(envelope-from <netdev+bounces-301358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:01:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796016B6F2E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:01:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=h7AEYe7U;
	dkim=pass header.d=redhat.com header.s=google header.b=hXNkHfPw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301358-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301358-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 432873014857
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2F3D5666;
	Tue, 23 Jun 2026 12:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E968308F2A
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 12:00:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216053; cv=none; b=AkBfGhF26WB/9/3FZfMEfuu02xZfgVW/32aiGUHCbUXvEF8TljPHUmGVRqJPioF0BWjbX8qSqlzy1y4B3S53Cdc56BsgGiGJQqm9qSsTkvBQbls4a9SGT+XgfBfxRKdvkgBwjHalUdYs4aZbgKCXRDz+HI0P0aLybuiIHnZDFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216053; c=relaxed/simple;
	bh=fD1ssBHumg0Z/KRB6UvyA2t+hWd2u9qcEbBZhmVSYkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCuJOju0/7ujd2jpextOsTG1JCvi5pRBV74VHkFId3NJq0e216UQWuZ94RVYEzPzEDvZ60vibFl1ups6/E236FLIp9THr0QiSeutdhJZBoJKD8rC8OXih23QAXXr6C5KUP9Hy59V4DS9yfPcmWQDUWcncKJCp9n/n/n+RhD3wpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7AEYe7U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXNkHfPw; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782216051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fD1ssBHumg0Z/KRB6UvyA2t+hWd2u9qcEbBZhmVSYkE=;
	b=h7AEYe7Udgvqqa80+rOwiPsORBtVDPSaLIeMgy7mSskTzQWGy5xFnB4kUQspDWeJHuh+er
	VcJfr7xWHwU2RJuobmQOz1BjU+qIJMS718qymXaPamTFeLBniXpzQP0mne9rMpH5oGdTB5
	J/j4yOk377cznwUp6kPQ5qdwiwlwT7I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-rLCVWKyAOPq8m1NhXFBZ7A-1; Tue, 23 Jun 2026 08:00:49 -0400
X-MC-Unique: rLCVWKyAOPq8m1NhXFBZ7A-1
X-Mimecast-MFC-AGG-ID: rLCVWKyAOPq8m1NhXFBZ7A_1782216048
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4925bf70f5bso4861585e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782216048; x=1782820848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fD1ssBHumg0Z/KRB6UvyA2t+hWd2u9qcEbBZhmVSYkE=;
        b=hXNkHfPwhev9JdbxkV+JsG0fBqn29LCm85K+2kUKCzPyiHNmyzalmI+PKnN+k4Qbw8
         1wXIguD623gYcPhe+UScZ7jvJD8wMC4kvrMVvJYvhM+LFnn2uNvgml7EmSK7IrmhfRVF
         iR5XRaxn/nhCmwZg6CfduMgAk/nYI0PD6hcTdro4F3qvrZC1RrEoF58jz6Dkqb4cwxLR
         4tc7ELQZmXYVp81ZaRaDGgZQ4bfAlQG9If9YGZH6dz2NXxLl6c2r+FhTTkadOl4bU5gG
         eFdJNvPFBePuOEuNKpVwSRb2hIbdnIxHDzVrl7ullygc9A3DDsqy9wcCcTtsdRppnUNz
         cBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782216048; x=1782820848;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fD1ssBHumg0Z/KRB6UvyA2t+hWd2u9qcEbBZhmVSYkE=;
        b=QMnriqiIaSKkxMKJvdAra0BoDfdhwzBUqRFctm7GbV938I8PEGBoDKsLqj3DMOZy9N
         0YjGwikckS33OQGD20SGmNjOf24d80O5Cv1xM43201wZwC9XnECnfvQz6H/pTfk819oe
         jam+ZAnl/i6pg5CTHFI2ok98YCcJSCITK9ELR8N5WQV220MrURvqNilSmHYTN2PI6I12
         XSAl28EossdhPcptvjTOjPJb7G62oKXnCmpgtAXyHDr0ee1a9v25eqWc3iBAvVCBDxPz
         CbAibWyOxNICdTw5fd3Ycsu2WlOk6Mk4PVVPU6Ltpj5dhjKaa/xsKq1sxzS3YOp0h3AA
         2clA==
X-Forwarded-Encrypted: i=1; AFNElJ9FE0B4vigvcSuCzutgz6nKaKIoJNVotEoRpJArQRwiboJqRtPZI6m/h03T2zscTxMiMpIeyXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOc5HM8E/J7bpaPNnwKdbOwhppQBBI7EfMP7RtPo8WXvasYTae
	/dYYjV98SqSzUfvV4THv2nzoic4dgidOd24q6cVzEEm4zD456Jjs3TLfB7+nxbkHpXXWzU+PRHS
	M40wxQKe7yIwoeQng48rrv55cWUo2ld57+rzvT7R6f9IUneNJcNd57n9DDA==
X-Gm-Gg: AfdE7cls0cp1uHDvkNFwKfpDJqkEJ+QO39itFbtj0hUuSGyG2Z/kkPeoHaZJejDHGkQ
	ZhXYDYkbImATe8ylM5gPaWkk2RbDK25oE1r5VqNweTaUPM6x4qVs4w+Yty1CkfAwcH114x5pCqx
	XJzY5Gie4cv3qP2TYq8UARbqOn11Y6lhWIICe7w/UlhBO7nxImqzUdd+VYW7+BkFohiM1lArKXe
	VcbIZ7TxjpUP3IPyLUTv7217Ei9iVSuyvRnsknR02Z5ltYWmThnUg+LBwBPHwLQcdLWz08iWZvr
	jKywV+QeTTAYckdLQBRIJpMt2G6DaGzf/DQPBMQv6H4ie5H16cuId7duAgCqqwh8b4aJWnO3LX8
	2NTcuqakvcSvH30WmRIIjZdlPA+p83WDzG/k=
X-Received: by 2002:a7b:cb56:0:b0:490:b65f:8b1 with SMTP id 5b1f17b1804b1-49240e22ed1mr202516345e9.5.1782216047217;
        Tue, 23 Jun 2026 05:00:47 -0700 (PDT)
X-Received: by 2002:a7b:cb56:0:b0:490:b65f:8b1 with SMTP id 5b1f17b1804b1-49240e22ed1mr202515915e9.5.1782216046755;
        Tue, 23 Jun 2026 05:00:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944fb71sm273200945e9.14.2026.06.23.05.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:00:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5BC60808C88; Tue, 23 Jun 2026 14:00:44 +0200 (CEST)
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
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag
 to bpf_fib_lookup() helper
In-Reply-To: <20260623025147.1001664-3-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
 <20260623025147.1001664-3-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 Jun 2026 14:00:44 +0200
Message-ID: <874iiteaab.fsf@toke.dk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dsahern@kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301358-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,toke.dk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RSPAMD_URIBL_FAIL(0.00)[toke.dk:query timed out];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 796016B6F2E

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

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


