Return-Path: <netdev+bounces-111834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468579335CD
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 05:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8001F241FC
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555E14685;
	Wed, 17 Jul 2024 03:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ayaya.dev header.i=@ayaya.dev header.b="l/zypqJX"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFA566A
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721187979; cv=none; b=MG5CWaJaXnR21ogeaWRnf7jHu0IquGM5tQzXGc4vZ6coZRs/QyBLnreAfL48xhzf51t/dxQ/Lz1icLmZWOfv2aNP5mfRSFJWvgbTlcBLlSs72984bD6bR6cksV6jSzJeIQ4lfNqdZ8/rk4J8QvJDd1te0PS+embc/3RqkQ5kUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721187979; c=relaxed/simple;
	bh=bST+xxFcijOrBD69lZmfNCbRSgagZWWhRdwmajXKqCQ=;
	h=Message-Id:To:From:Date:Subject; b=u1/Y0lSdUk14LLzy3hrzZK6y9+VeKnh4DYAgwaloM8Kl1w1nCqQeQ+qiC6n6DljsfVFUSPBNpI4c/FwvuEX96JeUaKVBmid994NL2Ca+vhlAMlDyzHGHDjMXVp1iHpUiFG8rvN7DETpTRqXj8wE6jWDzTOOxy2PIsAgNCNSeCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ayaya.dev; spf=pass smtp.mailfrom=ayaya.dev; dkim=pass (1024-bit key) header.d=ayaya.dev header.i=@ayaya.dev header.b=l/zypqJX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ayaya.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ayaya.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ayaya.dev; s=key1;
	t=1721187974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc; bh=zersvC+L3E4SApUB683mmrYO3rRig8jeDUQYxKRKD+8=;
	b=l/zypqJXZC+ve6ZUhavHx/Hs+JRY88+2EGPCeI+oNfH6/fVRFtmbKSeFxVWi0QIcoQFS8p
	GdgnQJdZ/ANNDht0wnAZHRvMxLNf9MAnVS/Yz4gu6+INAVWdTCVwIhHJpcQBGrLxLwKzJY
	61ZkkHsNY7mh/r0ZmR1NsvidhLR7m6A=
Message-Id: <D2RI7Q8MEQEJ.3KAN74XCKVF8B@ayaya.dev>
To: <netdev@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "psykose" <alice@ayaya.dev>
Date: Wed, 17 Jul 2024 05:44:43 +0200
Subject: [PATCH] libnetlink: include endian.h for htobe64
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

fixes build against musl libc which is more strict about header namespaces.

Signed-off-by: psykose <alice@ayaya.dev>
---
 include/libnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 30f0c2d2..0139efa0 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -2,6 +2,7 @@
 #ifndef __LIBNETLINK_H__
 #define __LIBNETLINK_H__ 1
 
+#include <endian.h>
 #include <stdio.h>
 #include <string.h>
 #include <asm/types.h>

base-commit: af9559b23367b01d0f1184c75cdf0cab9c6930ac
-- 
2.45.2

