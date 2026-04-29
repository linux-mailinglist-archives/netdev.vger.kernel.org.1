Return-Path: <netdev+bounces-282319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGoLBM7N8WlrkgEAu9opvQ
	(envelope-from <netdev+bounces-282319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:22:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F6491CCB
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2A7530B351E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BC23BED1A;
	Wed, 29 Apr 2026 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="NIcbCA9X"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4737881C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454207; cv=none; b=t2iEdnIx5mOGJm935Pv2DCn98lZHiTleZA+jk7xVfz8DFXfO6HS3T83wahcDymfXcgGNUHdlk6sJfTDbo8FWyB6VmIylO6lgOvL+HGOOU2CvUt9L9/lpF/KRo3YhAxU/qlMTsaWB5QF/ZojAEWAPsqb8WzLhL4sx1Xh9eabFZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454207; c=relaxed/simple;
	bh=NbrcFjVj4pAeh30NgS+5QbarhONMcl+DlRVFxYo3BFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx3eBgugQqWi5qQWur00oJXFtSwr5QCHPBf606ynAIq9eT3cCxhfM6QWhAVokYBT3LP3taBiehAKgI7elUnETt7Zd/u5J7gmxQZjKg7XwhXejXLe8XzUwicFfOhAdr6SmkjI+yWavTidj/adqQusQqWlhp+nScgxwC+Z3J6pbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=NIcbCA9X; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (197.87.13.160.dy.iij4u.or.jp [160.13.87.197])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63T9GhfB043822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 29 Apr 2026 18:16:43 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=sADltytHJ5kqQvPdJMi42YwYVBgGpDWYmDLr4N3QD4E=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777454203; v=1;
        b=NIcbCA9X5Z4kuTSwqtKJVv1FZlo6wKz5pwwOFDiZRbvAuz78/YGGIl0nKmyGJSeW
         9crifLfrbhndHdBnkkI9oulrsV2GXdm3tNi5qDk+fDkiy+W8FFbJcCcG7/sbMf77
         Y/bbG+dZgRv/CVkqiAa8h2Bcx8VtON3yIJsoS6u/PuzukRmpz/oLzsNOUelJDcw7
         UdLnGIxNpzxLidRKo/ua6sanP9+B2lZWv6nMFQTQSHEwAaXqDVfc9ID5elVeJ2XQ
         888MbfF62db8mieicJMgofTHR4a1tuD0k5RMRTULB7YNHldIr578/2dohqda20N2
         5YQizySz05jQX1VEBUHR9w==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH net v1 2/3] af_packet: use skb_get_hwtstamp() for hardware timestamps
Date: Wed, 29 Apr 2026 09:16:18 +0000
Message-ID: <20260429091632.26509-3-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429091632.26509-1-kohei@enjuk.jp>
References: <20260429091632.26509-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 680F6491CCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,engleder-embedded.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282319-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
skb_shared_hwtstamps may contain netdev_data instead of hwtstamp.
tpacket_get_timestamp() unconditionally interprets skb_shared_hwtstamps
as a resolved hardware timestamp, and can report bogus hardware
timestamps to userspace.

Use skb_get_hwtstamp() instead of reading hwtstamp directly, so packet
sockets follow the same hardware timestamp resolution path as the socket
layer.

Note that skb_get_hwtstamp() is called with cycles == false, since
AF_PACKET hasn't honored SOF_TIMESTAMPING_BIND_PHC so far, and this
patch doesn't change that behavior.

Fixes: 97dc7cd92ac6 ("ptp: Support late timestamp determination")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e6f3a734ba0..e88bc3f1156f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -458,7 +458,7 @@ static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec64 *ts,
 
 	if (shhwtstamps &&
 	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
-	    ktime_to_timespec64_cond(shhwtstamps->hwtstamp, ts))
+	    ktime_to_timespec64_cond(skb_get_hwtstamp(skb, false, NULL), ts))
 		return TP_STATUS_TS_RAW_HARDWARE;
 
 	if ((flags & SOF_TIMESTAMPING_SOFTWARE) &&
-- 
2.53.0


