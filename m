Return-Path: <netdev+bounces-287959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG9EHGrJBWqFbQIAu9opvQ
	(envelope-from <netdev+bounces-287959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:08:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C05421F6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA4863018AD3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577327F75C;
	Thu, 14 May 2026 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvO4U9Qq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC922083
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764135; cv=none; b=Y+GHrKR1T7Z3Hej1kLKI3UVLSeaotPp5pwAUGyrnbzbKMZyD7kTnV0v8Ac4iRe0/Ki5PxOO2pBrFwUtgC/AK3cOZ3nyyKT5OKvAujmYXoLVvcUKKkk5hu1M4KbT+Ph7c3xbRxN9HYuJF2+tKmN60f8trfmScjMe9TisLYzSxUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764135; c=relaxed/simple;
	bh=z+cAkSuJLhE40c0uEq+6x0YaX2J65ezf/wP88bR/sCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ta/XSYB2ZT108BBzXwHU7X3tIPWJHQZBOcd+13mqPuDk2+VS+9EyMJXqs4MZpqWDUu4WSHhBIF1e5hAy4ejKKKvDjS8TXWVm/jcgEjvQ646b6azBrmPGq3ABknkP30mDYIwiWAK0T5s09SPaEF9LUsMAUD1BGCnZFsGTzl0X5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvO4U9Qq; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1330d6bb78dso4686683c88.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778764133; x=1779368933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0FKlHSR2yB25EroVOVzDhJO/vm7mF/0/3x30QlYGog=;
        b=BvO4U9QqBWC8eCi63jOJbvcIShXzv1c1z5bQsQxIHxKakbPLVbG/XOmS4dVOHO5JXV
         kVQ8oDaqioqe2g9GyWyrt9Z/145honCeyOCRhc+4ZkzE3xXiZJd1PMt3a5+J/NTjoufE
         tVkK//2UmjwyRRlDBlzv13ZBn+23VbQV3mznFGxHRCE7Xm55QpuwiKKUS+4mjL1N+I9U
         8xV1ck2B42YiMTsSjJB7DLke4ZIoKJpsS2dLy0KWssjujZeBP160RiTsA0mfJ4rWBjLX
         JEMZ+LDPNRnSdG2bsTUNqY31sDT2e8OYR8Z9fm1q6iCEn/k3YavlCHAbdORPWkjyBrxH
         Eu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778764133; x=1779368933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0FKlHSR2yB25EroVOVzDhJO/vm7mF/0/3x30QlYGog=;
        b=kwfus/hPxcokiRx2/26FgNCsyAaZlblC1x3s9VHI1t6223UG0u8u7O5Tb6gRKhMPDP
         QBJzsMtyzaxIpbP9Gy80gcfn+zy/vttgGaRfkgx8fqqNB/9rIKw59OfHaiZ5EUBJURrR
         jzoVqtsU1OEZPe/xzURqevEYzPiRstSot0JnaFkye3bJrs+vwTI8TOL9YZQk7EQVFC8J
         zNb7vcWSSM6e7Q7hRgOwGJgLFfg6Okq3wcldpeuSdgnLvswPRQK4xkahBsvy3PuKWTTH
         I9baokVju9WmAc5pUtKFYkNlAAHmlizUw3Bz+PDHEyk15hC0Drm8vRucPnD/LBM7h9OB
         hGYg==
X-Forwarded-Encrypted: i=1; AFNElJ/gL8teul+NYjubAC3Cg09QavXUi41LFRHAipGZBJOBlSiAWqu4DHcD7mnD39K3iK276NxaeMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrgolgpoZNHcLKp3wObgrtw3EZKU1Tv0YjCEGZ1A332EXlYBV
	1/jTzwu3G1VZiIYJSFuOvABrQx7nATt/Y7oqG/1eZbY41RcwNKn4v2/IhzlsNuxoG7I=
X-Gm-Gg: Acq92OH6Bkeg/HL17EOQsuoL27Xctqgp2pWZEbmDgwElRiAKLNu1KPiht0Cf1J+vUwR
	vp6ZHjnZZSaw+7o1OvPplWErHaMB7tZ28mdK2/MRpepeiRP7SKpisiKRAqoT7tSjtZhDrG2XPQd
	b/Z7aLAKT+wvpCJU4CS2zkmFb3FXZJDQdfe7jdWZGZJq7FW2V6tqTRUYCRpxNT8h4CFhC/8heZd
	F8fXJleOCvK5OG0lz3u8CPYvh7MPMZa3SRxXnwof1pWzAWvcZpJklBixRic6Oqej0BSvpaVTIYe
	raDwWhcxra1fTAKOXx7llKNkFSlhg3F8y9BPbNNuX5jNlpc0JLz9VzByeAa7Ybz2FEOTt3DFyfi
	EUOc72xD9I/aAWeR/Yxm+jfHkMFBUWh2mxJZvbU2XyxgUflBOl/HATuboQ+kN9CcTIsLuGUEUcQ
	a7fQ3qVk7Qqd71Z8S1ElDqmRt4KC/+6XHFZxZaXbc01peW4payuKSep8SENUEf9ddJ2VHuHbvDG
	ZPo7YEJfA==
X-Received: by 2002:a05:7022:f008:b0:12a:71ab:8235 with SMTP id a92af1059eb24-1342ee39d21mr4686283c88.6.1778764132725;
        Thu, 14 May 2026 06:08:52 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm4389502c88.9.2026.05.14.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:08:51 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] net: appletalk: fix NULL pointer dereference in aarp_send_ddp()
Date: Thu, 14 May 2026 05:38:08 -0700
Message-ID: <20260514123806.3085961-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB5C05421F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287959-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.783];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

aarp_send_ddp() calls atalk_find_dev_addr(dev) in the LocalTalk fast
path without checking for NULL. When the device has no AppleTalk
interface configured (dev->atalk_ptr == NULL), this leads to a NULL
pointer dereference at the at->s_net access.

 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:aarp_send_ddp (net/appletalk/aarp.c:552 (discriminator 2))
 Call Trace:
  <TASK>
  atalk_sendmsg (net/appletalk/ddp.c:1715)
  __sys_sendto (net/socket.c:2265 (discriminator 1))
  __x64_sys_sendto (net/socket.c:2272)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Add a NULL check consistent with the other callers of
atalk_find_dev_addr().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Claude:claude-opus-4-7
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/appletalk/aarp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index e7315c01a299..30493ea3c010 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -542,6 +542,11 @@ int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 		struct ddpehdr *ddp = (struct ddpehdr *)skb->data;
 		int ft = 2;
 
+		if (!at) {
+			kfree_skb(skb);
+			return NET_XMIT_DROP;
+		}
+
 		/*
 		 * Compressible ?
 		 *
-- 
2.43.0


