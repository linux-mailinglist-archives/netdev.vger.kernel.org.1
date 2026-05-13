Return-Path: <netdev+bounces-287528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKSUEUdZBGozHQIAu9opvQ
	(envelope-from <netdev+bounces-287528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:58:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A09531BCD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B44F302BBAD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC138F24F;
	Wed, 13 May 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHp9/hMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1AD3909B8
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669729; cv=none; b=ta+eOM1pZ92XgsRJUGOtk7/GrrWxwudDDBsxg9WutYxEUHW3NSzSws2ZQ0WJajCfYHAAI1XvTA884sQfFeukruiurrHTiN2tKxBeXC9fO2K6yqyXs/PvCbDQO7JATYZxeNKAmhX3iyBlayY/WBNvz2EZDoismrJm+pFwxbaULwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669729; c=relaxed/simple;
	bh=1k6WTMFhrXyA/znL3IBVvVdsa/4Okp9ywx9f6iZ7AGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqWY2rRd+1AkpZ0kqY0V6kZrzTPn180qH9/3/9anwl9WDHZPK/n89QMRrtpssw7etWjFPL7zwt4AfI0gnfMfVHl3RrBZkqDA+ki9FvfUwks4MS7JepSolsiqYj6S/vI9cK2FjeAnvljaBRW7c/nfkHOOiYSer17LAlqBaaM166Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHp9/hMf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so59148195e9.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778669726; x=1779274526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7LAKju6yinUp5AwzsNmF8iUgexG+EtHz4fQlf15j5E=;
        b=DHp9/hMffrTfmKKvxidbQRB8Ux5TRgG4R506crF3yU0PzTEhZiTsm0X/vGY39l90bi
         up4lus8+cIduDw6DtbGu3tU03xSeTPzcf4+oB18E6HHWBl/myW33bghP1pCDhbEnBkZd
         zzq1Wbk3LL94O4kaGbUwV0YmuMRCNLwMTKNI8vzuKRxOT6jsLiuD4kbD3Q9SsRk1fqZJ
         jEWDwSkVOGuz0P8pIPpnAUY9T/gsFeoTAaei+wbGH1hGSbYDK/rigsJ66PAT2HplswC4
         mqjYJ0njFbWvCZE/zCL91YdAhFvCgnuLqW5wxqOZ2I/UOzRoWFrm1hAWrbvUTahSesRu
         71CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669726; x=1779274526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7LAKju6yinUp5AwzsNmF8iUgexG+EtHz4fQlf15j5E=;
        b=I+Q/LLWVuluuKzJG326VdwHUfuAHwuG1WNL+ZunpzAJAThp+zSMj5ya/suxsd3lf0M
         aR30lVh3HfyL007Icvy3wiywusn1i8AE2e8HlAP+bfkNHXipOzsY8TbSDIHlgd0c4ECF
         WmP2GYavIgduDffs+IMMz4ANoUPUa6xtRNAhbCIJqgcUl7YF/86na3em06LLRIseTQcN
         00mJ+1rwj3syUZrzqe/WLV+3tYYbt0eV7mucHfk1B3j6G19QbSw2QPD8hX16pLRpAiL/
         8W8ChCjD/TvLXrJfe4X379ip1Nt8Ar9yJwsL91hYU4eE4U3Cyf3lgvfQtdOujB4uCR76
         c2dQ==
X-Gm-Message-State: AOJu0YznPYqbT6/d3J5NPBdlXx1VXx1trxLpXWUCiR9pUpUSIeVAsW+n
	LXohJKrCrpkVFrgfQbxaSuZ+tXrHTKPiqFEMzb98y1dSphsA90wwmkRf7Zi+kbOfMas=
X-Gm-Gg: Acq92OF4fXBEP7fwSjbBMe5PfAgSEO0T8d9xn9r/v1bWEQ32dAXJvLZi4KAEhdDFxHo
	wnj7L6UB6RJIMufWIhFiTPouQEWD+xHI5XLxHLitF5d0reaCD3BaUSisJGgvX7zsVQrDdck8Ldi
	XaWAc17zNUwQ8Q6QkcdTiWJZiN0s4BPvtNzVrrsNCmeTGzh6l3Qr55Wve/fOpujWJ4xrPxoQ8tq
	45k50oTtkZ/hDofR1UjyNF7rpAxOJOX/Uh46GAgakz6UygGYVT9uDhfjz905ScVpZ4y7t0VzEtr
	/j5lGmHNPhw8Snw3m5uNy3CR6bRiTwuBEUDjSfBVgmdjtGfjHtlo0kfhPugu7SAVTLWCnrOtxYp
	JD4JeoNfTrQDXkm6mN4jKjR/JcM5/orwnPBkUiz8haEZeKHDzCB2jZxhydetesXsUVyX183vSKo
	5UZtZRrMppLsD49Ng/ZrzDBKNUgb0kR3eZeAIS9WZOFW/TmfKQUONvPVi/adhcM/BPszcr9KdFr
	r4ETbsmALg=
X-Received: by 2002:a05:600c:4e02:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-48fcea062bemr31307275e9.24.1778669726154;
        Wed, 13 May 2026 03:55:26 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f438890sm46688195e9.23.2026.05.13.03.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:55:24 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2 0/2] ovpn: fix TCP teardown UAF races
Date: Wed, 13 May 2026 11:55:19 +0100
Message-ID: <20260513105521.21629-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512042036.19870-1-devnexen@gmail.com>
References: <20260512042036.19870-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 99A09531BCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

v1: https://lore.kernel.org/netdev/20260512042036.19870-1-devnexen@gmail.com/

Two distinct UAFs in the TCP transport teardown path, both inherited
from 11851cbd60ea ("ovpn: implement TCP transport"). They share a race
class with the already-merged 94560267d6c4 ("ovpn: tcp - don't deref
NULL sk_socket member after tcp_close()"), which fixed the detach-side
of the keepalive-vs-userspace-close race window; the two patches in
this series cover the other two victim sites in the same window.

Patch 1 fixes a UAF in ovpn_tcp_close(). The function loads the
ovpn_socket via rcu_dereference_sk_user_data(), caches sock->peer in a
local, drops rcu_read_lock, and then passes sock->peer (rather than
the cached local) to ovpn_peer_del(). Unlike ovpn_tcp_sendmsg() which
uses the same pattern but is protected by lock_sock, ovpn_tcp_close()
runs without the socket lock - inet_release() does not lock_sock
before calling sk_prot->close. A concurrent ovpn_socket_release() can
therefore complete kref_put -> detach -> synchronize_rcu -> kfree(sock)
in the window after rcu_read_unlock() but before the dangling
sock->peer dereference.

Patch 2 fixes the CMD_NEW_PEER error path in ovpn_nl_peer_new_doit(),
which calls ovpn_peer_release() directly rather than ovpn_peer_put(),
bypassing the kref. The accompanying "peer was not yet hashed, thus
not used in any context" comment is correct for UDP but wrong for TCP:
after ovpn_tcp_socket_attach() publishes ovpn_sock via
rcu_assign_sk_user_data(), the peer is reachable via sk_user_data ->
ovpn_sock->peer; userspace recvmsg/sendmsg/close/poll and the
strparser-driven ovpn_tcp_rcv() path can bump its refcount.

Both Fixes: 11851cbd60ea ("ovpn: implement TCP transport"). Not Cc'd
to stable - borderline practical reachability and reproducer is
non-trivial; maintainer judgement on backport.

Changes since v1:
- Patch 1: tighten the entry block to read sock->peer exactly once
  into the cached peer local; route the hold check, ovpn_peer_del()
  and prot->close() invocations through that local (Eric Dumazet).
  The same multi-read pattern in ovpn_tcp_recvmsg(), ovpn_tcp_sendmsg(),
  ovpn_tcp_data_ready() and ovpn_tcp_write_space() will be handled by
  a dedicated helper in a follow-up net-next series (Sabrina Dubroca,
  Antonio Quartulli).
- Patch 2: make ovpn_peer_release() static and drop its declaration
  from peer.h, since the netlink callsite was the last external user
  (Sabrina Dubroca, Antonio Quartulli).
- Both patches: add Reviewed-by from Sabrina Dubroca.

David Carlier (2):
  ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
  ovpn: respect peer refcount in CMD_NEW_PEER error path

 drivers/net/ovpn/netlink.c | 8 +++++---
 drivers/net/ovpn/peer.c    | 2 +-
 drivers/net/ovpn/peer.h    | 1 -
 drivers/net/ovpn/tcp.c     | 9 +++++++--
 4 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.53.0


