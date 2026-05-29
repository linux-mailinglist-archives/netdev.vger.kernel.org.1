Return-Path: <netdev+bounces-293030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGLINjNFGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:50:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E32EA5FECA4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 688EA32315C4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD803ACEFE;
	Fri, 29 May 2026 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sqUs01N4"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57243328635;
	Fri, 29 May 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040731; cv=none; b=AhIXY+Rp51IfLDPUWFFb4ebRBuzSOyaq5P2D/CJSzgLlLkKNokK62SnA4TGWr+wJAZ03PxRTk1691IOLfU+ADGlQjMd8KDkqwL8MUgiRDKDZiJRwiLBW0y/VovNMBAmf2+AGccaK+pNWKIteEH8TU2Z6N5/QJKTqNHaPcmjvcVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040731; c=relaxed/simple;
	bh=4/rcVikLzFNIHzwXr/tDb8JuW0A5WAxO1YnN5vnYRJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qREvKycvZEYMYbJ9bb00KqOouiErtkM+DqDFFGwIpb7U7g351p8B9NtLRJGhSUH0z7+69v7a2C2xqw0/MdEHiuUF5J9JvG+56hLoh1lO5/bzOA6KN2vhEaDM5g1hP+jMZNEfNJO9fgW20w8NKFpwoKJU24qwqaIfrR8mZTghkgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sqUs01N4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=1ZTNUeL1mmdwYNv7ZCEh9fXBBMB8CAmIvFx5V3p+ucI=; b=sqUs01N4kVHhHla4q/ZaVuExLI
	ZEzaOc2k5JksVh6Re62+iQrdRpVbAQ6Zq7OAa/j4gapgf3AVzhFKqjRdTXKW5tHTffeiuoZHvbiN6
	zyhysk6SROSavoGHMhMEKKi1VVKYu85HfHUh+gOc1GGfKsQxlC+eK83jnTM1cF1MJcD0WFko0thc8
	ndJqU4D2R/+D2dqPerwRSICp/3LrZUgqmslJ/XxCXBdKAYghtFgZpg4SAs3DQ/QAnrJoleM3LeTQU
	KRMaoEk3L3w4qtAXCjU8J9zrWZa4eKQ99P7BdPBEWfYxSq60tKbrMDXHSKiIvOsC5xXjtlw2y9rfD
	ZKWltt4A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSruE-004kM7-2U;
	Fri, 29 May 2026 07:45:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 29 May 2026 03:45:13 -0400
Subject: [PATCH net 3/3] netconsole: take target_cleanup_list_lock in
 drop_netconsole_target()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-netcons_fix_before_move-v1-3-cb2d1426dd75@debian.org>
References: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
In-Reply-To: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neil Horman <nhorman@tuxdriver.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=leitao@debian.org;
 h=from:subject:message-id; bh=4/rcVikLzFNIHzwXr/tDb8JuW0A5WAxO1YnN5vnYRJ8=;
 b=owEBbQKS/ZANAwAKATWjk5/8eHdtAcsmYgBqGUQMqv6yG5bTKI5irUeICW72HQT7N0xNKAQHW
 lf1i/R6JO6JAjMEAAEKAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahlEDAAKCRA1o5Of/Hh3
 bSzHD/4/0Yu/gfenShs5VNG14I8JjwEwuKf3Djw1DnUanHvNCzpumM3Xpg6UQdkIFv4Gplh7yQC
 HGN2DMuNRGVnSBY4TUrIOnzEO21Lsx0z1ou/MMbjNeRw00LliPCf6DkwtLJqN0Etnas8nvmGGv3
 2WwJ7QUU/17/wkEGgV8OvPYgFzq2Pmu6CBsH1AWmKsvlA6gy+b6wZgCT8IroJSP9SXH7F/U3IiZ
 ZK1VIddi3g0mPOSmdY6LdCLV9pm/BcRnDMTEpz87afMtjtJr//FrukNhkXt86vFPwB5N1zbG38O
 Lqal2eXrWADl8rFHdOcg3zKqE6HlW2395PQzDAgMr4p7U2bMBC3GpPejSHPtBSCmRC9HMSZZ3Cp
 vS4rHeEiXi2zL8c3WmSOoArYaHldI4FWrQ4+c9jbxMePBFOKnJJE7CwNRp3vO2JErbm0kxFuMWq
 r+bOc9Q2omotWoJc/tgxZt3crzBHWIB4H6X1ebfYNjPBpLXHHGo8Vqq9OkLmXKq87mC1gJs48TB
 iPmqI49x+lRwe0qsTLSsCsPCjdajwhMjw/QdXNQmq3TV8Bw9NmFjkCjN8mj+QugYrKY/CqzuPI2
 2xN0zCilrpDPLa0krtJz/ifh09adPdkI1FFUfNB3c0IBgweiO0r+6k+FBxTfLmiocVK5APLR+YY
 Qg6r4ImVMNynkAg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293030-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,tuxdriver.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E32EA5FECA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

drop_netconsole_target() unlinks the target while only holding
target_list_lock. However, when the underlying interface has been
unregistered, netconsole_netdev_event() moves the target from
target_list to target_cleanup_list, and netconsole_process_cleanups_core()
walks that list under target_cleanup_list_lock only.

If a user removes the configfs target at the same time the cleanup
worker is iterating target_cleanup_list, list_del() can corrupt the list
because the two paths take disjoint locks while operating on the same
list node.

Acquire target_cleanup_list_lock around the list_del() so the unlink is
serialised against netconsole_process_cleanups_core() regardless of
which list the target currently belongs to. The state transition that
downgrades STATE_DEACTIVATED to STATE_DISABLED is left intact and is
performed under the same combined locking, preserving the existing
ordering with resume_target().

Fixes: 97714695ef90 ("net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a3dcbe713a0b..9e15d4186436 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1452,6 +1452,7 @@ static void drop_netconsole_target(struct config_group *group,
 
 	dynamic_netconsole_mutex_lock();
 
+	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
 	/* Disable deactivated target to prevent races between resume attempt
 	 * and target removal.
@@ -1460,6 +1461,7 @@ static void drop_netconsole_target(struct config_group *group,
 		nt->state = STATE_DISABLED;
 	list_del(&nt->list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
+	mutex_unlock(&target_cleanup_list_lock);
 
 	dynamic_netconsole_mutex_unlock();
 

-- 
2.51.0


