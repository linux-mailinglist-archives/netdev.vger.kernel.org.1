Return-Path: <netdev+bounces-273794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGoqNCVpzGlXSwYAu9opvQ
	(envelope-from <netdev+bounces-273794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:39:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06A3732B5
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F41223029F75
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA71BD9CE;
	Wed,  1 Apr 2026 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W1qbRkvU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588C1A680C
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003929; cv=none; b=hwMU7lh4o45YZHSFLUxmItbDCCynTKZr1kf5jsP4+68vqejRhsXpFGWLKkr0Q1pLUGW4ryk/Pu82DpfS5vL4b+FrYBdId7YeOpvRRZXK8rzl6i0eaL3KhmRb6jYgU8qUGW/rOpVA4/+TpIljU0jAqlr/GEBhbGnNRGkecKDEMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003929; c=relaxed/simple;
	bh=FKS1l8B4iRLYjoPZ4ZCQvX1ylPejp+uMV3jJCEcCCkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCVuVIy90SggiUSwKTOo683JIM3Y+85u4UF8P9nqq74iTcBRgm6GJ0GiTLFOBNsxZR8eTNE3iUkBpugafqz1MlfuhWuTLLi/LBSVIUzCIDpHUR7VlqDjxXO81fVMduJVHN6JZK/Hcmbt0vxZdwlncDllUhq3OW6DJidtuU18UQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W1qbRkvU; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so1462897eec.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003928; x=1775608728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYiLqhfEZMc7XkuMVbvPJdbLFT6h1JgI6C1KdlgLPZw=;
        b=AYEoIEQWnHcyC9vF7eXrcHMS6vkP3tO1FyCsuzIvLSR2Imgsl/lKsQERY4w4T1UbI9
         QwB+F8D7l2OjP5hdDF6RJKJffkUmQYewzN1bR0cJkxzD0D3lYmvqAPA4LbwBWXEI0bSf
         FQwhRkGarMQNXZzDz2ZXUl39pcjF4ArTojYUp9DMNwISdJhp6U/dtsxdzLs08sWr1F5F
         Ru2jIcet24cmKSkohLvbCGrDL5uPjnm6OxIMyBtkLKWx2cTgVPBM4+WK90Soe/pu0ZBQ
         JtfGA2hf8k6ldp3IJbcegxbkqHQf9fpWVgHXCxtyE7CvwIlI7ah0g9ddxNqM7A9TQrk7
         amKw==
X-Gm-Message-State: AOJu0Yz5gcmMYm7f1pwMOGZL8PdIRbn/PKRIjXdvKbMJiPny5VpmkkcJ
	+u+UUVeBn9rVICtWUh+QJaFBsq+GnWdGIzYr6tOMgBQ/rn2uvf4vgXWx9P4+FITbwedXEKzWafk
	bWXZJiSN+br45y1sPiLKV7s4Gb/hYtrgninsQSzY9ahEDkAXi4L40GEKdIaQRU2Ta/E7iJn/Zqr
	gG+RUPO3sfzS32s/CPQ2Dk2izT3GmFL0AgiTfsjscBeXn6lwBrvszEVXCGKnPRjDOqsTYd4u5xJ
	MPyrRkGOQ==
X-Gm-Gg: ATEYQzwxvYohqP3vb0/Gc7ZIr3SXZFURb9ryrI4lp6EYh0Eo/6rP/SXzCEffRLVusbb
	6Uu4nUHVUStTnSaBlJ1v0aGursvOuSB+Eb2IQoBiDIOwceYyCyDAwUnDBONdoiyazY03SrHvE3d
	iecTqOrY4IRz20fLmOFETLVc1sNEsBk40/L7gomeLl3PdeOX0MvTnO1JLNf30occtUz9SJEg1GO
	q+nFHVYJhc89qPIEip43lG48XeKx7KUjbHcwQPZJLUgFotzfx7znWXQXU38xtlYWvAw0PiQpt5I
	Ca8Hj1T3Roso2p3ey8L6uI6aYch7ZP8+zDuMyeg4ymOy+NZtP9Ga6Ad+7enCAC0sPWoqqb4WZiK
	Rg+DfSjvbLN+XmxuWCm4+QebWWZm2F3Ot65PUcPrpiKSk+ue0v6y9u0l0IIltKx9n9MsLZPxTPQ
	iT1Y4=
X-Received: by 2002:a05:7300:fb8b:b0:2c7:2c0b:f33b with SMTP id 5a478bee46e88-2c9323bacd4mr936231eec.20.1775003927482;
        Tue, 31 Mar 2026 17:38:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2c963c7622asm43261eec.25.2026.03.31.17.38.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 17:38:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-127337c8e52so10072217c88.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775003925; x=1775608725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYiLqhfEZMc7XkuMVbvPJdbLFT6h1JgI6C1KdlgLPZw=;
        b=W1qbRkvUtf8DZ5169VuKDWqfVQVnMBCqT68VJ4tJ7fD3Vr/WaAMAPTXgL+HF1tFylq
         JdIyYg3MQlGQ/zW1xmmPNG/0PVNIt79bAC3gN72V8pbZLp9XG93AFaSIqKOGyT8SPcD9
         f5jzVVwXwrqNWbZE3ZbeUNt3UHag2On3+Pr8E=
X-Received: by 2002:a05:7022:123:b0:128:ca6f:adf0 with SMTP id a92af1059eb24-12be6557593mr994199c88.17.1775003925337;
        Tue, 31 Mar 2026 17:38:45 -0700 (PDT)
X-Received: by 2002:a05:7022:123:b0:128:ca6f:adf0 with SMTP id a92af1059eb24-12be6557593mr994181c88.17.1775003924678;
        Tue, 31 Mar 2026 17:38:44 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm17663190c88.4.2026.03.31.17.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:38:44 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	nb@tipi-net.de,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v2 1/4] net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
Date: Tue, 31 Mar 2026 17:38:37 -0700
Message-Id: <20260401003840.3112454-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401003840.3112454-1-justin.chen@broadcom.com>
References: <20260401003840.3112454-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273794-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA06A3732B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The write_ptr points to the next open tx_cb. We want to return the
tx_cb that gets rewinded, so we must rewind the pointer first then
return the tx_cb that it points to. That way the txcb can be correctly
cleaned up.

Fixes: 876dbadd53a7 ("net: bcmgenet: Fix unmapping of fragments in bcmgenet_xmit()")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 482a31e7b72b..0f6e4baba25b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1819,15 +1819,15 @@ static struct enet_cb *bcmgenet_put_txcb(struct bcmgenet_priv *priv,
 {
 	struct enet_cb *tx_cb_ptr;
 
-	tx_cb_ptr = ring->cbs;
-	tx_cb_ptr += ring->write_ptr - ring->cb_ptr;
-
 	/* Rewinding local write pointer */
 	if (ring->write_ptr == ring->cb_ptr)
 		ring->write_ptr = ring->end_ptr;
 	else
 		ring->write_ptr--;
 
+	tx_cb_ptr = ring->cbs;
+	tx_cb_ptr += ring->write_ptr - ring->cb_ptr;
+
 	return tx_cb_ptr;
 }
 
-- 
2.34.1


