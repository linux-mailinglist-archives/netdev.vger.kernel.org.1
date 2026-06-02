Return-Path: <netdev+bounces-294363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xbIJMMgqH2pmiQAAu9opvQ
	(envelope-from <netdev+bounces-294363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:11:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E945631523
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:11:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=eKi0TKlW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294363-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294363-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A026305881E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F033A59A7;
	Tue,  2 Jun 2026 19:04:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA12DC334
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:04:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427081; cv=none; b=N4GCCu/ggQMM4ZL06iP+vH09i0hMYMH2GDipvo+Q3viNOjACeenb5c3OOlfUVwrdncHKEogQ1f6xXEnkASWDcseeyMvLOilGYEYbt1tTUrnVk+McUnT+xBDUjrCLQA0PnGIOgZQqkeuLvD+R7O6Mo2KaCRoljTGIP6vZ4VFK/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427081; c=relaxed/simple;
	bh=VlZCsBwJ24IBebNqmSQ8sxXwykBzdQsd2ZT5gH1+c8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S08lYkOArMgF8KAZ1/a1cqxFKtUPsjhIX9jj7G79CN9lDMYohsALqHoyfmE2QKK6KgJyUE7jyU+J8xt1foyLYN1pSsCveb72HpcZQ0tXABu/pZVDYTMpVetBOuS5I1t9s+q8/uIekEDuKiXTvSc8ddkW/x4Uj5xkF7Gx7eesXgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKi0TKlW; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423770d72dso4104813b3a.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780427079; x=1781031879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wX5OUqr0LpeEWL8kqquGiIWM/XSQBMTuyvyUgx8dfsg=;
        b=eKi0TKlWcWNGAzeKheVY+dA3Cx7AzJekHM2LW5QNTOkTMr+78sc7O9b9/HegRa0EO1
         0OP54BcSV6dBb+JkU0rLHgir5ioBrYANnLYTSTNX7/TNaAl+otK9YBr3DrJPS8wyIk1D
         BQC9/kVUZP24Q4JSKa6idFVDxQ4o1B44vho0Pjs6wkLaU4RUl8UTgdenmE3nkxOShx5o
         6is0YQG7/GQvVrNfIBeaTRwAEes/DJrgAFrPZ1t46YCgw8Gw3eLISUxzmPHIfpjM+ukW
         R+zWBjNPgFcZP0IYLxeXYD7+b7IRTT1/8SFCi1ZMFmaxqfkNeNu08lqvNwjHeAUH+cfj
         iweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427079; x=1781031879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wX5OUqr0LpeEWL8kqquGiIWM/XSQBMTuyvyUgx8dfsg=;
        b=MLU7CCuvBpI7uYYRbbXcnkrc7spPCde3jv+Q+v2e1uzvg2RgCmWYcSMCczVFEAq/R9
         JDm0/dH+EslNSiT/GX07lVXfr8qL9WUWe4t+V+1Xq9I85j7j07v7OHdJVQBYc44IlCLU
         yr+0g+sxtR/yK2Oc2wKewFqyGpe9zJmlha0ZJ19qWbgUN/v2NHuskUkoHaGaiS4nHrax
         4Pm2AhUPibs1bJ5mFCNYEyPCeLzXO+g+DwPzh7SzXx9ynp58FioxS+ecvKjZA3x0iOsN
         Im/mKx11sl+K8WrQlPq+06jPY5k9yf7PBoNEh9666ignsXCR/bHJHVVMXSYboT6NWblq
         o8Ng==
X-Forwarded-Encrypted: i=1; AFNElJ9V6VvJelvIs1vlK2imIAVCFRvemMKHi94SlBn+574mCLyk1ClTs38hWDlAWaF88dJUJnadYaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNRhdtWPQXMJrakrAYZgWbGG6aImlqFBYWuMD/FcXpvbOAVLd
	nhu1/OopJcMhgPzVnjVwyaQSSc7j/R2bM7WqZZFw7iczvjp5CToGKvtUNMP66zG7kB7k4by8BYb
	CGb2K1Q==
X-Received: from pfbdi4.prod.google.com ([2002:a05:6a00:4804:b0:842:3a6c:99f5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b0f:b0:842:35e2:40b3
 with SMTP id d2e1a72fcca58-84284eb3992mr180918b3a.35.1780427079019; Tue, 02
 Jun 2026 12:04:39 -0700 (PDT)
Date: Tue,  2 Jun 2026 19:03:41 +0000
In-Reply-To: <20260602190436.139591-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602190436.139591-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602190436.139591-2-kuniyu@google.com>
Subject: [PATCH v5 net-next 1/5] geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294363-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E945631523

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
2.54.0.1013.g208068f2d8-goog


