Return-Path: <netdev+bounces-106768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7F91794B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DD91C21D7D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5507E14A602;
	Wed, 26 Jun 2024 07:00:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3A7F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385244; cv=none; b=mI0URSdOmcogDOwCoCo/LAZr7UjIFd6+MmLMv4VYzsmsUAubIYyqnl5ufVAqCE2ocDjfFSaksA5hPja7WZwS0ZILgR8w+FuTT18ddEDI87GJl+KLuMcbwCfGdmalkzR64JHuJ3eSIT7BKxFJyiIhEQVITG/Yi1ZfegCfdp4ztGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385244; c=relaxed/simple;
	bh=FylXKTBnxotHRB1aKpnuj0kwhBQy7SJnDEQAvY2bydw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ok06O/kRkqnymeU/ILQfZCuewRUgXZWG/BL2OH0p5sVRuoR4uMOxgxmnnXRTOY9yUp0CKsr4lk25p1nPX5VfqrgQt9EUoLuK+Vhob7+WAsBZDdKE900AyrqVBGyOYHeNZWiUqXJ+5SIcLeD/MbSVGQrZ8vhnQ6uhpSpWcQptuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-422948b9140so5646995e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719385240; x=1719990040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGZZfaMxgvaBQwBr+0fVvw7aqhz0LrK230wvycBWnKg=;
        b=hXIrMsvrRBMkdMGJ/igYy96YY11xdVKbmj8s2IexVhXRHxI70p+dgacpGNNe8U+w2a
         16+uH3GmciTmewwPNoyuvLjfjL65ivddDuthjed/fcFoNIRfARNI+GmqesvaYdpCWjw2
         RBDvDdEsTyVrKhudmPCxq2+4alLxqv/VtFG7ADB1itthiDeb5ciJSB5Xl1t1Y72YC6ZG
         fAgpVqWHxtmhPp7lfd+8KF3GMNeMjMFBnL6BvU7UCnPtuHcHtKME1zO8x/JoCi9fjTl8
         ghKMkx3ZqfRaP/1eigACvstAqMWmCnki5hQ8rwi09QJ0umozUDmKtDY29xTeprIWCs1B
         WQiw==
X-Gm-Message-State: AOJu0YydHOPnrMAEZ361cI0/Y5pu9NjM/riXs9p3JkpV4r07QN98BNzf
	uskYeoUNw3+l8haIQ1LbIY93+tqVJGcYtX+6hMqB7vpNm9rwgcPqiyuDZQ==
X-Google-Smtp-Source: AGHT+IGJohaBt6+nMGwXLK+iamLibX8DBXc9Ds4FlA3h2aJOW76P/EmtT5M5fi5qS0WDBoF0DITgCQ==
X-Received: by 2002:a05:600c:3b0d:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-424ac9f6029mr12113305e9.3.1719385239994;
        Wed, 26 Jun 2024 00:00:39 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c823c28asm13728735e9.5.2024.06.26.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:00:39 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH net v3] net: allow skb_datagram_iter to be called from any context
Date: Wed, 26 Jun 2024 10:00:36 +0300
Message-ID: <20240626070037.758538-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only use the mapping in a single context, so kmap_local is sufficient
and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
contain highmem compound pages and we need to map page by page.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v2:
- added a target tree in subject prefix
- added reported credits and closes annotation

Changes from v1:
- Fix usercopy BUG() due to copy from highmem pages across page boundary
  by using skb_frag_foreach_page

 net/core/datagram.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index e614cfd8e14a..e9ba4c7b449d 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -416,15 +416,22 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
-			struct page *page = skb_frag_page(frag);
-			u8 *vaddr = kmap(page);
+			u32 p_off, p_len, copied;
+			struct page *p;
+			u8 *vaddr;
 
 			if (copy > len)
 				copy = len;
-			n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
-					vaddr + skb_frag_off(frag) + offset - start,
-					copy, data, to);
-			kunmap(page);
+
+			skb_frag_foreach_page(frag,
+					      skb_frag_off(frag) + offset - start,
+					      copy, p, p_off, p_len, copied) {
+				vaddr = kmap_local_page(p);
+				n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+					vaddr + p_off, p_len, data, to);
+				kunmap_local(vaddr);
+			}
+
 			offset += n;
 			if (n != copy)
 				goto short_copy;
-- 
2.43.0


