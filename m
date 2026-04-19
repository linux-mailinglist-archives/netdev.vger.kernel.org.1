Return-Path: <netdev+bounces-279598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VxMQC9zu5GnLcAEAu9opvQ
	(envelope-from <netdev+bounces-279598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 17:03:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 967BF4246DB
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 795F23004637
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889BA34FF40;
	Sun, 19 Apr 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRB9Ho07"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278432D7DCF
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776611032; cv=none; b=AnDj3rSlO1cufxSyV9rZHOpmYFAhxR3+ZkrZmLKpDwrLEt85ofJc3pk++eJRAdd0GxOhP+Xf33TDjIs3VGI2gPnevNZ7AzB4LppNF+s60OzUn5Gkiprf+aHOQa2iuYKXnYGpnfDi+WZKZK2I2sjHgvLFBWmcobfTSfb88OVMQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776611032; c=relaxed/simple;
	bh=7F60SSrHJuuj37siQvsAm+ufPyPi/yXV0jfkLdlJBjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQ0UjPkvNVJjN11FW6HFEBf7f0kwUPrC165IHT2K9cXPDFViuVQ71F1SPtS+OM2FfaNpu/4sO/M6wGSyyNXwoxFC1XqSvDJRn10xuaF9Bcs/zr+Tuqlh1Z//1bUuDtgBVNUfPC8RdtcBSy9kahtjsrDYkxdyvO/OmET0hXWPLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRB9Ho07; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2576887eec.0
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776611030; x=1777215830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkEaXmTj5uTg/vFgKNlji8gUN80AsQRcCUMNvFtX7zk=;
        b=nRB9Ho07tLMbWimYjBwgWax/G8+LLlRMuRji1sXMmRdfyOu048pj9G96eWPC+X5Vh0
         OJ/UfXk2GWVAoZm55801D1phTH9y+UdWyz4EdZGWJWCQ1jJyvO5Qb5/VjtFPJZA/QJ7/
         OJwbtLu5MIp5L6ENXFkoSV3o7MzytTwiPA6IzGoUcKc7ZHCgWKpnFrWx8EdSo+Mqj2jl
         nZmo8+Ce5y3jRMDGPXneLHJbIShSJFebfpteHEkHl6y7d9XVsI2lgJxD9irYHtFySCMh
         fmvbHMKmGUR9lmz5YzagVsDQHsXCtzmFJotiSUUkFmtysZToyGr2IU1UjTd1O5nQtFzr
         HfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776611030; x=1777215830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkEaXmTj5uTg/vFgKNlji8gUN80AsQRcCUMNvFtX7zk=;
        b=tVPA7V6g582JUS29I/qZ7zZ9D6ZyBCl9M1mN0Cq0EBtNjyyUEd8mhqbz3CnJcfdDom
         m1IZ/qLOOK53kTWoqFFAot90h2O9dK67Q5icfavmKEyP1SXlSeJWB+g+VhSk4pMrm1/C
         rj6gCotF52MkXOLdsly0YUEW2ByZMamiDfsuMJxydvni3i1I9k9kmFDopvXvH2jYTaG+
         BxxlhyPITr27YbwykfJqKVcGdTxSQPzbga0JhneQiikxw15z7tLNNxmfvM6VbdpYYwOx
         fUF1W76uy3xgFaJaL+A7hcSHUzWRthjI8BmMCK6PqZWN0eyolO1lfnwDLFH643X1x8Qs
         wCjg==
X-Gm-Message-State: AOJu0Ywh0YPjVGSP7F2+Xb6dyjn1p6QbEIXwLPLeUL3QGgZ8ccxD9KSV
	ajXldWOBlSb31rXViRsuvMIBojnSd1gP8BWHAozwlcIoEZIiwpBtZSmL
X-Gm-Gg: AeBDievEyX4PhFhMJEfrQISwpe3gACyheEzA9ZX9MCH845wJOeRBYUvT9Efvlhj+NDa
	4QCt3kk58SMwWOXwOtGx+qc/DQbmeiCHsfyK6+kjCXz3xLEwmpTLc0DR4YN+UXxsRMaACzkfjxp
	GyiKdLzInBkust4Odl224qZ6ERDIht8ViZfVT54VAWgsDOPmFjHhtRM8d+nw1sDYjuRvha2b5WQ
	mx+l14DIPhdy74HR4XX8o3nK5EKGNP+DRaRKHjtM1D+dLfozoiI9Vs5vqQVP7mEUeEnGk9+zXHy
	LpIsv9r/LIvpU5dB+D5p/gBo9yPJrkiGKSxOOBTRZU1C2o9l5WTxsvZ87EtmMsgU1na7Yh7TrYl
	WWVXYxQwPg95MQ9sG/dtDBjOtPn+6sxuhqLRUBEVaRFcHlPUgKOgyVTGHOwZFed+lrLHgTlVKdX
	Oz7qGnx2oYxlZZh4q4N0mxOsrP0ldg9f822XZFuEwBB9AiQPO+QNbH
X-Received: by 2002:a05:7300:1351:b0:2de:2f38:a7cb with SMTP id 5a478bee46e88-2e4788392f0mr4693613eec.18.1776611030108;
        Sun, 19 Apr 2026 08:03:50 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm12350791eec.8.2026.04.19.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 08:03:49 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net] ipv6: validate extension header length before copying to cmsg
Date: Sun, 19 Apr 2026 23:03:44 +0800
Message-ID: <20260419150344.624673-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279598-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 967BF4246DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip6_datagram_recv_specific_ctl() builds IPV6_{HOPOPTS,DSTOPTS,RTHDR}
cmsgs (and their IPV6_2292* legacy counterparts) by trusting the
on-wire hdrlen byte (ptr[1]) when computing the put_cmsg() length.
The length was validated only at parse time (ipv6_parse_hopopts(),
etc.). An nftables payload-write expression can rewrite hdrlen after
parsing and before the skb reaches recvmsg; the write itself is
in-bounds but put_cmsg() then reads up to ((hdrlen+1) << 3) = 2040
bytes from an 8-byte header. nftables is reachable from an unprivi-
leged user namespace, so this is an unprivileged slab-out-of-bounds
read:

  BUG: KASAN: slab-out-of-bounds in put_cmsg+0x3ac/0x540
   put_cmsg+0x3ac/0x540
   udpv6_recvmsg+0xca0/0x1250
   sock_recvmsg+0xdf/0x190
   ____sys_recvmsg+0x1b1/0x620

Clamp each cmsg length against skb_tail_pointer(skb) before calling
put_cmsg(). Extension headers are kept in the linear skb area by
pskb_may_pull() during input, so skb_tail_pointer() is the correct
bound. The check is replicated at each call site (one HbH, four
RFC2292 sites, and four switch cases in the DSTOPTS/RTHDR/AH walk)
rather than hoisted out of the switch, to keep the fix minimal and
backportable; a follow-up cleanup can factor it out. In the walk
loop a failed check also aborts the walk, since subsequent offsets
depend on the tampered length.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/ipv6/datagram.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index ca3605acb..a7b9f5a24 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -643,7 +643,10 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	/* HbH is allowed only once */
 	if (np->rxopt.bits.hopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 hbhlen = (ptr[1] + 1) << 3;
+
+		if (ptr + hbhlen <= skb_tail_pointer(skb))
+			put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, hbhlen, ptr);
 	}
 
 	if (opt->lastopt &&
@@ -668,27 +671,37 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 			case IPPROTO_DSTOPTS:
 				nexthdr = ptr[0];
 				len = (ptr[1] + 1) << 3;
+				if (ptr + len > skb_tail_pointer(skb))
+					goto ext_hdr_done;
 				if (np->rxopt.bits.dstopts)
 					put_cmsg(msg, SOL_IPV6, IPV6_DSTOPTS, len, ptr);
 				break;
 			case IPPROTO_ROUTING:
 				nexthdr = ptr[0];
 				len = (ptr[1] + 1) << 3;
+				if (ptr + len > skb_tail_pointer(skb))
+					goto ext_hdr_done;
 				if (np->rxopt.bits.srcrt)
 					put_cmsg(msg, SOL_IPV6, IPV6_RTHDR, len, ptr);
 				break;
 			case IPPROTO_AH:
 				nexthdr = ptr[0];
 				len = (ptr[1] + 2) << 2;
+				if (ptr + len > skb_tail_pointer(skb))
+					goto ext_hdr_done;
 				break;
 			default:
 				nexthdr = ptr[0];
 				len = (ptr[1] + 1) << 3;
+				if (ptr + len > skb_tail_pointer(skb))
+					goto ext_hdr_done;
 				break;
 			}
 
 			off += len;
 		}
+ext_hdr_done:
+		;
 	}
 
 	/* socket options in old style */
@@ -705,19 +718,31 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	}
 	if (np->rxopt.bits.ohopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 hbhlen = (ptr[1] + 1) << 3;
+
+		if (ptr + hbhlen <= skb_tail_pointer(skb))
+			put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, hbhlen, ptr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst0) {
 		u8 *ptr = nh + opt->dst0;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 doptlen = (ptr[1] + 1) << 3;
+
+		if (ptr + doptlen <= skb_tail_pointer(skb))
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, doptlen, ptr);
 	}
 	if (np->rxopt.bits.osrcrt && opt->srcrt) {
 		struct ipv6_rt_hdr *rthdr = (struct ipv6_rt_hdr *)(nh + opt->srcrt);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, (rthdr->hdrlen+1) << 3, rthdr);
+		u16 rtlen = (rthdr->hdrlen + 1) << 3;
+
+		if ((u8 *)rthdr + rtlen <= skb_tail_pointer(skb))
+			put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, rtlen, rthdr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst1) {
 		u8 *ptr = nh + opt->dst1;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 doptlen = (ptr[1] + 1) << 3;
+
+		if (ptr + doptlen <= skb_tail_pointer(skb))
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, doptlen, ptr);
 	}
 	if (np->rxopt.bits.rxorigdstaddr) {
 		struct sockaddr_in6 sin6;
-- 
2.47.3


