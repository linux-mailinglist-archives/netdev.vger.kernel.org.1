Return-Path: <netdev+bounces-172374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88AA546C5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A46E188F87B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68820ADD1;
	Thu,  6 Mar 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsQQSsES"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29918DB3F
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254416; cv=none; b=S/0iJzzqSfg3CflOlT7MZcY2UpeTQ5ubuKeESCnhaESaYLNPoS5xi3Dfg7ppcWZeAR+cnnOYGML8+4foC8ZDBUyZyatWZtC+UHTTSZKi5E+N8UuCYTsuTI9QaebrKY58lhLPMiqfB98iC/+G9qBd6X+KthZhMv9b1DzAXLVi+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254416; c=relaxed/simple;
	bh=g8ftAWsannBKjScJBkCA+ah2c8W+V8QRLBe3IcWo8/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8NKsim+doyEBfR0dalUFqrWGtvwqJdeoM9rJJSXn/OHgHJHo1jCJ6BaxMcxsujCrZv/KcKX3O4QcTXhTdHN1jJtDFuEL2Eseqr8rfCW+fU7pLSUsh7SV5lAQ4TaKyn2uXMfYqyuKPWm+8E6fcNsARiYOUN9IiES2EVqIMYCaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsQQSsES; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741254413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uubAh/lYg724YkjeIYAscgJbLGgC562xtf2/CZEmAQA=;
	b=XsQQSsESIq4PGrW1/fBUtp3oDyvOQNwV06C/4EUQYB4jOabjZRwlHFGVLi1AADSNVO83Wi
	akD4xTpQCNFVu3ciu/Lnd7kNUXrepxVmTYiD2X4VZbIg5/ZJXogsKcXVTYOTM0FRuBmg37
	8tyoy8U79VHfjqiYomxEMN+Epo/eh08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-hLr9eb_oNcGX36i0dJTnGQ-1; Thu, 06 Mar 2025 04:46:42 -0500
X-MC-Unique: hLr9eb_oNcGX36i0dJTnGQ-1
X-Mimecast-MFC-AGG-ID: hLr9eb_oNcGX36i0dJTnGQ_1741254401
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393e89e910so1955305e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 01:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254401; x=1741859201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uubAh/lYg724YkjeIYAscgJbLGgC562xtf2/CZEmAQA=;
        b=ZpUJbNpspoN0IhK13NqW6gd0AreER3ZuBo9yVhLtkoyc7D7SEfOkFb3dca3mDyF8T8
         yPYWZEhRhoSIko69Go7hPD7cvD5OP31Fp7x7fdnl43HddbgrdTnuuR8ag5de4qMqw0gj
         5ljfFNvbUodfm/anbSzBk3Tjbzh19lRX0prFA/OBBWuaYyBSeqY+cuoi7DfBAoGLVxYc
         r3O5kq3qhtaRhhomLIiXSVdMKY28jdI4tVvVW4vup4UItS+qJ+q2PhR1eu8/hFjD3yq8
         UnoOthPS3CK1jVIhOv3FVvWqmXCtPa9jRGm02Yaq32FyQrYRXoGhuvLoTRg9NF0sdIVU
         71KA==
X-Forwarded-Encrypted: i=1; AJvYcCUBvhqifpmAeVsV7yUXI4+ZxoTpyJv4P8pkeP5sbjJLd+4TlUzKqoolzqw6/Bqf4d53S0rDl8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9zGX67tpIpddc6QOZx4l1Gmscthr1JGmZwZSYCwAgYwUBXo4
	5rp1tCB311AxDyXy7CESZ36E26MNMkJ1cQwl1OI/DtABRHnXHMJireuJH7U0aRkB24xr3w1BtY2
	qkuO+wBekPi6A7A0LvA82gymadypgsNi+RuRYkP2S2orzNqTOXu7YdA==
X-Gm-Gg: ASbGncv9ExCa92LUcukB3X9KDIMV+3W3ZAFpdLSUouj3PYlSNkP7M8Akr8HKHZbvNws
	z/PayMemY4Famn1a4v6vzAd/XSHv1/C+Nx31PD7N+hYXCnccOJfUqAVBAoXV4XNJ9aQo9vQGulA
	CY9tuy1WpJMpvQg7OMB3rvPnNqQUP+daZhalZrTX7cfPXKjkiph1uQ9x5AUtuFMDA/pbDfcSZND
	Be16gfaorQXnp0WSY0w3AmO98dTvyOQTz/F/wcrLlNjvCGMk0n78ahlV4RSlbbID/4XAYliy6+g
	VTLeCvZnb2ErJajDSfFY4HzFItz49jyG8XD8OSp2g7kuctCq9qnq/OsXd0i9L0I=
X-Received: by 2002:a05:600c:45c6:b0:43b:c034:57b1 with SMTP id 5b1f17b1804b1-43bd2aed7a7mr43322545e9.20.1741254401105;
        Thu, 06 Mar 2025 01:46:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+0OwxS2kvbXPrOgsrLOM5Fgn/db/xRV171b/5GndlWVz9gP9UTft3oKMWDFA44upmCZSkgg==
X-Received: by 2002:a05:600c:45c6:b0:43b:c034:57b1 with SMTP id 5b1f17b1804b1-43bd2aed7a7mr43322305e9.20.1741254400704;
        Thu, 06 Mar 2025 01:46:40 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4293250sm44159625e9.16.2025.03.06.01.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:46:40 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust entry in AIROHA ETHERNET DRIVER
Date: Thu,  6 Mar 2025 10:46:36 +0100
Message-ID: <20250306094636.63709-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated
folder") moves the driver to drivers/net/ethernet/airoha/, but misses to
adjust the AIROHA ETHERNET DRIVER section in MAINTAINERS. Hence,
./scripts/get_maintainer.pl --self-test=patterns complains about a broken
reference.

Adjust the file entry to the dedicated folder for this driver.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37fedd2a0813..f9d3ff8b4ddb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,7 +726,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
-F:	drivers/net/ethernet/mediatek/airoha_eth.c
+F:	drivers/net/ethernet/airoha/
 
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
-- 
2.48.1


