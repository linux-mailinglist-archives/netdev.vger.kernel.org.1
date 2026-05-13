Return-Path: <netdev+bounces-287476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKqHHBA3BGoqFgIAu9opvQ
	(envelope-from <netdev+bounces-287476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:32:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A374852FB41
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D26EF305F26B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C63E0745;
	Wed, 13 May 2026 08:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64273E0733
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661079; cv=none; b=QAc+FOKHeQNyVfLTWSNEiqWPoMwMn+7x/IHuv28LFGAcymMvgXs70u1YAeXj1A1j0NbfNy+aTW2Ckf4uTmqRxcySJRAGAbv3PwApftZzzVy1DVg38EtfaV8hNucs9WNLnPbZ71B9vFewVXifFqPB3aYNyiBHpjlNj66RghtRou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661079; c=relaxed/simple;
	bh=zzdB6St9C7T53fX14eZHiiQY6NWMjTkZmhIJ2E6M69M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVgWDjASgflqGlyiiKBC+E+6xkavx2CN0OAyHH09amr1fRBCaWrDiKHO9d6NjKZs30q/YfIX0CiwIDxELzn87m+SI6YiSG94Ap/pFd6rcRBW0rnYmNFWXjTLHExq7OQatP6Wi7GwGuV2KHJ+sOE2E7/LPfwdMSYgTaoLiHbzMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowABnicPDNgRqFYcDAA--.4301S2;
	Wed, 13 May 2026 16:30:59 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: [PATCH net 1/1] llc: conn: drop out-of-service state in llc_conn_service
Date: Wed, 13 May 2026 16:30:58 +0800
Message-ID: <5f646c530f4a0820060499054c46b8dbecebd7be.1778638129.git.zlian064@ucr.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778638129.git.zlian064@ucr.edu>
References: <cover.1778638129.git.zlian064@ucr.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowABnicPDNgRqFYcDAA--.4301S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kAF4fAFyrJFWUWryxuFg_yoW8Wr1kpa
	9xur97KFyqqr13CF18AF109FZxuFZrWrsrCrWDJw18X3WkJrs0k39YgFZF9a1jyrWvkFW5
	tF4vvrn5W3yrAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEGCWoEFm8DogAAs5
X-Rspamd-Queue-Id: A374852FB41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287476-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Action: no action

From: Zhengchuan Liang <zcliangcn@gmail.com>

llc_conn_service() only rejects states above NBR_CONN_STATES, but
LLC_CONN_OUT_OF_SVC is also invalid for connection state processing.

The connection state tables are indexed by llc->state - 1, so only
states in the range 1..NBR_CONN_STATES are valid here. If a socket in
LLC_CONN_OUT_OF_SVC is still reachable and another frame is delivered
to it, llc_qualify_conn_ev() will walk the state tables with an
invalid index.

Drop LLC_CONN_OUT_OF_SVC before looking up the current state
transition. Return success for that state so repeated packets to a
stale reachable socket are ignored quietly instead of being turned
into llc_conn_service() failures.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/llc/llc_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248..715d5a314071 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -360,6 +360,10 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
 	struct llc_sock *llc = llc_sk(sk);
 	int rc = 1;
 
+	if (llc->state == LLC_CONN_OUT_OF_SVC) {
+		rc = 0;
+		goto out;
+	}
 	if (llc->state > NBR_CONN_STATES)
 		goto out;
 	rc = 0;
-- 
2.34.1


