Return-Path: <netdev+bounces-212445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD1B20709
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 13:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E05F3B3B00
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC262BE7B1;
	Mon, 11 Aug 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ9Yk98l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255623B627;
	Mon, 11 Aug 2025 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910774; cv=none; b=NU4/G0EdK1Oq98ZlDDw8KCFbQt4yBBEOGpil0K3GJv0b0e/uMfBghNa6pVtxxJlAnXdtkdhSpwOQPvBlDswNSF7+2cg7HKdIW0QABOKTb7OGNcKkyYDWtZYs2ahdvlDuO46ZKRqDt2mW1ec1n71VdhkYjXKhBKRGhD5IKRyNIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910774; c=relaxed/simple;
	bh=1RqIFn/aCaYbnX9ev6h5HB3n3Q7qvPW4lFjEXenhedc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G0WN+9P0NksnbBBhrw6Mi4R+bYFKrDZb4PcuMfBmkeYbQ3NYq60j6GPBnJRbT4wmpd/WZW0FPU/48y4M7p3SjtFJnZRty5SScK49bGG20ODu2uFYImmFDyWkP9lsnZPQPcxm8qyXzWNU12TnLrxB7B/xNxbowdkRobrZkrhwzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ9Yk98l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b783ea502eso2923297f8f.1;
        Mon, 11 Aug 2025 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754910771; x=1755515571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpFd1p985Zt2FE0ikX1FewH4hrglpUtZfkFtt2DZdFk=;
        b=eZ9Yk98lzgHhcUoIzx5D3e3q3v+fRkWmUdclt94xqu7RDerdaZO1qby/pmtwxZjooM
         HmuXYDPsCSzcYV4VjQuWradpwtbzLBPdItiSbWGfJp+Kag89Dm7KTGrIodeY7pola40x
         pWhTGoYXt46Z6hwLxjnqcWigXefKa1pugVYNHZ5JGrGg9+hrB5GMYbx9A/G2KwWFHq+H
         ZiiP16hDacpZXdQRKT5SVML/5Fea+SNUVcTiokq3oZ3vx6U7DRhzVV30TTAZ/Jqk8bt/
         xbBAnYhbttBpRE40yWmgm/LqdaReluiipAABl3TMzaZlCnUuFp8EPvtJGqSuYSFdYUf3
         Oj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910771; x=1755515571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpFd1p985Zt2FE0ikX1FewH4hrglpUtZfkFtt2DZdFk=;
        b=GqCOnJgkL8+oHQB1X83hNwIKPpNiZAyyONHSXCttmcy47+n+yxilk+dFskG/k1uwEt
         C31lfFTXh+4mEiQBk/QaA+PfjtcQ7Z3424ftmw3JWEcMaiqAl65z2+VJOboZ5icW1Ir9
         3QiOOfcvnWCPnxDFiHUTxLMZGRVcImPeb6ueBYDy+YRRJJ3+abuDol+eCtxTUwWQi/i9
         9GbItvTdYYb63taC9N0jaGkg8sd7xQLHGxwuzqhWaHvaYAVEDlM7HS1ZgY98EP6FQq4x
         jDK+yX5VSI9DCLi0lGdK63Rde1x86d/PSCBQy9NKFBiya59GGjZzBiFD0I2CNlLjv3xm
         06Mw==
X-Forwarded-Encrypted: i=1; AJvYcCURk2jK8NV3UTWcTZm26Ku8wACeTuCYsrXIjAezXTJyXQhHffM3ZewZyz5NOEn4eoscpkuSyViw@vger.kernel.org, AJvYcCX91HqXJUMZJwxLFUoNCY7wt56hz5pBVBTPoXYJxtX88TjHsUDVmNyUxZhcCwv89oxZaQjwlcoO7kp6cbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrOKUDty61+O8PSlkxDJbuUT99TyRLNGuWHq1IpuGNuQ5bz48
	XdGqpp7iokq8gKDwkIRVtE7aLqDfhMETnZZ+B3S9bxjV4A0TVbkPKAQt
X-Gm-Gg: ASbGncv3OV4MCz1B5NAi/pGiCxrCB4IXjDjpKMCZi1VQmIw75uzaV1CgCtDBS4ZdUpN
	P+R9LrcTkBIjfgawjZcPX2wkJ32EJGqZGE0QZorpewtHeDczQAknJSYVL8FzxVn9axrMBCNvlcN
	F2QRyXUK+EEsA6jpjBEaOWe7dNFJq3/mCCEtH7O1boF7Y9joz/kGSorSuvLTeDlfcBnnZfFA7Ab
	ODcd2JiiWSo5USHiyr2nphB13Pkt0wmy9Ep34xBJ4mSfrHRbadPi0NNXVQ01EctFpNPuXUzG3ck
	WzmfTqJWmj9OL0OSucxYwwqdYP+1k9QEGqGM9nTKH7B48mr2h7OFMA/s0zn5C0f2KL5WtCIK242
	UJHxUEViItud9VVwhoOAU
X-Google-Smtp-Source: AGHT+IEgnc5QqrRg0lz9+OdndWHdvt/rKwyilSbik0M4f9+GbjXlUx7jAfvxAzW/AxvkKUcd3R5bIw==
X-Received: by 2002:a05:6000:4308:b0:3b7:915c:5fa3 with SMTP id ffacd0b85a97d-3b900fe7e69mr12080048f8f.24.1754910770430;
        Mon, 11 Aug 2025 04:12:50 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3abed3sm40116248f8f.10.2025.08.11.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 04:12:49 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: make variable data a u32
Date: Mon, 11 Aug 2025 12:12:11 +0100
Message-ID: <20250811111211.1646600-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Make data a u32 instead of an unsigned long, this way it is
explicitly the same width as the operations performed on it
and the same width as a writel store, and it cleans up sign
extention warnings when 64 bit static analysis is performed
on the code.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 4846bf49c576..467f1a05747e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -251,7 +251,7 @@ void dwmac_dma_flush_tx_fifo(void __iomem *ioaddr)
 void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 			 unsigned int high, unsigned int low)
 {
-	unsigned long data;
+	u32 data;
 
 	data = (addr[5] << 8) | addr[4];
 	/* For MAC Addr registers we have to set the Address Enable (AE)
-- 
2.50.1


