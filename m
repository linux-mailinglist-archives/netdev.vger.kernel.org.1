Return-Path: <netdev+bounces-277997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI+cEVGv3GnfVAkAu9opvQ
	(envelope-from <netdev+bounces-277997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:54:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A43E962C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD0243021E7A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AB93AD508;
	Mon, 13 Apr 2026 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STNOPt8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B33815DB
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070305; cv=none; b=UIr70yNpZIqUcgxYaukX42e+wQpItPp8cP6Lc+tmwzRi3cfnUXcchsTPH27rYwTOkCrTqPxpBRbFV25KIwPY4XR1+EPOr5pixlFPAuyLoQkxAmrCuCVe9WTORZCQVbkSAKNaQYe+Lzn6EAV/SxG2bPdzbjzckLmO41cyuc5Hax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070305; c=relaxed/simple;
	bh=oEhqvsj8LZIzS+H6HZIm5cMpADVbGj819fda8YGrF5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mt4yc7/Q8+FyS052f0Ldsj/j3HekAS007BtT86NCmk0SF1dvJv1Ttu77ln2QtIANhN1OX4iKnIvh3yaciZV4l9RRkHzByAU92QD3sK5Eta0hjBhB1qQBWn4szZAuGKMjVQd503rHWyMcJ2rGOK6BXdOk1gHBfeXHw9DFviGI9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STNOPt8F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so1963137a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070303; x=1776675103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u09n0AIpPYwujUPPnPEh5iEGhVUVRAozHgm92824yT0=;
        b=STNOPt8FOX7mKq0lvrK8NOofF12upNo82E0hi47hEuPrnPDO9BrwYcDGKMycNj+GPw
         5LbP+sjSwgUshy2HVuxjNYUawz+Msg68ovYaMHs32/KDeEZAnWCPMLgypwpJNjNJOg20
         44/+LWsd5Kho/baN/tWzRqxiO1gDWr9pAWRpITwFTfxHpdJ/Z6EaHlPkbwGKQBmhkNkg
         yIQXtHfWG0V8cA78b+UPwE+AMN7MDmV0Qgxg2mpXE7eShPSbXHhgmO9FjCk0vVgCD9uF
         LRydfH2OtX+SsY4Ng09tSdVGLbCBxmtnLGxtNUIBF5bkXP/o+OGlFyU6q7579Xvwd6F7
         3Xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070303; x=1776675103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u09n0AIpPYwujUPPnPEh5iEGhVUVRAozHgm92824yT0=;
        b=MKhIispfrYnKYdqfv29GY4sG8Is7PZr1HA9jG1ukwLo+ZmR3s+UcSt+OHCDAI4vlnl
         0YKiggEmDLfrOY3nypTAvkNNX+SM9ZvL/WYOLbesNgbWef9C4i3k72m+lGTsPeKPhCJO
         FsXTUHKVwyKWiOJKgX2U2P9g7zWi7sct9KkKUg+ZzeXcpi/VWbE4XQA2UsyidIp3IzJl
         JccNdARlZ25qyuq/xzfYKYvd4HHeaGlH30wlFRxovmVrRzmorPnQ5cGfT6Z20xcssa0/
         puE0EmLxk4fK3SISN/auT6eZ/KH/6Zst2MneTUeO64Cg6OIfEgIiWV0toCFM6BeRzpkM
         3gQA==
X-Gm-Message-State: AOJu0YzZwWMvCXNE6q/lYZzcWEA/ngUrQdFg8UAIGdW2LgZbhb2RAWYt
	uij0wXFJlcQmuWVMwWcn4ZLSACoBA92AB8YycK/13Z/7Ds8MjwWez10S600nzw==
X-Gm-Gg: AeBDiesYaF0LUtw7EgHRALbajtLLk2GPvHRBsjYsPHJ32AwDRYPZm27fikgcSn1MRaK
	LnyABfQpZ3A6iTEeL+WobUeRlGmGkGuv601V9yqglgBUFqR9501m/ugShlJDoVMeQraclTnxthK
	WGJE9b63f6b0ivYqurBqpaaP277A60Pj7M5VUHmZqCvz34IFCo5Fzflh0I+Lfo6Z7Pb/KKyc0XC
	soWhPl/R9HEEfdFC04t05FLDVsd6UQbcLmP0vQOvaYWQDcxQfWjWm9W00tT4uiNeqyhZU6LD5Z4
	uZOR2bpMtRTIklU2GmPM36E8IKqUyZSeduhOBGcwa+EsoG7Go4YXFW2Er63o11xfCgLRddKTNgv
	inq9WS2b7tiB2dpzOxd5lc3ZQW8rKDTAXheMbP4qcYwh3rDPSXh3u0m6oMS1S/pRJ4zWF+iXwrj
	zF07CLOsxw9TfaQXz6xxOxSG9u5+E1ZeWX3nXDfY1oQ4dQmZc7YM5I8ApJ/N4jUNhrdu9h588VF
	ps=
X-Received: by 2002:a17:90b:17c4:b0:35d:9c43:57fe with SMTP id 98e67ed59e1d1-35e4280cc70mr12776644a91.13.1776070303046;
        Mon, 13 Apr 2026 01:51:43 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b461d599a1sm18181825ad.0.2026.04.13.01.51.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:51:42 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] xfrm: iptfs: fix deadlock in iptfs_destroy_state
Date: Mon, 13 Apr 2026 16:51:38 +0800
Message-Id: <20260413085138.72623-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277997-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A33A43E962C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_destroy_state() acquires x->lock (spin_lock_bh) and then calls
hrtimer_cancel(&xtfs->iptfs_timer). The timer callback
iptfs_delay_timer() also acquires x->lock (spin_lock). If the timer
fires on another CPU during destroy, hrtimer_cancel() waits for the
callback to complete, but the callback is blocked trying to acquire
the same lock — a classic ABBA deadlock.

The same pattern exists for drop_timer: destroy holds drop_lock and
calls hrtimer_cancel(&xtfs->drop_timer), while iptfs_drop_timer()
also acquires drop_lock.

Fix by cancelling the timers before acquiring the locks. The timer
callbacks check for state validity, so a late cancel is safe. The
queue splice is still done under the lock for consistency.

Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e55ba..11291b87158c 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2708,8 +2708,10 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	if (!xtfs)
 		return;
 
-	spin_lock_bh(&xtfs->x->lock);
 	hrtimer_cancel(&xtfs->iptfs_timer);
+	hrtimer_cancel(&xtfs->drop_timer);
+
+	spin_lock_bh(&xtfs->x->lock);
 	__skb_queue_head_init(&list);
 	skb_queue_splice_init(&xtfs->queue, &list);
 	spin_unlock_bh(&xtfs->x->lock);
@@ -2717,9 +2719,7 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	while ((skb = __skb_dequeue(&list)))
 		kfree_skb(skb);
 
-	spin_lock_bh(&xtfs->drop_lock);
-	hrtimer_cancel(&xtfs->drop_timer);
-	spin_unlock_bh(&xtfs->drop_lock);
+	/* drop_timer already cancelled above */
 
 	if (xtfs->ra_newskb)
 		kfree_skb(xtfs->ra_newskb);
-- 
2.39.3 (Apple Git-145)


