Return-Path: <netdev+bounces-288107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKoDKbpXBmqhiwIAu9opvQ
	(envelope-from <netdev+bounces-288107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:16:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29068547B57
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8F23041B90
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D37382F28;
	Thu, 14 May 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Gqtb3oHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0E38AC7A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800554; cv=none; b=brxLXA6zvjkEdnxOxbkuNY75KoWN9RgpMpGb8BtBs15YPeFMApmFmBkg6GuVy0oJpAFmbwtk7M7lN0w8sYWgwSVSvzxNYSgBSAZh5InbpypDdqgJj7DdSAR6X/H+FzXKLnQJYgEbi4jnHtFRtRECPTk1TAIGCtcffsfScpu+xzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800554; c=relaxed/simple;
	bh=ewXoffUMdvv5bIqnKehYjG8x37emNgeK7NsMvf+ZziI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX57uW+UsvKNalK+hzaGEqRAoSPximlG4eF/eX4Fw5DMhAY+DCQcxc/BCYGyccceLV31sgSH5NaUtIulfn6zkHyIddvtbtKuLfz9C7+JR3Z+xAe5t07Qvl1/H5iwao/6OUimoevMhM2bnYsrnx5s1jWaHQ/9XSpk99+H34io9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Gqtb3oHL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so53737595e9.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778800551; x=1779405351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/mrH6176Er5Zw5wyJoHskLTSAXj0ZxyC3IIHUQZw7g=;
        b=Gqtb3oHLH+oaQMFwGMocVGmJM4gN2upplZ4oBCokKR+hisp+AueFcJy7rWX8nBwdKy
         W+pwiv8E6tnq2lvDAv4QxZTTams+bqu7s5cPuZDs3DNsIE3oKPtCYxZDtk7JUw//PEbg
         qEXHYe8EL+exxKvS3S1ncAMYASxevEFFNPKcsalMFo3fWDAwjndfaxDPtbI/hAcjeXCB
         Mib8uzQn8gN2nMSfFlb57+oFpDKmg93cgqQViqLRSXKqL6NUexT5VEdKVl4zK460+2OY
         kVWzCl2wIx/c0YZUYMUCmugKXD6uBvItHeaP0+VV9v6qlN0aKL1o9LG1Z/AzhjXOe/sZ
         +SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778800551; x=1779405351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/mrH6176Er5Zw5wyJoHskLTSAXj0ZxyC3IIHUQZw7g=;
        b=KgJ0Z7+18NCQtpB3FpjpoU2mFbk8qMaAkqV+mG9LIWwRmbLUSfq9HQE5H3m1xzCudt
         QIECD8MAHwaTnRIuNHszkmNLnY31mWE2d8g82YQxLGFiBB3pCjDseYBX2VYM1LipSbmC
         dXFqpZrJxh7v697gTtgejrAjwXM28hdQMPOHme2q+PiWGxB9wBSgqVOghdeLhu7Pz7WA
         sCwOpHShC1/HOrxHOI78zOCRNOCf0wXWVqw4rhHbspjW0tWBCKtk9LQTPvumdL/0hJD5
         5woE33UcLqxeTxxWSNSPqH7UJoKrjwItw5EQ18mLGSPCv3HBXLvwT2Jj7HPyhdwZ1vMS
         3udw==
X-Gm-Message-State: AOJu0YxIJXb79k8EL2byEGzIw/1ZgpTkauRr3r1W3oYyYK7Tq5LmbTua
	pyQ+GlX3q21L5M1OlcP9vnEsrtnw/Xhw08ybCGzt/Wf+i1BTBv75MU5rA/+jjcdVwBczCCGbPPp
	50CUKqexdJ04AvyY9D+fWfxc057Eg6NJK7id3queZ7++CJ6XJtNVWIpVj5LzVpSX6edA=
X-Gm-Gg: Acq92OG3RR5Dextd5kGx5icj2V4I84EmPEKXNQYdTV+uez0DumEgHAudJ6cYV5CVtX6
	gA7HMK0O6m/WycFspc9QVd8QkT4QmO+eYp8HQrgl7U3PJ5iwQZDZkQlZIRcIT6MdKeUoyNVFnCQ
	WTcr8A/TmAOVgvisEHPDLDIx+ouEyQJRDrwvzOFNy2L2eFpdk3iOXsWJg4LKF+MWkdbhdWKcMhs
	PRhGnOlWnyUhNh6PEbmJH97nQh3vTpmMMyioOvS2QZN0AEMd0yCJqbfWoBQ7OPbTIf9VGXhL8tj
	IXefUdj00CmMgF5zjxZJoU7Az/Ij5R7ccLIeC7u4rgGCFuq1hES0xsReXgr/fQi14ioaAG4/22y
	Sx59O4vu+w6nXnlBPOT0uBiN8MrCqZOZcCYrfLH/pLHjbcCI4x1uQ88F5KXhI8FXoMMAi/mpbo7
	01vfiwCgQc4tWrN+a7mFZyFDpCJme8uizpfPScZcP3whSXdA==
X-Received: by 2002:a05:600c:848c:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48fe60e51c6mr14739735e9.7.1778800550832;
        Thu, 14 May 2026 16:15:50 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:a628:d33e:601:ebb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm39155855e9.1.2026.05.14.16.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:15:50 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	David Carlier <devnexen@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/5] ovpn: respect peer refcount in CMD_NEW_PEER error path
Date: Fri, 15 May 2026 01:15:42 +0200
Message-ID: <20260514231544.795993-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514231544.795993-1-antonio@openvpn.net>
References: <20260514231544.795993-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29068547B57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,kernel.org,redhat.com,davemloft.net,google.com,lunn.ch,mandelbit.com,gmail.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288107-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: David Carlier <devnexen@gmail.com>

ovpn_nl_peer_new_doit()'s error path calls ovpn_peer_release() directly
rather than ovpn_peer_put(), bypassing the kref. The accompanying
comment ("peer was not yet hashed, thus it is not used in any context")
holds for UDP but not for TCP.

For UDP, the ovpn_socket union uses the .ovpn arm and never points back
at a peer; UDP encap_recv looks up peers via the not-yet-populated
hashtables, so the new peer is unreachable until ovpn_peer_add()
publishes it.

For TCP, ovpn_socket_new() sets ovpn_sock->peer and
ovpn_tcp_socket_attach() publishes ovpn_sock via rcu_assign_sk_user_data().
From that moment until ovpn_socket_release() detaches in the error path,
the TCP fd is fully wired: userspace recvmsg / sendmsg / close / poll
on the fd, as well as the strparser-driven ovpn_tcp_rcv() path, can
reach the peer through sk_user_data -> ovpn_sock->peer and bump its
refcount via ovpn_peer_hold().

ovpn_tcp_socket_wait_finish() (called inside ovpn_socket_release())
drains strparser and the tx work, but does not synchronize with
userspace syscall callers that already hold a peer reference. If
ovpn_nl_peer_modify() or ovpn_peer_add() returns an error while such
a caller is in flight - notably an ovpn_tcp_recvmsg() blocked in
__skb_recv_datagram() on peer->tcp.user_queue - the direct
ovpn_peer_release() destroys the peer while the caller still holds
the reference, and the eventual ovpn_peer_put() from that caller
operates on freed memory.

Replace the direct destructor call with ovpn_peer_put() so the kref
correctly defers destruction until the last reference is dropped.
In the common case where no concurrent user is present, behaviour is
unchanged: the kref hits zero immediately and ovpn_peer_release_kref()
runs the same destructor.

With this conversion ovpn_peer_release() has no callers outside peer.c
- ovpn_peer_release_kref() in the same translation unit is the only
remaining user - so make it static and drop its declaration from
peer.h.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 8 +++++---
 drivers/net/ovpn/peer.c    | 2 +-
 drivers/net/ovpn/peer.h    | 1 -
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 291e2e5bb450..4c66c1ec497e 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -462,10 +462,12 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 sock_release:
 	ovpn_socket_release(peer);
 peer_release:
-	/* release right away because peer was not yet hashed, thus it is not
-	 * used in any context
+	/* For UDP, the peer is unreachable until added to the hashtables, so
+	 * dropping the initial reference is enough. For TCP, the peer may be
+	 * concurrently reachable via sk_user_data->peer until
+	 * ovpn_socket_release() detaches; rely on the refcount.
 	 */
-	ovpn_peer_release(peer);
+	ovpn_peer_put(peer);
 
 	return ret;
 }
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..fb10d1fea940 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -354,7 +354,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
  */
-void ovpn_peer_release(struct ovpn_peer *peer)
+static void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	ovpn_crypto_state_release(&peer->crypto);
 	spin_lock_bh(&peer->lock);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 328401570cba..86c8cffada6d 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -127,7 +127,6 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 	return kref_get_unless_zero(&peer->refcount);
 }
 
-void ovpn_peer_release(struct ovpn_peer *peer);
 void ovpn_peer_release_kref(struct kref *kref);
 
 /**
-- 
2.53.0


