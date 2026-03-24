Return-Path: <netdev+bounces-271164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ELSBti5wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:20:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C43B318E5E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3F53038AC3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C33D16F6;
	Tue, 24 Mar 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szwYRCD8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C637F72A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368800; cv=none; b=jJFBsi738LYcB/D82EGQhuFc3iBw2dldqsF0nxBNFrQPwRk+DzG3BFa9gxHI25xZgZn3ZF10u0n3ze5Um4UzQscZ1sRtP2TiPdDaHQ7r+EhPPKLDpgC4xLlAnxLe5noSNv+g38uqcCmlMaOtGn2vU5sMizQkfGwIBY3JDAKix3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368800; c=relaxed/simple;
	bh=oYHQGhASPStF1F6gI09Wy+VEIW+XOsrmKO9LSY6Yn7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b22tQX3Y05uJm2WKb1lcWO11VJk4+c5MwanwJGWiSRhskrU1loPdwbHw65SAOVsehSAcArjEUIBuSfRGBP69GAUps9N8BajSaYqwZRDZ60bakF6JpoCG4iD97YrH+4hiOAygi3Mc8MKwR9nSpG2sPeqHMwiPdmEzYOf2ws45uqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szwYRCD8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fe655187so52542475e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774368797; x=1774973597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Efpb+LqGSJ0Wl4bNfNJO+gjcYGiuows2jBcjKXLuEQ=;
        b=szwYRCD8bW2Xhr6ooZbkCVrsMQvQF5jlajnfmGsGtZDESh5zOuWfhH+gClewSDDlAP
         f9NT2ptiCOwu8KRKTLpZ4n7SzHV675nnJzil3avN8ojQmdkLcZDyaUHZlQ6x96PrBcll
         RPKZocy2EU/SB6WlAiKiIcE1DnQwm4IGepZFAj/MQjzzaq2XQbC7vO54VaPlbBVsPeLm
         6+Iox0xSGfMF5pc9zbVhLxYVhxMEe4A1uFV/NKs+FMtFf3Pm9y1TDoFAYUurc/bhfWEZ
         h+EnMx6eq811+AOZ3VQ/ifTqjNj1VQsryPgqGbvRTyAdM57EZlzek6h3SUOl7K1aYFY2
         g6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368797; x=1774973597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Efpb+LqGSJ0Wl4bNfNJO+gjcYGiuows2jBcjKXLuEQ=;
        b=gvmm/CkjqUxV9EFhptlO2mGqr6A5LJ7e4yjOxRnVQbyX8xkW5IuBXZDzYtkcT0ng4i
         ZMucekcMxRPRzTNGjNZtVLysjnkes6cSM+0EUVkvZ4p2xihZ3BebO2YRXVqry9cB8CQA
         HKmnFjUknRxv9QPqW4au77U/shxJP7dpY5+JDH9rutH4BmYskx5zkC4hWp49jUdhLM72
         r9dCMvCM+kwVsMXEJ9MFApyddOn7Vp7IWqXuornbK6MKXzRpc8ZWV3pqscZERsQyC6AV
         3z0iCR0LhulGnxT5vo+ghJCnafGDh8IjeQ9SHGTChEfA02siLpK2Seg/ejKN/clUaDeX
         fNLQ==
X-Gm-Message-State: AOJu0YzK8vtuOcBfk/f2IjGZ1T/gxMlaW03N0gAZ0GOQ2MLAdUQo2TjN
	LlaHIGt7keopISoz6RzPGFAM96wwrkwTwiu5d9jbuLg1IsN6pBtCwkUk
X-Gm-Gg: ATEYQzxWcjnzra3KZBQjEgWieCVjzpiwh33g3lZT3EEaoFhqETTBAy7g7MRdHxxWtCx
	UK6jo+G1GYDWC4b9ammWFuVOdLBTb7y63ebPgXrDSsDAZrkAR/pWAzhaXWeJEmyN89YgTFYXP3R
	Pnj6pDrYNcEbNQBdYqvsfDvx1TgfLYx2++32SNLEScPc6Qi+7w10rpgfiPqdX0g/1cWqpSvl40j
	I0S+PU5fyPZlOhY7IV6Mx4aJJjHC1W/aJs76q+umeZGPczd/w/Rw7PeLE65JTWnaKlGq44u1X4b
	nRASHtst6A60acyasNPEjQlTl7b/KWtITrgctmsJLhw1xajf3Mt4fWbSowql7/3DbyuKtsQGDew
	Wq7DcvC9yJgnhcxzV+8hgj9HAo4QSn58Of6KWwyw7GzVXvqp8abPfltJNeP8lOQ7au9JUlrYiMj
	nJA4MOelo8ECxbJhL9UhFYwHNoycinYBy6lQSdKB58XM8moO6/M68LTE/8bWeamOSecI2PFRGT3
	5zHbiEA7CK9
X-Received: by 2002:a05:600c:1d1d:b0:486:ffa3:592 with SMTP id 5b1f17b1804b1-48716071b2amr4895765e9.24.1774368797178;
        Tue, 24 Mar 2026 09:13:17 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ac0a8sm109272685e9.6.2026.03.24.09.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:13:16 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] igbvf: fix DMA mapping leak in TX error path
Date: Tue, 24 Mar 2026 16:13:14 +0000
Message-ID: <20260324161314.308433-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271164-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C43B318E5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a DMA mapping error occurs in igbvf_tx_map_adv(), the error
cleanup code decrements count before the unmap loop, causing exactly
one successfully mapped DMA buffer to be leaked.

This is the same off-by-one bug that was fixed in e1000/e1000e by
commit e94eaef11142 ("e1000/e1000e: Fix leak in DMA error cleanup"),
which noted: "This issue may still exist in the igbvf driver."

Remove the erroneous decrement so the while loop correctly unmaps
all successfully mapped buffers.

Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 5d04541072b3..88c6ce5040e2 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2190,8 +2190,6 @@ static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 	buffer_info->time_stamp = 0;
 	buffer_info->length = 0;
 	buffer_info->mapped_as_page = false;
-	if (count)
-		count--;
 
 	/* clear timestamp and dma mappings for remaining portion of packet */
 	while (count--) {
-- 
2.53.0


