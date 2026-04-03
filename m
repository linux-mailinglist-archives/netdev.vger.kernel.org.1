Return-Path: <netdev+bounces-274846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB/7Ak0jz2nLtAYAu9opvQ
	(envelope-from <netdev+bounces-274846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDFF39058B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB1C3302444A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4602848BE;
	Fri,  3 Apr 2026 02:17:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A41B4224
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182665; cv=none; b=Ei61vyZifTHB3Y3slIKNjYQL5WekulhuEsn1DqhBih5P5EopC82bykivcJamrbqKAQiqfdfV7L7cAVGS03mwsN2FGnFC2SH3LNNadCjYXIzyoYdS3wzMR9tXS1I+/uLYrX5MMrE/Qwi94Qx2Un/SDwau3nXUENcbKZjhLa0ofOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182665; c=relaxed/simple;
	bh=YxJSynwZ5Sbaq1EQpSaAj8M2UPe+TIV0y7eBSGoYeH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEvMX2SQvQwELQWSLaE/WN9YWMkRDDfnYIk+dvtFHZexV4DIyaBjtQMej8gTEcPHYsU1DJhIrF/6yEK6K8eO/vCKq5QqaZSXMKKqh1lqqwrkJmjSexgH3lum6GOBD04brgpxryMDYOZtk5nMeXEp0I/Rn13lE6DuA7tcGg7H1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from a800-server-1.tail7779b.ts.net (unknown [172.30.111.252])
	by app1 (Coremail) with SMTP id ygmowADHOPkwI89pqjeiAA--.675S2;
	Fri, 03 Apr 2026 10:17:20 +0800 (CST)
From: Yang Yang <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	jiewang2024@lzu.edu.cn,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] rxrpc: only handle RESPONSE during service challenge
Date: Fri,  3 Apr 2026 02:17:20 +0000
Message-ID: <20260403021720.532400-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403021351.530453-1-n05ec@lzu.edu.cn>
References: <20260403021351.530453-1-n05ec@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADHOPkwI89pqjeiAA--.675S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw15JFyDur43uw4kGw1Utrb_yoW5JrW8p3
	y5CFWfKF95XanxXrs3Jr1v9r1qka1kGry7JryDuw18A3ZYqwnxAFn5tFZIvF13WFy8Ga1U
	Zw4jyrs3AF45ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VCY1x0262k0Y48FwI0_Jr0_Gr1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28Icx
	kI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUYYL9UUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQMGCWnOkPwEpAABsn
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274846-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0CDFF39058B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wang Jie <jiewang2024@lzu.edu.cn>

Only process RESPONSE packets while the service connection is still in
RXRPC_CONN_SERVICE_CHALLENGING. Check that state under state_lock before
running response verification and security initialization, then use a local
secured flag to decide whether to queue the secured-connection work after
the state transition. This keeps duplicate or late RESPONSE packets from
re-running the setup path and removes the unlocked post-transition state
test.

Fixes: 17926a79320a ("net: AF_RXRPC: Provide secure RxRPC sockets for use by userspace and kernel both")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jie Wang <jiewang2024@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
---
 net/rxrpc/conn_event.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 98ad9b51ca2c..74823f70b57a 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -247,6 +247,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			       struct sk_buff *skb)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	bool secured = false;
 	int ret;
 
 	if (conn->state == RXRPC_CONN_ABORTED)
@@ -262,6 +263,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		return ret;
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
+		spin_lock_irq(&conn->state_lock);
+		if (conn->state != RXRPC_CONN_SERVICE_CHALLENGING) {
+			spin_unlock_irq(&conn->state_lock);
+			return 0;
+		}
+		spin_unlock_irq(&conn->state_lock);
+
 		ret = conn->security->verify_response(conn, skb);
 		if (ret < 0)
 			return ret;
@@ -272,11 +280,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			return ret;
 
 		spin_lock_irq(&conn->state_lock);
-		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING)
+		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING) {
 			conn->state = RXRPC_CONN_SERVICE;
+			secured = true;
+		}
 		spin_unlock_irq(&conn->state_lock);
 
-		if (conn->state == RXRPC_CONN_SERVICE) {
+		if (secured) {
 			/* Offload call state flipping to the I/O thread.  As
 			 * we've already received the packet, put it on the
 			 * front of the queue.
-- 
2.43.0


