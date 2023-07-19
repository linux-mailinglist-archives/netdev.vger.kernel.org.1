Return-Path: <netdev+bounces-18996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E07759474
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2641228181C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0393E13AD4;
	Wed, 19 Jul 2023 11:40:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAF14274
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:40:04 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0481715
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:39:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C9E601FEB5;
	Wed, 19 Jul 2023 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689766720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jQDZxCtHSygcvnzTXExpJm0oBvfu3bBtgPr9fdylL0=;
	b=Hixi54fTFYDI5IGeUDrhhBpbN0GJ9BPFZOWjOTQpqCfe2mlWvb6ZfLF3qwiSXTo0y6hIVI
	8H6zq3sy0NdumK+u/WzVOc6+Ul03QqsGg01Pr3524J89OEioBacdu7M8sIBl5IliQw3OgD
	6H1FlXmwZSrBQ5zgufcg3kUUUO5kA5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689766720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jQDZxCtHSygcvnzTXExpJm0oBvfu3bBtgPr9fdylL0=;
	b=H8hXiQuQ2thzr9XptApzatESOQSaUEoTX0pMeBaSzwi0q5eu6FnWFFqhAzt928m3Fl6euM
	Cpx8Jhx4zWnK5XAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B275A2C149;
	Wed, 19 Jul 2023 11:38:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A6EF251C9ED3; Wed, 19 Jul 2023 13:38:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] net/tls: Use tcp_read_sock() instead of ops->read_sock()
Date: Wed, 19 Jul 2023 13:38:34 +0200
Message-Id: <20230719113836.68859-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719113836.68859-1-hare@suse.de>
References: <20230719113836.68859-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TLS resets the protocol operations, so the read_sock() callback might
be changed, too.
In this case using sock->ops->readsock() in tls_strp_read_copyin() will
enter an infinite recursion if the read_sock() callback is calling
tls_rx_rec_wait() which will call into sock->ops->readsock() via
tls_strp_read_copyin().
But as tls_strp_read_copyin() is supposed to produce data from the
consumed socket and that socket is always a TCP socket we can call
tcp_read_sock() directly without having to deal with callbacks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_strp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index f37f4a0fcd3c..ca1e0e198ceb 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -369,7 +369,6 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
 {
-	struct socket *sock = strp->sk->sk_socket;
 	read_descriptor_t desc;
 
 	desc.arg.data = strp;
@@ -377,7 +376,7 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	sock->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
+	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
 
 	return desc.error;
 }
-- 
2.35.3


