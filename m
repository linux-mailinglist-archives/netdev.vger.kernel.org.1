Return-Path: <netdev+bounces-192453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F1ABFEEB
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC024E57E3
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AA2BD024;
	Wed, 21 May 2025 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EXrmcgRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D82BD021
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862842; cv=none; b=URrHsVreJzMlYYj8NjGaggaUmDYOEILY8JOtww79ema2Zu8watwZbw+JrmIYJikW21TbMfzbRVBh7Uml0cbvz16g7ZU9CAROo+ShMxKExLlfYbU95XQ9wRDlLEPTIj6MGuWcsKPlYQgLxndpvBlQCfEWV2A1qGk2Bnpv0S3V6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862842; c=relaxed/simple;
	bh=ZSTZkaKkwr+DYsOHrA7Xqe+NM3INb0ikj+DKHN4vS+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INjpjzyIFQ1jh/+e5Zd52ckn0NMtdjoTIAu4GmUqTtpGKyWLLGQJe5NZ03SniAj4am7Po8L09IKrFm0yk2uvmaVtadymgJsBu1aWjNzxNEcAZp+KffkAVA9OUTTJrXj2dxrvyilChiPB9919vsS0/gUYKAFnXvJGCmGzgm8QIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EXrmcgRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E21CC4CEEB;
	Wed, 21 May 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EXrmcgRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747862840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iHKVuKv5+sIao3c4PVTv45kmOQiRCWAt0Rok7NZTxg=;
	b=EXrmcgRq5uzCo3+1tVQ5V5MMPPZGX+zgTx3J9KZ62324XSeX5KF6Z8fD3UDb4n3xqlgUPJ
	6sr1q2pqUB/lfZI2UFSElWCL6stbSR3rPTOSCkP1rX+tKwZU+mfHQ69jju4AYz4AujEtrf
	NOYB+YE3Cp1EHgteNzs/K9btMpqSzEc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 026341db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 May 2025 21:27:20 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Simon Horman <horms@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 1/5] wireguard: selftests: cleanup CONFIG_UBSAN_SANITIZE_ALL
Date: Wed, 21 May 2025 23:27:03 +0200
Message-ID: <20250521212707.1767879-2-Jason@zx2c4.com>
In-Reply-To: <20250521212707.1767879-1-Jason@zx2c4.com>
References: <20250521212707.1767879-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: WangYuli <wangyuli@uniontech.com>

Commit 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
removed the CONFIG_UBSAN_SANITIZE_ALL configuration option.
Eliminate invalid configurations to improve code readability.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/wireguard/qemu/debug.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
index c305d2f613f0..5d39f43dd667 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -22,7 +22,6 @@ CONFIG_HAVE_ARCH_KASAN=y
 CONFIG_KASAN=y
 CONFIG_KASAN_INLINE=y
 CONFIG_UBSAN=y
-CONFIG_UBSAN_SANITIZE_ALL=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_SHIRQ=y
-- 
2.48.1


