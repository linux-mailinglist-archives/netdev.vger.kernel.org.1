Return-Path: <netdev+bounces-207456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B80B07525
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EFE583D78
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F552F50B6;
	Wed, 16 Jul 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="av3nxYxK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B22F4A1E
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666909; cv=none; b=J94i3hky8DJ28pv12p3jgIrALQpxHXUSCZbqjRU2ZjoU/ZjfO5KgxCSVHU+Rj4I+FoBtG36ewlT7vYiVAml81mhsKP2lwnWyq/YVURMLWudOQSEj3RGGzNeVSEe2wwFG5iFgz8/RtmcsJ2ag7hUaKPAtacoJte9T7f5V1VY0YDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666909; c=relaxed/simple;
	bh=n1CmIW4ydj3nNk9kLxEDrgG5jUViDoe3ELYqlFKv98E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpTHRGdri79S1Gzs9WAgh4mhdP+MmALS/N67WK2HJJfw8EmhZ5c3fIkUye5t0NKQtYGGcN5fu/ZrCZ6ERIs0S2rzd7jMqDiUCIU3/IZhGkE1enB9f20qs8ggjylEUyOtDxHZP7yYWVe/7rpJWcJ00inm8Wr2Q72X/DZ6H8YKWr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=av3nxYxK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so10847970a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1752666905; x=1753271705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcNeGiKpO8fC3Ox97SV3Ky1dSlGLIE06AiTXTqVjIfs=;
        b=av3nxYxKxg/hbWdRWFxBB20A9nD1sT2RXds/L6ygLlnQ4XzXn7krffCnJ9e31VFbUq
         UrPsxGUIDkKWbucaWopEmqwzXZKLZqaLxpEia+bPLyGgIhYtyUZ0dtDzGHbDxnW3Rai6
         P1PdIlnf3HFeYTEzogctAj2QjcBlszCpF6cIk3s16bH6XS6CQmdwzNHaPR6QHuUJID/w
         7tSMK/uNInHrs3eGrhC/rLrsWPX4KKxN4w1eS2zi7kyFGtzTYuHxE/F4fSFsONJ/+3wr
         z+/m+Ba95QUUSeiieyvT1GF20hVgJARC9DgyWm7TthpmK9RRQHkdVFizuETQ8C/PV3zY
         fZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666905; x=1753271705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcNeGiKpO8fC3Ox97SV3Ky1dSlGLIE06AiTXTqVjIfs=;
        b=aDvM0wt7jYORIVCycqQHyG5x+BpZjQHgyQn1lnWXdzsOIXXUtw8Q6wSVz3SL3VdNwG
         bQr7p/1QZqMtfSkXGDARb4M02tn+4Ri2dYlAmOtZqXY0wyB6iMeEpR7nWF2bGbCn4wei
         XoZkI4PPI6ChO7v5Rv3da0RutIyZeISKPVFrTi+65z47rq1jKwvhbA1j0WuZcrCQAbSt
         RyIBbf6rUNymSHABdUqBzhVYOgCv+Jk6XeVEgtklS2wNgPWn6dVMSsQBDnl51XN7T84W
         3YX7xazvos0NmDJV/A7lP1TFr5sU3tUJt9Spa/3uJfwt4E1BZKSXRDBWjYFFKUQj19t8
         pYng==
X-Gm-Message-State: AOJu0Yxsh2PudY4+fNpdK1umHCUqCmtmjuReuIzcWpl/FO28JJIDcKME
	dz0dlWA2dPgGwc07I5TFuwasnO/wLE6HkA6BRFZkRNjel8Pl8d/FUZhDr7dtc43+/tDmZoE6PIl
	wJVuoTK4S4Fi0cu8cRmHokwOelRxLGiBkcF9RcXErLOiBfBHGle1qcx+Bhftl0JE5
X-Gm-Gg: ASbGnctjlsmE3VPLFqf6PoJ0PUgwRF5H2SjLMKr6MQm9S+W6GxR9nIa2TLvdTO9hOjc
	eufA8f635K5ImUJ2RDxkVuVVAidLe8WQOPJO2PqNCltwr97cKCGULd2tf6ukbdFELPCulRT9u+w
	jwaMynScesPh5e9Y6zilSbSJ+3LxTmAra+eLIV3eYMAxidRrEFvHpzcHh9Xj+PjAWdxs7Wxbwmr
	1SJpl01vwK5TwJd3FNU8imd9WID9ZTYTZiUFciKuy8EnWZ6KIgz6/M1aM+4jS2GcBQ4dYvC95xS
	aJX6KDYW1QiUg/KYoj3EQY5nchBD7qzatF4/yzglj2XCyZAekbR/zGdKyZcUXn+VcM3j1P8s5is
	egKNJhZNg1bNeYDnHANMdj6hVg1tW6JVYslg/2PwTaVq7BNqAywvhJWbI
X-Google-Smtp-Source: AGHT+IEk/eea0bMdXgNsKY9GOkArYnleDhfcduy0qhpwPOHBUU8UK1/ccFo32t6ur4YWhdCfnh6EeA==
X-Received: by 2002:a17:907:a08a:b0:ade:4121:8d52 with SMTP id a640c23a62f3a-ae9c9997326mr327356466b.16.1752666905103;
        Wed, 16 Jul 2025 04:55:05 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:96ff:526e:2192:5194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264636sm1169169666b.86.2025.07.16.04.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:55:04 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gert Doering <gert@greenie.muc.de>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/3] ovpn: reset GSO metadata after decapsulation
Date: Wed, 16 Jul 2025 13:54:43 +0200
Message-ID: <20250716115443.16763-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250716115443.16763-1-antonio@openvpn.net>
References: <20250716115443.16763-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

The ovpn_netdev_write() function is responsible for injecting
decapsulated and decrypted packets back into the local network stack.

Prior to this patch, the skb could retain GSO metadata from the outer,
encrypted tunnel packet. This original GSO metadata, relevant to the
sender's transport context, becomes invalid and misleading for the
tunnel/data path once the inner packet is exposed.

Leaving this stale metadata intact causes internal GSO validation checks
further down the kernel's network stack (validate_xmit_skb()) to fail,
leading to packet drops. The reasons for these failures vary by
protocol, for example:
- for ICMP, no offload handler is registered;
- for TCP and UDP, the respective offload handlers return errors when
  comparing skb->len to the outdated skb_shinfo(skb)->gso_size.

By calling skb_gso_reset(skb) we ensure the inner packet is presented to
gro_cells_receive() with a clean state, correctly indicating it is an
individual packet from the perspective of the local stack.

This change eliminates the "Driver has suspect GRO implementation, TCP
performance may be compromised" warning and improves overall TCP
performance by allowing GSO/GRO to function as intended on the
decapsulated traffic.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Reported-by: Gert Doering <gert@greenie.muc.de>
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/4
Tested-by: Gert Doering <gert@greenie.muc.de>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ebf1e849506b..3e9e7f8444b3 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -62,6 +62,13 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	unsigned int pkt_len;
 	int ret;
 
+	/*
+	 * GSO state from the transport layer is not valid for the tunnel/data
+	 * path. Reset all GSO fields to prevent any further GSO processing
+	 * from entering an inconsistent state.
+	 */
+	skb_gso_reset(skb);
+
 	/* we can't guarantee the packet wasn't corrupted before entering the
 	 * VPN, therefore we give other layers a chance to check that
 	 */
-- 
2.49.1


