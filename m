Return-Path: <netdev+bounces-170186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B200AA47A5D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353621892632
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8022A7E5;
	Thu, 27 Feb 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KrKtpelL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D5225402
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652436; cv=none; b=Himcwm50Rz6S1I1olJQFZIpwmAHQJ66RcmxbBnfddX690fDe93bq/AIpjDuFiCROwoYfdmd1virOiV1lKzvswjltP6Z7GaVMFKJhWqAUqct0tl7zAzHYNH45MLjVNfXsIVmLYfJQPz+I8IFNodr0oppduNlS0RgsPntxXDMpCV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652436; c=relaxed/simple;
	bh=yNg0EW/sSTagffgojXuqqjjQihItDBy+BD9n5x9G7iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKqBPrBp6w3SO+qPbkcXalTGVw/7CytH+ZMy7rufB28tcaOpg9ngqLnKGjvn8ge4qReQJGebLyKGw9wdzgNEXBBOVuUGPvC3ZZYds8aBmeVrXyor4gsJv9OPFqQhG3w3Rx2nOkcn1S5Qr4aWF/K2I3vHE2fYiPonte/d481bB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KrKtpelL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso5082195e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1740652432; x=1741257232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6I9Y2sm2ZO37jUC9MCmxExXieoBlnX+XT5yv3CFjg4=;
        b=KrKtpelLhQZkTVtkt4uBTi1dJlqgq62w57BMfhUah4dK7iAXWCow6YEK0+uSieNpSJ
         e+lgAM87LbDXBvJv89ujLZ8K8LPPkCU5GaPeLJy039jB4pE7uitCKy0GHZycSQXFQU9m
         739vz1FQO6Mbg75ygwxYE9HmtAdHX7yEfoxAC5aBiyytjVb+N6Edn51TyH025QpAZOif
         mG/KYXOZ1BJB19kubx798uwA5bh/uSgBhXFzYujhzNFH0nI0hf+W8fO9xkKbrTMIAzZm
         NS1SPYiiHdBo7Pby/u2GctH7ow4L1o95AWfOFTATGQyO1t61nx5mgbE9Eo4q7bDShbo/
         8LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652432; x=1741257232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6I9Y2sm2ZO37jUC9MCmxExXieoBlnX+XT5yv3CFjg4=;
        b=NjjHQQ0DWw0MlYOi+vVmWFo9pQvQAXe9NiaLcIsokXQXEKsdVvCv84At+PyrG9Almb
         ZD9yUbaSMc5z4GOLjoJ/jA6I65NE2rE8CO048WerKTSVfkNq/i/68PALDc2ZEsNgY4Yf
         uPSsmnM7xzF1WZ0x1Y6nguI39xGS2WR2VhFDdyeveiaRDnMU4ZSPKL9DeZYZALhdHovU
         H1en36ZH2Fy9YoPdTO4R78/CrRCv9IEHQjyuxdUjJdymwaNF5lLrgYKxDksYwE+01SaV
         hB/0bNoVTZkoyQ61vhDI64aleVtXSQGszvVs/pXvvZlT5tiyckbkjC5PDW1hdHAsD55B
         xkxg==
X-Forwarded-Encrypted: i=1; AJvYcCXazMo5YSeIu1UEY4qKq9xv74TKKC9Woe0OGsTl1wHQ4fetru+rWLu6dJq3+9PwDWzxqq6SGJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Q2ArVB9uDYlXrBeEw1h1OXTeHTtNAOz2F7tLApuWmsYdfhNJ
	NiJqBIlfxLVsAQfdSx+nDvxB4QrWH8SDPUiYptzaoMbkIyNxnFDPNIghzM1Khmk=
X-Gm-Gg: ASbGncttw7pOyHqBsxlYhesTbQA/JrMmAnQ6l721Oog6UDHh9WTi8BOXGlrNzkxwpHg
	Nbmuh/mhz5Q2+nmOFP1N7v2VBC5LVwso55Nepi6UhHa1fdotyUC/uBfjBNvql+UWtVW5r1+9mFV
	e0OUIlHltLDJUDQj04obQgR5j5OSHIW5tAhKvMWoupLe2yfPEnMcYD195rw11Xp5q1VOyzZAHbD
	MDTMm+OpH4oydp6id+9aMoH8ujk1RBG2AUUWYtQDlpsWRwDG0HDqVr1W9FZByrU+gJKpOALNH/H
	cCF/5cGX15PG2xJqzFILguZDI58baycoA7W7oHhTS0k5rXF4VpxZjZABw8yDK7U5Oe0NhhSZNq8
	=
X-Google-Smtp-Source: AGHT+IFCt9u0coO8uHw2mLPkv/N6QOb1W05JtNtgr7XbEDzVKeQRsZ/jpOW0SzEfoBUonlsoaSDtAw==
X-Received: by 2002:a5d:6c6e:0:b0:38d:cdac:fc02 with SMTP id ffacd0b85a97d-38f70772b89mr17494957f8f.4.1740652432196;
        Thu, 27 Feb 2025 02:33:52 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27ab2asm17854305e9.32.2025.02.27.02.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:33:51 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 27 Feb 2025 11:33:41 +0100
Subject: [PATCH 2/3] net: ipa: Fix QSB data for v4.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-ipa-v4-7-fixes-v1-2-a88dd8249d8a@fairphone.com>
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

As per downstream reference, max_writes should be 12 and max_reads
should be 13.

Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/data/ipa_data-v4.7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index 7e315779e66480c2a3f2473a068278ab5e513a3d..e63dcf8d45567b0851393c2cea7a0d630afa20cd 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -38,8 +38,8 @@ enum ipa_rsrc_group_id {
 /* QSB configuration data for an SoC having IPA v4.7 */
 static const struct ipa_qsb_data ipa_qsb_data[] = {
 	[IPA_QSB_MASTER_DDR] = {
-		.max_writes		= 8,
-		.max_reads		= 0,	/* no limit (hardware max) */
+		.max_writes		= 12,
+		.max_reads		= 13,
 		.max_reads_beats	= 120,
 	},
 };

-- 
2.48.1


