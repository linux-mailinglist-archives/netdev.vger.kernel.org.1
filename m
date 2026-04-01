Return-Path: <netdev+bounces-274169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKS2OaRBzWkkbAYAu9opvQ
	(envelope-from <netdev+bounces-274169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:02:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ECD37D9B8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83DC731409D9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA24038A707;
	Wed,  1 Apr 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIkD2tVp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23828150F
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058445; cv=none; b=QG/ls/PCuWzAf2Tx117He0kMEYDHqkv4pwxL7T3+WIiSdWfvDj1ydcY2MNUHpJ7aHe7HzNCMy/w4sNBpUg7ZncFF1KN1s/EljsnNBjN9pqz4+2w7F7YvvKzN7RpqdeDEy7e3d+bx4Fm9nXCwOexBK1/UeBkUcdUCAi7n3MpcGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058445; c=relaxed/simple;
	bh=SJPM1nrJgNFuoVQt3hKMT8oj5nE5p7E/RZ78EtEFQCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IprsNE6RfBZPNO4oKOUUdQzfABtQ7L5ZQRUdPZ/5RWBeiMxcFvvZp/Ddu7x2PZPX7PPOkJhePn7Ei7n57607UWjUrqX17jqszB2zglvX1F+dKTjL81Gv9HfVvO5sNlOvOuRP4DmsLHwSVQ4AXxYJNok3TdEnULMEqKMClcXILiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIkD2tVp; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50911c94db1so168205491cf.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775058443; x=1775663243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8e3QnTGEmn+xO1v/AEWDaJO66fFRlPzhelLmuf1jyTc=;
        b=GIkD2tVp1Wgie6sWJu33cD1Ozta0RlIWnMA0tmuLCxYvTjtxu4L1+AAa+UMDxuHVdY
         1TIky/uVOUeB+hCbJG0rzpS8TZvJHrpY54k0PM8/qdeQbSk8qzaV64xgb4bIAIglCfF6
         NeviYwXXPAC3K8vkzCovK58Ip8lU1jWM+xRjHs2DgMaoNB9EcUom+m7WULJeh2hb8j0w
         pmf3p9Tr7/FNcJFZcNeUDGehxDz/LopoQ373X1aNHMcF825gtWn+wqMFyEGQeDoH+WGI
         eG85qXN5x0beOaYgAdsZdVkAZTKkbka6PeyyS1ovY0KZIpOxdL/ojgLSXCevULpV/s8A
         8fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058443; x=1775663243;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8e3QnTGEmn+xO1v/AEWDaJO66fFRlPzhelLmuf1jyTc=;
        b=LSEqn6brPi7JaRjSwz2auU04Wd7T08cGY1PtYTOjLnITSScACnCwxJ5T1sq5GGMwtF
         pb0v2wd24MQAtFrvZEyH+1qNMmorzcQrs3U0i27/KQGhIwxePgWExtAjQw9onl89hcZ/
         lTUXmxz/uPIxTG8w/kjBiL27ROBhaBwyEeEMFZEwvhoUnELCee/J3lad9t8XRWwXe7RH
         xQJLBDEn64XQuyyThhMZ4DzTFIIGjhciEBmDP6cSlP6/eHOk0yWNhNecSvkiC78dfmsc
         jyCEpgcll1YVaIr44nJyH1/EUDIwUv0vXICi5xFXFxPel93+/gReGeFxAj/UJ6bf0fWT
         Ee0g==
X-Forwarded-Encrypted: i=1; AJvYcCW0vJN8r42YYZXGE9Ol/Th6MPcRHehFe5MsAw2Ph2rokzYineTryLseu9ZsnTT1k1NsDBRqVBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw639GIGr1MEvHI3YjGCDSLzVJYMp+MG3yfonBT2xA/Uoo/kYzW
	EGcyA8BX7oWVx2R/50AfzcPfgPvjcxoB6XX11WJg3Hp7MLK7QDFsRIfRubBJA6FwQIZYJJ3t1T0
	ypl6KP6bVeSN48A==
X-Received: from qtbie6.prod.google.com ([2002:a05:622a:6986:b0:509:68f:94fe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:10c:b0:50b:4d80:ccbf with SMTP id d75a77b69052e-50d3bc1e274mr57070361cf.21.1775058442629;
 Wed, 01 Apr 2026 08:47:22 -0700 (PDT)
Date: Wed,  1 Apr 2026 15:47:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401154721.3740056-1-edumazet@google.com>
Subject: [PATCH net] ipv6: avoid overflows in ip6_datagram_send_ctl()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Yiming Qian <yimingqian591@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274169-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29ECD37D9B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yiming Qian reported :
<quote>
 I believe I found a locally triggerable kernel bug in the IPv6 sendmsg
 ancillary-data path that can panic the kernel via `skb_under_panic()`
 (local DoS).

 The core issue is a mismatch between:

 - a 16-bit length accumulator (`struct ipv6_txoptions::opt_flen`, type
 `__u16`) and
 - a pointer to the *last* provided destination-options header (`opt->dst1opt`)

 when multiple `IPV6_DSTOPTS` control messages (cmsgs) are provided.

 - `include/net/ipv6.h`:
   - `struct ipv6_txoptions::opt_flen` is `__u16` (wrap possible).
 (lines 291-307, especially 298)
 - `net/ipv6/datagram.c:ip6_datagram_send_ctl()`:
   - Accepts repeated `IPV6_DSTOPTS` and accumulates into `opt_flen`
 without rejecting duplicates. (lines 909-933)
 - `net/ipv6/ip6_output.c:__ip6_append_data()`:
   - Uses `opt->opt_flen + opt->opt_nflen` to compute header
 sizes/headroom decisions. (lines 1448-1466, especially 1463-1465)
 - `net/ipv6/ip6_output.c:__ip6_make_skb()`:
   - Calls `ipv6_push_frag_opts()` if `opt->opt_flen` is non-zero.
 (lines 1930-1934)
 - `net/ipv6/exthdrs.c:ipv6_push_frag_opts()` / `ipv6_push_exthdr()`:
   - Push size comes from `ipv6_optlen(opt->dst1opt)` (based on the
 pointed-to header). (lines 1179-1185 and 1206-1211)

 1. `opt_flen` is a 16-bit accumulator:

 - `include/net/ipv6.h:298` defines `__u16 opt_flen; /* after fragment hdr */`.

 2. `ip6_datagram_send_ctl()` accepts *repeated* `IPV6_DSTOPTS` cmsgs
 and increments `opt_flen` each time:

 - In `net/ipv6/datagram.c:909-933`, for `IPV6_DSTOPTS`:
   - It computes `len = ((hdr->hdrlen + 1) << 3);`
   - It checks `CAP_NET_RAW` using `ns_capable(net->user_ns,
 CAP_NET_RAW)`. (line 922)
   - Then it does:
     - `opt->opt_flen += len;` (line 927)
     - `opt->dst1opt = hdr;` (line 928)

 There is no duplicate rejection here (unlike the legacy
 `IPV6_2292DSTOPTS` path which rejects duplicates at
 `net/ipv6/datagram.c:901-904`).

 If enough large `IPV6_DSTOPTS` cmsgs are provided, `opt_flen` wraps
 while `dst1opt` still points to a large (2048-byte)
 destination-options header.

 In the attached PoC (`poc.c`):

 - 32 cmsgs with `hdrlen=255` => `len = (255+1)*8 = 2048`
 - 1 cmsg with `hdrlen=0` => `len = 8`
 - Total increment: `32*2048 + 8 = 65544`, so `(__u16)opt_flen == 8`
 - The last cmsg is 2048 bytes, so `dst1opt` points to a 2048-byte header.

 3. The transmit path sizes headers using the wrapped `opt_flen`:

- In `net/ipv6/ip6_output.c:1463-1465`:
  - `headersize = sizeof(struct ipv6hdr) + (opt ? opt->opt_flen +
 opt->opt_nflen : 0) + ...;`

 With wrapped `opt_flen`, `headersize`/headroom decisions underestimate
 what will be pushed later.

 4. When building the final skb, the actual push length comes from
 `dst1opt` and is not limited by wrapped `opt_flen`:

 - In `net/ipv6/ip6_output.c:1930-1934`:
   - `if (opt->opt_flen) proto = ipv6_push_frag_opts(skb, opt, proto);`
 - In `net/ipv6/exthdrs.c:1206-1211`, `ipv6_push_frag_opts()` pushes
 `dst1opt` via `ipv6_push_exthdr()`.
 - In `net/ipv6/exthdrs.c:1179-1184`, `ipv6_push_exthdr()` does:
   - `skb_push(skb, ipv6_optlen(opt));`
   - `memcpy(h, opt, ipv6_optlen(opt));`

 With insufficient headroom, `skb_push()` underflows and triggers
 `skb_under_panic()` -> `BUG()`:

 - `net/core/skbuff.c:2669-2675` (`skb_push()` calls `skb_under_panic()`)
 - `net/core/skbuff.c:207-214` (`skb_panic()` ends in `BUG()`)

 - The `IPV6_DSTOPTS` cmsg path requires `CAP_NET_RAW` in the target
 netns user namespace (`ns_capable(net->user_ns, CAP_NET_RAW)`).
 - Root (or any task with `CAP_NET_RAW`) can trigger this without user
 namespaces.
 - An unprivileged `uid=1000` user can trigger this if unprivileged
 user namespaces are enabled and it can create a userns+netns to obtain
 namespaced `CAP_NET_RAW` (the attached PoC does this).

 - Local denial of service: kernel BUG/panic (system crash).
 - Reproducible with a small userspace PoC.
</quote>

This patch does not reject duplicated options, as this might break
some user applications.

Instead, it makes sure to adjust opt_flen and opt_nflen to correctly
reflect the size of the current option headers, preventing the overflows
and the potential for panics.

This applies to IPV6_DSTOPTS, IPV6_HOPOPTS, and IPV6_RTHDR.

Specifically:

When a new IPV6_DSTOPTS is processed, the length of the old opt->dst1opt
is subtracted from opt->opt_flen before adding the new length.

When a new IPV6_HOPOPTS is processed, the length of the old opt->dst0opt
is subtracted from opt->opt_nflen.

When a new Routing Header (IPV6_RTHDR or IPV6_2292RTHDR) is processed,
the length of the old opt->srcrt is subtracted from opt->opt_nflen.

In the special case within IPV6_2292RTHDR handling where dst1opt is moved
to dst0opt, the length of the old opt->dst0opt is subtracted from
opt->opt_nflen before the new one is added.

Fixes: 333fad5364d6 ("[IPV6]: Support several new sockopt / ancillary data in Advanced API (RFC3542).")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Closes: https://lore.kernel.org/netdev/CAL_bE8JNzawgr5OX5m+3jnQDHry2XxhQT5=jThW1zDPtUikRYA@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/datagram.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index c564b68a056268c7cbc81b5f29f60289ea9e09eb..993e2d76fc1f66166df3c31d7e370726d5bd6df2 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -763,6 +763,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 {
 	struct in6_pktinfo *src_info;
 	struct cmsghdr *cmsg;
+	struct ipv6_rt_hdr *orthdr;
 	struct ipv6_rt_hdr *rthdr;
 	struct ipv6_opt_hdr *hdr;
 	struct ipv6_txoptions *opt = ipc6->opt;
@@ -924,9 +925,13 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 				goto exit_f;
 			}
 			if (cmsg->cmsg_type == IPV6_DSTOPTS) {
+				if (opt->dst1opt)
+					opt->opt_flen -= ipv6_optlen(opt->dst1opt);
 				opt->opt_flen += len;
 				opt->dst1opt = hdr;
 			} else {
+				if (opt->dst0opt)
+					opt->opt_nflen -= ipv6_optlen(opt->dst0opt);
 				opt->opt_nflen += len;
 				opt->dst0opt = hdr;
 			}
@@ -969,12 +974,17 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 				goto exit_f;
 			}
 
+			orthdr = opt->srcrt;
+			if (orthdr)
+				opt->opt_nflen -= ((orthdr->hdrlen + 1) << 3);
 			opt->opt_nflen += len;
 			opt->srcrt = rthdr;
 
 			if (cmsg->cmsg_type == IPV6_2292RTHDR && opt->dst1opt) {
 				int dsthdrlen = ((opt->dst1opt->hdrlen+1)<<3);
 
+				if (opt->dst0opt)
+					opt->opt_nflen -= ipv6_optlen(opt->dst0opt);
 				opt->opt_nflen += dsthdrlen;
 				opt->dst0opt = opt->dst1opt;
 				opt->dst1opt = NULL;
-- 
2.53.0.1118.gaef5881109-goog


