Return-Path: <netdev+bounces-277267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAAXFc2Z2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:33:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A13D2CFC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CD5E300E624
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD2B38655E;
	Fri, 10 Apr 2026 06:32:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8433A701
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802744; cv=none; b=dwQlcc/Y+JyMADswqkheQTXb9PMfREZvnR7A3lxjNTXCf8luX1F0lnM3sbHbElQvun+QjhPcAjIAF3vQPkbQRVkz03gEL5ucjKUEGLCpBp1O1N7R7a3ux7hyElY9tYr4YGI2sJFmXQ+bRCfv62Sy9OMAH9QJCMKoxF206R8VFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802744; c=relaxed/simple;
	bh=e4a8uUAs9uNPOyWNigdJsbTFKaUFUCJrtE4kqT2pfCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1lr81bucX+lxOLxC/jpOy66DNzgTbNHCmnykHBhKtE8jottExmYJp3R72j5ab2Xg1AvIKHY6b370upi0dPjjk8pJvasDAwPWil/kaDNFlLb7pgCG1bqyquUPIx0yupbHpIMvFW0U8CM34z9CWqHGA5FZzwaepaNaCjj+gosxfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAAnmPhemdhpqIa5AA--.64358S3;
	Fri, 10 Apr 2026 14:31:59 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	rao.shoaib@oracle.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	wangjiexun2025@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] af_unix: Hold receive queue lock in ioctl(SIOCATMARK)
Date: Fri, 10 Apr 2026 14:31:57 +0800
Message-ID: <f6cbbc8da90e95584847b5ceb60aae830d1631c2.1775731983.git.wangjiexun2025@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775731983.git.wangjiexun2025@gmail.com>
References: <cover.1775731983.git.wangjiexun2025@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAAnmPhemdhpqIa5AA--.64358S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyxCFW8Zry8Gw4UKFyrXrb_yoW8AF4kpr
	WakF17tr9Yyr40vr95t34I9FsrJan7XFW3JrZ7JFyUXFs0g3yfXasY9ryUXa18WFWDCF4f
	ZF1q9Fs0ya1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQENCWnXZ94bOQAAsh
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-277267-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,oracle.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 541A13D2CFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiexun Wang <wangjiexun2025@gmail.com>

unix_ioctl() peeks at the receive queue and may check both the head skb
and its successor while deciding whether SIOCATMARK should report the
mark. However, u->iolock does not stabilize receive-queue element
lifetime. Queue teardown paths can purge or splice the queue under
sk->sk_receive_queue.lock and free the skb while unix_ioctl() still
uses it.

Take sk->sk_receive_queue.lock while inspecting the queue so the skb
and next_skb stay alive for the whole decision.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/unix/af_unix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b23c33df8b46..54f12d5cda37 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3301,6 +3301,8 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			int answ = 0;
 
 			mutex_lock(&u->iolock);
+			/* The receive queue lock keeps skb and next_skb alive. */
+			spin_lock(&sk->sk_receive_queue.lock);
 
 			skb = skb_peek(&sk->sk_receive_queue);
 			if (skb) {
@@ -3315,6 +3317,7 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 					answ = 1;
 			}
 
+			spin_unlock(&sk->sk_receive_queue.lock);
 			mutex_unlock(&u->iolock);
 
 			err = put_user(answ, (int __user *)arg);
-- 
2.34.1


