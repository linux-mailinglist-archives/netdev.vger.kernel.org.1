Return-Path: <netdev+bounces-18249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FBD755FDA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0012814AE
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DEDA945;
	Mon, 17 Jul 2023 09:52:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36924A927
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:52:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA437A4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689587569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MR1j/VvelwrpB5IPicBmY+wKbGijazz49VyCLTDIVso=;
	b=dIQmh2Wx867n2mlxEBYvxaxdMqu0u8Qbq9e+LICv8udLqgPRqivVgNMz9JuSifx697FRGH
	qJi3YaHP1XFYPJaTm/vmEdzBtoS5bb1JaSUc0BrfDaVEdohQRBZBKaz91eC0rmk3PT9S2A
	faqE0J8C6+buDjsfp+q/lk0RMUfSdYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-nFf5qjLaPyaISjvXP5U-6g-1; Mon, 17 Jul 2023 05:52:40 -0400
X-MC-Unique: nFf5qjLaPyaISjvXP5U-6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DDCB8564EF;
	Mon, 17 Jul 2023 09:52:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0CCACC2C862;
	Mon, 17 Jul 2023 09:52:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next] udp: introduce and use indirect call wrapper for data ready()
Date: Mon, 17 Jul 2023 11:52:29 +0200
Message-ID: <8834aadd89c1ebcbad32f591ea4d29c9f2684497.1689587539.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In most cases UDP sockets use the default data ready callback.
This patch Introduces and uses a specific indirect call wrapper for
such callback to avoid an indirect call in fastpath.

The above gives small but measurable performance gain under UDP flood.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that this helper could be used for TCP, too. I did not send such
patch right away because in my tests the perf delta there is below the
noise level even in RR scenarios and the patch would be a little more
invasive - there are more sk_data_ready() invocation places.
---
 include/net/sock.h | 4 ++++
 net/ipv4/udp.c     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2eb916d1ff64..1b26dbecdcca 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2947,6 +2947,10 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
 }
 
 void sock_def_readable(struct sock *sk);
+static inline void sk_data_ready(struct sock *sk)
+{
+	INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
+}
 
 int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 42a96b3547c9..5aec1854b711 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1553,7 +1553,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	spin_unlock(&list->lock);
 
 	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk);
+		sk_data_ready(sk);
 
 	busylock_release(busy);
 	return 0;
-- 
2.41.0


