Return-Path: <netdev+bounces-263333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK2ADh0Vp2ncdQAAu9opvQ
	(envelope-from <netdev+bounces-263333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:06:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 949431F4651
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFBEF3075E83
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0523BED30;
	Tue,  3 Mar 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2wBqH2qq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0035D72631
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557271; cv=none; b=Bj/ocl+TjqrsmuJc24UgE9PHB3DDppcmhNVukUrV1pTLTYJA5hIk4LavGZYCf9PXNfac4aLzQm1DkIqdB9EoKH97DZhh6ko6dJ6B+AA7EII7HNWtVLjFotXmuzo0VRSm91OsBGbX+ZmwEkwd5Abq+N2yRqTPsTNqoXD+nyd69Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557271; c=relaxed/simple;
	bh=BLatzjqVvtRsincIhVbebxR/E15+tJc7XPVTRhg/sOA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h6M/OzdCyiVenDPySQfn1PRBmdK7IiZj/mk3bch7m1bahHiqx8gZMtiODwkplTyQDIyc6xYupDKe6NgSIuS1nZWEfRG1oTjMqkJXtlYZ023mlBbKn0Eef2oJFbjv9Ofr2uU0w7j2TyhV1KMwtMIi/f247B9RvFJufh1zKb1qt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2wBqH2qq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adef9d486bso53030645ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 09:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772557269; x=1773162069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3W9msYejfIcxyZd2zRSvO+gfVN6T58KsrkSE6malUmY=;
        b=2wBqH2qqXp70k3QpPRUCGSBNul+e6Kq29ZYea3P3cYm+xuyaXEaton5qX91wONraSj
         5vZdbdEkgi+wtGNe2vF5mtIdfCfhkzWJDHLdIE0tcO1TZmJCtIqxcTT7fv1hIo2MGzjX
         A7picmfgB5DQYvLJ+01fN7xfRjPZ+SrijCUSjqr+ufU/sQg1SMIyTGaTNjDcBoRJVmT/
         jPtxdcqgHPAXUbtOyRdtkBYQlR3Ek+BThpOJKNza9rrXqA7J9d06K8+krX+cE40hcfMO
         8QSAJcJyECLkf60j6L3RUWAIbpngVINw8MYirc1/7G8t6HnTupReKSYKAtUUfxGTx2ok
         7t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557269; x=1773162069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3W9msYejfIcxyZd2zRSvO+gfVN6T58KsrkSE6malUmY=;
        b=ACna0DTiVkU6kgGJxFVK1iIzubT84bUmt9wAO8lCsfyDmLgbuoMENung3Z1cdsGDgE
         AiR+mMHo9lIqfOfQipYKMd4NxmJdNAUx23MxYfJzXy1CfqPVz/RFlRjHgO3uSRhraVwd
         nzJ7juWDdHDyoZhZMY6SCIkNTH5Z0nlvL1wzwr6xyJBdnLbPj/D4rbcuocUVQiakSBSv
         3pypPmJ00i4X+f7RZsfQicWkgAGuyXemGXCJ+GkN3z08PS2KyudSXVLXpMGzOrbw6MWJ
         B4+6cwUTQ26YV4k0LcQlxFtXyTG9dHQksNoq6OGWvlfOD/WTridJ5ls+0/JNR1L8o0rg
         Magw==
X-Gm-Message-State: AOJu0Yx4D5iemBD4PlxIuVGTCIsJmg9mlKrDM7bvB973L5dO6dlLU2Dw
	FXNVkV1HNAyf91+m6FTEgdf1y60PpqJGYJ4qrzGT+WEPDDq1cJsWjPUuc6ypOSGLYFmvipijIoN
	0D4Q/Kt2PjFaZQFaFbnm/X+hSl+h88+mPZm2yZAPziaFnr71H2M5dy0FaktKIbqqKBLyywggFCD
	ZBHxbSMBCLI104cVeWDZ4J1XyjlT4lDfw=
X-Received: from pgbr11.prod.google.com ([2002:a63:5d0b:0:b0:c70:e705:e5b2])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5747:b0:340:25f0:a9b
 with SMTP id 98e67ed59e1d1-35965ce437amr14974704a91.33.1772557268887; Tue, 03
 Mar 2026 09:01:08 -0800 (PST)
Date: Tue,  3 Mar 2026 17:01:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303170106.129698-1-jrife@google.com>
Subject: [PATCH net-next v2 0/2] Preserve UDP socket addresses on abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 949431F4651
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263333-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

BPF cgroup/sock_release hooks can be useful for performing cleanup,
map maintenance, or other bookkeeping when sockets are released. Cilium
uses cgroup/sock_release hooks to do just that, cleaning up maps keyed
by socket destination addresses. This works fine for TCP and connected
UDP sockets when they're closed gracefully, but Yusuke reported that
this fails for connected UDP when sockets are aborted prior to closing
the socket. Cilium in particular actively destroys/aborts connected UDP
sockets, so this scenario can happen easily.

From Yusuke's testing results in [1]:

1. socket connects to "127.0.0.1:8000"
2. socket aborted - diag_destroy (tcp_abort/udp_abort)
3. close(sock_fd)
4. BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) runs my_sock_release()

__section("cgroup/sock_release")
int my_sock_release(struct bpf_sock *ctx)
{
    ...
    /* For TCP, dst_ip4 == "127.0.0.1" but for connected UDP
     * dst_ip4 == 0.
     */
    ...
}

Case  Protocol        IP Family  Type	        Result
1     TCP             IPv4       Regular close  Cleaned up
2     TCP	      IPv4       Abort          Cleaned up
3     TCP	      IPv6       Regular close  Cleaned up
4     TCP             IPv6       Abort          Cleaned up
5     UDP (Connected) IPv4       Regular close  Cleaned up
6     UDP (Connected) IPv4       Abort          Not cleaned up
7     UDP (Connected) IPv6       Regular close  Cleaned up
8     UDP (Connected) IPv6       Abort          Not cleaned up

This patch aims to make the behavior consistent between TCP and
connected UDP by preserving the socket destination address and port
through to the sock_release hook.

Regarding my approach:

Currently, udp_abort() calls __udp_disconnect(), but this seems like
overkill in the case of a socket abort. __udp_disconnect() handles two
special cases:

1. When a socket binds to 0.0.0.0, connects, then disconnects using
   AF_UNSPEC it needs to be rehashed as described in commit 303d0403b8c2
   ("udp: rehash on disconnect").
2. Avoids unhashing the socket in cases where it was bound to a specific
   port.

This makes sense in the case of a graceful disconnect (AF_UNSPEC) where
the socket remains intact and may be used in the future, but it seemed
sufficient in the case of a socket abort to simply set sk_err so that
future operations on that socket fail and to unconditionally unhash the
socket if it is currently hashed, thus avoiding any of the field
manipulation that __udp_disconnect() would otherwise do.

[1]: https://github.com/cilium/cilium/issues/42649

CHANGES
=======

v1 -> v2:
* Set connect_fd back to -1 after calling destroy() in the selftest
  (Jakub).

Jordan Rife (2):
  udp: Preserve UDP socket addresses on abort
  selftests/bpf: Ensure dst addr/port are preserved after socket abort

 net/ipv4/udp.c                                |   4 +-
 .../bpf/prog_tests/sock_destroy_release.c     | 136 ++++++++++++++++++
 .../bpf/progs/sock_destroy_release.c          |  59 ++++++++
 3 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_release.c

-- 
2.53.0.473.g4a7958ca14-goog


