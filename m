Return-Path: <netdev+bounces-207758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C45B08746
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BA87B7870
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406426E6E3;
	Thu, 17 Jul 2025 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjM951zE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010825A34F
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738283; cv=none; b=Xj6a0Tzbl6xJWoG8EHXaRAu04MoYtc/t9hYEeZLl9hSG9zo9TLA3q71JtOqunfhcFM4IJljb1KQMshfUGinlJtoFVlwUn9C12j0E+opuU4ndq+Oae1zOwNcgFAaFjS73X7PEHRaEfDWj1sv+v2GWk2dA7LMyOecELNUtqV/UJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738283; c=relaxed/simple;
	bh=VqkAKQ06zuDBxT1InigwkYWey8fIft48GLNxeyinELw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lysuSkNwcecPjQBWc5iRpBnud4jeGAw/E3ggCHZsAwzePb8wBNhyW/xmJR2r6j1D7cOf1iE9cBneRlo0nyCjI8kdVGTlD/s63z5n0cwXiStvyDr/5k+fbPdYCb0saPBQvKarL7zZd3+KHF+WPq/g/QXD6GIUlBQ4TXXB25iD2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjM951zE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752738280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAficW741eLddPXCBV20kWATJLxNZFQgJW7lDxysDlw=;
	b=KjM951zEtaGGsBgbYSAgOhN/YGthQjRyXQKxFgHmfBVOuaYNRz+l5Ks8mRhenurdYqzCln
	0++s6FD48/KSfz/I2lHHLvB1XO41GAwdYl3I1bNTBDnOwLEvgCrE2VIH5ZWMcfaWJgQMwd
	+auMhEAO9AasMrGAAeNjoozjrXM3Uro=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-RlCiFFR5PBmjpEHwfb0agA-1; Thu,
 17 Jul 2025 03:44:37 -0400
X-MC-Unique: RlCiFFR5PBmjpEHwfb0agA-1
X-Mimecast-MFC-AGG-ID: RlCiFFR5PBmjpEHwfb0agA_1752738276
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8468319560B4;
	Thu, 17 Jul 2025 07:44:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E074C18016F9;
	Thu, 17 Jul 2025 07:44:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	LePremierHomme <kwqcheii@proton.me>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 4/5] rxrpc: Fix transmission of an abort in response to an abort
Date: Thu, 17 Jul 2025 08:43:44 +0100
Message-ID: <20250717074350.3767366-5-dhowells@redhat.com>
In-Reply-To: <20250717074350.3767366-1-dhowells@redhat.com>
References: <20250717074350.3767366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Under some circumstances, such as when a server socket is closing, ABORT
packets will be generated in response to incoming packets.  Unfortunately,
this also may include generating aborts in response to incoming aborts -
which may cause a cycle.  It appears this may be made possible by giving
the client a multicast address.

Fix this such that rxrpc_reject_packet() will refuse to generate aborts in
response to aborts.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
cc: LePremierHomme <kwqcheii@proton.me>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@vger.kernel.org
---
 net/rxrpc/output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ef7b3096c95e..17c33b5cf7dd 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -814,6 +814,9 @@ void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb)
 	__be32 code;
 	int ret, ioc;
 
+	if (sp->hdr.type == RXRPC_PACKET_TYPE_ABORT)
+		return; /* Never abort an abort. */
+
 	rxrpc_see_skb(skb, rxrpc_skb_see_reject);
 
 	iov[0].iov_base = &whdr;


