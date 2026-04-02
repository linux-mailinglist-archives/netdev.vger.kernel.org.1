Return-Path: <netdev+bounces-274596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIZ6AdeHzmnfoAYAu9opvQ
	(envelope-from <netdev+bounces-274596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:14:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D638B1F5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCEF03013CB7
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF93EDAA2;
	Thu,  2 Apr 2026 15:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A285F3EE1D7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142785; cv=none; b=EgOLfH05YkantWQyXujBCnfpg0cepwFlbfMuYI3akvVFo7rBuuo0ZyK14ELOtZLKDT/RfIY/gzXdOoA3i4luPDkEhRgWDbN0lIBJroh9SSTGlt26/sOFwg1Ie2FfU2mLq8ABQX7LqFfkyALA2wUsoRTdzJKJTCCOlNqJqO6vlTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142785; c=relaxed/simple;
	bh=F8kBlwvtGeXHsOy7KlqLaw/eem2ltChN8vbS1kHkLwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPGa28w+XmEArFTGRb4rKOgrbexDX+2G0IvKLf2d0Z/HLBzsmda6vvY/C9Dpkig/2ME0eKAlYirLqbg778FdmCUVLiu3dgrhpi35D3ExJcW9DZHLAYbsNMP5l6CkbuqMMRmIH4d/E9Zq77BOX0h5RKN4tgVicEflwOpIgXBYv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnHwBgh85pjSKhAA--.35323S3;
	Thu, 02 Apr 2026 23:12:34 +0800 (CST)
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
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	caoruide123@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] batman-adv: reject oversized global TT response buffers
Date: Thu,  2 Apr 2026 23:12:31 +0800
Message-ID: <f1ae21c92be31b48651378f1ceba0dbbb43c2847.1774947926.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774947926.git.caoruide123@gmail.com>
References: <cover.1774947926.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnHwBgh85pjSKhAA--.35323S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uryDZr4rAF13Cw1fXFykGrg_yoW8uw4rpF
	WfGryDGrZ3J3sxJFn2y340vr4FkFs7Gr1UtasYv3Z0va1kKr93JayYkryqvF4rJayIkFWY
	vF1Y9FW7Xa1DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRi_HU3UUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQQFCWnNP3wYUwAAsl
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-274596-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: DA3D638B1F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ruide Cao <caoruide123@gmail.com>

batadv_tt_prepare_tvlv_global_data() builds the allocation length for a
global TT response in 16-bit temporaries. When a remote originator
advertises a large enough global TT, the TT payload length plus the VLAN
header offset can exceed 65535 and wrap before kmalloc().

The full-table response path still uses the original TT payload length when
it fills tt_change, so the wrapped allocation is too small and
batadv_tt_prepare_tvlv_global_data() writes past the end of the heap object
before the later packet-size check runs.

Fix this by rejecting TT responses whose TVLV value length cannot fit in
the 16-bit TVLV payload length field.

Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/batman-adv/translation-table.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6e95e883c2bf..05cddcf994f6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -798,8 +798,8 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 {
 	u16 num_vlan = 0;
 	u16 num_entries = 0;
-	u16 change_offset;
-	u16 tvlv_len;
+	u16 tvlv_len = 0;
+	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
 	u8 *tt_change_ptr;
@@ -816,6 +816,11 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(num_entries);
 
+	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
+		*tt_len = 0;
+		goto out;
+	}
+
 	tvlv_len = *tt_len;
 	tvlv_len += change_offset;
 
-- 
2.34.1


