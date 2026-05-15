Return-Path: <netdev+bounces-288327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wECoCzovB2p3sgIAu9opvQ
	(envelope-from <netdev+bounces-288327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:35:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750C551847
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4253D3010DB8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E39339B94F;
	Fri, 15 May 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmZUEdJw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A933DEDD
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855472; cv=none; b=q+niNF+m2ayvDewH99vO/aLMNuErDRw7LHCqTz6IK6UuiZCIHHkIB3cruZm8wUpPkfUk6Kpfno//B72EwBQWpcgQxUi8k7ETNGmxngTr5KlVdCOkEj9kfW2Ww5IDjBuYKh/g7na2gduHKGgu91ql9xw+v461X1rLZ94kL/yuLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855472; c=relaxed/simple;
	bh=bV1JeOldTkErlaOe7mZv8IxdkFPY30ISl0S82QP7r9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nl5yrE0JRxdpGq8FHlse7cndbbHjvLI5FYnK+6BDj96vCabji25DFDIJ5xPKxXGAJWn3xYaQ4/8o2wsIQeNCkksx1vu7fw6BrrYIG0KUNdx2fI0rS65uXFbeViLjPSicUv4oKDMjoon1ZpiVeDG6EhfBB6hZUpL9SeNV7z1rPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmZUEdJw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso13732525e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855469; x=1779460269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oRruk2hRCiEL2H/Lc0ikHTSfdx/PqADfnZnuck3Ni8=;
        b=KmZUEdJwyJ4RTk7ScnujzA+IuLqyja3NISvYqPL7OFT1l/ASWiwyBA/N9S0oz2p1i0
         nq2Q+JBwTm8auLpQ8DFMxtKHih38pT0UnRsLecoODflPnXFHtqagKbWJ4Gv8Cl8b2FBs
         3QRGT955MkD9N+ORFO50oHkorrF9IFJIHJYqVolvy2rb74zwUqglrgCsIHe32ob70015
         5YwL7LQSuHY8Zdxu61TQuijiizhALCyEuELK2MkI+E/UDcmnHtbBBBnVKTJFgdnU6r72
         p7gLVWJU7NntvXjnPRCYBhEaR9eM38Z/Xo3bc1uu059PSgoQkK9yugNx0Mpg8720t6jU
         ezHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855469; x=1779460269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oRruk2hRCiEL2H/Lc0ikHTSfdx/PqADfnZnuck3Ni8=;
        b=FxeZUjtt5QJnUb4LO0081gACnqTuaqAZEKNKAOBJQFwc6UpCWHOJ8+fY/xjb38J4eZ
         3EnLm1zM+JPAyzkKGjYUfcJA42aTUXwpqZ9me3WFcHrcalBhWhtZBPzfX19xPQg1o0a/
         ndxETwMlFiM/c+2mQqOZn5hreuJaP40PqO6Xl0RFWUW8ETNjbelq8XSUaj/Hr9PPDjPU
         FHMBZG98ollGSC5fJ1mJeUKCMvPzH4M72efUo02Bg6Xuyl07PWWkO3+X9/BRJbuBlnB3
         DeV5v0ZEINGJMq9ybWUzpq0/f63kwg+wFI98GPVcqAzAyS5YwDnry7wXwlw48NNXFyT8
         F1VA==
X-Gm-Message-State: AOJu0Yy8wFaMUduuW1O5cKI/IVmfqT5ZpZLo9e13/EOfsvsYDHXpg1cO
	Ylb6kDkx8INhBD6nflOopRU4z7Wpst6zAENxeW1oQEsNbt1+6ZDiFMuB
X-Gm-Gg: Acq92OH47K0rUE6vren8qY17kDfbntCJLUYj7/G4+wzzZSpeZRw96bm71yYIYMvTG5V
	AfGCG8VU2h3LNEHP/nV1AK6jSO6N0vQyIxWJypqn8yQl1JPQfwlxqbx+VQs3fI1mcGJ7ktg3LdF
	YuY1olXfMdpEbV963zQP2Jft+jcxMS725KN38GBF817bTgm08AhPBBDrUZawAzRRrSepsH2Jrb7
	XN7TGMDkMIeuEBeNSA7UFLtcRGipyed3kZ2uK3EeKHwO4YVa5KlqLIFD0jP6Hs8hm+rPANrDnyN
	vFU8m0evLoAaaMc6DkTxWpyrL49ooKIrHIo+mCJPMRev5GBhlT8gPCLfeJjTxQGMQgQ4umzJR/Y
	txZiIj4zecnZhoh54r7m8Q7YEHRXW+G2stvdyS7nZWZj+52KagskXfV4NvmD5Y8V2NTlXibkmVM
	KKFID/fdY4bLtzoaB/CfK0ev1pG11ujtz4T6+z
X-Received: by 2002:a05:600c:3b0f:b0:48f:e230:72fb with SMTP id 5b1f17b1804b1-48fe6631512mr57952455e9.32.1778855469028;
        Fri, 15 May 2026 07:31:09 -0700 (PDT)
Received: from builder ([2001:9e8:f130:7416:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6aff4sm15024815e9.25.2026.05.15.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:31:08 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: pse-pd: fix sign on -ENOENT check in of_load_pse_pis()
Date: Fri, 15 May 2026 14:31:03 +0000
Message-ID: <20260515143103.1721888-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8750C551847
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288327-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

of_count_phandle_with_args() returns the count on success and a negative
errno on failure, including -ENOENT when the "pairsets" property is
absent. The existing comparison in of_load_pse_pis() checks against
ENOENT (positive 2) instead of -ENOENT, so the branch is taken for any
error return: legitimate DTs that omit "pairsets" trigger a spurious
"wrong number of pairsets" error and probe fails with -EINVAL.

Compare against -ENOENT so a missing "pairsets" property is correctly
treated as "this PI has no pairsets, continue".

Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/pse-pd/pse_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 87aa4f4e9724..69dbdbde9d71 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -210,7 +210,7 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 			ret = of_load_pse_pi_pairsets(node, &pi, ret);
 			if (ret)
 				goto out;
-		} else if (ret != ENOENT) {
+		} else if (ret != -ENOENT) {
 			dev_err(pcdev->dev,
 				"error: wrong number of pairsets. Should be 1 or 2, got %d (%pOF)\n",
 				ret, node);

base-commit: 5db89c99566fc4728cc92e941d8e1975711e24b5
-- 
2.51.0


