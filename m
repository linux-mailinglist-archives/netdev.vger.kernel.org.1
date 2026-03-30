Return-Path: <netdev+bounces-273078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SID+M34aymlR5QUAu9opvQ
	(envelope-from <netdev+bounces-273078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:38:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57A35602E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49712300BDB3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FFE385525;
	Mon, 30 Mar 2026 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="nxZ+9mXe"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F237E2EE;
	Mon, 30 Mar 2026 06:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852591; cv=none; b=TADWrbQKdcZe0wO8F9lFlG4BtO84nf/PyXLMRilDnOP53hebm9/oHyjamF8sIpLX7CyNiCKpFK74sD8oOIh551YccKbKzdRVeO2+Uqr/eCeu9ZLxg/RgowOaW9BB8Z0yX5MlNe5LKWC4fSkC9IIatLJ7AoLRUZuGZfK4dag2Efo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852591; c=relaxed/simple;
	bh=XpLY8vVk+xjtPNLx85ccvF3JVVYJ1ep257Dx4BmBWOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:Cc; b=NhWSbRAYSwKGyYrwRy2148aTPCo5HM84hw4FhKEexGkwRB+4zdFkVrG6BPWncdXqJWepNiZmOgy1mwIeruKMdV0fFy0PYJS/w68kxWAoYaj8wQS3wkNDAJEj+eCWlqljt8lostnPbHf03B3OwOAMhh+9wxk7j4GDm5WOHDKwNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=nxZ+9mXe; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6563b15e2e=ms@dev.tdt.de>)
	id 1w76ER-007lIZ-Ib; Mon, 30 Mar 2026 08:36:15 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1w76EQ-00BUzF-BW; Mon, 30 Mar 2026 08:36:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774852573;
	bh=dlCl+45yJDKGfUis8Ieb5mpkcMlP0GxwsFcseJrCcJw=;
	h=From:Date:Subject:To:Cc:From;
	b=nxZ+9mXeV9t8HYYm81g7fGxpUKgdXONWwX8llMVNsfddoDxRZea46GNrk0Oe3aqCA
	 2u0nJnzolDvyRmIeoLvnM/uc+19GNiFuZk9N0/FY0z08qFbiTA0c/G7jxrR/d6WOEk
	 WiqaT3p6m4tKgRYXyEk5tzA0NSAlb9oC4y/oOSBaxZ4Mgzx1aSWUwjXx1NZAcJJ/WG
	 QYH3QGA3TSbb6SG32hTs+LxEmMT2OaFBR1XQiX7BGFMCrqWwqJ2GVSrJ61w96i6RSB
	 iJjKM8O8L2YftkSfWFLuj4a1gbxvtPsU78OppNHwgzGvDUF9bQHxCs0CLfgNsCW1+t
	 tyPm3yxnSZRPQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id BB702240040;
	Mon, 30 Mar 2026 08:36:13 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id A9FA3240036;
	Mon, 30 Mar 2026 08:36:13 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.16.15.17])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 5AF43206DD;
	Mon, 30 Mar 2026 08:36:13 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
Date: Mon, 30 Mar 2026 08:36:03 +0200
Subject: [PATCH net v3] net/x25: Fix overflow when accumulating packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-x25_fraglen-v3-1-5a8938465cfe@dev.tdt.de>
X-B4-Tracking: v=1; b=H4sIANIZymkC/32NQQrDIBRErxL+uob41aTtqvcopQT9JkIxRUVSQ
 u5ekW6y6XJmeG82iBQcRbg2GwTKLrrFlyBODeh59BMxZ0oG7LDvBCq2onraME4v8uxsNcrOcDJ
 GQCHegaxbq+0OnhI8Sjm7mJbwqQ+Z1+knGw6yzBlnF6sHxY20g5I3Q7lNJrWGqijjHxgLzKW4c
 K6F7XE8wPu+fwFzW56S6QAAAA==
X-Change-ID: 20260325-x25_fraglen-8fc240d1edd3
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Yiming Qian <yimingqian591@gmail.com>, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, Martin Schiller <ms@dev.tdt.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774852573; l=2055;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=XpLY8vVk+xjtPNLx85ccvF3JVVYJ1ep257Dx4BmBWOo=;
 b=RiDpVb1WEAt+5dMSFleR93L7KzLJ106RZj7HHM+xNaf0fl6whpEN9yVrU6gBgtFDrHrK6157N
 BuvlcbRmGpDA0vd5rxYQkZAyL+tk9DyvbmO+/IEhZthJAmFp68I6KpQ
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate: clean
X-purgate-ID: 151534::1774852575-EEC25842-B2B2FF62/0/0
X-purgate-type: clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tdt.de:email];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273078-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7D57A35602E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a check to ensure that `x25_sock.fraglen` does not overflow.

The `fraglen` also needs to be resetted when purging `fragment_queue` in
`x25_clear_queues()`.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
Changes in v3:
- Added missing Cc: Simon Horman <horms@kernel.org>  
- Added missing Fixes tag
- Replaced `Reported-by:` by `Suggested-by:`, because I cannot give an
  URL to the required `Closes:` tag
- Link to v2: https://lore.kernel.org/r/20260327-x25_fraglen-v2-1-143911c3f62a@dev.tdt.de

Changes in v2:
- Use USHRT_MAX instead of sizeof(fraglen) nonsense
- Link to v1: https://lore.kernel.org/r/20260327-x25_fraglen-v1-1-9fc751d4f754@dev.tdt.de
---
 net/x25/x25_in.c   | 6 ++++++
 net/x25/x25_subr.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index b981a4828d08c2e6676749a06035910eab01e6cd..cb84c683d249d6078f3673835bb2f80eb487f253 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -34,6 +34,12 @@ static int x25_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 	struct sk_buff *skbo, *skbn = skb;
 	struct x25_sock *x25 = x25_sk(sk);
 
+	/* make sure we don't overflow */
+	if (x25->fraglen + skb->len > USHRT_MAX) {
+		kfree_skb(skb);
+		return 1;
+	}
+
 	if (more) {
 		x25->fraglen += skb->len;
 		skb_queue_tail(&x25->fragment_queue, skb);
diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
index 0285aaa1e93c17233748d38eef6d8b5c6059b67a..159708d9ad20cb2e6db24ead67daf1e9d6258f64 100644
--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -40,6 +40,7 @@ void x25_clear_queues(struct sock *sk)
 	skb_queue_purge(&x25->interrupt_in_queue);
 	skb_queue_purge(&x25->interrupt_out_queue);
 	skb_queue_purge(&x25->fragment_queue);
+	x25->fraglen = 0;
 }
 
 

---
base-commit: dc9e9d61e301c087bcd990dbf2fa18ad3e2e1429
change-id: 20260325-x25_fraglen-8fc240d1edd3

Best regards,
-- 
Martin Schiller <ms@dev.tdt.de>


