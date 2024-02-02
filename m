Return-Path: <netdev+bounces-68562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF998472F7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339572892B0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362F145B04;
	Fri,  2 Feb 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2tDq2Gt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F3146903
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887174; cv=none; b=jOh1X7RHx0BIKjIcC2tlL8CnnlxK1BHp8bhXxy9vknWUasuoLkAVG4YKFdVRt8e4jIhvh0d5t3WRCCxTzGHZKp6JWL5RJdFdguZws6sDxo1u7+8tHoLtrCe/8s4dDxQxfyg4k+Ku6eIPER4cMgwP6vyZi/faqOgy8o2aum6KfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887174; c=relaxed/simple;
	bh=2Dbxz5xYJkxF7TJ2GJxLcMWWwSL1lpUM3YqACQhdtpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXG1n18QDBDRjzGRnEZCeGoTG226Gtk2SQniFhYVdBVEankv7Bd+MhbZ7Ue/7OvR5Yco7yzl+DHGTKZWLQdWcqXOFuPsGhvUWfb0kW3b1d4leHp2KPJBOiNUl1g41WubhnXNUrkoudXGHmcu/V6TkfsQ06ghhsLyOhaNy2vS42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2tDq2Gt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=odElO08YnTHudO0RnXkSSEFFNVCU35WEEp/Vx52s7/Y=;
	b=Q2tDq2Gtiex0vEfgVZHYP1vIgSRkmohOFE23AXmtM9kFYqPykBdHioIzOcFNk408jL5Q33
	VzTyFy5U+Eo2ncAo94giGnqRoS6TuQ/B672nJgU8dlESIAyAg/fGYLWCdr7aKHzxpLxN0s
	LBKT3XoKCYb5zE5kNItCdZN1lXKZ/r0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-QE6NjE1MPzSH2RcgRceGjQ-1; Fri,
 02 Feb 2024 10:19:27 -0500
X-MC-Unique: QE6NjE1MPzSH2RcgRceGjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67EC33C000BD;
	Fri,  2 Feb 2024 15:19:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1733A2026D66;
	Fri,  2 Feb 2024 15:19:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] rxrpc: Miscellaneous fixes
Date: Fri,  2 Feb 2024 15:19:12 +0000
Message-ID: <20240202151920.2760446-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Here some miscellaneous fixes for AF_RXRPC:

 (1) The zero serial number has a special meaning in an ACK packet serial
     reference, so skip it when assigning serial numbers to transmitted
     packets.

 (2) Don't set the reference serial number in a delayed ACK as the ACK
     cannot be used for RTT calculation.

 (3) Don't emit a DUP ACK response to a PING RESPONSE ACK coming back to a
     call that completed in the meantime.

 (4) Fix the counting of acks and nacks in ACK packet to better drive
     congestion management.  We want to know if there have been new
     acks/nacks since the last ACK packet, not that there are still
     acks/nacks.  This is more complicated as we have to save the old SACK
     table and compare it.

David

---
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (4):
  rxrpc: Fix generation of serial numbers to skip zero
  rxrpc: Fix delayed ACKs to not set the reference serial number
  rxrpc: Fix response to PING RESPONSE ACKs to a dead call
  rxrpc: Fix counting of new acks and nacks

 include/trace/events/rxrpc.h |   8 ++-
 net/rxrpc/ar-internal.h      |  37 ++++++++---
 net/rxrpc/call_event.c       |  12 ++--
 net/rxrpc/call_object.c      |   1 +
 net/rxrpc/conn_event.c       |  10 ++-
 net/rxrpc/input.c            | 115 +++++++++++++++++++++++++++++------
 net/rxrpc/output.c           |   8 +--
 net/rxrpc/proc.c             |   2 +-
 net/rxrpc/rxkad.c            |   4 +-
 9 files changed, 154 insertions(+), 43 deletions(-)


