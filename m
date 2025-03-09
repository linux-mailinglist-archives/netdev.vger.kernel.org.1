Return-Path: <netdev+bounces-173237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F41A58197
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EEB3AE8B4
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74F217A5BD;
	Sun,  9 Mar 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lVK7/nlj"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175924C70;
	Sun,  9 Mar 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741508410; cv=none; b=tPGYEeJT5BeqNtIqBq+N9a8gqSzlSlwugdRDeaFEAQufFkwBfKY39tovILq4J6qArwwORPFb17eJQsmnBJFygpN98YaB2rkaaScaOav/yAIBL9ZAKd2XesHqqmhivAkJvT3fViDIG9LJ5Em1J3/+DxkeOGt82u94eCyxuwOXzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741508410; c=relaxed/simple;
	bh=YJd7K01Y9oAxYGKugOPKABLM5bgZH6skQOHXLa+naD0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=SNn4o1j0xqyDfe7kx2hCT/fWvqY8DN99f5WOzDMvNb9xlvoVjLdQsJs8Zt5tdEsiXjFCL16C/9cY94/3Isl1XroFZa0CXKpsLODyEBvIKmNSSobauzwWxs4Z4CZXPMaF5QsLJSo3Rt0CyxqA+405OC9VjUSr2RjvnJ3+qrrQz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lVK7/nlj; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741508397; bh=4QtA+Ouj6OoRKOCD+7cWv7slbqgJtrFMVALehC4qc0U=;
	h=From:To:Cc:Subject:Date;
	b=lVK7/nljBjPbarDAcbzMMtJbDFS11KDsPdCszCjqVdQqxVTxGODLmsFJHE2NIz8Hc
	 dV83rFxmyyC5J16tfqQtcjU8hwZVnQuQiztwY1FJsJf2n3ji9y9Lq206wzMs/jsIxe
	 RgYWUTB5/isKAH6AaN87KKkRBMjPuLIaivbb496s=
Received: from localhost.localdomain ([59.66.26.122])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id C36296A9; Sun, 09 Mar 2025 15:48:54 +0800
X-QQ-mid: xmsmtpt1741506534t5qburu87
Message-ID: <tencent_8031D017AFE5E266C43F62C916C709009E06@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznEc2CaSvmAf4Ta9dC0ocsEd5uActWCQeQAhzP/KMe3RJHaaYeW3
	 yDZE3VQKEcoEB5K5rnqLVlXRGT3m0sfkN7nRHxj1cUiVqB83PftxbfHlioAZzEyRXESJtVaCuVMK
	 CCQOyJX7tfbP29TXafJh2e0ct6OPDCiNZp3il7sBRPC57Uq+CIgbD1ZVs1xHPdK7p7umipefS9ul
	 DugW5NTlBob7n4I3I3+7xzoSsl+bBFcAkIIDHoVCua1nf+GzLZgmqcoTX4vVHtZuDNlLFIX1+NRV
	 m1E6JA0zCzT/nGF71Xo0/m43JznAiTJWv7xytCqTbYofAUzPTsg5CLgO90Gu1f6kgDYjsXhhzWsW
	 aLz7t61Ug3Ho1WjAczlYwQ4fwD4DLy7iGc1JJaoPyy6bhRmtxheqUFv637O/rXqc6Vz3M5Ldgwpw
	 6hbJLyaVqBWhZ4jHoXcFYAJ6awOaQcmXbEkvQVnEBs2rwEAiup3QITUgCk/kDywBIkCY1yaQgpOJ
	 d8vM0Q1BjLhaj2jKydm2j1haAO9aWCBs+hP3lljgJwM/uPUe4Z23fr5vK9lEUWLAPnq6EujjSdch
	 uXG5ChCAe1uX1u1JHFm9RKDXHUZW80a742RHW6cEkcJsMq6ldNX/3jjyJzeFN7PE/8UePF0ocSXt
	 YdkkoYMdmBlzb99nQKozcz5h/NTOisMQ6v6CANl1Dmvkq5Uz5FkEy9J+CHHQWhbZNencRH2c0zIn
	 AnY8PSb05Czt5dDXVpl4Kqp9jE0RD0mYF5xUtBEs4kSYNV3aWpBtP+qfu577t+h0O6KNGKXR3dHV
	 D8DbMiVM/+Mld5OuNC995Xy96mmsuzDZgLfE8IwOHIob8vAcy6uPKlhiSahsSo6Ab/zRs50N2awb
	 XSL+hsLnPKYVS6XMD94CGURh7Lt5oMtqfoJNULkXmYMKuWn+4f0b682dZsap9Mhj98Pb5bCbyR4O
	 JRh2Pf1N6Sc7GDeb4DcI7AP7flODfIbtOr+T1HGLvwkNO9CxOhWrFElTbANZ31cL5W3c1VvgHy06
	 l25E2kATZzV+WQXbLI7350ab0Lklc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH 2/2] dt-bindings: net: add enc28j60's irq-gpios node description and binding example
Date: Sun,  9 Mar 2025 15:48:38 +0800
X-OQ-MSGID: <20250309074838.128110-1-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows the kernel to automatically requests the pin, configures
it as an input, and converts it to an IRQ number, according to a GPIO
phandle specified in device tree. This simplifies the process by
eliminating the need to manually define pinctrl and interrupt nodes.
Additionally, it is necessary for platforms that do not support pin
configuration and properties via the device tree.

Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
 .../bindings/net/microchip,enc28j60.txt       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,enc28j60.txt b/Documentation/devicetree/bindings/net/microchip,enc28j60.txt
index a8275921a896..e6423635e55b 100644
--- a/Documentation/devicetree/bindings/net/microchip,enc28j60.txt
+++ b/Documentation/devicetree/bindings/net/microchip,enc28j60.txt
@@ -8,6 +8,8 @@ the SPI master node.
 Required properties:
 - compatible: Should be "microchip,enc28j60"
 - reg: Specify the SPI chip select the ENC28J60 is wired to
+
+Required interrupt properties with pin control subsystem:
 - interrupts: Specify the interrupt index within the interrupt controller (referred
               to above in interrupt-parent) and interrupt type. The ENC28J60 natively
               generates falling edge interrupts, however, additional board logic
@@ -17,6 +19,14 @@ Required properties:
              see also generic and your platform specific pinctrl binding
              documentation.
 
+Required interrupt properties with a single GPIO phandle:
+- irq-gpios: Specify the GPIO pin used as the interrupt line. When this property is
+             set, the kernel automatically requests the pin, configures it as an input,
+             and converts it to an IRQ number. This simplifies the process by
+             eliminating the need to manually define pinctrl and interrupt nodes.
+             Additionally, it is necessary for platforms that do not support pin
+             configuration and properties via the device tree.
+
 Optional properties:
 - spi-max-frequency: Maximum frequency of the SPI bus when accessing the ENC28J60.
   According to the ENC28J80 datasheet, the chip allows a maximum of 20 MHz, however,
@@ -54,3 +64,17 @@ Example (for NXP i.MX28 with pin control stuff for GPIO irq):
                         fsl,pull-up = <MXS_PULL_DISABLE>;
                 };
         };
+
+Example (if can not configure pin properties via the device tree):
+
+        &spi2 {
+                status = "okay";
+                cs-gpios = <&porta 23 GPIO_ACTIVE_LOW>;
+
+                enc28j60: ethernet@1 {
+                        compatible = "microchip,enc28j60";
+                        reg = <0>;
+                        spi-max-frequency = <12000000>;
+                        irq-gpios = <&porta 24 GPIO_ACTIVE_HIGH>;
+                };
+        };
-- 
2.43.0


