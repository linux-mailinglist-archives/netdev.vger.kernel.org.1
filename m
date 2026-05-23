Return-Path: <netdev+bounces-291045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E1CH2ZGEWqUjQYAu9opvQ
	(envelope-from <netdev+bounces-291045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:17:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE95BD67D
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7E1301982C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E120932E757;
	Sat, 23 May 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6XhAngQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D33026290
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779517019; cv=none; b=lEJgQvt8DitMBDQkBZwRZAd/kMru9KvDzCenigy5zuzvmqGR9mpzphTk4sUdvY+wkz7twea8OdWc61lxqYH5fom+ZG9QhCcdqPA3XNp/gYioi7onZUaMsLPGsc7Soiq8r0eMEWYXgMljirjHdwgF4DhIe+aeUK3DMQC5LCbLkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779517019; c=relaxed/simple;
	bh=ZhlhR6rshxs5qqLII4zGL3LS3kkye7X+F7cqNaymDWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PfZtnyl4R0h7y8imys91Slul4nYEE5za0qPXkGULffEM7dJAHmhpDIS5ELBqwjkB5TccQ2zPpejKKo1GMEV6ra1LAfpRYJv286j29+aIoQ0dYsK+/CVn4U/TYdBHDyzy1L4ifSTZocAtvmvtpwZCL+t2a9PsXmUYTs3YaSmIDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A6XhAngQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c827bda3052so11648344a12.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779517018; x=1780121818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpKypp/GLg3N03nkT2RIa2qeVOfma2k23brRAcI82SQ=;
        b=A6XhAngQ8XC4CHquyOW4GZWEJCcDSeTswJu5KRRDdd1uL+fbLug9RhiUn1cDWcj9Jn
         hsEjqj3NcP/CtHha06krbqUNLyL679zCtmPfIrwQu7qRHyUgae1cvrsoh+tN3Ulwhtwz
         E04lEUT7KsJmke6yqEt1t00r7Yy/OzOR3HGvYdLx9QuS4XAVjgiD04CFiwso2oXajuP3
         oBR4sOw13443qGtOH5vwzXlNXINzBrJ0+jUjTCgT/4klYTKpEjg38KW+GwIxV7zPPQ0H
         wIO38EFQ97xxK+avUUmDO9uuZ6yXxVCFof4NwqCebu3ohFA6mpgoB9PE4+i/M7Jx4FRA
         oFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779517018; x=1780121818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpKypp/GLg3N03nkT2RIa2qeVOfma2k23brRAcI82SQ=;
        b=SWcz/VeHPciP7hgwRzrQLzoW0+TigXlmY5aDtMW4eaF9d0sLfPAbjsyIAV5mxqgZzX
         NKFlN3I2UNcZW2HLZXMc5QgdISuTIup/zVTNedHUqyOOZXXWiaXzPm6cGcgajJx2NjuT
         9dG1QVnMB1i+Th0DjSnc0PXReDhz0Ieh8IgMW4TqR2euzXHncnFbogT0behf1jSzz2w2
         Ymd0D+TRVz3aa/LOLyd+XjXjLaYyEHlO5wxqv4ypiotOkbcvrRbN9KKQNjITZlS7T3y7
         fIX3z1HG3BiWlX9QG2dHByGHoE2jh5UJsn8B3aalXvi7PXKc2NvWMUN1/N/atmC8bj3i
         nqsg==
X-Forwarded-Encrypted: i=1; AFNElJ/pl2dZmjuwAaqLYcqn5pIMKTUfGrzEVVVH1/9kUnhhqHp4vb17W/IBMCqJ1aKm/ZXzB1H8cqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqPNybrjn+IjND58tZ9sDTavLRhS3uz/89QvZp9+d5mgm5bxm
	3ZK+jFhRcv5RlfhLMGxE6Vp+OgZfJ0wqE5Gjpp2udXcSIWtSkxZo6JYFO2G4/KQ4bOgV+YyftzA
	fBRt68A==
X-Received: from pfbhh10.prod.google.com ([2002:a05:6a00:868a:b0:82f:6a26:5f78])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:419a:b0:83e:d996:92fa
 with SMTP id d2e1a72fcca58-8415f3f82aemr6397522b3a.11.1779517017309; Fri, 22
 May 2026 23:16:57 -0700 (PDT)
Date: Sat, 23 May 2026 06:16:24 +0000
In-Reply-To: <20260523061654.2767060-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523061654.2767060-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523061654.2767060-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/5] geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291045-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1AEE95BD67D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

geneve_nl2info() calls ipv6_addr_type() to check if the remote
IPv6 address is link-local.

Then, it also calls ipv6_addr_is_multicast() for the same address.

Let's not call ipv6_addr_is_multicast() and reuse ipv6_addr_type().

Note that addr_type will be reused in the next patch, thus it is
not defined inside the if-block.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index e8ff03ed87dc..16b5f9e13859 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1898,6 +1898,7 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 			  struct geneve_config *cfg, bool changelink)
 {
 	struct ip_tunnel_info *info = &cfg->info;
+	int addr_type;
 	int attrtype;
 
 	if (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) {
@@ -1933,13 +1934,13 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
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


