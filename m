Return-Path: <netdev+bounces-299782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tTWdKC4UMWo4bQUAu9opvQ
	(envelope-from <netdev+bounces-299782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:15:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73468D6E4
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:15:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Wa/ls78t";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299782-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7DBB303283C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24D42189B;
	Tue, 16 Jun 2026 09:12:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3141B375
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:12:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601131; cv=none; b=eOPQcReWAgY5oV26IG9pZIzbr7eCYNNcHvDI1orHJFEHw0PkvAp61e4vVQ27NOF+x0xu4CZpiyy/T9BrCul2CTgbYDkQA5VKo8FYAur4RSXXMZ9KuUQJreO6IZWOyrcdOJg/8zIjqs8LwzBXJps98pZoQ3btxbuw+NfExrMiU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601131; c=relaxed/simple;
	bh=OLrKwtOMAAXc+cn4sWKdPlWR3wyVQ6X+l83adwNoANE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lp7ruiE0cn4JMmMxNt/QeDBT9ZK2Oq4NVB8dj9tIJKngbj1YLw7ySfvPmWGyFeOmOcvHfsUvmvt5dtVQO6OijhGmev9TWYEkAPCDGy1EF8Mwfi6EW7HWAWLYhBoqNPEIr0Dg5Qt3vdTz/s6ZJ2sUt3tCasJpHdFGGcKGctqxNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa/ls78t; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423f869421so3429736b3a.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781601129; x=1782205929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCMlAj/PQW48QlYO1ogaZDvkUzT5hyp9HL1ZWQeHJVQ=;
        b=Wa/ls78tFOo1qzCj0oCRILESDpCXDR+h6xSJg5/l2VdBMETLiZn1gUm+h+RiRREdK+
         AfDtcW986iAokSUUTfiMKvFwwYUYtzHt5VH2ucUg2a0LEJ8brKpjOT/2ysJec+/7w5Te
         MxJ5Rc95clxinK+O8EeQ++qAB9RrS6zM4JfsE4Nh+1KRGblDIzd2celhNqmEU8uLv7l7
         bc+p8fE2B7BBoUFkbVsWLsk4/aWvO6hmOllDFHLDechHxlx0L9yre6PkhuuN07c7O6T5
         Kyrgy6KnqylWW7b9a8JM9q5tTt8O/yavvjb2SnlPJSx3p+qemuZA/G74Pn/Tdac2Ptcf
         YuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781601129; x=1782205929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCMlAj/PQW48QlYO1ogaZDvkUzT5hyp9HL1ZWQeHJVQ=;
        b=cPa3mA5l9PMZyIIf7GGhaKuXmguClpIG+rcYt8VpKGoy8r0+Es2g/cnmHA950d/fAt
         zm1Y/pbIR4d+Qr7CfwnjVba8tC1CtPJTDqXpABKQu8AmEv4GeBv2sZBiUhG4nQDizPRz
         B3jgDV6qp87Tc+ev3F39WyY5GPSlolq/he09xUjy1s2JHzpDkKq8lQHI3OGbA5KcpwV7
         vwWZ3DqoIoYshZLlu3EyHK1UWManN9/kfmK1H1sesdV/+5ymFypQ06jcWf+kfdus3+ps
         DIg6B9nMauuvLWswD/jQ8p5qCvsrVAJbgTtbPnhnsGoGZ750QdqFRqDVdO9oT/Z3WPh2
         ndYA==
X-Forwarded-Encrypted: i=1; AFNElJ+8mfFsjl8e8hfJQeVrsKGevk8We4a5XgMZyeWcbbsmEfvK6Jysji/kFnTYZnPt1yu5qsuDYec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjaMOHb/QS1CKAyazCDMGACWOIyik0p95mBO2MJkVtb2AJihL
	RKjNZGPsqcEsct570xKuwph79Ipwfgdk1g3BEqP4X+7L+7zokS5zv3hD
X-Gm-Gg: Acq92OG5HRLHnVTJGoDdHwQlxWstn8y4IP+nLFBCNSlZgz2ZDeAci4KwQU1ctBfX6J2
	QnjbgqERiB+JITC+XRxm7yNX4HxY0FNemWFHxWq35ehiS/cgORONOZXbojKTQwIe/7jnT7m74VP
	ytVu06P83/FhJ5A/VGlB6toRXhhOK8rjKlfCUVnhDVe/jtQMjhBA3h2y29sNR1uOCWXDDDFd//z
	/eWLp0rOKMLsNkrV5Sduh6ustBUtTNZiTDtCZ48MhOloULGhPLtXH6pN1tlQl9RnTmfGmud60Wz
	te6Vp9wyy0xCfB3yeS2FCZpOZpYoQjybQMhrO5Seq81TqEdsjyjRF9C6GQtjKWMAyo3NQSGKKTs
	NO7HhcPOPgb1PviUEGvB+5KxA55h73sQSvRZOsSD64H4uTbEsrK+NfGy/dLYH04nKG2FeYgLuR9
	Pw98zNKetofUg9yQ906p+Ysm7cQ+yn9l3GbM7y3F0iD4+NxAVAzX5GFKKA60XE2Q==
X-Received: by 2002:a05:6a00:804:b0:82f:5051:f024 with SMTP id d2e1a72fcca58-844e1a2f1b5mr14917312b3a.27.1781601129475;
        Tue, 16 Jun 2026 02:12:09 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf23a7sm12026478b3a.22.2026.06.16.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:12:09 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock and sk_callback_lock
Date: Tue, 16 Jun 2026 09:11:51 +0000
Message-ID: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299782-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B73468D6E4

sock_map_update_common() and __sock_map_delete() hold stab->lock and call
sock_map_unref() -> sock_map_del_link() under it. sock_map_del_link() takes
sk_callback_lock for write to stop the strparser and verdict, giving the
lock order stab->lock -> sk_callback_lock.

The opposite order comes from an SK_SKB stream parser. On RX,
sk_psock_strp_data_ready() holds sk_callback_lock for read while running
the parser. The verdict redirects the skb to egress, where a sched_cls
program calls bpf_map_delete_elem() on a sockmap, which takes stab->lock:

  WARNING: possible circular locking dependency detected
  7.1.0-rc6 Not tainted
  ------------------------------------------------------
  syz.9.8824 is trying to acquire lock:
  (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
  but task is already holding lock:
  (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173

  -> #1 (clock-AF_INET){++.-}-{3:3}:
         _raw_write_lock_bh
         sock_map_del_link net/core/sock_map.c:167
         sock_map_unref net/core/sock_map.c:184
         sock_map_update_common net/core/sock_map.c:509
         sock_map_update_elem_sys net/core/sock_map.c:588
         map_update_elem kernel/bpf/syscall.c:1805

  -> #0 (&stab->lock){+.-.}-{3:3}:
         _raw_spin_lock_bh
         __sock_map_delete net/core/sock_map.c:421
         sock_map_delete_elem net/core/sock_map.c:452
         bpf_prog_06044d24140080b6
         tcx_run net/core/dev.c:4451
         sch_handle_egress net/core/dev.c:4541
         __dev_queue_xmit net/core/dev.c:4808
         ...
         tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
         strp_data_ready net/strparser/strparser.c:402
         sk_psock_strp_data_ready net/core/skmsg.c:1174
         tcp_data_queue net/ipv4/tcp_input.c:5661

  Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    rlock(clock-AF_INET);
                                 lock(&stab->lock);
                                 lock(clock-AF_INET);
    lock(&stab->lock);

   *** DEADLOCK ***

sk_callback_lock is an rwlock and the established side takes it for write,
so the read side cannot re-enter once a writer is queued.

sock_map_del_link() uses psock->link_lock and sk_callback_lock, not
stab->lock. The socket is removed from the slot with xchg() under
stab->lock, which leaves a single deleter owning it, and its reference is
dropped only by sk_psock_put() in sock_map_unref(). Release stab->lock
right after the xchg() and run sock_map_unref() outside it. Do the same
for the replaced socket in sock_map_update_common(). sock_map_free()
already unrefs without stab->lock.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/sock_map.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 99e3789492a0..390bd5ee46d4 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -421,13 +421,13 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	spin_lock_bh(&stab->lock);
 	if (!sk_test || sk_test == *psk)
 		sk = xchg(psk, NULL);
+	spin_unlock_bh(&stab->lock);
 
 	if (likely(sk))
 		sock_map_unref(sk, psk);
 	else
 		err = -EINVAL;
 
-	spin_unlock_bh(&stab->lock);
 	return err;
 }
 
@@ -505,9 +505,10 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 
 	sock_map_add_link(psock, link, map, &stab->sks[idx]);
 	stab->sks[idx] = sk;
+	spin_unlock_bh(&stab->lock);
+
 	if (osk)
 		sock_map_unref(osk, &stab->sks[idx]);
-	spin_unlock_bh(&stab->lock);
 	return 0;
 out_unlock:
 	spin_unlock_bh(&stab->lock);
-- 
2.43.0


