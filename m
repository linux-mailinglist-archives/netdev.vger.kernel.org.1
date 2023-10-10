Return-Path: <netdev+bounces-39612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DA57C01D0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1132813CB
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE742FE15;
	Tue, 10 Oct 2023 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZVQ3BBOj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xQs5UgZg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C72FE07
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:39:36 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3656097
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:39:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7B9D21898;
	Tue, 10 Oct 2023 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1696955973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SgqwT3S5wOEbVoQaIVfxk6KPJPmK5HYiWFfLOamEpsg=;
	b=ZVQ3BBOj1ONM4HEvsHWdV4IO7jDWhwMFuP5yV03N9DOn2BsM82mn3oms12QiyJpQ57X6xJ
	65PTFOGaDBFLHjt+iv1Q/5zBF6wsTiYuILg/ObvnniZCLbh/YhnaiLhQrMR+tzE4SUoVOY
	0y9BV4onxmn69Q7v3eoiT5tlY4xL1aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1696955973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SgqwT3S5wOEbVoQaIVfxk6KPJPmK5HYiWFfLOamEpsg=;
	b=xQs5UgZg4PS5fRZaiIrlG6xaTn/63d6klzlyrAA0mste40iymlokiMIQq+Wa3uo/bz/o7O
	UPntzxkMSW/EMOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2BE41348E;
	Tue, 10 Oct 2023 16:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JVdsM0V+JWWZOgAAMHmgww
	(envelope-from <jwiesner@suse.de>); Tue, 10 Oct 2023 16:39:33 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 144D1767B1; Tue, 10 Oct 2023 18:39:33 +0200 (CEST)
Date: Tue, 10 Oct 2023 18:39:33 +0200
From: Jiri Wiesner <jwiesner@suse.de>
To: netdev@vger.kernel.org
Cc: Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] bonding: Return pointer to data after pull on skb
Message-ID: <20231010163933.GA534@incl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since 429e3d123d9a ("bonding: Fix extraction of ports from the packet
headers"), header offsets used to compute a hash in bond_xmit_hash() are
relative to skb->data and not skb->head. If the tail of the header buffer
of an skb really needs to be advanced and the operation is successful, the
pointer to the data must be returned (and not a pointer to the head of the
buffer).

Fixes: 429e3d123d9a ("bonding: Fix extraction of ports from the packet headers")
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ed7212e61c54..51d47eda1c87 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4023,7 +4023,7 @@ static inline const void *bond_pull_data(struct sk_buff *skb,
 	if (likely(n <= hlen))
 		return data;
 	else if (skb && likely(pskb_may_pull(skb, n)))
-		return skb->head;
+		return skb->data;
 
 	return NULL;
 }
-- 
2.35.3


-- 
Jiri Wiesner
SUSE Labs

