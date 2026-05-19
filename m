Return-Path: <netdev+bounces-289388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE9MLuc4DGq2aAUAu9opvQ
	(envelope-from <netdev+bounces-289388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:18:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BA257C09A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B7C030362C2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4887D4B8DED;
	Tue, 19 May 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAG29ITP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0D4C041F
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185792; cv=none; b=k2XYSOAHySd8UehmGOVi9RFb3ruNfPC2ORSUsBWLEq7TqBCBclQUnyc8R0bMADGEC5Hud3Vw1YixYGtIxyZIwefH2mWeeiuIbsIB7UtfgWYBVmEIap+QuClRRRhOPZgF8awD2NzlDDbVUOfU1XzLVuI3n1vY8ExHhJMiyqqnMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185792; c=relaxed/simple;
	bh=A8lCk64tyDutpdWygpqGjJXORX5zZQ3IQ4DQQhG5Q8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/yChPSc9syqjaYXFgTIymk9VoKUtQgWj9xHvdWo7umQ/oZSyRa3seVvvjPAUrrx8xCq9lq59oGy21UySZwU6iJvx8MNSBtcJdHHDCFK2YQurRzdk0P4Ecp1/OeThDgBHCYMN8+ABmNOpEe1t2wJBLhyIvb1R/ejgXALXPfIh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAG29ITP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so2043354a91.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779185786; x=1779790586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6PE6oczvQzlzFTW3XERm2G8PX98I8qUZJMdLKZ7oFc=;
        b=DAG29ITPJ/oltyXTun/ebhMLfI83fqgSN5oYsS8vRj/qE1KkpfXMT5DP39bLfwUYKR
         A6BsCPu6Q7ejgyDVjPGZzdCTDcGFuJbTDWldnF1AIX7qzyQw1hb4iD6DikwQIAm0hk5I
         Joa75cPtaN+xi+JdCSK5IEGsGP3hy8FzGGDho8DnGsK1oNn69lBhVSWIg845okyayfgN
         XwH2LITXECyTa/FmUOZYrrP84s1HQ60j6XeEqRarl27x7qAyK8IXwc6qoRQ0vsFFbI+L
         W1KzxEBC7kFJYAPkvUiusmzN1FbPmLRmNtF5s8svPufgVbe2VqbgnTtzXMgWxtSxoerD
         dO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185786; x=1779790586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6PE6oczvQzlzFTW3XERm2G8PX98I8qUZJMdLKZ7oFc=;
        b=YIwhyWVEqR7LYo9S+v+cJu3WVEyDKvtcPzPVNneDLMSPSj7QaT6kZm3FomKLXFAS9S
         EILE2U99of+vCS0Km00CkncjNdESsDwBrZqBS044BHngUA+7h1V1h5kR3+IIpTE7O9ab
         xNLY5jBZm+askNFATTngYu0oc6+/8jeMVtrEfSszx0dLXYAaovuu8TWfJGfdKA3Uwlyg
         y2Cpe5GgtGCzSLpeGewQmDWvC8mxhuatQRz1nz+Xem9oUdPuZahatzkFKnOeBkLQzi8T
         uucqMH1tYicYASK+7gRIKblLzp2wRegyzMk4Zz7m5SOluDuaxWXb39uidPk4eMaCmpOI
         wpKA==
X-Forwarded-Encrypted: i=1; AFNElJ9wEEAhDcysL66bFAYwIlo/dT+PmBqK/aBJDXmU0rV6MvgWq+RpQyEQNfIHlw5fM8Cx/BEsKY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjm9StKKoZsHYYsi02z3bSD1jKIcEWAwVuVE7BnGQfQM8EupAh
	Akehf0AE5VS2cbFWVBYfWjhC7QdMPXGXM7MwwJ87CG7KmCddZOHd/oZo
X-Gm-Gg: Acq92OETK1EbqzaZEWGjPP9aBQmJfFD7QuEyG7wnjq2TFpxIk2MEkCEhM1hFoBf+5Ye
	DShpa37xdC893DXih7rQ3x8eSYVhKfo+LxqHo+ZnmaYqinSAa4Rd/sEYwf8KnMKAtqF6ZLOejJC
	lHAomRr326P7PogiVJM1wXb0A8M0s75cQ+ZWsdnelZjgk95DZCEtg/g3nWClDDqCZq9/Fq/A2gj
	cYmJbZln9hb8RgXt7WYCrqGfeR3sHJ6bdst/AXyctj7j9UzRgWtiBeDjtQs0R4jkvnQ/OrjIHSs
	OmH8awmfU+CqT9erAnbutAf9377mK4TdND8nTlOA6bH3GZRNXxazBxMU9V7RoxNNa3+6jxWS1cS
	0Yv6spVdL2cCwrjaR20rhz+dsfKImDo7YN24joVYsp/pjJCWi7QJho6C4NyWOlYACkA7WfR1G8q
	QnWpyOErYc8jNimpMgo3FJBn5xIQ==
X-Received: by 2002:a17:90b:2742:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36951b82f8fmr19522119a91.15.1779185785623;
        Tue, 19 May 2026 03:16:25 -0700 (PDT)
Received: from fedora ([171.243.49.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d234540sm177683165ad.79.2026.05.19.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:16:24 -0700 (PDT)
From: Minh Nguyen <minhnguyen.080505@gmail.com>
To: pabeni@redhat.com,
	bryan-bt.tan@broadcom.com
Cc: sgarzare@redhat.com,
	vishnu.dasa@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Tue, 19 May 2026 17:16:10 +0700
Message-ID: <20260519101610.233070-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agwv3YkxYIC7mvyj@sgarzare-redhat>
References: <agwv3YkxYIC7mvyj@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289388-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 74BA257C09A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmci_transport_recv_connecting_server() returned err = 0 for a peer
RST in its default switch arm:

	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;

That made vmci_transport_recv_listen() skip vsock_remove_pending(),
leaving the pending socket on the listener's pending_links with
sk_state = TCP_CLOSE while destroy: still dropped the explicit
reference taken before schedule_delayed_work().

One second later vsock_pending_work() observed is_pending=true and
performed full cleanup: vsock_remove_pending() then the two trailing
sock_put(sk) calls -- the first reached refcount 0 and __sk_freed
the socket, and the second wrote into the freed object:

  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
  Write of size 4 at addr ffff88800b1cac80 by task kworker
  Workqueue: events vsock_pending_work

Treat peer RST like any other unexpected packet type (err = -EINVAL).
All destroy: arms now return err < 0, so vmci_transport_recv_listen()
removes pending from pending_links synchronously and
vsock_pending_work() takes the is_pending=false / !rejected branch,
dropping only its own work reference.  This also closes the
multi-packet race Sashiko reported on v2: pending is removed from
the list before any subsequent packet can find it.

The pre-existing sk_acceptq_removed() gap on the err < 0 path of
vmci_transport_recv_listen() that Sashiko also noted is not
introduced or changed by this patch.

Tested on lts-6.12.79 with KASAN: 52/100 unpatched -> 0/100 patched.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
v3:
  - Different approach to Sashiko/Paolo's "trading UAF for leak"
    concern: normalize RST to err = -EINVAL so all destroy: arms
    take the same err < 0 cleanup path -- no special case, no
    multi-packet race.
  - Sashiko's secondary observation ("while not introduced by this
    patch, does this error path leak sk_ack_backlog slots on failed
    handshakes?") is correct: the sk_acceptq_removed() gap on the
    err < 0 branch of vmci_transport_recv_listen() is pre-existing
    and is not introduced or changed by this patch.  v3 stays
    focused on the UAF; a separate fix for that gap is needed and
    would be welcome from anyone closer to that area.

v2: https://lore.kernel.org/netdev/20260512025851.189140-1-minhnguyen.080505@gmail.com/

v1 was sent to security@kernel.org on 2026-05-10 (not on lore).

 net/vmw_vsock/vmci_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4296ca1..ba3a66e 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1161,10 +1161,17 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 		}
 		break;
 	default:
-		/* Close and cleanup the connection. */
+		/* Close and cleanup the connection.  Peer RST is treated like
+		 * any other unexpected packet type in this state so that the
+		 * pending socket follows the same cleanup path as other
+		 * handshake failures, instead of being left on the pending
+		 * list for vsock_pending_work() to find later (which races
+		 * with subsequent packets and was the source of a UAF when
+		 * the cleanup work observed an inconsistent ref count).
+		 */
 		vmci_transport_send_reset(pending, pkt);
 		skerr = EPROTO;
-		err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
+		err = -EINVAL;
 		goto destroy;
 	}
 

base-commit: be48e5fe51a5864566307998286a699d6b986934
-- 
2.54.0


