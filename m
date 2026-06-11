Return-Path: <netdev+bounces-298228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a5R/FpnpKmoyzQMAu9opvQ
	(envelope-from <netdev+bounces-298228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:00:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF405673CD1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:00:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=At0GnMv4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298228-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52FD345DFFA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD9A33A03F;
	Thu, 11 Jun 2026 16:39:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2432E696
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:39:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195999; cv=none; b=W+CBZ11aPbUwQ7e59P8iZTqcx1iDK71bZo/IWZddTp2PVFIBFBzCHFYtXAAK4gKrJx61euUdNrRbRgd47Mms96iBnTZSPvx91WhdyEBx8ExnUsFEOa4+W3Vb1xozEKTVDDg2SsX+NsRyBJkFwbMt7x2yTdvrfhEBK+NcKLuLNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195999; c=relaxed/simple;
	bh=+2ELpIuu/kZoWmXpfR84iC7fb2SSVfA5Q7aDf1vNCF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lz1aogZkcYQzecx2wQCHeiqzAEJyoteVRdBF0klxEYVXJ0WopRweArV0Ogq8pGi7Ey4IHkaf0gH6cWDI/R6yBR7XFhOjR0xrgh6QnKZhTjcpjbfrmR4Ogxlh1wrvvQ/T0lMtIgOTFTq4WLdzGd9yeneEht7+H6DC+RcIkuJTxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At0GnMv4; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36da151a152so129954a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195998; x=1781800798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8qESLKmYNi7CYrkCCAoHviyQqGGqtEPjbAggAd2UYI=;
        b=At0GnMv4jDCP+WuCJ6jzjrLSYCgfIoLJSLmps25qmU33EFfWGHS1Aeyw/Wm5aT6aCP
         64VZqoNMxsVEXk4otEdWKVlDgR9ZqPaU8K8tEyNRAK6QsPkX2BHSsIC/vtqTtoq5LADI
         kaZ0k9K/bZoi1/KMVkRMDzKQfkOK3BTeCgFXwn2sZwTgfX4PVCJppHwwI773fSXJjwZJ
         SpqXKxXdKqqEZoAx8w43LkIqxlL/gES6vXyRsItWsxYcwk6o11SSL+s5fohoHcp/jObK
         gHrSlt8omlZkU/9/LrWrTDVnbwrWjE7lftxVWKQzAkDQ8pTn4lCCgKVULS6tHB3e0Rul
         ce5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195998; x=1781800798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8qESLKmYNi7CYrkCCAoHviyQqGGqtEPjbAggAd2UYI=;
        b=SOUi/kiIrJxYZ9BnZTin0NyEwrdwOOwL3XKMg1JyOeyyPYHbiyO4K0oeoLAFK9Swpl
         cVa/4joiBfagaDQBtPCr6AZCO7fE4/cS31BHTVj+gS1ODfxMwq6QvcTrSKZBjeLLN5af
         XEhaXM6Ok9Ol4v96sJS8EMH3DfMiMqU9Ba06G6b+n0+avoDmnIr5ue2rn96AVVoCb3/p
         MSvk+Nu2pL+wiajDEuINmboV05CjcWJBQkzU4gvyC+g1AaMirMRGZTNs1S2Tyub1EQ++
         Cshwlvbp/GrlNh/fvkDFQlAp1W72RldSXGsHU1deIFzfgqNNmkINiEahAp5VvBqtUPV/
         h8HQ==
X-Forwarded-Encrypted: i=1; AFNElJ/R88VxJHg2OjjQP6bdECD9GwFIdshuapnxx4KIhaEEqP50toU04dkn//ucvUWdAyB7P5PVYSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrr9r6RO0LH71A1uKGD1a9kGHJn87Zvnop7znyjWc6zCihOvF2
	D/Ip2B7T8oGJUkVHk79+givldnjBy09GcU+fVHJ/SIMDlopZQb9q2mTD
X-Gm-Gg: Acq92OE1Q8MKG87QnBx4tfPy2HTjWsXyM8iKs7ikK459Jk3E5pDo4389SXRtbqV4kYD
	fjJw1jcotuBdNS3gDdvRzshgLnyvqI5gnBaHeC4K9irt5FtPO0lZ81Gib6cMr2apuJ0FRy6KHO9
	itHqRc5nh71rC6Bvqh2AL8sEP6i3BYO4ECSTvnJuEpNxAcu+A5C00xeoFTEDHw0tkFfhVXUCakp
	NNY2eFrLvb9GI/kXhbbaduB8Z880rSNjms7s3XAm66ZLIIEbv6s/aRyCOCnKThji6GNw9o746OR
	UoCui5U2GOtuiznt4JqTiqf0UaZ1M4iVDZfDKflmtPMxEs9XXpIqsjNzZ0p9Ji1CxcPubOFXugQ
	HJUlD4E+vc//fYx7eY0VqRRhRznWyCY1mK2XYz27bT0OGJUb4soRU3j0jz2Htq8PB8+h/+Rwrog
	eyIGDMwwkWoAUJOeAwVzDwqmgbmRRhENs1yWzI1ie6rM3uQCSkzCjmrAwilkrho9dwN3hHQwMJ8
	3i2evO9wWxn
X-Received: by 2002:a17:903:1b66:b0:2c1:ed61:36ab with SMTP id d9443c01a7336-2c2f3544de8mr38081515ad.19.1781195997693;
        Thu, 11 Jun 2026 09:39:57 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f70660sm283186925ad.11.2026.06.11.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:39:56 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] atm: fix skb leak in sigd_send() on a closing listen socket
Date: Fri, 12 Jun 2026 00:38:06 +0800
Message-ID: <20260611163805.2151734-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,asu.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298228-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF405673CD1

In the as_indicate path, sigd_send() pins the listening socket with
find_get_vcc() and queues the skb on its receive queue under lock_sock().
It does not check whether the socket is being torn down. If the listener
is closed concurrently, vcc_destroy_socket() purges the receive queue
once under lock_sock() and removes the socket from vcc_hash; the final
free goes __sk_destruct() -> vcc_sock_destruct(), which does not purge.
A skb queued after that purge is therefore leaked.

Recheck ATM_VF_CLOSE under lock_sock() before queuing and drop the skb if
the socket is closing. ATM_VF_CLOSE is set by vcc_destroy_socket() under
the same lock, so the check is serialised against the purge.

Reaching this requires an attached signalling daemon (CAP_NET_ADMIN and
CAP_SYS_RAWIO), as only the daemon emits as_indicate.

Fixes: ae88a5d2f29b ("net: atm: fix crash due to unvalidated vcc pointer in sigd_send()")
Tested-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Link: https://lore.kernel.org/all/aigrk5B3VzaWgKIF@Air.local/
---
 net/atm/signaling.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/atm/signaling.c b/net/atm/signaling.c
index 358fbe5e4d1d0..cb80b5a9d8452 100644
--- a/net/atm/signaling.c
+++ b/net/atm/signaling.c
@@ -150,6 +150,11 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 		sk = sk_atm(vcc);
 		pr_debug("as_indicate!!!\n");
 		lock_sock(sk);
+		/* Don't queue onto a closing listener; the skb would leak. */
+		if (test_bit(ATM_VF_CLOSE, &vcc->flags)) {
+			dev_kfree_skb(skb);
+			goto as_indicate_complete;
+		}
 		if (sk_acceptq_is_full(sk)) {
 			sigd_enq(NULL, as_reject, vcc, NULL, NULL);
 			dev_kfree_skb(skb);
-- 
2.43.0


