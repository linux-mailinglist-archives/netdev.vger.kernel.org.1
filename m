Return-Path: <netdev+bounces-286563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMhLNWuhAWpKgwEAu9opvQ
	(envelope-from <netdev+bounces-286563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:29:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3B550AE39
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E8AF300B1AF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCE3BED1F;
	Mon, 11 May 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/eps76x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18383B0ADF
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491741; cv=none; b=dRYOoFgmOCTAtf4PrCIYZNLCR7QB1jdaagvu5IfyMUFRrN6eo43r/W++xHFZKc0YAmVF97K2tsORyqQ3RE90O6ePMALB917DdrQrK5bYHGHfQSW8k0AxdqSvouCUc+isay2gbYWbUeuGNSuazIdm3ZpORboI6nCxmfkBp24JTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491741; c=relaxed/simple;
	bh=lsDFIcHAftlanfKCuHhcmiZBwiRMAZikzgChqPjJjHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6pFcO1Pyi9KncU06gEhQtsk32IGweboH22VwE4hqvZfpQJiyrlVwvvWul1LxZpGNjQsUGtlGYL7MprKz/dEoRxCQ0qiWWHaUbRVK7u2N38+Gl5/Y6Z2cXVBpoqmI1/tN18Ph/g98wILslH46Ka6TBZLjh7q6R6t9/F/zmL458g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/eps76x; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-448528f4e69so2396099f8f.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778491738; x=1779096538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
        b=O/eps76xEqanhoVZDUPzxaSL1NgGjOErbvN5U8eYHw8S5gN2yRJitkOKgbJsSCvfTS
         7VvoO+obDujbo18AxwKmCZjAvZC9IW2rGyhDl+oakRwm7SSCogfmyx9hi5pQj3qUTFgx
         VrtsUvX/V4+33dp8llkv4rM9UuzJ+i+4Fm56bsMNusvPC6S5cMdt9yLcVHkMnWXZ+OJE
         4n7mbkyjLyvGjjEpx7gP5HDMyNmmWKkStEcpKXPAytKJdrk5WCOkb+9m28Fp0JgG6bGE
         iqZ7DO3hXN+JW1nWxr70pXiMJ6BI3kU6Y54ykv0pE5o9mMIGKUXQCdtmJtq7OkFQpu6M
         EQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491738; x=1779096538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
        b=oXN5jezQKh9BjUVrRv1KbNLFRfudoNQvnhyeVv/2ZQEGaWcsblCFX1HH1xfoQO2L//
         9+PE0x00z4hDh85ulfZtbduD7UcNY5hLYpRawwusHkpLSEooFXIf6Fj1nSMKzYwyvDvq
         EASDDYujISP8f9mIxDbHGWJMTiSOzKY5fqNAglHVsnMK7NAeWgwsLukO3HvCSov9hyma
         9D4UakMXbBpa24N26DHAie6XB1Nehj8wbVxWWMInNKW/mZZYPJkZTNvSYSf75rs8xRV4
         0BbY0+GteXCp67rxsATT6sSsJcOhlrMr+Dk8oq2oFZ0+clXotld/d9ZGfJXx0ECl/xQW
         MouA==
X-Forwarded-Encrypted: i=1; AFNElJ8cREKuzxDsgVLoWgzTQw9O7mUPxmcKbBDdfKUEfQRbh9ZoQePW1OfciCX26gSgTEhslgsR1Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6u/dz8Dl8ingMBxClDEczDj/8/oYsSB1AqxH8Hs94aTC7Sjnm
	HSISJLK2i4bLFS/wacSeaiSee+Q5xyWjK9ptKQrbekyWJR90OS/9jAd/2esxPSDsBz4=
X-Gm-Gg: Acq92OH4AA4qcIWFHYklhQKfvI2jG0hu+D4y5mUpmiawcwMABcXQ0PN6oiTPkLh72GD
	QwD84wRzydojeIUxtFZ8YObUNfO8TJhfuP2Fe7cuFqBNpz5vjKnb6egsEO4jDwYTqb92c9QITdZ
	48+aTQW67L4QbB3odPI4taIopn9kux3HBu9C0dZ1kl+7vTi5lh+zTvnLDxAoLwC9X0smAsC3zdb
	1VTGhvJJIrTSkIUJ3t5gU4a3ueMI5GXdIh/83dAdcqZ/Qq8LEqSujMZ625x98jCG0ltjNgHlphO
	LxAbyJIftnfe/fdmx13Ugg/ULIqfT0NjadI1k9MVLF5Mh6vkYQG31xIy9MjLXWVeD+JJrg279TJ
	+JmSo1T/x0UUDLifvrzaYVMHK7TE0xfHN3XseoLi9lx76upX6aLsFL9R6eorLdzi30cK/gRivnr
	3NLQ0iTknq7IqpVnHruWpU7dlrEPDoSJaybxH1IOCEDlVHDXQ=
X-Received: by 2002:a05:600c:8908:b0:48e:6275:27ec with SMTP id 5b1f17b1804b1-48e676b6393mr138132725e9.24.1778491737984;
        Mon, 11 May 2026 02:28:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e89fbsm157606675e9.4.2026.05.11.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:28:57 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH net-next 1/5] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Mon, 11 May 2026 11:28:36 +0200
Message-ID: <20260511092846.120141-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511092846.120141-1-marco.crivellari@suse.com>
References: <20260511092846.120141-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F3B550AE39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.ibm.com,ellerman.id.au,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286563-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Haren Myneni <haren@linux.ibm.com>
Cc: Rick Lindsley <ricklind@linux.ibm.com>
Cc: Nick Child <nnac123@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..a1c01c9820d2 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3229,7 +3229,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	if (adapter->state == VNIC_PROBING &&
 	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
 		dev_err(dev, "Reset thread timed out on probe");
-		queue_delayed_work(system_long_wq,
+		queue_delayed_work(system_dfl_long_wq,
 				   &adapter->ibmvnic_delayed_reset,
 				   IBMVNIC_RESET_DELAY);
 		return;
@@ -3267,7 +3267,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	spin_lock(&adapter->rwi_lock);
 	if (!list_empty(&adapter->rwi_list)) {
 		if (test_and_set_bit_lock(0, &adapter->resetting)) {
-			queue_delayed_work(system_long_wq,
+			queue_delayed_work(system_dfl_long_wq,
 					   &adapter->ibmvnic_delayed_reset,
 					   IBMVNIC_RESET_DELAY);
 		} else {
-- 
2.54.0


