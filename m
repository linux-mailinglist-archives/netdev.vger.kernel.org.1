Return-Path: <netdev+bounces-18615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8E2757FCF
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA091C20D02
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB93D2F6;
	Tue, 18 Jul 2023 14:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E0C2F2
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:41:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75042EC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689691281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CCg5WDaXzv03l28o1RN2K36+Jpm9hzngTCK2Y9mPiyQ=;
	b=EC3gQ0BnPR2M54ZxizjSJklCa2YSo8KXtWeGE+5PBZwgFje6mhU3b6oDRomXT0SZK66xEE
	iWOC1Q0qZlUL9lQDrko9AV614IeGsQGIaOHNJs77ahnGi4Ejv/SZh/mmNpHZUNT616tZQn
	OcNVw91Qe6j/rd8D6l+DAwG7acE71OI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-FqzJvgWKNvSOxwt5HZkmBg-1; Tue, 18 Jul 2023 10:41:15 -0400
X-MC-Unique: FqzJvgWKNvSOxwt5HZkmBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D788891F27;
	Tue, 18 Jul 2023 14:38:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 06D5240C6F4C;
	Tue, 18 Jul 2023 14:38:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 net-next] udp: use indirect call wrapper for data ready()
Date: Tue, 18 Jul 2023 16:38:09 +0200
Message-ID: <d47d53e6f8ee7a11228ca2f025d6243cc04b77f3.1689691004.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In most cases UDP sockets use the default data ready callback.
Leverage the indirect call wrapper for such callback to avoid an
indirect call in fastpath.

The above gives small but measurable performance gain under UDP flood.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - do not introduce the specific helper (Willem)
---
 net/ipv4/udp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 42a96b3547c9..8c3ebd95f5b9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1553,7 +1553,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	spin_unlock(&list->lock);
 
 	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk);
+		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
 
 	busylock_release(busy);
 	return 0;
-- 
2.41.0


