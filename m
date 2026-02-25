Return-Path: <netdev+bounces-260919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNx8JrXsnmk/XwQAu9opvQ
	(envelope-from <netdev+bounces-260919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:36:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1DE197731
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 421213027682
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678D3AEF23;
	Wed, 25 Feb 2026 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i+vYl3y4"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7A3AEF22
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022813; cv=none; b=cmFTyovizTsOWCY1DPVm4H3Qk4/3LkIhE1jZMmt6BttXk1IaXjoLEgmrCFMiYFMLKDuswQPFLnrcqdDol3E3iHGuf+tjTuDIuyloyRcMYyMxFgmIE/Ohr4IyXU+5tgks4+93PUEyWgvNsWffraz8dYAPD8balFVu2jVxl979C0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022813; c=relaxed/simple;
	bh=mSHA3l9jQAIcS85uHcd9QmebzwPNvT88b+XadxDR4Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iaoj3EcoaDaqBAJxG/cFiYOK8t5y2wwEr3EWh7TXZJLQyI89gqcYgP3tRUaR1b7yDtUTUjT2gLyQ8aXECr8FHTKcNNFs1GJ+0WeuPuX03bhDqJFDP3yZbl9tcB+/wSkhRnNGtE2WACgmZyFakbkMWuZwTWcCGgXg3fEofVsZaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i+vYl3y4; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772022808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ud28h0/OpCSuq/G4O7ecA7OxqRdVhcz40EILUN6X3w0=;
	b=i+vYl3y46QD5Gmc2WwIAgr/rHYSNGK5thYcXu8WTno0FFI5HnU5iYY2KtUEKBI1MDem1S3
	cstGK07rZdai10JhX90aFn/X3B4rH/Vsw8PRE4Nx8Fb+Fn/NjIyb1oXz/AmI+nvumFy0R8
	wdcT5igX7thnSmWyDHD22b3ouydetEU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
Date: Wed, 25 Feb 2026 20:32:40 +0800
Message-ID: <20260225123250.189289-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260919-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email,appspotmail.com:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 1B1DE197731
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
This issue can be easily reproduced using the syzkaller reproducer.

In the ATM LANE (LAN Emulation) module, the same atm_vcc can be shared by
multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_vcc).
When the underlying VCC is closed, lec_vcc_close() iterates over all
ARP entries and calls lec_arp_clear_vccs() for each matched entry.

For example, when lec_vcc_close() iterates through the hlists in
priv->lec_arp_empty_ones or other ARP tables:

1. In the first iteration, for the first matched ARP entry sharing the VCC,
lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_back)
and sets vcc->user_back to NULL.
2. In the second iteration, for the next matched ARP entry sharing the same
VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv from
vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to dereference it
via `vcc->pop = vpriv->old_pop`, leading to a null-ptr-deref crash.

Fix this by adding a null check for vpriv before dereferencing
it. If vpriv is already NULL, it means the VCC has been cleared
by a previous call, so we can safely skip the cleanup and just
clear the entry's vcc/recv_vcc pointers.

The entire cleanup block (including vcc_release_async()) is placed inside
the vpriv guard because a NULL vpriv indicates the VCC has already been
fully released by a prior iteration — repeating the teardown would
redundantly set flags and trigger callbacks on an already-closing socket.

The Fixes tag points to the initial commit because the entry->vcc path has
been vulnerable since the original code. The entry->recv_vcc path was later
added by commit 8d9f73c0ad2f ("atm: fix a memory leak of vcc->user_back")
with the same pattern, and both paths are fixed here.

Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68c95a83.050a0220.3c6139.0e5c.GAE@google.com/T/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
- Add Reviewed-by from Simon Horman
- Drop the entry->recv_vcc->push to vcc->push cleanup to keep
  the patch minimal (Dan Carpenter)
- Clarify why vcc_release_async() is inside the vpriv guard
- Clarify why the Fixes tag points to the initial commit

v1: https://lore.kernel.org/netdev/6bc6f7fe686e53fe2aaca467920ccf300546d5bf@linux.dev/T/#t
---
 net/atm/lec.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index afb8d3eb2185..c39dc5d36797 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -1260,24 +1260,28 @@ static void lec_arp_clear_vccs(struct lec_arp_table *entry)
 		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
 		struct net_device *dev = (struct net_device *)vcc->proto_data;
 
-		vcc->pop = vpriv->old_pop;
-		if (vpriv->xoff)
-			netif_wake_queue(dev);
-		kfree(vpriv);
-		vcc->user_back = NULL;
-		vcc->push = entry->old_push;
-		vcc_release_async(vcc, -EPIPE);
+		if (vpriv) {
+			vcc->pop = vpriv->old_pop;
+			if (vpriv->xoff)
+				netif_wake_queue(dev);
+			kfree(vpriv);
+			vcc->user_back = NULL;
+			vcc->push = entry->old_push;
+			vcc_release_async(vcc, -EPIPE);
+		}
 		entry->vcc = NULL;
 	}
 	if (entry->recv_vcc) {
 		struct atm_vcc *vcc = entry->recv_vcc;
 		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
 
-		kfree(vpriv);
-		vcc->user_back = NULL;
+		if (vpriv) {
+			kfree(vpriv);
+			vcc->user_back = NULL;
 
-		entry->recv_vcc->push = entry->old_recv_push;
-		vcc_release_async(entry->recv_vcc, -EPIPE);
+			entry->recv_vcc->push = entry->old_recv_push;
+			vcc_release_async(entry->recv_vcc, -EPIPE);
+		}
 		entry->recv_vcc = NULL;
 	}
 }
-- 
2.43.0


