Return-Path: <netdev+bounces-289814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF+EBB5qDWqGxAUAu9opvQ
	(envelope-from <netdev+bounces-289814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:00:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3458948B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 319B43051489
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508D39EF32;
	Wed, 20 May 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTmmpZ0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E381B36AB49
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264008; cv=none; b=MG/2icQg3s2t7ObotrvmcgcI8zfvjmXsaWJKeYcNki92UrnNbouIIIu9Ecn3MZmUhoFlw1wgH9ehaTzw8zj3/irVC0ffF+0Sbo7QrVyUZWFhFxcOmwilfnavW4irpxOcV5hjYMRN3FXntuiKZ7Mi4yidGjXMfZ13OJnRaCs/Obo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264008; c=relaxed/simple;
	bh=bylUaJtdDzwGNVF4Uktdq+iIyOjiXM6Hq+EFEhzDvAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBt/2UGegL034xU1pJsTahDEer8lMmaEKm+ZuU6Hc5Naw80wJM9jUvAA3FOI21OIOs79OK2nreadYGF/lFDoKHEiaOMymGkhXWq/E4CMydOsjImThnm9hknbYtiKKDNDJppjy10u4gcLTvHUbE5KqM2bKruKIC3byYWngJeYgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTmmpZ0T; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12ddbe104ccso3209082c88.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264006; x=1779868806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSnyB4XZYPvq8d1lcWiPY8NYEotO8Fxh7ugf2SByLY4=;
        b=KTmmpZ0TpDXRO550qmmOQxwrfZ3iKXqEKbKHx7lVeh9+puhNZrJB5JBJ9NYX90PoZ+
         s9yfLXp1jvFGgZPQfc/yrk9QjWEs4UG9YO3hWSSbB+onGyT7MdFhZLkuXrkdSHJiWmME
         59in/N9+fJ3Q1RbYYgvByw1k5w+AVa9nxW6h81hpRKynbUtNZ0ZGaOehD2eaBQB8N78r
         xZYhlKa7keTiE38ySI1b1lB3Secjq+bS9za33h2Wg5dUU9FNAHJ70K3P92c/aWYftLgy
         ipV3Zdy8aKqJuQ92mnCkd0cWaJ//vkQxqxGGNIzC3B5/42w7qXP7K8rJu+JU/1NAUdGC
         SAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264006; x=1779868806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSnyB4XZYPvq8d1lcWiPY8NYEotO8Fxh7ugf2SByLY4=;
        b=GT8IMylEhuEBvUtBWSF+rPj/E+k7hqgeAE2JJeR1F8LjSZeuBQdTnkzTHV44JtkD28
         nnOKgVu4kjw6dXuugh6QTKkLjlWlVhsO7lsXp2YQxYNi0j+FJCw7Bd38sUo8BsjUcI47
         TScSyxTkN1MCPb7DjQeoNX3wCmp8s239dl88eyAY1CZCVvBBUCdC683H0aj6MOlpIEk8
         Zk8t3SSlsi7okfh2nRc398EDk8/+XTBKF03hcq9m8LcGRGZYSf2HaljS7YHtS/Ao3WoO
         47zDUy10rEXYiqi1sV1hmqI3tTj0ZlgKH7ZkAoHyxSk/cV3NJHs0H08j/N6bwKQLLK4I
         BsvA==
X-Gm-Message-State: AOJu0YwDNNvEd7dKfQyecDYuoTy7l4J8T1NgOg5WgwC98d9PHAwMmEKd
	m1gtCtaR/vDqFep4aq/RE4foYQhkQyWhETc7wOJG1xwaCY56fsXmOd+KYNQ2SLcx
X-Gm-Gg: Acq92OGyeg4tYB06IjTRDepqNGrFS6dJnPnuUL1njXsWXJ5s+t+PfEr7YegQycfXdHz
	6ai9vKj9wo26wspT709pNrqUza3W3DbfC1CnRv3TIj90GVzX2HahDkD3jzgB1aiL6KVXOxkYe/P
	3YNsnC+XL1mZtVRS+nRCilZ+Qlg34wfmh38yGtoA5n/zyAGFL89jJT6BWKq7IKkmHhN7obqZ4Te
	h1WhNBEk8ws+13HKcUapUeVR6VJfIiZX8wTzWwiGHmnGJgF2vhIED4cEfcLfOT38Opp6u7rIe9B
	+E5SGnXyAEAPakPybh3uqSk7XtudHEF/OYYpUjUhAe17jEY0rNeat3kppNC65GrVpcFTzu9sYdV
	Vh4TRPGmyBXfpbachXibwnN1xfQ8TeyMvYTxNlqcWtgu5fSkFMhUz4UU4sxizHo4OrpUrWGrLMF
	tXWMqrCPBsn1r1fWVslMYegpqNzobhQb4SdONAsdBcQSpXXML7rHZ6Phuz8d0tvdxcWqo+
X-Received: by 2002:a05:7022:4193:b0:12d:de3f:d84e with SMTP id a92af1059eb24-1350494d102mr8420228c88.39.1779264005251;
        Wed, 20 May 2026 01:00:05 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm26136361c88.1.2026.05.20.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:00:04 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	cong.wang@bytedance.com,
	stable@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
Date: Wed, 20 May 2026 00:57:38 -0700
Message-ID: <20260520075736.3415676-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,bytedance.com,vger.kernel.org,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-289814-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 80E3458948B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the SIOCGIFHWADDR path, tap_ioctl() copies 16 bytes of an
uninitialised on-stack struct sockaddr_storage to userspace via
ifr_hwaddr, but netif_get_mac_address() only writes sa_family and
dev->addr_len (6 for Ethernet) bytes, leaving sa_data[6..13] uninitialised.

Those 8 trailing bytes leak kernel stack contents; SIOCGIFHWADDR on a
macvtap chardev returns kernel .text and direct-map pointers, defeating
KASLR.

Initialise ss at declaration.

Fixes: 3b23a32a6321 ("net: fix dev_ifsioc_locked() race condition")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index b8240737dc51..e1522101b9e4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -923,7 +923,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	unsigned int __user *up = argp;
 	unsigned short u;
 	int __user *sp = argp;
-	struct sockaddr_storage ss;
+	struct sockaddr_storage ss = {};
 	int s;
 	int ret;
 
-- 
2.43.0


