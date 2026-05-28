Return-Path: <netdev+bounces-292500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DUWAj2UF2oiKAgAu9opvQ
	(envelope-from <netdev+bounces-292500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:02:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC745EB770
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33973010C0A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C662E221F1F;
	Thu, 28 May 2026 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyz8l0ER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495F1E260C
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929822; cv=none; b=aRw0w9DzKYgYTY+IOHRcWMR93i01GJg8CjYO4heCINMb6gzGifcByY/R/jhioYiOs/mlMoi8Gv4LxmecAgFBSGkvm7ekVrsSoGGFY+mQ1/Eb2rmBHmWLDTz0B2E+LRl4rGvO6YqclS3e3461KvkZ3cpp8RCp2FJyzid2i/7obZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929822; c=relaxed/simple;
	bh=fXTuTRHwGp+hCvWXzEuCMac4sBMnC1HmTCGkXAsucDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgCMUkYvzqmcHEILQGSlHbuQYDQzgNZqTAXp1p1yg24aitjoKMrmAjdXAGvr5vVHwnuuxadWFaHQzA3+Ou9q65c1LNjuhpG32++rvS5pL6xNCKIilFCn/2ppnCo8ryjTN+mjhUNq7pXVl41XvnC6F4KXDtIfs10r8IoqH97YlyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyz8l0ER; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so8087594b3a.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779929821; x=1780534621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXLfpg1Al8O/JM+QjWDrsNSuSHoQhg/vyvJAxCM33M8=;
        b=fyz8l0ERXlZuJ/KRNgsENYrY+DE98rsUcs1tseCOiMNLP3O2L82NwEZLR6ebniWRua
         /FK37y5pOrk2K24ce6LuOnd1lmk2pMAmNiwETZ577ol7bfowZ5g1xTz5qOjK8ATAq+CS
         KK+kQCGOliS+bgSNMUWU/fhP9CVc/U0eOmQjl13fpnvKtzaOhAfH0t+sdPv1AHIfjaGh
         exUM49GstElGvq8VIMi3cDm8f/p+wEVXJwkJea/ZizUSQG5fgh15vTDLPKqglQnWJXCP
         Z481Y0EhYmI6oAKhReG920VTp/bLHiZH8Sy0iNFnbQ3ORkmbHo8+M5qVsH/Q9DVKK6XD
         4NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929821; x=1780534621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXLfpg1Al8O/JM+QjWDrsNSuSHoQhg/vyvJAxCM33M8=;
        b=D+JJ0iOGN4jImMdzcERu1ZCE3p9bKPIFWgXuPpxqSJ0egS+PDw1JVVJaHq8EgLMa40
         s8tb539I8QAh64dpjnO3wYpKZcWiSo6amXz7VCMf3840g30VVD5BR1/2GakHhgZ2Lcwm
         jPLe3bS5Ep2KLQzZdwi22MrpeCx1Jq8max2s0piJAbMovE6sLS2+62oXr9Nd0/iLXSf6
         LDCxtpYbaogSuPjLnm18GJ72XomdYtlraiA6JpWvwiUBzP0NQvH9U3l+3OoOgoKRNhb+
         R/KVVo+u/aNEFx6ub3jTif2N2N9T/2TA2oleZ2EiSqWrBqDRWDgpFZ79wysPbAxc+2j9
         THMA==
X-Forwarded-Encrypted: i=1; AFNElJ9bETn+iMdW0vKmVhQC8i3N+XzyjHWK3y/B7p0sTFFajwBoFv9/GALiEfx09Y5sg5f8CRzPEUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvtwd7bwSccUdki89VxgrE7xCgUKwklOizRQIj07yYuqUoZZGA
	zoaxnWo9f6/EqWjoJ9VMsOeIA5c3yF63PxKiWnz5g9H2P1XQupHu+s1k+ayzWn3WhMNaL1VQDnX
	xaz9wkQ==
X-Received: from pfbei37.prod.google.com ([2002:a05:6a00:80e5:b0:82f:5d4f:734f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6f59:b0:841:d0c0:d9dc
 with SMTP id d2e1a72fcca58-841d0c0f6c2mr6409173b3a.44.1779929820572; Wed, 27
 May 2026 17:57:00 -0700 (PDT)
Date: Thu, 28 May 2026 00:56:44 +0000
In-Reply-To: <20260528005658.1756248-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528005658.1756248-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528005658.1756248-2-kuniyu@google.com>
Subject: [PATCH v4 net-next 1/5] geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
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
	TAGGED_FROM(0.00)[bounces-292500-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CC745EB770
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
2.54.0.794.g4f17f83d09-goog


