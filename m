Return-Path: <netdev+bounces-201628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C5AEA21C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23D54A391A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767FC2EBBB4;
	Thu, 26 Jun 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY0vhStd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A52EB5C0
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949795; cv=none; b=Sc/2rBV+p/0++k9AEk13xnaWUAKE7ZDmJcOL/Bd3mufp5um4++B1A2BYErcb2QM+i6xADrR8Rfq2zTlAw55r1wbV32mCAbYSnxyzRd9lKme+ebyb07ZLlvi90u/AV+QcOkJSGh1Je52RqLFtFowQJUQ4LEII54GVlpoDxYsSPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949795; c=relaxed/simple;
	bh=iykfbsrxSCOnjxxFh2JtqfS/ROKqMsv+hOfXunPFmqA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JOlDoCACM5KTjyZmWBh3IkjOXYF4WS74vBE0DH1Cv7M2FXKh14cAGfsQmxzSjePaUWbjJ12g1rpDStHd1Tltg3OHj/L5coukAukptGva4whJD7pHvL9ng957+6UzoKSvzi0K02pPQJjj5IgObOA6oEZwUmTjfGr4kE+KTy2k8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY0vhStd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450ce671a08so6203395e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750949792; x=1751554592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIP6pdshViq6EI7MHx7gntjeDKncr7QtwkxAwkxI/8Q=;
        b=iY0vhStdNq4ihQCBJUkcSQNGz9SleeqkFUUDeJZywzLoFBExPkucBmcDDKippGrsPz
         0+bi9teMFRL5T3of2i+LE8+sdda0/r0IdTWX1NRb0/6aMf3PLbCFPnfaodOSMzd8RdrT
         7en3eYOZ8ny8/tIZ1OXAceQfr3RvLlRpAUwgsvYxvHxKr0ErxzAWNYITT4SiDd0q+4vq
         ZVgkZvbIgyN/NV5H0Q8HXV+k2EW2t0/rAuvW0qQHqZoHZkp0JVAZv7WUlaCRUx4+E972
         3YPbcLReMWe+FAle43b9RGKliYt9cug19yyJV2oT9qoS8dmenqYDY7JPmXvTD+tDHQJB
         UWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949792; x=1751554592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIP6pdshViq6EI7MHx7gntjeDKncr7QtwkxAwkxI/8Q=;
        b=SPFcL8f8H8EggtWXSlQuo2kShjw7VKPWDbd6hwbeyTEbxo6nvKrgeBtzx0nv1+FOPj
         mtZRNSCivwffWzZnubK4FZZjbzv8xakoEV+S1TNcdFc5m0pI9dIcwQqyipSc6Qzm/sEA
         azpm0+MYRCQcKbP9jWM3iR3+uRLrHh6rQtqbzFTZEHso7D6USPkhicJF5IQrX1Ywk/u6
         reZC8faplVsHVJLjIeNzcE20Erqs+MUdsGvYJmKdGE2nRRw9dKRBgEM2Oj+YERTpzixq
         SqRF81jPjDkv5dNVx2bLYL7A/pYBDVT8nXD4Cwp/go9CmheuoyJizxWlNlhjJAtYIBml
         M7sg==
X-Gm-Message-State: AOJu0YzgDU9TGPoHVjDe7hCPsamBjfiStAUGYowxFyK9xeWCg9MForxN
	zJXSuAHeKRXrWaQPicnK/6LqVmhxnxVsfKRiYA1joFDGBMI/GaAp7ofVU6IOTA==
X-Gm-Gg: ASbGncsj8F7P1g5p9Qft68D0f9S9bI4eDLwAi3/J6fg/HlGCW5ZTnn1h8zmhCMdZ2oC
	n2H7m3oUdiQtt87PDsfQlCWeChTkjiFdKdn9ZURgFg4XvGIB1VDHcHCGlksBl6Uu+WUqTJUhad2
	pI1uqEeU8TFJ00Wk4hYVCyn9r8YbTc8nxatKTryxMYurGHvw0bTDqNqSZe+0FJdw2EpixuQX6zB
	dxwHVf3KlMce9bIneWjXkrgt+qf1/hdvpPD0yxQ63gLEWjpS5ObyVEOhDpYvS04TumOIlLkdH2X
	fyoMFViwQUeuzJRMrPUEO/bUS5jr8QCjypcLoRHrt6fujfcPRVV4aBiABx/HDYn5EsHhj4Cug0w
	=
X-Google-Smtp-Source: AGHT+IH9q23rr8ojakiJ1qwcHupfpmIrryOiWYWjJAUvaUBwnMAeLcWqKyoaXo9xuS2Zu9YJZ4dzDA==
X-Received: by 2002:a05:600c:8710:b0:445:1984:247d with SMTP id 5b1f17b1804b1-4538e3ae3ffmr6327765e9.7.1750949791721;
        Thu, 26 Jun 2025 07:56:31 -0700 (PDT)
Received: from testlab.kopla.local ([87.130.86.114])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453823c42e1sm52295565e9.37.2025.06.26.07.56.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:56:31 -0700 (PDT)
From: Ulrich Weber <ulrich.weber@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH] doc: tls: socket needs to be established to enable ulp
Date: Thu, 26 Jun 2025 16:56:18 +0200
Message-ID: <20250626145618.15464-1-ulrich.weber@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable TLS ulp socket needs to be in established state.
This was added in d91c3e17f75f218022140dee18cf515292184a8f

Signed-off-by: Ulrich Weber <ulrich.weber@gmail.com>
---
 Documentation/networking/tls.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index c7904a1bc167..36cc7afc2527 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -16,11 +16,13 @@ User interface
 Creating a TLS connection
 -------------------------
 
-First create a new TCP socket and set the TLS ULP.
+First create a new TCP socket and once the connection is established set the
+TLS ULP.
 
 .. code-block:: c
 
   sock = socket(AF_INET, SOCK_STREAM, 0);
+  connect(sock, addr, addrlen);
   setsockopt(sock, SOL_TCP, TCP_ULP, "tls", sizeof("tls"));
 
 Setting the TLS ULP allows us to set/get TLS socket options. Currently
-- 
2.43.0


