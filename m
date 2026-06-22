Return-Path: <netdev+bounces-300976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hDYmESfrOGpCkAcAu9opvQ
	(envelope-from <netdev+bounces-300976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDA36AD744
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:58:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=eTrYCv7O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300976-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300976-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A3493032F7B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132F383987;
	Mon, 22 Jun 2026 07:57:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB863815E8
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:57:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115065; cv=none; b=F+xsMQ0OlU+DGO1p39jaNj7b+l7WeP4Gg5yueG7KmZQsXkPTXiAXsR1F0nuq7v91ZvQjeLN/lQ7hB1EM17pLzbvT6pZt0uNy7pOLI88YArvD8udfUYF9KkbleYnijegkxo6Nq11tmuKJpdRsMK8HiIg29/QR4WldH1DpcpDmTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115065; c=relaxed/simple;
	bh=XmrJEW68/IelDHrEEwwLMMj4qwv6KCYRU/dq4OBQAOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9od0b3kqgGXqtWhEMpwARpRTjRvgABZxwM52B+sHEAKTFWkA97MmYtRLJ7YB2hssM9Tm9Rd/Hplly+qOh/W8cZjVQh5vCEeIOMKl1QG3dhwt0ztvu6HMELx8wi5FWNYt6SZ4+CpSggM2oRYhyJ1sZILMdm0P/DCHJ67OcXVBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eTrYCv7O; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5A2D1201AE;
	Mon, 22 Jun 2026 09:57:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qKxGmNVI-PkY; Mon, 22 Jun 2026 09:57:33 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9B3F8201E2;
	Mon, 22 Jun 2026 09:57:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9B3F8201E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782115053;
	bh=lfC5oJUsCk1FYx3t/ZI0VB2hloGbdPKFg19iqLHYAxI=;
	h=From:To:CC:Subject:Date:From;
	b=eTrYCv7Of0d0dk3UdoNQL1gyWzwtnUziYWF28JX8IMUKKbdob9jTX4aDueUtYeoYa
	 jUZ//kaIThbjCZaILpcRZAb/5E/Ai7cLwYVikzGib+yR8CGrFaop6aCwAz2SQfZhd9
	 u5rfwHXfRbNyPmCaUQ+s0EsAltsdMzvUsfr5BWJnp9acucFpDY9e1wNWEVSBlZpVsL
	 ILewZG19iNnMrSpnDM9LhXczv/RTCuAi8QDlizYi1KMjeo+Qre/7abx8go8wYnCNyq
	 Qybb9g/ODgWv7A2e6xGBGCr7yJrTSdB9duXA/HcR4mNVPQGJuq79z/Y5gFsuHCJ+BR
	 mCth51yyOUDBQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 09:57:33 +0200
Received: (nullmailer pid 30051 invoked by uid 1000);
	Mon, 22 Jun 2026 07:57:32 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/7] pull request (net): ipsec 2026-06-22
Date: Mon, 22 Jun 2026 09:57:02 +0200
Message-ID: <20260622075726.29685-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300976-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,secunet.com:dkim,secunet.com:mid,secunet.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BDA36AD744

1) xfrm: use compat translator only for u64 alignment mismatch
   Gate the XFRM_USER_COMPAT translator on COMPAT_FOR_U64_ALIGNMENT
   so 32-bit compat tasks on arches whose 32-bit ABI already matches
   the native 64-bit layout are no longer rejected with -EOPNOTSUPP.
   From Sanman Pradhan.

2) net: af_key: initialize alg_key_len for IPComp states
   Initialize the alg_key_len to 0 in the IPComp branch of
   pfkey_msg2xfrm_state() so an uninitialized value cannot drive
   xfrm_alg_len() into a slab-out-of-bounds kmemdup during
   XFRM_MSG_MIGRATE. From Zijing Yin.

3) xfrm: Fix dev use-after-free in xfrm async resumption
   Stash the original skb->dev and extend the RCU critical section
   across xfrm_rcv_cb() and transport_finish() to prevent a
   tunnel-device UAF and original-device refcount leak when a
   callback replaces skb->dev. From Dong Chenchen.

4) xfrm: Fix xfrm state cache insertion race
   Move the state-validity check inside xfrm_state_lock in the
   input state cache insertion path so a state cannot be killed
   between the check and the insert. From Herbert Xu.

5) xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
   Add READ_ONCE()/WRITE_ONCE() annotations on xfrm_policy_count
   and xfrm_policy_default to silence the KCSAN data race reported
   on net->xfrm.policy_count. From Eric Dumazet.

6) espintcp: use sk_msg_free_partial to fix partial send
   Replace the manual skmsg accounting in espintcp with
   sk_msg_free_partial() so the skmsg stays consistent on every
   iteration and the partial-send accounting bugs go away.
   From Sabrina Dubroca.

7) xfrm: validate selector family and prefixlen during match
   Reject mismatched address families in xfrm_selector_match() and
   bound prefixlen in addr4_match()/addr_match() to prevent the
   shift-out-of-bounds syzbot reported when an AF_UNSPEC selector
   with a large prefixlen is matched against an IPv4 flow.
   From Eric Dumazet.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 9bf10032894f429b3e221de63cf95a8544511a90:

  Merge branch 'tipc-fix-netlink-gate-and-receive-path-bugs' (2026-06-11 16:01:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-06-22

for you to fetch changes up to 40f0b1047918539f0b0f795ac65e35336b4c2c78:

  xfrm: validate selector family and prefixlen during match (2026-06-17 11:17:27 +0200)

----------------------------------------------------------------
ipsec-2026-06-22

----------------------------------------------------------------
Dong Chenchen (1):
      xfrm: Fix dev use-after-free in xfrm async resumption

Eric Dumazet (2):
      xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
      xfrm: validate selector family and prefixlen during match

Herbert Xu (1):
      xfrm: Fix xfrm state cache insertion race

Sabrina Dubroca (1):
      espintcp: use sk_msg_free_partial to fix partial send

Sanman Pradhan (1):
      xfrm: use compat translator only for u64 alignment mismatch

Zijing Yin (1):
      net: af_key: initialize alg_key_len for IPComp states

 include/net/xfrm.h     | 15 +++++++++++----
 net/ipv4/xfrm4_input.c |  2 --
 net/ipv6/xfrm6_input.c |  2 --
 net/key/af_key.c       |  1 +
 net/xfrm/espintcp.c    | 34 +++++++---------------------------
 net/xfrm/xfrm_input.c  | 29 ++++++++++++++++-------------
 net/xfrm/xfrm_policy.c | 27 +++++++++++++++------------
 net/xfrm/xfrm_state.c  | 23 +++++++++++++++--------
 net/xfrm/xfrm_user.c   | 20 ++++++++++----------
 9 files changed, 75 insertions(+), 78 deletions(-)

