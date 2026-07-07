Return-Path: <netdev+bounces-305512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yD3kOU8aTWqPvAEAu9opvQ
	(envelope-from <netdev+bounces-305512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:25:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7648671D3B3
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:25:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dNVVhTgK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305512-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305512-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D6733013EDA
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D609337A4BA;
	Tue,  7 Jul 2026 15:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82091378806
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 15:11:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437104; cv=none; b=VupUhfPgbCRmOWDBEtQZT2jhj7nOjxwelhhT4HXG/0/mfErcEiTc7RB2x/0W6eXYDunfrYK0nTqGcfwIP4VtU7fWK4lzmW124WUZ1r6sgqb8sV45NxL28RioJYA/fXRCIimuZhnhW5QMZ4A5H2gC6YHadroXk0o/FB4M6fJsP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437104; c=relaxed/simple;
	bh=/eMyLhMtgOhVToRnc/6PZd+yHvWgmaLfJt5C/QgKH2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KWaCNJthCK38GcbaoBXuL2dQvcZJp7Y+ecR8XGCKi+6K0ieCJHjIzuWx93i9qCM8Sy3m6gFlNI/GL/buvjY+PTWpmMKowih4krwgYvhhCOTdDa/9olSPs2HxPLeVaf2FGQvBBqAWfDf6b+C8juPUlXOw6y9CAU4ZlP9sILwaw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNVVhTgK; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-847a69ba83dso3459070b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437103; x=1784041903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPT2PsJ2NgQIq8sAETDfZXCdfC0YIlSwd/aNYXHd3Ys=;
        b=dNVVhTgK9CIMfFQOM9YRPwl7/ErEtPc0AKmXDa2HNv5cSm4kko5hij3rAfIV0Log5u
         hnpWlc7Ajyo71vt7AnkKmRKs331VNiQFcx2yw919tAO05CPyQ8ApTnAq1qseDXspQxk+
         tJmN/qp7QenxO556pNSAfpMb+pwPvlKG8WQupm8Uq/mxPI6xSXKlFQYjXNCXRkgjdqGj
         3WLmzVExxXdAXn0Y8wVzOVs0R2a41VcwUrhXHbgB1uvMzqQwavu9hBC1qVGGctxxJbHo
         t5n1n7iXQxT8cJ8/iipr2kB3pnbSNm/930nfRVCgDqhWgknxBKESjxyJl05mYGLJnHT0
         fmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437103; x=1784041903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPT2PsJ2NgQIq8sAETDfZXCdfC0YIlSwd/aNYXHd3Ys=;
        b=mI56UHvQJ0fx31pyrjWlX1CZZqwNlyuCnoo7ZXbG0DT5+qDau6tV13UtbRFNnwUdDJ
         ru8wpHxlDwt1EnWG+hSLi+OECykU+5+MZP4M/vUiHqGwZVnGqqj7H+fV+m++J51UKCPH
         aQlYWKxM19JA8ZY4xVebaD9HScmvc+dAuM2lZ975U8W/6U8I7qqlthlnRwLAONE2rYax
         dW2c4EVPKf5rht2oPKlM8sI6gyP4Gczt7pzT6f8VaMiZHUtKRol6kU0NR7Qokp6grLek
         ICAbtmHtovvFtqvgICMMxzEDIy16Td90Vk3bbaEex3zMIrrB33VWbboEPhpA/c5h+Rxa
         HdRA==
X-Gm-Message-State: AOJu0YyQtIXKHgg7CF48bdkkMoMsXL8dqqjMOnY0uRoFxi3Yq/FqujMY
	dONrzMHKFAHRFh1Sa3fFJ70Y1I76+cD1S/MNQhrAzTaGIidlJA0zZQ61
X-Gm-Gg: AfdE7cnnJd1nkcZybcd0H3krWNvk25bkuyHONsUz4M6RGQVTvY+XmHLUnH/1jShXxsH
	KHFFmKP+i9GPYl8SjBeoSFCdOSFvQqaX0NSb+hBt8l2sz8z/F6WyiOK5AFJGL2ATLMND1xpAMGH
	teQ12rMxR2pJKitSnk/y9ZP8i1FdOx5JAJoRv0IBMYLMnJqUlQL+eplHh5WY1TPsSxuFmdI28GL
	+jclYGrmZD92XrSENkYePIZPpX5Zf2MOQLH8TK9BSyNx3Aq2U44ZMFHzm5BssC+IzFmJO/zNTh/
	MdIRLsQct0+xRkOFM6h+sBNdReMQKds+kX1M6C5n9Npp0AWdDAG5hHNNHqyM66ecexu7VWcfFQF
	W0U6kqeW6BUlOnBV+NGMSEBwMF6EfAOYIMYZ8QQtOuRGVhrNuLq+5ePxLTG4nBcvQG6o5TLe9nE
	7ZEvUhYof6KVUpmjCK2diCzyAGERC5/w==
X-Received: by 2002:a05:6a00:9085:b0:845:e8f3:bdd0 with SMTP id d2e1a72fcca58-84826d1cc52mr5550329b3a.33.1783437102811;
        Tue, 07 Jul 2026 08:11:42 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.148.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6162esm5756047b3a.11.2026.07.07.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:11:41 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2] tipc: fix u16 MTU truncation in media and bearer MTU validation
Date: Tue,  7 Jul 2026 11:11:26 -0400
Message-ID: <20260707151126.3412-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305512-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,microsoft.com,linux.microsoft.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:blbllhy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7648671D3B3

Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied MTU
values but only enforce a minimum bound, not a maximum. When a user sets
the MTU to a value exceeding U16_MAX (65535), it passes validation but
is silently truncated when assigned to u16 fields l->mtu and
l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
truncate to 0, causing a division by zero in tipc_link_set_queue_limits()
which computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing
values (e.g. 65537-131071) produce small incorrect MTU values, resulting
in link malfunction behaviors.

Crash stack (triggered as unprivileged user via user namespace):

  tipc_link_set_queue_limits  net/tipc/link.c:2531
  tipc_link_create            net/tipc/link.c:520
  tipc_node_check_dest        net/tipc/node.c:1279
  tipc_disc_rcv               net/tipc/discover.c:252
  tipc_rcv                    net/tipc/node.c:2129
  tipc_udp_recv               net/tipc/udp_media.c:392

Two independent paths lack the upper bound check:
1. tipc_udp_mtu_bad() -- called from __tipc_nl_media_set() (MEDIA_SET)
2. inline check in __tipc_nl_bearer_set() at bearer.c:1160 (BEARER_SET)

Fix both by rejecting MTU values above U16_MAX.

Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2: Solved format issue

 net/tipc/bearer.c    | 6 ++++++
 net/tipc/udp_media.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e..0926692dd 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1163,6 +1163,12 @@ int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
 					       "MTU value is out-of-range");
 				return -EINVAL;
 			}
+			if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) >
+			    U16_MAX) {
+				NL_SET_ERR_MSG(info->extack,
+					       "MTU value is out-of-range");
+				return -EINVAL;
+			}
 			b->mtu = nla_get_u32(props[TIPC_NLA_PROP_MTU]);
 			tipc_node_apply_property(net, b, TIPC_NLA_PROP_MTU);
 #endif
diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h
index e7455cc73..0d62a57c8 100644
--- a/net/tipc/udp_media.h
+++ b/net/tipc/udp_media.h
@@ -48,6 +48,11 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb);
 /* check if configured MTU is too low for tipc headers */
 static inline bool tipc_udp_mtu_bad(u32 mtu)
 {
+	if (mtu > U16_MAX) {
+		pr_warn("MTU too large for tipc bearer\n");
+		return true;
+	}
+
 	if (mtu >= (TIPC_MIN_BEARER_MTU + sizeof(struct iphdr) +
 	    sizeof(struct udphdr)))
 		return false;
-- 
2.53.0


