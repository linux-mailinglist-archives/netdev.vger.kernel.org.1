Return-Path: <netdev+bounces-292191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDSFD4euFmpHoQcAu9opvQ
	(envelope-from <netdev+bounces-292191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:42:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A05E1415
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63162303FF0A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEAF3E0733;
	Wed, 27 May 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JwPi/G8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EC2C1595
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871335; cv=none; b=E9yKaCtZdEelCAmPkB4Z7upFFn9Jmj5EE1dRLxbcYk0R7mMxB5YZQELR4x1AEzdS7wFhalJmbDGHXq3FZVL4RCgEfTI1PGBQjj4yUiRrgMnKg7K2BOkjhV2QgV0UAchFwvD81P1rpRILtEbEoEztPCBARA62H8ZdJXZET80e+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871335; c=relaxed/simple;
	bh=5okNZD1eu3CviRC5pJL21MYSgVeOfZZbEd76W61e7Wk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwEPqFhiFJ1fUppkQAXVYHftfDlYJjj/ubBShiF1flJxOBcxpSp4ZzwRiDckFqqcGki8auS1O3ucRxUW3RoHpm5nkyCRQFNzETjUZnf59UQVf2SD0TjYWfZNhxlR2CXnpX803o9KG891fYsaQVS7psqA78qMpmXvPo0jH0s1qFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JwPi/G8Y; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D2102205E3;
	Wed, 27 May 2026 10:42:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IA1lot8kYc4g; Wed, 27 May 2026 10:42:02 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0B5E420520;
	Wed, 27 May 2026 10:42:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0B5E420520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779871322;
	bh=U/F8pf5Czlt5KsKgrcsklNM9/tOs+HWlL64tqTzqHcY=;
	h=From:To:CC:Subject:Date:From;
	b=JwPi/G8YfL+gt2oVxwCsWgoo/iMK+PDdMoxw/oS5WZTupgOr3X+QtYg2EFrbMRVM8
	 l/uHgOkJsEA8yAXwRj4ETQ0k2dafvCRkzCkH+MoI6Nx4y3MeTt0I5cNsYApHBheqtj
	 8EaqyHwZli0YnAvZ/3MOY41wF2+kYGQ4sT4lMrTH6ABX1TfFkkHeh9KMJE7qcdpejA
	 DAFhEfMwEbSeGGmrIGMfN5ppu7XD0VObLyuOZQBIcChfYAKsGx/Bhb8id4+54OQA4N
	 43fesF5x0uGVlzS5yAn4TRaqbhE9QcGos+PhelziJnYEsTLvYzlZR3cDuglf6D9X37
	 8QpH+B3wDyOtg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 10:42:01 +0200
Received: (nullmailer pid 3493984 invoked by uid 1000);
	Wed, 27 May 2026 08:42:01 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/9] pull request (net): ipsec 2026-05-27
Date: Wed, 27 May 2026 10:41:18 +0200
Message-ID: <20260527084148.3489759-1-steffen.klassert@secunet.com>
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
	TAGGED_FROM(0.00)[bounces-292191-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA3A05E1415
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1) xfrm: route MIGRATE notifications to caller's netns
   Thread the caller's netns through km_migrate() so that
   MIGRATE notifications go to the issuing netns, fixing both the
   init_net listener leak and MOBIKE notifications inside
   non-init netns. From Maoyi Xie.

2) xfrm: ipcomp: Free destination pages on acomp errors
   Move the out_free_req label up so that allocated destination
   pages are released on decompression errors, not only on success.
   From Herbert Xu.

3) xfrm: Check for underflow in xfrm_state_mtu
   Reject configurations that cause xfrm_state_mtu() to underflow,
   preventing a negative TFCPAD value from becoming a memset size
   that triggers an out-of-bounds write of several terabytes.
   From David Ahern.

4) xfrm: ah: use skb_to_full_sk in async output callbacks
   Convert the possibly-incomplete skb->sk to a full socket pointer
   in async AH callbacks so that a request_sock or timewait_sock
   never reaches xfrm_output_resume() downstream consumers.
   From Michael Bommarito.

5) esp: fix page frag reference leak on skb_to_sgvec failure
   When the destination scatterlist build fails after old frags were
   already captured into the source sg, release those old page
   references before jumping to error_free to avoid leaking pages.
   From Alessandro Schino.

6) xfrm: esp: restore combined single-frag length gate
   Check the aligned post-trailer combined length against a page limit
   in the fast path, preventing skb_page_frag_refill() from falling
   back to a page too small for the destination scatterlist.
   From Jingguo Tan.

7) xfrm: iptfs: reset runtime state when cloning SAs
   Reinitialise the clone's mode_data runtime objects before
   publishing it, preventing queued skbs from being freed with
   list state copied from the original SA when migration fails.
   From Shaomin Chen.

8) xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit
   Flush policy tables and drain the workqueue in a .pre_exit handler
   so that cleanup_net() pays one RCU grace period per batch instead
   of one per namespace, fixing stalls at high CLONE_NEWNET rates.
   From Usama Arif.

9) xfrm: input: hold netns during deferred transport reinjection
   Take a netns reference when queueing deferred transport reinjection
   work and drop it after the callback completes, keeping the skb->cb
   net pointer valid until the deferred work runs.
   From Zhengchuan Liang.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit b266bacba796ff5c4dcd2ae2fc08aacf7ab39153:

  net: ethernet: cortina: Drop half-assembled SKB (2026-05-06 18:43:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-05-27

for you to fetch changes up to c16f74dc1d75d0e2e7670076d5375deda110ebeb:

  xfrm: input: hold netns during deferred transport reinjection (2026-05-26 10:35:30 +0200)

----------------------------------------------------------------
ipsec-2026-05-27

----------------------------------------------------------------
David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

Herbert Xu (1):
      xfrm: ipcomp: Free destination pages on acomp errors

Jingguo Tan (1):
      xfrm: esp: restore combined single-frag length gate

Maoyi Xie (1):
      xfrm: route MIGRATE notifications to caller's netns

Michael Bommarito (1):
      xfrm: ah: use skb_to_full_sk in async output callbacks

Shaomin Chen (1):
      xfrm: iptfs: reset runtime state when cloning SAs

Usama Arif (1):
      xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit

Zhengchuan Liang (1):
      xfrm: input: hold netns during deferred transport reinjection

e521588 (1):
      esp: fix page frag reference leak on skb_to_sgvec failure

 include/net/xfrm.h     |  3 ++-
 net/ipv4/ah4.c         |  2 +-
 net/ipv4/esp4.c        | 16 +++++++++-------
 net/ipv6/ah6.c         |  2 +-
 net/ipv6/esp6.c        | 16 +++++++++-------
 net/key/af_key.c       |  6 +++---
 net/xfrm/xfrm_input.c  | 16 ++++++++++++----
 net/xfrm/xfrm_ipcomp.c | 12 ++++++++----
 net/xfrm/xfrm_iptfs.c  | 28 +++++++++++++++++++++++-----
 net/xfrm/xfrm_policy.c | 17 +++++++++--------
 net/xfrm/xfrm_state.c  | 23 ++++++++++++++++++-----
 net/xfrm/xfrm_user.c   |  5 ++---
 12 files changed, 97 insertions(+), 49 deletions(-)

