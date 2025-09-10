Return-Path: <netdev+bounces-221496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631DB50A50
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81794434E5
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F720C47C;
	Wed, 10 Sep 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M0lyx/Ou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0641F936
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468216; cv=none; b=GKW5G/GzGMW/zrYv0udSztmDADVYwuWeBW8Sm0BYbPmdDb200hsajKKnwdnvkQSIRG1lBu6EU1Xyd4Qs+p9vIL9vOF8JZ3d1ov3ispZoFdDr7bMWzq3Uc4gGFlq4zI4en27oCo7QDxS3KNyR/R2q+wXy/Da769QGpBvUxo+Pfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468216; c=relaxed/simple;
	bh=iJ+LKnlwfv16WSMuLGGEsUqpc1OUJQAvmckb+Qabf8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUECaAEfL5V0XwD+PNhADrO8u/U9LzU7iFZ5ESEpmfN6j5AVFXpqxDPSWkif2T3y++3O0za7o8yYtdaAFRcSAbt8B2PJ8jl0OiXO/5UKjJ5KsJ+dvBovd/Ih/ntL1FlQSUdLEoTK9FKV9BpU7kl65Re45zJpCexS+pKaN8ZOKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=M0lyx/Ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE421C4CEF4;
	Wed, 10 Sep 2025 01:36:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M0lyx/Ou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757468213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Upgq6MXgQ15ZB+QGLxbUuDhjLl8SbBZkPn9KXLjj4E=;
	b=M0lyx/OuqrV/TUi6SAhctXGECXewPcKPQyT8AGpnZyfB11JjAEz0qADwBeJRTk1ZpSucG2
	3CP5DVg7G41UOuHMr1VajAcMu6Zvwxa6CVA+LBN/XMtBpOW5KCoV2FjsSFJhcl5Hnhvlvg
	Vx0d7SwaHuHof6+rVmP8SvYgZHNXeHA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 06a456a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Sep 2025 01:36:53 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 1/4] wireguard: queueing: simplify wg_cpumask_next_online()
Date: Wed, 10 Sep 2025 03:36:41 +0200
Message-ID: <20250910013644.4153708-2-Jason@zx2c4.com>
In-Reply-To: <20250910013644.4153708-1-Jason@zx2c4.com>
References: <20250910013644.4153708-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>

wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
function significantly simpler. While there, fix opencoded cpu_online()
too.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/queueing.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 7eb76724b3ed..56314f98b6ba 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -104,16 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 
 static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
 {
-	unsigned int cpu = *stored_cpu, cpu_index, i;
+	unsigned int cpu = *stored_cpu;
+
+	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
+		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
 
-	if (unlikely(cpu >= nr_cpu_ids ||
-		     !cpumask_test_cpu(cpu, cpu_online_mask))) {
-		cpu_index = id % cpumask_weight(cpu_online_mask);
-		cpu = cpumask_first(cpu_online_mask);
-		for (i = 0; i < cpu_index; ++i)
-			cpu = cpumask_next(cpu, cpu_online_mask);
-		*stored_cpu = cpu;
-	}
 	return cpu;
 }
 
-- 
2.51.0


