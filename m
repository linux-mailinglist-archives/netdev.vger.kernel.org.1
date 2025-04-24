Return-Path: <netdev+bounces-185368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38922A99EAB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316444465D8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A191A8F9A;
	Thu, 24 Apr 2025 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/inCZS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9611A840A
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460739; cv=none; b=tLcutc9K+nNb5IZWUqxNLYLeOPG03n2KnJbBmE7x1z/JP/pyz/YB4yG/gnaDMesDs4j678ThxWs7wwww1XXtYlkOlZqZ7hiEBuHQNuUoDW8mwxqvMFA98gWVNCu/EDzNsFK2llKc6EhavMghYPanSM6O96fMV8yWMh6y5GYM2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460739; c=relaxed/simple;
	bh=CYtiYSk2IXPrszL0ZSPa9Lag0nzRYRH8B+kksn5Iuss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih2swoaMFwNG8yy0ZzjsSp0gY9gl/yYcvtbSCGGiyX6k/huDQjb4N8M3XuBp8TiKoe/fCoxsqFZNZm6rOrqtVTm30kmnM0LG5xYMb3+L8sFny6aEqKHsY/pxueL7I1N+Q1Kp2WSdkT9rZA8xFwf28TV+Z0xzJjbIeev/IUTtNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/inCZS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBABC4CEEF;
	Thu, 24 Apr 2025 02:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460738;
	bh=CYtiYSk2IXPrszL0ZSPa9Lag0nzRYRH8B+kksn5Iuss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/inCZS78MfurtMfDGEEtV+NHVV/O+PJbnkDjVhQ+xcuOkHJ45CvRyD2LwE8sqZPa
	 KuiydGIq9H3buQLYmP2zfoUBf2D6Q3VPEV7FAhj7DKCtXEdklHtwSW+PcLczuP6td9
	 vLvNf288fBgH/jIcuTyXI0wzQM0FK5Trq3JHQmNqxWDa48exPxvyNj+yL9JNQ88yn1
	 TrtWyuLwl2pYoxGvvZaGhbkHTbFAtdFr5fD7JfrRvDvLWMtYH0ra4MyAPVZy23MbmF
	 LiqfmBaa7o+8QpDqKVUyeeEXcFBXBpn3r1JUb2OnJ5EzF1ZZy1iZg1HW6TAy3VT8U1
	 6Mpy6UWczJUlA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/12] tools: ynl-gen: support using dump types for ntf
Date: Wed, 23 Apr 2025 19:12:00 -0700
Message-ID: <20250424021207.1167791-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424021207.1167791-1-kuba@kernel.org>
References: <20250424021207.1167791-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Classic Netlink has GET callbacks with no doit support, just dumps.
Support using their responses in notifications. If notification points
at a type which only has a dump - use the dump's type.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 35a7e3ba0725..2999a2953595 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1283,7 +1283,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         self.struct = dict()
         if op_mode == 'notify':
-            op_mode = 'do'
+            op_mode = 'do' if 'do' in op else 'dump'
         for op_dir in ['request', 'reply']:
             if op:
                 type_list = []
-- 
2.49.0


