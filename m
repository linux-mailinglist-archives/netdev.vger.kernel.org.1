Return-Path: <netdev+bounces-207447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E3B0750C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61729504DB7
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535B2F3C3E;
	Wed, 16 Jul 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeiFbi9b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891E2E36F4
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666803; cv=none; b=J7peDL2XdAWzxswgEHTjKfz5hO57jx3fBDtP96G/fi3jUuD9pb2XnyH1PzmIcrVqAy8Aej423yeblN4TV80QLfODFlBa01J+TPLepa6mtvGAV4uzrcLHtxgvgmubBsrOqb780k4kbO1tyQK/0DaJq7e6K+x17lM/DYgyaw8RaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666803; c=relaxed/simple;
	bh=BruD9tYhNwaS4DlutQi0vPMuIfgCOS9cBm0jE9Ja2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtMEl1vHLKWM5XBhZGQhFv5ZL4ennHnplcLr9frfe1AX45Eb/RBSHPBXj9OCb3rtYSaWhtovWE+K1kGkCxJMBS/4Jg9Fel528RnsRvBmCqUkza71y+BYN2OyOn15B76wQWfJ8nobI/zqtEXL9LNpdL+CBWZgK61FjR3vBufufBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeiFbi9b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752666799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x3dqR61avblo1D6TtvCNGWnhVtqUAM9K+rgyOPMwpQc=;
	b=ZeiFbi9bNZTOmqZdCUgaxb7NmFWE7LJM/an8kIKSXECpkmz3qdUToG9ZJJcYt+iHZE1EBo
	w0TJBDNyKXcrCa2+BK0cXbfxWGge24C8NiQ63LHF8YDAmdOaklcdheEkl9AGjA5W8NyBhk
	0eNwNG12WjhwyvJ3IHX25RTGUdM1F6s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-Ty0HzaaxMNuuY2zy9-Eitw-1; Wed,
 16 Jul 2025 07:53:15 -0400
X-MC-Unique: Ty0HzaaxMNuuY2zy9-Eitw-1
X-Mimecast-MFC-AGG-ID: Ty0HzaaxMNuuY2zy9-Eitw_1752666794
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5947195608D;
	Wed, 16 Jul 2025 11:53:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF18C195E772;
	Wed, 16 Jul 2025 11:53:10 +0000 (UTC)
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
Subject: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Date: Wed, 16 Jul 2025 12:52:59 +0100
Message-ID: <20250716115307.3572606-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Here are some fixes for rxrpc:

 (1) Fix the calling of IP routing code with IRQs disabled.

 (2) Fix a recvmsg/recvmsg race when the first completes a call.

 (3) Fix a race between notification, recvmsg and sendmsg releasing a call.

 (4) Fix abort of abort.

 (5) Fix call-level aborts that should be connection-level aborts.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

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


