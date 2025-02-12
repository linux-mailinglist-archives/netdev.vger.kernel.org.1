Return-Path: <netdev+bounces-165626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31366A32DC0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18C8163F41
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC43260A33;
	Wed, 12 Feb 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs+1l6xn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA69260A2C;
	Wed, 12 Feb 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382223; cv=none; b=XjXLzjpQkaZ2hsWhirPuOlm4HXg/17Fe0nRwHDNLsEy6AP2t0VIx4XMbEcI53ZBrHPBIL8F6rt1DhGnyNqRLJVuLXbc0s9Rd8ZaOvuK0SfPsIe/CnVhiUmqRhpY9cAYYGJ2HQCiLK0NGC56XP6GBKWvoZSxe0qfinxl9czhGlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382223; c=relaxed/simple;
	bh=yV10f3sVYdeD/lwq8HQsrJW3zW/rQaXngqmNeXro5IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srf/616T1JWNCKLIO/0r6c/WZmawfrLFw1FWCB1EBBs2yr+yOhQLjkbfMuz/NsQpzoSlYk8HvKwHVw7XPT2U8Ocg1Gp+nwaHYrfPP+EEg5wJNbjfLVUnv3X0SZWq7pEalEMxkQDoBHiNkiYGD2yVWAbLSN6KRd3B5yXxMYmXacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs+1l6xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6313C4CEE2;
	Wed, 12 Feb 2025 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739382223;
	bh=yV10f3sVYdeD/lwq8HQsrJW3zW/rQaXngqmNeXro5IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cs+1l6xn0g8Fm5UW9psMSwSDShIg8O/UVUUb51qgjHM+cAqDXiqIn+Fl7/8m2VrNf
	 5bBNz5f090veOhnot48tjJ5DMh8xUJ2AAG+WSZgiiUYf83sFg+1bbs0xX7inH5aoUy
	 sWVb1zdGOYFK3DojvTbZ5eeNSTbyXGOglJJQ/d5SQANvCnzkKR8vMp6ngEmynCVYV9
	 fvHeXExBOfTsSVvM/4b8UP6wsPwWtfp8xq9boDILQvEvITP/7gyDqWhfkuK1QL8AZv
	 1zxRBTA77SsNXVzp25CCAgrkslA/5cYbd3X5T3763B2vRbm+JyMzMGFg7/8urx1jv2
	 7t+NiRG7U7gFw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 2/2] r8152: Call napi_schedule() from proper context
Date: Wed, 12 Feb 2025 18:43:29 +0100
Message-ID: <20250212174329.53793-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250212174329.53793-1-frederic@kernel.org>
References: <20250212174329.53793-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_schedule() is expected to be called either:

* From an interrupt, where raised softirqs are handled on IRQ exit

* Fom a softirq disabled section, where raised softirqs are handled on
  the next call to local_bh_enable().

* From a softirq handler, where raised softirqs are handled on the next
  round in do_softirq(), or further deferred to a dedicated kthread.

r8152 may call napi_schedule() on device resume time from a bare task
context without disabling softirqs as the following trace shows:

	__raise_softirq_irqoff
	__napi_schedule
	rtl8152_runtime_resume.isra.0
	rtl8152_resume
	usb_resume_interface.isra.0
	usb_resume_both
	__rpm_callback
	rpm_callback
	rpm_resume
	__pm_runtime_resume
	usb_autoresume_device
	usb_remote_wakeup
	hub_event
	process_one_work
	worker_thread
	kthread
	ret_from_fork
	ret_from_fork_asm

This may result in the NET_RX softirq vector to be ignored until the
next interrupt or softirq handling. The delay can be long if the
above kthread leaves the CPU idle and the tick is stopped for a while,
as reported with the following message:

	NOHZ tick-stop error: local softirq work is pending, handler #08!!!

Fix this with disabling softirqs while calling napi_schedule(). The
call to local_bh_enable() will take care of the NET_RX raised vector.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: 354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/net/usb/r8152.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 468c73974046..1325460ae457 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8537,8 +8537,11 @@ static int rtl8152_runtime_resume(struct r8152 *tp)
 		clear_bit(SELECTIVE_SUSPEND, &tp->flags);
 		smp_mb__after_atomic();
 
-		if (!list_empty(&tp->rx_done))
+		if (!list_empty(&tp->rx_done)) {
+			local_bh_disable();
 			napi_schedule(&tp->napi);
+			local_bh_enable();
+		}
 
 		usb_submit_urb(tp->intr_urb, GFP_NOIO);
 	} else {
-- 
2.46.0


