Return-Path: <netdev+bounces-288302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JMfFbQVB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:46:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C566154FDE8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75DE23122B8E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976A47DFA9;
	Fri, 15 May 2026 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbLagwll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6C47F2E8
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848242; cv=none; b=oV7T8X/Sx4vINRjPv7a0kIwLe23dZrFZjD6oQVIBPj2Qwci9038OT7SveXC1njhrbebDiDtdn2h7rd6ly4aSSvzfkHc6gZL9oITs0uDhsWMB+/q/qBKEqQ2rWo+atAx+0EGriG8nTMokPqmiohCOwNy/IiWYo7LIfHtpiL2Il0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848242; c=relaxed/simple;
	bh=lNhmRx2RUJ7H07Ci0KctaR42KIjvgj533CKUPRrvdhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uf7zNT0ckD7nECIiaeb2z+Eg91wCjMkKON06xGaIwt3G+/+0XEM0JT4vdwhwbWvSNIckc7BmaFL9B+0ZZ8f9pOhEWDeybbP5IaOjqceA/SmkawKTAcDFFv7jPR8xZPj5fsC4OAelOni6aZRozvCHOwPYnyFhAPZSgeu/NoDQNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbLagwll; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso3991052a12.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848240; x=1779453040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j89QRPmeBr72gJxV2lEqSzN0fu5h/G1MZUN/zKxj7Wo=;
        b=SbLagwllU4MDIBPzzEwZXWJss8mFoP/4RdcpTi0UNMET0LOcHNr2EpXEg8+6C75CEx
         hhr2ZMuSLBIMd8mVDpc6dph5azAk1bldjJljTBMf3waUBdF3pv+LqpdRcEcF1JxSRV7n
         3y1PCYH/kWzMQo1UewhMtP8E649ADrPiUgrPoa6dKmybCMfskzPj41oCfz0Cd/N6slzJ
         keD1oyCD/ac6fDBCMueudC1/mFOskbD9Ak9grfhCWZGofydWCwegEGL55mZ7PFHOrij+
         doEdz94MG29SpksxJeJkVGcEyY9jmT1dRcMPMiRI1jWDySi/vJTibjacFQdJMRcVwdPk
         78dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848240; x=1779453040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j89QRPmeBr72gJxV2lEqSzN0fu5h/G1MZUN/zKxj7Wo=;
        b=iQjEZ0BzknMf2uJkPT8PHx1vEA46rnnLn3ydq1sJpgMFlgMHCWBI4nVdLpRk3qiOzQ
         NRAa7xIg8zoKDDr1lcBWhYQjsPUPAKzWoFjxvLYq8acf/EWEacwWxz3KWQssgRWMMb4z
         ad/P1oYS1OFKi2iEN1F5CYBoFTT9SoBWEF3sEpLiYAzAwlhWafuqWMoTFEygoCa+XLea
         Md5RBT5ujpqPcP48qXbp6gZshou/YV23bKPCQWIXfKWEc126NETUUqZPsKLmmsxiYfGX
         0K0/otHWMmGfqpNQJ4UpwaSnE1TcwKAw6Q3iIfBp5BicD+ZdF0qhXAOL7WoSOzduNMbR
         UNPA==
X-Forwarded-Encrypted: i=1; AFNElJ9NA2lvuEXvqn+S/11iIyYj9zzVfmP7XOYDhR9oFQWjiEbOtKc/cP5y5XhAlcvFzeOIgpSOwIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2XkrgS5gVlvhk3AeRLgSEB22h7pNTjWVdl6NyQ9q3XcrydTL
	SrlxHPHgTkggE3Vf5OZv15zRF1Jkc9f83Nv9eWGDPbgkd1M8GFnDexZk
X-Gm-Gg: Acq92OFm9SSFr2pQm9FQSH8nFe3za256Abue0P7I/PWbpE9LzhzunB/1c67YH6wt1Fd
	8hz9JHNcZvaW+Lxd5cTEIHujWLBwhJrj0nHBvbXlWdBvkCXHKkBIO5A4ZU32XOVILkBx/WGYzos
	/gIW82a/V/JJNRBINr737MbeRSR4OCHVg3ELQ7iC/gAXmpNlmASI3PteDkNr7VXnkMr9xoQ5r6N
	LG9lwdChwKvduuOWQ9M6yTHTRBk6aNg4EyESkhCDqbedOdExqmM/vJMRZ60A0I3JX9PvS+pveRD
	iRNUjxsoKSuMVU/W6L6vFwt73ixbMfT/iwWzdnLhPbPCqoquh5zrTL9u5Fnmt2PalIqdyR2DZ3k
	siOsYVFJRKfZuF+kM5OQSxyUl7PTTUieohXPTJf2nwDiRQhEfr/kJrJ/mOOkB/P6DxVE+dgbqXv
	N5V5ONXE8TjxvxyBvoNvqH+jZ9nVw42wrPX/m5m7ZE3psuYqjSf/fNrp5bGP2YcVKer6xlN/b+Y
	6SGBb8P0DCydRjUHAsQeHDH95Nb4NU=
X-Received: by 2002:a17:902:b693:b0:2ba:881f:6192 with SMTP id d9443c01a7336-2bd7e8f10eemr31784485ad.22.1778848240163;
        Fri, 15 May 2026 05:30:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:39 -0700 (PDT)
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
Subject: [PATCH net v2 1/5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Fri, 15 May 2026 20:30:14 +0800
Message-Id: <20260515123018.80147-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C566154FDE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288302-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

The TX metadata area resides in the UMEM buffer which is memory-mapped
and concurrently writable by userspace. In xsk_skb_metadata(),
csum_start and csum_offset are read from shared memory for bounds
validation, then read again for skb assignment. A malicious userspace
application can race to overwrite these values between the two reads,
bypassing the bounds check and causing out-of-bounds memory access
during checksum computation in the transmit path.

Fix this by reading csum_start and csum_offset into local variables
once, then using the local copies for both validation and assignment.

Note that other metadata fields (flags, launch_time) and the cached
csum fields may be mutually inconsistent due to concurrent userspace
writes, but this is benign: the only security-critical invariant is
that each field's validated value is the same one used, which local
caching guarantees.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6bcd77068e52..adcec1d22e8b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		if (unlikely(meta->request.csum_start +
-			     meta->request.csum_offset +
+		csum_start = READ_ONCE(meta->request.csum_start);
+		csum_offset = READ_ONCE(meta->request.csum_offset);
+
+		if (unlikely(csum_start + csum_offset +
 			     sizeof(__sum16) > desc->len))
 			return -EINVAL;
 
-		skb->csum_start = hr + meta->request.csum_start;
-		skb->csum_offset = meta->request.csum_offset;
+		skb->csum_start = hr + csum_start;
+		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
 
 		if (unlikely(pool->tx_sw_csum)) {
-- 
2.41.3


