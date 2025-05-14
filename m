Return-Path: <netdev+bounces-190470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D6AB6E04
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E38188B945
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B51A3146;
	Wed, 14 May 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsgLmJUq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B26194A44
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232390; cv=none; b=QItShWhamKtbOmC2AX1f1qGiaZ2HRdyCaoUl0kfSsngOXAmL9YLE6YzoWRNlbONV7bHJdql1TBLjxy9B0wsx2k/hP6RxRXbZM8DPAp7Ex1/cqRL0WrHJKsEStg9EYR0s2hk6+Vhcg3+qmiN5Cexv2o0GTDwNPBxqDAedssttd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232390; c=relaxed/simple;
	bh=5Sj5KzI/F46StOB82OyP21k7diNVwpEzL2KwJR5OdEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcFpWvbxm8nzQLK9dqtpUPg5F3iqMqd9K/bXgtXWHC1OxuVTnbw2LQPKW3WLyFHlGBt7RQHWlS3D/v+VALtfzLZHoZwk/uRmLeykR6fOhpchpsS8OXvCqs/pqa1mGfjIbVs0EHsalvj058VP0uQY4iAz+n/VTku2A9lenCi5R24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsgLmJUq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Zvmt/u8Of+L1THnq1idxvoVHR9sJvksCbQhIaqH1ko=;
	b=RsgLmJUqx2Jye3nWFC/liW9hAgF2raciqJz/WvwXogsCQrYLTfJNqZZ1q/q8BPtScIJX3k
	6O/YLNKCujOGlXXkEbsNuuVkabrMBFxjHG9TEvodCMHW4/f1PYNA+/hiL8NnKHNOpCaYB0
	PfkObO15UwbAvsui2SIP1T98CV6wD9s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-fyamJAixN16pbWR_TzB7mA-1; Wed, 14 May 2025 10:19:46 -0400
X-MC-Unique: fyamJAixN16pbWR_TzB7mA-1
X-Mimecast-MFC-AGG-ID: fyamJAixN16pbWR_TzB7mA_1747232385
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a0b6cb5606so3210704f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232384; x=1747837184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Zvmt/u8Of+L1THnq1idxvoVHR9sJvksCbQhIaqH1ko=;
        b=fwj5PldracI4Kd6dckfJfk0A+fSXm1GJ5gmkNq6mp/Q6s1+/xctQB/72yVu645wbs/
         nLxHabrYsEpRK6QlUjGvKVVFVyTyqiRMGlBxiUN6hyJfZr1aoKP8C66esxuYfuPcBEhU
         Gf/3SyIDS/oblqwfYgiS5e56iHqaipCWTrP9fS9SenK2crHR/T0IJLh1XkbP/SpHMNmF
         DBcXDbQv3NX0baWC2oZDmU6V92G6WPQg9ps0aPBieIH3s6P8fXbAEJYCBAWGA730cG7Y
         9jXwqsbHQJjwt1jZmiLauoxyS72MgMWhREaG7O6HNbjmSUcCafgppZv610mm/L6YnFD0
         89TQ==
X-Gm-Message-State: AOJu0YyQE6beFjtee2cKP6vaRrfrVVZf67wf1CGebJS94MzZdQa/mWg5
	7Ibn0wUtkYA3tSsWPWR6JgIPIoIX/F56Y4A+xwCR1eC8UpYWbF0WLVfU6dPbfzcmBPbDgsKRLat
	g7sklNsrZy4uZ6k8iIiPmbXM70lNFC5SX2xgPrbTfWf2oGHhvlvwOk5eIeGe8fOUpeKtCscGsXH
	3+Y7N2OmWlpa74zop7zQOt8Q7PzF7txNthO+lRVA==
X-Gm-Gg: ASbGncu1EV/d3TKjdDNEprA+GjmGbwuUoSZexxy6DkcSepaFCuJqyUGkKxmfRljTu6q
	Dswbct4Ksw9yNNVTVauqjHp6/deK7cxBgs/WgY62vgCoJr61pri/a+h4BdvKr1lOgrqp9CMxsJK
	eDV9GRs2EBvWE2noF5nXhwbpIkxYMma1CivJ+3j/bRgBH8JaZGGNtFcx3LkB40Bd4NBMiofkJwE
	waQ8t8AWQbbrAg3NGhruqiPJUU1bf8PBR4XpX9ZyTJl0DOrHiC27klfYs3USOz9ycoqEjikUfX2
	+J4YI6Z+dLpuqVbt0w==
X-Received: by 2002:a05:6000:2011:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a349694e9fmr2882898f8f.12.1747232384603;
        Wed, 14 May 2025 07:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlD0Y36veSQX0bZUBU4CJr9Oc/mcPJK9k57/34jB6gCQcLqBmTZi0wMgJYerwAAhbWQRLHsQ==
X-Received: by 2002:a05:6000:2011:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a349694e9fmr2882865f8f.12.1747232384019;
        Wed, 14 May 2025 07:19:44 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.203.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f28f7sm19625694f8f.41.2025.05.14.07.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:19:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] vsock/test: retry send() to avoid occasional failure in sigpipe test
Date: Wed, 14 May 2025 16:19:26 +0200
Message-ID: <20250514141927.159456-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514141927.159456-1-sgarzare@redhat.com>
References: <20250514141927.159456-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

When the other peer calls shutdown(SHUT_RD), there is a chance that
the send() call could occur before the message carrying the close
information arrives over the transport. In such cases, the send()
might still succeed. To avoid this race, let's retry the send() call
a few times, ensuring the test is more reliable.

Sleep a little before trying again to avoid flooding the other peer
and filling its receive buffer, causing false-negative.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- add little sleep [Paolo]
---
 tools/testing/vsock/vsock_test.c | 38 +++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72..68f425af00cc 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1058,17 +1058,34 @@ static void sigpipe(int signo)
 	have_sigpipe = 1;
 }
 
+#define SEND_SLEEP_USEC (10 * 1000)
+
 static void test_stream_check_sigpipe(int fd)
 {
 	ssize_t res;
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, 0);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
+	/* When the other peer calls shutdown(SHUT_RD), there is a chance that
+	 * the send() call could occur before the message carrying the close
+	 * information arrives over the transport. In such cases, the send()
+	 * might still succeed. To avoid this race, let's retry the send() call
+	 * a few times, ensuring the test is more reliable.
+	 */
+	timeout_begin(TIMEOUT);
+	while(1) {
+		res = send(fd, "A", 1, 0);
+		if (res == -1)
+			break;
+
+		/* Sleep a little before trying again to avoid flooding the
+		 * other peer and filling its receive buffer, causing
+		 * false-negative.
+		 */
+		timeout_usleep(SEND_SLEEP_USEC);
+		timeout_check("send");
 	}
+	timeout_end();
 
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
@@ -1077,11 +1094,16 @@ static void test_stream_check_sigpipe(int fd)
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, MSG_NOSIGNAL);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
+	timeout_begin(TIMEOUT);
+	while(1) {
+		res = send(fd, "A", 1, MSG_NOSIGNAL);
+		if (res == -1)
+			break;
+
+		timeout_usleep(SEND_SLEEP_USEC);
+		timeout_check("send");
 	}
+	timeout_end();
 
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
-- 
2.49.0


