Return-Path: <netdev+bounces-130446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B6198A8D3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4EE281688
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4AF1922F8;
	Mon, 30 Sep 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VCkay0Ig"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C21922DA
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710817; cv=none; b=i3q+vJl8t1YEdYup4G/xWZHi+6fdO9j0Ke30/Z/GBlwL/Rf44F8ZoTiM7qp8qrUCwSBGJWKjE6C607jjYFt2Ke++Z0Is3iIMKJcDxFcawQLszcb3UyTm1ZFKxb5+6wgGURgbU2bA1h1Bcojk/6+MsFYEazN7owTm62sKdMQqElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710817; c=relaxed/simple;
	bh=2ayb/aRy9s7UAywgsgl5kMfQtRv+G4n8lNByX7Z98og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AcWmdy/Glmq5wKBzpmow8KWebBbctVLKRyZmsxmcW3bir+SBe/dLlU3KB8xAHzhf2uLUAablU3WYEcCiSqV8WLJC/gRcInPEJSp3oKrWTYka1CsZYeYdfu2XjLs+SekLShBvuokJE8o2Id3fUOd/l3qCl19h5OusLVTk2UN1wmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VCkay0Ig; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727710813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b8c6Yzc2x/r/1MD6EJdj0wxYaOvsWglAbfqX6bif82g=;
	b=VCkay0Ig/C9lBrfjiXuIWC/ZuoPlsZhBjc4fY1ELvuhxAKhtzzENkVMXuoaVDFnLguoR4w
	El91CaWKeu7Gj66Wuls0WSM/Pod5p3o3grb9ruf1WsrUJI/9nA+RPQeqP2JcmPoNBXfOjl
	i93XFZI9rXpSjSn/kuR7uPwFTW3b+VE=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Brett Creeley <bcreeley@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] doc: net: napi: Update documentation for napi_schedule_irqoff
Date: Mon, 30 Sep 2024 11:39:54 -0400
Message-Id: <20240930153955.971657-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since commit 8380c81d5c4f ("net: Treat __napi_schedule_irqoff() as
__napi_schedule() on PREEMPT_RT"), napi_schedule_irqoff will do the
right thing if IRQs are threaded. Therefore, there is no need to use
IRQF_NO_THREAD.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
https://lore.kernel.org/netdev/20240913150954.2287196-1-sean.anderson@linux.dev/

 Documentation/networking/napi.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 7bf7b95c4f7a..dfa5d549be9c 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -144,9 +144,8 @@ IRQ should only be unmasked after a successful call to napi_complete_done():
 
 napi_schedule_irqoff() is a variant of napi_schedule() which takes advantage
 of guarantees given by being invoked in IRQ context (no need to
-mask interrupts). Note that PREEMPT_RT forces all interrupts
-to be threaded so the interrupt may need to be marked ``IRQF_NO_THREAD``
-to avoid issues on real-time kernel configurations.
+mask interrupts). napi_schedule_irqoff() will fall back to napi_schedule() if
+IRQs are threaded (such as if ``PREEMPT_RT`` is enabled).
 
 Instance to queue mapping
 -------------------------
-- 
2.35.1.1320.gc452695387.dirty


