Return-Path: <netdev+bounces-280396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L8CMh676GkHPgIAu9opvQ
	(envelope-from <netdev+bounces-280396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:12:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E96F445BD4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C97F30571B6
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55FA3D1CD4;
	Wed, 22 Apr 2026 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAW8g/Hg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3463CB
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859800; cv=none; b=lLqE9WsrrVxEYHVoJFjyCwoLA/m3CnJdnIyDMRXu+yNLxhhmJIAyJIz55UEOuj7jYvyIe/JIMP2mrFo1SHkEIHIc7VKQImcl6jehXE01i7KrmgIH4A0IHDfYPjGK5TePsYWTQGuyq/1+qiSQvMJ7lqlLPPHQDQzpqKgzvAL/sZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859800; c=relaxed/simple;
	bh=hjsvYy51l4+d68+Ky+C/JI2f1kTJUYN+qBMx0/prB8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DUlFHRE+LIqFbPbv4Vy6C5bRr2lCqwDh4w7nyJIlFQ4mMNDfkJ/TV/P4sCT8vQIARzgSLr1+HR+yd5brYkk4gFgt74pGolVIFm+h/Q/PfwnS64Od8sT0rYC/wgqD1NfQiCyUbQonrEZKo8eWGhvYVuvzfkGLqRNBo73dPYBMaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAW8g/Hg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296dabef74so4595601b3a.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776859799; x=1777464599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NebLMnO65OtCJ9kTmTFrhiV9D6tfIFz2CrdNbRxmY7A=;
        b=YAW8g/HgKU5Cd2daADXGyw2RYXgjloJ56nAgLpNmEVoliVjzt+3j70wqU4AhqP+bEQ
         lB9Q4Io8E+oSWhll0Yd1u8ATHbUFLkfKkZpKiLCZ9+1MCTtIKghCZeioTU9Kx8i87sTz
         3IjiP1g59fp/3JudOUIFUhKn9PwBikLi21GrUF2Ruc5vnAfBHZ5euDGmVlJS/tbCCrgy
         at7tb4vE4fgUaT5OLPDnMX4dH40ORqKM/zResc1LovT9em6FmHJ6HMGmApN/FbL6nVfO
         XDFmDtD1oN0+NU+qwJURVqWA3h0wtZ9ESuQ7/roDzXJ5jFYGfgQocqi5dQKpX74bAlK0
         FCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776859799; x=1777464599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NebLMnO65OtCJ9kTmTFrhiV9D6tfIFz2CrdNbRxmY7A=;
        b=BV8YPWywdGwRLTReCzDFwTdp/GL0rVsLpOzPtylVe76lxF26QxzovfW9BrxJf9BIWx
         t5LQ04hty6SXru6+edFZ2pvCjCDZ2MjXuTfVqYnj0jTGgHNGmgOhdUhLnuuKUbr1nahi
         wrKdhmmPeJ3pgR9bWjCIGjaowDy1Tuv57HRuVvXJ4cYYTVczhCqPQrt6xww09cjzHwjb
         4X+bAEZLmyrz9l01ATmhd2Sj72Pnj7hRjrm9NXxWJYDdd2vxaWSfrWInvN55IGfOJMpU
         VtONQrWGVytSW3idvXhVyvFGl1EV1gaPtgcoqb8o7QEYHl8RGvdOM6TUrqhXJG6C8Jm/
         Twzg==
X-Forwarded-Encrypted: i=1; AFNElJ99I/EM6vy1H5hIKSAnYlst0TXbnwRn2pVA90lZSFAuOhABi4xJDh1KuC3GDcyRxKR12stbDgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycIKQIYlACJswajTWb+ecWq/ZuUQ1KQGoqNd2SXxi7N76hXzh2
	GUR5wsDKYds1d+rtZ+z2LfhRww7AvsyubR3nUXDI4FhwB+UVAd+vAcmQ
X-Gm-Gg: AeBDietHHYh27s8V9yHQmuDFYJ7/t4DSt+rXO6WA4raTJqTzUXLg8/d1ihOzEoYtFG0
	fUNLunfOmDkl+nhnl7UMxUOxOUR3rDTPSqp3p4YU/p+IeU9SfvzAE6DiffC3JmQFPxnyAx1cLDd
	bJ1n25oZH9eM0JCYzZtJ8ddqqKhlJ4oQPGKqpBt7NlAc6z99B/RgWOfxnCCilepy7RvQAQcP2C8
	hQLUz/6inu0bb/hjKZkqzwYwX76FEKtaCNOZZVilN0JJKFfN9EYoF7S/eRQ9jFIfmQzV8pNT/5x
	DLq4GcJtIYOROUaOsVNw2wAmok7/2f8x18/71PGW3p6rj52SlCrZdTyCbJJcOnEzdPJ/8eGtvnH
	tvLHJmRU2/C53SXQXCXlrW5Gz8cZMvNnGoLz7Q11MhgUsYNxvifThfA5x2x9ayQSNVjQGu04AQQ
	9F8oN2HFVqSm3KRTn3IQVxWwwS7W+LunQ=
X-Received: by 2002:a05:6a00:3e16:b0:82f:5571:1a8d with SMTP id d2e1a72fcca58-82f8c8308e0mr23715240b3a.2.1776859798571;
        Wed, 22 Apr 2026 05:09:58 -0700 (PDT)
Received: from localhost ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9fcea9sm21196745b3a.23.2026.04.22.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:09:58 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: matttbe@kernel.org,
	martineau@kernel.org
Cc: geliang@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH] mptcp: do not drop partial packets
Date: Wed, 22 Apr 2026 17:39:54 +0530
Message-Id: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280396-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,google.com,vger.kernel.org,lists.linux.dev,mpiric.us,mpiricsoftware.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:mid,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: 3E96F445BD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data.  Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion.  Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
drop partial packets"), reverted in commit bf39160c4218 ("Revert
"mptcp: do not drop partial packets"")) also added a zero-window
check and changed rcv_wnd_sent initialization, which caused test
regressions.  This version addresses only the partial packet handling
without modifying receive window accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 614c3f583ca0..6858e6e283e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -397,12 +397,27 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-	mptcp_drop(sk, skb);
-	return false;
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	msk->bytes_received += copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+	tail = skb_peek_tail(&sk->sk_receive_queue);
+	if (tail && mptcp_try_coalesce(sk, tail, skb))
+		return true;
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
-- 
2.34.1


