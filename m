Return-Path: <netdev+bounces-31469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C5278E39D
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 02:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92D7281337
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3A11703;
	Wed, 30 Aug 2023 23:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0085111BE
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 23:59:43 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5386CC9;
	Wed, 30 Aug 2023 16:59:41 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 2/5] netfilter: xt_sctp: validate the flag_info count
Date: Thu, 31 Aug 2023 01:59:32 +0200
Message-Id: <20230830235935.465690-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230830235935.465690-1-pablo@netfilter.org>
References: <20230830235935.465690-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wander Lairson Costa <wander@redhat.com>

sctp_mt_check doesn't validate the flag_count field. An attacker can
take advantage of that to trigger a OOB read and leak memory
information.

Add the field validation in the checkentry function.

Fixes: 2e4e6a17af35 ("[NETFILTER] x_tables: Abstraction layer for {ip,ip6,arp}_tables")
Cc: stable@vger.kernel.org
Reported-by: Lucas Leong <wmliang@infosec.exchange>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/xt_sctp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/xt_sctp.c b/net/netfilter/xt_sctp.c
index e8961094a282..b46a6a512058 100644
--- a/net/netfilter/xt_sctp.c
+++ b/net/netfilter/xt_sctp.c
@@ -149,6 +149,8 @@ static int sctp_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_sctp_info *info = par->matchinfo;
 
+	if (info->flag_count > ARRAY_SIZE(info->flag_info))
+		return -EINVAL;
 	if (info->flags & ~XT_SCTP_VALID_FLAGS)
 		return -EINVAL;
 	if (info->invflags & ~XT_SCTP_VALID_FLAGS)
-- 
2.30.2


