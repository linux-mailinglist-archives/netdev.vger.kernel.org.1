Return-Path: <netdev+bounces-282308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFotCH3H8WnnkQEAu9opvQ
	(envelope-from <netdev+bounces-282308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:55:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3F9491656
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7BB3038C5E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ABF3A9015;
	Wed, 29 Apr 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3UECdS2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DB29CB57
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452897; cv=none; b=Ypw/S8oGlnS5wnbaR10lzcIHIuIxVVOsBZtX0ztgGHnDhBfLS99Xz/ITdgZlprYj21uL/x/4JL3af0XrzGWKQ3UalMf2otEK3oOk7kgE8JvOunKZhSCnmWv9KtZZVOuJiaCm0itYZS7KtUBT904mHmzr9F6O9GED4UwfQdZ5v0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452897; c=relaxed/simple;
	bh=OGC7+IcZNZIL6sd3hOLyJPDWEm22FuB1Y+vAmXpI6EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF2CrFEq7hmySWcPkKTmPRBLOpd+VZxMMBnoZV/2Cwgeuy7lqb9K0OdFHHZxpKWWPcR9DqHFjPmfiBtl+BAttvYMvzWvTfZ6kbT6RpWsQct4X8N76WV9BLddQr64O0tTE9rkdLXHDmYjTTIjzQV4U0jvyJVaIlryMSa7xo/WsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3UECdS2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba6b39871a3so118734666b.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777452894; x=1778057694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxxbbPZ8q2XWtUlU/73YnAMHWldZI5Lyz7JAu6k9IoU=;
        b=J3UECdS2on/eRgMU+Q7mwA4hNRZEujruIEbgMXyVWehdXFwkAakK2Z0g7K+YQpByfJ
         FRaE6tzIDJWOIjIINzOabdtg61LqIJGdCaUz4HDwKbCSAnNil4/SZtNJEX4aAvPap6Zf
         W7MrM3nIJzaJSFetObHeK4+L8TJaP1+6vXv4BUmVyL4T6no22hZAIsStWsxZ3qWpMPUz
         m9vVkMjKv78DgsHlAAZF3JWJs1qIaSpmMg5HnGCgZVlk/yD35hkKJkSlFqSJOVgMAM5X
         sDxGB1Tj+WVQCXkOCUdLAfbvVXOB2nHJUd8F88F2S6fRGrFJXHwb3bvwnjf2mSg2S/RV
         Gztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777452894; x=1778057694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxxbbPZ8q2XWtUlU/73YnAMHWldZI5Lyz7JAu6k9IoU=;
        b=DoJKnWJa8xKGBz1QZPV8ZmFINOT5QwYRTMOy+jjdMJzyIGjhqIA5XsyiX2IoBp13Uc
         pUgduMxwEZkSa52WrfZ0jRRphWcHbauKIhSRWAILHgirU5pLWSoHJZWDRVDIOC7WdFE4
         dUMgxbQ8EsE/Pc7xGc/+GdJqnf6MdaJXei50cDLvH5fmz8HGFC0WbNrLj2E3awmLN5nn
         U7rzMXF46TLCDR86CJe3oVi75/p9ndCe322KQvAjBeTzhhBL4po2aBq5fNGZumuMymhW
         2Pk6OjH23stbRgNnlr5NAxV/NBBJGHCjqLiow2wdbGqNFlmmET7B5FmFBHPcvvrTkC1b
         faxw==
X-Forwarded-Encrypted: i=1; AFNElJ/vfVmGFgr8SjpwIUiiJPZKpxRaOLx4KhZZxNoTh7TqkP4ZDHPKFwj/l8+j6IhodyIPrS1Di9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpT+jCZxRTgggxUaRNdY/oFtQnzBE5CDz3DO3bjl6LugNBRySC
	95GGtWRMd14MCkM6A3Hq4SLUHIJMLQzAiSsMpgWJipr/VVHJg2+SbZfs
X-Gm-Gg: AeBDievt8EtWBrRPYKNi5t+WIhLmo0G/dzoTEfHPUHGV76PCh2CzCNlDyGch4Qj/Ljk
	ovzXduLR5C4+2ZQMqGhx5JrAyZTdpCJNSaPU4tbxLdPNeYnXW9Mij7ZUUzB/yijush6tr1SccBR
	2sPBAdz4J+V2siftm3wWOVtp3UJFz9pbCvwLy+RPJLBxdN6P9Q56RO9bSo0IR2tgpXmZYJPuoi2
	0WTfsdSOYZ+VeiFz+Tui9lt7lxzzb/n4SHvgVI/q+BsgDs9lEy75oBVev8gQhkZYiJmAKEc0QHw
	1pm55M0ubKE0W6UclROHe+m2MxxVANIbmBCINRu3mTdGEbfJ56gOb2I2fYDf8eY7JffvHCMm2TZ
	8KDFDLJjzfJKzcq7JpSvWwnzVR+BW/56TvQFIrOxP1p2rNeqAq11VzLtfLzxIog4dirx3yUyqjG
	FV0u0Wpncl3PHrN1Vt36P/ns5hShqJw/Xvvumh1+BR0BysVOu7CamIoxjye5lkGn/p19aPnITeF
	+AYrvb7kiEXJ4OaSr01l1CGerJ7lU4tBL14RAS4QGdNmiKuEAQ=
X-Received: by 2002:a17:907:3e0f:b0:ba7:41d0:5efd with SMTP id a640c23a62f3a-bb96bb7eba4mr103744066b.28.1777452893856;
        Wed, 29 Apr 2026 01:54:53 -0700 (PDT)
Received: from localhost.localdomain (pqu18.internetdsl.tpnet.pl. [213.76.110.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a70168sm62682466b.2.2026.04.29.01.54.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 01:54:53 -0700 (PDT)
From: Michal Kosiorek <mkosiorek121@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ipsec v2] xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
Date: Wed, 29 Apr 2026 10:54:51 +0200
Message-ID: <20260429085451.93944-1-mkosiorek121@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <afHEWqYEiA07An7W@secunet.com>
References: <afHEWqYEiA07An7W@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A3F9491656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-282308-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkosiorek121@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

KASAN reproduces a slab-use-after-free in __xfrm_state_delete()'s
hlist_del_rcu calls under syzkaller load on linux-6.12.y stable
(reproduced on 6.12.47, also reachable via the same code path on
torvalds/master and on the ipsec tree). Nine unique signatures cluster
in the xfrm_state lifecycle, the load-bearing one being:

  BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990 [inline]
  BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:516 [inline]
  BUG: KASAN: slab-use-after-free in __xfrm_state_delete net/xfrm/xfrm_state.c
  Write of size 8 at addr ffff8881198bcb70 by task kworker/u8:9/435

  Workqueue: netns cleanup_net
  Call Trace:
   __hlist_del / hlist_del_rcu
   __xfrm_state_delete
   xfrm_state_delete
   xfrm_state_flush
   xfrm_state_fini
   ops_exit_list
   cleanup_net

The other observed signatures hit the same slab object from
__xfrm_state_lookup, xfrm_alloc_spi, __xfrm_state_insert and an OOB
write variant of __xfrm_state_delete, all on the byseq/byspi
hash chains.

__xfrm_state_delete() guards its byseq and byspi unhashes with
value-based predicates:

	if (x->km.seq)
		hlist_del_rcu(&x->byseq);
	if (x->id.spi)
		hlist_del_rcu(&x->byspi);

while everywhere else in the file (e.g. state_cache, state_cache_input)
the safer hlist_unhashed() check is used. xfrm_alloc_spi() sets
x->id.spi = newspi inside xfrm_state_lock and then immediately inserts
into byspi, but a path that observes x->id.spi != 0 outside of
xfrm_state_lock can still skip-or-hit the byspi unhash inconsistently
with whether x is actually on the list. The same holds for x->km.seq
versus byseq, and the bydst/bysrc unhashes have no predicate at all,
so a second __xfrm_state_delete() on the same object writes through
LIST_POISON pprev.

The defensive change here:

  - Use hlist_del_init_rcu() instead of hlist_del_rcu() on bydst,
    bysrc, byseq and byspi so a second deletion is a no-op rather
    than a write through LIST_POISON pprev. The byseq/byspi nodes
    are already initialised in xfrm_state_alloc().
  - Test hlist_unhashed() rather than the value predicate for
    byseq/byspi, so the unhash decision tracks list state rather than
    mutable scalar fields.

Empirical verification: applied this patch on top of v6.12.47, rebuilt,
and re-ran the same syzkaller harness for 1h16m on a previously-crashy
configuration that produced ~100 hits each of slab-use-after-free
Read in xfrm_alloc_spi / Read in __xfrm_state_lookup / Write in
__xfrm_state_delete. After the patch, 7.1M execs across 32 VMs at
~1550 exec/sec produced zero xfrm_state UAF/OOB hits. /proc/slabinfo
confirms the xfrm_state slab is actively allocated and freed during
the run (~143 KiB resident), so the fuzzer is still exercising those
code paths -- they just no longer crash.

Reproduction:

  - Linux 6.12.47 x86_64 + KASAN_GENERIC + KASAN_INLINE + KCOV
  - syzkaller @ 746545b8b1e4c3a128db8652b340d3df90ce61db
  - 32 QEMU/KVM VMs x 2 vCPU on AWS c5.metal bare metal
  - 9 unique signatures collected in ~9h, all within xfrm_state
    lifecycle

Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
Fixes: 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI is zero to the SPI hash.")
Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
---

Resending v2 via git send-email -- the previous post had been sent
through Gmail's web client which stripped all tabs from the diff
hunk and made the patch un-applyable. Apologies for the noise. No
other changes versus the prior v2 send.

 net/xfrm/xfrm_state.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..686014d39429 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -818,17 +818,17 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
-		hlist_del_rcu(&x->bydst);
-		hlist_del_rcu(&x->bysrc);
-		if (x->km.seq)
-			hlist_del_rcu(&x->byseq);
+		hlist_del_init_rcu(&x->bydst);
+		hlist_del_init_rcu(&x->bysrc);
+		if (!hlist_unhashed(&x->byseq))
+			hlist_del_init_rcu(&x->byseq);
 		if (!hlist_unhashed(&x->state_cache))
 			hlist_del_rcu(&x->state_cache);
 		if (!hlist_unhashed(&x->state_cache_input))
 			hlist_del_rcu(&x->state_cache_input);
 
-		if (x->id.spi)
-			hlist_del_rcu(&x->byspi);
+		if (!hlist_unhashed(&x->byspi))
+			hlist_del_init_rcu(&x->byspi);
 		net->xfrm.state_num--;
 		xfrm_nat_keepalive_state_updated(x);
 		spin_unlock(&net->xfrm.xfrm_state_lock);
-- 
2.54.0


