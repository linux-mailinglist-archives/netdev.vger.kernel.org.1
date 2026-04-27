Return-Path: <netdev+bounces-281236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHxUJtUF72ma3wAAu9opvQ
	(envelope-from <netdev+bounces-281236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:44:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9935146DC47
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30EE33005EB7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6C322B9F;
	Mon, 27 Apr 2026 06:44:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944C24676D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272272; cv=none; b=sv+75ToYG+qlfMJrSBPlcDoxme1ifeidzeSVPnNi4YX1HpX5BCwaM7638yGA0oSiEdAzYEMiDzIk49NXS0KHSEHbz7zSwRNsngD85onz5nF4kKlsC0aaRqOghj7/NFOEb18OlrUw9eOIt93JQkgh30Fe9HKaXAUOQuKnYbGWgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272272; c=relaxed/simple;
	bh=Jo9k13W5Vq5CzhD21g888UVupDbMnS8fHVvc4zBbTwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdvQyY6Oiyl4ZeOf5b3s3GJC8DtkgsmCQpEYojzCtoALC3hT5MYLuu+6WhVphZiduiCZkKMuoGxRD5ZK82xHl2Z5voKpiTvDBTYIIS6QD8lxEmne336npIJermolKZafCPxlWF4Or9Ll87oyLat/P8+w1egmTk+sAacqM/ngA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADXTwCaBe9pClLjAA--.56415S2;
	Mon, 27 Apr 2026 14:43:38 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	tr0jan@lzu.edu.cn,
	wangjiexun2025@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions during teardown
Date: Mon, 27 Apr 2026 14:43:33 +0800
Message-ID: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADXTwCaBe9pClLjAA--.56415S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4ktw48ur17Cr18Jw43KFg_yoW5GF4Dpa
	yfGr90kF9rtw4kXFsFyryYkr1ayw4IgFW7Way3Cr1UAFnrtr4rKa4kKr1jvrn8tayUKrZx
	Z3yUta47Zan8CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi_HU3UUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAICWnsf+IDoQAFs-
X-Rspamd-Queue-Id: 9935146DC47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-281236-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.855];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:mid,lzu.edu.cn:email]

From: Jiexun Wang <wangjiexun2025@gmail.com>

Prevent tp_meter from starting new sender or receiver sessions after
mesh_state has left BATADV_MESH_ACTIVE.

Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v2:
- Split the original fix into setup-side and teardown-side patches

 net/batman-adv/tp_meter.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 2e42f6b348c8..d9a80e459c2e 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -947,6 +947,13 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* look for an already existing test towards this node */
 	spin_lock_bh(&bat_priv->tp_list_lock);
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
+		spin_unlock_bh(&bat_priv->tp_list_lock);
+		batadv_tp_batctl_error_notify(BATADV_TP_REASON_DST_UNREACHABLE,
+					      dst, bat_priv, session_cookie);
+		return;
+	}
+
 	tp_vars = batadv_tp_list_find(bat_priv, dst);
 	if (tp_vars) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
@@ -1329,9 +1336,12 @@ static struct batadv_tp_vars *
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		    const struct batadv_icmp_tp_packet *icmp)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_vars *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		goto out_unlock;
+
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
 					      icmp->session);
 	if (tp_vars)
@@ -1464,6 +1474,9 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 {
 	struct batadv_icmp_tp_packet *icmp;
 
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		goto out;
+
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
 
 	switch (icmp->subtype) {
@@ -1478,6 +1491,8 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 			   "Received unknown TP Metric packet type %u\n",
 			   icmp->subtype);
 	}
+
+out:
 	consume_skb(skb);
 }
 
-- 
2.34.1


