Return-Path: <netdev+bounces-234492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B104AC21B2D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FAD463CAD
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF6F32C33D;
	Thu, 30 Oct 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lVw3Fc8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B32D6E71
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847778; cv=none; b=SWoqNRaMsuKUBDf4fAxpLLamWVVeWXuJPQZoNYWMN95YgqIhKu8UJdrGYV+XZiXefwFbehaIC8W8G+vIfrjf+Wc6Tn8LeyT/YCg4dQo/Pp4CD0NGbltjH3Z3TqGmKIes1TYp56+/VQ2/iTWjYWmHm4ZVWqGpuYmUCq1SIZBpB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847778; c=relaxed/simple;
	bh=Hs1pM8LrCPsKFJMLLjY40/qaHszKmItfHSs5Ip57vv4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s0OHLr/Dj43LOJPZWq5f2LIft/xnupk19epxU6lcYrpdrrchzgtkAliP9aUIaU7rUOP14S1hoi7bEI5+tYfmKbitAPYHl7VTCUh2RxZp4DOQg38qcCDGc63SwKToINC4QVObMR7AXyzftMuw2bGkR07D3OIFcIFriWgC8D0e+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thostet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lVw3Fc8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thostet.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso3059459a91.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761847776; x=1762452576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pxbU2yjowbmDAWtqBINWVzp9cCDjUVE/Z7xeFsXr6PI=;
        b=1lVw3Fc8wL1jBa7zFVcl/cJcWzRyl9gjk7pXGec0peLITzTw0SQBuozZllmN+GeJYl
         JluP9K8N7wRmEgco4O0Kzfka2ZBJq35V5zmFk70LuHLGqxQuBDJ/nD3FjK6gtuT05J+/
         ICR+M2NVxeowcp2HsgvoCMT/IzWGVmjX+gvYbb0ulB9iQl9u6+VlE86g+/UIqWscB6eC
         QIw1TcbIB3KDazBrPLhj+8ffVoDZhHdDu0bXq5JpN82klfTnAtwcI4Fvh5TDMtduTTCK
         Tq9JBPRh4rfuJ8mq1talBKBiSXpso6FeRKiwNlHoqwHBrsNp6nuNfBh+xRrsE1WNsRi+
         tkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847776; x=1762452576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxbU2yjowbmDAWtqBINWVzp9cCDjUVE/Z7xeFsXr6PI=;
        b=IxZZ6sFzIoTgsSVoeKP0lXRGFZ0pkfexvdWcs9q0yOWACbGeo1HNFwRvSuQq+VQgKq
         iswmfFa14b6Yw8LD4OYB46IMWk5p12jl4FikFTEbhZ/eBc6E0T79y6mu80LsVyaWXLYJ
         0CUaIstZabU1jERnQRMOS1i8FWCh+3a/7XyCVtLqQ2F7JfwzyJ4WFZOZETxTWROJJVbB
         9nePZq0P/FMpH4x2aJF8mup6vRlQ7JUyqzFX32uoSbDYR1Wnl6oOINZ1nPJiGhcjFirR
         oIGve+evHqidOW/7Ao9NaEMb8AfBYPZCqMLi9nfoBm5sZ/cdpvJ9cuP1YSyadbTk+Som
         8sSw==
X-Gm-Message-State: AOJu0YxjRXlP/cnfSkHRNhhXRlzh6Cz9aUcsakoAN7w8TEyslMuc2YH4
	8+EGtXVHtUPYuAhsrrtMYXWIzGcPc4XWaBj3dftbX6/Oh/Qr9LPG66myxFfsXFmvG5DPf3qy7ZM
	PdlMxNg0PPhp6s1JuvYYz3fV/0j/J6KtuVsNMUiANhnAaUWmnTRhgfEFc0eUGlKFL3MHnRcl2+L
	7rOa/gj4UbCbv3Hgsk3zOE1VcIdeRdYk7Y+YiQ9d+61A==
X-Google-Smtp-Source: AGHT+IEKGSgDJLK8DZHzMkJrDQDVHZwHSDHdaAuqpHRm1Zrxjo98F2lFQTGqgyjvBI4CUV7pCmHq1okdBWDF
X-Received: from pjyw17.prod.google.com ([2002:a17:90a:ea11:b0:340:5f65:4ff4])
 (user=thostet job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51d1:b0:330:84c8:92d0
 with SMTP id 98e67ed59e1d1-3408306b9damr858011a91.24.1761847775593; Thu, 30
 Oct 2025 11:09:35 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:08:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251030180832.388729-1-thostet@google.com>
Subject: [PATCH net] ptp: Return -EINVAL on ptp_clock_register if required ops
 are NULL
From: Tim Hostetler <thostet@google.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, Tim Hostetler <thostet@google.com>, stable@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

ptp_clock should never be registered unless it stubs one of gettimex64()
or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
of function pointers is null.

Cc: stable@vger.kernel.org
Fixes: d7d38f5bd7be ("ptp: use the 64 bit get/set time methods for the posix clock.")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Tim Hostetler <thostet@google.com>
---
 drivers/ptp/ptp_clock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ef020599b771..0bc79076771b 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -325,6 +325,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (info->n_alarm > PTP_MAX_ALARMS)
 		return ERR_PTR(-EINVAL);
 
+	if (WARN_ON_ONCE((!info->gettimex64 && !info->gettime64) ||
+			 !info->settime64))
+		return ERR_PTR(-EINVAL);
+
 	/* Initialize a clock structure. */
 	ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
 	if (!ptp) {
-- 
2.51.1.851.g4ebd6896fd-goog


