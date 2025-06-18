Return-Path: <netdev+bounces-199091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B858ADEE87
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC4C4047B6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595392EA72C;
	Wed, 18 Jun 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCwnS1L9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4621C6FE1;
	Wed, 18 Jun 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254871; cv=none; b=Dk3Q5F059VevOsNtdrn2pIRLOk6jnXLTQCACLcd/krYnN7zx1TVoJMDTcQIDOLmmn3NvtxsrkacBZKw0J1egKdqVGJg2IFqG00bnr0BrqVvgxBffwN13VyzcOnBXIwQaq/wGRs9t6F1AIcN7Q9o+I2NuiOuc1fxtbb3W/Xr4DH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254871; c=relaxed/simple;
	bh=UKk//vSIWaJthUCrkf5IZytcjvhwxfOCufg0WdZ1FaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qp3ZjO9nhwrDYUu9PuI9KHMNSMLd8ueuatW1cdtJiZeoqz2ytCcsFHqlQYrnrxEhOm5HdLZi+eDYx9acPbjGc502DzwaK3b7UDytLXcBz7u0ebVNLUea7fdAEsb5T7X7Z7HvYAPwXl2sgOQDiHY4jc4jNXNsyd1SbVhorCb/LSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCwnS1L9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so78815235e9.1;
        Wed, 18 Jun 2025 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750254868; x=1750859668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VsjqlWk6bmFlt9a3E9KK327lUQiY5+ZZ+i/JJjNAi0U=;
        b=aCwnS1L9Qf0TzTSXXJNemiEsxWnDNOyKuzTIODgwGgqpaqlwC/8FVOp+E2SAx3cDz/
         fOtCEQu8PB0n9FbG8+x8/pkxwwlLQvAG0FKBcxkAqeT/ha3rqsFJW/b/9nrnt2Jjc3Gb
         ZBQSKT57ROSZaa8aDcevoauy87Saq95vTOpkm7xwZ9qdJp6m66/hRhUVwA/wtjcVOpO+
         AeHXrCFvmSD/2CRSWLubsIlIEB642kiDVzff5dWzyDPy73FM56H24cLJLhd81I1E0v5p
         nKPTCnSdmSJRXN2yOWMl46OEuKFagir5vh1qS6DBYnY/mso5wangTCxgplyj2WE0Ca2o
         WuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254868; x=1750859668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsjqlWk6bmFlt9a3E9KK327lUQiY5+ZZ+i/JJjNAi0U=;
        b=xCwRO7f10Gt9dRG90XiXK2L5l0bZrZGu1KUOb4kUDIWiGmXjiG6njHxw1YlmoBIi3u
         JCbJIs79vkWY1cVap7q9aeuXXrf1kiN3rGN/yWx9VjeX3R9xGnWyD++5OfeLjddXDCwb
         yD4Xp6BtR0PVJI4bORxPrct1cSxZFeq3B9wuR2Nfz/O3HkDnZyOTNgUpNhSoJGcjBa0o
         CVJLgEgHh3gddRTF9WMLNzDF6TBILXddhARE2tHp71nGWLIQ+JiUvqkZkcNWyI1SAvmc
         khepJ51zWz9ofHY7hVMmm2BgVl3IroyXHoIZNX1AHqVXQHDhSEWZm6dhGxGULmMTTAiM
         R1EA==
X-Forwarded-Encrypted: i=1; AJvYcCW25HwrfKSfx5/8R2qVZul2sjKX9KdmJa3jTiWfnhj2NBbpyGuXcyIvAxp8oTmC2mcGyjLGpy0iuHEPA28=@vger.kernel.org, AJvYcCWmkVZyoPc2a7GQPyk74mwhHLBHIxuEn1ngFYQZauIJmxgg/XRJoVQNgHL9+8wuTHOsJ6Bs45o4@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCKmiDajd+lEVeGaJ8Uozcn96CIFu9J014hi5tCnNhm/2LMb7
	DkTETy881u2WVuGiOStXGwxbJPqtu3c9TZ3i9CtoucIIWcMOHjo4+4CK
X-Gm-Gg: ASbGncvVilBz4rr6nXfTcEoub/Kb+0nyEEmlKstBcAf1UsNvGrMDwYpQbFJVlv1jvhA
	EL+UPC5Mqx8ynIoHTvcdSBZ7lJO5PQ9R7VSsX1pKhEbxqiklaIbp+3Lns6dqeRSXjg52ttksSrd
	PK0ls3XCD2Cu9L8zt7OJv/hYUPU2Y9DrH4b3ejse0+gi6u1n91dRNu7O1DwftVqtGfoYStppL6E
	V1QLyC3MSgXKLcilfGN5lztzEL2enJ0HFfJtH0+08l9KUMMYH5jmwqr5wC+hZELhOALnkFPS0T5
	UrZAmKhbYmFwN5Sdrm2D2lPQGJkQDmNMvTMJfZYrTlFpKJ0yFs1Vr5t2d4j/
X-Google-Smtp-Source: AGHT+IGK0BK6ayZuw30y2UmFGch38fYUMJhCpRBmDebTNO7bFXfxfhyJc3ld19M5sFBfc55vHw3/ig==
X-Received: by 2002:a05:600c:698d:b0:442:ccf0:41e6 with SMTP id 5b1f17b1804b1-4533ca4e339mr182304675e9.3.1750254867610;
        Wed, 18 Jun 2025 06:54:27 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e156e8dsm214525955e9.31.2025.06.18.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 06:54:27 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] igc: Make the const read-only array supported_sizes static
Date: Wed, 18 Jun 2025 14:54:08 +0100
Message-ID: <20250618135408.1784120-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only array supported_sizes on the
stack at run time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index b23b9ca451a7..8a110145bfee 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -431,7 +431,7 @@ static u8 igc_fpe_get_frag_size_mult(const struct igc_fpe_t *fpe)
 
 u32 igc_fpe_get_supported_frag_size(u32 frag_size)
 {
-	const u32 supported_sizes[] = {64, 128, 192, 256};
+	static const u32 supported_sizes[] = { 64, 128, 192, 256 };
 
 	/* Find the smallest supported size that is >= frag_size */
 	for (int i = 0; i < ARRAY_SIZE(supported_sizes); i++) {
-- 
2.49.0


