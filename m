Return-Path: <netdev+bounces-249975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A4D21DCF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA1F3029D3B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47547082D;
	Thu, 15 Jan 2026 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LICpaw96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDD1684BE
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437243; cv=none; b=UTbZobdr1dO3UEavxy1UTNg6Zy+sLS/ehNd3cqQOeID/Ap0M9LESSF5bzDHXXUvLQ2defdD041eeOgH36DCEZYHwHQuG4/DTPZZWhnIzT6+JEq8Zyrh93viwz6JGdJJtj5EbbeKTsLWRmZ7bP2ra4BpVPacLuyDPaO+SRLXm2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437243; c=relaxed/simple;
	bh=jdMP22+z4mKu2MxwIO0TE6Y7dPloYZ06zIFsg23SP4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAU7pDp+hxod7sZ1p0BEaQoDmiNTSAb1BC/H33kAGSMfHMistKBNcJVU7kGkNJAIxUvrCcAlU3eaKZNSW4zWCh9Boa+jh2PVMhluoiz8FO/F3Va5CmpEiaLZqU9ZLXI4wWpngh0PTp+qklNDoFXoCygdy2uvpd5zrDEyx8dKNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LICpaw96; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so2192145e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768437240; x=1769042040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR4ZfBgCSkGc4JjU8nDjqUHH2Va+zMHBS6jTWlrE/KA=;
        b=LICpaw96SWKmalvs9NRmjzVNltVK1eqQx7EK07OyhXdiXtoNnGiPI4T8k0hebxVeBk
         YWow+5imcgcnynqRNeTnvEoUp0wl0TXj7I/7gd+lCZGeuFyusUel7GUqrseFlvS0Rmrh
         7Sgo55q0wQEDBiJ5HTsMo+riAiW9ipIaadgaxYf8f9eeItAQbjSaqyWcvYGh4/GE2v5h
         TntyF/cQv2LWYVJ0NkWfwbm1F8waiLKVR4pfHNMPoa93uYXC/Lyxy2GGx+pLNOE5N6eu
         w+loHmUBWznnAqoW2sb/amf5VjqVa0NDiz3WcpHtzzBIpFoRB/RFEClpJDPYA7osKDkU
         fwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437240; x=1769042040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PR4ZfBgCSkGc4JjU8nDjqUHH2Va+zMHBS6jTWlrE/KA=;
        b=BQol6/3+EBT0KGfWvjvPLUoMddW26dlK2t3LH2km6PzDUT677TMeGAOgmLj2ySDXo2
         Dt8hRgQ5vSKhNe5T+vlQXMZLKTNCdW91QH7oim8T/oloMETIe0bXy53VL2y9YWhIpjCU
         iryI3R7WjJzyKr3dti/02cfSpslGsZAKkxl2Yolj/Q9Ov44txPSjirKTffFkWEw1g0QG
         Wn9ZLynbW/mBGWLA4uFgqVB3yhrLOiz6B1scAbiQ+DqKXFXwEHwTj+/aysktlz0PDJgJ
         ufPNBnkNsguUSUe7NOijw/W2POCBeNBrThc7KxTJs1Fp3bq0SO8Yv1VrHgbOwfsqangf
         fmSQ==
X-Gm-Message-State: AOJu0YzIOcxmo+7o1mMG0btfbHBEDOtxEzasXC6DinN37MGXxPGF76TI
	PKtdMOsGKdyvZQwA6nglgnWsNprWYmxKvAaGXmldkG/JtL/k3loYeQwYJS/GN2iH
X-Gm-Gg: AY/fxX6ULbQltoncgyXa5yv0pcGE5sWqGA9JzLOqwd5Qa9B3a89tmDC1oNK9c2gulL+
	lxb/9JKx1xRYYpWe4eb5uyAyYisWAe147H0MC62NTzkdZsEncQ/QFL+NeeLWzYzvd1bf85s3bRk
	W5phieTYsOQBtho1M72OIVdTeZCg5Ub9EaUiV696xETvywvnGX3SzkoufkBNyfoabTx5K7arTzs
	uMcG7KdiapFszmpERESn458E1LqQYcTVvo0hBA5a9iKCYfGuhl0yysF6ofH8x40GfiIYp6KND72
	0iro0oRPuktNXN5Fqwpr0lhR43Yks7iTPZ53jw1+IzQhYwI3fTF61parb+S5oCT764ml5JHTzdJ
	r49WX1QWMX1qZb6TGgC35bjpSSx/vUgUh7xd3KZePJYJOzRvn/PuiEGSScfBodyJHxKsAL4Yder
	qQ6Dx5Ncg=
X-Received: by 2002:a05:600c:5490:b0:47e:e20e:bba4 with SMTP id 5b1f17b1804b1-47ee3356e79mr49291565e9.18.1768437240170;
        Wed, 14 Jan 2026 16:34:00 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm15604865e9.10.2026.01.14.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:33:59 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next V2 1/5] eth: fbnic: Use GFP_KERNEL to allocting mbx pages
Date: Wed, 14 Jan 2026 16:33:49 -0800
Message-ID: <20260115003353.4150771-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
References: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace GFP_ATOMIC with GFP_KERNEL for mailbox RX page allocation. Since
interrupt handler is threaded GFP_KERNEL is a safe option to reduce
allocation failures.

Also remove __GFP_NOWARN so the kernel reports a warning on allocation
failure to aid debugging.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index d8d9b6cfde82..3dfd3f2442ff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -205,8 +205,7 @@ static int fbnic_mbx_alloc_rx_msgs(struct fbnic_dev *fbd)
 	while (!err && count--) {
 		struct fbnic_tlv_msg *msg;
 
-		msg = (struct fbnic_tlv_msg *)__get_free_page(GFP_ATOMIC |
-							      __GFP_NOWARN);
+		msg = (struct fbnic_tlv_msg *)__get_free_page(GFP_KERNEL);
 		if (!msg) {
 			err = -ENOMEM;
 			break;
-- 
2.47.3


