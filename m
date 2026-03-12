Return-Path: <netdev+bounces-267226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCHLMQhAs2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:36:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 426D427AF67
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 598F5309BB9E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214123D333D;
	Thu, 12 Mar 2026 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="T2KjEnT5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D182FD695
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354930; cv=none; b=SBD0G+1Fk+nQAkU9c/Y3j/TMPQUmhVQxoTU2dyITUM/1TEgEsa+210uuuPOJ6vDFWIJfRiecmAgosomx4cm9skFLaccyTR/RBezLwIRwmB+yzk/skXLYx4/Yd20lbiSYOfmLXegufH9mvCz9vVow4sJJbrGsl15bG/ttM8xj+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354930; c=relaxed/simple;
	bh=NVUYBlGIFPOzvTgwiM1AqtMx+naqD3Qm2M223Xx4Pnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB4ONP5p7vLyhut+jW+E11z5lRhQ+wS7ilTyCN/C+x5QFAvq/o0qoXMjPvkxkS6RedZVqI7yomU3ighFgS3HgYdhZ5egxf+DLPTsqCjmmpUG325/0G4Grgt5OVFcfGSDBZyJQNlMXROtI2BO9xzblqnYXeZ2e70yHYtVmgoFVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=T2KjEnT5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso708284a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354925; x=1773959725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NktXVc512r2uSg71OOoFRo+j5rlYWgIN6qvWki50uU=;
        b=T2KjEnT5rgqMaWEF7O45OaLrj26om6HRdQkB82EyLSk6W+CQyxPqvEPRTKDq1EHqV+
         nwMAr1/+xc2TP67naQPIK7gEmObsuESzBYJI44yNnYOn8mrhReXsgeBHWKJiMb3hRSC2
         WNT4TVVrn0mzFkxpE9OllKbVFyZ6cZrhirPYvwwLklXu/wECJAhHjyq6Appgq91EmrHz
         GueexyjnRtjplBHKjpU0ytBxi/M4jZ3ArSi09rNVMKiFeK2VYX5/ke2AgdFhTO8XGDY6
         Lb0SXMoCPrn3MaQLpAmfv9C4ZY+Zpm56Hyvz9VjoP7jwSAmwDILr7M7v8rAF5q8kpsUO
         vAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354925; x=1773959725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NktXVc512r2uSg71OOoFRo+j5rlYWgIN6qvWki50uU=;
        b=PcYrVhwEyQP4325SXvZu6svWQbCPXc7VH9+lCnYpD/H4HexsMJiy0eTDq5432VzCyg
         PmJzQVcDKiAkn05RjZml5RrPbjovYtoLnC/ki/+bMB+eCZmo/dSs1sGCekSl08ujYqWJ
         aH7rkkor7kxGfWMCkKQPIv/xvUpFozI9qJ0Jtt5zSf3EVdQJjSCvzr1YaVm4ml5Fmad7
         1vtB/CWfasjuuLw8CI9kf0FxbrFvLiT61Q18qy9mUrUhp45xdFiA/dhcFMtXJ1NBx2D+
         FzIGCpKvku2gVy3LAaXQsszJwj45pL2ozbR6F88J+g8pinGmb93vHJf5EWWbP05177HS
         OxRg==
X-Gm-Message-State: AOJu0Yzc1XNxMwBysAnfw0tmRO4EXCE6tQM/t/KFeKVodKqPcKrwHPKZ
	2G5Pp10zagqv0bVC/XzTvS5/NgLkryKpfqxpPddMFj/VW7r72WLSGByhumHXsgA7+fmUHgDwct/
	1Hzl/Mks=
X-Gm-Gg: ATEYQzzNj9OJd/d8QkL2Jbu9c7OvK/Q5HtjBg5Rcv9MVCmRx0qYoi1aEFERDtm6eOUO
	XjI6i4UGq/znOzkz9j5tIZKhEfcfkz79B0GTFNXUYvzwegCjwqNkHA7LWFQEHuhXIBNsg/C0Wh7
	4was/GIdX+/EzRXPreiGjn8G906ZU86q2MeqMK2oHLMjCR3Lwnb6Rn/Zr/7qIXcL0kqENCCCO3R
	Y3XJm+QEiODAyDpVqbnI0fAzPkGT/NaJ9O4sg/lvcAAa3oF3YF+Y28sjptMlPqAnzUGf3i50V70
	SqlS7gXZNPv9PyCZROWK4YCX7iLyGIviGSequLlQgFTcGo1gw9Qjj0y+/8tDjI5kzipj8b3ljkt
	0EhNGDgUFLlRNUmzIIe1sk3jbcXelSoWtVlXLFilQ503Cw9QCPI+1qB84uGhyCq0jPRCg8uLLd4
	n8x5ALdiCXyNrGlic=
X-Received: by 2002:a05:6a21:2c11:b0:398:80dd:5705 with SMTP id adf61e73a8af0-398eccf385amr678068637.46.1773354924927;
        Thu, 12 Mar 2026 15:35:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738bca8sm3905934b3a.60.2026.03.12.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:24 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 10/12] net: bnxt: Dispatch to SW USO
Date: Thu, 12 Mar 2026 15:34:47 -0700
Message-ID: <20260312223457.1999489-11-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267226-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 426D427AF67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 60daf813154e..c09772aa2b32 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -508,6 +508,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 #endif
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
+		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
-- 
2.52.0


