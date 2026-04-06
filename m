Return-Path: <netdev+bounces-275602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDfcFwW702m5lAcAu9opvQ
	(envelope-from <netdev+bounces-275602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:54:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14C3A3B8A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E11D23003539
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADC29E11D;
	Mon,  6 Apr 2026 13:54:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB36306B37
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483649; cv=none; b=hUh+MdCvOQFSbrXmAC+cmARU2KvUtQlspFnFXP6SFTVm3GrhWlVrB0NE4qxHGqp7OxtSVj8c1v++ugXVtB/QglnbVqJHS/YrcswQZ1nCR+H2gxMFnghxGRw6i6VWAh64rBPGwPU/uin66AysBOxa7l/hOqs6LLvuqMitpXfqh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483649; c=relaxed/simple;
	bh=gDbwPL4lWb538GdsokNOA9J91hRTKlJnwhJ2F0/4G/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjYhkjMw+2OH1ya8JryY70gCY95zpvH7eNBMNYYnaTloWP1lUneAuf21fU75n765RPze4xQInICR3C/9J/Q136+j6Taarrd0FnhACfWb+1C5560/JMUy8+YIAMaB5IG9EYjETivUIo2W/0yak+jHlkpY0sdiJNfxTCKNcWD/5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADHOPnqutNpAc+rAA--.3279S3;
	Mon, 06 Apr 2026 21:53:48 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	xemul@parallels.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	wangjiexun2025@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] af_unix: read UNIX_DIAG_VFS data under unix_state_lock
Date: Mon,  6 Apr 2026 21:53:44 +0800
Message-ID: <e597de49d761fdc6961f49d638ce26bd3f74e988.1775207252.git.wangjiexun2025@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775207252.git.wangjiexun2025@gmail.com>
References: <cover.1775207252.git.wangjiexun2025@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADHOPnqutNpAc+rAA--.3279S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy5Cr45GFyxCrWDGryfWFg_yoW8uryUpF
	W3KFWUKryDAry29r1fKryI9w1Fva9rWF98G3yqkwn5J3ZrJrWIqas0gr9Fvrn5JFWFkw4x
	JF1Y9F1rGr48ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQIJCWnShX0IRQAAsN
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-275602-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,parallels.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: CC14C3A3B8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiexun Wang <wangjiexun2025@gmail.com>

Exact UNIX diag lookups hold a reference to the socket, but not to
u->path. Meanwhile, unix_release_sock() clears u->path under
unix_state_lock() and drops the path reference after unlocking.

Read the inode and device numbers for UNIX_DIAG_VFS while holding
unix_state_lock(), then emit the netlink attribute after dropping the
lock.

This keeps the VFS data stable while the reply is being built.

Fixes: 5f7b0569460b ("unix_diag: Unix inode info NLA")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/unix/diag.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index ca3473026151..76b2c48137dd 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -28,18 +28,23 @@ static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
 
 static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
 {
-	struct dentry *dentry = unix_sk(sk)->path.dentry;
+	struct dentry *dentry;
+	struct unix_diag_vfs uv;
+	bool have_vfs = false;
 
+	unix_state_lock(sk);
+	dentry = unix_sk(sk)->path.dentry;
 	if (dentry) {
-		struct unix_diag_vfs uv = {
-			.udiag_vfs_ino = d_backing_inode(dentry)->i_ino,
-			.udiag_vfs_dev = dentry->d_sb->s_dev,
-		};
-
-		return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
+		uv.udiag_vfs_ino = d_backing_inode(dentry)->i_ino;
+		uv.udiag_vfs_dev = dentry->d_sb->s_dev;
+		have_vfs = true;
 	}
+	unix_state_unlock(sk);
 
-	return 0;
+	if (!have_vfs)
+		return 0;
+
+	return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
 }
 
 static int sk_diag_dump_peer(struct sock *sk, struct sk_buff *nlskb)
-- 
2.34.1


