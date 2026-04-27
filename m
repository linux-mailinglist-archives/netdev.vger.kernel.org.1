Return-Path: <netdev+bounces-281459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAX8Ax+072kYEAEAu9opvQ
	(envelope-from <netdev+bounces-281459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:08:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA14790A6
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D16CB3028E82
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568863EF0A1;
	Mon, 27 Apr 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBAc8Y4h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA23EE1DD
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316783; cv=none; b=GaGUyKoT6jQsuTdcKloM3ykcGFs2nHbp0dN2NFI4hN7skhjOkeZq3nOcDTg8sbhxD1nzwDztWh87k6oG34+MJkERs89TBj7vFyLf3Q91VMWpumEqAJRPy5T7U71SX9raT5xYh075hxRDuFqSpdAUdPvDH+s8j9rQKOFwjKmQu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316783; c=relaxed/simple;
	bh=46kgNA1But8/FQT0yM4PIXDCfdm0+SoLk489FtfGl94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWj1dCFkZ7ex7tJz5Fw0/M2klPati0A3v62hO0mRefxaQeYNib0hnM42C+QXFK3Nqrzd8p15I4kYrVzH+0OHJQiC5gmn7F2YwMrC+PbBF8nyf4yascdueDZMN43uLEvC5s5x1nuedw2WXr42nmh7U3GiiXC2gf2aWduykLZuYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBAc8Y4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D86C19425;
	Mon, 27 Apr 2026 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777316782;
	bh=46kgNA1But8/FQT0yM4PIXDCfdm0+SoLk489FtfGl94=;
	h=From:To:Cc:Subject:Date:From;
	b=kBAc8Y4hf9hZ+8cxsXN2JjwRA73O9ZtQmc5OzIhsGO6EQ/pHJ77TTkmuXM4byIvwM
	 4qDPkkQIhQL3P9UsCx98Qyaw9rmaUyADSyd5EjfdhP1Oukos690i9jyrtYdbHaYYD+
	 ZzVxn2Fq0IqBup/hOaSLBxqnP14+bcjHSTqD9w3EOzVtrWjnG+yqoay2m+PfLrfCcm
	 ajA6i14StvmDLflj/X7XzJk2xk70BIE9gXsXl1G3vOviQBtfTEmEJUYL86JxKBdLPS
	 G0gK/gNs4Y39UXCD2Y669QNb7U8/dTNQYXoc2dfJL03pNclDKe4FsXST1KG4ml4MDB
	 jAz4IRqI6A6ZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net v2] net: psp: check for device unregister when creating assoc
Date: Mon, 27 Apr 2026 12:06:06 -0700
Message-ID: <20260427190606.366101-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5BBA14790A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281459-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

psp_assoc_device_get_locked() obtains a psp_dev reference via
psp_dev_get_for_sock() (which uses psp_dev_tryget() under RCU);
it then acquires psd->lock and drops the reference. Before
the lock is taken, psp_dev_unregister() can run to completion:
take psd->lock, clear out state, unlock, drop the registration
reference.

The expectation is that the lock prevents device unregistration,
but much like with netdevs special care has to be taken when
"upgrading" a reference to a locked device. Add the missing
check if device is still alive. psp_dev_is_registered() exists
already but had no callers, which makes me wonder if I either
forgot to add this or lost the check during refactoring...

Reported-by: Yiming Qian <yimingqian591@gmail.com>
Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v2:
 - Sashiko spotted that psp_dev_check_access() has to happen after
   liveness check, as well, so move the liveness check earlier
v1: https://lore.kernel.org/20260324205107.318303-1-kuba@kernel.org

CC: daniel.zahka@gmail.com
CC: willemdebruijn.kernel@gmail.com
---
 net/psp/psp_nl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 6afd7707ec12..0cc744a6e1c9 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -305,8 +305,13 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 
 	psd = psp_dev_get_for_sock(socket->sk);
 	if (psd) {
-		err = psp_dev_check_access(psd, genl_info_net(info));
-		if (err) {
+		/* Extra care needed here, psp_dev_get_for_sock() only gives
+		 * us access to struct psp_dev's memory, which is quite weak.
+		 */
+		mutex_lock(&psd->lock);
+		if (!psp_dev_is_registered(psd) ||
+		    psp_dev_check_access(psd, genl_info_net(info))) {
+			mutex_unlock(&psd->lock);
 			psp_dev_put(psd);
 			psd = NULL;
 		}
@@ -319,7 +324,6 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 
 	id = info->attrs[PSP_A_ASSOC_DEV_ID];
 	if (psd) {
-		mutex_lock(&psd->lock);
 		if (id && psd->id != nla_get_u32(id)) {
 			mutex_unlock(&psd->lock);
 			NL_SET_ERR_MSG_ATTR(info->extack, id,
-- 
2.53.0


