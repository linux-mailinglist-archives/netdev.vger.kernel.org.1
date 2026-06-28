Return-Path: <netdev+bounces-302382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z5JAO8XSQGrHiQkAu9opvQ
	(envelope-from <netdev+bounces-302382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 09:52:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8056D3615
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 09:52:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=Nyow2sfy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302382-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302382-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A26AB3010241
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2E36D9F9;
	Sun, 28 Jun 2026 07:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90642279329
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 07:52:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782633151; cv=none; b=b5nJkFwEd7nbRmjVqMkrtNlDq+h6gxLv4wT/mNgxswCZhVonkmGkpqNu51u/jwRtZUzq+E92SdVaAg+ZxKtN8mede32h3M/nyQF6pCs0HLY6Vx+YqrErY9wqzqTcuGe3exio4PWAImpyXBER4EHRIeNM3+dBgkMkCVCZ/IrHBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782633151; c=relaxed/simple;
	bh=eWs8hmQVn7ooRFzr/P0NKEX8NsdyZEJ0N/JK7ANg7Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgc3scLD7l//OYn4CPEPwcYrUMNxAtpCjpkdSTGmCWBXxs5+NUhaLSH+RKpYesHzfSvIeg6+zng0x+TuRLSyKajTc/sZdjNMYDTSFhUZJcEA5Gik6BQt/flcfc0gjoIGhca3mYcEi8d8uV9grcxgJITxWUJoxQmxBISotQYZDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Nyow2sfy; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37ff436a048so71333a91.1
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782633149; x=1783237949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKHu6YV0p6k8NYhU5hftHrqraq/fLWFejQIMZ61Edm0=;
        b=Nyow2sfytcGKjEd6CxDmuprdJpXdprsmT0sCDAAPwvjfkQcWTNrypPiWTfKUESURKo
         iWcBdxsf9p1EF6brqFiKFPobxl5j9oC3Jo3wvMREI1M7Tc5YX+1RmpYanSbcJXZZzG30
         6C0sTA/sym4VcQeEQyOfZnMFL+DnLIAMm0ueeu9/fbiWS7qTWQJIS/fRcCCnqMiCgaJN
         v5oSdiKj+noATwtMUTV/i+MYOJfxoHt7FI9QZg2dBDkO9X1X2gzmdLN9/q4jNskVGPb2
         4HJAHqvkbAR2x3g2s2kulxjnxyiQ2Ob8lYhaesAOGNBJkprQmeYRZxqrasdP1ZWC3pMb
         2/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782633149; x=1783237949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKHu6YV0p6k8NYhU5hftHrqraq/fLWFejQIMZ61Edm0=;
        b=QqG2V5nEErWklDieIYy+cceyhLdD35FG2Bgo22+UBpRF0SDRTiiUNgutSpzcTnMwJz
         QGQiHqrQAuy3HvqiUo5ebaqUWbpd3kpPbfIM3oCNFOSXbPigpSYIj8OzvOjc2qT4XCnw
         uY9nMDH2JGOXHqnM9hdVo2r86tVxveboJ61aQL8PZTIKnHRWmda/dJ/hfc1q24QlTl2I
         ibgS5ddV+9oX9pwfI0bYSA9z5FfZO89tgOMo4BsaIO2mcFwoyoGCY5rawjvb/DywKc9e
         QLjzQBd+jSrHWGlyDNXtzcBnHO+Uv3zXKRVAKYrpRtIj+Q4tQZ+IjCwvRUeziGieEFQZ
         vGDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZ3UuoIOSDnDk9KAPCu2EEN7mbiw5Y31zcDm+isMeWO7PSJfPCWOGJNiLYNWmvNSh4h7C0rg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaFj9rcG8Bne1PFkOTE5MCi6CsrUScaTqu80ZqAuNLfSsRYCm
	AraMvEdxn/pr0anxDegiG/EexwgAmdgGvscYnxYIdVinh65YiDNKpy1/7cT1xL9EZQ==
X-Gm-Gg: AfdE7ckQR5Df8UL1Um/c3P9E805oXAECuV/+Twfx3UmLMHrRX9EZLn5PSnE3I5zQCOA
	3zeSotK9RWWakkP6++MidZ2TJblpGNUnw0yEs4YTDkgfwYFiRZ7Yq3w8oYVoR9gkRlXRtlt/qJa
	fFHIAp1Ic5hld8fPC+v81Uyrv0ncRkomTvf1570Mg4Xb7V199zkC4RH/Hi0bS7leGs0LT+0zEaO
	+dlvA/2ePjXV48LA2Dj3wwk6QfUUsYuKc4VZgXjquWaJyQoC1vcjJdc57qujapo+dcQO5hsSkKN
	a+hzt4/lRna/+iUZmcBxjzbDACLRWZBMcVXJC74lNFIdQgSV+lGm5FVvEE8myEXedb6Wb3o51HE
	tx787H9v9eur7K2ng4f6Rrsad1W0eHnKB7qADS6t3ArZPhU/e4Yomg+yOyZc6BlZ52ZF/cSud4Q
	==
X-Received: by 2002:a17:90b:2743:b0:36d:f28a:c5ee with SMTP id 98e67ed59e1d1-37dfa2c7ba1mr11774058a91.25.1782633148717;
        Sun, 28 Jun 2026 00:52:28 -0700 (PDT)
Received: from p1.. ([2601:600:a402:c8a0:f57a:7d6f:5cea:797d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ed2a68075sm3354470a91.10.2026.06.28.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 00:52:28 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net: qualcomm: rmnet: validate MAP frame length before ingress parsing
Date: Sun, 28 Jun 2026 00:52:05 -0700
Message-ID: <20260628075205.62280-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302382-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:subash.a.kasiviswanathan@oss.qualcomm.com,m:sean.tranchetti@oss.qualcomm.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A8056D3615

__rmnet_map_ingress_handler() casts skb->data to a struct rmnet_map_header
and trusts the on-wire pkt_len field without verifying that the skb
actually contains the bytes it is about to dereference. When ingress
deaggregation is disabled (RMNET_FLAGS_INGRESS_DEAGGREGATION cleared), the
skb is handed to __rmnet_map_ingress_handler() directly, bypassing the
length check that rmnet_map_deaggregate() performs.

Three distinct reads past skb->len are reachable, so three guards are
needed:

 - The MAP header (flags, mux_id, pkt_len) is read on entry, before either
   csum branch and even on the command and non-csum paths, so a runt frame
   faults here regardless of data_format. Guard the header first.
 - On the MAPv5 next-header path, rmnet_map_process_next_hdr_packet() reads
   the v5 csum header at (skb->data + sizeof(map_header)); the entry guard
   only covers the header, so this needs its own check.
 - On the MAPv4 path, rmnet_map_checksum_downlink_packet() reads the csum
   trailer at (skb->data + len); guard it under the same CKSUMV4 condition
   the read uses, or valid non-csum frames would be dropped.

Each guard uses pskb_may_pull() before its read. The MAPv4 check uses
ntohs(pkt_len) (== payload + pad) directly rather than the derived len, so
it is unaffected by the u16 underflow in len when pad > pkt_len. Well-formed
frames always carry the header/trailer they declare, so only malformed
packets are dropped; this mirrors the length check rmnet_map_deaggregate()
already performs on the deaggregation path.

  BUG: KASAN: slab-out-of-bounds in rmnet_map_checksum_downlink_packet
  Read of size 1 at addr ffff88801118ed00 by task exploit/147
  Call Trace:
   ...
   rmnet_map_checksum_downlink_packet (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c:413)
   __rmnet_map_ingress_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:96)
   rmnet_rx_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:129)
   __netif_receive_skb_core.constprop.0 (net/core/dev.c:6089)
   netif_receive_skb (net/core/dev.c:6460)
   tun_get_user (drivers/net/tun.c:1955)
   tun_chr_write_iter (drivers/net/tun.c:2001)
   vfs_write (fs/read_write.c:688)
   ksys_write (fs/read_write.c:740)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   ...

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index 9f3479500f85..83d011ed5942 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -61,6 +61,9 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 	u16 len, pad;
 	u8 mux_id;
 
+	if (!pskb_may_pull(skb, sizeof(*map_header)))
+		goto free_skb;
+
 	if (map_header->flags & MAP_CMD_FLAG) {
 		/* Packet contains a MAP command (not data) */
 		if (port->data_format & RMNET_FLAGS_INGRESS_MAP_COMMANDS)
@@ -84,11 +87,19 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 
 	if ((port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
 	    (map_header->flags & MAP_NEXT_HEADER_FLAG)) {
+		if (!pskb_may_pull(skb, sizeof(*map_header) +
+				   sizeof(struct rmnet_map_v5_csum_header)))
+			goto free_skb;
 		if (rmnet_map_process_next_hdr_packet(skb, len))
 			goto free_skb;
 		skb_pull(skb, sizeof(*map_header));
 		rmnet_set_skb_proto(skb);
 	} else {
+		if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4 &&
+		    !pskb_may_pull(skb, sizeof(*map_header) +
+				   ntohs(map_header->pkt_len) +
+				   sizeof(struct rmnet_map_dl_csum_trailer)))
+			goto free_skb;
 		/* Subtract MAP header */
 		skb_pull(skb, sizeof(*map_header));
 		rmnet_set_skb_proto(skb);
-- 
2.43.0


