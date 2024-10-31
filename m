Return-Path: <netdev+bounces-140773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC169B7FD2
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04161C2191E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B5A1BBBD0;
	Thu, 31 Oct 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hl0k/Fo4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370D1B86D5
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391496; cv=none; b=nao/+r3ZTm8suf5zTzIsRA9lbrs4OKWC3cyX35wdxwk5K9256ZJq2z3YwfW4C5W5tRlZpULcAJKYvE0wppFgsgv566y6YloIeGfYB0dgGK0YMUYNbhnUCt3248fzzQypp5QO4nBeEcOAVhLJtTMjPkCss3pGu6ZNmUIbQqM59OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391496; c=relaxed/simple;
	bh=WouSwHJcHzje0C4fi/eRSrY/1YS4kqLVQgfsDSaSVsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fnfn572ityLbcOu2UNTqJ2q9NqUVqhTv9vmocxgzx6PzJf9WK2F5Pk6uPg2cvI6TRyqJGDFFdT6/wleOtVWrYhBgfsxhMdpUIDhtNxdcCJCzmr0LNRxxUyE5nE6mTrCYixuPkramncsb6huEapREq9On4pA8G3qs8q1s2IRj23k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hl0k/Fo4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730391492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxx09rhPXBW0+fbvKhcDxytRWwt5G4IT/stJwiAJCe0=;
	b=Hl0k/Fo4nyI92MtzoO9zfEN9oCWahbH6IdLP6YBgYY+sPuNDDeoX3WTugl8ZxEZlFDr0lL
	/rt4gLS8zxfpwZQDNV8lo6grwpKLTlL5Se8XAEvlBeUcmrQOAyQDkmtY7BjocKBFFU2wVH
	ZaX4EzF/eQ1uOLxRBBEMkcdmGc3RzU8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-ZMfdMlANNb-gmFWIaic-Kg-1; Thu, 31 Oct 2024 12:18:11 -0400
X-MC-Unique: ZMfdMlANNb-gmFWIaic-Kg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a1af73615so88003666b.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 09:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391490; x=1730996290;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxx09rhPXBW0+fbvKhcDxytRWwt5G4IT/stJwiAJCe0=;
        b=PW/H0zs+TnOi4PFacsmxwx/m4uw9GN0do4x3iE/rQeX/4B5o+lazFaXro1rObmE8H8
         dxgd1gQxx9eeyOqJ92ERGxglqCwnnHKYtxg5VG3eUll3oavHs5AQyzWbAHxHpI/FeUgP
         R3UXueMT7U2BPwdy2vZ0zdLgyK/taAhMKhcRVwd/txeXB/nvcNZoHW8GVoVZ3EhwRqVH
         BWc56WBdycpN4cNIWE1nsCge5onAqUA/W5JQTdZ+9LSuttdGlL+tQAu9cvGzckg27mK9
         v8Yck1O6V4n3JJtBRYhOBXYrfZOFYU0oOVbzSHZdCRGKNVW/EaKfPJyk3rO1cG0FmtJ5
         AjvA==
X-Forwarded-Encrypted: i=1; AJvYcCWdOcPMYdb0aXqNXb6xhkuN4fHrJ7Rb0nYY27sMCQnBD3ndOIfuPGTa16tFlbF/mUbGOurIFzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXPizzvuTfuTph2toYDCfFn1B0ILjxgHLkuvcdJhFP+B/gIkV
	JaUpVazyRkgIWVYgr3wJ+0rl9AVm/U6zmqt50iFfWmBkQDgbAFpq0tCiB5yuND254Qlzoc3jUfI
	BxJZsRNJCnsVVIKvSp21+RQnAn5caq1UBVPL39yOVVuIZIhOJ1mrIBg==
X-Received: by 2002:a17:907:96ac:b0:a9a:1796:30d0 with SMTP id a640c23a62f3a-a9de63327c3mr2013677966b.62.1730391489857;
        Thu, 31 Oct 2024 09:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcPr4JkEYqmPz2R4rXU5fH3oMbGqzpFoCe3YaKkRKxGz/Uy/aeNVT/TYWyZnSar5vduQlf6g==
X-Received: by 2002:a17:907:96ac:b0:a9a:1796:30d0 with SMTP id a640c23a62f3a-a9de63327c3mr2013674966b.62.1730391489327;
        Thu, 31 Oct 2024 09:18:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56645ecesm84789766b.178.2024.10.31.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:18:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CEC11164B7AF; Thu, 31 Oct 2024 17:18:07 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
In-Reply-To: <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com> <87o731by64.fsf@toke.dk>
 <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 31 Oct 2024 17:18:07 +0100
Message-ID: <874j4sb60w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2024/10/30 19:57, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yunsheng Lin <linyunsheng@huawei.com> writes:
>>=20
>>>> But, well, I'm not sure it is? You seem to be taking it as axiomatic
>>>> that the wait in itself is bad. Why? It's just a bit memory being held
>>>> on to while it is still in use, and so what?
>>>
>>> Actually, I thought about adding some sort of timeout or kicking based =
on
>>> jakub's waiting patch too.
>>>
>>> But after looking at more caching in the networking, waiting and kickin=
g/flushing
>>> seems harder than recording the inflight pages, mainly because kicking/=
flushing
>>> need very subsystem using page_pool owned page to provide a kicking/flu=
shing
>>> mechanism for it to work, not to mention how much time does it take to =
do all
>>> the kicking/flushing.
>>=20
>> Eliding the details above, but yeah, you're right, there are probably
>> some pernicious details to get right if we want to flush all caches. S
>> I wouldn't do that to start with. Instead, just add the waiting to start
>> with, then wait and see if this actually turns out to be a problem in
>> practice. And if it is, identify the source of that problem, deal with
>> it, rinse and repeat :)
>
> I am not sure if I have mentioned to you that jakub had a RFC for the wai=
ting,
> see [1]. And Yonglong Cc'ed had tested it, the waiting caused the driver =
unload
> stalling forever and some task hung, see [2].
>
> The root cause for the above case is skb_defer_free_flush() not being cal=
led
> as mentioned before.

Well, let's fix that, then! We already logic to flush backlogs when a
netdevice is going away, so AFAICT all that's needed is to add the
skb_defer_free_flush() to that logic. Totally untested patch below, that
we should maybe consider applying in any case.

> I am not sure if I understand the reasoning behind the above suggestion t=
o 'wait
> and see if this actually turns out to be a problem' when we already know =
that there
> are some cases which need cache kicking/flushing for the waiting to work =
and those
> kicking/flushing may not be easy and may take indefinite time too, not to=
 mention
> there might be other cases that need kicking/flushing that we don't know =
yet.
>
> Is there any reason not to consider recording the inflight pages so that =
unmapping
> can be done for inflight pages before driver unbound supposing dynamic nu=
mber of
> inflight pages can be supported?
>
> IOW, Is there any reason you and jesper taking it as axiomatic that recor=
ding the
> inflight pages is bad supposing the inflight pages can be unlimited and r=
ecording
> can be done with least performance overhead?

Well, page pool is a memory allocator, and it already has a mechanism to
handle returning of memory to it. You're proposing to add a second,
orthogonal, mechanism to do this, one that adds both overhead and
complexity, yet doesn't handle all cases (cf your comment about devmem).

And even if it did handle all cases, force-releasing pages in this way
really feels like it's just papering over the issue. If there are pages
being leaked (or that are outstanding forever, which basically amounts
to the same thing), that is something we should be fixing the root cause
of, not just working around it like this series does.

-Toke


Patch to flush the deferred free list when taking down a netdevice;
compile-tested only:



diff --git a/net/core/dev.c b/net/core/dev.c
index ea5fbcd133ae..6e64e24ad6fa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5955,6 +5955,27 @@ EXPORT_SYMBOL(netif_receive_skb_list);
=20
 static DEFINE_PER_CPU(struct work_struct, flush_works);
=20
+static void skb_defer_free_flush(struct softnet_data *sd)
+{
+	struct sk_buff *skb, *next;
+
+	/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
+	if (!READ_ONCE(sd->defer_list))
+		return;
+
+	spin_lock(&sd->defer_lock);
+	skb =3D sd->defer_list;
+	sd->defer_list =3D NULL;
+	sd->defer_count =3D 0;
+	spin_unlock(&sd->defer_lock);
+
+	while (skb !=3D NULL) {
+		next =3D skb->next;
+		napi_consume_skb(skb, 1);
+		skb =3D next;
+	}
+}
+
 /* Network device is going away, flush any packets still pending */
 static void flush_backlog(struct work_struct *work)
 {
@@ -5964,6 +5985,8 @@ static void flush_backlog(struct work_struct *work)
 	local_bh_disable();
 	sd =3D this_cpu_ptr(&softnet_data);
=20
+	skb_defer_free_flush(sd);
+
 	backlog_lock_irq_disable(sd);
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
@@ -6001,6 +6024,9 @@ static bool flush_required(int cpu)
 		   !skb_queue_empty_lockless(&sd->process_queue);
 	backlog_unlock_irq_enable(sd);
=20
+	if (!do_flush && READ_ONCE(sd->defer_list))
+		do_flush =3D true;
+
 	return do_flush;
 #endif
 	/* without RPS we can't safely check input_pkt_queue: during a
@@ -6298,27 +6324,6 @@ struct napi_struct *napi_by_id(unsigned int napi_id)
 	return NULL;
 }
=20
-static void skb_defer_free_flush(struct softnet_data *sd)
-{
-	struct sk_buff *skb, *next;
-
-	/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
-	if (!READ_ONCE(sd->defer_list))
-		return;
-
-	spin_lock(&sd->defer_lock);
-	skb =3D sd->defer_list;
-	sd->defer_list =3D NULL;
-	sd->defer_count =3D 0;
-	spin_unlock(&sd->defer_lock);
-
-	while (skb !=3D NULL) {
-		next =3D skb->next;
-		napi_consume_skb(skb, 1);
-		skb =3D next;
-	}
-}
-
 #if defined(CONFIG_NET_RX_BUSY_POLL)
=20
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)


