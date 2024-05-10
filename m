Return-Path: <netdev+bounces-95438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E37A8C23A5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFFFB22288
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E070175571;
	Fri, 10 May 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="MozL53ih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073B17556E
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340682; cv=none; b=Gc5Bte76DHxmixO0qwJPuVJF/8CO1agu5HGpZn7PGnRaqCWh8IYqRgsBMLJUZqhL+54MJvIpHiRFv0klobCTCzkkF97jQkyvBzJ4b0maocoRpXk1xEr5/Nvv+jRGnjjNkY43oT0rEkh6E7r43SqYPGzOEldd59CLhD8S89QJ3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340682; c=relaxed/simple;
	bh=j9nzsjB8ZKN5OEzUlhmbXTCrNTlkvkyve4S9+JzLx3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKnLpno9Ca5uTqf/nP+/eXbEcsIU6GVSwLGDoXb3Si6MXn+o+pj8Cao8A8H3VLgBZ+UIq47tWf5seegSyxJEx1sq1o20UnJGJdijpGB3yrZ6efH1/Ny9al1S3mcE9/GNDKD6P8+bSWvS5mJBu02fUWWI0GJFPXNTYu2u/46Py+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=MozL53ih; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso469145066b.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715340679; x=1715945479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka1+pk2geib/J7YLFiKu4r03GZT40+nA2E2uYjpMTOk=;
        b=MozL53ih/i1Bvx7NVVn0ZxZdsKg7rnyF7Hyo0irZxY4QHXc6cQR0c+6aE+K0ebWNJo
         9zxwSPbZ6oCFIIETIfsJP09awBHZrfXzlGTmU4urUJzeZdEx3SenltpwSiuNojDU5Vyk
         iLFuGJAsRD8P/oqMdosTJKHq/0bxirLYZoawVqld6T+923Rxpzod0xZJx35Ed1xo/rx4
         SFFqzLRbyx7ykLqNuROPOG40k9WznVHW5TyOJR8roLBToYXhHuDNArYJUxauxBCFeMnB
         avuCUMug+yy2kGC8ZU3vYwL9N3aMKOIbbcyFno5PqW8Y9uFcAyiELCgTqTUSD2+/ZLhM
         zYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340679; x=1715945479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka1+pk2geib/J7YLFiKu4r03GZT40+nA2E2uYjpMTOk=;
        b=tF+nhMHr6sOcx5t0JK29GBWRUv0ymi/xu5mpSPYcY4KmGlWRD6Rb1J6lPzy0bWIAeD
         moPXow5jX20ZNnbNvqUZ2iQokAD1mXqu2p2yXdhK39JJyPFcd6i2ksfmGLqWmiHsBJ2O
         1QrbyW/o4jRymK+ZhVNhUeo7OcJriz/Gd/oDaIbhvI6i7bYC2TnzuUllsPf+1SfYZ8WG
         vujV5yUVFB/t7wi/qSDuUTRSFQU88UNhHgmZkLCE6wv4r7Cm3dOfb8Y7HvImS2pBLSW0
         ezk08GRZ5m03LY5JF1N02PrSz1aMNquiWRoxytv1myZ6s8quaxF5hfRG6MhOjUlDnoF+
         1MNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3wJBO8OOsqOfNP7Umy6EqrGile/DP2ydvC/E3S2lOvmS0sRvA5wzLLHmSLQ5zkDNzjWN69dDYBo7VGHYPok6Gvzg6dw+y
X-Gm-Message-State: AOJu0YzDmj2I7u5DdZC41lH6wHMQXn3LiCMPty1HiJf4rt14ylXre1sC
	1Epcxjth2aVB4MaQRbMCDh52HlgUHr6R0ZOlbT0g0cOut0s7iWOHlZSMqPDsqDc=
X-Google-Smtp-Source: AGHT+IFd+1aMcsICY/YHsevY1zrNmPQWHgy87tSrQJHc4ec18XtFpWfX1JVZFQt5CdbgMWOYAkrSdg==
X-Received: by 2002:a17:906:7084:b0:a58:96fc:bb53 with SMTP id a640c23a62f3a-a5a2d5c7f02mr169164866b.20.1715340679364;
        Fri, 10 May 2024 04:31:19 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d5afsm176254166b.3.2024.05.10.04.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:31:18 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: andrew@lunn.ch,
	arnd@arndb.de,
	davem@davemloft.net,
	edumazet@google.com,
	gerg@linux-m68k.org,
	glaubitz@physik.fu-berlin.de,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	pabeni@redhat.com
Subject: [PATCH v3] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
Date: Fri, 10 May 2024 13:30:55 +0200
Message-ID: <20240510113054.186648-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509213743.175221-3-thorsten.blum@toblux.com>
References: <20240509213743.175221-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiling the m68k kernel with support for the ColdFire CPU family fails
with the following error:

In file included from drivers/net/ethernet/smsc/smc91x.c:80:
drivers/net/ethernet/smsc/smc91x.c: In function ‘smc_reset’:
drivers/net/ethernet/smsc/smc91x.h:160:40: error: implicit declaration of function ‘_swapw’; did you mean ‘swap’? [-Werror=implicit-function-declaration]
  160 | #define SMC_outw(lp, v, a, r)   writew(_swapw(v), (a) + (r))
      |                                        ^~~~~~
drivers/net/ethernet/smsc/smc91x.h:904:25: note: in expansion of macro ‘SMC_outw’
  904 |                         SMC_outw(lp, x, ioaddr, BANK_SELECT);           \
      |                         ^~~~~~~~
drivers/net/ethernet/smsc/smc91x.c:250:9: note: in expansion of macro ‘SMC_SELECT_BANK’
  250 |         SMC_SELECT_BANK(lp, 2);
      |         ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

The function _swapw() was removed in commit d97cf70af097 ("m68k: use
asm-generic/io.h for non-MMU io access functions"), but is still used in
drivers/net/ethernet/smsc/smc91x.h.

Use ioread16be() and iowrite16be() to resolve the error.

Fixes: d97cf70af097 ("m68k: use asm-generic/io.h for non-MMU io access functions")
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use ioread16be() and iowrite16be() directly instead of re-adding
  _swapw() as suggested by Arnd Bergmann and Andrew Lunn

Changes in v3:
- Add Fixes: tag
---
 drivers/net/ethernet/smsc/smc91x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 46eee747c699..45ef5ac0788a 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -156,8 +156,8 @@ static inline void mcf_outsw(void *a, unsigned char *p, int l)
 		writew(*wp++, a);
 }
 
-#define SMC_inw(a, r)		_swapw(readw((a) + (r)))
-#define SMC_outw(lp, v, a, r)	writew(_swapw(v), (a) + (r))
+#define SMC_inw(a, r)		ioread16be((a) + (r))
+#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
 #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
 
-- 
2.45.0


