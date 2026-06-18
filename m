Return-Path: <netdev+bounces-300388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ywg0DYvDM2q4FwYAu9opvQ
	(envelope-from <netdev+bounces-300388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:08:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241969F1BB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:08:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=dD7GQ3kW;
	dkim=pass header.d=redhat.com header.s=google header.b=BlNso0af;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300388-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300388-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA8BC3028D19
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DFE3E00AE;
	Thu, 18 Jun 2026 10:07:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503E3ACA77
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:07:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777270; cv=none; b=VifSHX0ibllvAlKE7M+5FC3SNKIjDUCytzfKEhhf/Onc3hEy0NKaebhtUZkh1wL4Ll+J+5jtQuMSm+uiTLhf+HqZ/ZXM03SeL0Oyfd6b1HNZmqbi+EKvI4Ga+yGKDWOlx3brA4tSDoi0FixRs6YKRV+GQ8igcSqXToyYd4wGbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777270; c=relaxed/simple;
	bh=BCnhMXpiNt6GeK/JNZegIFyy6D8zcdHM6e+0Bxca6Ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HZXEAxEBuCTr/GbtNrobJHCksCm7xiNiHlLr1JvXoDMhumCmL7BmxDzrA7vUssc9V/DaMm+CmBb+BXjfGzC1o1ylnk84XzeyUcJG3vGtgmVRhmxUS485jOUGprbWiNplvvcXH+QAx8KTU/RAPfi5m8qlb63Q8WQGf/FyJmIu35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dD7GQ3kW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlNso0af; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781777268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H2D+VZ/Tj0mUVDsv+aTtPFKUCIWgmNxSZBVstBUBcWw=;
	b=dD7GQ3kWJX8vjuokrZNaD8F9I29d3DP9EAzK1Hh9Nl6tU637SkNpsLy2MnL9vycAuWJCaT
	ap3YWE0N4F2LSjLD3CJVg45Ke8nQdeUZr0Pa0cqFrAjb2Tl0RJLIiTVFpmRNK7NTT8iY62
	YEKqWQHAc8zfjC5CoS8to3lWfPqU418=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-YnqXxOLDMhqtNrfTPqLX4w-1; Thu, 18 Jun 2026 06:07:46 -0400
X-MC-Unique: YnqXxOLDMhqtNrfTPqLX4w-1
X-Mimecast-MFC-AGG-ID: YnqXxOLDMhqtNrfTPqLX4w_1781777265
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-461e0dad8easo513909f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781777264; x=1782382064; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2D+VZ/Tj0mUVDsv+aTtPFKUCIWgmNxSZBVstBUBcWw=;
        b=BlNso0afPaiSvxBB6f5/68vwG3CqZVg+02CbcYz34zMqrVu+OkpZGJyf+Qzd3NEcWe
         rRqNJjH2VUZIESv32fhmWNFWXXntp7DNxDR+bh2n1cxQILuVLENGNONebB1PQLLJEBTk
         dlv1Gfiqn/tW93IwxdbUhIM6IJOaU/X4C2KcwqZ5+zBXBaKOWgF84NhHKs3iSNsLpAiF
         /l8q5X9lm4Z1QICHKgfFvbv105u7XgSOSTmkVc71DvJjAA2IgOheplZev5YXwcHW57yP
         iTDDcfjNBy9v44ODQqaHkaS0YPl/nTfhOxqIT6Ptxfcg609IqAYj5k6oNxmqd1FQV2Xk
         dVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777264; x=1782382064;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2D+VZ/Tj0mUVDsv+aTtPFKUCIWgmNxSZBVstBUBcWw=;
        b=KXHzNRQp08ZSK4gekijbApCwJPymA1H22bgItF3bKvKzBs5Nh5qsdisXWEHpO9vZ1g
         21p2XC2NlJ7mtgY/8j8t0aag/xM6Irtq8ID4M2L0aSbTFbmwoT5kwczqaf5m877Quy8e
         gcEBIQ5ImhgmMeBh4Q0j5dTDVph/3ci4QIkUziw26MF8wkx4Y5W1w4c+tUSMcYHin4b1
         DdVCuUg2ouLQNRfbIxNNUIx8UKuJepDj45xHkGi1HYA8cyqrBDHCcN9jZRf3j6I3Di5o
         cOZX+mDeehvb4isGH91YXbh8mec3DL0F084vzcEp0MNWciE+slTSya999egNVE02RC9z
         Baww==
X-Forwarded-Encrypted: i=1; AFNElJ/wjCvqVEo33oRyViNSDQr2E7KObf4dLy17LEuGtvJEjJFwmG2gkkjB9eMreyfqToFFOINGl4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGb+kfUpVyl9hK20ennPmPQzYdEHSBc01HK5+dZwlLN63PZjfQ
	Ih/nfnRmlAfmgqfMpUbEN3VWpWSiXLxOgmrvDXGQkI/YRocuD1TWv+kuXlFQEvrjDQ2JHnvoXAp
	rzy7NdCz5EP+2qH86e0pz1gCEpvbjhbqMuL7cUDqXatiQbG7U4/Kwu39LPw==
X-Gm-Gg: AfdE7cl7LElCPLetpaWYXpBHRqVIWzT+XLlH3v4AOLye3hhnU2xvNZunG/PElMcZoEI
	dteGHWTyUZJ+daixKiA2c6amsWd+CMkwBQY4RUu4lw7hWEZeAd7sLii5Q51NS+Ceszg7OG8oV8x
	tAckpBCiCHSZLFOF1ruOFp4zT7I0Xn6C9ApAWVx2BktGZDlMYy73tgaoO1+MPDaIOoRiBbO/Ig9
	9jpy0P7UQZFeR8bHMuVq/greJQQ9xZyELuEreAR2WQR0NMGOWZNeQKaXADIOiS2+znO7CIm5upy
	8N4IVKDM7ABvz1kh7LGZhVjL3z7ahquPUCXHUegE1r+6O7RVjGKUqK+RHVlVGPoK6tvpIJGcB5y
	vAU8DmnpMgHm3tKQzaiMoiW5mQWQaqny3cf1o0w==
X-Received: by 2002:a05:6000:1a53:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-4624179ba99mr9709052f8f.35.1781777264551;
        Thu, 18 Jun 2026 03:07:44 -0700 (PDT)
X-Received: by 2002:a05:6000:1a53:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-4624179ba99mr9708996f8f.35.1781777263942;
        Thu, 18 Jun 2026 03:07:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3fcfsm56057272f8f.26.2026.06.18.03.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:07:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 97AAE807861; Thu, 18 Jun 2026 12:07:42 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: ameryhung@gmail.com, a.s.protopopov@gmail.com, bpf@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, eddyz87@gmail.com,
 edumazet@google.com, emil@etsalapatis.com, eyal.birger@gmail.com,
 hawk@kernel.org, horms@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 leon.hwang@linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, rongtao@cestc.cn,
 sdf@fomichev.me, shuah@kernel.org, song@kernel.org, yatsenko@meta.com,
 yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3 0/3] bpf: bidirectional VLAN support for
 bpf_fib_lookup()
In-Reply-To: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
References: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 18 Jun 2026 12:07:42 +0200
Message-ID: <87jyrwf9g1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.43 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300388-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:ameryhung@gmail.com,m:a.s.protopopov@gmail.com,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:eyal.birger@gmail.com,m:hawk@kernel.org,m:horms@kernel.org,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kpsingh@kernel.org,m:kuba@kernel.org,m:leon.hwang@linux.dev,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rongtao@cestc.cn,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:yatsenko@meta.com,m:yonghong.song@linux.dev,m:avinashduduskar@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com,etsalapatis.com,linux.dev,redhat.com,cestc.cn,fomichev.me,meta.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,toke.dk:mid];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3241969F1BB

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> This series adds VLAN awareness to bpf_fib_lookup() in both directions.
> BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
> plus the VLAN tag (XDP programs need this because VLAN devices have no XDP
> xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged frame
> had arrived on the matching VLAN subinterface, for iif policy routing and
> VRF table selection.
>
> The l3mdev/VRF flow-init fix that was patch 1 in v1 and v2 has been split
> out and sent to bpf on its own, since it is an independent Fixes:-tagged
> fix that routes to stable on its own schedule. This series is otherwise
> independent of it: on the default CONFIG_INIT_STACK_ALL_ZERO the VRF
> selftests pass with or without the fix. Only the one full-lookup VRF arm
> ("IPv4 VLAN input, tag selects VRF table") depends on it, and only on
> INIT_STACK_ALL_PATTERN or NONE builds, where the uninitialized
> flowi_l3mdev otherwise misses the l3mdev rule and the lookup falls
> through to the main table. Applying the l3mdev fix first closes that
> window.
>
> Changes v2 -> v3 (all from Toke's review unless noted):
>
> - Split the l3mdev/VRF flow-init fix out to a standalone bpf submission
>   (it was patch 1 in v2).
>
> - Patch 2 (VLAN_INPUT): bpf_fib_vlan_input_dev() returns a
>   struct net_device * with ERR_PTR() for the -EINVAL case and NULL for
>   NOT_FWDED, instead of an int return and a **dev out-parameter.
>
> - Trim the BPF_FIB_LOOKUP_VLAN and BPF_FIB_LOOKUP_VLAN_INPUT UAPI doc
>   blocks, and drop the in-function comments that restated the commit
>   message or the flag doc.
>
> - Patch 1 (VLAN egress): on the skb path without tot_len, the deferred mtu
>   check now runs against the resolved egress (VLAN) device, not the parent
>   params->ifindex was swapped to, so a VLAN device with a smaller mtu than
>   its parent is no longer checked against, or reported as, the parent's
>   larger mtu. Found by the bpf ci bot; this was an open question in v2.
>
> - Patch 3 (selftests): re-run every case through bpf_xdp_fib_lookup() as
>   well, since the feature targets XDP; and flip the no-tot_len mtu arm to
>   expect the VLAN device's mtu after the fix above.
>
> Open questions (defaults chosen, noted here in case a maintainer
> prefers otherwise):
>
> 1. An unmatched, down, or foreign-netns tag returns
>    BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
>    fib_get_table() finds no table, rather than a new return code.
>
> 2. BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_VLAN_INPUT is rejected with
>    -EINVAL; restricting now keeps relaxing later backward-compatible.
>
> 3. The name BPF_FIB_LOOKUP_VLAN_INPUT reads oddly next to
>    BPF_FIB_LOOKUP_OUTPUT. A pair like _VLAN_EGRESS/_VLAN_INGRESS is an
>    option while nothing is merged.

These three are fine as-is, I think.

> 4. The egress flag leaves a VLAN it cannot reduce to a physical parent
>    plus one tag (QinQ, or a parent in another namespace) as SUCCESS with
>    the VLAN device's ifindex and the vlan fields zero, like a plain
>    lookup. The input side instead fails closed (NOT_FWDED) on the
>    cross-namespace case. An XDP caller cannot xmit on a VLAN device, and
>    a zero h_vlan_proto does not distinguish this result from a physical
>    egress, so returning NOT_FWDED would be safer for XDP. But the two
>    cases differ: a foreign-netns parent is clearly fail-worthy, while a
>    QinQ egress is still a forwardable route (tc xmits on the inner VLAN
>    device), so failing it closed would reject a usable route. Should
>    egress signal NOT_FWDED, for both or only foreign-netns? I left it
>    best-effort, but will change it if you prefer.

This one is a bit more ambiguous. Specifically, the inability for an XDP
program to distinguish between a route that actually targets a physical
device, and one that targets a VLAN device that couldn't be resolved for
whatever reason.

Since this is a new feature that's opt-in, I think I would lean towards
failing lookups with a new error code (BPF_FIB_LKUP_RET_VLAN_FAILURE,
say) if the lookup finds a VLAN device but can't actually resolve the
parent. That way the XDP program can repeat the lookup without the
BPF_FIB_LOOKUP_VLAN flag if it really wants the ifindex of that VLAN
device, but that will be explicit and not hidden.

-Toke


