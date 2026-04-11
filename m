Return-Path: <netdev+bounces-277688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL42NJsp2mmRywgAu9opvQ
	(envelope-from <netdev+bounces-277688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 12:59:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ADA3DF6B7
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 12:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FAFA300F7B0
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5833F8C3;
	Sat, 11 Apr 2026 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QJMvB2Eo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583C248886;
	Sat, 11 Apr 2026 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775904821; cv=none; b=nlWgCXtHr+DUeSUa7mWo1fj964ItwCEI/U+i2U0ziLBKEkHnVXQGvwL7m1qsNYohWCCgRNeB+hLdI58SHryqjK4MIylXwIcuYuFhUlLnFYV9T6Nj7ZWNjGrvfPOFntkmfHeHjcTdhVElUV5BjgJljQsBWuE66pZFAymXLElbAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775904821; c=relaxed/simple;
	bh=qYTSkRz7NplvE+99a9CYOj7zPsVlqUzfO2SlX2wFwKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5DYMaCS/l64aSZz+gKPyavJCoixT2ogBVdxRnf9DApT1HirSQTEXhNXEjbaM1sLXBhYdyHKUxBLCL3Lqr78tTo8tcTc/gIxo66TnjtcgTNKkzWULS4ucNIQhSP7sj1500DnF6mgPCVIbd+LVAWi/fzTr9eYMCKBS5jzz0jDZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QJMvB2Eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C959EC4CEF7;
	Sat, 11 Apr 2026 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775904821;
	bh=qYTSkRz7NplvE+99a9CYOj7zPsVlqUzfO2SlX2wFwKY=;
	h=From:To:Cc:Subject:Date:From;
	b=QJMvB2EoJ4sxUVOeQCH8iz/bBIQOkxxCQQSNYgDC30Yl7T5EUL3AcbvHaVa0kSP0u
	 2TQBiOEXs/2dFadYRg9yMWpjSQIdB/0hZA1sz4jGgj2i4+NlEP7McYfzgXayfeXqDq
	 wXPs0hPpBqyZCwu6FnwWmyRrZgyb7tElwPc847aI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] net: usb: cdc_ncm: reject negative chained NDP offsets
Date: Sat, 11 Apr 2026 12:53:38 +0200
Message-ID: <2026041137-comfy-eaten-a1ed@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=qYTSkRz7NplvE+99a9CYOj7zPsVlqUzfO2SlX2wFwKY=; b=owGbwMvMwCRo6H6F97bub03G02pJDJm3NAwvJiVdt/9s/19ubYypR2OX86Kpgo5Pnq638ZazZ tZ+deN5RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAFzkEMP8gDk+O5T+Te4yT30W lvdgxpV4742aDPPDr6fqTVpk/e3Bv3bBW6xb+MpmOnQAAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277688-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,neukum.org:email,lunn.ch:email,davemloft.net:email]
X-Rspamd-Queue-Id: D0ADA3DF6B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cdc_ncm_rx_fixup() reads dwNextNdpIndex from each NDP32 to chain to the
next one.  The 32-bit value from the device is stored into the signed
int ndpoffset so that means values with the high bit set become
negative.  The first time this is read, the value is properly tested for
a negative value BUT the next time through the loop, this type of check
is missed entirely.

Fix this up by checking for a negative value when dwNextNdpIndex is read
again in the bottom of the loop to match the top check.

Commit 8d2b1a1ec9f5 ("CDC-NCM: avoid overflow in sanity checking") fixed
a similar signed-overflow issue in the datagram offset checks of the
same function.

Cc: Oliver Neukum <oliver@neukum.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index bb9929727eb9..b2d08c4aae54 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1835,7 +1835,7 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 	else
 		ndpoffset = le32_to_cpu(ndp.ndp32->dwNextNdpIndex);
 
-	if (ndpoffset && loopcount--)
+	if (ndpoffset > 0 && loopcount--)
 		goto next_ndp;
 
 	/* update stats */
-- 
2.53.0


