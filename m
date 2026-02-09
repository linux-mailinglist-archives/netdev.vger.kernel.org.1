Return-Path: <netdev+bounces-257963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P38IF0LimnKFwAAu9opvQ
	(envelope-from <netdev+bounces-257963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 17:29:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F956112826
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 17:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD3E6300443F
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573D3815E1;
	Mon,  9 Feb 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="IXTomYUA";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="TOMUT6Wx"
X-Original-To: netdev@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46437FF60;
	Mon,  9 Feb 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654552; cv=none; b=YkHgf490wh8onDD/iwQuBQYI2+6bFju31sUbrXCkzGFDK4bDYVZwhtziyNzbqYhonsKtirQwSSYVvAQSXIytKG54wKsJqKIL2jkM8BugbfH2pETtsK4khWkaK479YWbyVw5ARyDdJySsY1ioLy6j1N21/ksk+r15R7xAYBLSaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654552; c=relaxed/simple;
	bh=xkvNxqbgqeEoqLcE8qxomMI4NmK6kmBCXSq+yWgjMEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWIQvXcqYa1jvDtxnIxabmudbSjEToCCiRFOi20qvyVl1tEa130jTWnr5xNf3tFCrlAzz71hUOYYNIO4n4wNzv7dPaoSkwsMXF3WqPMDPGWNQFLL5CsH9HqxKVOSBCEqFWHP6sUDra4fD5tY8FjscHHgo10hS9gLz6or7Sxvkgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=IXTomYUA; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=TOMUT6Wx; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770654531; bh=uxvdcbMORNal9bzuihso3lM
	o4Xfi1tMf+XNjbGwuWg0=; b=IXTomYUAQT7AJkJLysF4Qe7L9uJ1f3cKdVIWVqTZAhCIeDm+je
	aV/QDEfOcMSBesAI9wDw+eNYQ0wiA58q6lLvKc4ITiig19b+h2xDZj//M2GniqbFRBUxE81PdUQ
	fUqID5kLG0Isngi1kIEeRd2yktkfPirrN+aaw+UNrsC6XJb2lMG1efv1ratwkqjGBG7CnnnyQDP
	ISqwRlT5nuXjzMNSL7cRzaiVhL1NjQWjeL7a0G9CSMANyT0hM1Z7INp3RKsxgsW4qmKngpjMIqy
	pGvTbpTyY+j91L/Y9fVWjuiYtLxeSc86wl4Sed1teMA/rpwKT6Q+15hQK8ZqsAeF/gA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770654531; bh=uxvdcbMORNal9bzuihso3lM
	o4Xfi1tMf+XNjbGwuWg0=; b=TOMUT6Wx7Fj+jGocdAkVzXMR+9DlNZ4Ik9Mhh+cOrda8EVMfzr
	5Y+zApL/si/n8W9Xs6ruFtp7Jd6wayV65cBg==;
From: Daniel Hodges <git@danielhodges.dev>
To: sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>,
	syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com
Subject: [PATCH] macsec: skip PACKET_LOOPBACK frames in macsec_handle_frame()
Date: Mon,  9 Feb 2026 11:28:51 -0500
Message-ID: <20260209162851.11800-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257963-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,0e665e4b99cb925286a0];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[danielhodges.dev:mid,danielhodges.dev:dkim,danielhodges.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 8F956112826
X-Rspamd-Action: no action

macsec_handle_frame() assumes all incoming frames have a valid Ethernet
header at skb_mac_header(skb) and reads hdr->eth.h_proto to determine
whether to process the frame as MACsec.  However, loopback packets are
delivered with pkt_type PACKET_LOOPBACK and carry only a
protocol-specific header (e.g. 7-byte phonethdr), not a full Ethernet
header. Reading 14 bytes of ethhdr from such a short header results in a
slab-out-of-bounds / uninit-value access.

Fix this by returning RX_HANDLER_PASS early for PACKET_LOOPBACK frames,
consistent with how macvlan_handle_frame() handles this case.

Reported-by: syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com
Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 drivers/net/macsec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 0206b84284ab..edcc51f82327 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1103,6 +1103,13 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	bool pulled_sci;
 	int ret;
 
+	/* Loopback packets (e.g. from phonet) don't have L2 headers, so
+	 * attempting to interpret the mac header as Ethernet would read
+	 * uninitialized memory.  Let them pass through unmodified.
+	 */
+	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
+		return RX_HANDLER_PASS;
+
 	if (skb_headroom(skb) < ETH_HLEN)
 		goto drop_direct;
 
-- 
2.52.0


