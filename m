Return-Path: <netdev+bounces-293150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MgZGDesGWpEyQgAu9opvQ
	(envelope-from <netdev+bounces-293150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:09:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A1604501
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF22F31BE234
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6CD33F8D9;
	Fri, 29 May 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNaDX/qM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181EE3EBF24
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066038; cv=none; b=bNmUwe2rCJOSFF1zaongL3K1sDwKcPUf9tYB4wfDrKaflronlrP5gq4sJVdw4oxK0sfKB/l/vf7PV+/TrRvpAG9qcI/0Xg+i2PXVloOVrnlIZspujX4XBkBz6yHdtb6BZRhJ2bKOwww4IBeWZeanNaLcd+/oyWeW0/Iiyq+7xJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066038; c=relaxed/simple;
	bh=ltwZovjUZ2vcGmHBKuZt8cbOq/0lKBsTreqFmZ4Nzx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNZOtqtlnM5g+e3txmuG93oB3fCI4Nz6wKNmJmunKYR0ZSK1bb02UcQVyukGQh9DQp7D0b8pj8IIjYbmqVY6DPTq1H6fimbUCpmT/gLCZE9rL8QD7WAXZT+VPS/+3/5839uqBUizQtMjRFPKp/s0n0j6WgDgw/TLgzj/4wPQ9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNaDX/qM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0882E1F00893;
	Fri, 29 May 2026 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066036;
	bh=UvIw1sN5KwmjfI9LyMdRK1j0pBF09VG7im6Gd0W3NWE=;
	h=From:To:Cc:Subject:Date;
	b=SNaDX/qM1h9fRG9xqHzMWAt3mYxSb8AObBDWuZzhahIzoRjROzcFUdOTwBZ03JF4w
	 H5UinznNP6BwQsZ2HpW4fUKskfxcvC2qn6HU3gZleoYoe5NxdwAg3ef6A4bQ0UzRj3
	 8PLZyY43ZXwBCYUk7Tf61SxDln+vZcS5BmIn4UUXRVTM6i/w1jJ3GI1yHCizncUcsp
	 5G6g3nkbWC4IpRv6x4veIhw2Xaz/g+y9jUqBq96bhzlMY1OxvgGSwXirDrwDLNKozW
	 VVNZBYpwesI1do34fWyxWcZ5z3g0jynMrogYULorw3HzTXCtZeV/k3Dr0/ZPadnDKE
	 7Pardk0e/kCfg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] geneve: fix length used in GRO hint UDP checksum adjustment
Date: Fri, 29 May 2026 16:47:00 +0200
Message-ID: <20260529144713.780938-1-atenart@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293150-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atenart@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D8A1604501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In geneve_post_decap_hint the length used for adjusting the UDP checksum
should be 'skb->len - gro_hint->nested_tp_offset' (UDP length) instead
of 'skb->len - gro_hint->nested_nh_offset' (IP length).

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Cc: Paolo Abeni <pabeni@redhat.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260521131436.748832-1-jhs%40mojatatu.com
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c6563367d382..715180c3a1b3 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -632,7 +632,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	uh = udp_hdr(skb);
 	uh->len = htons(skb->len - gro_hint->nested_tp_offset);
 	if (uh->check) {
-		len = skb->len - gro_hint->nested_nh_offset;
+		len = skb->len - gro_hint->nested_tp_offset;
 		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
 		if (gro_hint->nested_is_v6)
 			uh->check = ~udp_v6_check(len, &ipv6h->saddr,
-- 
2.54.0


