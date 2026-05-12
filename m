Return-Path: <netdev+bounces-286934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAdJKk6YAmoauwEAu9opvQ
	(envelope-from <netdev+bounces-286934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 05:02:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FAC519214
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 05:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C54583043512
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F8378830;
	Tue, 12 May 2026 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8PoftOC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD12FDC3C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554747; cv=none; b=tduiFQbg+Oru8y1L61m65Lx5sveXm9L5a9GZZsmG7YfKKZE25uhg71F/oTJl14y5NyzcGzGwGq4/3NQFcQTFJH8jbPxQf3oY3PPVtz+dYtcYGrSbM7vx3iieOcp6aWRHOqB2Ddg3eEBQCuG/HK8qUhsXxjHEy6HAZ3ep5jHRI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554747; c=relaxed/simple;
	bh=qELwf6yVFwCKCy76GRQ3b5WHenmlqq0luRAqIwCu6hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8zz/UJ9aKmT76iVU/q3KFpWgaeGN9HKyvyxAeBJ0jjxX7JltiWiSPC3by6jkGK9W5VTmYSQVozqFAjxXe8vzRjS98t+bRUNWKvRYxml4NG4TxJCQEcD76VviNrx+7PnFMmFfoZ88lELYp4SMM18W1u0IieXuqH0IKYLcdJf0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8PoftOC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b9e9a6802aso19992165ad.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778554745; x=1779159545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/R8nu4FmGtSchXT9i0AhYNs7M9dg3GLRopNafO7mLQ=;
        b=L8PoftOCWkBHzoslNDycXPYshKTi+1JGR/7UxSoLKdun7CzVeSuyRT1cAsLmgO8Aln
         XXZSl4TFGRIm18BanBxRUNJ9tjJi5mWYkLOitiQxo/1SkX5QSIxiQyuntg1gUIF2mNMG
         fHJl/rswAqJs4AHl7v6lZ9CIjsgfIpV5FV/F86WCJ+kFInTJjwGAXJyBqTQyPX5I+qUR
         wHPTa6OwqKUbiMHTdg5m4MddtdmHcMJOPlGkkOalzq+Jr5+nYnD2MCmgY3a1dWLX036t
         3B1gAuW/xhBelydx8O9Z/lfNtp4V5jKfzMPc/BK29SP+ZBRARS95Hq6HaPvqYK9BPdN9
         S9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554745; x=1779159545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/R8nu4FmGtSchXT9i0AhYNs7M9dg3GLRopNafO7mLQ=;
        b=lroXnETA+9ynZZ3P5/SknrD1y/6HSpT/qdL0Shh8IOX2quW/+jCYIJ/4f3jZOkpQnl
         UlqkD8b1Hd8CfbrZhskk3+r0QJj55KgZU99hP5h7rz+08C8ChRQzwRx6fnqD1mzfFFsQ
         JbX/qrl/ZuO7xZTb2yJqe2+UqnAT9QskwYmOSV1fBYCREeYq1ZV0R79/3K1mTOaWyD+2
         yKtpUX/UvpNzzHWpvSpDdjbv4sSa0k2XnpkPbkvuM7P4YrB35Z3/j39BF+FpGRQytn3q
         oZS3fL39st9Amfua/mQ766cyROSO3JmMFPp+c4INk4TUr822wD4OgtqN9EAftDpABIuH
         SPGg==
X-Forwarded-Encrypted: i=1; AFNElJ9kX+2/1OCPoNWrENFXN0+3YCII6pLyYsUbxPkZJYQp0hTM7LQw4HqvGI18963GsucDutQ0tXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkETmasxTVoFfpnJGLp5tjFyHQAaFq6DvW8UbtudiPIrI/lI4h
	kes42VdBagTndHVcIy49hzua9jRWm/Z9rM8M/wBL2dzhYjy7RBoqfGTy
X-Gm-Gg: Acq92OHjO/+5ZaqQY0vzWHiXwHfKE5dDhZxICQk1Hw5ziKWwhszvWVVGf29cw1jAvQa
	0szVo++zothWgH7SJBAFQAuPxmFUaFLANb9aLoBbdz8SFNy6bfmAjXSozLqTx8Kc42VQKxXCRIW
	QsbDkG83zk3JlGbAi18TDBSPTDww8MT3Xxkkk3MuczL2b5vORJ0KvJQPWib0b02XuuF+bxms8Fl
	tzQwiuVbZU041vab1i1X5O4pIYL1hBfKPlw1f/wWeH0a9qKOvk6IGOCQnMIrbh6Y1bNXTZXDj7J
	4a5K1h7D/6Bm5PmQZ3LEhLOlJzX3nP+S546cafIs+h7yNe2jr493JRa2U8TFueP+2/UGRdWpbVN
	pyNDql/8/Dxc7NFmEjJ4RE1w5Beqb1M9eVH4/fkJwxksRu7xvPIssHkJGl9EmC6HXwih/qpUKPT
	qNNNwJ9iBfdgl4tujBpvnYvcvQKs0T
X-Received: by 2002:a17:902:d50e:b0:2b7:a1ff:b239 with SMTP id d9443c01a7336-2baf0d27e04mr160602415ad.14.1778554744436;
        Mon, 11 May 2026 19:59:04 -0700 (PDT)
Received: from fedora ([2001:ee0:4fc8:5b0:526c:3adf:8a0d:13a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27242sm129460145ad.9.2026.05.11.19.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:59:03 -0700 (PDT)
From: Minh Nguyen <minhnguyen.080505@gmail.com>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Tue, 12 May 2026 09:58:51 +0700
Message-ID: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37FAC519214
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286934-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

vmci_transport_recv_connecting_server() jumps to its destroy: label
and performs an unconditional sock_put(pending) to release the
explicit sock_hold() taken by vmci_transport_recv_listen() before
schedule_delayed_work().  The existing comment claimed this was safe
because the listen handler removes pending from the pending list on
the way out, which would prevent vsock_pending_work() from dropping
the same reference later.

That assumption breaks for a peer RST.  The default arm of the packet
switch sets:

	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;

and vmci_transport_recv_listen() only calls vsock_remove_pending()
when err < 0:

	if (err < 0)
		vsock_remove_pending(sk, pending);

For RST (err == 0) the socket stays on the pending list, so when
vsock_pending_work() fires it takes the is_pending=true path and
drops all three references itself: the pending-list reference via
vsock_remove_pending(), then the two trailing sock_put(sk) calls.
The unconditional sock_put() in destroy: had already dropped the
explicit sock_hold() reference, so the second trailing sock_put(sk)
in vsock_pending_work() is a write into the freed AF_VSOCK slab
object.  KASAN reports a slab-use-after-free write of 4 bytes from
refcount_warn_saturate() on the workqueue path:

  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
  Write of size 4 at addr ffff88800b1cac80 by task kworker
  Workqueue: events vsock_pending_work
  Call Trace:
   refcount_warn_saturate
   vsock_pending_work
   process_one_work
   worker_thread

Triggering the bug requires only the ability to open a VSOCK
connection to the target and send a RST before the listener accepts.

Skip the sock_put() in destroy: when err == 0 so it only compensates
the cases where vmci_transport_recv_listen() actually calls
vsock_remove_pending().  RST is the only path that reaches destroy:
with err == 0; every other path produces a negative value, so their
behaviour is unchanged.

Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=y,
kasan_multi_shot): same trigger binary, same VM, 100 iterations:
without this patch 52 KASAN slab-use-after-free reports fire; with
this patch applied, 0 reports.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
v2:
  - Resubmit to netdev per Stefano Garzarella's request after v1 review.
  - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
    enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
    same VM, 100 iterations); test summary captured in the commit
    message.
  - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
    bug is no longer embargoed.
  - Rebased onto net/main (no functional change to the diff).

v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
no public link available).  v1 review summary, for reference:
  - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
    vmware guys on this that know this code better."  Asked for retest
    and resubmission via the net tree workflow.
  - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
    me."  Also noted that no modern VMware product allows guest-to-guest
    VMCI communication, so the practical attack surface is host -> guest.

 net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4296ca1..88d7128 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 destroy:
 	pending->sk_err = skerr;
 	pending->sk_state = TCP_CLOSE;
-	/* As long as we drop our reference, all necessary cleanup will handle
-	 * when the cleanup function drops its reference and our destruct
-	 * implementation is called.  Note that since the listen handler will
-	 * remove pending from the pending list upon our failure, the cleanup
-	 * function won't drop the additional reference, which is why we do it
-	 * here.
+	/* Drop the reference taken by vmci_transport_recv_listen() before
+	 * schedule_delayed_work() only on real errors.  For a peer RST
+	 * (err == 0) the listener leaves pending on the pending list, and
+	 * vsock_pending_work() will drop that reference itself when it
+	 * later cleans the socket up.  Calling sock_put() here in that
+	 * case would be a double-put and free the socket while
+	 * vsock_pending_work() still holds it.
 	 */
-	sock_put(pending);
+	if (err < 0)
+		sock_put(pending);
 
 	return err;
 }

base-commit: be48e5fe51a5864566307998286a699d6b986934
-- 
2.54.0


