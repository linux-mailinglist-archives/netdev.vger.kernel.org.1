Return-Path: <netdev+bounces-234122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED6BC1CD21
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437861890A50
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386DA35771F;
	Wed, 29 Oct 2025 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1K8PFzo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AF3570B2
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763581; cv=none; b=DmbMlK8JsGwSk+IJTQFPOaXNtbZ3ktUdP7B9v4hIpQ61gXyS4Rp3nPmzucA10c2Tybo2Xd9LUyd+OlzMcaCgH0HtVQ1YFRtdDv7wJYpfGZdyI0qbnaE8K7C5M0XrRQQL4a6W9cHnKLmJktWE7xwj4Tv4FcC1p+W6Q532zRMzsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763581; c=relaxed/simple;
	bh=Hz1cW695wARv+9NNwYgilEM99jI1ucwDgTbPkgMEw+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jwmm0uLAva8RZonyiifhqH7nYPEa1AuQ7rF5mGagwkmgMP0zY1cv4RKEU3IlCJkZyJuOz2nkyw7M+N98hseowbMO9zgaWeKSy5dg6694ef0cgONno09fMLyN5/qf8wyKseht0cv6IpMeu7CNg1of2e7rkTL7+RGGPBw3ROBST4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1K8PFzo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so56592a12.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761763578; x=1762368378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9IwTcakLAgrwbK0/rUiOaLMeUNE4P+aCL2i5ar5nog=;
        b=p1K8PFzoXzpg+fN1+poLJELtDyA07pofMtNaKHDS2A0ndVF1X4s0eFOYuSUKABY8a6
         1LQZ6AwlYsHbA9yQP19lGhqYG7YL4vEgCIA572XD7DV3hQGCTrTg1ObgsgojU7046Uvm
         zVPVBpog6+lWUtB2R1wLAdZKgaza5DhyrOpAIYY2uob2TYPkGisN/YTTDakOtlTZuDa2
         AwkgQKiizjokL8ZXJjJ2ivbvkP2VRb9NKecT8nLyrXIBuUXpBPe6sZlcI+LXpJcCOZNK
         MQgDs7utbsQ4Rwd8gWjtDJB4aqdYU5I8ZkT6fifXsozPDkE4AUeanMN9Zfq3dwKbuypS
         V4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761763578; x=1762368378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9IwTcakLAgrwbK0/rUiOaLMeUNE4P+aCL2i5ar5nog=;
        b=e1ufN1sXrXRXX3z0l+ntaCt1JpJGLQX6BMUBjPDNao85n2H2CLEBt0oCfnkmfjwYYJ
         Ajw3gFEt7lsWcxP6yDBgTuXUZbthD2kx9EkUr9lGd6u4GWdy+XaAJt+QVEr0wUwNvTNe
         hXQ0Q4GEfmXW58CGXn2reeM+L0pjRUMIm5NxWh5z6dRf+Ykkjr4wPJlz8j3dv18dGsPL
         f+FM6JkIXDW+gm9xpz9c3ikH8SSBMUT/Oek2lUBPzO46BX/fZRpTyhsG+FjhHW5Hacjq
         4U7e/LIPrgkc8D1gdPeuHET1uHZLewpGe+i84agZA1tUTp3mGQ/RAR2FjruL2MIlYFHA
         ktlw==
X-Gm-Message-State: AOJu0YzepTiXNVqBbXjptdcOs4A4CmyeNy8brQ8Ux+PLsxLNzBhx9hzG
	pFD6Ll3oXCbs2ggt4gno+JO/6UslBCjZp4FCiisy8Rw+qLYKZ2r4l5bbU0LZOX1mrfiP6B3ryWy
	cEsGuZF+iwqPky15HG7dAg7puRY2b114Jo/w6lKpeb5A43JRR7+t08H9MO+FrCoh3i72vmp8uow
	KP5F6g2g/OLIzFBjdwuUS+PO+FvyuTCudY4e6ci9MpafcfLfk=
X-Google-Smtp-Source: AGHT+IGBXn4UqDJBhNJF8Mu8AdNxT3YMrXSar3uJxtmQPCtoodVpYeYO9PeH5wdj9Ndf9qskRirxlFt7PN8v7g==
X-Received: from pfbbk13.prod.google.com ([2002:aa7:830d:0:b0:7a4:f01a:8bee])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1584:b0:2f6:cabe:a7c5 with SMTP id adf61e73a8af0-346531469acmr4427423637.34.1761763577596;
 Wed, 29 Oct 2025 11:46:17 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:45:39 -0700
In-Reply-To: <20251029184555.3852952-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029184555.3852952-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251029184555.3852952-2-joshwash@google.com>
Subject: [PATCH net 1/2] gve: Implement gettimex64 with -EOPNOTSUPP
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Tim Hostetler <thostet@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kevin Yang <yyd@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

gve implemented a ptp_clock for sole use of do_aux_work at this time.
ptp_clock_gettime() and ptp_sys_offset() assume every ptp_clock has
implemented either gettimex64 or gettime64. Stub gettimex64 and return
-EOPNOTSUPP to prevent NULL dereferencing.

Fixes: acd16380523b ("gve: Add initial PTP device support")
Reported-by: syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c8c0e7ccabd456541612
Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_ptp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index e96247c9d68d..19ae699d4b18 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -26,6 +26,13 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
 	return 0;
 }
 
+static int gve_ptp_gettimex64(struct ptp_clock_info *info,
+			      struct timespec64 *ts,
+			      struct ptp_system_timestamp *sts)
+{
+	return -EOPNOTSUPP;
+}
+
 static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 {
 	const struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
@@ -47,6 +54,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 static const struct ptp_clock_info gve_ptp_caps = {
 	.owner          = THIS_MODULE,
 	.name		= "gve clock",
+	.gettimex64	= gve_ptp_gettimex64,
 	.do_aux_work	= gve_ptp_do_aux_work,
 };
 
-- 
2.51.2.997.g839fc31de9-goog


