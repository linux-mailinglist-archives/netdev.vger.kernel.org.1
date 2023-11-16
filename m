Return-Path: <netdev+bounces-48328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEAF7EE121
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B40B20A59
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC4B30659;
	Thu, 16 Nov 2023 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9lc6bAD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C87CE
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=56qEDo8yIqTUJHP8P2HT8aLUWZCphDYXUxLI2O0HehM=;
	b=K9lc6bADjFiXNXCBvxcCVStrYgXw7znSELzjF7VRJrXDJzJj/zG8YPKKtIa7dC1OvN/9Df
	KN6H13L0uEwRGQWRt01FqxQWqStS6+aCArFfSO2sDRX+ZUL/sw0gryxUBBfqTry1bvqhFK
	lqVtiUPOH4oVx/iqQgyv/UBLcv22g18=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-Ddy73NA3Nwaye6z-spbp7g-1; Thu,
 16 Nov 2023 08:13:04 -0500
X-MC-Unique: Ddy73NA3Nwaye6z-spbp7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E3E51C05193;
	Thu, 16 Nov 2023 13:13:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 35F5F2166B27;
	Thu, 16 Nov 2023 13:13:02 +0000 (UTC)
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
Subject: [PATCH net 0/2] rxrpc: ACK handling fixes
Date: Thu, 16 Nov 2023 13:12:57 +0000
Message-ID: <20231116131259.103513-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Here are a couple of patches to fix ACK handling in AF_RXRPC:

 (1) Allow RTT determination to use an ACK of any type as the response from
     which to calculate RTT, provided ack.serial matches the serial number
     of the outgoing packet.

 (2) Defer the response to a PING ACK packet (or any ACK with the
     REQUEST_ACK flag set) until after we've parsed the packet so that we
     carry up to date information if the Tx or Rx rings are advanced.

David

---
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (2):
  rxrpc: Fix RTT determination to use any ACK as a source
  rxrpc: Defer the response to a PING ACK until we've parsed it

 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/input.c            | 61 +++++++++++++++++-------------------
 2 files changed, 30 insertions(+), 33 deletions(-)


