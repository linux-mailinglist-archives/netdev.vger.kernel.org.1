Return-Path: <netdev+bounces-292542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGGZM2iyF2p+NggAu9opvQ
	(envelope-from <netdev+bounces-292542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:11:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E105EC1D3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 490BA3009F2E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28D26ED5D;
	Thu, 28 May 2026 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dejd0qhb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6418C933;
	Thu, 28 May 2026 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937888; cv=none; b=gcs/S+fsi5XI83nB2Tr2UpbE1z0fYG6Fq9RFGT2VUY6fsDI3XYLtAgHEv20ThBql2FWL1bu57exBbmAmKdx3XDs2Q/PMfFRqnwwSxbxTQ9/ojFn7Mdexa0lJSqIS5n9faP/B4t7HbFrmWuJvRdHFmUbsoiHm+y3oVttwpKo97ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937888; c=relaxed/simple;
	bh=1y02pKwUZldBzTkxXv+DoJFfjLlZ+TQQncVV4iSp8BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ae4kSzPunAG9ZHInPFvAHjye3dlZL3PANAfQwddU3vr+sWFMjCINYU+nX/ZWQLB728ZVbs+t8k7QRJqkT/W5leSy+bEkbusl9GoOSSKRdsU9w39gdOA+mYSEaV7VaDNztGNIeYZ7vmcVPtVs9KFhYEWF+uGlFeEZ1pDeQ6gCWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dejd0qhb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65E11F000E9;
	Thu, 28 May 2026 03:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937886;
	bh=2LJir5NYveamozdEogI+01xu/ZbFXYpoE1MTH8bCSu8=;
	h=From:To:Cc:Subject:Date;
	b=Dejd0qhbEWMn6LN2R0CyuK49/u5lyOIhBYROqn3lwGDQ6OU9B48kD+Ow3PGcbdQna
	 kha0836A0cQNMi3SHjvBSLHdoUUZGPKKD+1rNli9fhE01MZCh2lFgzikkyITxKAj4F
	 xAsUcVdNkkfASv1Z54YGvrHVXlKilinraqZdhHeh8ZFonFNzRPNJZnoI1fleN3nZpX
	 PMbM6Xjb+6iA1t/hJ+7nWTgvPx2XvsT8KFZpCED4/FIPoz/TtDvbyejEHjBi+cCpil
	 EuMQzUEV737HxzZLxEj1GFT/cjGtqkjPj5CguYmHYPf1ISkj7e9LiM/gnHmv5OxnxW
	 YmVdLlrSMJWxQ==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 00/11] NVMe over MPTCP
Date: Thu, 28 May 2026 11:10:34 +0800
Message-ID: <cover.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292542-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:email,purestorage.com:email]
X-Rspamd-Queue-Id: D8E105EC1D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geliang Tang <tanggeliang@kylinos.cn>

This series (previously named "MPTCP support to NVMe over TCP") had three
RFC versions sent to Hannes in May 2025, with subsequent revisions based on
his input. Following that, I initiated the process of upstreaming the
dependent "mptcp: implement .read_sock" series, which was merged into the
Linux kernel in February 2026.

After several rounds of iteration on the MPTCP mailing list, this set
addresses all the reviewer comments (including Sashiko's) and fixes the
identified issues.

This topic was presented as a discussion item at LSF/MM/BPF 2026.
During the "NVMe over MPTCP" [1] discussion at the conference, it was
concluded that MPTCP should be treated as a new transport type, rather than
a TCP variant. A request will be submitted to the NVMe working group to
officially allocate a transport value for MPTCP.

This series runs without any user space changes (libnvme, nvme-cli).
Later, MPTCP KTLS support will be added, and a follow-up series will be
sent to enable TLS for NVMe over MPTCP.

Based on NVMe Multipath and Block Multiqueue, each TCP queue is converted
into one MPTCP queue. This is achieved by abstracting six socket helpers
(set_nodelay, set_reuseaddr, no_linger, etc.) into per-transport
structures. Inside each MPTCP queue, multiple subflows using different
IP addresses aggregate multi-NIC bandwidth and provide fail-over
resilience.

Patch 10 demonstrates that with a single NVMe multipath configuration and
four network interfaces, MPTCP achieves four times the bandwidth of TCP.
Patch 11 demonstrates that with four NVMe multipath paths, using the
round-robin I/O policy and a lossy four-interface environment, MPTCP
still achieves four times the bandwidth of TCP.

[1]
https://lore.kernel.org/linux-nvme/a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org/

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Geliang Tang (11):
  nvmet-tcp: define accept tcp_proto struct
  nvmet-tcp: implement accept mptcp proto
  nvmet-tcp: define listen socket ops
  nvmet-tcp: register target mptcp transport
  nvmet-tcp: implement mptcp listen socket ops
  nvme-fabrics: compare transport in ip_options_match
  nvme-tcp: define host tcp_proto struct
  nvme-tcp: register host mptcp transport
  nvme-tcp: implement host mptcp proto
  selftests: mptcp: add nvme over mptcp test
  selftests: mptcp: nvme: add iopolicy tests

 drivers/nvme/host/fabrics.c                   |   1 +
 drivers/nvme/host/tcp.c                       | 101 ++++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     | 128 +++++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  31 ++
 net/mptcp/sockopt.c                           | 149 +++++++
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 397 ++++++++++++++++++
 11 files changed, 813 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.53.0


