Return-Path: <netdev+bounces-262963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GD6AVIspmm/LgAAu9opvQ
	(envelope-from <netdev+bounces-262963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:33:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D01E721E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10CEA30763DF
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C171FCF41;
	Tue,  3 Mar 2026 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQZu/LYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F7126C03
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497987; cv=none; b=s7S0FJBdZXgutoPclDIasDiNhmabE1YNM1LutKd0iPtvm4PEtppW6JM0TPHagI+wH8g873idam1qc/UPupKiO8DM0QPpS52VYiH9tE8Fy90Qk4rTlbSYrEctRDKM1ZX1FG8gNSBbmAGFkcn4XQi2xl4IrPVxr+K1CDz7vWrUgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497987; c=relaxed/simple;
	bh=OKYgKlSTeG4GSRH5iOsE/UaIFTSGi8cSgGLLV4ZpEA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=stWNbCyZ5NQVz1/GnUvSwE49PDvqKG9HyLkesjLr24FtDzUt4zJK8lrasmmv9jO/ZyF4F0ZHVlimiqP+VpidzmpQgdc7Rsy3FwUHKhkdxss8zwxOLkF+QM5IlJPPj8qo7a8fYV5e/Db3gthY1o0rldvtXg3oltt6AqnGKKqU7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQZu/LYQ; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-649278a69c5so4366578d50.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 16:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772497984; x=1773102784; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gRXaYxmpUNBUEUdJFcpug3buWfv3yzf3AEaknZ0Z1k=;
        b=eQZu/LYQV41Epc5ciB3Wj6JFCUIkzI/S8feSjLKd6/vYeX1fEXtgXYvPsd208hiivm
         0S0FvSxggtAFmBkRrFw7zzoiGZudeyaursq3Rn6wK0EbEXffbZre1zuVYffhgPw/6d70
         GcEAgVZC8GVXpwwWekFdy31UL4Vm7+OTdK3NKxkAnDlnfL1Hoc/VkSssPnr1AX8aR5O0
         2KQOSn0io8sXPNu3UHLEN0vrNFmIHx/Q0OFt7Ye01S8h48JNJc/Ljihv4+7MUj2ZDGjq
         9ZpSeUUyq2qjNcKCqNYMq95kSU9DioXPf1wcIms5P4lVSpFtntKGD6iF0uyJ2JHiew2x
         9ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772497984; x=1773102784;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gRXaYxmpUNBUEUdJFcpug3buWfv3yzf3AEaknZ0Z1k=;
        b=k2Dfmlrx0FC1Kw8WVYEW5EdWcSJBZKLgFk/3V6pgYLyZYx98XX8DLq38QMUJ3T77bs
         o8ihzMZH4WkUWG9iDyhRRWqLC/1RpKSN/QhG8tN18jbu441vuHzlqIr5eJ1iCrtF4m0Q
         CD+e1UgUCed7aMOXQFs8pXucCDYwaV3Jtfm5yfVAvz/izRLAuYfAWjCr9CsFsNR+Qopn
         hWt9StZsTkS+miMu0X2NG9btFLhU81N8uOZhEGHqpmo4NNyoOsmCv3iSBcPUal5lwcQg
         ygOMTO0an1lMqB4sFKOzb5CnO3Jz2ufD49H8Am3TmyimTphKfG1fmN0VqjL56yrFpJpj
         u10A==
X-Gm-Message-State: AOJu0YyvooxbFbN7BRVUSGKdRheMY3U3XL0cXIMpyigFDWx3sYHrHJT7
	82B+U7ZJzYsEyoy9XfHUlU4thjhMtcU8TW1iDSFep1Hs51g/nxk3J0jf
X-Gm-Gg: ATEYQzwUoloQaTXddW8Uo0UfP0TOYDf+84kWarD6RCGsjkddVQgmD0IUsEvQSRaH8ab
	3nfRcWA3qGqrEKlkEVCtBaZhl8o7MdyhOiD1yGsNplASfOd2AtnQyUk3ql/OtHjRc8c+mAn73ii
	US5dxhQ1v0Uf3zmfoRo3nhxFNZr0TrT36dQ74QyT8r6nOc5AZ4bHdpx8QDyo9yWBNj/sit4JK44
	0OatBiNtuLa2GKtH3rHiYCjryqiUcOvufS1o25ro+q5cgw9sabGyLhi5KzPyuX1LI4USil8VBlj
	h4nYmYUCL5eHrPl4KcFRwAMxr2/FCcgQxlDvtKkgQsEK3CqHB3K0DvZbeGZ+rM9efo7k3I6eEpT
	3JeWkmRddr+MqkyIsYuIb9s230Ab5/yhAA2cA35AFoICzkVnaXTXGKn+ErhXoci3j6QF/Ds+mZT
	sJVHNSYllPrFgY+ZUHthNyiA==
X-Received: by 2002:a05:690e:174b:b0:64c:9c10:c16 with SMTP id 956f58d0204a3-64cc2224ed0mr8535381d50.53.1772497984218;
        Mon, 02 Mar 2026 16:33:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7572340sm6178927d50.1.2026.03.02.16.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 16:33:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 02 Mar 2026 16:32:56 -0800
Subject: [PATCH net v2] net: devmem: use READ_ONCE/WRITE_ONCE on
 binding->dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-devmem-membar-fix-v2-1-5b33c9cbc28b@meta.com>
X-B4-Tracking: v=1; b=H4sIADgspmkC/33NQQqDMBBG4auEf+0UE1urrnqP4iJNJnUW0ZJIs
 Ih3L3iArh98b0fmJJwxqB2Ji2RZZgzKVApusvObSTwGBVObtjamIc8lcqTI8WUTBdmosTfn+1Z
 3obOoFD6Jg2yn+cTMK8ZKYZK8Lul7foo+0x+yaNLU3L2zrPnah+4RebUXt0SMx3H8AL1y5Tq2A
 AAA
X-Change-ID: 20260223-devmem-membar-fix-3a5cd9618f8a
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 7F9D01E721E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262963-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:mid,meta.com:email]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

binding->dev is protected on the write-side in
mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
concurrent bare reads in net_devmem_get_binding() and
validate_xmit_unreadable_skb() it should be wrapped in a
READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
with the underlying register in unforeseen ways.

Doesn't present a critical bug because the known compiler optimizations
don't result in bad behavior. There is no tearing on u64, and load
omissions/invented loads would only break if additional binding->dev
references were inlined together (they aren't right now).

This just more strictly follows the linux memory model (i.e.,
"Lock-Protected Writes With Lockless Reads" in
tools/memory-model/Documentation/access-marking.txt).

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- add ASSERT_EXCLUSIVE_WRITER() to mark write-side critical section
- add READ_ONCE() in validate_xmit_unreadable_skb() too
- Link to v1: https://lore.kernel.org/r/20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com
---
 net/core/dev.c    | 2 +-
 net/core/devmem.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c1a9f7fdcffa..9036fcf9f965 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3987,7 +3987,7 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	if (shinfo->nr_frags > 0) {
 		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
 		if (net_is_devmem_iov(niov) &&
-		    net_devmem_iov_binding(niov)->dev != dev)
+		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
 			goto out_free;
 	}
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 8c9aad776bf4..69d79aee07ef 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -396,7 +396,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	 * net_device.
 	 */
 	dst_dev = dst_dev_rcu(dst);
-	if (unlikely(!dst_dev) || unlikely(dst_dev != binding->dev)) {
+	if (unlikely(!dst_dev) ||
+	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
 		err = -ENODEV;
 		goto out_unlock;
 	}
@@ -513,7 +514,8 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 			xa_erase(&binding->bound_rxqs, xa_idx);
 			if (xa_empty(&binding->bound_rxqs)) {
 				mutex_lock(&binding->lock);
-				binding->dev = NULL;
+				ASSERT_EXCLUSIVE_WRITER(binding->dev);
+				WRITE_ONCE(binding->dev, NULL);
 				mutex_unlock(&binding->lock);
 			}
 			break;

---
base-commit: 9439a661c2e80485406ce2c90b107ca17858382d
change-id: 20260223-devmem-membar-fix-3a5cd9618f8a

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


