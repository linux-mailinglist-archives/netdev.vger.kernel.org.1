Return-Path: <netdev+bounces-179082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2A2A7A84A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934EB172736
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95882512E8;
	Thu,  3 Apr 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FAnzjTMy"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269952D052;
	Thu,  3 Apr 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699501; cv=pass; b=SXkYgf6vTNEC7T6hiewJ5X9NZlSXD/60NgtqYr1BfDxrKMZkTY527vcFsIuaUZldQQcU1zwr6kLJPoyvlIdCJd37W0N+lTIZ9LHe3SQxxy35KqrEOOx9+DDQIGqTJkMWMRK4qkyDoQN1M6neycXgalAaswc8jvX3b1f76r1LpBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699501; c=relaxed/simple;
	bh=IMK0vRqPB1kvZoixPsMjAMEMXNTIwq4WAJ2xK2pug88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgAqqxbwyK2HpoCN2+EHPLZhG4c4NJXoIK0pZKnoDpmOoRlyTN2fKlUpflEEW3OtmAwBLJHj33yhueOm27DmMWr6yk2c9G+o2M5OFyZGUc/iT/ZZvCheZiL3OhR8Q7eh5l//Ijsp0GXZ5+vRCShNbe4aP34JPzIRQTeEp3Oq3iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FAnzjTMy; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZT7GN2K3Nz49Pxf;
	Thu,  3 Apr 2025 19:58:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743699485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bTZRIVsiORj7EbfVIazfg3T+z6IiFqu0YVKqgFaKKdg=;
	b=FAnzjTMy1GiWHfakFYG16XC17kub0XF1RMQRgKtcO6ueGDC6D9qc1FYkPp0/APi/z7eT6P
	xQ77u32mtfET5t4OsDEa7DFJ3o5i2LdA2JSgRPuFDBgVn1fDvNWCG/nNu6maxevSxJhrLh
	SiWLXDF9C0kB+nrvtAapKYN6KK5fx9VqkbWbs1dCoi1NdakkPMhmw8pkqge0XNeyrpZdP6
	oo9rCaDpwP6j/xc2oXYHQPIYcWrhkNpa46eRam7ZVLejnD+p2XqHvave0gWtn166UypQgd
	tEwOhcwxRasgjm6ddabv1At9hmi/vlLUsqXNBPbl253XZlBSybdwdd/IymzpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1743699485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bTZRIVsiORj7EbfVIazfg3T+z6IiFqu0YVKqgFaKKdg=;
	b=KoiHNzqGUYahpaZkpaHxuZGdvTcACfUCo++A6CTHK10/dVgONdzL1bMRggz3ae4QGnslQe
	yLwyLaJWIECK4E2uRzfhP2WT/cjBUUHMWcaMzOGJDCcX0+jFkDR5phAfqHvOnqv0xOm2YP
	G1I9ttkij25DnDyomom1fwwKVsb+0MKpQBTdaTWclN2i9UsNIPbmXXh+2NN0Mpu4E6KlG5
	aCbOxBhcIBkynJunUp+3fCRWm64PVHKUWpqJMbvsJ884L2FLQmJySO6bq2ofQNOjPgDVuP
	T7l7kUyxbnXyw+fY/7LLqMUrrvRT30G4P6yGcbefTG4WZsJkAlRcw+VBfZHSrg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1743699485; a=rsa-sha256;
	cv=none;
	b=dzhUY9ntXt3tmrvdevv2iALtvgCXQDEVVJ7Etqec3OGPdHs5skFRRsS0h3wQ86DHMYAS2n
	8H6AYmvxYvVnA2J37aMpk2sv+J8eVa6NdbavAesNHswRG8nJVn7WJTMkYCQv4fqNMv48XB
	uDcf7MuJYp06xEbnBWiZ4xUm5fyQnHhiBxNt4KbIF5/N2jsNPXH3WJmu9XEVo80XTRQRKu
	tSZolKbMD0jjMIyP4lloyMVGuTUcBPvE8n+k4UIp+WBPXKH4l5ESaDgKP9yinFoc+ocbP5
	j9l2UXw3s49ftZ7BHkgdP/GRWQR5lOaMfmOCFq5o6FNdtf7Eu2CWhwnzcq48TA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	kerneljasonxing@gmail.com
Subject: [PATCH] Bluetooth: increment TX timestamping tskey always for stream sockets
Date: Thu,  3 Apr 2025 19:57:59 +0300
Message-ID: <cf8e3a5bd2f4dbdba54d785d744e2b1970b28301.1743699406.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/timestamping.rst implies TX timestamping OPT_ID
tskey increments for each sendmsg.  In practice: TCP socket increments
it for all sendmsg, timestamping on or off, but UDP only when
timestamping is on. The user-visible counter resets when OPT_ID is
turned on, so difference can be seen only if timestamping is enabled for
some packets only (eg. via SO_TIMESTAMPING CMSG).

Fix BT sockets to work in the same way: stream sockets increment tskey
for all sendmsg (seqpacket already increment for timestamped only).

Fixes: 134f4b39df7b ("Bluetooth: add support for skb TX SND/COMPLETION timestamping")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 95972fd4c784..7e1b53857648 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3072,6 +3072,7 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
 			    const struct sockcm_cookie *sockc)
 {
 	struct sock *sk = skb ? skb->sk : NULL;
+	int key;
 
 	/* This shall be called on a single skb of those generated by user
 	 * sendmsg(), and only when the sendmsg() does not return error to
@@ -3087,13 +3088,16 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
 
 	sock_tx_timestamp(sk, sockc, &skb_shinfo(skb)->tx_flags);
 
+	if (sk->sk_type == SOCK_STREAM)
+		key = atomic_add_return(key_offset, &sk->sk_tskey);
+
 	if (sockc->tsflags & SOF_TIMESTAMPING_OPT_ID &&
 	    sockc->tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
 		if (sockc->tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 			skb_shinfo(skb)->tskey = sockc->ts_opt_id;
 		} else {
-			int key = atomic_add_return(key_offset, &sk->sk_tskey);
-
+			if (sk->sk_type != SOCK_STREAM)
+				key = atomic_inc_return(&sk->sk_tskey);
 			skb_shinfo(skb)->tskey = key - 1;
 		}
 	}
-- 
2.49.0


