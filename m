Return-Path: <netdev+bounces-303457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z+H9OUeKRGpfwgoAu9opvQ
	(envelope-from <netdev+bounces-303457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8740C6E97B0
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:32:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GNRixS33;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303457-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303457-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F27193021CBA
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05221257F;
	Wed,  1 Jul 2026 03:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FCC190473
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 03:32:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876740; cv=none; b=SRS9Pmpu+OeM4kQz82Lyww9i6lrJRGKWJCmFKPtIru6Mib0ubNlS4b/WUSjP2RkLS/DQFiughVmokjwbkKrOHb0HViR2CuuwYUeSmhCSkBZKkmipIJsxNrP9wIDRuPEvSgIr3idihAwh+SH76w48aZrI1GNSaeGobNJhtDswbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876740; c=relaxed/simple;
	bh=qBSfS5ti60FG+DjWbyR/Dcw5pWUGlJGzrHzvvTePmOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PB6aP8fAbcQTmhPk3WwDAy/sjTZql4ihcBLZXkxLBuq3kdbYypoTUuY7w3UxhePor5QPhFZ622ECLaMdy1drc23o9YLZn808CgUp7KpF4NRrtUNTq29p6lAwIAkMGVJ8pi2DOjjINb9LT77sHJTEUOnag0x6c9j/fKsTQ3MZhc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNRixS33; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-847aebc56b6so74410b3a.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 20:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782876738; x=1783481538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rHsqq/2Rjpg7iDyb+HiQP78fOmnxJA+oi3DFoeFiPE=;
        b=GNRixS33GxedekDFKPN4YxioT9Y0m0lIv3MmSpUtrdTS2uV6JdE3OslTrHOfpD+RTe
         vj4FaT9l7CQG5g3B4t1YJ0pPAxESCOjO2zcojTro15eaCsaRnK4I9pG65LIHvXX2C2Lz
         2474HiMLABef/sUaKrHWPPC3K1K9uLgiCUhsbli1l/lYDfqNdtqYmuv2GzHUW1kw5/CI
         OlI8vC1PHHKqWww2gSH6Q3kGKdJ7nKQrlsgoNk8CfchAklUmVfUiedyVbi3bz8XbGn/Q
         uYfpXIYxmgzkm4BfSVFQ126jr7R296KVygAg8ZYyCCDYzokf5e4LlOnRzSTNjvQYnnUt
         z3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782876738; x=1783481538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rHsqq/2Rjpg7iDyb+HiQP78fOmnxJA+oi3DFoeFiPE=;
        b=ekOPcUInHanD/NsI99A7TyYq6HdantNXSzT8dJLv1bS7B03NMyaF2rrepqqgn6+kkW
         nN8Mdycsx3aNIojVj2HxWegN2SMbycmHHTd3GB+//DpT1mFrvaatTv0IZqkRqfounZRq
         yTJb/MD+CkrrMStA47ptu2A6hiMAYI0WtB3vZTkeOg8JnStTx//dqpi4Wrdj3GkdNQ4r
         FWSvc0iiC5UHPK1Rp6J8CCmvpj3nb82NQdwdhYp5d/vCn7JgL0WFr2h6PKjVl4Fk6ZX6
         ZYI4MMAsRO7D1zB4/7Dpw7P6PEeXBm/597iGOrWjZqlGV/Ek3C7JU8WhlwmqZhhl9cl4
         QtPA==
X-Gm-Message-State: AOJu0Yye7KDfDj1eXBW3+BqvxWwJtotpCwCg1uVQwxGw0C82B+nl2Xwi
	zOSvyGg3skPSC+1lUuo8fQfT9BuAE5ZYU2DEgcUkJj11Ovqt8RKmfPcV
X-Gm-Gg: AfdE7cnV5o2qXwivIPPs6BYBiBAqjHISvjBlW+gqtfeAMMkL4SFNBMu/xEXCxFCRD3g
	cT5FjdTbnDC6G5XEoIpNk/4nws42e8XEu0PGsUHUqhsYRmAK/0HbRtPyfbK04aoCNO4DPvU+eiM
	pFzpL0QyBWSatIWNx0WVb/AeoQVw2/a4yQRk/EWmeiUemhaONvRZ0YTNSrqWg2DGXu52I92xU0m
	3dr9U5BEXEuDfVEYZu6L3g7qN0jzSTUHwdv7WUy0EBYNLE1aJ5jp3yrtbtO+YUdkTLh3yW+CNo+
	Vw+Cx7bjuto4m2pVK11zT1srDioGpZKNIs5fEtCKjTCv0rgDaoxhh7pGcQYeE93PcRwDu6gYdx1
	TpsWZixgHzKkuJ7h5sCdTd53HwAbRs1/ZRyeJFsI7yZNAMj3PxwPsiplsZl9sGx+0RHKCNqX/nc
	4f/GqHacTe9nxxWiH7E9QfOQ235gFYfb1f/G3sIw5bWjUtCRdI
X-Received: by 2002:a05:6a00:2e85:b0:847:80c8:dfdb with SMTP id d2e1a72fcca58-847adf29971mr2996454b3a.55.1782876738352;
        Tue, 30 Jun 2026 20:32:18 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fff4c7csm3162757b3a.16.2026.06.30.20.32.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 20:32:17 -0700 (PDT)
From: Chen YanJun <635381823cyj@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	moomichen@tencent.com
Subject: [PATCH v2] xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()
Date: Wed,  1 Jul 2026 11:31:52 +0800
Message-ID: <20260701033152.29222-1-635381823cyj@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:moomichen@tencent.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303457-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[635381823cyj@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[635381823cyj@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8740C6E97B0

From: Chen YanJun <moomichen@tencent.com>

When iptfs_skb_add_frags() copies frag references from the source
frag walk into a new SKB, it increments the page reference count via
__skb_frag_ref() but does not propagate SKBFL_SHARED_FRAG to the
destination SKB's skb_shinfo->flags.

If the source SKB carries shared frags (e.g. from a page-pool backed
receive path), the new inner SKB will appear to ESP as having privately
owned frags.  A subsequent esp_input() call for a nested transport-mode
SA then takes the no-COW fast path and decrypts in place, writing over
pages that are still referenced by the outer IPTFS SKB.  This causes
kernel-visible memory corruption and can trigger a panic.

All other frag-transfer helpers in the kernel (skb_try_coalesce,
skb_gro_receive, __pskb_copy_fclone, skb_shift, skb_segment) correctly
propagate SKBFL_SHARED_FRAG; align iptfs_skb_add_frags() with this
convention by setting the flag inside the loop immediately after
__skb_frag_ref() and nr_frags++, so every exit path that attaches a frag
unconditionally propagates SKBFL_SHARED_FRAG.

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Signed-off-by: Chen YanJun <moomichen@tencent.com>

---
v2: move SKBFL_SHARED_FRAG assignment inside the loop, immediately after
    __skb_frag_ref()/nr_frags++, to also cover the early-return path
    that fires when the requested length is satisfied mid-frag (pointed
    out by maintainer review of v1).
---
 net/xfrm/xfrm_iptfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index ad810d1f97c0..597aedeac26e 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -480,6 +480,7 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
 		}
 		__skb_frag_ref(tofrag);
 		shinfo->nr_frags++;
+		shinfo->flags |= SKBFL_SHARED_FRAG;
 
 		/* see if we are done */
 		fraglen = tofrag->len;
-- 
2.47.0


