Return-Path: <netdev+bounces-211248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA7B175E9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF847A7ECE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A5239E91;
	Thu, 31 Jul 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNKccbWq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817FD23644F
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984876; cv=none; b=csZxpeabZ2BQxX9HnxpYU6M3MDMLz7+B/7aGnrmDXMhKWG0UYMOoOdcnqMz9n9LqduF9qJ6G+R91zLtF4Jt6R+aWeW0Tpj7rPmq97S8MvW/ou1nmxY/2ah21RrSPy1JcWQphjJu0ecy/VXtiW4aLaZq0hh0ozOPuEaby/8zcwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984876; c=relaxed/simple;
	bh=Zwc0SPPcbghkacEJD90D95EyeI17XLPTAdfZUkhNCX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bf1JciRjrbhPi4o2ALKf3ay4s7HUfZywx2pEFyTCd7/29YOtJJ58FDuXzQRl15G+OMVPpVtB/2XNF276n1dTx/0ABNBkjYI8VClm7GVacxr3GqM3q0blpUetTAfzm7jfOb2GUccSZVwYmhKIcQaJn4+Gvs4mWWtMt82F9FLqjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNKccbWq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753984873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nyoDhXJsyJ+eWJFNkLxVXQYz79heny9XiWvBr8bapU4=;
	b=VNKccbWqhIMztjaguvsNpURITQn6f6MqHVgKcD4D20zFIMv6+6kV2jyyWvZm0MRXOMPkO5
	lBOCU+aOITPE2ElomnQsp41ACOPX1Ck4jDCIdSIj4e+HVWhGrpNdwtHNuWSOdjPNmJVq1L
	JWPqus64hGQ1m2oCYqbK/0AO9zUpKqw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-mAvch5gkO1mh3SLvpv5GGw-1; Thu,
 31 Jul 2025 14:01:07 -0400
X-MC-Unique: mAvch5gkO1mh3SLvpv5GGw-1
X-Mimecast-MFC-AGG-ID: mAvch5gkO1mh3SLvpv5GGw_1753984865
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64E93180045B;
	Thu, 31 Jul 2025 18:01:04 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A085230001B3;
	Thu, 31 Jul 2025 18:00:59 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@hammerspace.com,
	anna.schumaker@oracle.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	hare@suse.de,
	horms@kernel.org,
	kbusch@kernel.org
Subject: [PATCH v2 0/4] address tls_alert_recv usage by NFS and NvME
Date: Thu, 31 Jul 2025 14:00:54 -0400
Message-Id: <20250731180058.4669-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

v2: patch#3 changed to remove unused recv_cbuf member of nvmet_tcp_cmd

This is a multi-component patch series: NFS client, NFS server,
NvME (target), net.

tls_alert_recv() has been originally written to retrieve TLS alert
payload out of the msg iterator's kvec buffer. Yet, the callers of
tls_alert_recv() have not been careful enough to make sure that
msg has always been initialized with a kvec-backed iterator (ie.,
some times bvec was used). Furthermore, callers didn't account
for the fact that the msg iterator's kvec is advanced by sock_recvmsg
upon filling up the provided space by the copy. All that lead to
the ability to construct a malicious payload that would trigger
badness in tls_alert_recv().

This patch series attempts to address it in a couple of steps.
First, there are patches for each of the current consumers (NFS
server, NFS client, NvME target) of tls_alert_recv to address
an immediate problem which I think should be backported.

Note, patch#3 is NvME patch that had no testing. Compile only patch.

Second, the last patch builds on top of the fixes but changes
tls_alert_recv to force the callers to provide the kvec directly
in hopes that any future users of tls_alert_recv would be more
congnizant of providing location to the actual TLS alert payload.

Again note that nvme changes in patch#4 are compile only.

Olga Kornievskaia (4):
  sunrpc: fix handling of server side tls alerts
  sunrpc: fix client side handling of tls alerts
  nvmet-tcp: fix handling of tls alerts
  net/handshake: change tls_alert_recv to receive a kvec

Olga Kornievskaia (4):
  sunrpc: fix handling of server side tls alerts
  sunrpc: fix client side handling of tls alerts
  nvmet-tcp: fix handling of tls alerts
  net/handshake: change tls_alert_recv to receive a kvec

 drivers/nvme/target/tcp.c | 38 ++++++++++++++------------
 include/net/handshake.h   |  2 +-
 net/handshake/alert.c     |  6 ++---
 net/sunrpc/svcsock.c      | 56 ++++++++++++++++++++++++++++-----------
 net/sunrpc/xprtsock.c     | 51 ++++++++++++++++++++++++-----------
 5 files changed, 101 insertions(+), 52 deletions(-)

-- 
2.47.1


