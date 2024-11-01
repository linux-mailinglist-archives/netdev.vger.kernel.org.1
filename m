Return-Path: <netdev+bounces-141123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E219B9A65
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57C11C21775
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E40E1E25FB;
	Fri,  1 Nov 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aflBpbOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162681D1310;
	Fri,  1 Nov 2024 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497714; cv=none; b=nomBNZCash940uWqmLXL9Kpj7nlD7j+OKX8Zdy1cCtJJPsKnJGNXuaLOGvIu8YG+CKJzGcdVIv9JwMlnVPE4a/gRGr8vqK43TI1/3s7geEgR/9s7gruVmADPIckBTMCPsrATHJU4L8N6weD9wMblf5Vba6mPszFch/JewIOIclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497714; c=relaxed/simple;
	bh=qOyTTVkBLP1YnGMddEiaBMbtswAaiMCW3SPMIUioFVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coMKRysK/QfixRGsjFXXSkajVJVtkqxp6fWOPpuJFavZtPhwuEBSCdOoqlq4YIobDpJ8lyDXSGDUe8smIacV+LWWpeS/WFztR90vT2K2dNt6MehF/cPO/aoBivjI3lnMjTuOuRxWFL4yTHd/ZXRPae0vsOipeQPUq/AYkGR++vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aflBpbOM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce65c8e13so27222895ad.1;
        Fri, 01 Nov 2024 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730497712; x=1731102512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noE1sbEKFDZrbYOA8JlhyS8ihnBLzSlP3tvD0FZfyKY=;
        b=aflBpbOMRu6LK/0jmWDqnmoNCU/mfCzwAz3ldc4LifvbzcIT5mm7FmzE+28J7uCewu
         E6cJ3ramHRmfHpXEvAdcYarlH28tYXW2Vdow2lCW2zhhflcLmnNZIDZA1xkVegDp/klx
         SAEpLN6Pns2VoIiPi5WXse5hP6aiUivI8tJmhrwHHdAmrK8HwXTj/HhIgxyDKiHlcUG7
         h972b/ZJG7EozElVNsFd6TyrPjRl+0RMCFX2JcdYldQRylvaN7GLlJv242odx2ZqdcSc
         vpwp+rpS1UjMW1pBMs51bsJG6wI62UEeuPNgPpkGJ7y3vOJCIP+4jlnoJ1iIyEnB6kWd
         0B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497712; x=1731102512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noE1sbEKFDZrbYOA8JlhyS8ihnBLzSlP3tvD0FZfyKY=;
        b=njOGgVM3SYwwmOw3xvRuXkuX5AooNE8TTYvLX72PI9hdnhOmWXuhDq8CyFX8hFXOO6
         YROOYIeTP6GctDsuw/QsSnrU19xxf1sTG1zrbtoWAVr9rh+IrJmQXKZgRkJqCQ15IUBp
         VtK1RtxN/lRnwtyaTS7g+53EKfTsQovs91RIxHjxYcSMihWb/XImNi1qpbFOIk0F2gsI
         6E8/x8xH7glkJuy64aNHq18zUkW5CpFnvylBnzWQygHzJZOAHnio95nRrfhS4A3hNtWR
         lKbkvNHl2R+f+EN7ZU2rhA4ktgOQ3hiKHgjydQT04cazAw0wLM6ni/7/xVakADX9JU9Z
         aarw==
X-Forwarded-Encrypted: i=1; AJvYcCXaGeizqo5O0ZOXcoxWe7NjFPnKghdOMWBbw3Xx0VVQ0Oq+HjjV730HcICy9tDhMzNEEqDkBWE9282PFps=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmHeLrBw/8RYuPdJNJNvfiXE6Da8dR3e/lv9BRODuy0gKwLEz
	rudW4PaBSh8fMg958Jcsx6CvT+fTyrGpp56hJNBlhA2T6uHJUdzJ7KPiVHGt
X-Google-Smtp-Source: AGHT+IHISPdujUY/EsUwPX2ickOcfQezhjpp1bzEpRgb5rr5skB7fbE+BO3CHq4s1fkuXfvrAM9uQQ==
X-Received: by 2002:a17:903:2308:b0:20c:ecd8:d0af with SMTP id d9443c01a7336-21103abcb03mr116467865ad.9.1730497712074;
        Fri, 01 Nov 2024 14:48:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057cf273sm25120155ad.239.2024.11.01.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:48:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/2] net: ena: two cleanups
Date: Fri,  1 Nov 2024 14:48:26 -0700
Message-ID: <20241101214828.289752-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify some code.

Rosen Penev (2):
  net: ena: remove devm from ethtool
  net: ena: simplify some pointer addition

 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 31 ++++++++-----------
 1 file changed, 13 insertions(+), 18 deletions(-)

-- 
2.47.0


