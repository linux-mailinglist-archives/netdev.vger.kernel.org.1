Return-Path: <netdev+bounces-260632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IGgFxf3nWlzSwQAu9opvQ
	(envelope-from <netdev+bounces-260632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:08:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70EE18BAE2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EF1D30CA569
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2752EC09B;
	Tue, 24 Feb 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFxNc3yF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783052E9733
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959920; cv=none; b=gzYhmPj6kmP/VZsZuLD/ojeegWFM3i0ePrToAFTHjy92CCrSSOmFRPQoYOS5Ab4WKtFqn/qt0cVrQ/hU7H92w7VMU02n/u93fd0qgFtlavygwjO2z+1EGab/zu8HZyPOS3go2ypOuw6Op50VzHwVyFQV0iyHTMhBC3gT9kPPBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959920; c=relaxed/simple;
	bh=OCNxYDfnz8wR5V9Cv3OB9XetH+SY51hTcnZZ4pAoI5g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XCRTuzilfx6BOJWyBKiA0sgnB96ktXrbgsVZ/KSyk8/20oIxpW9tY1kvYnY6194+3gBuFb6ZfME5hj8DPmUgIfY0TYl/wLkJ2xgCBX1gkCqaOEBDP7GPcAa+owGpsYbvv4IeD5ny1AgR68XCyzILIksbDEVPI24c4aEtDvG4hgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFxNc3yF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ad7e454f38so257266285ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771959919; x=1772564719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l5d55I+UC4S2v9rGNSOm/YyhWxZHXqmfqn1568sIRjc=;
        b=pFxNc3yFlUUFp7n83pF0/+19giZ/9wzIS1mW8LecDz8w/GJgTs9ZJxyCAhQbvf/AH/
         TV5kwOO3T5emqALH8kB0hp4pcj4bWkzFtFy2HO7XLK2iUpZHWpw5M0FCIxJOc3ZXb52K
         ID7/v0oi0erlNpfUOS3+XtbqXvFcrKEVuupdwVTqgZCfK2g7Yejnzi9H+Js26XkEifNT
         ItIF2obcLSiarKopOW5qFUhakfJNx8ifLX27yolFjCqVopehhybLil0cT57CQecbCj0C
         MBwTQNyQWHTL2dHifOvpnA5f858w1kcY6m2WfCtowWgNm2B4EM5/TEYciklOyEB298OT
         wJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959919; x=1772564719;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5d55I+UC4S2v9rGNSOm/YyhWxZHXqmfqn1568sIRjc=;
        b=R3g7HGrrCWUyPdqR7jn44GhDTXQ9drlatk84A9x2msQnPk5RdfWUbZu+owT4ZbniG7
         5I800f/ZP1NQpA5zcYgvWc2qkqh65U/OiXwbCnSUABJieLIX+HRJwjViRYXBDpgE5Bg/
         V292QzjTwUOZk8aWtjxXy8dLxX+Hm+4WvFcXIj93Yc3NUe9o8tdNiVvEmpOJfP9GHf1Y
         gvVHsGTLWEBPBZXEnXq6y2rxsHIj6h98NC1K0hxh+u+EM4E1x+Vjdp8uWUmuNmlzOY3T
         dGAUS+Cm/DTFRFibMys9y1LcJXNI9c38iGVkm8oS6lgKg9/OqTq6Ueg9VMFHQUZKhFCG
         iiqQ==
X-Gm-Message-State: AOJu0YwFrUlILR5G2lpFEBu1pui9S6pEWQMTFI5l0BwSa4EH54JyFTrk
	mS4Qg7SOhXN2xZSiKdLgoAglNN6tvxv/iOZNdp+qawCeOwV/8HmQX6ENf6prxhxcLjC7+WQNmUs
	HSk00XD7LTvIudf12aIalzjFv7BybhNp3qjgEy3aFYIOUAg0Fip4xppPMda1EVFTKgjd9Sazo/S
	9trWJeeC5CLgBCNReZSKIuZFv9WKKnG1A=
X-Received: from plei10.prod.google.com ([2002:a17:902:e48a:b0:2a9:4415:acae])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e787:b0:2a9:3396:738
 with SMTP id d9443c01a7336-2ad74547d8dmr114595125ad.44.1771959918369; Tue, 24
 Feb 2026 11:05:18 -0800 (PST)
Date: Tue, 24 Feb 2026 19:04:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260224190516.2102048-1-jrife@google.com>
Subject: [PATCH net-next v1 0/2] Preserve UDP socket addresses on abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.862];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B70EE18BAE2
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

Jordan Rife (2):
  udp: Preserve UDP socket addresses on abort
  selftests/bpf: Ensure dst addr/port are preserved after socket abort

 net/ipv4/udp.c                                |   4 +-
 .../bpf/prog_tests/sock_destroy_release.c     | 135 ++++++++++++++++++
 .../bpf/progs/sock_destroy_release.c          |  59 ++++++++
 3 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_release.c

-- 
2.53.0.414.gf7e9f6c205-goog


