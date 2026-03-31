Return-Path: <netdev+bounces-273574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLGmKJary2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:10:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97D36888F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 674C0301A426
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95039DBE2;
	Tue, 31 Mar 2026 11:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E137997E;
	Tue, 31 Mar 2026 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955342; cv=none; b=RvSZQIvlDlmCVNnDd/vl+gVwAx4JEw+pMB6cepf5R487sC4hqA8IoP5C93GCAyu4oThQT9msziLblu+yNKkI7Ryp5+IFuG+yVxmjRkHnH67vmnsTDtjQi/s6ZUL6A/G6kr4ez7HRhGR9qiqJeWlf7oGGctRQhYXmfIy3NpG+ceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955342; c=relaxed/simple;
	bh=uXt46mYXa3mWxyi5nR4O2AFtZzetjrxkHsB2+go4B10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dpQZibHNn4mzabGSJktK668S+cgAvkwuGTqne19qtDpETBd4+8iG8W2AUu/Okfqpz1rTnnz+US6LwbsE9Np94ZeQ33cT3dfboEiAKur9/POEw7Rl1AyR0pwAogUdfqoWGARibwg9uizDXBosn874mw8BoSEYA+9UXodeVqoc6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62VB8VKH008582;
	Tue, 31 Mar 2026 13:08:37 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
        david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net 0/2] seg6: fix dst_cache sharing in seg6 lwtunnel
Date: Tue, 31 Mar 2026 13:07:53 +0200
Message-Id: <20260331110755.25042-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-273574-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E97D36888F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The seg6 lwtunnel encap uses a single per-route dst_cache shared
between seg6_input_core() and seg6_output_core(). These two paths
can perform the post-encap SID lookup in different routing contexts
(e.g., ip rules matching on the ingress interface, or VRF table
separation). Whichever path runs first populates the cache, and the
other reuses it blindly, bypassing its own lookup.

Patch 1 fixes this by splitting the cache into cache_input and
cache_output. Patch 2 adds a selftest that validates the isolation.

Andrea Mayer (2):
  seg6: separate dst_cache for input and output paths in seg6 lwtunnel
  selftests: seg6: add test for dst_cache isolation in seg6 lwtunnel

 net/ipv6/seg6_iptunnel.c                      |  34 ++--
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/srv6_iptunnel_cache.sh      | 177 ++++++++++++++++++
 3 files changed, 201 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/srv6_iptunnel_cache.sh

-- 
2.20.1


