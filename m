Return-Path: <netdev+bounces-157658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684BFA0B281
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C426F7A1C01
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661F239790;
	Mon, 13 Jan 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2P/67+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4423875A;
	Mon, 13 Jan 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759761; cv=none; b=bszUnBpE94F6lU8rc+P5q2RkJFBbr8TIGGCn6gLvrcTXxVQ3QN0rQWoscqmo6x0wKet71AAh+KB4YQcIBoaEheQOWLOtBTXIydUDoAA5AiE0IJdofIoBIDwvgi9qYuLZzgExGIYb1iRYpKNXYqqiWFvogfJbRtA8LbgGaN4pY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759761; c=relaxed/simple;
	bh=2upNpvYvkCawsHSbcv9E7oJy4xTvN7h6IJpVbivirN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SprTqexOAkKfetMkhFGxTF2NvpHR7q+qLoOJr9aOekPiaIBR8Yy0bHAiLvmW8eEtM4z9fXf5nWbzm7Qq89hErgTLZaTOqwY0gM0vJndSYwtxAX4gMcxWGz71CUFWNMV4T+ea/w20c3V9/yYKol6UnmhD48QwvHxCx+VxzVNFWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2P/67+P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361f664af5so46301875e9.1;
        Mon, 13 Jan 2025 01:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736759758; x=1737364558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2ygkQJ95X1g7NdQpmB1nFBFWpKiLZIqDirXmvA8hQQ=;
        b=e2P/67+PV6JiHLtVTH8ZZPJQTThYaVXYK9S/TEtsV54RnmRyZTDfbZiJxLQpMA4Tko
         1k/DHFUPrRa8otU5UtQ90q6TAsDAFkxmLSG0KI5AXkGJBaYQWBbbNzRv8DRU9IUsREHh
         ssQm24ReB2JtdSyia8/fA6eyr6j4EbpbPFUbP4sVj+dFjVGwKmcDRp5bQRTdJBZMOMNO
         /PrcerwQmEgDN/V51P/i2lPtwIIDbYIJ6wsP4ECsXchxNW3FixbuXaISXDjGb6mGK6uC
         GO34pS3NoXPQsurW5dVruQgjysW90XMaLpNiEOs1b3ZGwVxf8Lc0aqRW/PdIHRbCSmBM
         GrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736759758; x=1737364558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2ygkQJ95X1g7NdQpmB1nFBFWpKiLZIqDirXmvA8hQQ=;
        b=EDqlAGbF964miv4bIpjlJrS8i2X3n+/lT2CocWPYcrWeos/1gvvUFg0viouzgt2qcH
         bFN9ZJSbXVZ4xUniWpWi1xzs+QNYd+bD/lHzEvxmLWCw58wNJ9t+H4TV/gzuOfNmGvw7
         2oO58ornGrM+/qHPLB1FWQ6Y6XWa8K4bx7y2xlgWDd7cr0b7egiyveSWO4TKfNE1kIWa
         XZrss8WjnO9odtaBxwVP4Brme8hfe7oMIWfKfi+kktpfQY5tfxyCHCAMXUfGkKpafY88
         +aK1cjCHUXyyC9q/UOgEvAaTW9OSlB9Jqr5/1Gbu+tCRTyjvW1ywYMmvOFeaff1fenRC
         r9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWX19R1+jBbk+jWdyhGOcTkhG6ymFEn9Us/KpSuRY/MPDcatSM1KerrOKn6XOTa3vJpe5ALENBM@vger.kernel.org, AJvYcCX014s1BCrfStjXnnMSsah69MdKbg8qgVt6RTI4TPl6wXL94ZY6y/n7YfiqbF1debyslBtxYJZi1hRIBNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrvGCYDRY3t/fUX3ZJ+aEZ/1mH65r000oAqQPHK3eenZuUhL+
	lyCgMLhcw+OvfnYqUF6pN5xl3xQnOM0jACoQ3YZvaOKL5xTduI0B
X-Gm-Gg: ASbGncv2mAsLsVFhfgaLJhx/2gc2bA5G9kuvVmhkpDnGQUSqpvI0XPsqOCJTjEYk/tu
	nwlFYEHCM6lusv5rIwYp8Y6gIKHQbLPQ7mjJEU6fc+N2zxJoP1Mp3eTphDlpEVVDIyo8W7Nb0wS
	ed7CMHIKSyPQcKPGyLxXOdxIWU1+LWvKIPaJcwJVakU9LbPq6SyImWBPzMHY/kEFaHG/+s9WWM5
	O2Yx042gPTNlbtTc57dfdyT8aojCrlMhRzj1Fb7tKk+Lzcgm4QbNMJaog==
X-Google-Smtp-Source: AGHT+IF0tIfGxR4xSSK7aYKVgCXjjGxJs/CrL7Ts/43gR4yqeZ8CBQo7W+fSBsIeceUleYBPCxNjhA==
X-Received: by 2002:a05:6000:4714:b0:386:3752:b28c with SMTP id ffacd0b85a97d-38a8732bb23mr16193342f8f.41.1736759758185;
        Mon, 13 Jan 2025 01:15:58 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03f8bsm135849445e9.23.2025.01.13.01.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:15:57 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: phy: dp83822: Fix typo "outout" -> "output"
Date: Mon, 13 Jan 2025 09:15:55 +0000
Message-ID: <20250113091555.23594-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a typo in a phydev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/phy/dp83822.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 4262bc31503b..f89e742281d1 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -762,7 +762,7 @@ static int dp83822_of_init_leds(struct phy_device *phydev)
 
 	if (dp83822->led_pin_enable[DP83822_LED_INDEX_COL_GPIO2] &&
 	    dp83822->set_gpio2_clk_out) {
-		phydev_err(phydev, "COL(GPIO2) cannot be used as LED outout, already used as clock output\n");
+		phydev_err(phydev, "COL(GPIO2) cannot be used as LED output, already used as clock output\n");
 		return -EINVAL;
 	}
 
-- 
2.47.1


