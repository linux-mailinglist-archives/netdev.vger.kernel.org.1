Return-Path: <netdev+bounces-193721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80CAC531B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 18:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FEC167528
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A827FD62;
	Tue, 27 May 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="fMQEveMS"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43C27FB16
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363757; cv=none; b=Vcq8vlEaVLAZZ9VbyGsiHQxwu2kaxaJelBx0YxQrg/AbCoTpP+MXR/RBbdkQcGFAQDrbGySn2SvvuoypONvENgbElcgHM7Xemog+chMNISCNEqyMV4ylEfBljcasLq4avdz4/0VDmNRD+Y76xbcmNMrZlm32BC0rFfAgrrOMJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363757; c=relaxed/simple;
	bh=DJJFUpsUiCre1lpkV+ag5+41okCtVww+DKaXdPxtYo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A8iePuj6QNEMJpETRxqElCfNBPyZc2D+3qWLfmHs5XF+zUcvvkm+gLrQgyWfXBJLSQGUX4A8m854Geuy8FCjMaBw/XIgdGzez/esaFN09dUd45pGwY4YUMlJepPXq3StZcX9VTe+6uI+0SFf/vGXWwaBNPzc6CfdK3Sy/SQ/cAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=fMQEveMS; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0F03E240029
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 18:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1748363752; bh=DJJFUpsUiCre1lpkV+ag5+41okCtVww+DKaXdPxtYo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=fMQEveMS6YXkn2kove67MVSKiIRhLI93AXEMfPn8C7e7CTScmOMpO7WVIISOsua5H
	 jx2LMTAq31ebaNFwS6S7GukwPvRo43NqmqsWgje6jHlMPV1qxrc59tFipWYWM2q37z
	 cXTR7SItHm987dX7ugxWrbYjR5aGc+GLy/IMVrH6Y92gEIvskMQjoJFPy7O2hNwCKQ
	 pS3MJ5VACdTPsjoZpqLUf3OkUjMp2ep73+ILxko8zFh0JQHgKWBP7WnfY7akvL6uV8
	 fyoZikZ4Q5oGJXwimhg7uKA3Squn6DyzpoxQ8b/F+CwCwe4VbmF790MtJWfc4LjaHo
	 +v/cUyPWDkZiA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4b6JCn4RLSz9rxB;
	Tue, 27 May 2025 18:35:49 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Tue, 27 May 2025 16:35:44 +0000
Subject: [PATCH net v2] net: tipc: fix refcount warning in
 tipc_aead_encrypt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-net-tipc-warning-v2-1-df3dc398a047@posteo.net>
X-B4-Tracking: v=1; b=H4sIAN/pNWgC/32NQQ6CMBBFr0Jm7Rg6ggZX3MOwqO0As2mbtkEN6
 d2tHMDl+/n//R0SR+EE92aHyJsk8a4CnRowq3YLo9jKQC31bU9XdJwxSzD40tGJW/Bpdav1YPq
 OCOosRJ7lfSgfU+VVUvbxczxs6pf+kW0KFXY3mi9Vae0wj8GnzP5cmzCVUr4XFhFrsQAAAA==
X-Change-ID: 20250526-net-tipc-warning-bda0aa9c5422
To: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Wang Liang <wangliang74@huawei.com>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 linux-kernel@vger.kernel.org, 
 syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com, 
 Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748363744; l=2206;
 i=charmitro@posteo.net; s=20250526; h=from:subject:message-id;
 bh=DJJFUpsUiCre1lpkV+ag5+41okCtVww+DKaXdPxtYo4=;
 b=TsWLAtMEAVd3acno/f6j4+FGh2WOq/xu3qWINDjy+sYNDbRGDPdX48d/h24TnjC2WHYfxJfOL
 tgC3tNTWyNzC2Qbk98aD/0ab/KG+HwVn4n5T1IKMDTDQNVU8M8XrZ7H
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=PNHEh5o1dcr5kfKoZhfwdsfm3CxVfRje7vFYKIW0Mp4=

syzbot reported a refcount warning [1] caused by calling get_net() on
a network namespace that is being destroyed (refcount=0). This happens
when a TIPC discovery timer fires during network namespace cleanup.

The recently added get_net() call in commit e279024617134 ("net/tipc:
fix slab-use-after-free Read in tipc_aead_encrypt_done") attempts to
hold a reference to the network namespace. However, if the namespace
is already being destroyed, its refcount might be zero, leading to the
use-after-free warning.

Replace get_net() with maybe_get_net(), which safely checks if the
refcount is non-zero before incrementing it. If the namespace is being
destroyed, return -ENODEV early, after releasing the bearer reference.

[1]: https://lore.kernel.org/all/68342b55.a70a0220.253bc2.0091.GAE@google.com/T/#m12019cf9ae77e1954f666914640efa36d52704a2

Reported-by: syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68342b55.a70a0220.253bc2.0091.GAE@google.com/T/#m12019cf9ae77e1954f666914640efa36d52704a2
Fixes: e27902461713 ("net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done")
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v2:
- Return "-ENODEV" instead of "-ENXIO".
- Link to v1: https://lore.kernel.org/r/20250526-net-tipc-warning-v1-1-472f3aa9dd9f@posteo.net
---
 net/tipc/crypto.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 8584893b478510dc1ddda321ed06054de327609b..79f91b6ca8c8477208f13d41a37af24e7aa94577 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -818,7 +818,11 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 	}
 
 	/* Get net to avoid freed tipc_crypto when delete namespace */
-	get_net(aead->crypto->net);
+	if (!maybe_get_net(aead->crypto->net)) {
+		tipc_bearer_put(b);
+		rc = -ENODEV;
+		goto exit;
+	}
 
 	/* Now, do encrypt */
 	rc = crypto_aead_encrypt(req);

---
base-commit: 49fffac983ac52aea0ab94914be3f56bcf92d5dc
change-id: 20250526-net-tipc-warning-bda0aa9c5422

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


