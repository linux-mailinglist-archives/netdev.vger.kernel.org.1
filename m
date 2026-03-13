Return-Path: <netdev+bounces-267512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPbmAxgqtGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:15:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB30D285B9A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3F9430A5A19
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077339BFF6;
	Fri, 13 Mar 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gitRWG7g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE852E093E
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414567; cv=none; b=QfB9oNyiJSZhwlYrBKMY9piE1eXREpmjZVCTfRNRDjkLxaRarvZS9NMEg2/jO9VLZpkYEyOJ/DwlQHeTQoUTDTC0p7VS6fAj5DU53v6ji55UFx+zWS9LRvK0bLDbFqGPQjnTml2MsINtoLTwzksjCvuVDmPZpplQZAesP9KN/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414567; c=relaxed/simple;
	bh=3X60ZXwew/9lp/WITRjMllIKaA7aYWegUTrVpXqXxXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xld+PdQGBHFlXTN7cOdTot435Z8ogkoyoCRt2tCGHe8HBvMAW4pw4Rrl858oVycPhJ3y37+BGU+WPbSYOgy0AatKimla3FteqWdtvkArZmvAAPePtOHZL2aaCpYUGmAw9H7b8COUAx2dzgQHfpL1aoNdlu16nEWkUw2Lad9BzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gitRWG7g; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439fe4985efso2063901f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773414564; x=1774019364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urDXnIwW2W/IeIM0EjZ2m3KkRF3QCtGaKXO+zv+xEPE=;
        b=gitRWG7gB9KQOg2zvwzR8JS7kAuZSqgG40YVki7JvggqZF9QmDhq1oNORfNG8oQZNn
         0xH4isD14u7m7Whxe4HXoEuCSHpHSqVxrekJxcYsUUUC9J2wcKV7pS8U5gUrSgiVDpyp
         sHxV4rnVCEwQlserbG95vvQBm7gL19vHTfFfQnyKoXPasV3/xGWGLjbRnC9C0uj0gnzI
         Bs+OiDgG2YodCH+m6HWPPmFgxVV8DPid6OtIGbzd9CFaM72agxqmEqr5Twk67wPm2qZ6
         3af37BFHo8mhaahRZ5OqY8sLQqWLrWR11lv8GbIYTh7h6R8GRzdwfJ/fYvFk9w59VAV7
         quzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773414564; x=1774019364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urDXnIwW2W/IeIM0EjZ2m3KkRF3QCtGaKXO+zv+xEPE=;
        b=tZ39e6bRqBgpvxmaPQxauMWowuRS0hEZTQbihaViBgLHmkzUPwccjHhuntkDKoRNh7
         c4GV/XbDDvQsH1ljxzxiC9cCQaB9xt/kXOQnMCJ7SNP1TU9DdD3ZlqkdZ2KRjwYoBdsl
         lP3nrVPugd3dbXvJGQWWXDys7uzBbIxm8/06q2p6CrzF+sZpB+s91M9ceu/v4TxIoUox
         pL3fs+E29rB9YVvT/pgJ0J07M+AgLhHx5KrqN7mXRb1BPI8Rq1qOOgXvkqDYqKR6yqf/
         uWr/jh/73lPlUg3FjRMfSQ6M0dbbGO5SHN/nNNCAY+ExwrwGO+Gj3455UmQ2kGqMKNR/
         CBYw==
X-Forwarded-Encrypted: i=1; AJvYcCXX/OCi9gLQ+4FRwxkCl2T7h7fFqiazu3FbM2Wrv+wAahL6TgROkh9wIFGFRdD9pwuASVb/BP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zx7kFS+UoUfyJ0Sz3/a1KvSA0Ykpyu2qz7xm05iRZX8A3d02
	BY5uBIL6+/SPJKs0qhDxACP8VEKgLqhaWu4Vmz4G5dYjkmpY+l77IgAdqodSopr7wfg=
X-Gm-Gg: ATEYQzxUYyoxCQf1f5OFSw7giOs1mY1/qxiWu5Ng61X7BXgUhRux3ynnYK/SXJiQ4H1
	h6ASQ068wgz9EexM23SSKJJyNf3x8/KXuypSffIzqL1Tvoko0opT0NJHIYI4zEceQk8TLJuML3g
	tA1KYYEgjtiauZ2HAJMC7ZwivKQrhFgy+qt4qvFxqtBjbta+KZYAvcp5CAdheczSRToFqxayNrx
	bflguyQY11OBqWcfpYqEQFY+1yFImqYr+EP+KvrSMvEO6m/zwYkdG4d3i/36X9uy7m0Z1o6JOPF
	rGwV6qgY1Yy3rbbD+6U/cRhw3W1wM1EDXXb/PZXmn3upGR60ALt5vELkJYTLzfaYKdHj+/jEXaH
	j39lL8+aRxeONzegc6WJFQ0Vtnm7hwbe2N+oWvjTmv8z3dH1ksBby1LPRyge002AZPZ5NKby9Y4
	XoY2JkcoruRsLa+H4gV73nwh7GSyVUKn0IbWW7F0VwBtTc6pZC9w==
X-Received: by 2002:a05:6000:1885:b0:439:cd8c:209f with SMTP id ffacd0b85a97d-43a04d87c31mr7656964f8f.23.1773414564529;
        Fri, 13 Mar 2026 08:09:24 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22f3a4sm18494305f8f.38.2026.03.13.08.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:09:24 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] idpf: Replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 13 Mar 2026 16:09:17 +0100
Message-ID: <20260313150917.271086-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,intel.com,lunn.ch,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267512-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB30D285B9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 252259993022..6b84e728d29d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2022,7 +2022,7 @@ static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb)
 		/* Fetch timestamp from completion descriptor through
 		 * virtchnl msg to report to stack.
 		 */
-		queue_work(system_unbound_wq, txq->tstamp_task);
+		queue_work(system_dfl_wq, txq->tstamp_task);
 		break;
 	}
 
-- 
2.53.0


