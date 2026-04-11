Return-Path: <netdev+bounces-277707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF5rOull2mnb1ggAu9opvQ
	(envelope-from <netdev+bounces-277707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 17:16:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610173E09C0
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B10DD30F09CE
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C73391E72;
	Sat, 11 Apr 2026 15:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3539478F
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920262; cv=none; b=j9hnXs4mtSqPB9rtGkzw44HHJwABrW2W2sYigQLG/r8iIHtMXymCgMbdenHptKbTxaERvJsii3zP3gCwwJBQixnj0e0IqUG3e8h5ne+a9LWiAa3XuKLZzjmyxDQlgUrTgFQeJFKG8qb7FZmirq4CKJ7ABHjskH0qTfbDFvjsZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920262; c=relaxed/simple;
	bh=Wj98PszY5zvEfP7EDdFQiIUbKAh6CR7bC4z8eZxeue4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4OMpuD3EvNIhcvhs3MN0JbL+D3UGvzzPBaTXTt6qO9GTVl3O0Fw3t5wiL+RGjCXW3pgPdmmSXBVak1f4066ASLpJ09V53FMB7LsAr0jie3SU9BRZxzedsJzu3rZCN1K4SImQV1rNEQ7WzyNxsJJiBlniJIKgDnfR4ttKLw1oyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAC3T4ZoZNppX7Q4AA--.30572S3;
	Sat, 11 Apr 2026 23:10:37 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sjur.brandeland@stericsson.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	zcliangcn@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: caif: clear client service pointer on teardown
Date: Sat, 11 Apr 2026 23:10:26 +0800
Message-ID: <9f3d37847c0037568aae698ca23cd47c6691acb0.1775897577.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775897577.git.zcliangcn@gmail.com>
References: <cover.1775897577.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowAC3T4ZoZNppX7Q4AA--.30572S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWUZry8KrWUJr48Gw4fAFb_yoW8Cw4Dpr
	sIgw1xKasrGry3Cws7ZFy0qrWYgFs5Gr1UC34kG3WrAa48ArZ5A3WvkFnxZryYvFs7CrW5
	tFn09F4qv34UCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
	6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQwOCWnaCt8DvwAAsQ
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-277707-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,stericsson.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 610173E09C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhengchuan Liang <zcliangcn@gmail.com>

`caif_connect()` can tear down an existing client after remote shutdown by
calling `caif_disconnect_client()` followed by `caif_free_client()`.
`caif_free_client()` releases the service layer referenced by
`adap_layer->dn`, but leaves that pointer stale.

When the socket is later destroyed, `caif_sock_destructor()` calls
`caif_free_client()` again and dereferences the freed service pointer.

Clear the client/service links before releasing the service object so
repeated teardown becomes harmless.

Fixes: 43e369210108 ("caif: Move refcount from service layer to sock and dev.")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/caif/cfsrvl.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/caif/cfsrvl.c b/net/caif/cfsrvl.c
index 171fa32ada85c..d687fd0b4ed3a 100644
--- a/net/caif/cfsrvl.c
+++ b/net/caif/cfsrvl.c
@@ -191,10 +191,20 @@ bool cfsrvl_phyid_match(struct cflayer *layer, int phyid)
 
 void caif_free_client(struct cflayer *adap_layer)
 {
+	struct cflayer *serv_layer;
 	struct cfsrvl *servl;
-	if (adap_layer == NULL || adap_layer->dn == NULL)
+
+	if (!adap_layer)
+		return;
+
+	serv_layer = adap_layer->dn;
+	if (!serv_layer)
 		return;
-	servl = container_obj(adap_layer->dn);
+
+	layer_set_dn(adap_layer, NULL);
+	layer_set_up(serv_layer, NULL);
+
+	servl = container_obj(serv_layer);
 	servl->release(&servl->layer);
 }
 EXPORT_SYMBOL(caif_free_client);
-- 
2.43.0


