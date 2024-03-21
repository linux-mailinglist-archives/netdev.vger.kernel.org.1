Return-Path: <netdev+bounces-80960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1696885593
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB111C20F90
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4F377656;
	Thu, 21 Mar 2024 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THXXtBXW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5E69956
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009102; cv=none; b=Q+rd6W0e/dNnK/yXCOIjSmJe3yLn1iBalhkU01nfBhKBZi6AkOZ4HMvKqXMWtr8GcvH/bVC1y4sTrg40CBFJKOZa85g3ISsc8Xam/DlAATUBqIOfGTkrL+C1U/vgxAqTwdEqmlh2wSof3q34jUZ58t3/faV14Dbp57HIrsU/YTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009102; c=relaxed/simple;
	bh=tUl6Y+ILB3eCX9Bq6p+WZ/03L1ZXrx8Zy6xZm4TJ2Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7jSKdJiaYKtGbaNc8JNxQYPj8Sw2R0LQfIerxxCoep659EIbgdblXHNKJpeegAs/JcknQrfV9faO0VEguc7V0ZSK7Az6bvFrD7Q+exIbKT+TdXa8nzpevDKClfcgTWRAoodAh8jELua9vt99P8xYbabI7ohArdO6993UC8rJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THXXtBXW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711009100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNwara8hmM/oqZZWTbZfweFJpIhXMITtHmwHDwGJec8=;
	b=THXXtBXWU/5wpmQO8usZVrxPtmfNeJThIP9u3oHEpEbQTaZ4FDwLezXA3twlxHQhc4J6VK
	c6+F0ff4GCi+WMR5HyQoWtJF6nl0YnVWsbBkqkDVl9iRAuE9uhzigYezJ4MVGntV1Z1Qt6
	Zp12RJcFJrOTUxDG8q+YrYDN1zihnGY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-wsHdh9YcM1OadUS2IBFShg-1; Thu, 21 Mar 2024 04:18:14 -0400
X-MC-Unique: wsHdh9YcM1OadUS2IBFShg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A11E9185A786;
	Thu, 21 Mar 2024 08:18:13 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0A041C060A4;
	Thu, 21 Mar 2024 08:18:11 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Xu Kuohai <xukuohai@huawei.com>,
	Xi Wang <xi.wang@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v2] arm64: bpf: fix 32bit unconditional bswap
Date: Thu, 21 Mar 2024 09:18:09 +0100
Message-ID: <20240321081809.158803-1-asavkov@redhat.com>
In-Reply-To: <20240313140205.3191564-1-asavkov@redhat.com>
References: <20240313140205.3191564-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

In case when is64 == 1 in emit(A64_REV32(is64, dst, dst), ctx) the
generated insn reverses byte order for both high and low 32-bit words,
resuling in an incorrect swap as indicated by the jit test:

[ 9757.262607] test_bpf: #312 BSWAP 16: 0x0123456789abcdef -> 0xefcd jited:1 8 PASS
[ 9757.264435] test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1460850314 != -271733879 (0x5712ce8a != 0xefcdab89)FAIL (1 times)
[ 9757.266260] test_bpf: #314 BSWAP 64: 0x0123456789abcdef -> 0x67452301 jited:1 8 PASS
[ 9757.268000] test_bpf: #315 BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89 jited:1 8 PASS
[ 9757.269686] test_bpf: #316 BSWAP 16: 0xfedcba9876543210 -> 0x1032 jited:1 8 PASS
[ 9757.271380] test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -1460850316 != 271733878 (0xa8ed3174 != 0x10325476)FAIL (1 times)
[ 9757.273022] test_bpf: #318 BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe jited:1 7 PASS
[ 9757.274721] test_bpf: #319 BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476 jited:1 9 PASS

Fix this by forcing 32bit variant of rev32.

Fixes: 1104247f3f979 ("bpf, arm64: Support unconditional bswap")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Tested-by: Puranjay Mohan <puranjay12@gmail.com>
Acked-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5b461dda4385..c3ededd23cbf6 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -943,7 +943,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_UXTH(is64, dst, dst), ctx);
 			break;
 		case 32:
-			emit(A64_REV32(is64, dst, dst), ctx);
+			emit(A64_REV32(0, dst, dst), ctx);
 			/* upper 32 bits already cleared */
 			break;
 		case 64:
-- 
2.44.0


