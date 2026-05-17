Return-Path: <netdev+bounces-288689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJNqHophCWpOXgQAu9opvQ
	(envelope-from <netdev+bounces-288689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:34:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2892455F87A
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A16FE30179D4
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D422DECDE;
	Sun, 17 May 2026 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkN11s1r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA32DC765
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999625; cv=none; b=jY10n2JNrGzwQur3vjxFmWHeGj2frLatFygPAAws7eQp4Dhidx3SLAELSQK3iiJqVRvUTv9NoixlDKmRWkrE6KBuZDcC6XI+5uBNczqWM1cLIQMEH+Pqmjkf9IQmRyfLh18wEp5xLlu6GGqMa5ImsvGEetpbvTN8cnyl/RNU/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999625; c=relaxed/simple;
	bh=gYo9/K8sLXJNeg4Hne6w4h87zBKCMcNLlvVjrX7mcO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJxPWgvWhSRwRfNqRjYavLfGL3aUo352yvEt7ao06KwYNfmJZ0Qs4l7mJjrJKjjyVhVeQq+MU7lqF2PtPq/WSAsJf/eTsWPMSU4Fh/SJZTp2deIUcyUnzE3mQKitjM8LltyZFoNrtC5Sq9lSeOo2Rr8aOQVjbGfe1TfFXu4h4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkN11s1r; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b4583f0a1aso6675095ad.3
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999624; x=1779604424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ5UR7Z/H4396xz/6XU9FLA+Qv1VDDlhZ5LK4N+hzCw=;
        b=gkN11s1ra2mqr38AzFMcwMHFc2in2cEGtoCGfvMY49w5VhKdRrgPvnx9a0d4EFtsoI
         GjM+6v+b1TWBEoJtkAEjBuXZ2K0tLpwp20hwbYtAzNTr/ilYaqbNFLkcDUDtCHvSDZ/G
         nod+j4b/Ql0voTcE+ZJ62MHSf8NxrfLGG1k5kpzgtMYNMVAQvLQC+xm/OsEvHQST8j02
         zDlRsj+urnbSuHHrhXq/yObhSW8KJvU2WSTquZPMG+Hsgyg6c/aN+BHKNJZh/bjMvhxB
         hS+hyae9O3+2HCgoWXz27KMIo5C4jF9kZNXL9B8GNuAnHNZuUeqrZdpxpcj2N0CwvfTU
         5k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999624; x=1779604424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZ5UR7Z/H4396xz/6XU9FLA+Qv1VDDlhZ5LK4N+hzCw=;
        b=XRSJaEOaznokXvH7fXhHWH2qZ1tAxd6WjcUZ44SdtR6lUEdg0S2KnP2uOKBpCtkrNB
         3Jvw1rOsSu0jhhzuLbv16R+O48gf5pSvW4kDV5Bt6iEL2JOLXepvywKITCjnaODFipVE
         iGxiE0hCjV6djpfFPp9cp6P6kvPyf9Gf1GhYS6MomZF+v+DQwjfI/o6NXRX8toZVxbzq
         Y244bP7BJiMn7StThx8KAw7C6NenkcahuIy8oRMk630Eky+MPkuw4oK2s/cVIVFpUQz+
         x7SweAoZPUJXrHZWDqRvIuIXS1fXmCQheLif0ouNMrHkOoLaBB/WjiByfRnrHzXu7/CW
         QysQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PKjeU//jKqJTS7C0HhD+84mbBAASzRhtr2w/uSG36dgr4EAP3KiAgxjMQEKy3R8qRb9KtSbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTIDONlPRIigyN3hqJ3R7zxK9xIYO2O6F3JfZtCEbLg8Di5+g
	yjayFEUJ+sUrkudiP5XLqzCLWWW2mOWlmSsv4EcfwZvuqOsoLQoOtkcu
X-Gm-Gg: Acq92OGM0Wt7E3aZo3AGY/2Xv+5ICY/rx3bLPWvy/SUrAwMloFhMxSqUmFQEnOffFth
	vwIjxzKqIRI3cgwL5KdiC4noLfvxk1BIsA/DVhKRehrsdl5oqI6TEjy2mNJLL5XrUC9TQeTkOTp
	j42wzaRE4FkA+E5l4X6EaSqCAJs/Y2lXR2sdgJeDIQmCnlOBQZuXwjz/FII0OVl/cyE/3gLqdok
	2bSrTI3UJ05eayjSoQNO6sp0nTO+v7LVKZJSlVEZQjG5AwhhmvIE7y1KNAXQAE56OR+VXgsa1gI
	HPjT/zXUmQBWF2GxSSZuJqrH9kjxRsgtaiYoF2qKuJo+Zl8XWd3K3o+1iQGTXZ3HTfL17M3T81T
	hSxb/eFSYFrOvo8eASLRldYkErKBLIfhknYlv1yMPLNjr1wzxWlT1v57orayyUNs77OyjFaQyJ5
	TFG6IRQ80ReyUCfuIVkEiUSNGxkLAPHGPzF5vPoi/9IzIQmG19gN0KYj5b8c9xKR9uzItCWJ3Qm
	P48Y8cCEUUuDV5bDXxNbvAEQJhPgKQ=
X-Received: by 2002:a17:902:cecf:b0:2bd:6327:b4f5 with SMTP id d9443c01a7336-2bd7e93580dmr115440635ad.40.1778999623958;
        Sat, 16 May 2026 23:33:43 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:43 -0700 (PDT)
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
Subject: [PATCH net v3 4/5] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Sun, 17 May 2026 14:33:10 +0800
Message-Id: <20260517063311.28921-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2892455F87A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288689-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

When the TX loop in __xsk_generic_xmit() encounters an invalid
descriptor mid-packet (e.g. an out-of-bounds address), the partial
skb is dropped and the offending descriptor is released. However,
remaining continuation descriptors belonging to the same multi-buffer
packet still sit in the TX ring. Since xs->skb becomes NULL after the
drop, the next iteration treats the leftover continuation fragment as
a brand-new packet, corrupting the packet stream.

Fix this by setting the drain_cont flag when the released descriptor
has XDP_PKT_CONTD set. On the next call to __xsk_generic_xmit(), the
drain logic introduced in the previous patch handles the remaining
fragments with normal CQ backpressure.

There is one subtle case: if a subsequent continuation descriptor also
has an invalid address, xskq_cons_peek_desc() rejects it and the
while loop is never entered, so the in-loop drain path cannot clear
drain_cont. The post-loop code already handles this: it sees
xskq_has_descs() is true (the failed descriptor was read but not
released by peek), releases it, and checks its XDP_PKT_CONTD flag.
Add an else branch so that when the released descriptor is the
last fragment (no XDP_PKT_CONTD), drain_cont is cleared. This
prevents the next valid packet from being incorrectly drained.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 298194b7335e..cd451b285645 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1122,6 +1122,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+		xs->drain_cont = xp_mb_desc(&desc);
 	}
 
 out:
-- 
2.43.7


