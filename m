Return-Path: <netdev+bounces-198909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A2ADE4A6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07123A7BF1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386127E7CF;
	Wed, 18 Jun 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTAl8TCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4719DFA2
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232220; cv=none; b=ttmV6s1ZDk7GadT4SJuAPsYi4kIuzbfmoONRv+7/MHXS40ccI2mf0RzND13wa8oOz7VVsKpvqlhc8Fmtcuqr5w1JbVn8mi+ax3Uea+pTIRPHMcX9qC/oIITScpvkqMOcielc63iFVFhfbvOaYwnS6CtCmD+ufyInsvOuwIe/JtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232220; c=relaxed/simple;
	bh=WkRs/TboFDX8xfzfGINehv8lcvkeaBoDHGvUNBlrxXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfF8KU2wUe89K38e9kXP+TDuS3iJmBr3Fogxtms1guAeZPomso+oSb44PSHj32+p4fwgGgKKFd2ZK1pcCbiGKB7vA7X0onS7Ixul6iXo+1iu+x+FLwZPOMLWqrJFRzGyF72Wa4FJFJvzqVsgfA4YBw2mgBHy7lwvRGV6CfJAWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTAl8TCO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45306976410so1973335e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750232217; x=1750837017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZXBxt0cc6L0naAoZJZAGNT6TJUcn+mtDHZVLEqs+No=;
        b=LTAl8TCOxh1uOwiGrB8LrimzoI0hpWdZKIcoOk/sdaTPZ0m/KK4oTpy9EpyCWySKaO
         rVguNPBlRlEtticcaia4kU44Szw1+PNwbceUGu41zmDdX92XKLgqneouNgIZuk/9W4zw
         NTMM57h7Sxi7GLnoAhaEKEzoFykIglwEYCWzxDa/z6R6PuoDHd2WUOLW2i0WZEPwI9cY
         wst0pI0mBX52ouJd0klX+SEJbZQ7WouC+oq4sp1HKqP+VBmKNkyQgDhIxT9NxiGTsAeA
         bUVoxDpNRUSALO5U0AWUUIJ+oYFwjhsUsUY2pJoZJja+sW1b52vCUvEEUl6vXT9ue0xe
         IkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750232217; x=1750837017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZXBxt0cc6L0naAoZJZAGNT6TJUcn+mtDHZVLEqs+No=;
        b=t8tlfKHK6eH1wprrSl+4nQ02M4yfeJ9ePv9S0z+9KObWiNL//5PIyKzS2BtW02Zh/Y
         Pbl5FDR42kHiELGGgBJ+u207rBYjfNOW9OxcT4tBOnjvRIQJDYJQtuzvP7OSX+56CsDm
         VafZNP8DJ8mfi85WKOIRc5gmrK5FbKI0MOz3sDrYY3p94ct0BLp6Sgvg7mvxXGY2fxW7
         tfE/1nU0+OYKDI8ea8k7bQXZ13AeSBQ+4/uWk+elGzWOmJpwutS6ugahLppSZ/GWdh9J
         nJWO+85wJhfm5mnYjaGCFYBBo73UyxoREryX2WmfLv/l42NzE82m0cfxERBO1Zuil11C
         Df4w==
X-Forwarded-Encrypted: i=1; AJvYcCU5kT4Dyub+H/q/NEyIA9/mWO4gCP78jkzmiH2vZLDgIOi5En2lh0YEGaSxtyJ5G8Zz92ZrjFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDzR1kZBAGYGQikJ9yQzgUradGvGYxAes93sNrb6ZHZQeGISP
	PKW2z61GYZcGpiMoErtsyr6RbwK4pdSuchTMRc/7Q6LcU0vzhSRtz0aU5RLKx8i/iSE=
X-Gm-Gg: ASbGncszqTinnXyN8hdU0ftv/3tvsaBtmIo9ita1k0ofhLBhoB5H9wdnYa4YUzYKS80
	g9eu9wkfgOkZluH5NW4Gy1ZETNEdWKZdH1wWn1NgcA+xlQpS91CYPpp7S9PC0Gaybe7LWtTGQsj
	z9odYEsiS+XtAKDOk4dKHyttM8Lf6s71E6Md3xZ6YEUTG/2EIGEb5Us0fgloHikLf5rEn5o1872
	2eK+qhoZTV2aZmria7lCm/XY0lYH84F/q8DuLfk9QnKnP85fJpM240ICGv565N5DGTzlQApJmsg
	TW+ErP38jLqx0nDjvCjgqn2Q5aKuVOukZNNsp/zKfVgrXCQe+gaHq8IcxU8+DEHi85ZX9fJLni5
	U3u4hoaDV
X-Google-Smtp-Source: AGHT+IGzdx4bFzKCr1o8dRWdVSdkAmLcmC90spjSihYQwSyc0weZmyPLolTCTmYgiIecY8zC3ErPWA==
X-Received: by 2002:a05:600c:1d0d:b0:43b:ca39:a9b8 with SMTP id 5b1f17b1804b1-4533ca48dffmr58906925e9.2.1750232216922;
        Wed, 18 Jun 2025 00:36:56 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8f2e0sm195792835e9.8.2025.06.18.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 00:36:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vincent Cuissard <cuissard@marvell.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH] NFC: nci: uart: Set tty->disc_data only in success path
Date: Wed, 18 Jun 2025 09:36:50 +0200
Message-ID: <20250618073649.25049-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=WkRs/TboFDX8xfzfGINehv8lcvkeaBoDHGvUNBlrxXw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoUmyR9Sy/6+NxZF35Vz8mGEq+q31qkerrdCl1S
 kIPLmllOdKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaFJskQAKCRDBN2bmhouD
 13omD/4zhyiDc3yVsBfIujWpgDnnQ/l3ePHvdbts5xY9N05fFjRhLNIv9Z/PMQfCL5sWiYJxZZo
 9X1IAcKsu7TItxoN+Kx8Ah6IruEbidB02Nyt/C9TxaWVzETWDWvDCUQzwpM1H1lVNmQPojXIwgU
 wZaoSbr66Qlgyygzsh8npVA48SkBzSucYhEpPfGVP2+5MIMEJthHwGaoUyss0tfJAGD0XA6VMl7
 Ad8vdIwkI0ZCY3kkpnHxYMsWSYFzJAZmRRvrJC4B2+rQHdctXwwfSvjBrlTWMV9r6tt5c3EBk/P
 xnmPGhzHSXp11rasBPlmwmubeC4879dQdbewqlIVj5ymyfSVLqOdvzoXrqBwoXajhxUDS78SN/y
 iEs/8phFmc98F5kLrJ2cB9zI5hoSD/VmM50fHfgjuVpSjF+fQqnRl4D+wuj6rgvmpmL5otgI50O
 eUC1qmE30Almsx/ey2bbBlVsHeSvC41jwzdMK+Y93qjIoZdqaqVc4AztnwPFk3pCw3f/dnpCn8Y
 YYleGNGUgPIcPC5sKa/McvfOHO7VHEHTXkOfuTdqk5d+pqc6XesjhE3YKNTYLyO0rWb70akwz4c
 l9Ey/IYMak4UQ0W6IgEV1JIL/PHA6xqIs2jbjimYqngW79+VBvS77zkrz4B4ZtSNvuzp2a59Ej7 bsaAbyuHHDH8vfQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Setting tty->disc_data before opening the NCI device means we need to
clean it up on error paths.  This also opens some short window if device
starts sending data, even before NCIUARTSETDRIVER IOCTL succeeded
(broken hardware?).  Close the window by exposing tty->disc_data only on
the success path, when opening of the NCI device and try_module_get()
succeeds.

The code differs in error path in one aspect: tty->disc_data won't be
ever assigned thus NULL-ified.  This however should not be relevant
difference, because of "tty->disc_data=NULL" in nci_uart_tty_open().

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Fixes: 9961127d4bce ("NFC: nci: add generic uart support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 net/nfc/nci/uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index ed1508a9e093..aab107727f18 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -119,22 +119,22 @@ static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
 
 	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
 	nu->tty = tty;
-	tty->disc_data = nu;
 	skb_queue_head_init(&nu->tx_q);
 	INIT_WORK(&nu->write_work, nci_uart_write_work);
 	spin_lock_init(&nu->rx_lock);
 
 	ret = nu->ops.open(nu);
 	if (ret) {
-		tty->disc_data = NULL;
 		kfree(nu);
+		return ret;
 	} else if (!try_module_get(nu->owner)) {
 		nu->ops.close(nu);
-		tty->disc_data = NULL;
 		kfree(nu);
 		return -ENOENT;
 	}
-	return ret;
+	tty->disc_data = nu;
+
+	return 0;
 }
 
 /* ------ LDISC part ------ */
-- 
2.45.2


