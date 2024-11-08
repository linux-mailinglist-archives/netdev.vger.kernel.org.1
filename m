Return-Path: <netdev+bounces-143263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB89C1BC6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8893B24B52
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB831E47AB;
	Fri,  8 Nov 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjvyN4G9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012071E3DD8
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063544; cv=none; b=LC2aDu228BoSoCbPAskIL5+AI3le2KPMTva1saPw9JWJKZCp3EltK0j6jEMkDR0ymUDsmXxlcIBmjsh3HF1v5VpGwTfBA9PKvhvQHfdhVEexsT5xrCQ0EYOzS1NuC7Qb2EKqmHtasAI37N5j2XM0CxQQZG5ELQ0Mr5B338uWerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063544; c=relaxed/simple;
	bh=HnlIv0shPYlrmFHUiRovfXGGOpfl3wKy7+j8e+K5FkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVPVrtx0sLb266/ztG1CknmXtSQ/UNZrj7Y8CR/GAmcwP2l4vcg0IXLT3sKshZ/oX23h4+I0WnpZb/9FR/iIPleuYrWrYgbeUWXvtK3F5bNIjd8+69YTnDN0bnaJlIR9NXxyaDXHgI+4WpvcXGPT7e0JfpTWvB1567HhHX7nbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjvyN4G9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731063542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iR/x+dH77F1MdZ4GlNiB8vuIlGOSlBv4jBLCMBeFDpU=;
	b=YjvyN4G9Al0j89BFafS6hjE2DHfy6oAjBhI5Y+LEcELU0nfbqQOhepq4bc16mpi4vflZZ5
	NSYqwd3K8B7sZQWD6evYuKBAYt+8P4W/RphZzbirJOJciZL+W5+7Wa2wISk8MQO8eokgL/
	RZ5YutyBK4DEezDYszf8AL7CcHJNvAE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-8HrvlfFJOmyBmB4juogIgw-1; Fri,
 08 Nov 2024 05:58:56 -0500
X-MC-Unique: 8HrvlfFJOmyBmB4juogIgw-1
X-Mimecast-MFC-AGG-ID: 8HrvlfFJOmyBmB4juogIgw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DFD21944DF3;
	Fri,  8 Nov 2024 10:58:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.90])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B9641956054;
	Fri,  8 Nov 2024 10:58:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH net 2/2] mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
Date: Fri,  8 Nov 2024 11:58:17 +0100
Message-ID: <02374660836e1b52afc91966b7535c8c5f7bafb0.1731060874.git.pabeni@redhat.com>
In-Reply-To: <cover.1731060874.git.pabeni@redhat.com>
References: <cover.1731060874.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Additional active subflows - i.e. created by the in kernel path
manager - are included into the subflow list before starting the
3whs.

A racing recvmsg() spooling data received on an already established
subflow would unconditionally call tcp_cleanup_rbuf() on all the
current subflows, potentially hitting a divide by zero error on
the newly created ones.

Explicitly check that the subflow is in a suitable state before
invoking tcp_cleanup_rbuf().

Fixes: c76c6956566f ("mptcp: call tcp_cleanup_rbuf on subflows")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 95a5a3da3944..48d480982b78 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2082,7 +2082,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 				slow = lock_sock_fast(ssk);
 				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
 				WRITE_ONCE(tcp_sk(ssk)->window_clamp, window_clamp);
-				tcp_cleanup_rbuf(ssk, 1);
+				if (tcp_can_send_ack(ssk))
+					tcp_cleanup_rbuf(ssk, 1);
 				unlock_sock_fast(ssk, slow);
 			}
 		}
-- 
2.45.2


