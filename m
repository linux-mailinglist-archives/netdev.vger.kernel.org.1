Return-Path: <netdev+bounces-235626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB69C334F7
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263B7189F35B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D67C32D7F7;
	Tue,  4 Nov 2025 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQcyOQPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060E309F0E
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297177; cv=none; b=ZKzuaeIrAbX/265n5z3Wu5tX4CNAo5LGDJIBezt3r3JV2rrQbz6fT+5+Jo0Er8sYHphCnCzyPoXHNS0EkhsVLRyQ4rk9JspL/SN073/KqEiEaFG2/zmoMb752K3tRxs/JzW7ZbQzJqp/Z3lfOmk4ocgZOS6rauJx9TLiejjxEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297177; c=relaxed/simple;
	bh=Iq8MbGklyXhx9xeS940InA2Q8/EkrBxN9l1R29833y4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JwVfFmXX2MrFrJVqNwyj4vKHJq/tCevam+oOq38u3ygi2fULH/lOvGdyT6IvBdxU5ubes5CtLqiHKFq61IqQ+qZKNRwWYQL9J9rpmTj+g0r4oaShQ3tXwKXD/PWJhLAqbBhef4h2MMBSEGshZHuqY6Py+FC7fB5xqrcWhJAZ7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thostet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQcyOQPj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thostet.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3407734d98bso6329396a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762297175; x=1762901975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g8Oy6aWnIh0O8I9vsplVMQmhGtDA57xeR6/6rSOUDmI=;
        b=TQcyOQPje4A4dFg3KDcFuECXnonYg7no1Gq07FXo45XUBlwY51s5Wc7L3YYEsLd92W
         Frr+a2OTftPQbNfhQ5flZnSXw6h00FWVJnEHOBvZpOT2fuZAcyF2jE5JbyR3bKutdT0a
         rRzDA0T7/MrTGAHYEWK6U9/MDyd88/v4NSueEmwWQIbpNjsMJN41Oekc/My6mV2+vHEK
         SxDNRPo8kE40eLIdhXCQrjtVKS1h6l95qZv798CLeAxisu6x23HmA27l/m5IWIE2Hqe7
         Y16f/B4wYEsUr2srddEjTKX4M6kvn/Jy3Uuo3kdGUd0QbH+wCCYj1LzDpLwvEYOU5+kX
         YKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297175; x=1762901975;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8Oy6aWnIh0O8I9vsplVMQmhGtDA57xeR6/6rSOUDmI=;
        b=EVBi3I3OmwvN5CGfDCKgzB5UDxr2rtYnf9d8cza0gQyn737TLks5hHO+qfKHB1Zbui
         z9uL42zrscihqBL8oozJfNa0qBfNUatzW0JIkwmk0E9xT+VPajOO5eUk9wdzqgaWw1is
         XFfNRpCbNeP6GmY/6GzGGkM5gymJv91GDAs40wOQBghUhmRd6Uypt6UwzwkE9SxrwWn5
         CWs+fJoi28M8yP3hNs9P1z3B/FksWCPDMimGZtcfu95u+KtM4IbSXHLM2hYgX+33mPWS
         157KEUIBNzebI+Od/ZEu4MrQn/HMdZqDJrCLrFr5UAWZAU0tbFCNNsD1tAz0bN8ZcfxR
         MdOw==
X-Gm-Message-State: AOJu0Ywmm0SRUXSJO1+Gx3USsKm8V6/DD7DB3eL3OFxRS+fIfWBGTS8t
	znkJuWsUoU+G42fv4rAYw43bSkt9FLzCCUGGB5IhTL3cc0f+UBT4BrezLWaHQHT4kekv8oL08Wg
	UFx5XdcDscG++S+UV/mL8ciAronstGn/acyx6QMY5UJiQLaFc8Q8oAA/4J80DqrJM7do9aLM8m9
	Wsfu5D+/BtZVg0L715KW6++0bL3L4X2XwC1U6+n6qgxw==
X-Google-Smtp-Source: AGHT+IFZmZv89AHeew1DxjqnD92JEDh/w4DRt+30O/ESQr5pPOOyv4kJIgltsLGevqqn+HClztxkCOdoWkL6
X-Received: from pjzm12.prod.google.com ([2002:a17:90b:68c:b0:32d:e4c6:7410])
 (user=thostet job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0b:b0:340:7972:a617
 with SMTP id 98e67ed59e1d1-341a6dcb83emr1065737a91.18.1762297175133; Tue, 04
 Nov 2025 14:59:35 -0800 (PST)
Date: Tue,  4 Nov 2025 14:59:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251104225915.2040080-1-thostet@google.com>
Subject: [PATCH net-next v2] ptp: Return -EINVAL on ptp_clock_register if
 required ops are NULL
From: Tim Hostetler <thostet@google.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, Tim Hostetler <thostet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"

ptp_clock should never be registered unless it stubs one of gettimex64()
or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
of function pointers is null.

For consistency, n_alarm validation is also folded into the
WARN_ON_ONCE.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Tim Hostetler <thostet@google.com>
---
Changes in v2:
  * Switch to net-next tree (Jakub Kicinski, Vadim Fedorenko)
  * Fold in n_alarm check into WARN_ON_ONCE (Jakub Kicinski)
---
 drivers/ptp/ptp_clock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ef020599b771..b0e167c0b3eb 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -322,7 +322,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	char debugfsname[16];
 	size_t size;
 
-	if (info->n_alarm > PTP_MAX_ALARMS)
+	if (WARN_ON_ONCE(info->n_alarm > PTP_MAX_ALARMS ||
+			 (!info->gettimex64 && !info->gettime64) ||
+			 !info->settime64))
 		return ERR_PTR(-EINVAL);
 
 	/* Initialize a clock structure. */
-- 
2.51.2.1026.g39e6a42477-goog


