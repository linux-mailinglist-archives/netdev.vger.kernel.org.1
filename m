Return-Path: <netdev+bounces-140105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5249B539B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A281C22609
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9F20F5DF;
	Tue, 29 Oct 2024 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFoE8Oe7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358020F5A3;
	Tue, 29 Oct 2024 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233474; cv=none; b=dluj44sAQff5XB8vOSTwnqhFMs3l9Yq+QNWp13Ug0TDzS1w/tPxDn7I7wqZw9TlZbSK/Jgz1WT0+21pIa60vsYsMghlggIqHEFzb48D5hNLUIkaHGvIHMy3X1QlBqyWyyHW663o1K+Cv7AnRxMdqKJxl5Havd1hfKfWigObwc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233474; c=relaxed/simple;
	bh=DdCIz4sO4xaU11QPXc5LxhfllptvqGZDP+fVv4ydW4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcqGOWSZ2sFXr/dP01c5ANLM8p8mpD73p2l47TIoM+EVfYOyM3ddW4jZdQ1xIi6WD6OT6B3m63uWq90K45qZgUo4urgWn+DOMj7HDx3uUvQplQU6NNos69YM5HuqeqoG3jJyzP9/lxaJ06VwyS7GSlEeH4wBcPS0U1STuKfULCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFoE8Oe7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43159555f29so4871805e9.3;
        Tue, 29 Oct 2024 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233470; x=1730838270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/XbmEWC0pF4C6y9sizpz5a4/Nkx6ZhAqpplNpnUb20=;
        b=hFoE8Oe7Pr203I30cxs4ACSVWzikVgRlNlFrCYnpuX+d4ZegPA+FMV6n6NngCYyNL9
         +12wewZBzqHSDlQwwMCEb3y2XIrdDk/kRlvJBauHOJJ0/qnWXtUR4bW8pZbd0/LFq3DJ
         uyFW0G2FGOzWs4i6MFA1qUcnl8xjGYjLfF/1/XYuiqPaPEnoQvsirREXYCaiL7kIbhs3
         Nkv2VF75pnpqTeZDQerXX2rmX4M616RUMXvD4rqJV+8fDVMEwzo0Fa9xD+qkq7aVMyoN
         AKFv4v3NTGA51lAbHaPTDG/PO49JBJRBEBW7lzHw7B/S5obfVzlOe3ctVrJnjRV0HvXt
         AXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233470; x=1730838270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/XbmEWC0pF4C6y9sizpz5a4/Nkx6ZhAqpplNpnUb20=;
        b=AQmUWJ50qoXV+fzvKPpOoHBaGGcM8AI80q29fS+bgXonr4vRv7I1FFWf31+Gl5d0CA
         WXqCdMZYSHFz237TRVYsvCCsvTeBSEaRmCYWeGycAdIbE++6LU3ZLS+la8/17f7PKgsJ
         aE6791CB17KaHoKTFxMwBSRaZZd/TpDgIdMphNXNIp/el+fGwZN+04aVVa0qtEP1IKkI
         pSNCxtgzLiGIvtVJdpSc0z7McAh09ig5VtfbVjGXlAQsXmF7nDHcB7Y3pT30Pzaiiykc
         6UFyyPNn7c2jng5nK2lAEUGyC3NGDK7NJwmH36QrUr/kUz+W99KFy1LuHXC+tA0U/l+c
         AODg==
X-Forwarded-Encrypted: i=1; AJvYcCVOWgyVRz2I5qqNz/MWBOe2f32yXjr/8Ea6KSCefhlogwvlCZsb0r0tknnAP/VAuaf9GgdPZIH76AjaG+uN@vger.kernel.org, AJvYcCWNLOU0L/dj98BMpr9x+JB0bO+X9lFu6uHroOkoZBbOZ9PbS55hlZzu0z8y/ye3X0mqKNZ7a1rpyIaU@vger.kernel.org, AJvYcCX8QWqjeBQND+/5u25/AMN/F7H4eF18N4I6Mdqg7xGLZFvufygPRMFb8RQYnkVyQ1Emqz3ycZsX@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQbCdDKv1wcuvBIEWZlg5AywjoqpmKczHKbSGD9yNLHddTZ+R
	XBHEuRYXNki0zjKE2daNd2ndCG7mt+3TRfdWndiyyPb2q3owGcx/
X-Google-Smtp-Source: AGHT+IFeavUh9Ar+9ynVIaIAr6yW4KMEe1TsLPjWkPYnSTeBsy+x87ewnsyJPz2/5d7A+QJihIa3VA==
X-Received: by 2002:a05:600c:35d5:b0:42c:aeee:80b with SMTP id 5b1f17b1804b1-4319ad748cfmr49058445e9.8.1730233470329;
        Tue, 29 Oct 2024 13:24:30 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:29 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 22/23] dt-bindings: altera: removal of generic PE1 dts
Date: Tue, 29 Oct 2024 20:23:48 +0000
Message-Id: <20241029202349.69442-23-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029202349.69442-1-l.rubusch@gmail.com>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.

The removed Mercury+ AA1 on PE1 carrier board is just a particular
setup case, which is actually replaced by the set of generic Mercury+
AA1 combinations patch.

In other words a combination of a Mercury+ AA1 on a PE1 base board,
with boot mode SD card is already covered by the generic AA1
combinations. There is no further reason to keep this particular case
now in a redundantly. Thus the redundant DT setup is removed.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 51f10ff8e..1561f0164 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -31,7 +31,6 @@ properties:
       - description: Mercury+ AA1 boards
         items:
           - enum:
-              - enclustra,mercury-pe1
               - enclustra,mercury-aa1-pe1
               - enclustra,mercury-aa1-pe3
               - enclustra,mercury-aa1-st1
-- 
2.25.1


