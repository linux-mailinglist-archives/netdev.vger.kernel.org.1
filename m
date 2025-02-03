Return-Path: <netdev+bounces-162052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B3A257BE
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 12:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08737188183E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A89202C4F;
	Mon,  3 Feb 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E50cCWi9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11210202C30
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580602; cv=none; b=GrZhMJh75VmrLuNnAu7DIUiLJ8MfHrPpP7HV3V+reUYdzCQmZd6c94biX/oFFFOGEz3hoBwJ4jdvIJESgd+E/6Q2OhPx+CpxxV5eCWpHCm9oQWvg1WfCC3WWPLnoFyNU2z9zd74wHWI43jhfaF3Vrz5GCDwM+No2kdQZudaIBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580602; c=relaxed/simple;
	bh=xaAAHpyaS+ihWCjpvL1g5q1b2wxX+3o/PQXqetgkm/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drev63JgklYzou2N8XTe315TnEfLyTVciSvS8YsZjTB3iJZVH42PdIu3qV/nY/3Fx1MroqlirP4moY9Q2mrOsgHiTEbLkSOeFCDGkifWxbayETTj0YRrmXKZ8GFeeLC8SntoKQCzUJW+l6hwnoUjwxrsyEWmfsDDEhymfCD5PZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E50cCWi9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738580599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WiB2eGPnUWekIgORYbul68z2a+sk8HOanBsmp7E6tqU=;
	b=E50cCWi9DWsQWS3G4q6zh35FuR8FmfFDXEtPYuBLL/B6G9BZAfL1UY/yz35/3ciy2M0hQI
	RypgyGZphWbAIM2ZpykTZy8rK4mArQku8g7M5h+ABvJ5NH07Q2/EfUPW+UDsX8Bh7Eulbc
	7uQ6p8rYEn0HvFMW/xUMSdAlzDoDZGQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-S-VfnZG0NW6UvWz9FE0fzw-1; Mon,
 03 Feb 2025 06:03:16 -0500
X-MC-Unique: S-VfnZG0NW6UvWz9FE0fzw-1
X-Mimecast-MFC-AGG-ID: S-VfnZG0NW6UvWz9FE0fzw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46A3818009CD;
	Mon,  3 Feb 2025 11:03:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B2AF1956094;
	Mon,  3 Feb 2025 11:03:12 +0000 (UTC)
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
Subject: [PATCH net 0/2] rxrpc: Miscellaneous fixes
Date: Mon,  3 Feb 2025 11:03:02 +0000
Message-ID: <20250203110307.7265-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Here some miscellaneous fixes for AF_RXRPC:

 (1) Fix the state of a call to not treat the challenge-response cycle as
     part of an incoming call's state set.  The problem is that it makes
     handling received of the final packet in the receive phase difficult
     as that wants to change the call state - but security negotiations may
     not yet be complete.

 (2) Fix the queuing of connections seeking attention from offloaded ops
     such as challenge/response.  The problem was that the attention link
     always seemed to be busy because it was never initialised from NULL.
     This further masked two further bugs, also fixed in the patch.

David

---
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (2):
  rxrpc: Fix call state set to not include the SERVER_SECURING state
  rxrpc: Fix the rxrpc_connection attend queue handling

 include/trace/events/rxrpc.h |  1 +
 net/rxrpc/ar-internal.h      |  2 +-
 net/rxrpc/call_object.c      |  6 ++----
 net/rxrpc/conn_event.c       | 21 +++++++++++----------
 net/rxrpc/conn_object.c      |  1 +
 net/rxrpc/input.c            |  4 ++--
 net/rxrpc/sendmsg.c          |  2 +-
 7 files changed, 19 insertions(+), 18 deletions(-)


