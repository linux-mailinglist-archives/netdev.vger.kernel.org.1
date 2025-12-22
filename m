Return-Path: <netdev+bounces-245760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F255ECD7297
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7636B3017397
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 20:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C03112AD;
	Mon, 22 Dec 2025 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Muw0EL01"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293DB158DA3
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437124; cv=none; b=fFlaeqSmcnX7BVtXRpCSxxKP7G4c6faJMO6tmJ58Hr4LWba5oHKbKIF/IwIDPmvm+Fbdyb0eHiXIQvfoX6WbI8HZEHaNffYBcUkfKrAXbgFzn+HaygllPCE7DZlPQUTy+uPyJ+yafJjvfqrE2ccseHZb3T+DSx9tOwXpvag2j2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437124; c=relaxed/simple;
	bh=ncvH5Hpm8J46z+VAdVGdOdWLupBpbeX4HPMUiIpAIzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpM9xT4l5Xqk2vOlzZKhIiyKMKScSM/xQCQ6gnokrhcH/qCrsNB5XE/fsen6HBfwG/Ll/goiYBhuvcLk1maBlJVs9UoS35TvbGZHfG9UU2uTEuJkrfkBYs3aSxPK+GrrgGEibvCij36BX49YOeP3+dmQKZp+2JgcRUQAMKD3AKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Muw0EL01; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766437122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZwL+E2R0PzQlczwK/thMjaqSiICmS0kZHErRYU2os/c=;
	b=Muw0EL01xeiWIqa3I7FKmIgsy8EdwHQt7FxMg6h2VhFqPEG90dMNu8EKAQmwkv4LChUgaL
	l1v0evjAv5P4xyBVMJJ1lCNfoowS+5/nqRyQWU65K0en37dFjvynsGGhn+OlLoi2XTnuZn
	MlaPI/FYP3X8a9rhUF4ccARnrVMyfLw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-_JOsb-7xPwOqAAsVbDHvbA-1; Mon,
 22 Dec 2025 15:58:38 -0500
X-MC-Unique: _JOsb-7xPwOqAAsVbDHvbA-1
X-Mimecast-MFC-AGG-ID: _JOsb-7xPwOqAAsVbDHvbA_1766437117
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC4C81800365;
	Mon, 22 Dec 2025 20:58:36 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.178])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 246C1180045B;
	Mon, 22 Dec 2025 20:58:32 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@linutronix.de,
	mingo@kernel.org,
	allison.henderson@oracle.com,
	matttbe@kernel.org,
	petrm@nvidia.com,
	bigeasy@linutronix.de
Subject: [RFC net 0/6] hsr: Implement more robust duplicate discard algorithm
Date: Mon, 22 Dec 2025 21:57:30 +0100
Message-ID: <cover.1766433800.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The PRP duplicate discard algorithm does not work reliably with certain
link faults. Especially with packet loss on one link, the duplicate
discard algorithm drops valid packets. For a more thorough description
see patch 5.

My suggestion is to replace the current, drop window-based algorithm
with a new one that tracks the received sequence numbers individually
(description again in patch 5). I am sending this as an RFC to gather
feedback mainly on two points:

1. Is the design generally acceptable? Of course, this change leads to
   higher memory usage and more work to do for each packet. But I argue
   that this is an acceptable trade-off to make for a more robust PRP
   behavior with faulty links. After all, PRP is to be used in
   environments where redundancy is needed and people are ready to
   maintain two duplicate networks to achieve it.
2. As the tests added in patch 6 show, HSR is subject to similar
   problems. I do not see a reason not to use a very similar algorithm
   for HSR as well (with a bitmap for each port). Any objections to
   doing that (in a later patch series)? This will make the trade-off
   with memory usage more pronounced, as the hsr_seq_block will grow by
   three more bitmaps, at least for each HSR node (of which we do not
   expect too many, as an HSR ring can not be infinitely large).

Most of the patches in this series are for the selftests. This is mainly
to demonstrate the problems with the current duplicate discard
algorithms, not so much about gathering feedback. Especially patch 1 and
2 are rather preparatory cleanups that do not have much to do with the
actual problems the new algorithm tries to solve.

A few points I know not yet addressed are:
- HSR duplicate discard (see above).
- The KUnit test is not updated for the new algorithm. I will work on
  that before actual patch submission.
- Merging the sequence number blocks when two entries in the node table
  are merged because they belong to the same node.

Thank you for your feedback already!

Signed-off-by: Felix Maurer <fmaurer@redhat.com>

---

Felix Maurer (6):
  selftests: hsr: Add ping test for PRP
  selftests: hsr: Check duplicates on HSR with VLAN
  selftests: hsr: Add tests for faulty links
  selftests: hsr: Add tests for more link faults with PRP
  hsr: Implement more robust duplicate discard for PRP
  selftests: hsr: Add more link fault tests for HSR

 net/hsr/hsr_framereg.c                        | 181 ++++++---
 net/hsr/hsr_framereg.h                        |  24 +-
 tools/testing/selftests/net/hsr/Makefile      |   2 +
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 198 +++------
 .../testing/selftests/net/hsr/link_faults.sh  | 376 ++++++++++++++++++
 tools/testing/selftests/net/hsr/prp_ping.sh   | 141 +++++++
 tools/testing/selftests/net/hsr/settings      |   2 +-
 7 files changed, 714 insertions(+), 210 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/link_faults.sh
 create mode 100755 tools/testing/selftests/net/hsr/prp_ping.sh

--
2.52.0


