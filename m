Return-Path: <netdev+bounces-21590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C5763F58
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E62C281E1C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8CA11CAF;
	Wed, 26 Jul 2023 19:16:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15F4CE99
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:16:11 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6DB2719
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:16:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1604021CA2;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690398967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=an99c2Bly3oHsUbH8CBRgxdYchS7h7EFR57B8TXyjaw=;
	b=DJxcyp215Y9Rh8thegpyrdSh+SEytJ7pc48Zheo96FFYcII8LTEcYLyQcla/i72lYA/veH
	Gfdke6NT/r3EK9+d+pLCzQRCDrQPzD2d3Vb2Jk4FQLTzjiNR6VJsRpqIhAsCXUbH2n/KkD
	w5mZaq6QUP0ZWLCsyP03untiEouh4J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690398967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=an99c2Bly3oHsUbH8CBRgxdYchS7h7EFR57B8TXyjaw=;
	b=OeLjS6xDIBFlDLFGNbfpRk84bpqtnsuK7Fk15mRxzmPZqCNK0X9kMK6SLOfZPIoUrPHEFr
	efIsdaaX47iyx9Ag==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 283E52C145;
	Wed, 26 Jul 2023 19:16:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 1D1CC51CA331; Wed, 26 Jul 2023 21:16:06 +0200 (CEST)
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
Subject: [PATCH 2/6] net/tls: handle MSG_EOR for tls_device TX flow
Date: Wed, 26 Jul 2023 21:15:52 +0200
Message-Id: <20230726191556.41714-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230726191556.41714-1-hare@suse.de>
References: <20230726191556.41714-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tls_push_data() MSG_MORE, but bails out on MSG_EOR.
Seeing that MSG_EOR is basically the opposite of MSG_MORE
this patch adds handling MSG_EOR by treating it as the
absence of MSG_MORE.
Consequently we should return an error when both are set.

Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 2021fe557e50..5df18f696d7f 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -441,9 +441,13 @@ static int tls_push_data(struct sock *sk,
 	long timeo;
 
 	if (flags &
-	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SPLICE_PAGES))
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+	      MSG_SPLICE_PAGES | MSG_EOR))
 		return -EOPNOTSUPP;
 
+	if ((flags & (MSG_MORE | MSG_EOR)) == (MSG_MORE | MSG_EOR))
+		return -EINVAL;
+
 	if (unlikely(sk->sk_err))
 		return -sk->sk_err;
 
-- 
2.35.3


