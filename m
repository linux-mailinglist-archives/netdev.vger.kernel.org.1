Return-Path: <netdev+bounces-279465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ7RNUoP42kuBwEAu9opvQ
	(envelope-from <netdev+bounces-279465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2AE41FFAD
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C07263052EA2
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759883375CB;
	Sat, 18 Apr 2026 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmyIfHwh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53F302767
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488235; cv=none; b=Tiai6vMPObFWKIeiVKryh0USms9pxH6umoPT2ClvdR2HwIlTVw4ODSsoaYe+2RWS4SaOSxqEnJ8f51HSu5O2zVYHtTdAYtEd9A7gChHrbJPeDy6yHuyIhPMVnfbS1qFSDGDBGjOz4fUQEm5i2XC0Hv4pjObIuTOMLSUCcS4o1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488235; c=relaxed/simple;
	bh=tcfCsgbnieg6qkiA/a4ucXj2rJyFJzVtLJ7GffKDqEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zlulvs/4JXXL9r8rhK3T7PJbeQJ6G+sRVVdVjUuwm8n4FPo1aCI+0S8PHLRcWvKhiXCJvdmeHDUFH22EEl9Poes7HhrtB/4ZjIkrjQKVI/2eLyYaKt0kxorZGqsZDGSDBgvWpwlndkEp2pmUt2TkBVtsSqywPe895otPE1WXkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmyIfHwh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso916909a91.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488233; x=1777093033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJp6qysCzD93Sv185skue5qBzMtZ0Zel+Y3yR5NUr/s=;
        b=GmyIfHwh8F1nCViUd8F9AeuZ90m12aanhzVFrinrX5um8GP5/ZWCbbcBwQ8BLZ6Vti
         d7h1dcRdcC0geqrtwgksb2Pxhy4uyYTRSj80q1DfYzAONMICMhhijUz9s0RYb3EYlgAv
         ISYFY5FU8Yj0LGRVJ4GeD8A5axZxy5o9zRJN5vCXEAApZenra1AUoZfhSmdWnIgTwGJu
         7TNQY/udYcUH5AF5TdJ3bSjhOdnXHptjMbpWnZyMNIxbkiDyCqa1XAgCwDRNHgLO1xvf
         O/tUeDV4Yn3aG0LRl5+l6JErSDrIwGyLk9nT8v/nL7kJjCl4q+ohBrHTIYCGDit2T3R+
         5GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488233; x=1777093033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJp6qysCzD93Sv185skue5qBzMtZ0Zel+Y3yR5NUr/s=;
        b=AxUy0FkLSoo3zfJ7ve322jbTYR+nMiTSRnps6tF4rl3YS3Kx4b2exZv0JBV660ltC6
         fBp9qDNQzkOj+BxR9PnXQDdP283Ya/qAKyy2cCZtHQNp49e/HFyCksLjfJnxcFu02DcU
         tXubHAs0Ht+QBomGpGkGXWsDdbTuVEmBKVsQvQPgti9YL3J8o02cTrDHKU8FLmWNi2Yz
         iLHqzbfGN8p/Ej+2TltAhNZaz59h3rNEu07Zbm7Wq805SUmErI8N3i791vAZ0k8Sx420
         D36bCw0SZVokImgPYALZ4DlROz8fhEqYaJ/O6UAe5RDRj+yvE4HPTd8zpy83W6RvM/KV
         HVxA==
X-Forwarded-Encrypted: i=1; AFNElJ8TYITKTB2Iyoy6z0eeGjdOxwsIHMfgEeGmuUOD4XaeAlL3OcbCPOE8R8K6m4VRAUXCgVysC5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybsa/jk/Y/fU0qP0n2BoIsb5eDSggmRY/DEfuY5gOxMZdH/lV5
	+0freyN6kX/PRaDiJ9KmpCQVhUPP9KvpvnArd0cpLFW9gqJZfuf0ANxD
X-Gm-Gg: AeBDieuX4OGyZ0oeUdI9yyFDNNbR/rEyuCIJZq/CIL11/rZoeZEXe6JcjXplqdCSwql
	ROItLUiLGGit+c40Whxm2QO4jtqVtLAK4uzw8OXZ0JG52P849y3QCkLJ7bi/lGe0RSmWwl9xOMy
	Nz0iQnXt5cpQIGkkdbwvDTsM2vLmkMEsuIxhEgk+YSM3SpcRzm+fF31RjCEefqyAWyo+5hSDX7s
	PjJkbGpHKWHVzcbJaHc+YDgP7K8F04v8wjreivGiQ1lgrEzcxW5IbJ+szYWqqphsMVZIVIv3j8Z
	O7F+IR7w2Z9Pkf4NNlU0hbuqAxckKV7KxcK0qJaNB17tV7NGDcUdSSe1RVYchjxsMzwBFV0PB1I
	qEJQW4PDp2gMM5pIWrZ2RuoqBtTfKasVJA/b/iNyz4GdVH4Xzv6yK2LxjqcK3JNpUneYNoO+J9S
	BRtPl5iXB6y4snfbVr0dOiUCGCc0KIspajOiCIGEhmfXktgk1PdhWrgjfa8ggT26tp0O6nMWDlk
	k11nzvW1w==
X-Received: by 2002:a17:90b:5845:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-36140473f70mr5833835a91.14.1776488233557;
        Fri, 17 Apr 2026 21:57:13 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:12 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Sat, 18 Apr 2026 12:56:41 +0800
Message-Id: <20260418045644.28612-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260418045644.28612-1-kerneljasonxing@gmail.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 8F2AE41FFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means no frag and xs->skb is
   NULL) and users enable metadata feature.
2. xsk_skb_metadata() returns a error code.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
4. there is no chance to free this skb anymore.

Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..8fcde34aec7b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -743,8 +743,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				kfree_skb(skb);
 				return ERR_PTR(err);
+			}
 		}
 	} else {
 		struct xsk_addrs *xsk_addr;
-- 
2.41.3


