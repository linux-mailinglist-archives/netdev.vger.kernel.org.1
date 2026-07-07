Return-Path: <netdev+bounces-305274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pWmwJPiATGrElQEAu9opvQ
	(envelope-from <netdev+bounces-305274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 06:30:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC347717400
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 06:30:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ntYWJ1A5;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305274-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305274-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0E5302F3AD
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 04:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB3A2BE035;
	Tue,  7 Jul 2026 04:30:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19D42086A
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 04:30:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398645; cv=none; b=AsUkWzImqb5aQ9SUfzmuVjw1ZPLD7HXPqaOFCmfrq980R7AKRsqmCxcDAvRl6yYX9EILSq/4nct1epDP+y/RAEFybiaOt9QzdqqXmvCvTjr6j37of8u6R519yLLlqo2TM4rqQSNpfEVVawP0Luz49uGRpCjmlEt/CL1JfjW7r28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398645; c=relaxed/simple;
	bh=M2hWQFzhSKgrdKI6qiemtu4JnDynZZgc1Roe2FLVgwE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LV3dZF8qHfY9256sOXq6SGnoTakyoF8uXgV62PXXH/YcfWzDOUN7/l5yODW0o6Awqll5zXR9TbOn//DmZebfTo56qwHxzDMLzRGozIAUcUb/R7WiYqHdDAhCB8aY2pNSCcRYFLITIII7IjNnLNNl1ansLnW9tlTSH40quck6UB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ntYWJ1A5; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7f385887bso57278025ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 21:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783398644; x=1784003444; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGoxbQSfVWHXD3Qk6QxK4PGiP7s64rwM9sU/cWIRVkM=;
        b=ntYWJ1A5rDdk27egIHys6oN9wm4rlbcsopa9cTWX2My9n5YrYx6jUlyDXekJE0W/CE
         cH34g8XdsAkM7bwqA/aHX8I8RO8iMCur6TvUlvZFfpakyQ5eVH4dXQTgCqPc3Lzc0V/e
         azRzv92BJ9NkpGnFwGY2alBFSaNK8a3K96N6NLAqMvkCgU9Gmr0NZ2a4+0xkKUM/Z9dD
         Jbn0dlPBQ01PHIbxpskccBxq8eXELf+NK8lYmsLnTzxgbj+XTCfT3XpafceR6Oo58u84
         Hs4Yj0hvbujSORCYQGUsLiJ2BTfzhIsds1QB1nlTqtV1ufjiU98QrZ6L80K/4vD4TO9k
         XM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783398644; x=1784003444;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGoxbQSfVWHXD3Qk6QxK4PGiP7s64rwM9sU/cWIRVkM=;
        b=Fj1Lyd8J1cO9VydTvDdVMWegWS+yTNkv/1lRtoMDadINA3niBKj7uUMosUb5s+jsSy
         dnxoZZ9CNtSUwpKpFecbFtmCT6O45eW4eD+Qy+BchFeLbPywD5IdAspWOeqnNF1ygH1X
         NQlId4sxTUyBLpjV/NVhAgTF04uKyB0ZqnMJToziAt2K2jJiDwq1Uu3N3V9rBN3QcMoy
         SKgyOijK/BV+Lwq5Dehqn4F5qjfQtRS+ufLhumjqpeiAufdn7AM75yT187IWmy1FW1ts
         pcHc/OVIhNM40uGudArWX8IJYQxfeK3HbdZQOKI+gUbQboCFOin8cKLtfPH/CIjA2i7/
         BnUw==
X-Forwarded-Encrypted: i=1; AHgh+RokUnDxW4M/ZGIzaVCnmgoikFa1mvqZz/Y1JjHS7RUrSEyKd0tvB8CEnbUDnlLGeVJyIoiIAUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hjubUJBDMwGm1vAgEOChKTM2DXsNF4QBaQoaaZ0YP5sB9yfM
	PQ2itXD+B3Z0g9sab/DrcfxYDlCVnJrYRkAHRwZqP+CbXw+gx0IGlBbNMwnyahXl3M9KV+GwOxU
	gB4T6E25U9WrL/rt6Wb/l2DfWbQ==
X-Received: from pllj7.prod.google.com ([2002:a17:902:7587:b0:2c9:a23b:b02c])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d490:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2ccbe7224c4mr34291765ad.14.1783398643713;
 Mon, 06 Jul 2026 21:30:43 -0700 (PDT)
Date: Tue,  7 Jul 2026 13:30:39 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707043039.101983-1-yuyanghuang@google.com>
Subject: [PATCH net-next] net: ipv4: clear dev->ip_ptr before destroying inetdev
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305274-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC347717400

To prevent RCU readers from accessing a partially destroyed in_device,
clear dev->ip_ptr early in inetdev_destroy() before freeing the
multicast list and individual IP addresses. This aligns the IPv4 teardown
sequence with the IPv6 implementation.

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 net/ipv4/devinet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a35b72662e43..3b31f4bec30e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -322,6 +322,8 @@ static void inetdev_destroy(struct in_device *in_dev)
 
 	in_dev->dead = 1;
 
+	RCU_INIT_POINTER(dev->ip_ptr, NULL);
+
 	ip_mc_destroy_dev(in_dev);
 
 	while ((ifa = rtnl_dereference(in_dev->ifa_list)) != NULL) {
@@ -329,8 +331,6 @@ static void inetdev_destroy(struct in_device *in_dev)
 		inet_free_ifa(ifa);
 	}
 
-	RCU_INIT_POINTER(dev->ip_ptr, NULL);
-
 	devinet_sysctl_unregister(in_dev);
 	neigh_parms_release(&arp_tbl, in_dev->arp_parms);
 	arp_ifdown(dev);
-- 
2.55.0.795.g602f6c329a-goog


