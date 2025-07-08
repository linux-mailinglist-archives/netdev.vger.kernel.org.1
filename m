Return-Path: <netdev+bounces-205142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9139AFD96A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF0C481376
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19402459C6;
	Tue,  8 Jul 2025 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUvRAMs5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95A24397A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009322; cv=none; b=rt3+4De5lgk1t1IeP/vczcyBObaWO1QzIRb1X0kyAWG6KqVPUotyU0EZMEcOF81bRWXaNLZYG+HnU5JB6INqw1AAqVqSEvtn9UrxhHxtTDUXOU0NLgv7yIaMAeBGhWwuKzCm3Keb2eYlN76+8auu9J1UOQfXGw57SBazB0W1E3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009322; c=relaxed/simple;
	bh=gcBBl2uhaU0yVxFwYI2lJl7+1TNo9HVTNuETgRLv13k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dg9swr5ObZ22XmMTxw5WfiUmF3h+Mkb4JLTCgNUDhj5rgVUfmANzQxQWuQgqUTS82rIHv/3LTuN0bT3EQRU9+vdUoJFjOmNANxojNIFeZoBDp0s6X9rwuijnUcOxKiHLJP/1DW2a9Vc4U7rlOH+NDBVeSS/d0E3bR1EhC6dIJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUvRAMs5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752009318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FWRdUp7oGKaEUhfD8Yy3WRtF8OKI+2g+/1sHlLVfExY=;
	b=WUvRAMs5RznLJ2HiIBSGygpkUyH4wVxrV++zJ+3HF+vdLLshxwj3OdHjgak5vLMVUfQbNE
	YZzq3jPlPkRQaR3EAgyvhEQU8ZZVxeLwKxwaE66C0qirhjrITi1I8zyxgIdDLccmqTW2LH
	ON0SkpMsRZEn47vRhSegUIhnA9wTz2o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-CCW479xSMRG90MzkFUsNug-1; Tue,
 08 Jul 2025 17:15:15 -0400
X-MC-Unique: CCW479xSMRG90MzkFUsNug-1
X-Mimecast-MFC-AGG-ID: CCW479xSMRG90MzkFUsNug_1752009314
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5331180028D;
	Tue,  8 Jul 2025 21:15:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFE2230001B1;
	Tue,  8 Jul 2025 21:15:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] rxrpc: Miscellaneous fixes
Date: Tue,  8 Jul 2025 22:15:02 +0100
Message-ID: <20250708211506.2699012-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Here are some miscellaneous fixes for rxrpc:

 (1) Fix assertion failure due to preallocation collision.

 (2) Fix oops due to prealloc backlog struct not yet having been allocated
     if no service calls have yet been preallocated.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #2)
 - Don't need to double-set RXRPC_CALL_RELEASED.
 - Drop applied frame size warning patch.
 - Add patch to fix oops.

David Howells (2):
  rxrpc: Fix bug due to prealloc collision
  rxrpc: Fix oops due to non-existence of prealloc backlog struct

 net/rxrpc/call_accept.c | 4 ++++
 1 file changed, 4 insertions(+)


