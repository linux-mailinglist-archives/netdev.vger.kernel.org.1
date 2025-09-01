Return-Path: <netdev+bounces-218665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92FB3DDA6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260E81883E00
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867203043D6;
	Mon,  1 Sep 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cljPwtmr"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A933043B0;
	Mon,  1 Sep 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717766; cv=none; b=tzmkd8H68Cdef9pA8/2OP+95AyE8A0sFwHcHwI+bMZWAh8goKBUcLo02LZBr5Aa7SqPsUkQE5vjkbivV9cxc/sa8iuzKvpyoYiIJSqqMx/F1ipJLUk3QDUpFcj2Q9lSa3f3xOQfrIcpn+qCVlUO7cYHU17ppvu35QwQwPZC12fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717766; c=relaxed/simple;
	bh=T8ihf112g9u2f1A9yPNf17Zec+yVLlF4arukt8xeoQs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=rtdTKIjep/1TyDtlOeLbTDleVUgyKjHGT77hLwjnHnYkAFjYEGNQf7gztt83y228Gy0WrSD0j83ChMALcW2B/GgbUv9EnEOTn52MWtx2IMhm72Nw8YB//AqfJM/Sn5S/I5lsaAg2MoUmJza4L134laH5+fDmtEqWXphXlzURDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cljPwtmr; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756717455;
	bh=yaTeFtLRO5tvXwPuK3rKpMfJKgvbP8eLKfJv8XhYE/E=;
	h=From:To:Cc:Subject:Date;
	b=cljPwtmrAkZeg8IkGCVBuGqJPAgyLgrV6xteO5Jd2rdpEwZVwqjx4d/rOQ/7UJ+fm
	 dU4lDMh/0QHzqKGIPDMG9r88STauudtDsjU5p5n+YgEqd+UyzipY/Hkc3fz3WQ28Mv
	 eTcNagklQwIxyt1dAKuz5OZgLBKnqRAdVw2Z+Upw=
Received: from localhost.localdomain ([112.94.77.11])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 10D1883F; Mon, 01 Sep 2025 17:04:13 +0800
X-QQ-mid: xmsmtpt1756717453t5ocrcnwm
Message-ID: <tencent_64909A540A8CD9063D28DEFD0A684AF9B709@qq.com>
X-QQ-XMAILINFO: NRYSeI3Ux+UPKBqenge/iM5apnt4JgNSf6hICTmL6hwIFOvHFwQt6jEpO5mfZ7
	 ff7W+zARH/K2ohCTAQtNOZ9K/+dzervwNbcHVb7ZOPLd7PFftSOx24rKqtKjN+SI/46ipWyJp+mf
	 N3Vw6kZdPI4mUdaLfxCn+zYw1OSGkXo3qA/OwlYGCwxG91UYkF3Cy1JKiXIKAyo20QP36SsvL0ed
	 tQFXw+789q+0a+vxtOOjcO6tatqpp0YuagsZ8T32dJvGzouFltZSPd2V3hpo0+F9s4ltPnnkbJ/n
	 aXqtwu6CUGo8ihauxjnGFUKOePrn0m008hP4OBzwYE6/ZCb+d4RiuwfLymeh7VllGN1tGTCIA+Fb
	 bIvDpbgBCz2zZdxUZh3IO0gxHZGK9wssu6IfrSi/NC6ocMWQkqI3oAHnEjwwnAB/pWr/vCQbYKTw
	 4l8FPj2hLZ/TJU8jaNnfWyiyt9PGFwZOYiGbuZoI+CbqC8gTSFodeRYfl5jmRcv2JX/BjNDXCtpN
	 UwBeMQqqVwn8IXoFrkFZFWBlozXZt0cEkaB6axoiIAA/5Q1FD4mJJvugXIaT7EJjP+SvF/yq32FS
	 LeocQal7ou8z3QjpOcPDH4OXXRNmJr7d42lY3tl1sC+b+Dy7WKdekCzJ0It5GumRrocnY4XEytUe
	 ux78PRYagET3mDYgss9ymWWPySrgAAQJy4U26Q5NEJLvxAfwCr4omlw3m+5hsez52WvPj6KpRBan
	 3quRgn7OWzmeMGfxM0hcpX5i75UBVnGquZfJP/TQQ5fcAswl0X4ioJj6cGPADKxMu39Q8Q5DulYE
	 rOa7nDnNzIcF0qYoxlJRs/zSd3DsxjQhvEgwE5zbE2+YqF/TCM5J06JlKgrzDQ1ULxkewBgMXQSn
	 LRqY5L7U+FK+w6pFRr83xq+rDeKAgaQJV+txukzFb1nEzRnU8hvFEgK8Wpzp0mMjUHV0nDa+XtcT
	 5ehyRPrRKcKkW14IUAaGrNdTGrZOAPY6NsT2JaevrDdeiH5NrQ/3tIA5Yzz9O9zu8923LMv+h8PR
	 ktlx0pYv/6fKaJI8SqHQ7rc1dXt6w=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Conley Lee <conleylee@foxmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	wens@csie.org,
	mripard@kernel.org
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Conley Lee <conleylee@foxmail.com>
Subject: [PATCH] arm: dts: sun4i-emac enable dma rx in sun4i
Date: Mon,  1 Sep 2025 17:04:03 +0800
X-OQ-MSGID: <20250901090403.533184-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current sun4i-emac driver supports receiving data packets using DMA,
but this feature is not enabled in the device tree (dts) configuration.
This patch enables the DMA receive option in the dts file.

Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 arch/arm/boot/dts/allwinner/sun4i-a10.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi b/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi
index 51a6464aa..b20ef5841 100644
--- a/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi
@@ -317,6 +317,8 @@ emac: ethernet@1c0b000 {
 			allwinner,sram = <&emac_sram 1>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&emac_pins>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 7>;
+			dma-names = "rx";
 			status = "disabled";
 		};
 
-- 
2.25.1



