Return-Path: <netdev+bounces-261251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBajG3UNoGnbfQQAu9opvQ
	(envelope-from <netdev+bounces-261251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:08:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7521A323A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEC7B30993A6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C5396B9C;
	Thu, 26 Feb 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM6CiUii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B8395DBA
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096191; cv=none; b=hWG1k1ggjE3aViWIteP2ZA1z2mp7gw8STH8N22SIU6u5N/eCAEY7GeSIIT2QcpqxJy4bd3rapUcZW26f1Giljguwq5SHdDr1vqetq5GMPC6zxLPGkvOkJ0LNk9SrZ6Ei8YbDkA3ECui7TyV57LKFiLHzVOm982mWq9Ind1UUkaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096191; c=relaxed/simple;
	bh=yjujEF507FkM1LvRmeoa1lnj6VPSIxn7+rlLXsx2RIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfYgto4DYsvTQoWHAJaOpR0i3DHGAsGCgYpvsnissP5qprAWDUY9TKAZQ1ZJK2Q8W90L/FAQenADe5PAPzIoGd7QDV7KXnM9NtE+75tUBeCGWVEpnGL3+uH0uFYLwkpmi+3Sys//9yPvstuttSn9hOsnbei3sMI47T8KESaGSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM6CiUii; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a9296b3926so4684235ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 00:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772096189; x=1772700989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4C5I1Pt/wEGclaDi4K2UNhQ2nDAFpcehkeSkCYPJ+M=;
        b=CM6CiUiivWgCnTC2q4j6DiK0qOQDMYEC3ZHKHcs9H+8NycAlfyvkPEggOy3z/NqiG1
         HNQwqmQH3DlNUEv2vEhzwxtIuloXHFbW6S/ACCDopopNbPVO4khBjXSgRcYoUoaKA4RJ
         5nDO0SRpzRxKIKKZ5oSHpKpyoR2MKJpOuBjjOEz3exBNgTqfRPW7CXSHaLSMIckz1qaw
         W1AkP0xCwt/g3Japp84NpIlPhDfVLKMmHC4D6x7uW+62TA6cqwvnawFDU9x0f0WGuOF4
         tRqqJmma+SMy7Zs8lF71Pj0QWtAusmdX5rEYh9ag6ql5BtcHZdIfr6jguIHIrxZ8pZIA
         PUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772096189; x=1772700989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4C5I1Pt/wEGclaDi4K2UNhQ2nDAFpcehkeSkCYPJ+M=;
        b=SqebLudsHmFS65p/w5U7WwVs2C+6pPTtwqi2r+nWd396zqjnDAVWg7thQdgkSUv4zu
         lMAF5FJlsrfdpe/xm/0Xf+KaBvbOvUbJkRG+Sgg1QkMR9DbvB2P01SRJ39q6CdakNMcN
         Yr7DuyxDBU98u9lOMY07RH/f3jDJDG45WbBgry+OvleuQfwscYZ0vIa0FEuO/6dLi+Mm
         QZNXJoe4pFeTew/I45ylQryT5Ow+VQATGQ43nfom5FXU3UNZy1XdpalodWdQP9E3uuVQ
         7mC6cze1KyhXqN9kMO2YhXw7VXQfgQjsWGPmcVMMqXZNMlX2KQwXu+m+jmmP3CpWvcoD
         EPGA==
X-Gm-Message-State: AOJu0Yx5g39cGZP91dqpZV+K1DJBDL8M28of/THPtx/HnjIRNP6ADP/9
	l08g8S7G+PA0QjsV5nL3big/UGUnHVzSgYu3LMHE2ZTPlwJsSMtQci/i
X-Gm-Gg: ATEYQzxb8ZdEAfpXIZnTIrZTrJvKbl7C6Fdq0NGNFucbsG9flf439ly/eiQXKzxiL4P
	aZK52XioCS7FiwF+eqcYe6YfFhW1WfBKvYBzrhYAAkU4vGcCVOVxcxfz447CJnihNHFwNhxpmDD
	QUGuk6A8Hv/lapjQqJxwLiS3CFDe+XStA0+FVnkzj23Pz7zPlCMip3aXCPzbLjVeGcznZ7dGtF5
	AEFy+w9t2twDYh18ojQFxzsp8lEFpwxtrzCO5rJZLkaTSwxjkrE6bMlMj2+bq9/Qq3V8LHxKDA4
	o/Rsqpy1dQL60yCPeoU8/IjhrshJlkti+ZVSRTH8pOaidxsj7ZWKCWvEXiI9PCVrZLhmxj9j+SR
	FCSmiwVML0kcp9F2sgL4rB6LCVfJ6F6CYTCBgAAQmaunUwxj6Hqrmm+Kq6J23fZlCejfHhu5tro
	YmRVjlUQrjRTMqSaWigpPnIoTQUp8p5N+J4gDKJG2R9AbcA5czPtiekEzNjG6ODs7VXOgT
X-Received: by 2002:a17:902:e5ce:b0:2a9:62ce:1c0c with SMTP id d9443c01a7336-2ae0305f1bdmr16231495ad.6.1772096188631;
        Thu, 26 Feb 2026 00:56:28 -0800 (PST)
Received: from zeeshan-Standard-PC-Q35-ICH9-2009.. ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c7aesm2220020b3a.21.2026.02.26.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:56:28 -0800 (PST)
From: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
To: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Subject: [PATCH net v3] net: core: failover: fix NULL pointer dereference in failover_slave_register()
Date: Thu, 26 Feb 2026 13:56:01 +0500
Message-ID: <20260226085601.11343-1-zeeshanahmad022019@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261251-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zeeshanahmad022019@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E7521A323A
X-Rspamd-Action: no action

Smatch warns that 'fops' is dereferenced without a NULL check.
While other callbacks in this function properly check 'fops', the
rx_handler registration does not.

Consolidate the NULL check for 'fops' at the beginning of the function,
before it is first used in slave_pre_register(). This ensures 'fops' is
valid for the entire function scope and allows the removal of redundant
NULL checks later in the function, as suggested by Dan Carpenter.

Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
---
v3:
 - Move the fops NULL check to the top of the function before any 
   dereferences occur and remove subsequent redundant NULL checks, 
   as suggested by Dan Carpenter.
v2:
 - Target 'net' tree as this is a bug fix.
 - Change logic from an early return (v1) to WARN_ON_ONCE() and abort
   registration, as discussed with Simon Horman.

 net/core/failover.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/failover.c b/net/core/failover.c
index 2a140b3ea669..47e4a91dcaa6 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -59,7 +59,10 @@ static int failover_slave_register(struct net_device *slave_dev)
 	if (!failover_dev)
 		goto done;
 
-	if (fops && fops->slave_pre_register &&
+	if (WARN_ON_ONCE(!fops))
+		goto done;
+
+	if (fops->slave_pre_register &&
 	    fops->slave_pre_register(slave_dev, failover_dev))
 		goto done;
 
@@ -82,7 +85,7 @@ static int failover_slave_register(struct net_device *slave_dev)
 
 	slave_dev->priv_flags |= (IFF_FAILOVER_SLAVE | IFF_NO_ADDRCONF);
 
-	if (fops && fops->slave_register &&
+	if (fops->slave_register &&
 	    !fops->slave_register(slave_dev, failover_dev))
 		return NOTIFY_OK;
 
-- 
2.43.0


