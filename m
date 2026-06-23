Return-Path: <netdev+bounces-301293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oDyeK0w8Omr54QcAu9opvQ
	(envelope-from <netdev+bounces-301293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:57:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F253B6B507D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:56:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lQiNh3Li;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301293-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301293-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81993028B45
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D583C73D1;
	Tue, 23 Jun 2026 07:54:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4D3C6A43
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:54:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201253; cv=none; b=hFnvjPyR8GeZszNMwaV5LH4gqxEjmAFA0GoNysvF++ep+SXzNNqtea100EfAbIkR/lzZtGwwIZks1F1YUwtkR6QnOf1NtjZb6TfkCwuGDwFw0IvfIkIdMnyP51t1FUcKIN8+QYpTYHGD4aT/yqHTBMKFce0pHVxv1tFvGZ/jLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201253; c=relaxed/simple;
	bh=RT/YHB7TIBtxz0KLJv4ZRJBZzmIBfu1nFc74LXiYnz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRZp+lxD2YlXN8AzbtWlT0crNuVmc2TsFOaA4nn9uyU4KCo//7B7x8FgwWo9WD86ySwsavnDBogqJh4rbPRL6rPJfeXoYD/8kKUEnBfu8INNc2EgV2yjlAwkv0q/lea+Jsq5O01I4hBXP9pjWWfA3t3x1324mwHebYkaQti8e/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQiNh3Li; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84237c55ef9so3141083b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782201252; x=1782806052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh7W1JbaB0V4CutUD6HMfxu25gznQAFJEJzcv49AZMU=;
        b=lQiNh3LiNtWGzB6VFpozJiZPgZB3g1jWXTWjQO0ezsRzOvACJGIV8Lu0eRTqQVX2a5
         Pa6HVXpPTOvNjw8gO+3alFZ0LcRLvxs3hudguoHzdqdUs54d2IfZNTaNA5EOtoLM3ES2
         rMAwXE9z9h6WiD+MwElwXBMxhWmG2oHs/XkmeHIo7x5o3y4U8dZCyknrrZ4GOAuOH0MF
         RqjWOfQomWZOYDEFUqIeIWN+ARjd+YM0HhpHfbMlOZARpYaf5MkAtFuSfoAXxPG9qbpi
         IOposXHeCoPdA7asHoO5KQ3OabjI1NJPoS1i7IVOzKCQ76bmwOzo1feSKpL0FfLjCKK9
         VBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201252; x=1782806052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh7W1JbaB0V4CutUD6HMfxu25gznQAFJEJzcv49AZMU=;
        b=RSPUyXy2Hio2wDBFax6IgSmL1Zbie/YEFwgj8mFqg1K2/MCQDmPXWqmMdIrvAHFpws
         aw0b3jWgyfvPkwbDR51d7wdRrSxBDgGUj68YSaIIhPif4RgUKG5ZW/eFfYdZNOp72+k6
         SPG/SkZYlOuCchfXbdT5jRwuQlqDS4unyAkr7scdn4qEtoXQ2kYqlAH6viywEq4gS8zw
         Jhw06dmXyt61cNiioJ8v8eiNIOkS+N5YJo4axf2YgtLvINW9hgCR8iW9Ou8DoeDnoRA+
         d3oXugT1BqHQuRy6Vg+XHQIOl0+iMHUmhr5SugbZFEjWTaTMhkoWIPn3i7GQp4EADpxh
         yJOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/d0NaYt9326caRe0fjgUnWzKVf2OD3VFJxa/nmkEPn+3X0PznDwn0qyZMHbSZLFC0hktcDtDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeiEqP2tJ5XNpyl0zS6CAOP5df2I1zlL1NM2YpHKuWImRqgEZ
	8zBVrCEEQD5klVGDFRuJGt0t8x7W3nTaE8zWyC+wjQ8ypqvklXsnzPw=
X-Gm-Gg: AfdE7cn8RAi4LE0dfj9CSAC2B4JCb3WY7hDvnWp48HJjmHeJWwuSscrdf1r7tJLZlxl
	TyuAqDVuF4qw3zMTQ6tCf5l8JK4UukQKfbiAnS2O+tofD3QjlBwbxEkampxyINsme/YqcJKITlQ
	b2U1FKFJJ5geNs/tmEZ1o1UrFOsJmvYl4cwOGPA+WGbPkLnaebUDJPkPUu18fowCv3SIZlHSnYu
	HrMQgbanRUGMcP3STatDmMrcaNXF7jQAU1RtlB+NuXOn7G/y+CtiqEVXHWyFGXHbz3EwYCYf1cI
	mNWWE0mjeppSVgJy769UsdaXU3FuNrHBV5okpg31seZatkGReh0UhI0mZ5OZZyJQzKEv/NFh1L9
	fYbCIAEtD29APHE9LYJDFAOQ/IF5zHd+z0rFhhO/LIp2RG5P3nZHb8fDBIcITw5e2/Jyr2HBBAp
	6yZMzIuEvfMJ8qQ6wTkjulovmgsEP70E7iv555ugyL4y8BvNGDCQ/W0RNaAS4fsdwN
X-Received: by 2002:a05:6a00:950b:b0:82f:9985:d4a1 with SMTP id d2e1a72fcca58-845952fa1a0mr2211610b3a.24.1782201251751;
        Tue, 23 Jun 2026 00:54:11 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6bf73sm9834256b3a.5.2026.06.23.00.54.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2026 00:54:10 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] atm: fore200e: disable PCI device on DMA mask failure
Date: Tue, 23 Jun 2026 16:53:56 +0900
Message-ID: <20260623075405.47120-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-301293-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:3chas3@gmail.com,m:netdev@vger.kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F253B6B507D

fore200e_pca_detect() enables the PCI device before setting the DMA
mask. If dma_set_mask_and_coherent() fails, the current error path
returns without disabling the device.

Reuse the existing out_disable unwind label for this failure path so
pci_disable_device() is called after a successful pci_enable_device().

Fixes: ede58ef28e10 ("atm: remove deprecated use of pci api")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
 drivers/atm/fore200e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 2423eed506..5e2cc4813e 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -2593,7 +2593,7 @@ static int fore200e_pca_detect(struct pci_dev *pci_dev,
 
     if (dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32))) {
 	err = -EINVAL;
-	goto out;
+	goto out_disable;
     }
     
     fore200e = kzalloc_obj(struct fore200e);
-- 
2.47.1

