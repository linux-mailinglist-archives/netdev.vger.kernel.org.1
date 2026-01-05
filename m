Return-Path: <netdev+bounces-247196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D27CF5A4E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A31E1300A91B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5882DEA78;
	Mon,  5 Jan 2026 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODNZ0OZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0C16EB42
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648000; cv=none; b=eRHjoqKqkP3q9x7uiU1VNKZO4/IaLG8MBdaoTALG077I2rB44gPCD/Nn62pxTNtGEUNu4YT5VhVDuLy0a4rRY5P2clw9YFskj3autEY0IDhRxdt/JCr83Vad4AtI5n2yJwkBHp4JwVdgpUlYD9CDpAHBe2CDtFyt9jCgLAsOE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648000; c=relaxed/simple;
	bh=t9qFiFeqGxp4Cn6wya3cXn6vSYwDyML16YgOBP5gC9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9zO/HLe4AtkfDNf0FVAQVeMpXiCO2dRxdz3Wb4qDA4SBkbXrbRAagvGIjZDSyB2qJbMW5f+GBUKIKU/NOPQbKBagWdAJUCR/zMs/Ih41slGOYX19JKFgKs1uzzg9lU3WSVsEpA3+1Uf4zPWC8iEAawM50MuQjunqH3XmIUxHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODNZ0OZH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477985aea2bso314535e9.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647997; x=1768252797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYAiogr7/hdP4KHS0vv5xxzgIzj7f7R1MCPaXxXIEic=;
        b=ODNZ0OZHYmFWfgKdzIWejzUDQfJCrnIB2dZz2e13gGH7zuYdJiFJiEseFb3h9akaE4
         yu+SaBHExR1pfGKIOInxFtEp/hmuKjxDyFCiTkoCAZzE0s775FDQ8u9Hj9aRSxpilBoc
         eSfyNKYW65XaVL7nuJdkI+QLeB74vYzSVTXHpP48m0DfFehMdxfnM/YMzHmw4R4RICdZ
         d3G82EUXm76t9ArrzkxHZHN8abuvVaLhzLRj/afo8lrQANjapn8RrkRsx2Bd9j4dfaIZ
         vBc6hDB11P+hn7JLL/aEx4cmcTsfVa/C9d82IoDCdaXq4PaOQ4W45zZoz5gsF6z/FGsF
         jX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647997; x=1768252797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYAiogr7/hdP4KHS0vv5xxzgIzj7f7R1MCPaXxXIEic=;
        b=Sc9umWG1uEzNNccffU2XgWcUP/tpBu0sE6kio8hMj73lsJ8kcM5oNayzTM95ha9B2v
         XaX3M0KMH3Jw8dtiG1AEENRgF2zq3WTuGcLKYg/0wpQnUC6bB7D2VXxOZmayJdWzapPL
         GAZnKb04nkM9YuuX1mCV0PXA2ZZvrCeWlS1032ndqDwLLiVkMbxBLHZLkwjbBSHe5uDF
         5sACLhCgUP5t1cMNRM1NgrAeAkrX5Zf4Vv9vFlz/gA56EMAGt34hSkLvqkq32yCkxA1v
         Ii60TuPBS9JaSeyp3pUCFtS++C7FWLYdA2c76Kivt7lf+IMipNtCayvP9FKJvXzAYVpO
         Tvcg==
X-Forwarded-Encrypted: i=1; AJvYcCU3nGOP0OlJN04xEP8TMuz2tTLgzYGOE5mlm1xig6kEb4N3N7zTt79BRWP2ToZeSXXBEOGwOj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0xebUnG3QakS9jfZJmDomlZ92Z+MhqcccniqePo8diS/DX5g
	xvrBjmFMjArU1XtAV43AsAw9t5yqmXkljhke0EA6+XWmFPQFCcej4O5Q
X-Gm-Gg: AY/fxX5EEG0PqgWWlk0IthFOPvf2+CQEoPSrOZ1CtFyyFQM7ZwUjzctN3yHZalQixf3
	nqevVvn6ND60MwJkmqJt4Ds56qFeCj/Lfn08R5Zttizu3vLrorDOHLx8go79nyU/A2kqcNG7Q8y
	LIsBuAkJc0B1u9ovfqw2kMAlXn0tBBFH8Ppa2FV8ixr+gEZxZYJ3Te3iOeehKaoZGtwkqfH7pMJ
	wKSgMrWLC6tASLcSl4ma8evIIlSOwmOOjkWi3yln/4f3HHIT9kxKqNLd428Z0npiA6y8dGcgSIG
	xZrfvZonzGP87iDWt9+0jmE8S68BJuixfGv39fzOYxithPbBzu9vx46i0kTmYedvF/yEeX7njpo
	tr2oUkMsz4XzpRZur8HS9gJLK4/VMx2wjcFmiNEZ3jR7ODhhOuQqHO2jYQdGuZyw2nmCGX0tD+m
	Ne5d6TvLyrEtV9ciU5VsG/s1VYFaak49qS3m0=
X-Google-Smtp-Source: AGHT+IFIa4aa3q7kG3OyPJxh1m15HSK01sRw7aceSgFDOoGG3uwGaBJZsocA2rlnxs6QMnXHm5c2Vg==
X-Received: by 2002:a05:600c:5488:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-47d7f06ca9bmr5264805e9.1.1767647997535;
        Mon, 05 Jan 2026 13:19:57 -0800 (PST)
Received: from thomas-precision3591.. ([2a0d:e487:144e:5eef:4e0a:3841:cee5:ead8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47d7fae67ebsm1957965e9.1.2026.01.05.13.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:19:57 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Chas Williams <3chas3@gmail.com>,
	chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
	"David S. Miller" <davem@davemloft.net>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] atm: Fix dma_free_coherent() size
Date: Mon,  5 Jan 2026 22:19:11 +0100
Message-ID: <20260105211913.24049-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of the buffer is not the same when alloc'd with
dma_alloc_coherent() in he_init_tpdrq() and freed.

Fixes: ede58ef28e10 ("atm: remove deprecated use of pci api")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/atm/he.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index ad91cc6a34fc..92a041d5387b 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -1587,7 +1587,8 @@ he_stop(struct he_dev *he_dev)
 				  he_dev->tbrq_base, he_dev->tbrq_phys);
 
 	if (he_dev->tpdrq_base)
-		dma_free_coherent(&he_dev->pci_dev->dev, CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq),
+		dma_free_coherent(&he_dev->pci_dev->dev,
+				  CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq),
 				  he_dev->tpdrq_base, he_dev->tpdrq_phys);
 
 	dma_pool_destroy(he_dev->tpd_pool);
-- 
2.43.0


