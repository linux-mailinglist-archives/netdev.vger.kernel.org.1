Return-Path: <netdev+bounces-180708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A5A82388
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770A217F68B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDB825E447;
	Wed,  9 Apr 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Stl/b+pz"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720D25D556
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198051; cv=none; b=oPWIP0JZb34aVGodUSkD+sYkKgW6KpBkLPEtkv1zadhOTXn9m4ZTV7JuZaRtteCkh1/Pgmi1IZnUFyTZMfgpIsQt8UD7eaaAbaTA09GtTqfOjBg0iqAPOgCUNtrxRELVXEaBdHINeVCd1zGnTwcrcPk8ZaNQkwAR1yOa6G+OHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198051; c=relaxed/simple;
	bh=+o22E5RcH+sglBGMSqX6O933OVxTfE119DlmXip/o50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKhFHx8VP9fT/Z1gC0sqSml/LXpksvURhmupQKCb6OYTq95wlq09h4iMfL9MhMOmoisLWRWFznInd/Tmq2rJ3BoRokWNkw79Ax7DLOefynp0pT87Lb5w+fIcLyqv+prL9Hzcxa9XQ90CZ7zSZ2PdejCCovCJ0VdYf2WP9t0BYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Stl/b+pz; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744198037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dYki+8hZ1VIAcnV82v/klkogc/Iawb6YfIpaQ5C6q3k=;
	b=Stl/b+pz4nWZWrB4ZorspouS2L3UN47q7kcQ8QaoOa3j2K2lS490bmEngmKNLDPqzcrOgU
	pCDnginI67mJb8d5ZbCvcneL6MJ8bFqDDaUo2QDuMjezS9ogpOsd49vQ9YTqYdlXdAxxfx
	C7un6NwtR/Y79Tq7Hpe9f0DR00t9uQ8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: kuba@kernel.org,
	edumazet@google.com
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antony Antony <antony.antony@secunet.com>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] tcp: add a new TW_PAWS drop reason
Date: Wed,  9 Apr 2025 19:26:03 +0800
Message-ID: <20250409112614.16153-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Devices in the networking path, such as firewalls, NATs, or routers, which
can perform SNAT or DNAT, use addresses from their own limited address
pools to masquerade the source address during forwarding, causing PAWS
verification to fail more easily under TW status.

Currently, packet loss statistics for PAWS can only be viewed through MIB,
which is a global metric and cannot be precisely obtained through tracing
to get the specific 4-tuple of the dropped packet. In the past, we had to
use kprobe ret to retrieve relevant skb information from
tcp_timewait_state_process().

We add a drop_reason pointer and a new counter.

---
v3 -> v4:
1. Update commit message and make it more concise.
2. Integrated Reviewed-by tag from v3.
https://lore.kernel.org/netdev/20250407140001.13886-1-jiayuan.chen@linux.dev/T/#t

v2 -> v3: Use new SNMP counter and drop reason suggested by Eric.
https://lore.kernel.org/netdev/5cdc1bdd9caee92a6ae932638a862fd5c67630e8@linux.dev/T/#t

I didn't provide a packetdrill script.
I struggled for a long time to get packetdrill to fix the client port, but
ultimately failed to do so...

Instead, I wrote my own program to trigger PAWS, which can be found at
https://github.com/mrpre/nettrigger/tree/main
'''
//assume nginx running on 172.31.75.114:9999, current host is 172.31.75.115
iptables -t filter -I OUTPUT -p tcp --sport 12345 --tcp-flags RST RST -j DROP
./nettrigger -i eth0 -s 172.31.75.115:12345 -d 172.31.75.114:9999 -action paws
'''


Jiayuan Chen (2):
  tcp: add TCP_RFC7323_TW_PAWS drop reason
  tcp: add LINUX_MIB_PAWS_TW_REJECTED counter

 Documentation/networking/net_cachelines/snmp.rst | 2 ++
 include/net/dropreason-core.h                    | 7 +++++++
 include/net/tcp.h                                | 3 ++-
 include/uapi/linux/snmp.h                        | 1 +
 net/ipv4/proc.c                                  | 1 +
 net/ipv4/tcp_ipv4.c                              | 3 ++-
 net/ipv4/tcp_minisocks.c                         | 9 ++++++---
 net/ipv6/tcp_ipv6.c                              | 3 ++-
 8 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.47.1


