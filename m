Return-Path: <netdev+bounces-305057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HqZuH7PKS2pfaQEAu9opvQ
	(envelope-from <netdev+bounces-305057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:33:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE759712A2C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:33:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=H6ka8P+I;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305057-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305057-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF163162813
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E283750CF;
	Mon,  6 Jul 2026 13:40:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71A36F912
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:40:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345245; cv=none; b=PgjOTC0cRZvDLtzczEIyAhXLCTrq4Nmyq3SvEqj9Qo1aFjvKWQQEPK8DC8Thrbm0V0+lVo1lP0EoYlsscPSie6Wz2MjTfmhVxETMcxQoCpS6lXFjTEfSoubTJ9izUOekuHbaWFmxJZBCZXMsiqyEDnWweU5x5759TB1ZUXwJlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345245; c=relaxed/simple;
	bh=lsDFIcHAftlanfKCuHhcmiZBwiRMAZikzgChqPjJjHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKchtAAsOpXWVHa5L5tXgcl+7eK0+AYxhc9koRHzr3Yj4NqF0LRx4Uu3ySgV/3suKZy1LmMJTdAvJ+z4HZoJYPuEwaT+9BvH9epqLtcG2iK0afTUVUQO9roQpmahkFhtriYNvdCJye19hFpWbhXWzNHmtDA8/SlOyuw+5AqKEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H6ka8P+I; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1639325f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783345242; x=1783950042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
        b=H6ka8P+Iv8JbglyJ3MfUf1QG1iBNmZU6TBryESC3elIvf8iwSw8uPLCSnp91kFEtpy
         AnO274KLUH5UkpHa6Gjlq+viJv30b43y0UZ4n6lcC97vTkxc+NjwjqxxXHjcAKVW766+
         qDQ/eRAW5vyoG3lbHI+6QAynTEECKXhNvYR/X2PeStRxR7FojRGp4bSatSXE3BVOcYD6
         Yo7IOLoeKrrbupHK3rFVWqFNEq2O63EkK785Zl7f25bxRYIrFeNFloV+QM5xT4ZryOt/
         Y4iPbCk8+mPD/8Cu3vtInLmC2t4upaMGihe/kzKl9NihpvxSD3yFDEZpxFc85GM5AuFa
         dihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345242; x=1783950042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
        b=OfL06o9gQdSNmjOGKY2TMTCzI2mFOXHYbaidJHVTzYKCUJKYcoK2VPY1OtrVEBwVbW
         rYaeTzOXFX4lhQZ635X9BL90dgO5TSHLVc6OUiawEXide7F4jxzxv5R1MoDIrbTaImmX
         qeuIX86UJxoPY9ud5eCPi0IBqQTErjUNzJT7HbSFiY5AYYDiN3KKsNWV0blTEhZZYA7a
         rPHGOGu35QsfimK+wz5YFJtFK+hDpWtEPkovU2B8PK5zPPFhHVIpJLnQXKfx9+VtUx2e
         AYjUbYlxU0ZTU5GPVJMHl2V4RRfCUJI5uDsvVSMov7shfd2PxXD2E5AgDdybnLlXx/R/
         l0WA==
X-Forwarded-Encrypted: i=1; AHgh+RrqVddlJEC3HbnFBoyrF8DUvlVNtImnR7NLlw78QS3ZgrxfUNFrqls2/89/Er9z/9vUuqznvAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyLvGx9sZcKbqKbro3msb1QyEffQ6I+xlM5SJqwV0Z3sskJmC
	+zu89vDUo00hkvM4H9ZNvmJMGwe3bR2X1piyT/KA8x32OEtd72t2bBIbYsoOH+iedCc=
X-Gm-Gg: AfdE7cn/8/PkB4AnW4BkodtQIFU3dDryXVOGVf4pCdhZmcmoPqQ6bSDLPI5fTvEg5CC
	f+X2edCdOfUnwSRb/K7uG7z6Jhy37s+YblEKbknFggZXjoXR5M6/2jP0TSI9H8Jg2zb3fUEFEBg
	J5efkEvLCIQkxZ+3SN7LjtD9DW0M8Aljey2shF0IWI4HtfkUPlRMkkm7/VtJ4XLjYbOqy2JutaG
	d8kI7taXiMjRJ3eec4/WxSjqhb9VGoT7MmqxR+AeFvXRxvtMpo+LZxitsBQodVcV5xd5rE6hrzE
	sx3HuALunAn1/7xNA3ZpsqdMPfHoU5i9YYlsB4YCH/pgyrM0CPop9RqWZrhThRDCJ1ydvUSvnil
	1za7T+MBurrNJMuz9X0q5ZGqKWttJTtLlt/yM1gQX9GTmJBiVJvq87fT/dw1cWcYwJ/RB1fRXuA
	hhYyAXZwEFCqto1mDoxjfyZ9zzLD/CytaiwrRqv2uggBoQKA==
X-Received: by 2002:a5d:4101:0:b0:460:2eee:4e21 with SMTP id ffacd0b85a97d-47de66a4d3amr240493f8f.17.1783345242476;
        Mon, 06 Jul 2026 06:40:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm24424868f8f.33.2026.07.06.06.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:40:42 -0700 (PDT)
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
Subject: [PATCH v2 1/5] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Mon,  6 Jul 2026 15:40:24 +0200
Message-ID: <20260706134033.244295-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706134033.244295-1-marco.crivellari@suse.com>
References: <20260706134033.244295-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.ibm.com,ellerman.id.au,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-305057-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:marco.crivellari@suse.com,m:mhocko@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:nnac123@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ellerman.id.au:email,ozlabs.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE759712A2C

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


