Return-Path: <netdev+bounces-239982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 037B8C6EAF1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9DDD3A454C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E133F368;
	Wed, 19 Nov 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="DEdkcZEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155C2F6929
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557060; cv=none; b=dE9FwIY551/j6M5ksMyd9QLbiGKph79tV0XLIZhjInZ+e21ockTH9OdMAXORetu4RLTLMkWCI+IS9xJ3Aj++AquDQZEqx96N/FgumORob1S+tGjng72si5nZ7Qqh2u4waUOE1zVtFBo0PEvfMklrkwGPx2GlN554nvHd9lhXjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557060; c=relaxed/simple;
	bh=jbyO2iXTJWKsPH084GotjCd1zsUwDuhyqpR9YD38bG4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Q6nTj4BUaIWetywvo8tdLrk8DshAQ3AvlRJMVtM64miREk8zBxn8ga2iO2yjLl4TDbYXnWWzU+WMewqagrnGWxLpdFl9FsyB2sk3dKN3VwYmcCpdnv3ODnRQoayxtz2/2JRUjN3LVl0EsP7ciwSFA3KzFuY2QrDo+hl05Pq2aIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=DEdkcZEB; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 864B21483ED3
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1763556462; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=bFhm/WttfaQ80Th2gK8NctIigdXN0YWmNPFU81xWTsU=;
	b=DEdkcZEBmV1pulLvtqZbnDnzIUKK5GPLxcnOyan56lyMvTwOIMHp/EejbK4hKZANj5BSx2
	L3ys+QPCj/lRrELRbCXl2LI/dQzxOoxXMnGHMYKRlPjSZwRJJu4FSkLubZVCtuHxIF41VB
	+rjwBqN4jbuck2Zf+6DU+y3SSq+Q31dii5M0a/bMO98lOOWMp5Y9wRxD6emSev4OEBNHKf
	mNqlD8EvAnCsViVbob7VfgRwxmt/kqqONPwCLX5wuj0iKPEewP0gZDBKh7EkChVMvnPBaR
	ZPYPN/yur4F2tbTDQugVPbpPihbAUEeeg2zhLGsuMuFIxYYLsVltPDS4S1Yb4A==
From: Alexander Dahl <ada@thorsis.com>
To: netdev@vger.kernel.org
Subject: [PATCH 0/2] net: phy: adin1100: Fix powerdown mode setting
Date: Wed, 19 Nov 2025 13:47:35 +0100
Message-Id: <20251119124737.280939-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

while building a new device around the ADIN1100 I noticed some errors in
kernel log when calling `ifdown` on the ethernet device.  Series has a
straight forward fix and an obvious follow-up code simplification.

Greets
Alex

Alexander Dahl (2):
  net: phy: adin1100: Fix software power-down ready condition
  net: phy: adin1100: Simplify register value passing

 drivers/net/phy/adin1100.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)


base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c
-- 
2.39.5


