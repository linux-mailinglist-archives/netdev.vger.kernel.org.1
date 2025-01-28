Return-Path: <netdev+bounces-161398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EF4A20EF9
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CE9188A85D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E77F1DE884;
	Tue, 28 Jan 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+YlJExe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A11DE4D2;
	Tue, 28 Jan 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082819; cv=none; b=ea8wSi72SH573GM4ittjnUXHzQho7beoKx/uXAMyAJD7ydV15WZBz1T0wWQu7xs/WmDctaCTLYqNWTW47BAsXJWl4i0lVb50uj8HUSNF0fDWso4CYFG0WrUf5ExpoOxMOVP6nwvdzDH2mPqlLk0vRW2f7Az6YDfC62l0u0HXzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082819; c=relaxed/simple;
	bh=glHKOapZIwcwFFnizpd/vqC6g/9VM+x0Bg4In7uX6fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQtogdwcAX3cmzC4DgcS2QePsc8lkfqMLfDdd0aPm1Or3UYqjHBTe7WiNo1kj40DsCcCIQ7byEJeV3C5FK6maRUM7g2f8AdXUh2vEoZG4lL5UsnstL8+aZcQafZKZdwFAKwW06T0ue2iZncAea+qAGEXdIkiyK/Pq4gmYdbdWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+YlJExe; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e4419a47887so8021738276.0;
        Tue, 28 Jan 2025 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082816; x=1738687616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jlrAcgdlcuse8iCe0f260piXpVGsuWUSordlnIs6v8=;
        b=b+YlJExeCkjlSnCHura1ZigcukgpQtML27Taap95aBOT7amGH+poy3Yssum+i20efZ
         I6Iw5v87+1lG9TsLf8oc/SATFSUqkf/MzkIur/UYs2NKatIL3M+ihaoj6uh+jweeZAXs
         +GZbWdTU2kbA5k7AHQ9kLLBsJGPUs59DjKwdqkXWVfsxeUlV3w28Oo32KizwIrKY6s4q
         eqXSxQ/6ia0VYTMJWP6Fx/k0IRuoj/XLESNgQouwOhox14MR9XA9m92LA53uTFAXUrAY
         jlgpOgjHzT1kOXf+FPqwZ7V7icfzmmlm+gWackYPzqIt8NhjBXUf4mbXzyvsfbteEH4s
         ESKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082816; x=1738687616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jlrAcgdlcuse8iCe0f260piXpVGsuWUSordlnIs6v8=;
        b=b1VAbAUeIOszgokpX5g9Y4SjlEU9T4FJ7Zs0iqhopYYuhrTXmIvKJGFvhoF6o14dp/
         vPppTUW3gnbZn9NnzACwbwbAYjEH1zNW/fZhERHd0TTMGuoCH30qwV1IXOlpVf+jD8ZQ
         zmvEscT8lsNOHQwzNYaGUObMUql0f/mN/zF7ay9SnwToTU2VO+5hIMQhcaVaftYEGHjb
         JEzmA1xIqyIhb0Exj9SF/mVtREup73gYdhCGOD2YyvXuetAJL0ArznKhqNxT7FgByGMS
         S97I1MuUeqdejyn8WQPmfPLxHGvrgalTgtcCia3Q8xunXEG+OH9lhdP434NSB8OWP28r
         2Lag==
X-Forwarded-Encrypted: i=1; AJvYcCUuOvpbAtj4xYrauS3P+3dX+UoSI37ndSbDsHeqmY8jr0iaJrZawBnBS4IYNGG79quh8NExzzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2meHoKgkVwISGCkqnEKA5saEnpA9Ke49EuTVBYJ0EWyrfcBf
	NqqCM0/oB9LQYS6bK9ra1kBA2VADkW4b+1240kxeGXwnC1CEPpl8LyCDE/LJ
X-Gm-Gg: ASbGncvp1jY/j3zAWtVNWtbAHfKIR+XPtOatCg1iBlQFNHGurgRl8RUhcsrMppJpMez
	kI32tDAuB8kLNMfCnQVq6zLsEw7W+avmUrwzz08CE3KJRM8aQ5xWZMCuzYDxr4x3loVjO0VfngA
	s361R7kZ7Wos0ajEKCKoQhLaeRvYOae8l5AnzCm0g+bLBLQpMmlaK8WmQfxZklUrKnKWV5B/iMc
	6BKYQa557/Z7MAZWPcI7iMWkvV2c5m+O/p8i0Oud56G4D6fynNm7Civ1W2CvtxGae57VAR1f/LF
	AKkXY3nz6YH6U1xLWoykfEVBigaCZWhIeuArmzGjSFLWLmFM2z4rHRoOltVreg==
X-Google-Smtp-Source: AGHT+IHgsJ3cSZTT2IUcyxNcM0FxGg/w0v9YU63CYMxP8tpt4cmfiPqHRC1Hgkmpm4IjqQ+OplZzew==
X-Received: by 2002:a05:690c:46c2:b0:6f0:237e:fc4c with SMTP id 00721157ae682-6f6eb677db4mr335746597b3.12.1738082816017;
        Tue, 28 Jan 2025 08:46:56 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f75788d7d9sm19386767b3.27.2025.01.28.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:46:55 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 03/13] ibmvnic: simplify ibmvnic_set_queue_affinity()
Date: Tue, 28 Jan 2025 11:46:32 -0500
Message-ID: <20250128164646.4009-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A loop based on cpumask_next_wrap() opencodes the dedicated macro
for_each_online_cpu_wrap(). Using the macro allows to avoid setting
bits affinity mask more than once when stride >= num_online_cpus.

This also helps to drop cpumask handling code in the caller function.

CC: Nick Child <nnac123@linux.ibm.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e95ae0d39948..bef18ff69065 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -234,11 +234,17 @@ static int ibmvnic_set_queue_affinity(struct ibmvnic_sub_crq_queue *queue,
 		(*stragglers)--;
 	}
 	/* atomic write is safer than writing bit by bit directly */
-	for (i = 0; i < stride; i++) {
-		cpumask_set_cpu(*cpu, mask);
-		*cpu = cpumask_next_wrap(*cpu, cpu_online_mask,
-					 nr_cpu_ids, false);
+	for_each_online_cpu_wrap(i, *cpu) {
+		if (!stride--) {
+			/* For the next queue we start from the first
+			 * unused CPU in this queue
+			 */
+			*cpu = i;
+			break;
+		}
+		cpumask_set_cpu(i, mask);
 	}
+
 	/* set queue affinity mask */
 	cpumask_copy(queue->affinity_mask, mask);
 	rc = irq_set_affinity_and_hint(queue->irq, queue->affinity_mask);
@@ -256,7 +262,7 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
 	int num_rxqs = adapter->num_active_rx_scrqs, i_rxqs = 0;
 	int num_txqs = adapter->num_active_tx_scrqs, i_txqs = 0;
 	int total_queues, stride, stragglers, i;
-	unsigned int num_cpu, cpu;
+	unsigned int num_cpu, cpu = 0;
 	bool is_rx_queue;
 	int rc = 0;
 
@@ -274,8 +280,6 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
 	stride = max_t(int, num_cpu / total_queues, 1);
 	/* number of leftover cpu's */
 	stragglers = num_cpu >= total_queues ? num_cpu % total_queues : 0;
-	/* next available cpu to assign irq to */
-	cpu = cpumask_next(-1, cpu_online_mask);
 
 	for (i = 0; i < total_queues; i++) {
 		is_rx_queue = false;
-- 
2.43.0


