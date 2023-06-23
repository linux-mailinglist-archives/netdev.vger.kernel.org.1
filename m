Return-Path: <netdev+bounces-13450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4440D73BA40
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C151C212B4
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98D230F5;
	Fri, 23 Jun 2023 14:34:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776B230EF
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:34:34 +0000 (UTC)
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 07:34:32 PDT
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57431724
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:34:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by smtp.missinglinkelectronics.com (Postfix) with ESMTP id 125B720526;
	Fri, 23 Jun 2023 16:28:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
	by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TF7Iwp3HGh8Z; Fri, 23 Jun 2023 16:27:59 +0200 (CEST)
Received: from 0.0.0.0 (p578c5bfe.dip0.t-ipconnect.de [87.140.91.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: joachim)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 7954B2034A;
	Fri, 23 Jun 2023 16:27:58 +0200 (CEST)
From: Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [PATCH] net: Fix special case of empty range in find_next_netdev_feature()
Date: Fri, 23 Jun 2023 16:26:16 +0200
Message-Id: <20230623142616.144923-1-joachim.foerster@missinglinkelectronics.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,RCVD_HELO_IP_MISMATCH,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Avoids running into an infinite loop when the lowest feature bit is
asserted.

In case of the "start" argument of find_next_netdev_feature() being 0, the
result will be the index of the highest asserted bit in its argument
"feature".  Given that for_each_netdev_feature() uses the return value of
find_next_netdev_feature() - which can of course be 0 (=> bit index 0) - as
the next "start" value, find_next_netdev_feature() has to deal with that,
in order to make sure that the loop of for_each_netdev_feature() ends when
having iterated over all asserted bits.

Fixes: 85db6352fc8a ("net: Fix features skip in for_each_netdev_feature()")
Cc: stable@vger.kernel.org
Signed-off-by: Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
---
 include/linux/netdev_features.h | 6 ++++++
 1 file changed, 6 insertions(+)

Of course one could also argue, that this should be fixed in
for_each_netdev_feature() itself. However that could complicate this macro.

On the other hand, I don't know whether there is a possibility to also
cover the special case as part of the masking and shifting in
find_next_netdev_feature().

Since the past commit 85db6352fc8a has introduced in 5.18, this fix here
could be queued for -stable >= 5.18. And should probably be queued for >=
6.1?

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7c2d77d75a88..30f5364c2e85 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -173,6 +173,12 @@ enum {
  */
 static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 {
+	/* catch special case of start == 0, which indicates "empty range";
+	 * caller for_each_netdev_feature() depends on this
+	 */
+	if (unlikely(!start))
+		return -1;
+
 	/* like BITMAP_LAST_WORD_MASK() for u64
 	 * this sets the most significant 64 - start to 0.
 	 */
-- 
2.17.1


