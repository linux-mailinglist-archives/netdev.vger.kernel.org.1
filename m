Return-Path: <netdev+bounces-179658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A84A7E071
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394133B003E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A71C07DA;
	Mon,  7 Apr 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WvTc0BdE"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943C1B3940
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034434; cv=none; b=hYzXD2gCGcpGbQ/JemNyMftGbc8XZSeLe7QPzbL6hpQw/Hqrh5YkNnbvPx0n1vlxw1rEb7R0KmupRfyExp6fGcGgXBT9X0PwRmo5LNP81iQ1vxhggpFlHp66aESQMPc2Y7Dt0DhprKk2rOW2ljsCVhBccXCy+CK1SLQku/hE4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034434; c=relaxed/simple;
	bh=/6uprZLADz8IwUmk8EgesHcuIVKbMrDNRmW1j/TmpH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAMXmAXza0mn+fNet3W3QqZUndtMYZ0jFissKU5EF/TDmaET8y1GZogcfJUD1FOEb1DGwOcK05Q2fNfi8RMy6lNKoEcvcHKbl8ZiTc2UbQa4VdRVuLqRM3DClUHP/UAUhQNnqL2eIKYj3d/Xt/y3rnkzvkvN9mLVkExHJPGDMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WvTc0BdE; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744034419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZsTxmJA06+KEIIYttk/IyeF44+Ud1z93XW6H7Gh8cAs=;
	b=WvTc0BdEASl8hhzN38d6ZSUYZgiCq0AULq66M0bvOVUsjc8bXNrwu2s8EyARzv4cCvwKYo
	gwbywHfCTkNj5jPsFqjYYuoFTZrBGmYnLV+7+bb2CbOENYIAhLaUEjeo6WuDmbrgqqv/FZ
	pH3tVVYhns34Ylnw8dAUqPhKJODLfK0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH RESEND net-next v3 0/2] tcp: add a new TW_PAWS drop reason
Date: Mon,  7 Apr 2025 21:59:49 +0800
Message-ID: <20250407140001.13886-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

PAWS is a long-standing issue, especially when there are upstream network
devices, making it more prone to occur.

Currently, packet loss statistics for PAWS can only be viewed through MIB,
which is a global metric and cannot be precisely obtained through tracing
to get the specific 4-tuple of the dropped packet. In the past, we had to
use kprobe ret to retrieve relevant skb information from
tcp_timewait_state_process().

---
Re-sending the patch after merge window.

v2 -> v3: use new SNMP counter and drop reason suggested by Eric.
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


