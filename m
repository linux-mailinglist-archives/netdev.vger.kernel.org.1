Return-Path: <netdev+bounces-272292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOjXAdPIxWmgBgUAu9opvQ
	(envelope-from <netdev+bounces-272292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:01:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD733D53A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FBD30FC2D4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC273C060B;
	Thu, 26 Mar 2026 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="JwoWFS87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68033555B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569196; cv=none; b=Z1Ld8HZ+G4b9QmL073BjK+5nbX04gHJyKbuzDaM5gKVgPPinFgoxB/Lw2L5uBvVI3KDaV441Mmi5HMARPUE0o4Ni7BwDPAXLbtbx/bDe2rebnRXKhhKMO9Egf7+PjwshN86WsxULc63e0EFtVvg222AXQlm+6nEXpTK7sWzrNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569196; c=relaxed/simple;
	bh=pKyucMpUmEUvEFMBIx42AjbztCbNrx6csAdo92it2Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzWznhWa+F5Arb0z4ofPZSEm9buTwEzzduHlp7Q24m7Zld9YnB0g38pumlOnEiFt+xoZ32vCEW4GHoIaBsusAJQ155HTir+ZJH4N8mjSN/zNj7w+jbBghp5r8u+2uma1U+kizUBBlUR7knH/1qlooaTp9SdN/i+A1yl+ardVgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=JwoWFS87; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad617d5b80so10044735ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569188; x=1775173988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqiCKER8qXjRaUNO4Rk4CZBahew9NIm21W29yweRKzg=;
        b=JwoWFS87IOpq+uKx9Fqh8duQts3Mx0KQwqFHzfVCKlGLtvto24T2phCv+fOhy0l4C9
         tur+Er7cHLRarL7sfep5iR3aviRDR5klUP415UNykel10+ggDTfhBENcjuOvot0Nsw2B
         NmRNdqLHyBS4mEzTWt5IxXy0ZjIDgmib9e84+mv89YVarUWbFuR1Lvc7cQg77lZPemjN
         1jVkrbnc8WVrZH10WLb5lCbPWr07DQFMAAfYVAnTTWgtLvvE3BzBl+xaLn3+gBqXoe18
         j2jY9sJfsnaNddaZq6hkHnLrSJ/gd1Ze3o5dALMm5MRAWNwtNUmEtnZLrMUIgKaKfq5y
         ohXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569188; x=1775173988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqiCKER8qXjRaUNO4Rk4CZBahew9NIm21W29yweRKzg=;
        b=b/EjOqyjcOHrgtOQfn7X4WH5dJwd/yhpbMkFoO1zUiF1Q8u4nZrmavmxdLqrYf+yvT
         5W2ahmrppFYR0UyfWS9Esd1zxVSLs/A3N2h4Ho2bGVvAy0obZiHg/FN+CVluiTRtv1Ku
         fX1HVwjZy+DnKI30/t+G9wAmTayzL7XC8xCIg8uUs/PM3r3pHBVYV5+UtP3Fjmj+I9z9
         4KafCLtvgpgV2DGqq/v6xcVF+w673bmuz4IyZwFfBqb5bJ5zOtYlIYJ4THdCluXmvAcI
         qLz1hN1upO2NySbtmW7VW1qJqYYY9JynvRaNcwbZ5tDzGv1BjJASmj7r8ecl3ioWkGvV
         OHJA==
X-Gm-Message-State: AOJu0Yz5OwHnteljNMcM6GQn+wk/wMEgYEjDSbJO3+YfGpxHHMfA/x50
	bOLs6X02Kb6zneP2A3w8xAlBcNY2/ZDtIwxGm1PNzneiaOJR2oq94iz3KMj0uTYy3zqVK67SHRV
	ZfKdzr/0=
X-Gm-Gg: ATEYQzyAIRe7Sr0G40MDqsOS/p6qOY/3WoA8+KomTr7c5tjaO/l0P8bKcljO/OKZsMC
	BApWt22QVmyEl1Qz/42YWFRZSe6qNCZ+T+E0T1mfFJSrDeppvmsBnGimCVgWlXBrKKfvSnzBSy3
	ZW5rvrXa9BMzLtV4O9I/SI4UYFPUNkUkFP2PtzPDI9pD8Y0OwocmKf8y+DzJMsSi1Sa8ihlBl9B
	zxV/iPc91nMvog9bOOYCNr87iGp4KKnSApv4iWzdjBmnzJJZtvecbR8tUdD27Y1OgKAm4hpD944
	RXrB16IvD1SqC+7LcteHfxZObGlal2gBjC/NWq/kb6DS4h6EpAgqBBaWiXLHJYKgl50XwzZacHB
	/f3PAk9uC0xbeqjfgsV/5Fb1pKD7UEXH2OkByyfYaLkYcagER2Fh3drAuh3d5wZZXWGm3QMxuW3
	R/r8XO5ezKCYI49yQ=
X-Received: by 2002:a17:902:da91:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b0cdc238f3mr5392445ad.7.1774569188532;
        Thu, 26 Mar 2026 16:53:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7b233fsm43338585ad.32.2026.03.26.16.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:53:08 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v6 10/12] net: bnxt: Dispatch to SW USO
Date: Thu, 26 Mar 2026 16:52:29 -0700
Message-ID: <20260326235238.2940471-11-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272292-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5DBD733D53A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 946608db92a0..bbbef1f1fa70 100644
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


