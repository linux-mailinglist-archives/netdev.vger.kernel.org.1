Return-Path: <netdev+bounces-286938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGu/L6WqAmqkvQEAu9opvQ
	(envelope-from <netdev+bounces-286938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:20:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8565198A3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCE7C300B2A4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76762D9EE4;
	Tue, 12 May 2026 04:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDVsw8Pi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A323A984
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559646; cv=none; b=E9NlgwW9qK/du+3K5XqUwyqpJU9PlRYsW4kZiIvsIuzEaWsGYJB61CqTZ+QM48+6A/Sk8ZT9Y4NChGcrIwM9iz5CB6q7uIb4a5+MWDFGiWfgsBBWT0CnqYD0BIPn92+/dJk1JMSabJO5rTDSqWU0u/pNEORt93hBcQXMKjyqCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559646; c=relaxed/simple;
	bh=J73l5U9Sx07EGAgWi6Q9iSUpB16DxlhPVIkCuLFiKf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpwk/JJO/0jsEtCxg3sbwadh2jyQI2sBmuKZQcBK95XgP4laOsdkhuiXTrQvQhBixi5bdz2rlZp2T4WWZy+ghq16ClYSC4u2N2LFEZrt33VoBZJtzppKgSIpx3xRZsbvO3KkP3Vj9kFHaLnU6GBr2Xmqf/ybGOHUG3Y3OxInsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDVsw8Pi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso54974515e9.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778559643; x=1779164443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zXLLdOv4rmsvALUvbnxKoMY9G6lNFNqtU8tunEw4OAY=;
        b=lDVsw8PiutC2zo31sqfWBzPzUNn5sR2C9J8ij9zzZ7Vq5UqmYLCAe4yo4rEiaf6UlN
         jbnSTUXfRWxkJUrwJfWuV1NzfBcMDzOjwJb7/sEggEc0oZ2ncuIl/ZvxvHlpfMqPog1z
         +lC4QEIohOCZ6j3O3zYtmKValNy09ZQrGGoZVIrFUR6yfvddNhWdJkuMWZPF4fVY2jr6
         nRh1oXkfLwr6EnURx8tMo3LGkbijxYP0xqpcgavHsvsbINKBAqyPum/SEqMJME0IuIX4
         vUSiIqAWMoDKX24Lp4fbF46qHP9Yz240yszQdjjcuAq+FGTfgeCFRb3yvq39gyBw1kj/
         HhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778559643; x=1779164443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXLLdOv4rmsvALUvbnxKoMY9G6lNFNqtU8tunEw4OAY=;
        b=dLYRhz5ZBHN+KkJT8VXXTpW5EO2KQqqNHO98zIH8NqrcSaUoBCMqPSatmh9wQgdN8k
         PuQbm+ZE/noksGN86osUQFg8tlR7mFyitVPh34UII4KZfirV1Z1ucNJRyyRmV2YCcHV4
         GoVzoMvCilq110R/FoNSNDaAdlgOczGDwTWaOY5gOjXcX7HQM/UKmO+oYlMNu7OyAggV
         AUHc5Nzc+X2c7lMtxSkRPEvtA7RXFAoQGkkyaGU61ykY6L1VwhVuAGy0XTT7IXzbro7D
         Ux0Hd6Sm4JNYW9K7NpMa4UCsNfxH/PyNUpv8kAvfOSbujH/FEGieMVF0MdiciiYgRJ9f
         fZ+w==
X-Gm-Message-State: AOJu0Yxq4GUJOi+TuCqQoW1IoH43VGMu56z7ok1AmqGrxm8v8D51TvKs
	Dy7L7WNaU4eINZMAccUTIEm+3fgXw0sD4i1ix785u/RO1n6ZAwT1dGTHVVOCaOfP+XE=
X-Gm-Gg: Acq92OGh+bRO9tOtUyCF5pH8RHQRJ2xyZEnkHt4XijMYY99qwzTNDhe8FCmuWF1C1lG
	R5gXSIG+wbKDu4oDEEjke8gZ9++W6kZa4ADMYoQiF2F46OaAeJgM738TYxrivNw79qNORM8+/9t
	8u03k4dDbUAUwUpfX5/2SX+afO23V4ahfo6FtJjViR3pIjduyDoqqZnoN/ZjvuGGORqpzdXtTty
	GHDWMkNPtsv26UmZdY0djpb4Ak11AOPjeoB9ReJQz43IPZyx8OcDHUkBS607du1EaFeDNKisqri
	YnwiVmHn6OxXqW7/WFwRA61TYi/3KT9pRDGX8HoyoD1rtDRpNjaU6rrc72iF/jneOgcluNkS454
	JUbVZGf3s3eLAL2wCyYCcg2Z1X8IVHBZu+X6acGOT5ekNVJxQOrkU9v1AatQS+Ff945SjlAWQG+
	E2Lezl9QdVJ9q9FU+ED8MWrLmjNv4yeYDqBHouAbTO4X5wKMqdsUt+rZPhDH4ruMeda7v51dSAQ
	PIfWj7kwJk=
X-Received: by 2002:a05:600c:470a:b0:488:a639:b772 with SMTP id 5b1f17b1804b1-48e51e15485mr412179505e9.7.1778559643360;
        Mon, 11 May 2026 21:20:43 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e908d2c77sm16802215e9.12.2026.05.11.21.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:20:42 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>
Subject: [PATCH net 0/2] ovpn: fix TCP teardown UAF races
Date: Tue, 12 May 2026 05:19:11 +0100
Message-ID: <20260512042036.19870-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF8565198A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286938-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
  sock->peer dereference. The cached peer local already exists, is
  held by ovpn_peer_hold() taken under RCU, and is the correct argument.

  Patch 2 fixes the CMD_NEW_PEER error path in ovpn_nl_peer_new_doit(),
  which calls ovpn_peer_release() directly rather than ovpn_peer_put(),
  bypassing the kref. The accompanying "peer was not yet hashed, thus
  not used in any context" comment is correct for UDP - whose
  ovpn_socket union uses the .ovpn arm and is unreachable from a peer
  pointer - but wrong for TCP. After ovpn_tcp_socket_attach() publishes
  ovpn_sock via rcu_assign_sk_user_data(), the peer is reachable via
  sk_user_data -> ovpn_sock->peer; userspace recvmsg/sendmsg/close/poll
  and the strparser-driven ovpn_tcp_rcv() path can bump its refcount.
  ovpn_tcp_socket_wait_finish() drains strparser and tx work but does
  not synchronize with userspace syscall callers. Use ovpn_peer_put()
  so the kref correctly defers destruction until the last reference
  is dropped.

  Reachability is narrower for patch 2 than patch 1: it requires a
  userspace operation on the TCP fd to be in flight while the netlink
  CMD_NEW_PEER handler hits an error in ovpn_nl_peer_modify() or
  ovpn_peer_add(). A well-behaved openvpn daemon issues CMD_NEW_PEER
  before passing the fd to a recv loop, but the kernel cannot enforce
  that ordering, and the fix is one line.

  Both Fixes: 11851cbd60ea ("ovpn: implement TCP transport"). Not Cc'd
  to stable - borderline practical reachability and reproducer is
  non-trivial; maintainer judgement on backport.


David Carlier (2):
  ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
  ovpn: respect peer refcount in CMD_NEW_PEER error path

 drivers/net/ovpn/netlink.c | 8 +++++---
 drivers/net/ovpn/tcp.c     | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.53.0


