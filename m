Return-Path: <netdev+bounces-199580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05CCAE0C23
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7751726D9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736A28C5DC;
	Thu, 19 Jun 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDYUTkRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641128B7E2
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355573; cv=none; b=FBcPdfVkFIPWeb08IojHHjpROP3qdMfelIUTKuNKHCDbklZDh+WGhWwJ+vYSfLgYOBpopxrSs2YUbXOWXKEmXwr2/hk3kXenZ4JC94jCEqJSCxYmzHNw+vjQiNhcIdot88nE9XfOkYug++mi5PScSh1VKutr+nB9b9tUBIi/qyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355573; c=relaxed/simple;
	bh=11ng1f6VPwCvI+8XO7NWn6w057suUPB/xBIrVu/g/yw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=opewUbUNmJPL1nDwBo2DfbtGkmG3Onxld0PXP7Tq0NQZZ8HsremzHmlacMydwJsj/WoQcVfPXrytbLjiKSO9B6GD0wHhDmkJ3BKI2yvwQLpKLrIW5s5ZYZSe/EnsizswL5UAxIOkd+SDF5xmNTbHSBraqk37th3z6KMvtbdkxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kDYUTkRz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f13ef248so922983b3a.3
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750355571; x=1750960371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKAQxo09G5cPv5qwWN16POW5i7zkedHBeHYLB/DKhXk=;
        b=kDYUTkRzBpifw3J8v43aS610ADumWc2i0IQOmYGe1O9mJwk9b+4KI4j0FhEgnAPh0B
         x/lL99xFO7d9jytmxKFB0bc9Jgul5aBU+QHV9Kozgxg4jKPm+Fo5C2kWZKyAdRhbsHXd
         YM0BZCz2hHglJHaSh8QLGE/EVckFcPgoalesAPyhrqgeNZMuiTrDhTObyC8S9SIVma87
         Nf36L7Rc+HD9vXr8Y0Bc39OvMju4kJkU8EqIrtptIJ9sLPNwc7VXCfv9fhhfQQ/fKuku
         4E25vtKEeYobt2rc/NaI4plmF1PyOqO1qyW5ZcLQkFw0T1j09E4OhDCILwMc1Zi5V3e8
         x6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355571; x=1750960371;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKAQxo09G5cPv5qwWN16POW5i7zkedHBeHYLB/DKhXk=;
        b=eyY6A/YvUQAwtJ0nocu+lxphG7PiNgMxDc002MYoy4/T5qntb/wXvO8mT+QlYiS+ql
         SD2atyVnV3ruDOByEL9C9+/1E/himvwiQ3dichbh+TIbl1lNaMllFLnLjd7Sk7xf28yL
         uN85LhqDRAqq4+a6TPOCZN4Qd5ePqf0J8qlbKjOcNi+qmsMl70w+22FNm49mm6JkEvEX
         I8WHhC8bT8DsHz2q8nAXz7tEIY6kYzaubHj2BGPosiWGHpAuijroZBqESGgrZDGGj1/n
         aGmdfBsJRQyHIIgnJN2aHEyGa6VmaKSBbQ1wMcwPETGtmrZik/1nDrHeaQoBNaW9dCdm
         8WQA==
X-Gm-Message-State: AOJu0YzKIvs8n+62C2l1ZEyF8edIq+Y/GXynTiPokTqD7JBizbcwkpyV
	KKd0EaN6Cmd0oJduF5xxUqrEx27BgbHtYdqxGy4ggq8T8v++APDrDyk7Ok//xE36e/hx+3YnHfP
	mO/6AkpjEQtptML8Ahuq1hb14NzqBPnOwMPppdWYWivvIJqUucSIQDd63SVx4bXoOhHA9wXMfZ9
	6i4ys2RsxqZYC0N4JEoKhTmYGa0cL6sLsoRub+wErJ56VVuq2OX8Xrm63fx4/BiT8=
X-Google-Smtp-Source: AGHT+IET5o2P4wUYb7dd58G56SGW2P48lKGW3j+rhDyrZHG0JDXaF5FQiMdicsGmxzV+16PzB+pmpmYbPzshlxEX1w==
X-Received: from pfqf15.prod.google.com ([2002:aa7:9d8f:0:b0:747:9faf:ed39])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b13:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-7489cffb748mr31583409b3a.20.1750355570964;
 Thu, 19 Jun 2025 10:52:50 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:52:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250619175239.3039329-1-almasrymina@google.com>
Subject: [PATCH net-next v2] netmem: fix skb_frag_address_safe with unreadable skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, ap420073@gmail.com, Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

skb_frag_address_safe() needs a check that the
skb_frag_page exists check similar to skb_frag_address().

Cc: ap420073@gmail.com

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v2: https://lore.kernel.org/netdev/20250617210950.1338107-1-almasrymina@google.com/

- Move to net-next
- save return value of skb_frag_page
---
 include/linux/skbuff.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9508968cb300..4f6dcb37bae8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3665,7 +3665,13 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
  */
 static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 {
-	void *ptr = page_address(skb_frag_page(frag));
+	struct page *page = skb_frag_page(frag);
+	void *ptr;
+
+	if (!page)
+		return NULL;
+
+	ptr = page_address(page);
 	if (unlikely(!ptr))
 		return NULL;
 

base-commit: afc783fa0aab9cc093fbb04871bfda406480cf8d
-- 
2.50.0.rc2.701.gf1e915cc24-goog


