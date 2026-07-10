Return-Path: <netdev+bounces-306472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ng1nKkS8UGoo4QIAu9opvQ
	(envelope-from <netdev+bounces-306472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:32:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3380739151
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:32:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=FgRVw9lB;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306472-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306472-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B5DE304150A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6B23D7D9F;
	Fri, 10 Jul 2026 09:04:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336063CB8FF
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674247; cv=none; b=NKufsdJy8CW8HgE6iQ7EES2FkEYodApz6Zo7Grif3N2Iving2AJ1EshYF64Yp15HACD39iTtUDIDzoI4SGjqdIQtu0oacoiExxbPAQIn1vcav16XIaYrGtc7WXtoGxc3GR1s3ppa73mFmcNa7yfW6HKNH6QB/dT8syAeS5SLP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674247; c=relaxed/simple;
	bh=D6t/HirDsGwjXAt/0GUvoIkD55RKlDlQIODAh4TCHw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOOfIrrdiPx3dDFVIfjl33tUrObQNCsLEmV4HRUAJKQY4jpKPl/iHo3XXPZUzlt4cJ9kJSzFDeTJjnxynr7HwqaOE2DD8Fad3e/3nIF1VEn307ZFOTJCph3Ou0wEgf+ONInHhTY+JLXsOUlRk7XPOhH69ADlYtbrGYRiyQUbI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FgRVw9lB; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 84DCF207B0;
	Fri, 10 Jul 2026 11:03:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GDjiWsfqUWJq; Fri, 10 Jul 2026 11:03:56 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D63F7205E5;
	Fri, 10 Jul 2026 11:03:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D63F7205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674236;
	bh=m1cg/getpUwBybgRA3cQrGRPc+efByFcjLwl9A3p84A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=FgRVw9lBZiZN4wqMaejaC3TDxWBaY57/tY/1GjeQ+pD72kJ+BtYLnM/xYTfRi0gDw
	 lyBOOxzNs8VAlT+ZMq9gqyOWKsskH6fcQ4RbIDGjikhRO2v+/wl2euFRwzZUvZF1xO
	 r39sy+8SxxE9BENK2JiS/FqUTRbxrAlXNv481AgBxNTRZ0HbbQAonFyvvWaG4CfqRA
	 v1dsibOdDrFUfPdL71hcI099gfF50+2pvUk2mHJN7LPvSDCsb7C1KTGWaENJWxkcjf
	 qP751vscR62NYeNFSUf9/+t6xoemkKkzETN6bRVNKi0YeYIACwZcSP09E2E8468ZZW
	 9QvQHSAV2p4fw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:03:56 +0200
Received: (nullmailer pid 343854 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/10] xfrm: clear mode callbacks after failed mode setup
Date: Fri, 10 Jul 2026 11:03:20 +0200
Message-ID: <20260710090349.343389-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306472-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3380739151

From: Cen Zhang <zzzccc427@gmail.com>

xfrm_state_gc_task can run long after a failed IPTFS state setup. In the
reproduced case, __xfrm_init_state() cached x->mode_cbs, IPTFS setup
returned -ENOMEM before publishing mode_data, and the temporary module
reference from xfrm_get_mode_cbs() was dropped immediately. The dead state
then kept x->mode_cbs until deferred GC ran after xfrm_iptfs had been
unloaded.

Clear x->mode_cbs when mode init or clone fails before publishing
mode_data. Those states never installed mode-specific state or the
long-term IPTFS module pin, so deferred GC has nothing mode-specific to
destroy and must not retain a callback table pointer past the temporary
lookup reference.

The buggy scenario involves two paths, with each column showing the order
within that path:

failed setup path:
1. cache x->mode_cbs
2. mode setup fails before mode_data
3. drop the temporary module ref
4. dead state keeps x->mode_cbs cached

GC/unload path:
1. xfrm_state_put() queues GC work
2. xfrm_iptfs unloads later
3. xfrm_state_gc_task runs
4. GC dereferences stale x->mode_cbs

This also covers the failed clone path where clone_state() returns before
publishing mode_data.

Validation reproduced this kernel report:
Kernel panic - not syncing: Fatal exception
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
failslab_stacktrace_filter matched xfrm_iptfs frames
ack_error=-12
FAULT_INJECTION: forcing a failure
BUG: unable to handle page fault
Workqueue: events xfrm_state_gc_task
RIP: xfrm_state_gc_task+0x142/0x650
Modules linked in: esp4_offload xfrm_user [last unloaded: xfrm_iptfs]
Kernel panic - not syncing: Fatal exception

Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 10e5a1a95fe3..36a4f6793ede 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2072,8 +2072,11 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 
 	x->mode_cbs = orig->mode_cbs;
 	if (x->mode_cbs && x->mode_cbs->clone_state) {
-		if (x->mode_cbs->clone_state(x, orig))
+		if (x->mode_cbs->clone_state(x, orig)) {
+			if (!x->mode_data)
+				x->mode_cbs = NULL;
 			goto error;
+		}
 	}
 
 	x->props.reqid = m->new_reqid;
@@ -3292,6 +3295,8 @@ int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 		if (x->mode_cbs->init_state)
 			err = x->mode_cbs->init_state(x);
 		module_put(x->mode_cbs->owner);
+		if (err && !x->mode_data)
+			x->mode_cbs = NULL;
 	}
 error:
 	return err;
-- 
2.43.0


