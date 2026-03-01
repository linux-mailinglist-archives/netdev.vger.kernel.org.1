Return-Path: <netdev+bounces-262418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGlZHa5ppGkigAUAu9opvQ
	(envelope-from <netdev+bounces-262418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:30:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC71D0A2A
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574CD3009145
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16341F1534;
	Sun,  1 Mar 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOMkXrM5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD719E839
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382635; cv=pass; b=ECMFSkK9MlpB84x6Hv6ayQvhLhoDY0hAJsrzdB0l4BaU9ZyXNtls8cN6MLon8c6lvwOXF3bWXC53rKU/eNaAaTkmMy+1cUMxCm3YWR69hvl07WQ+4gXYDjKQVQODdpKmNT964UpUPN7HW8WxzZ2dQp8lh0WmthJeOyoZ/jwVxgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382635; c=relaxed/simple;
	bh=lwhqFualEJkQhDEMdmfG8JTXKfR32VCm/twCDx0hHdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pq4BJo+itOsEBN5W9Qc2ZUTwi0ZSVnb5zBVcy5RN4+n6o0nEqtD/DqGau6+gbL+/LjbFLe1F2WLt7gT6J4pwbM7mngSNfMcDZahWgGEyQWOX56lzJM4tC0rz/6XUxykHrzb19GAgITv9Ls68wXoYATboc9v0tFxQqE+Kw88Z1Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DOMkXrM5; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50336cffef9so33297561cf.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 08:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772382633; cv=none;
        d=google.com; s=arc-20240605;
        b=COAoDTTzMQ4ey7qvYGuCyVTRvRu59jkW9c7PiOI1n3L5WAeyMDXNic6KMoYuVae+9J
         ytSPyY/7dj+Zd9jaH3hy7n+Jimdt/gagx8Ln+Z4kcoljqCMj7TGNO2nxSXLj719knc20
         eEHvwBwSJRjRF96j2Wv3FoZQylpJEX2b8vb+CcgR69A8gzvJEgyYXi+0rCv6m6fZB/qo
         IH0NEPNarof5xmpnc5w3MT8CdJn2RYtt262/Ps/s8ICCJA43VP3eBTlMucCKE0dPWsWC
         qZA10oFnBF+M3AzFmK/zeok16pQoJWnSr3NK4wSZDMiH49YAGERBkExvcapdzZNPfMRx
         oLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwhqFualEJkQhDEMdmfG8JTXKfR32VCm/twCDx0hHdI=;
        fh=gC/mwvxtBruAlYxQRMmTJTmNoQUhQmpwh7CHbYdwze4=;
        b=JxiIbow+e+ZHgwUF+m/Kx2gHPxTI5R2e8tvlkXHT1mscBDeUAHjRfj3REYWV6bc11r
         CzJhrjc0M2w5QRj8wRwfpjlfdMZNQiF/lsNYZsDf5MvVTItBhR42JsE6Ny5IX+nZ2tm+
         mk6hCrtmOe+7UEnrDOdpHMqOQkwt1URSguoRi5mmQCIzWHew5yLhfFDWJfrPT6tGiis4
         WmJHNRz73l+/NpR86Orhlzbfrh22xWYPv0zzt60GeyILKp4Tl/6U0MD2orjYa3HRtNEP
         c1FzXcwoeyrBWRaAAhlq6zP6IoiwxfebxVBgrDAuzL+NPwjF1DXT0RIEayg9VeItMLoA
         M8Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772382633; x=1772987433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwhqFualEJkQhDEMdmfG8JTXKfR32VCm/twCDx0hHdI=;
        b=DOMkXrM5n0Yi3CzvwUno9Aw6JbNn2mkSslzlUTDaH7H4e5/9tIcZhDtfaBgdEjsj4x
         IQlSHKvPggwlDHTFOtrz+LhbQnazwyFlDHlueEovk4VK3HK3pD2q4gRJPN8aWIxDaAFH
         ovgeI8nt2MbzCMZXPhTlBIQGGyLFTAoSrSJbx4kg9BX0V5DUFgcnLu2jFMQSIfnvaoMU
         TLMbO7Ekz6+CkxjLnOlUnFkaLb2fIGiF6tYaf7UgxkjRFDZrH6klT4WXtao3vYm+974N
         XII6dt3ybhpzhCdP98IuucJh5yC4I71xQqga+nJEUqrnRZm5hsl99NkgeasjCt78dCHv
         B20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772382633; x=1772987433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lwhqFualEJkQhDEMdmfG8JTXKfR32VCm/twCDx0hHdI=;
        b=K51j3PPnMCcjTCNQWBGCNGvMguZB4nspCL0VfGKRNaNRfCO7gVf3uYOiHXqApalq58
         XTQx5eZrQCGBgLLEmVVCistW6KApwwaDJXqAa4k6XqpbUxqVWBiBIAVnXzBCAauM27QU
         ZQlgcq/FB264cUmQCxFOVyrMilz7rfBRowKQB1G/vbxdc+GmmRUlQGOwllRbeTbnmJoG
         uJeTKJbxjTc+cBTQWlYMIdoZlyKWnhs4D9ezGOcC8NguP8oDbNN1z21CMihoGWuy3G2C
         eZs4zT+2RqrYELLNUFmQlZbIGLHQNO1Ebr3/GqICowNhvI4qJYUdEbrhQQ3BIh1zTja+
         poFA==
X-Forwarded-Encrypted: i=1; AJvYcCX7FwJ6eYOeUCgannbNv5Cu74JiFWA5W5d5nNNdXabnzHg/0nlaEopfNDlZTxGOLuSmnPvC714=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSXrQEVf/G9pvc69sd26Ym6pUJotl4Dt8Yih5pN4wgCPRNSac
	zgltqBuLF35xJ/HHlK0520wWpEwnfmQoQ5vDKJCHnbrm5EeXSvBwpoxd3Zoteta/+8twio5wrFC
	ZRKUU7V7T/zgGzRiwP+z+YJMIPnc9fkLjMUrsFEbh
X-Gm-Gg: ATEYQzwbLriowJ8o/EQVJk4IhyJ09wBec+Pn1irziX/6xy29Zolb9b/rG1A0yJQGh8Y
	38MJD/y9tWYKyg7ow9VtetBYzQomIZv26Tjb3dydjt5QqdOUFjBxyq4bgdAU3MpFd0qwn5mkOal
	BSd3bBnq5OfFgIxybeUN+LzbiEGDPTHgwsAyhtxG0+yBBO9PwbIBVda5TW8/B/ChehEW74Iwbev
	kK9LdgSpjcqYEbrkLeIR9bV5tspFaW2T64n/mo2u8jCSI5JPC7JnXPcPXC6JM/AkyTpfM85Z4M0
	HMUGzC6NXwGwR1nGMJU=
X-Received: by 2002:a05:622a:1921:b0:505:e7b8:5523 with SMTP id
 d75a77b69052e-50752883db6mr124533511cf.8.1772382632554; Sun, 01 Mar 2026
 08:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228141252.435509-1-edumazet@google.com> <31a14f1c-7d20-4b0f-a039-9e034762ed98@suse.com>
In-Reply-To: <31a14f1c-7d20-4b0f-a039-9e034762ed98@suse.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Mar 2026 17:30:21 +0100
X-Gm-Features: AaiRm52OUMnh9XwFSVonqEzmEHMbU4OJWBCu6A7l0Ltp1tbmMJ0d0OC_b3MH_p0
Message-ID: <CANn89iKH92jjRDD_jDNeioSy9U5mxKAYeyBJ3hHAFR_z4+wccA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: adopt SLUB sheaves for skbuff_small_head
To: Vlastimil Babka <vbabka@suse.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Hao Li <hao.li@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262418-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,suse.cz,linux.dev,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: D1BC71D0A2A
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 12:24=E2=80=AFPM Vlastimil Babka <vbabka@suse.com> w=
rote:
>
> On 2/28/26 15:12, Eric Dumazet wrote:
> > skbuff_small_head is used both on receive and send paths,
> > serving potentially 80 million allocations and frees per second.
> >
> > Tuning it on large servers has been problematic, especially
> > on AMD Turins platforms, where "lock cmpxch16b" latency can
> > be over 30,000 cycles.
>
> Huh, really? That sounds insane. Any pointers about that?

Yes, obviously on semi-contended cache lines.

>
> > Switching to SLUB sheaves fixes the issue nicely.
> >
> > tcp_rr benchmark with 10,000 flows goes from 25 Mpps to 40 Mpps
> > on AMD Turin.
> >
> > Other platforms show benefits with tcp_rr with more than 30,000
> > flows.
>
> That's nice, thanks!
>
> However I must point out some caveates. I assume you did this on 6.19, wh=
ere
> sheaves are still opt-in. But also, when you opt-in, the pre-existing
> per-cpu caching layer of percpu slab and percpu partial slabs is also sti=
ll
> there, so effectively the amount of percpu cached slab objects increase,
> which can be the main performance difference for some workloads, and not =
the
> difference between sheaves and percpu (partial) slabs implementation.
>

Tests are on 6.18 LTS kernel, on which our latest production kernel is base=
d.

> Note: but hopefully for your workload it's really the implementation.
> "(lock) cmpxch16b" should be avoided, until you start freeing NUMA-remote
> (to the freeing cpu) objects in significant volumes.

Right, __slab_free() is absolutely not 'slow path' when we have
~80,000 in-flight objects
on a 512 cpu host.

>
> In 7.0-rc1 sheaves are enabled for every cache automatically, and cpu
> (partial) caches are gone completely. Their size is calculated to roughly
> match the average amount of percpu caching the old scheme achieved (but t=
hat
> effectively depended on the workload too, so can't be exactly translated)
> and the result is visible in /sys/kernel/slab/$cache/sheaf_capacity
> the args.sheaf_capacity can override that automatic sizing, if the specif=
ied
> one is larger.
>

Nice, I did not know that (I am not following lkml traffic)

> So what I would suggest is checking the performance betwen 6.19 and 7.0-r=
c1
> without this patch (hope there won't be any other factors in the upgrade
> influencing this much), noting the auto-calculated capacity. If it still
> looks good, you don't need to do anything, otherwise you can try making t=
he
> capacity larger and see what happens.

I can not test this yet using 7.0-rc1.

I guess we will carry this patch privately, and will come back in a
few months when
I can get our infra ready.

Thanks.

