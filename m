Return-Path: <netdev+bounces-284752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AEiK2L7+mnjUwMAu9opvQ
	(envelope-from <netdev+bounces-284752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDF4D7D6D
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65925303A275
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6523E1233;
	Wed,  6 May 2026 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeXQoQP2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA0175A7B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055863; cv=none; b=BpgJFjTRGun/wotqETJlIhsRY0sOTtvbgT3HHBB7SZjpHiclY15/CKse6W/6QJaCp7iTj/fx28Kjw40W1/HIHM+WGq3V3nqHVkPrx4fo7by0UQvzfwKX1D5W+v1p8MhF5jRwDOJu4fdoww3ebeeOWbVs9nXYeAcboRf88j8Pfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055863; c=relaxed/simple;
	bh=FjT3tRekuKDQHAOGCXnDobwmU46yO/8SbxGfk0IJiv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iwtYFGC8SG9kCSd1qi/vmoGvXSeNhtpsPyNocoP6av7wYsMzwF3PuU70MwKfiKDR1Q+Z5Li0wIR8I/GfFmgiNyiJYCwg7JuX1XyR8aqEWP1AX7zaggEPHrF7t98yZWMx9J+0g7FLJIn2BSogwlWhgjfjjxWU0NRQJb/lYCA6j70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeXQoQP2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-365312a27abso3330122a91.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778055862; x=1778660662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+NLYhJbCV0yu/jhkzCiRqjYSwyB+jChRB9RgBBhFmY=;
        b=BeXQoQP2vifKulrLafOT8HIk4L/bJLZoPXDejSPzUtfseqyltiBlkfn/Ax0IBxgIE9
         vHQ7pQnSpYHpFraBYjEEEGu1Ok2jICi6FPZKevibrJB8SKzBKV3zT1z8Z4V/uUj0mjgv
         pzbI2bUir9gbOpIOD0E3OeY3gDbc2WAugoIx5pYcAOp3fZgt+8pEp2Jzyq+D/U5oSNNp
         p5EIH7VxQR0yI0G/Tj9/z8USwLK3FcqOG5TP+E8Q8HRNXTFCIwsaexKkhlCcgGnHinf/
         2FHCUh4BcUUEcZiGmEYwVuH/oKEVeT8uZHyxtp6jh+MCbswJZlcwvcksdQ5JsLcMFfQR
         MNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778055862; x=1778660662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+NLYhJbCV0yu/jhkzCiRqjYSwyB+jChRB9RgBBhFmY=;
        b=Ej3s+DYspz95j1w288rWkffn2ztA9s9G1m3c9sv7Uu9rTxZZTh6vWEuEXhzj8TscOe
         xEGqB5WNx6ZfykgYCWlAkq92RWcygDUIunslenQN5mvPciOjE9MB31bWv1GWU4KYwvxv
         NsI8cvRCrCadChRIVZc/zcIa5MidI5btHysoFL8Pq7rYRAF8EpDHfkR0QBPI0chr1Zzz
         lM3XQ3/AnEUvTjPiyKEnI/GHbpjPybFq56Lj2I1yItzE6paImQr6c5dme5lX2tMLqUgN
         u0GDAvJEAKgFVaJ2UUKnSsGMAxCmzBcnvqkPnpNStNO9ebkyXc7sZ1LG8FfKE8V8DdLN
         v92w==
X-Forwarded-Encrypted: i=1; AFNElJ+SnAEGKsarz3FP9PC+mBDn6Pa4e9QT4w4k7Y31zei8xMybiS9XqEyFRD5/cqpdw1qkm9gbx64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01KYl+xruY8E2kHhegQHXSwC/aMZGbKmt5KV+nt3CepBpIqKF
	wAwbyHGKviO8PaYyMRYzgpEfkKkeBh/aODBwoxo9UA7O81Q+r0onbqhf
X-Gm-Gg: AeBDiesPPhwPKo8o2gTAsLJ4FFCxJjH1xL3JMawG4Q8Dcfyya42+MCmLPhimBODf2nV
	mIeqElBWbnhPW5nadscP2qT8aAofUKpivIkTbfNRm4XYMFKNGKcJY4aMMASOcRMvaZjAv+cvjgV
	rSM0hZVCxO/M1K4+3b17p6GWqiBl/9PHVKrrN+ztqGGfuuh6m1PxJq3W/iusOpzec/em1PiM7RF
	Z70VWXOEqaP1DjS1dvLPFmb1sYVQvz+0HzfM1akx2ehQ0owWTRDanF1xhFtuxQNXP5c+Di1cRaX
	mGfkg3xwoU76CPZKwbltgZIOq2RjbXer0/VwDlRbP2YMjRq1y+tgtD0/0FSNGkdWodm0YNj/J3Y
	z/QGTEz40GVdOHfnrdU9odBajbbjaaE/1UFAHNNL6au/pMHMvZYIWHRe9qCA+oT8NDs1k+5gKqA
	DkwGMHiQlBWv7i5W6i06oIZhZWcG4SDEsul/gjiLRFOsqCpAFMU+urJVPdX+E=
X-Received: by 2002:a17:90b:1c84:b0:35f:b7f5:9b3 with SMTP id 98e67ed59e1d1-365ab8ba745mr2366825a91.3.1778055861651;
        Wed, 06 May 2026 01:24:21 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b12a1eddsm1000293a91.6.2026.05.06.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:24:21 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH net v8 0/2] ipv6: flowlabel: per-netns budget for unprivileged callers
Date: Wed,  6 May 2026 16:24:14 +0800
Message-Id: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12CDF4D7D6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org,ntu.edu.sg];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284752-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

This series fixes the cross-tenant DoS in net/ipv6/ip6_flowlabel.c.
v1 through v6 were single-patch postings, each in its own thread.
v6 review pointed out that the existing fl_size read in
mem_check() and the corresponding write in fl_intern() are not in
the same critical section. v7 split the work into 2 patches.

Patch 1/2 is a prerequisite. It moves spin_lock_bh(&ip6_fl_lock)
and the matching unlock from fl_intern() into its only caller
ipv6_flowlabel_get(), so the mem_check() call runs under the same
critical section as the fl_intern() insert. With all writers and
the read of fl_size under the lock, fl_size is converted from
atomic_t to plain int. This is independent of the per-netns
budget. It also makes 2/2 backportable without conflicts.

Patch 2/2 is the v6 patch, rebased on 1/2.

  - flowlabel_count is plain int rather than atomic_t, since the
    previous patch put all writers and readers under ip6_fl_lock.
  - In ip6_fl_gc(), fl_free() is now placed below the fl_size
    and flowlabel_count decrements, removing the v6 cache of
    fl->fl_net.
  - In ip6_fl_purge(), fl_free() stays in its original position.
    The function argument net is used for flowlabel_count.
  - mem_check() uses spaces around the / operator on all four
    expressions, addressing the checkpatch note in v6 review.

Numeric budget (preserved from v6):

  pre-patch:
    global non-CAP_NET_ADMIN budget = FL_MAX_SIZE - FL_MAX_SIZE/4
                                    = 4096 - 1024 = 3072
    per-actor reach                 = 3072

  post-patch:
    FL_MAX_SIZE doubled to 8192
    global non-CAP_NET_ADMIN budget = 8192 - 2048 = 6144
    per-netns ceiling               = 6144 / 2 = 3072
    per-actor reach                 = 3072 (preserved)

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Reproducer (KASAN VM, 4 cores, qemu): unprivileged netns A holds
3072 flowlabels via 100 procs. Fresh unprivileged netns B then
allocates 32 flowlabels (the FL_MAX_PER_SOCK ceiling for one
socket), the same as a clean baseline. Without the per-netns
ceiling, netns A could push fl_size past FL_MAX_SIZE - FL_MAX_SIZE
/ 4 and netns B would see allocations denied.

v8:
  - 1/2: replaced the "Caller must hold ip6_fl_lock" comment in
    fl_intern() with lockdep_assert_held(&ip6_fl_lock), matching
    the runtime check already used in mem_check(), per Willem's
    review.
  - 1/2: added Fixes: 1da177e4c3f4 trailer to match 2/2, per
    Willem's review.
  - Carried forward Reviewed-by: Willem de Bruijn on both
    patches.
  - No code change beyond the lockdep_assert_held swap.
v7:
  - 2-patch series: 1/2 (lock prep) and 2/2 (v6 rebased on 1/2).
  - 2/2: flowlabel_count int, fl_free() reorder removed in
    ip6_fl_purge(), checkpatch / spacing in mem_check() fixed.
v6: rebased onto current net (resolves the conflict on
    include/net/netns/ipv6.h that v5 hit). fl_free() restored
    to its pre-series position, with fl->fl_net cached locally
    in ip6_fl_gc().
v5: replaced the per-netns ceiling FL_MAX_SIZE/8 with the
    computed unpriv_user_limit = (FL_MAX_SIZE - FL_MAX_SIZE/4)/2,
    which evaluates to 3072.
v4: addressed Willem's v3 review on netdev. Dropped the
    flowlabel_has_excl cacheline argument in favour of "fills
    the existing 4-byte hole after ipmr_seq".
v3: addressed Willem's review on the private security@ thread.
    Merged FL_MAX_SIZE doubling, dropped test data, moved
    flowlabel_count near ipmr_seq, inlined fl->fl_net in
    ip6_fl_gc().
v2: per-netns counter + cap, sent to security@ as a 2-patch
    series.
v1: fix-shape sketch in original disclosure.

Maoyi Xie (2):
  ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
  ipv6: flowlabel: enforce per-netns limit for unprivileged callers

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 46 +++++++++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 15 deletions(-)


base-commit: ebb639024ebd47a13a511cce6ae630c15e4b3126
-- 
2.34.1


