Return-Path: <netdev+bounces-201432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C4AE9743
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E933A3E3B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE1237162;
	Thu, 26 Jun 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHJFEsEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A638FB9;
	Thu, 26 Jun 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924434; cv=none; b=tKLjW8xPU2A5eKOf8CaqZuNqXQHcy8AMkP8sZffWZiGbW2YaatO3+HmJxAkrder/8fWn4m9kTba1/F05HXgrBNuDIicRDDea6siRxL24nwEWToGD1nFEjHEWD+LmesDn44f12BjpiXDXn+VWllySCOGGwEmGGfoOjNnbA1yalwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924434; c=relaxed/simple;
	bh=FnqrHBDnkXYFDp1T4K5G7I3G/5qKZlHts3NFEuwPA4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCvJ+nk8F8NjBy39Ow2KijFdlhhjeqOPQLt9NOPP+SKm3TK7rNsv4F86/K5NqlYt4is2vvIKuFY5ugEopDlCYTpfMDHMFXQWcF5lTQiWAcTUlwatci/RMTMbt41thalebHozs084VBT3bK4EznI1hVmAKEq7kmx9HIcWFKzwvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHJFEsEF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a577f164c8so93950f8f.2;
        Thu, 26 Jun 2025 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750924431; x=1751529231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pd6bT6wJQiLnyABIdP4QbPF8bfvDog3aiJF+bv347cs=;
        b=fHJFEsEFFC+WWElH7KiCxzgZCZHRgbtu1n18f8kXJj0LmQ5LZmWxxGo7LTyxMCpdu7
         wUvuzHxkAHLTQ6j/jmzkj4gAf7Yzjqeh4P10TOBv82HAlp3mAK5TEIUBwh2iaOrqwDA0
         NFJtFhw3axw58lgxCJ7zESG7buhRbZRR8XS877EYIZsQxivy8jvs8fGe1aomJeAq7Uju
         /p7/Z7QDMKt4tBNi+3k40A8oIj3jMe11Xqd4i/fBggPEJLW9YIq49hXqDeYlgktiLgnF
         OZyf4jRK5NTjooK8HAYLYI91AwRDTt3Opl7PqFDOvSPdnISAuO5FGnqJe8j6gdfsbnA1
         DZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750924431; x=1751529231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd6bT6wJQiLnyABIdP4QbPF8bfvDog3aiJF+bv347cs=;
        b=BXJMX9aT3bbs97uUk7rVEJ3n8g7qo7IMjUAcrvKY9fDtSxRNukgsdQr8n9UXxFJemY
         ci1MCHehHG/4afUjinZtGNb9mVezxhpyfSw7Bmoa9OagcSm6C0jhp9NT4IwgU6WltT4f
         S06FgjiijFQOsJZjmMmR32Is7JpeO1xvzroxvtkBSDLwEsNU4MYl4SPAkjXwT2vm3aAn
         /uUkQ0WSRvJmruv26AUOAATcpzLxF2Jq/WZviL8GeAU59NkVwnA4p4N3m0uJTWqLPLhZ
         XaGDUG/aMNSbNumtldGp9KpyBCEgrxCh+f2YP+BvnAywgrPxNnk1gL3evlkxhUx2c45l
         RCSA==
X-Forwarded-Encrypted: i=1; AJvYcCUVolTqRuSSkItf/w+QVnhU1WUQfH6cn0rmcHwyBp7llFbBMzU4l5850Gbc19bEjPqa3578+Y8u@vger.kernel.org, AJvYcCVf0XNqZu2p0eOtXJozNWu4C1g4j15BZ97QKy0l0g4FOQe0InewGkPkemN6DxKnWjtqX9RHFIrH0G53ygI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhRUG+fSZ6mT4QuM/VhtlNzGzAFENYh0FkDyrtNFLPJcVyqMH
	4QObyOOpTVTeSHjTQCuUrztQAETLyNsk7f2tfnVPmJxB0LYy8uzBtbkf
X-Gm-Gg: ASbGncuF+zL8z8KLDwnEXUF54cnLgpTt/6fz8uv3ZeNsFpgCYrESAE/7M0oqs528W7k
	8gI87kR+lsCd3sZeCP9j2YC2+CHivNh2c4+HFNgiZ+1fRRFMeM7pYL0EInoSZjSg/SpJyE3p+Z4
	EWBiayp240qJ7IfNxyraHr3DllyrbWVR+iuw4YRPjTH8x1X7ihHbNz3W9qOXhSKBSC+e/eGHP1i
	0FRibC5Kcrg6OeLxylXQ5MBjumzvkL32ndFR7LFD0kFFOpW/vIC04IJoRYnQmH68cLYczhu1kdo
	WG9sE5BIwj6qdAAHTKxC38QExt1ok1252WBxuYSLJUD5J3vhvCzU1MBzNeGDCm/pXtZ2/5ziE+w
	zJ6YcwkxrT/V8jyo=
X-Google-Smtp-Source: AGHT+IExWdPqbFfwV9gpo2qljF1loSdxR22c3Gl0rBYYoDqlQzmcfWSR38d7RykfD2ZdKlURvIuP0w==
X-Received: by 2002:a05:6000:2d86:b0:3a6:d191:a834 with SMTP id ffacd0b85a97d-3a6ed650665mr1152721f8f.9.1750924431077;
        Thu, 26 Jun 2025 00:53:51 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:cd14:15b8:23de:109b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a6e8114697sm6742220f8f.98.2025.06.26.00.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 00:53:50 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] atm: idt77252: Use sb_pool_remove()
Date: Thu, 26 Jun 2025 09:53:16 +0200
Message-ID: <20250626075317.191931-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing the manual pool remove with the dedicated function.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/atm/idt77252.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index f2e91b7d79f0..888695ccc2a7 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1844,7 +1844,6 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 {
 	struct sk_buff *skb;
 	dma_addr_t paddr;
-	u32 handle;
 
 	while (count--) {
 		skb = dev_alloc_skb(size);
@@ -1876,8 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
 
 outpoolrm:
-	handle = IDT77252_PRV_POOL(skb);
-	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
+	sb_pool_remove(card, skb);
 
 outfree:
 	dev_kfree_skb(skb);
-- 
2.43.0


