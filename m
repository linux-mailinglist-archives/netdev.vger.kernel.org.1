Return-Path: <netdev+bounces-221498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CEBB50A52
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0665A444C94
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B1520FAB2;
	Wed, 10 Sep 2025 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ki0HJvCC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8244202F9C
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468219; cv=none; b=F2NfdOfmjTakqDwApKqGFHPzq/82S/bptXoWfEGf5/SPq/xPvUzgkGkTxwIEMlbATclaUk0kkyD3PxRY0n4Y5TVdxi7rtm7OLNDR7MDy8BmeGqYVH9Wx5t3iuvMIG+YuBwn3DcY4DlcqTqVjb7LzSzCCPRaDD0vgiefpSbnOOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468219; c=relaxed/simple;
	bh=rj7l7V80ao0F2PnyiG/lfSGBjy2npI9NkUIbDzbxWag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvI48qGYS31uV6UYuTWnoVJsIzhpHeZaSrKwokOhO+rJtG/7mFDsMyT/dKH45slag5ryY6nBMpW2DXoQB9AI9Lof0JDwI13W9o1Yr3VN6A0RvYePQMMt0mEdUQByliYAHyOGppL5qrJAqzB3UTHDEx2msisBosgdJx0Uwq4O8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ki0HJvCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0313C4CEF4;
	Wed, 10 Sep 2025 01:36:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ki0HJvCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757468217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYU8P/pCPZCG3Cv6WvuHtUVPNbBA4flHbfP1WHmHsyI=;
	b=ki0HJvCCD2A0OKDlEkazpx88rcPigHR0YGo1sPGKOPqUZhNeZb7KO+/yX9P/nvu6ke1Xnn
	77Xw4f/e0koeJ8diwSu/lSdeex4LwynTSV7MZGPyQRdce+Gf4WvDXkPbLsm97woKD5DB2w
	Ke9Ibb2csk+9F/gn+EJw14JeoSQZJLk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b3a5a300 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Sep 2025 01:36:57 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Hildenbrand <david@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 3/4] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
Date: Wed, 10 Sep 2025 03:36:43 +0200
Message-ID: <20250910013644.4153708-4-Jason@zx2c4.com>
In-Reply-To: <20250910013644.4153708-1-Jason@zx2c4.com>
References: <20250910013644.4153708-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

It's no longer user-selectable (and the default was already "y"), so
let's just drop it.

It was never really relevant to the wireguard selftests either way.

Cc: Shuah Khan <shuah@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f..1149289f4b30 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -48,7 +48,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
-- 
2.51.0


