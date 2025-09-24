Return-Path: <netdev+bounces-225788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8EB98482
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA5219C2C0B
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 05:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8283235BE2;
	Wed, 24 Sep 2025 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgfjzxOs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5822F75C
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691641; cv=none; b=rnVIakmGZ6iU/JNOvmtYhAP5chkIV5/mL67AHswU6LXbZOMM2o4dOqMpiwTM4gSsobY1e4Md/CP0rGxl8CZOeSegUB8hzo4kmfNwXKuhUiM+65ySFlnq/sG5cus671Z3KmtOSXKPfetUf0IvV+JRLXtGqJwIsCLWJO15bFYf+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691641; c=relaxed/simple;
	bh=rcN9V5LgKmUDWSRQZxN6EScS8uDKfYLSUyVCZijz34s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sWihz1KXVdQbTEuBIVtSHeD5vPG709oUGBJO7t98ic6EoEryO4LLsN2/xanezDkhX1KT1/bt74TV6NAZHeqq5GCS0WiYS8eBjutxK3Nwc3gvhZwLGxlBQ9lC8gZ5iYoBr67s0iTVnb5qvLoSekwy4dYncez3GJgBLml9cDnqxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgfjzxOs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758691638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ERAoYpMxtDzUD7G3vhLO8DlEI+eK/IUeWFrCKYCHy9Y=;
	b=hgfjzxOsCEXnopeyWVt3tYUhA3oXKQJ5thZICynR6CwegZfDMQrzeprQyxpIqwUMRr09ce
	7O4yC2JQ1th3GfhLb3e9ZhvhH6X7HZ1vOqDuiaPVx1MD8Auj3EAimG/LBrUiCXPYWUghQS
	MkKKfITKM10x7HRygPtzv9rI1Cf7BoQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-vVjpi-bmPQmGO56a0jPMng-1; Wed, 24 Sep 2025 01:27:11 -0400
X-MC-Unique: vVjpi-bmPQmGO56a0jPMng-1
X-Mimecast-MFC-AGG-ID: vVjpi-bmPQmGO56a0jPMng_1758691630
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so2109728f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 22:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758691629; x=1759296429;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERAoYpMxtDzUD7G3vhLO8DlEI+eK/IUeWFrCKYCHy9Y=;
        b=ksnhiYyCerYpvsH+wX5IOgQA26PLihTheZl+PNixOMjf4x00ZXMiLoRCPsRKfPEJOy
         vwRWlJOnpIjPWCXsnNrVUKbihVHZXaYvfa8iI+Md85xKKwShB8NremAOjRuHsvqnEEY9
         MpzRQefmn5aRlgOISTuOFohXkkL9wxY1zqYM7fDEjIPRWhJnkoeXhlNYiLWVjOBjjqMi
         9I6nDze1FlvgKKyxJwVqRsyhLjRFhAWgkMeQYH6XI+imBwQaqikZIqF6DUBf8n692bh0
         4bcrzSHBZwh8D2jSKw5pw4LGFSIZbfrnFocnSCuvqmQv+mUFk3uEHWhhThGYXzT+3cCY
         MHDw==
X-Forwarded-Encrypted: i=1; AJvYcCUiMwWUezSaWiao1TAiS/efOJnzfE9JDZ62OwYTeutpMttnCrDvPqfJbak1WbmMQ0oLLUA5rEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWahw7CpfBEJS2JxA40YYZ1WSlpwsVl3OKiNb1ZCu/chDJ9Ysw
	YaYEDc2uMuaOEFd30rTPo3CMGjDs1up+10kyrzGIHLfQV2A7pVUt2jzuvqPIBR73JWuqbHT659q
	pcgA44NXYVeTiW9H7xEFg3XuCKAAZedT2erzmHfyF/rVc0J3iyWrhcb3KBA==
X-Gm-Gg: ASbGncs0X8RJMKIg3BQz5Hi/C1cjdfpShSrlnF0cRP71eoN4hdSk610cTfUT1248xHj
	9xnCKPLvEtOHc833zXMwAVlkCl0BCvJeXHgUHKqiPsefEjCeBthLQiiZVLzvPtZzC6edDiXVv8Q
	peoyuKMYLo0FWcQ1L/T4P/IuqrebCJIsdeRpeyJAN1CMc2OupO1nu3tsiiIEOlfO+ADq7bqEuEO
	eZb5+LcX9tVXaC9eKI5qxKOc18NSyAGf6tKUxMOuJp8e7W7u8/d7qAxpnKdCJlDIcpiqTsHf1qD
	ISarPLVdwt/YXeXUK1m1EiDRoJZWY0hQ/vY=
X-Received: by 2002:a5d:5703:0:b0:3ed:e1d8:bd73 with SMTP id ffacd0b85a97d-405ccbd7134mr3235973f8f.57.1758691629604;
        Tue, 23 Sep 2025 22:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5oQeVT7CKEbf5OCtcMlY7u7zZmn5BQoE+KmwNxb2YtEQ0G5EhwtLvtdy5csjDyGCS3ujNUQ==
X-Received: by 2002:a5d:5703:0:b0:3ed:e1d8:bd73 with SMTP id ffacd0b85a97d-405ccbd7134mr3235962f8f.57.1758691629177;
        Tue, 23 Sep 2025 22:27:09 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac5basm18752475e9.7.2025.09.23.22.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 22:27:08 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:27:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] ptr_ring: drop duplicated tail zeroing code
Message-ID: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

We have some rather subtle code around zeroing tail entries, minimizing
cache bouncing.  Let's put it all in one place.

Doing this also reduces the text size slightly, e.g. for
drivers/vhost/net.o
  Before: text: 15,114 bytes
  After: text: 15,082 bytes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested.

 include/linux/ptr_ring.h | 42 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 551329220e4f..a736b16859a6 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -243,6 +243,24 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
 	return ret;
 }
 
+/* Zero entries from tail to specified head.
+ * NB: if consumer_head can be >= r->size need to fixup tail later.
+ */
+static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
+{
+	int head = consumer_head - 1;
+
+	/* Zero out entries in the reverse order: this way we touch the
+	 * cache line that producer might currently be reading the last;
+	 * producer won't make progress and touch other cache lines
+	 * besides the first one until we write out all entries.
+	 */
+	while (likely(head >= r->consumer_tail))
+		r->queue[head--] = NULL;
+
+	r->consumer_tail = consumer_head;
+}
+
 /* Must only be called after __ptr_ring_peek returned !NULL */
 static inline void __ptr_ring_discard_one(struct ptr_ring *r)
 {
@@ -261,8 +279,7 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
 	/* Note: we must keep consumer_head valid at all times for __ptr_ring_empty
 	 * to work correctly.
 	 */
-	int consumer_head = r->consumer_head;
-	int head = consumer_head++;
+	int consumer_head = r->consumer_head + 1;
 
 	/* Once we have processed enough entries invalidate them in
 	 * the ring all at once so producer can reuse their space in the ring.
@@ -270,16 +287,9 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
 	 * but helps keep the implementation simple.
 	 */
 	if (unlikely(consumer_head - r->consumer_tail >= r->batch ||
-		     consumer_head >= r->size)) {
-		/* Zero out entries in the reverse order: this way we touch the
-		 * cache line that producer might currently be reading the last;
-		 * producer won't make progress and touch other cache lines
-		 * besides the first one until we write out all entries.
-		 */
-		while (likely(head >= r->consumer_tail))
-			r->queue[head--] = NULL;
-		r->consumer_tail = consumer_head;
-	}
+		     consumer_head >= r->size))
+		__ptr_ring_zero_tail(r, consumer_head);
+
 	if (unlikely(consumer_head >= r->size)) {
 		consumer_head = 0;
 		r->consumer_tail = 0;
@@ -513,7 +523,6 @@ static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
 				      void (*destroy)(void *))
 {
 	unsigned long flags;
-	int head;
 
 	spin_lock_irqsave(&r->consumer_lock, flags);
 	spin_lock(&r->producer_lock);
@@ -525,17 +534,14 @@ static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
 	 * Clean out buffered entries (for simplicity). This way following code
 	 * can test entries for NULL and if not assume they are valid.
 	 */
-	head = r->consumer_head - 1;
-	while (likely(head >= r->consumer_tail))
-		r->queue[head--] = NULL;
-	r->consumer_tail = r->consumer_head;
+	__ptr_ring_zero_tail(r, r->consumer_head);
 
 	/*
 	 * Go over entries in batch, start moving head back and copy entries.
 	 * Stop when we run into previously unconsumed entries.
 	 */
 	while (n) {
-		head = r->consumer_head - 1;
+		int head = r->consumer_head - 1;
 		if (head < 0)
 			head = r->size - 1;
 		if (r->queue[head]) {
-- 
MST


