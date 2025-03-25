Return-Path: <netdev+bounces-177461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1551CA70430
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C0E3B0007
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AEA25A359;
	Tue, 25 Mar 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WNGxc+AV"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3825B68F
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914062; cv=none; b=TjJJbX4Aa357vMy0o8+nVXEGUa/8vCwcDzB/Qm4f9sR8XMZabb7Bq0RM4t+J9b6qQPKidPhbiSbOSTNPORTAzqwIJEjcaEoKyQ/4cQlstABxXHhS3ENx8lXoy0tJCvMjebwi6VQCjHiO9IF8LHu9WQf+BO5rb9d7tOU8PTwdbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914062; c=relaxed/simple;
	bh=0MglWJtOl6peLrYtuC7iL0LvNigm0xF2wcTMnlxZRDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiSnPAdIhBcZDUl7EdQtvER9Mw6TOyc2Dc6D9HFjz0TPIbdh0RxA/PQ4/wARs5Cnl4YMzX3oE+pccXvUiJr7sWbh7ozBqbKphETGnBWv88XXy+53IuBQogty4FI/8hqE2PNGZpWip+g7Sm7s8ZO99K029anx+DkX0eB1lnWNhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WNGxc+AV; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742914048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jP5cdaNptS+bjJEdoMUR0c/sbj6TC+eUvsvJtB+r3Gk=;
	b=WNGxc+AVt/Bwh+5dLX7vXyXAT+lC6x7NjvinpRTXVy62E3A5QxUtwx2FOzg0DQVfau9/vT
	geYm/15dkIgQhmRBTaf489ceCZ1kq2nKIkgbqzG3kI3zAtY5H12smNJE+HryLHij54r2fg
	YgRTeigT2oOAIS4Tyd6Zro41k/lu0I0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	kuniyu@amazon.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH net-next v3 0/2] tcp: add a new TW_PAWS drop reason
Date: Tue, 25 Mar 2025 22:47:02 +0800
Message-ID: <20250325144704.14363-1-jiayuan.chen@linux.dev>
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


