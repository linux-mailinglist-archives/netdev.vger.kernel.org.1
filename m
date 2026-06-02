Return-Path: <netdev+bounces-294228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yNcnGIzeHmp9WwAAu9opvQ
	(envelope-from <netdev+bounces-294228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:45:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D073962E9E3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:45:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dA4HSdrb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294228-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2330930F5D67
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFA83E6DEC;
	Tue,  2 Jun 2026 13:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA93E716D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:36:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407375; cv=none; b=nL652wZ+FIwLI8+Qz5jkk9TzVvwLIieK+gd+U7RrbbKTQ2Zk2gfcBrtbXtDkq/akQEZskjCSyrwEaePoYT+WpRPfdHD/WUe5Vi6TIOfUqZDR5nTCg6fKb7pSvnzGZWelEAu8ICSKSipwf/B5H5ZF+a2b/VNgv4kX6We90zEz1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407375; c=relaxed/simple;
	bh=1NL6Qmnkz0oI1ydQVFDJi6tvcpuaJ5q5yBcftCCrSTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFwzqy4BR1x6YqANWANzz/AUgoZoFkQSmoNgfe14xh1B5N6ExU+5jleBYHIntmUCVEJcOiG6Tn/L4OxLTezX9pIbuhsJCupNhd0WOY/QZraLuxFJ+O8QDwl0CxpNwmHZfo42ijszSmqcO6otoY+cTSMkCZhO7jYHxMkKnXPYJAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA4HSdrb; arc=none smtp.client-ip=209.85.222.44
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9640111c168so248159241.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407369; x=1781012169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5WTfY9YK2ad5b/+hJKuVJtifWnnYSlI3WuKMhEPBqM=;
        b=dA4HSdrbz3tW2D6rjv/nqtoLRq7kSm7joUKrgoKzkk976+0MA8Y0nD4SLj4JSrkLMe
         FJavDSTZmX/9uVNwrBy94cVsVgGpOpv5lqqNfD3vrq3GfXtxObzNMg3xLeyQU4agUsbK
         VoKYQVbdUOhgNAOEdH1c97nDU6UsziYwr8fqZl5d3oZaspK38iGl9IOavFBh0TkM1WRA
         d5SWWsqXUgQ9Zybj6yGLNuQtD86zlI6hmaQ1qWwv+M8a6/rQfMwkU9mjInpVZWnnwyUa
         aTW0VmlH9BV0+yxj5iI35fLx5uT3wxkB71Y6Vpb1FkZCNTTAi9cIk6ZGEZ8mytPI4s4A
         FKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407369; x=1781012169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5WTfY9YK2ad5b/+hJKuVJtifWnnYSlI3WuKMhEPBqM=;
        b=jKbHDRX1QZ6p1KBRdvReYXY5Ol4il2mxaAswhRfjW9BNfBZ97O/vssGn0zuTavqwiL
         McXgzkviz7Em0Pnjw5OB7YJWxoXp1Ow24dB6h0f1QX3h8Mpm5Wo5NezciHp0y+S1vAqo
         ySGaXKuAbgSbgbHv5e0uv+wKy3O3u/lbgpi4ACnIUJtyVubJvu3IxWomqnLoWyrkomJM
         QDfPLLNGsjqmfNgzpptpflxsGhYWXZHaOeZ/eyOt4INyHIBB/dcwDsmUNmYauLz5OpLE
         MYVstJmwkHSPi5WAAe7U72XDBYLtB8v/WWg2g15jxpkUAk+sJgemD7EXktCrckEsDYla
         emhw==
X-Forwarded-Encrypted: i=1; AFNElJ/wu40CikzbiA2Im2sHefVRpuzMzbFgAmN+xixl12thJ0pxlnCMH/N0/JJgxubSzGkazb0ls3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdjR6hsJ1hQcdwZ7uRORxPCBCbsmcI5FbD7YmmkOdO6W0LocS
	eP846FMcVBfqEKaXqroV3dvuPmTyb6ckvrX9v62+aWc5tUUR/4yLCyjn
X-Gm-Gg: Acq92OFuunMZ6kjhsAXm/kkWJnji5iHxqEU2NorFGRFHPehja7b71srsLpBwygqfB82
	eRftA56JMaNzT1bWxpmZJ8pxD9PSZNTVZdquZ4JYJYCCNdX4277+Lx05AgA3GIZMCad0IYUgOxl
	mbYaQzrsxJ4/M04nR1kNsMPqPfd3fBZSeRotUcKRN6oCcMz5h/4ETjQwMaOb09Kza/QRhKIqv4C
	8aseI0xiZ1c/66iPRYHjbUvRiAFaSS0wlvPYiGHyYaPut8c9Uz5K1/8NRMhIvXwvE07LpmqsHlw
	xmzW6WqbaAA9ZDHa2EpteVfiti/sADoQ/jEGmM/4H1TjLgTt9xZg6ycMBrLBpXuOOZaV4ag0AVM
	Ey0VP+rlcqmbJjmz2mVCjHok9Kg4+dsb5+TLOWyithsGGy36xa6g1r9lsVK4NTK+moQ5HGxlBKN
	SaHU49FAk6jvyCZLl/IUPJwkliWbLq6K8jUW8FiDXUy8tCWY+KdHL3saSCp0WrTBs+kit7bEqHV
	r8BTPYa8nROrRMN+07JrnsiVhRauJY=
X-Received: by 2002:a05:6102:3f51:b0:639:4bb7:c915 with SMTP id ada2fe7eead31-6c6943bfb5fmr7546364137.16.1780407369475;
        Tue, 02 Jun 2026 06:36:09 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915721f7d75sm346036285a.18.2026.06.02.06.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:36:08 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] tipc: fix missing netlink admin gate and receive-path bugs
Date: Tue,  2 Jun 2026 09:35:51 -0400
Message-ID: <20260602133555.769727-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D073962E9E3

This series fixes four independent issues in the TIPC subsystem. They all
require a node that has TIPC configured (the tipc module loaded). Patch 1
is then reachable by a local process with no capabilities; patches 2 to 4
are reachable by a remote TIPC peer once a bearer is enabled. They were
found by an audit of the TIPC netlink, neighbor-discovery, connection and
name-distribution paths with AI assistance; following the kernel's
handling of AI-assisted bug reports they are disclosed in public.

The central issue is patch 1. The TIPCv2 generic-netlink API registers
its state-changing operations without an admin-permission flag. Generic
netlink only checks CAP_NET_ADMIN when an operation sets GENL_ADMIN_PERM
or GENL_UNS_ADMIN_PERM. The legacy TIPC config netlink path gates the
same administrative commands behind netlink_net_capable(CAP_NET_ADMIN);
the v2 path does not. So on a node where the tipc module is loaded, a
local process with zero effective capabilities can set the network id and
node identity, install and flush AEAD key material, and enable, disable
and reconfigure bearers, links and media. This restores the authorization
gate the legacy API has always had.

The other three patches fix input-validation and arithmetic bugs in the
receive paths. They are reachable independently of patch 1 (from a peer
node over a bearer, or over an established TIPC connection):

  1/4 adds GENL_UNS_ADMIN_PERM to the mutating v2 ops, matching the
      legacy API's netlink_net_capable(CAP_NET_ADMIN) gate. A QEMU/KASAN
      repro run as uid/gid 65534 with zero effective capabilities could
      change the network id and node identity, set and flush key
      material, and enable and disable a UDP bearer; with the patch those
      calls return -EPERM.

  2/4 bounds the media-address and node-id reads in tipc_disc_rcv()
      against the received length. A short LINK_CONFIG message otherwise
      makes the handler read past the received data.

  3/4 caps the peer-supplied connection ack so it cannot underflow the
      unsigned 16-bit send counter and leave a connection permanently
      flow-control blocked.

  4/4 rejects a peer PUBLICATION whose lower bound exceeds its upper
      bound. Such a binding can never be matched or withdrawn and leaks
      the publication; the local bind path already rejects it.

For the record, two related TIPC issues are deliberately not in this
series because other contributors already have fixes posted to netdev:
the broadcast Gap-ACK out-of-bounds read in tipc_get_gap_ack_blks()
("tipc: validate Gap ACK blocks in STATE message") and the
neighbor-monitor use-after-free on bearer teardown ("tipc: fix UAF race
in tipc_mon_peer_up/down/remove_peer vs bearer teardown"). This series
does not touch those paths. Note that patch 1 also gates bearer
enable/disable, the operation that exposes TIPC's packet-receive paths to
the network, so it is useful as defence in depth and not only as an
authorization fix.

Each patch was build-tested with no new warnings against v7.1-rc5. The
four patches touch different files and are independent.

Michael Bommarito (4):
  tipc: require net admin for TIPCv2 netlink mutators
  tipc: validate discovery message length before reading media address
  tipc: prevent snt_unacked underflow on CONN_ACK
  tipc: reject inverted service ranges from peer bindings

 net/tipc/discover.c   | 14 ++++++++++++++
 net/tipc/name_distr.c | 11 ++++++++++-
 net/tipc/netlink.c    | 12 ++++++++++++
 net/tipc/socket.c     |  9 ++++++++-
 4 files changed, 44 insertions(+), 2 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.53.0


