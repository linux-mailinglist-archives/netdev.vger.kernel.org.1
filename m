Return-Path: <netdev+bounces-291493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJawNOL9FGp2SAcAu9opvQ
	(envelope-from <netdev+bounces-291493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:56:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBC75CF97D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA16E303EF4E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 01:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65D2DCF45;
	Tue, 26 May 2026 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6IcAIaX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C22765E2
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760316; cv=none; b=FfdIfqW2EermMZVp3HzNgmnmZ8QPVNvi8GP1wknHFgzaodWiv29pHkm0/jk3mG5cdl6Atdun7gOXA+vuW07DXR/EDtuX85wbECji0a+blHBM7SwMRMKSphGBlKFkA1wLtoWNXYxrd776babChg99BnZ9qviEggJ4y5BrZpOPWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760316; c=relaxed/simple;
	bh=RxnY4JC11X8DSEjOvMrQjaa9f2Dza/HlzMbii7abnBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fS2hMzFm0aBMklSflcoPnS5CoUT3/KxXXrxfDWyQCNGjkAxZdpaCMtR7IJeN/i7FBwJXcWfe9JrqXGZWyjqTLbJE+URe/3v9Rr9kwrTwbmjOXVxQ5MHSvW5+VJJ9VY7lVG+0daUB6gAy9tobR7lk6XX6CEDxxI2/SH4/kxRjzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6IcAIaX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82c84be9c3so4538330a12.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779760314; x=1780365114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ9RFiAHvu4O94FJFGKLOngXqWtdOke97nTnpQGm8/M=;
        b=Q6IcAIaXsjeVCh/gVRTpIRCBo0pUfJzo03uo0obUPR2Q3cLrPA3nNDuSAT+WxYIOPx
         jkVjmtQVJaJfaJxXz/DxCJf+EbskZZ7sJhSAmS5teTCnsPdJPqjbLI85cR7KZD5f1f5f
         oQihSd0jXsWdd//V7y8z9jn6ARD9XmDRJP/udMTY+vfmmgDfH2gFSYimUcNRpzEZZsPR
         PhgzRuf2++KslWOko/FZ+tb9VGbppqiGhWqfROegterRuiy/KbJkOre7a8vDhPW4Odiw
         dFk1xc63acYJLqiQp/xWzLHYFlSrOZe0QV7Sn0NlN2bpZzo9HSrz4fZtnlBpQdNObLsQ
         hR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779760314; x=1780365114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ9RFiAHvu4O94FJFGKLOngXqWtdOke97nTnpQGm8/M=;
        b=d3e1HzC3ICTCpxPPMWCK1i70NMDDH/jvkuiqsD3iZyBG1wY+zWn7NZFVK8FgFedAgx
         cXX0AUDyj5vQFw1XpfFIzgSfm+SBC45thHKi4Wcn2pXxFBF5Ky7KqXYJTWe/j/w6dv6I
         Rm2F2mLiFiXuNdcTWKhmRqf29J5KvOVvV2OW1QGCc8EdZc2avOpoFc9tk9APPWdBP9Dt
         jU5Su+jqGhyhPkCEiuxAb1w+DWnHihlR8D7eKUr4Xs2Lc//NAAeTlSFaZ53PHSRZwDCm
         UsKmBpq+a0mXl0A3PLcAYGYLDpYFRlDoWtm81ACBU7t1GgJJGmCjCVQtMZqKtygp8JRl
         aoRg==
X-Forwarded-Encrypted: i=1; AFNElJ+44vfh+fNKNlbXVY5/EzjgPEWHNB/JbHFbJJbc4gH+mvr6h607Oyn6RSbjBt4sf/ENVrwOFP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Wp+0uCqQT9em2/C1KjuahBGPEvtmzjyvMs3JlwkwCUXEESQQ
	CNHEFIa3UwWzGqWzlrgvPlvYFAjknVqrkKZwf0VfIwVYjv7QIX9gSW8F5jNV+Js2wEXeHxqNA6l
	fVOrRIw==
X-Received: from pfjj20.prod.google.com ([2002:a05:6a00:2354:b0:83f:64bd:2fb0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:189e:b0:82c:d6d3:3190
 with SMTP id d2e1a72fcca58-8415f363760mr15947512b3a.38.1779760314257; Mon, 25
 May 2026 18:51:54 -0700 (PDT)
Date: Tue, 26 May 2026 01:51:13 +0000
In-Reply-To: <20260526015152.2409183-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526015152.2409183-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526015152.2409183-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 1/5] geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291493-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3EBC75CF97D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

geneve_nl2info() calls ipv6_addr_type() to check if the remote
IPv6 address is link-local.

Then, it also calls ipv6_addr_is_multicast() for the same address.

Let's not call ipv6_addr_is_multicast() and reuse ipv6_addr_type().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


