Return-Path: <netdev+bounces-207752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9BEB08739
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48279167E56
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8B255F57;
	Thu, 17 Jul 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMU4cj4y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762E1DE4F6
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738251; cv=none; b=J5Px9wFFnQwWiQnWPNsdGZo47iIAWZktUxBKYffXlsHYsDaNV2Ia9IydaaWwLKmpifxVSlotqnmWxot+aTL9RRh8RvudDKaIla6VQ0lRQpOhcbEhrq6PRuPKBuUXbUduMWkN9AY+CZGn67b8XPQGp1+IALj0segV43BopVao9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738251; c=relaxed/simple;
	bh=ZM5tD7+0eFKJmyE0cmz84E6oU6+wMlx4Zku9qVJa29U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfsSb2cJ1iOr75RxrQMpW7tCC8apylBqPMjFAHnJ0kBQdAJhO4GpzjlbKqTbjwJQDAGDyve+mw24KtlZuE0gMEBcs23w+OxCwsN8bvjDxqATI45s+b09wVD835WSd5GKBD4AwWf7e2svOUeZdpIYfTMQxcRfllH7KkQ3vGNIIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMU4cj4y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752738249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5JHOkbClq+KJbfrHcBtMiIH4aYWxo1yewDYQHM+bbaM=;
	b=fMU4cj4yxuhMwvMw0mb4cKuhun1axaZrLV4D8Uu8hcZ8qMDZt5xsD//chMCqcYL8xHK11X
	FGmCYQpIOItkb8X5dZxcZy/glE/lBiK68Uigwbc/U3fyY8xIMwVj/S5MneQ5eTeM9jilfB
	C/1EQyisG+oHczr358grPdeamtMfZ4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-NUiLPwbYPkW-v0qESwr28A-1; Thu,
 17 Jul 2025 03:44:05 -0400
X-MC-Unique: NUiLPwbYPkW-v0qESwr28A-1
X-Mimecast-MFC-AGG-ID: NUiLPwbYPkW-v0qESwr28A_1752738244
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91C7D1800282;
	Thu, 17 Jul 2025 07:44:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72E3F18016F9;
	Thu, 17 Jul 2025 07:44:00 +0000 (UTC)
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
Subject: [PATCH net v2 0/5] rxrpc: Miscellaneous fixes
Date: Thu, 17 Jul 2025 08:43:40 +0100
Message-ID: <20250717074350.3767366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Here are some fixes for rxrpc:

 (1) Fix the calling of IP routing code with IRQs disabled.

 (2) Fix a recvmsg/recvmsg race when the first completes a call.

 (3) Fix a race between notification, recvmsg and sendmsg releasing a call.

 (4) Fix abort of abort.

 (5) Fix call-level aborts that should be connection-level aborts.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #2)
 - Moved a trace note from patch 5 to patch 3 where it is used.

David Howells (5):
  rxrpc: Fix irq-disabled in local_bh_enable()
  rxrpc: Fix recv-recv race of completed call
  rxrpc: Fix notification vs call-release vs recvmsg
  rxrpc: Fix transmission of an abort in response to an abort
  rxrpc: Fix to use conn aborts for conn-wide failures

 include/trace/events/rxrpc.h |  6 +++++-
 net/rxrpc/ar-internal.h      |  4 ++++
 net/rxrpc/call_accept.c      | 14 ++++++++------
 net/rxrpc/call_object.c      | 28 ++++++++++++----------------
 net/rxrpc/io_thread.c        | 14 ++++++++++++++
 net/rxrpc/output.c           | 22 +++++++++++++---------
 net/rxrpc/peer_object.c      |  6 ++----
 net/rxrpc/recvmsg.c          | 23 +++++++++++++++++++++--
 net/rxrpc/security.c         |  8 ++++----
 9 files changed, 83 insertions(+), 42 deletions(-)


