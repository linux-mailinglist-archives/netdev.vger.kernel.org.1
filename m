Return-Path: <netdev+bounces-194691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64153ACBEE9
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239F33A2C8B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9418FC91;
	Tue,  3 Jun 2025 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B2QtZz7t"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E01BE4E
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748922110; cv=none; b=dLoCm2yuDHtzx9pD4LWQg1S8jI8H9vAOqLCdoLaLd6PQj3NELndDL54sRDseitYvTvifLawMZqRTu5Q3TNCI8ivcqsDahFgOZe9Gvcoyyet1VT1uLjmH52bWWo6BvEM+YHLPXqAjP6X0vceN3Z55fkNQrRz0/Va/EPcu/engEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748922110; c=relaxed/simple;
	bh=RmOtnds9PRTt5hlNpE65UrqkN+rjLm8P9mXtHSpBYO8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VfaD7ZkjBODVzNH8DpXKbrr5+IvWj2YQhjlA1r+SL17cTiFHgulcjPmr3jDaRs6gHFSwjXsM2Sz5lYlhWv/pD3BKS7aygK2h70vsWZixdBiQclCXzLvL+SBwWKQJm28wT9eXTiET5u6cumVJPx+lVa9b2XvUS+4PR6WZyxwlbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B2QtZz7t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1226)
	id 99D832113A59; Mon,  2 Jun 2025 20:41:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99D832113A59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748922108;
	bh=TxfxM5iGbjE0TypZ6NXPtibruIBrb5JAeT0GbioAAM4=;
	h=From:To:Cc:Subject:Date:From;
	b=B2QtZz7t84z6uXUG/mwOSPWjdH4qYkLVc/fE/HosqyT9BvmGMhH9KK1f98OMTe0tp
	 t1gs1tsXnwCGNqHaIbfE2Dkn7aH+W8E3aQOPSZ0fOJkS1EmgEObKp1Wf94RJdV0n5t
	 MT9eSeRDsrNSmT5K0AEqMe+AH69P1K4pqU3/0Fps=
From: vmalla@linux.microsoft.com
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org,
	edumazet@google.com,
	vmalla@microsoft.com
Subject: [PATCH iproute2-next] Parse FQ band weights correctly
Date: Mon,  2 Jun 2025 20:40:42 -0700
Message-Id: <1748922042-32491-1-git-send-email-vmalla@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Hemanth Malla <vmalla@microsoft.com>

Currently, NEXT_ARG() is called twice resulting in the first
weight being skipped. This results in the following errors:

$ sudo tc qdisc replace dev enP64183s1 root fq weights 589824 196608 65536
Not enough elements in weights

$ sudo tc qdisc replace dev enP64183s1 root fq weights 589824 196608 65536 nopacing
Illegal "weights" element, positive number expected

Fixes: 567eb4e41045 ("tc: fq: add TCA_FQ_WEIGHTS handling")
Signed-off-by: Hemanth Malla <vmalla@microsoft.com>
---
 tc/q_fq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tc/q_fq.c b/tc/q_fq.c
index 51a43122..13c5a896 100644
--- a/tc/q_fq.c
+++ b/tc/q_fq.c
@@ -258,7 +258,6 @@ static int fq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
                                fprintf(stderr, "Duplicate \"weights\"\n");
                                return -1;
                        }
-                       NEXT_ARG();
                        for (idx = 0; idx < FQ_BANDS; ++idx) {
                                int val;

--
2.43.0


