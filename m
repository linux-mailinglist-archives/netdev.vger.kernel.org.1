Return-Path: <netdev+bounces-210458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F85B136CB
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3926A3A3F79
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CEC2236F8;
	Mon, 28 Jul 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="iHO4WXGY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5EB2E3715
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691737; cv=none; b=OqZNZGUHw4QzIouhqdJMDp24+in6GNWfFGS/AUEDPTrmmyzMqVHixWVfCxGNjFRLCHxEy489JcWvo6KARtYw8DpGzoJ7U3gZvCGNlM0Yr6LG1ureHDa+FNZM2cVRbrmhJPawiL/rMnTXYbQGG9E3llRgvkhH+3NiODaBe2IJ3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691737; c=relaxed/simple;
	bh=uq+ImxcXIDpT7koBCX+UcC0xIpCmcUr0MukPByOa2Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QBBDFI2fgxYivrYzz4N+qBbyw6W/kq05+MUs5Nq+XLlESZcsuuJ2SpwJ6akWvYpoP5WM4t5m8IaSPa46RkgcTDkEPFvd+0hAn+LdMaMhyvTchUuKhRcYZA9jRX63XAjK+QD6XIlYEBiAEK75sBpYcGPCIMhDtIJK1OyZ8yf2XdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=iHO4WXGY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so8853357a12.0
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753691733; x=1754296533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+GMtvbjmv8Vnpzhp5frnyGTe3+Arr4kqBd4arPc9h0=;
        b=iHO4WXGY17tmTrWpKiCTGLB0bjUBddLJDr0B6lBJppd1FND0bmlXlIFlRHYNPjL63P
         M4YQ/ceoa2KK6x+u2Nr4KaRCd8ZyDpk/9NRR0l7ysOKUaZBwmVXtt4lzEKmm6ojOTO9n
         2uk4//BrhSc4jCSA2F5UtreHjuGO76NdbCU2hzAxRO49pHtcljQTc3ss+q4yNYDjwgdf
         xxiT7bfZD4gmiJ6qglL6OUHql5BUidfOyykhzo1X6ddf1eHJFLAvVVyIxVGwebxAtxFC
         px/xQ6YNoESAEQ2iq0+H/2C1flqfBRpLSX/ErTewbva/XOueJQIgDIQv21D3667OAEd4
         FBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753691733; x=1754296533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+GMtvbjmv8Vnpzhp5frnyGTe3+Arr4kqBd4arPc9h0=;
        b=kevTkerirtzBPgIcyiqW6gL2DK95NBH6tfLmqi2ilbiOWulhtlqb+Mx9k7snm30rLD
         dyhrlNkHB2qVm/1iUnztZVSKjX9kuGRmJMK5oT2HASTJ+IYR7W6MYuruShlYilib+o/W
         wh4kG5NWFy64k1nuuw4LLIMyqi6ostfRkffNDcjt0EtpjGle7kDfUP4osJWg2NKz0nc7
         e7zkO2XmcepyJSskNI4zxeYstyaCtSZGRiJ9PauZZYcdzaHMEYGHcYNCMnorBzXe5CFe
         euumFycy5qggKhbAdtiWyONDckeCtF0Np6als4b0mfRN5rNSSxxjk6VmhQ7W0WT9hzsK
         2joQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9DseucYCKHivrtDMc9yN3Dy7nXiegz32KjEjCAjs2jhpyE+woHWYGvUGNelN3qIxjiMv8hyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1V4wFBMdxkr+ColWzsvyhlATB914KLc6RYvY29GphOpXrDcZv
	gqJrtHaHZYv7JT6EZe+2fsXLD3J5Xm4uUPZb92ai1v1+eVIWgD3/5Jrc9k9Ip1O1dK8=
X-Gm-Gg: ASbGncsjHkdCL1hB8lBU4bcW29ST/sI3GfTuCe5eq2f0oEjefo2UbalF3CeoehAQpph
	9MLXx7rDaBVLwciesO83E2c0BnZpFlFD/jLEkfKRsovyr6ZGy39dOIMl+0guduu3JLQjmfe1Pf6
	0PktGVVTn1+Wvwz1EYUykK81NftBDWM5FePAVyGt6GrdQHE8ZmwVnff00tdPnJIal3O/cdZkv0T
	p3zyKpTFZojuPRxhdrsfudqyDLrL2eCiDi1D7JC9hhsrwXuZvv+vKruoDfdunVdHoJ0JKGRo3sL
	CXwkmKjRIYiqpXyhi8kE06oKVJ4FuDDHI06pG11bhndXuTXyqcmVHlv2qPuhd4qWTE0N5BkpB1w
	ibprOZTV6n4A3T4xz8CsNFNolrbNTEDTuO5V6IHkyriBCfqqJSv5zkBRDYVIzQfhszvMT
X-Google-Smtp-Source: AGHT+IEBOjDm49OG5iajjv5/g2Kv4L9dOcAdyp+LmUUVb1D/Ep2oTi+pZ65JkiAVimwgzoOcYQbOYw==
X-Received: by 2002:aa7:c6d5:0:b0:615:3a2a:e14e with SMTP id 4fb4d7f45d1cf-6153a2ae3a0mr2467948a12.0.1753691733390;
        Mon, 28 Jul 2025 01:35:33 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500a5a014sm2968551a12.20.2025.07.28.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:35:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 28 Jul 2025 10:35:24 +0200
Subject: [PATCH] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAEs2h2gC/x2MSQqAMAwAvyI5G7CF4PIVEak2ai5VUhGh+Herh
 zkMDJMgsgpH6IoEypdE2UMWUxYwby6sjOKzg60sVbVtUA6HhCZDeLF+/RhPlbCiI6r93Ey+NQ7
 y4FBe5P7n/fA8L5RlE0NsAAAA
X-Change-ID: 20250728-ipa-5-1-5-5-version_string-a557dc8bd91a
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753691732; l=1189;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=uq+ImxcXIDpT7koBCX+UcC0xIpCmcUr0MukPByOa2Mk=;
 b=G2dTIgCPaZQDwhSQBS8d3RRhaJYTgThtBtF6HvSRKoozUXXxKyIRBsuhIuvD5vSc+6YhRgF8b
 69DChLOqCBiAHNo5Qr44J9qFsvTOU6dnTVrTZzCAhGRVB9PCbSuTTns
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Handle the case for v5.1 and v5.5 instead of returning "0.0".

Also reword the comment below since I don't see any evidence of such a
check happening, and - since 5.5 has been missing - can happen.

Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/ipa_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
index a59bd215494c9b7cbdd1f000d9f23e100c18ee1e..a53e9e6f6cdf50103e94e496fd06b55636ba02f4 100644
--- a/drivers/net/ipa/ipa_sysfs.c
+++ b/drivers/net/ipa/ipa_sysfs.c
@@ -37,8 +37,12 @@ static const char *ipa_version_string(struct ipa *ipa)
 		return "4.11";
 	case IPA_VERSION_5_0:
 		return "5.0";
+	case IPA_VERSION_5_1:
+		return "5.1";
+	case IPA_VERSION_5_5:
+		return "5.5";
 	default:
-		return "0.0";	/* Won't happen (checked at probe time) */
+		return "0.0";	/* Should not happen */
 	}
 }
 

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250728-ipa-5-1-5-5-version_string-a557dc8bd91a

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


