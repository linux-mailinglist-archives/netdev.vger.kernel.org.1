Return-Path: <netdev+bounces-244463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E01CB82B7
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 08:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBC9A3040A72
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE430F536;
	Fri, 12 Dec 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIxJL8Ug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60444305047
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525936; cv=none; b=NEPwoGXYrkISsftxihsQs7DGxpjN32XP2kI5gugWrfCYmxaatOPVGcu1HrVQnXAVX9EdB2oeTLTg0BiRKDDMJmBxWoH0DInp+Puq7bukk4JaP1B1UpgNO+8+RpGdeE+amosvyvsOgE6oDSprDnbkqCZGBATess4G9b7VH9tZ0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525936; c=relaxed/simple;
	bh=BQVch3Zrr7oIILOgV2AMkxvg7cE9UJnrX8P4cQ3AVAI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QNVkFBcoSp02vQmvPEdYKN1a26devKFpgyx+w5lgTOlfarwoHCQ8pcRSX2YqqxO+pUONnFnoTriLHemuFVhYm1nb1Ae0ubme1i2BcgfWK5Jqmc9qlYeYZaT7ndy9Ft2K/3NczEkLksXx6OU7bE6oCyb/EibycqHAbovH7herXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIxJL8Ug; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11b6bc976d6so1195637c88.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 23:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765525934; x=1766130734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g0+OL375DlJZBChyN+LFQBvKaqLhEoBHitMOMJRXqlc=;
        b=CIxJL8Ug/nVXTikL7GTa6XIKeq/b/uc1s2qG72tqocpBMRDkiYON6cMc/RSfzyuFPK
         lT6+z0S4XguoIJfoROSFGvitTxr9zM6Fw4Cp90aeRbRxV+A+4qMiQ2uSebI6Yph+hDSl
         gbn34vgPovDeNP01cNZaE+/rQ9SVgDwfLiVBsMwF3KXe6YYMeMcKGGAsbRFzxn7u3kAp
         CyzgS8NRdrjIViQ/he5XFOdjt+Co5PjK/FOUi1Imom6qGFBVvcUSAcHQPAtZ7q1cqzNQ
         CbQ9sAO+C4MrcknnWJUcW9Wn/JvjYKfQYyDDgnkucptpO0PjkKo2fvNGu4RXu1UAFsGJ
         vrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765525934; x=1766130734;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0+OL375DlJZBChyN+LFQBvKaqLhEoBHitMOMJRXqlc=;
        b=gANN0eQI6AU+yZBFUGgDAfMJR3CaMcBQJQFGHGq4lyD1sX1vKHvbAJuLEljkC2AA6D
         1ZNYUFvA84iuurS1i0ieZa6IigGI6KPNeuRtC65kvTUO3eB76Nog+QSmxpV4p+VnJ3dn
         oDHh9pLOp9SgwnfSQfBBrvAoEqLpl6bMp4qOuImLZ2bZMbcqCMVRJmRfrRT7ZWf9yM5Q
         wkAHFJE+Kc+MCOCfbWVYM6uTLG2UGtco7jeuFFT8WaNZWdiS8a43w3tK3LSvJXFCBCol
         AYItCfgFzsKE9fOxyADzbjw81n63DxZjEi/kIwo7DDrb3gLhZrAew3t5Qp6j7oCc+2dg
         qcuw==
X-Gm-Message-State: AOJu0Yz1+tnzclSDVMbwc1O+hbs8C+0OEzt110V5g/0FJkoefP6N3Ncs
	sIKIdCXOYfCqTM+TGctg0xdHrIJ/XokfNuiPZHRoAEWocoQvHUsCgL/SGAUE6UU8+hBdMTDZmP4
	esQMbD4MC1z3gL8v/b1lxSr3xoRyr/vkKsqXBiiin9Q==
X-Gm-Gg: AY/fxX6CVuIzIIg2Omuno5BwrWwzad6+BBRcs514TSGoiTTBe/kR2czkQC57XvDL8aa
	fZPN5PEIKBZtIsDyxbJcoml5dlV34+0QauRr6OWhsdNbOQVX9ZrWS2MLoRqYIP3B7mrR6yHKB1Z
	4JXuVg1gOpwQexbdDHAQogsKBUR8EBYMWCVQOpHvPsO55RrwwAMR1bQUOxAPwRU47XmLSBXdrVZ
	RBirm6ckB0+AQjArBg3Jtb9r17PCNbeyh76zeFOYI1U1XVBj5exDP5pz7ozkz3tKD8iDx8x4YuL
	9VsSUQ==
X-Google-Smtp-Source: AGHT+IHv8ZqJ1PmknbzFmDHR9oVIqES7WTjEtv4kEsGZ0d0+JATrMRSKhA3N2ybhYrc2uCvTpmXEvEGg3x7j+BLctRw=
X-Received: by 2002:a05:7022:384c:b0:11b:a738:65b2 with SMTP id
 a92af1059eb24-11f2ebc92f6mr3287095c88.5.1765525934305; Thu, 11 Dec 2025
 23:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tuo Li <islituo@gmail.com>
Date: Fri, 12 Dec 2025 15:52:01 +0800
X-Gm-Features: AQt7F2ocigM-AmUusutfTjhGIohTkSnFbtuOTKP9LUp3RaQiXpKOcVQBKKvAIwk
Message-ID: <CADm8Tem-jtBmmOO9S6jW-jzffCqe7X_DpJcy25KRkyY9Tn+TZA@mail.gmail.com>
Subject: [BUG] net: 3com: 3c59x: Possible null-pointer dereferences caused by
 Compaq PCI BIOS32 problem
To: klassert@kernel.org, andrew+netdev@lunn.ch, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mingo@kernel.org, 
	tglx@linutronix.de
Cc: netdev@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a few potential null-pointer dereferences in vortex_probe1() in
Linux 6.18.

IIn this function, gendev is checked at lines 1109 and 1173, which
indicates that it may be NULL. However, it is later passed directly to
dma_alloc_coherent() at line 1211:

  vp->rx_ring = dma_alloc_coherent(gendev, ...)

This can lead to some null-pointer dereferences. Here is an example
calling context:

  dma_alloc_coherent(gendev, ...)
    dma_alloc_attrs(dev, ...)
      get_dma_ops(dev);
          if (dev->dma_ops)   // dereferenced here
      WARN_ON_ONCE(!dev->coherent_dma_mask);  // dereferenced here

Similarly, pdev is checked by an if statement at line 1466, but is then
used unconditionally when freeing DMA memory at line 1476:

  dma_free_coherent(&pdev->dev, ...)

It looks like these issues stem from the call at line 987 used as a
workaround for the Compaq PCI BIOS32 problem:

vortex_eisa_init(void)
  /* Special code to work-around the Compaq PCI BIOS32 problem. */
  if (compaq_ioaddr) {
    vortex_probe1(NULL, ioport_map(compaq_ioaddr, VORTEX_TOTAL_SIZE),
      compaq_irq, compaq_device_id, vortex_cards_found++);
  }

This passes a NULL gendev into vortex_probe1().

I am not fully sure whether these paths are reachable in practice and how
to fix it. Any feedback would be appreciated.

Sincerely,
Tuo Li

