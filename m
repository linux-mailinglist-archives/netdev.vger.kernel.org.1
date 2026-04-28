Return-Path: <netdev+bounces-281891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPvKOe268GmFXwEAu9opvQ
	(envelope-from <netdev+bounces-281891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:49:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4835C4863DF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEBA32DC863
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09F3AEF29;
	Tue, 28 Apr 2026 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwpbGlKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE627E1DC
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383766; cv=none; b=SM5iHdWdUHWvu56w1+dzkYzqCd86TTwJtWnipVya92XWPwlgKvSWAspzxd5yncHdNCKjtlZZ5/6DUqH6B6f1qbxmn0lTyBVol2Zj0pLk9YSIUaKba1uhUHAcT1UGbLNZCs2bv20kUWJK1yQ7QCIlhQxCRmr097+pLGh7h3rJE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383766; c=relaxed/simple;
	bh=3fTJZcmes/th6YUY+hR5wNK8VA/ILbEaybzo8AGKjK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLDszsBzkiFEuDA3H2rO0+MGX/x/mCQ5nRmsE6I/s2ODldXtfYCDAbPfbzHHbJPRj7YAcNK+sCo4cVuzES9yxwAxRrJ9PkL8zI9X1XyhO5x8WYnL+LiJrxDCxIcrp3QXpG2tMQBQ5qnjCfi9OcQKWLkiIaffZCGxIFvkCHZdbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwpbGlKl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so105150745e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777383761; x=1777988561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJADsQL6+j0VWedbBviJoQt3A3fje4Hd8xa4kVveAGQ=;
        b=gwpbGlKllUIfflZgiqn36LzIWT8Vnybuj5rrMdNW6666t0q5BqkwfBoj/WDmDsFfGF
         +LjU6yaU2C/mDaYvwI15fNzdzPDqrBxt69bOQ0kgnSloIUrSChpDMkM3FXDu0Yr/qm1f
         X+GRj0ai2Je3KOQjzyDr0JmrNiIyLMnMvPfmk9d9UYC6v5ompKdxGMyWY6oqYu7Osiho
         LhUfjN0TjMAEaK7I9vfRYueYMuDMnBE9H0zqdIqQ1BizpcXFGKrsLEcMI3HmttSTofs0
         90gtnFiOQ2x+yQDbE0IohKdKH2l5YNzMQ+UVwDjKz9UROWBkK2sDszwlfGRNEt090xOw
         rn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383761; x=1777988561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJADsQL6+j0VWedbBviJoQt3A3fje4Hd8xa4kVveAGQ=;
        b=S5KEGQDMbj3RYZCU0IxmclCsNsJ5MtH0x+EOWyENimJLbdmPh8h7VUIMoi3jrLe6wF
         P6l91Wqmjvk+WXouigjvHRO/f3OyE+8EwlBEWB3E2nhR3xp80RJXPoOPx6b2hRwjpaL3
         debJzdOV5eRmAZBch0W9Jn+Pyo5CdT74RhWKVJYj2ZMaNMDWNml5uIpmSIIGUXbl299a
         5SypMuuCR012n8sT0VCg01/5mPqFnDqv9l+vOe4l+Le8wqKEzdvWRcOaixLASzUIX/h+
         bZ8/4EsnGI570ZPVcYEFxexjXeeGlwFoXmSh2cOwRZOI3dZzE4lwH0+a8VdXVR9TMAV5
         OcNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2gmXn0cDImk3fz6EwtE0XhkvAnTzpsj7om9uL3lRZJbhhHol90KbWrz0q6g4KT/CZFv3QubE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPk2OAvtf5+9GjVs89nSWH/2wwfVvqvE3xrxuKzPflji333kn7
	5v6BS9MnlDMfZ2vF1/Vhvi1vx9f9Vbvud0dXQfTZghLdba/wb9MWizOX
X-Gm-Gg: AeBDietQlOJGq8lDMNSXrNBZs/0pfM4GUPxsD5aUE/McgJeQLxWUu9IPWd0N1M8nqXo
	F8KVBX8Q0+qFrCKUzd+pNuSmW385OP6GR9UAa+8OJWPns5IfuRACywtjURkgIIwmJnQQ/xJWAUk
	/kvCmRv+DWHOlGLy+NI7JbADX2tc6isUKcuifdQePMD+Mq0KirDWbj+d5zCWHV7JCiF2etWl2A5
	hxMlSe5v3D8XxRJ7q9LXxq3/4j6OcV7WK15l51EkY8jc6+hVdQ5X9TbsNxUCMoEgwLQXGPE7HZ7
	Ktq4Ue1BYP9mNTtU19uaZDOO9/pJUULZ5PO3bfQ6ExlkRWm6GzV3XibDNswj4Lt/px1+BMdLviE
	USSNNmY+DAme5RWXM7CJtOI0535bd+CPjoHU4ONkEg4LCmJESsq7x9yFpJDH9OQtKXq+dKuyu7U
	5yIurCfxBNuUKqqJX+Q9dlWmBLmGn4xwa7YMTU73Prezr7R4kl1aZwpCgeVaqdtaGVuOKGRB86M
	K2Gn/5H7bdXRq20wF3/
X-Received: by 2002:a05:600c:19d3:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-48a77b240aamr52281015e9.22.1777383761006;
        Tue, 28 Apr 2026 06:42:41 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-205-63.cust.vodafonedsl.it. [2.37.205.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77aeb47csm51114445e9.1.2026.04.28.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:42:39 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
Subject: [PATCH] net: sunrpc: fix slab-out-of-bounds read in cache_seq_start_rcu
Date: Tue, 28 Apr 2026 15:42:24 +0200
Message-ID: <20260428134230.136533-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4835C4863DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281891-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessandrozanni87@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,60cfa08822470bbebe44];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]

Syzbot reported slab-out-of-bounds read in cache_seq_start_rcu().

The issue happens in function __cache_seq_start() when is invoked
hlist_for_each_entry_rcu() and the hash value is greater than the
hash_size.

This fix verifies that the hash index is within the hash_size value
before dereferencing the hash table: if the hash index is out of
bounds return NULL, otherwise access the value.

Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection rather than the r/w spinlock")
Reported-by: syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60cfa08822470bbebe44
Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 net/sunrpc/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 7081c1214e6c..aac5f03112f5 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1348,6 +1348,9 @@ static void *__cache_seq_start(struct seq_file *m, loff_t *pos)
 	hash = n >> 32;
 	entry = n & ((1LL<<32) - 1);
 
+	if (hash >= cd->hash_size)
+		return NULL;
+
 	hlist_for_each_entry_rcu(ch, &cd->hash_table[hash], cache_list)
 		if (!entry--)
 			return ch;
-- 
2.47.3


