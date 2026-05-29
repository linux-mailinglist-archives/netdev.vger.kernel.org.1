Return-Path: <netdev+bounces-293087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODidEAJxGWqNwggAu9opvQ
	(envelope-from <netdev+bounces-293087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:57:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C13601312
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28576302C158
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6D38C2DE;
	Fri, 29 May 2026 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="hTr8hDtv"
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1928E36E49B;
	Fri, 29 May 2026 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051839; cv=none; b=AM2hP3U6hG3jLSze7jIt2M6Wa7EjX6sX2YJpl5kqNJ0/MM0PYCXEMaeM+Np7eIoXAkerUrq1joLPcBe0i2/2RARCKQO1FJ3yc4l41mdCYHSn0kCz9HoYPF7GssZxRnBWUZEoWTZvzqgLJWj5lPh9zCA2Y6GCAxZvWEtV5y0mL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051839; c=relaxed/simple;
	bh=zJmJyszzc4rtwFc1feoDW1EMDCE2xN7IAh2f0zqeWaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msFM/1TJ9PUDdaI2/HKa3flYuAD/wFwiXdR7h3Hq1/IDVNKSADasNS0T8fwqAJ3CW0mJnmOUlU+mfof8Q3Mo7p34GySE+3wHxlvjly7Ud+pBL7X8xz8Xs0PUkwBrHHP+KAaSBhvpjxUAUAuKS3LvlM0xNHX98hHg97LFBrOZyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=hTr8hDtv; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=x7eYy
	W8Vw90dDgE+/J8Hbda3z+rHKSx6ialGlB6EhI4=; b=hTr8hDtv7+73OqcyCCZNr
	2LI6UE8VEIgNrBcr2lxaayYAaPxwLA9mn2ffFcr8Egg14k6M+1zbQ8Suw19WKgbw
	T7M/X2BI3y5kh1i44Upl09p8EXccyS/i6IInyUA4XFaeYJy5xDhMWvtP/5OzC8xs
	RWAmmJs4j8sbWd+KXffJIM=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web3 (Coremail) with SMTP id ygQGZQAndpNxbxlqKqb8AQ--.63974S2;
	Fri, 29 May 2026 18:50:26 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH net] appletalk: aarp: zero-initialize aarp_entry to prevent heap info leak
Date: Fri, 29 May 2026 18:50:16 +0800
Message-ID: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQAndpNxbxlqKqb8AQ--.63974S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr18WFWUJr4kuFW8JFykAFb_yoW8JrW7pa
	y3Z3WqyayxJr9rCr1kJw47Ar45uaykWr93t34Yka4jvrnxWFykG3W8KanxZr90ya4kKF1r
	AFyq9FWjvr1DX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj_Oz7UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQUCAWoZNVmVWQAAsU
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293087-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:dkim,seu.edu.cn:email,tsinghua.edu.cn:email]
X-Rspamd-Queue-Id: 90C13601312
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

aarp_alloc() allocates struct aarp_entry without zeroing it, but only
initializes refcnt and packet_queue.  When an unresolved AARP entry is
created, hwaddr[ETH_ALEN] is left uninitialized.

aarp_seq_show() later prints this field with %pM when users read
/proc/net/atalk/arp.  This can expose 6 bytes of stale heap data for
each unresolved entry.

Fix this by zero-initializing struct aarp_entry at allocation time.

Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index e7315c0..9490395 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -393,7 +393,7 @@ static void aarp_purge(void)
  */
 static struct aarp_entry *aarp_alloc(void)
 {
-	struct aarp_entry *a = kmalloc_obj(*a, GFP_ATOMIC);
+	struct aarp_entry *a = kzalloc_obj(*a, GFP_ATOMIC);
 	if (!a)
 		return NULL;
 

--
2.43.0


