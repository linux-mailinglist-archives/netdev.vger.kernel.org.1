Return-Path: <netdev+bounces-265393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH0/OCt8rmnoFAIAu9opvQ
	(envelope-from <netdev+bounces-265393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:52:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD8F2350EC
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 012FC30067AD
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C43624AB;
	Mon,  9 Mar 2026 07:50:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54C368954;
	Mon,  9 Mar 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042647; cv=none; b=P2e5tBtwwFNyLm0iqQM/xVnEzUK4ja1y1x1PJGiZow96QWzORcNYnRoTsae+B1WUK4fD8Wwot4f98oHFPycRz/z6Ft86Z6L4u2GNjYcKwrGuM6SMBp3WB27V+hG3PkfeG3Aq2skrEDyfHSQJMzisFhp5NX+SIPwzMf/3ST4lUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042647; c=relaxed/simple;
	bh=WgM63bkMNCNibkQpWs8bsqpc4csyCLfir2TlPmhqIvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sI4mC0zhzqEp8V9iocSSti9iJB1A16dEjqDbjUQM9+bmTb6Z4N9W0TtvRRm/hAiG8vYTTf/Ziy9dKETgWHeUFu44io9GqTV3fSJJO89zMrkQvF9j9WpnAfF2REeUwxviOPBkbtcZsyda1aLDTobqJS96Ih6XA1Bl/Uz/lliLYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowABX7A+0e65pV0fwCQ--.52086S2;
	Mon, 09 Mar 2026 15:50:12 +0800 (CST)
From: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	18291782795@163.com,
	pengpeng@iscas.ac.cn
Subject: [PATCH] net: dsa: scope dsa_user_suspend() and 
Date: Mon,  9 Mar 2026 07:49:19 +0000
Message-Id: <20260309074919.715092-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX7A+0e65pV0fwCQ--.52086S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUGFWDGrykXFWxJF1rtFb_yoW8ArW8p3
	W8Wr43trW7Jryq9rW8u348Wa9aqw4Fk34xGrZ5G3sxCa98Jr1xCr4rA3W5ur1jkrW5WrW5
	tF9rK3s8AF15Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5918JUUUUU==
X-CM-SenderInfo: pshqw1hhqjhx1rx6x21ufox2xfdvhtffof0/
X-Rspamd-Queue-Id: AFD8F2350EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,163.com,iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-265393-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng.hou@isrc.iscas.ac.cn,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.610];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,isrc.iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Action: no action

From: pengpeng@iscas.ac.cn

In current linux.git (1954c4f01220), the helpers dsa_user_suspend()
and dsa_user_resume() are defined and declared unconditionally. However,
their only in-tree callers are within dsa_switch_suspend() and
dsa_switch_resume() in net/dsa/dsa.c, which are already guarded by
CONFIG_PM_SLEEP.

Match the helper scope to their callers by wrapping the definitions in
"#ifdef CONFIG_PM_SLEEP" and providing no-op stubs in the header. This
fixes the config-scope mismatch and reduces unnecessary code footprint
when PM_SLEEP is disabled.

Signed-off-by: pengpeng@iscas.ac.cn
---
diff --git a/net/dsa/user.c b/net/dsa/user.c
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@
-int dsa_user_suspend(struct net_device *user_dev)
+#ifdef CONFIG_PM_SLEEP
+int dsa_user_suspend(struct net_device *user_dev)
 {
 	struct dsa_port *dp = dsa_user_to_port(user_dev);
@@
 int dsa_user_resume(struct net_device *user_dev)
 {
 	struct dsa_port *dp = dsa_user_to_port(user_dev);
@@
 
 	return 0;
 }
+#endif
 
 int dsa_user_create(struct dsa_port *port)
 {
diff --git a/net/dsa/user.h b/net/dsa/user.h
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@
 int dsa_user_create(struct dsa_port *dp);
 void dsa_user_destroy(struct net_device *user_dev);
+#ifdef CONFIG_PM_SLEEP
 int dsa_user_suspend(struct net_device *user_dev);
 int dsa_user_resume(struct net_device *user_dev);
+#else
+static inline int dsa_user_suspend(struct net_device *user_dev)
+{
+	return 0;
+}
+
+static inline int dsa_user_resume(struct net_device *user_dev)
+{
+	return 0;
+}
+#endif
 int dsa_user_register_notifier(void);
 void dsa_user_unregister_notifier(void);


