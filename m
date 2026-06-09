Return-Path: <netdev+bounces-297234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d/m3NpNcKGrxCgMAu9opvQ
	(envelope-from <netdev+bounces-297234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:33:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2166766359B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:33:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aSnonK7S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297234-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E53A303A91A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023AF4C8FEA;
	Tue,  9 Jun 2026 18:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AB48AE03
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:32:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029948; cv=none; b=T3XEmODyI00mM2byVwHlB1FsNlZMQoBWJXm1AHYtF3Up5O1dbmItJPLFlvkZ771/1lrvU9Id0XyXgA6675Bj+dIndfsH/6CR00Px59n/CZbs+YfOj230HXrXT8btoKz9PD/6seaBV4hVHoVEOPYkcAIASfAsVLwObUUaZEj24OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029948; c=relaxed/simple;
	bh=N3k5y8fp3cAn0GYvxCLEdMnRS8kTUxdZYIvTYHdWrJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGhMS5AsyyCGJ1WvzOR2V1zp6aLoQ/LJelhxrpF3Y1jt4aVhNPCleNOISSJpDgD9KI4olTNUZIDIRAMKJmTkgU5rb8PQBGR2q7DThOg8PUpMqA2l+7bCHwEyoZjOmayNTVunmvRsrYPKsEUplqnn6G4GoZym8VSkP5kZPTXUe5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSnonK7S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888501F0089C;
	Tue,  9 Jun 2026 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029947;
	bh=Zj+g0wTJyXtks4s0p+ugVL3oxHky3xp/anjYAInaF2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aSnonK7SFuVTCCoSovAZEP6ZyZuR7SptCh8aglOpz3AO6Jm7rSihHwcDqqbNxdp+S
	 2cl/PPDgC7AKsd2/OjoTjvfChKqs+lSkWEuGv+MSrwq/KQOjqzI5iLuF+t5Rgmm0iv
	 mTo+h/0JbZgJ7pkV/ajmjJWm07Poh6EHoJOWXI354nmZN/Ws71DjZghqEnfmoVjyek
	 z4Y+05oc1vQVTgYai7BSOlgA8R0nSB3IiVt9tSSPh9SLGFcCVa9cQZHmgNF9h6Lqrv
	 2p8rzPfV1WVzqCyd8WP2O15M5yVu5/GJxWMsez1y9Gs6OyKtOgTvFpkm0YD8atK8sY
	 K094sfswAK22g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] net: shaper: add a note that we expect cap dumps to be tiny
Date: Tue,  9 Jun 2026 11:32:24 -0700
Message-ID: <20260609183224.1108521-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609183224.1108521-1-kuba@kernel.org>
References: <20260609183224.1108521-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297234-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2166766359B

Various AI scan tools may complain that we don't support resuming
the cap dump. This is true, but the cap dumps are tiny.
net_shaper_nl_cap_pre_dumpit() sets up the dump for just
one device, so the size of the dump scales with NET_SHAPER_SCOPE_MAX (3).

We don't expect them to ever need more than a 4kB page.
Document this.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 5a3b44c5d10f..b65b356da16b 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1452,6 +1452,8 @@ int net_shaper_nl_cap_get_dumpit(struct sk_buff *skb,
 
 		ret = net_shaper_cap_fill_one(skb, binding, scope, flags,
 					      info);
+		/* cap dumps are tiny, we expect them to fit in a single skb */
+		WARN_ON_ONCE(ret == -EMSGSIZE);
 		if (ret)
 			return ret;
 	}
-- 
2.54.0


