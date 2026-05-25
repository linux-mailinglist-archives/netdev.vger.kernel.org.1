Return-Path: <netdev+bounces-291364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAarCK9vFGqXNQcAu9opvQ
	(envelope-from <netdev+bounces-291364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:50:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D15E5CC80F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66BAA30041C5
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BF73F54C7;
	Mon, 25 May 2026 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="H8NCPbtv"
X-Original-To: netdev@vger.kernel.org
Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4889202C48;
	Mon, 25 May 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724204; cv=none; b=ucNoUhXByALI+lMAao5550Oo6goB8doN/VvCfrvtOwbBVHFWyhE+D7JIa7eoKAHkAvQ/WbtBW6oJkdTAuKmVOpBngAhibYwSCYlp+4lbWaEh1m/YY0FFk43vhvfC8YaL8vi6hBbI48K+yLRaoqXyxS986Bwas7Nm694qruhHTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724204; c=relaxed/simple;
	bh=VqqZmXG4qtl7D3IZAXMvozh/f+EgC0MJjqisx7xBX+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfqqlJB+wWE7xMwazbbmzRxfdvuIyQ+5sXDRmuibQG/n5Zjy/z7r96gMRDUmg83vzoxCrUW67gX4zFS6A06hW5wTiFRUXbZj9n7xGJh6ZLRPzNkPebXw2XwBV9i+XQO8/jdUeOfZ2sJctKBw+LYjiSMMhEmU1/4E0QAnHnsgIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=H8NCPbtv reason="key not found in DNS"; arc=none smtp.client-ip=63.250.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Received: from Kyren (unknown [49.207.213.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gPKpd0LZ3z6tkq;
	Mon, 25 May 2026 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1779723644;
	bh=JUefQ2N3Ya8tzjlBXDac0kjYXwjD9oX4C6Aq4ymYW6g=;
	h=From:To:Cc:Subject:Date:From;
	b=H8NCPbtvVoQjwTj/X8hHTcElicz38krPHUB6eudjt81115oHJ4R0yce5cjRSWPyy4
	 n2IKD+37r+YeyXt0/YZ7yQKr2MfOAFIQP4CSK71d6JqjcedjenYEBwgHMlO+qKQKA1
	 FOZsmrAJ7/93L9w1kt+C+u2Bt4ftzkESXGcemmUFrC+YyjaWtT0kWc7IVBk2vN7+U2
	 fBaTTTZL2bXUhxHFoA7uJKvH5svgiS4K4XeZ2mQQSwWOXYzal6c9RfO4qd0UOZaxMb
	 zJu8p4+nEHXGn7QRwJdSpfcERS7vn+tQ+vs0qjWMC+qMLwQ+fvoyQcHGYTjBhOCame
	 BOe6H1ky16wew==
From: Rahul Chandelkar <rc@rexion.ai>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rahul Chandelkar <rc@rexion.ai>
Subject: [PATCH net v2] ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()
Date: Mon, 25 May 2026 21:10:31 +0530
Message-ID: <20260525154031.2290876-1-rc@rexion.ai>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291364-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rexion.ai];
	R_DKIM_PERMFAIL(0.00)[rexion.ai:s=spacemail];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,rexion.ai];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rc@rexion.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rexion.ai:~];
	NEURAL_HAM(-0.00)[-0.899];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D15E5CC80F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv6_rpl_srh_decompress() computes:

    outhdr->hdrlen = (((n + 1) * sizeof(struct in6_addr)) >> 3);

hdrlen is __u8. For n >= 127 the result exceeds 255 and silently
truncates. With n=127 (cmpri=15, cmpre=15, pad=0, hdrlen=16):

    (128 * 16) >> 3 = 256, truncated to 0 as __u8

The caller in ipv6_rpl_srh_rcv() then places the compressed header
at buf + ((ohdr->hdrlen + 1) << 3). With hdrlen=0 this is buf + 8,
but the decompressed region occupies buf[0..2055] (8-byte header
plus 128 full addresses). The compressed header overlaps the
decompressed data, and ipv6_rpl_srh_compress() writes into this
overlap, corrupting the routing header of the forwarded packet.

The existing guard at exthdrs.c:546 checks (n + 1) > 255, which
prevents n+1 from overflowing unsigned char (the segments_left
field), but does not prevent the computed hdrlen from overflowing
__u8. n=127 passes because 128 <= 255, yet hdrlen=256 does not
fit.

Tighten the bound to (n + 1) > 127. This caps n at 126, giving
hdrlen = (127 * 16) >> 3 = 254, which fits in __u8. The compressed
header then lands at buf + ((254 + 1) << 3) = buf + 2040, exactly
past the decompressed region (buf[0..2039]). No overlap. 127
segments is well beyond any realistic RPL deployment.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Signed-off-by: Rahul Chandelkar <rc@rexion.ai>
---
 net/ipv6/exthdrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 95558fd6f..35a02584f 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -543,7 +543,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	 * unsigned char which is segments_left field. Should not be
 	 * higher than that.
 	 */
-	if (r || (n + 1) > 255) {
+	if (r || (n + 1) > 127) {
 		kfree_skb(skb);
 		return -1;
 	}
-- 
2.54.0


