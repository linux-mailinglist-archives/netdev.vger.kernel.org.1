Return-Path: <netdev+bounces-291220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMf5HjyVE2oqDwcAu9opvQ
	(envelope-from <netdev+bounces-291220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:18:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ECA5C4FFA
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41D58300A4FD
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD818871F;
	Mon, 25 May 2026 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzenIXAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C73438B5
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779668274; cv=none; b=CgO+HROPFcaObslQ9sI1xvaUdXdF60PdZPO7RbJrUuw262Qn8iLvhaNE+5ueV0iIU0FSXTdJdHZQAKI0o3st3RTLWKVFj6Tclko8/Z5BjsFT7YIqdEZE4hvTGS1zwjxufHihr6ymu6+eg165k3CDsK/acEd9282lwkmv/yYuDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779668274; c=relaxed/simple;
	bh=curlzGWDR8u/+E+K0BhIq/Zslz9SzWezrZxK+1d4+bQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ctI4qJ5jKH3TWYGLElLy9VBGIClau3Vr/Y+2NWG3QNZUhnDdCDXXvxK3PrwX9npUedh2/8YAhatj8RpyWL8iV9571kFfmTO6o9YOV8phd3EfRPoSeHfRfuYk1El6UmbaGVtLPQ1ld4JN0x7ACLOTesFNQch577sU1SjID8bX+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzenIXAw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so91909165ad.3
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 17:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779668272; x=1780273072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+fPji2+1+UibOtvILNoe3MVmA4rKbaHFCgjwxAKoqA=;
        b=VzenIXAwObnbkeTRZU4R6cpC+n9Fr2IUOXji8f0dYJ7+F9WVN9OakEWD4mzE/Q+S3B
         CQzeC2pi9eUAwFFEkiO7HesG34wPbarhhKBORpjxRW5hvTc0b4DNngSXmnY8WoG6h7o7
         23ftEEFyn/5m5fo0Wo3TkX94IhzJcDZlGQ8zaLHPzlomRPRffN9HAw/YtgaIZ0I51KQW
         3TWnGKe+4an+DtCITAiA3pHx+SnuOr8HYNfc5erE5cnYg5hA4rP/MPq2QFr5cH/0tffU
         DmKfemNjPEFOOrIa6TB5ckTrlnpkNpGVwTKzIWVOLXcj4nqt01FLiOH6X2VHDG3u8n0L
         ssNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779668272; x=1780273072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+fPji2+1+UibOtvILNoe3MVmA4rKbaHFCgjwxAKoqA=;
        b=mHjkogsiGlCtrSZNDxZdoGIeXFuEg9HtOQKuPn/vjR6wyNPHW50Z4OlbrTbuvU+P5s
         Pxo/iXujr7DhcZ6VdRHVDZBehF5lHc50N1o4pnLA7UbesAxTxDeM/Qj3f06Karhxjf6t
         U1smYV5hvL9GBAhRkYwQYLR2LY1tSQgB5hmPLDaPKpw/Vi7kio6Xiohb7nSqGVZsgpyK
         R9C3PiDC4sqNyI/62RYZYCuTwe/awOSDVfQ0Wv5LAlG2o+6wB3BqswKgMpxoFJfjHiWO
         n/485mmMz254vcwUMRF6aewoiY3W/2y3kP2UbKvA3ETJD4cZPvSnagDyWuPNMdCq6Hat
         3jcw==
X-Forwarded-Encrypted: i=1; AFNElJ8qxQ/k/1zSZESy+/i+CAFeKhZByEoYppaBKXA4IVk2dCSkInioYd1aHuLpWHs3aE8sjB+erSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbDsBTXWlPLarY7MAUUCWSU97S6e5lO7eP8EytUmGtkx/Q9OK
	onOmWEd9tbrAYsHsOiLwe9pErUEHNC3LGkDME3hLC70AvK5QKnl87iaiDNYz2BTebCS8BW+2rwS
	BYte4aQ==
X-Received: from plbkd12.prod.google.com ([2002:a17:903:13cc:b0:2bc:f6e4:bcb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0e:b0:2bd:ba87:40a1
 with SMTP id d9443c01a7336-2beb07ffc75mr134370635ad.29.1779668272036; Sun, 24
 May 2026 17:17:52 -0700 (PDT)
Date: Mon, 25 May 2026 00:17:19 +0000
In-Reply-To: <20260525001745.1251640-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525001745.1251640-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525001745.1251640-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/5] geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291220-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F0ECA5C4FFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

geneve_nl2info() calls ipv6_addr_type() to check if the remote
IPv6 address is link-local.

Then, it also calls ipv6_addr_is_multicast() for the same address.

Let's not call ipv6_addr_is_multicast() and reuse ipv6_addr_type().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Move addr_type to if-block for CONFIG_IPV6=n
---
 drivers/net/geneve.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index e8ff03ed87dc..8413c21fee6f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1924,6 +1924,8 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 
 	if (data[IFLA_GENEVE_REMOTE6]) {
 #if IS_ENABLED(CONFIG_IPV6)
+		int addr_type;
+
 		if (changelink && (ip_tunnel_info_af(info) == AF_INET)) {
 			attrtype = IFLA_GENEVE_REMOTE6;
 			goto change_notsup;
@@ -1933,13 +1935,13 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		info->key.u.ipv6.dst =
 			nla_get_in6_addr(data[IFLA_GENEVE_REMOTE6]);
 
-		if (ipv6_addr_type(&info->key.u.ipv6.dst) &
-		    IPV6_ADDR_LINKLOCAL) {
+		addr_type = ipv6_addr_type(&info->key.u.ipv6.dst);
+		if (addr_type & IPV6_ADDR_LINKLOCAL) {
 			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_REMOTE6],
 					    "Remote IPv6 address cannot be link-local");
 			return -EINVAL;
 		}
-		if (ipv6_addr_is_multicast(&info->key.u.ipv6.dst)) {
+		if (addr_type & IPV6_ADDR_MULTICAST) {
 			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_REMOTE6],
 					    "Remote IPv6 address cannot be Multicast");
 			return -EINVAL;
-- 
2.54.0.746.g67dd491aae-goog


