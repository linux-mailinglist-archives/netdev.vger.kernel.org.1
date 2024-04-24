Return-Path: <netdev+bounces-91082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B788B14E5
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 22:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEC31C22C00
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9191156895;
	Wed, 24 Apr 2024 20:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341313A401
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991754; cv=none; b=kXJZJLaSYUGYq5LaHzQSlg7UkY3oW8QJzuErKvfBM43aXaoThtxmW9oMC5aFxdHIaNG5nBApqFzIWeF7//yENdiR3DksJDLJQ4IGMl41L0NpyVYCRrk63QghEypkD7ugZ+r7qB6EllUggwUwZwjap5NfstMo8K3lEepcPwGKpF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991754; c=relaxed/simple;
	bh=ta2HIQlhcQ2aeQnE00n8cD/LfrxUSp33wui/gOfjwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sfxATVxwOO1Vx/FIq2o5XCKBzAzjoheyZ3L40SGxwbgWiowsrkPATz8prkWtbm+Y6wZLjI1qLIgSxtNfLQZ10ZFrQqwdG7tGlCzl3qaLiJq/szWtijEs66p/U27VkNr/ukGETeqc9nB0u0U/KcEd0Yubkdd0V+XYsdlJiEsShgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-nrB5DHENOw25sVUgCYyYIg-1; Wed,
 24 Apr 2024 16:49:06 -0400
X-MC-Unique: nrB5DHENOw25sVUgCYyYIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E6933C000A2;
	Wed, 24 Apr 2024 20:49:02 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B35A25C772;
	Wed, 24 Apr 2024 20:49:01 +0000 (UTC)
Date: Wed, 24 Apr 2024 22:49:00 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David J Wilder <dwilder@us.ibm.com>, netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [RFC PATCH] net: skb: Increasing allocation in
 __napi_alloc_skb() to 2k when needed.
Message-ID: <ZilwPJ3QZC-7ideG@hog>
References: <20240419222328.3231075-1-dwilder@us.ibm.com>
 <e67ea4ee50b7a5e4774d3e91a1bfb4d14bfa308e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e67ea4ee50b7a5e4774d3e91a1bfb4d14bfa308e.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-23, 09:56:33 +0200, Paolo Abeni wrote:
> On Fri, 2024-04-19 at 15:23 -0700, David J Wilder wrote:
> > When testing CONFIG_MAX_SKB_FRAGS=3D45 on ppc64le and x86_64 I ran into=
 a
> > couple of issues.
> >=20
> > __napi_alloc_skb() assumes its smallest fragment allocations will fit i=
n
> > 1K. When CONFIG_MAX_SKB_FRAGS is increased this may no longer be true
> > resulting in __napi_alloc_skb() reverting to using page_frag_alloc().
> > This results in the return of the bug fixed in:
> > Commit 3226b158e67c ("net: avoid 32 x truesize under-estimation for
> > tiny skbs")
> >=20
> > That commit insured that "small skb head fragments are kmalloc backed,
> > so that other objects in the slab page can be reused instead of being h=
eld
> > as long as skbs are sitting in socket queues."
> >=20
> > On ppc64le the warning from napi_get_frags_check() is displayed when
> > CONFIG_MAX_SKB_FRAGS is set to 45. The purpose of the warning is to det=
ect
> > when an increase of MAX_SKB_FRAGS has reintroduced the aforementioned b=
ug.
> > Unfortunately on x86_64 this warning is not seen, even though it should=
 be.
> > I found the warning was disabled by:
> > commit dbae2b062824 ("net: skb: introduce and use a single page frag
> > cache")
> >=20
> > This RFC patch to __napi_alloc_skb() determines if an skbuff allocation
> > with a head fragment of size GRO_MAX_HEAD will fit in a 1k allocation,
> > increasing the allocation to 2k if needed.
> >=20
> > I have functionally tested this patch, performance testing is still nee=
ded.
> >=20
> > TBD: Remove the limitation on 4k page size from the single page frag ca=
che
> > allowing ppc64le (64K page size) to benefit from this change.
> >=20
> > TBD: I have not address the warning in napi_get_frags_check() on x86_64=
.
> > Will the warning still be needed once the other changes are completed?
>=20
>=20
> Thanks for the detailed analysis.
>=20
> As mentioned by Eric in commit
> bf9f1baa279f0758dc2297080360c5a616843927, it should be now possible to
> revert dbae2b062824 without incurring in performance regressions for
> the relevant use-case. I had that on my todo list since a lot of time,
> but I was unable to allocate time for that.
>=20
> I think such revert would be preferable. Would you be able to evaluate
> such option?

I don't think reverting dbae2b062824 would fix David's issue.

The problem is that with MAX_SKB_FRAGS=3D45, skb_shared_info becomes
huge, so 1024 is not enough for those small packets, and we use a
pagefrag instead of kmalloc, which makes napi_get_frags_check unhappy.

Even after reverting dbae2b062824, we would still go through the
pagefrag path and not __alloc_skb.

What about something like this?  (boot-tested on x86 only, but I
disabled NAPI_HAS_SMALL_PAGE_FRAG. no perf testing at all.)

-------- 8< --------
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f85e6989c36c..88923b7b64fe 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -108,6 +108,8 @@ static struct kmem_cache *skbuff_ext_cache __ro_after_i=
nit;
 #define SKB_SMALL_HEAD_HEADROOM=09=09=09=09=09=09\
 =09SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)
=20
+#define SKB_SMALL_HEAD_THRESHOLD (SKB_SMALL_HEAD_HEADROOM + NET_SKB_PAD + =
NET_IP_ALIGN)
+
 int sysctl_max_skb_frags __read_mostly =3D MAX_SKB_FRAGS;
 EXPORT_SYMBOL(sysctl_max_skb_frags);
=20
@@ -726,7 +728,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *d=
ev, unsigned int len,
 =09/* If requested length is either too small or too big,
 =09 * we use kmalloc() for skb->head allocation.
 =09 */
-=09if (len <=3D SKB_WITH_OVERHEAD(1024) ||
+=09if (len <=3D SKB_SMALL_HEAD_THRESHOLD ||
 =09    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 =09    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 =09=09skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
@@ -802,7 +804,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi=
, unsigned int len)
 =09 * When the small frag allocator is available, prefer it over kmalloc
 =09 * for small fragments
 =09 */
-=09if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_WITH_OVERHEAD(1024)) ||
+=09if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_SMALL_HEAD_THRESHOLD) ||
 =09    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 =09    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 =09=09skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
-------- 8< --------

(__)napi_alloc_skb extends the GRO_MAX_HEAD size by NET_SKB_PAD +
NET_IP_ALIGN, so I added them here as well. Mainly this is reusing a
size that we know if big enough to fit a small header and whatever
size skb_shared_info is on the current build. Maybe this could be
max(SKB_WITH_OVERHEAD(1024), <...>) to preserve the current behavior
on MAX_SKB_FRAGS=3D17, since in that case
SKB_WITH_OVERHEAD(1024) > SKB_SMALL_HEAD_HEADROOM

--=20
Sabrina


