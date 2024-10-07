Return-Path: <netdev+bounces-132635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FAF99296C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD55284B07
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC231C8FD4;
	Mon,  7 Oct 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="O/cDgp7u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1014AD17
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297816; cv=none; b=VcFAD9z30yPDjkr36XprthgMoUOoa+itCuLEXTduSQEilW/Bwbbrh2YbsLRes8WHuRy9XCn3QTl9tZbI4jy0oCamvkgGZtPOVYsojfyLRjl2BGjMg9BWY0Fn6iS8tq3NgfJXn4kK2TYV83XhMynv6x6dauOIU916JNp6Gk+k1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297816; c=relaxed/simple;
	bh=4PJdfMOsoiQIxOcVyX2yXraFbf+GFNeslySxiYmbCEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBZpMZI4vIBpw5mCzDuhbF5CgvwigFGWaFVIvKoaMm/Urv46Nj5qIeMrzGdnjQimhq393zwXGuNyvfH5ESuNYPX83xhLBzM4Dm/emFknoEBOfbT4zho2XuwITIBxuHm/27bAd8XYPTp5gmQIIaW7uf9jdz+IQIugyjNtPGK7Jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=O/cDgp7u; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e050190ddso489202b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1728297813; x=1728902613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIy7AM5G0ME2Cnj3aHq8w9by0s62tKH1e994YTOxWyE=;
        b=O/cDgp7ugFdfNY2zatHhotrSw1WWuJvf1P9JTInUOh8loF6t4heyRboXMfISMqVrcc
         Zf7qxWjWO2YMwyI7dxfVJU2kBMBTvNWfKif3SbPHEPQ+mrhLnZNjZrk6yvLiLJqnZPz+
         xnga/soCNMtDPyDeKY5QcOKX+2TMjR7mNQBX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728297813; x=1728902613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIy7AM5G0ME2Cnj3aHq8w9by0s62tKH1e994YTOxWyE=;
        b=fZW2Kqc3G/iKnZNuFRFUh0Staj2scBtiE9UvtpTcMICnxEAxBxD/Id7zGAeWEXEWIM
         7QL+m4RxgGIzbnVuakpxFVzVdtB29RrY4PGLw4RmRUvhuFuhIMeWFUPkphXST+R8sIn4
         YgJ4hCYQEJw7K1B1qUd8WBQ88gynYIIC1DaJnXmj50jPNHxRv1uXdziQTuBCJXuv5YdK
         XIxO4yKq7GPbltxVt2K49u8IEwRNoXrMmcjU3k77U7qZD8knwkpf7N0jnWaoyJo8Gbft
         b3WDX+MTokunasCjYNfMSr1YtwV3vjxN+ggUvtHVKYDieLxjSzEdfcyO9+T13VUEFiyu
         3gOw==
X-Gm-Message-State: AOJu0YwqONVnwNMXnGLFV4RtJbAJBEdrxNjhKuXXsgDw0FciDcwqyE2U
	k78VGUo0tCPoVn+zleR+Cd6JGj6DQJx37SgfFSE60eQD0SV6uv+1QR+tYd+Vgl/+B3HZwbAjAIy
	9BYk=
X-Google-Smtp-Source: AGHT+IGl83CjUr7USNXqEfJMYi+ASfj5ibmjtXq/p6gptuuYtJ6UknsioxF3cEPrQL2fCgFkgXX2XA==
X-Received: by 2002:a05:6a21:920d:b0:1d3:5208:1ea6 with SMTP id adf61e73a8af0-1d6dfaef24fmr19208689637.45.1728297812919;
        Mon, 07 Oct 2024 03:43:32 -0700 (PDT)
Received: from shiro.work.home.arpa ([2400:4162:2428:2ffe:3699:ffc0:b2a2:f7a3])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0d6521asm4105132b3a.166.2024.10.07.03.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:43:32 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] net: amd: mvme147: Fix probe banner message
Date: Mon,  7 Oct 2024 19:43:17 +0900
Message-ID: <20241007104317.3064428-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently this driver prints this line with what looks like
a rogue format specifier when the device is probed:
[    2.840000] eth%d: MVME147 at 0xfffe1800, irq 12, Hardware Address xx:xx:xx:xx:xx:xx

Change the printk() for netdev_info() and move it after the
registration has completed so it prints out the name of the
interface properly.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/net/ethernet/amd/mvme147.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index c156566c0906..f19b04b92fa9 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -105,10 +105,6 @@ static struct net_device * __init mvme147lance_probe(void)
 	macaddr[3] = address&0xff;
 	eth_hw_addr_set(dev, macaddr);
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -138,6 +134,9 @@ static struct net_device * __init mvme147lance_probe(void)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
-- 
2.43.0


