Return-Path: <netdev+bounces-286564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBqAGiSkAWqrhAEAu9opvQ
	(envelope-from <netdev+bounces-286564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A750B19C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39243301EF86
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBF03BF667;
	Mon, 11 May 2026 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BCtBLc9c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663413BD653
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491742; cv=none; b=csNTYOsma7UUV7Oej1PTs0TyUtZLYDr6MLnJnVljW7aJNBdd2e7xrjFMtz+dJTnr2qdf7cU6ovmPfuIp8/pYo/Qz969Cj5+Kfncmhsnyyhao5Em+fHD07A0g07muc59bCyxpmKq2gbAXcBhBi6CM01dXdYSDoQMIzPOYgSuN160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491742; c=relaxed/simple;
	bh=63ifupjXbAjohqyy4A1IJNKn3JmWa27I29vcvR905Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaIzEXQ75R7SBBzcAGu6HoWqs0BB/bUlEhj2f/ATWmY4sHRplDxuvtuIiAt3M8QkaTk8P3Py7pW+gWPL2JpIfMgqvrktB638gRsRl9JASzEgUphusbqHrigM1gr/f8cluSAOps3THLpqbSaFF6Gg1xQiAkSoxZ62gHQlCsYwLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BCtBLc9c; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso35217835e9.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778491739; x=1779096539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZyfAFR2B0cKhvW2WvNxW2hQKKC9f/zud3fwLb2p1xU=;
        b=BCtBLc9cBOJ8UKei2M/q7vkk7FXUxMqFgDIfNDSq1qTWlx87tArPJtseoQN0vPzZTj
         v/YSPTCwZgqZkk33JytIcIdBg/+ljCnTGCkUE2qx3S5ZlAKySSodTFkK+1GMRS7RoOmI
         9whJG2OE5/3ZoqFORcES4WP3av3ToJ3lTfVwAasJ/YxOwbS1m3Y5e2a1u78EYyaGgijd
         uwPmGwFP3urhketMOpHDAxWlo4gNII2VfU1IvgeAA+ONKZGhQpVvzsB94le24iL3wlvS
         FBULTys5ZQNgZyDkfkpqg+Xd6r7F0qLeido+iTHygxPIGPgIAAXOEXihEMOXLUq8oVt8
         9n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491739; x=1779096539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZyfAFR2B0cKhvW2WvNxW2hQKKC9f/zud3fwLb2p1xU=;
        b=aqNvjwGmF/7giSlN6RudHwHaAvgUzcSfe5b2lPXA+eiDLWpOmiASHBi2hDLx6mr5dN
         HTJd7W4AoqOJFhnN0P4CcoGN94hXCVLVjrGJ1UVvxX1GTxsj8O5/TDSe8tPdes6xLg2A
         FfG6x3uk4zGzbH8AYEFMsEgoHra6CGafiNCOSjoXx6ZN7KEDz+Rn2s1xdFVI+rxYeCqb
         uX1EFnNK/bFHaJQ//djAYaXCFJd3TIMjdU3Evk3WonLvKDW2R68mgCcC4qFShey8LSNM
         zoER4Ra9LEILOHenKZr8gdiyAk3BeXSPTdUeUQwG2Q3VIkwauthZtCt6KQ8DiZdsBPRk
         AHVw==
X-Forwarded-Encrypted: i=1; AFNElJ9dQxloTNE16EX3H9l0CxgX80wttrT4wb1phuULWljrWiqOO7+B8xNlbIr3yiRJpdvF31jC6j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4BlyTWN+Masj6HWksCaYdZXltAY0dsTvKgPyI+8DSJcUGas9
	/lSaINvatjXhLtisWJPoLwctFwQFTZSbn7QTArzGBTgOuk3TzpVF7UThxLbnmceUPQ4=
X-Gm-Gg: Acq92OGsrqeXAr4bsaNhi1jxbumPhbG7PSO2NrfM+OuN7o0Ir9/K4/VZR+VcfT4ZWfw
	HA/Ka80AWQx+RC1BlITQuNl0R6AlWf7VVrjmkg46jTPlhH1zPani3QPUyohEWaSR3zZVfEKrqre
	gfYx5Rqwcq0YjipG9CymnylFxKuKHNDNralENNubg2hd4i1Ja+mkra8HNrQi2q7ikIIYsn5pBK5
	B+hOZiQMc0wW0pFdSAk5C3b40/guFKcq6QncgN1zuXc4P+xZNrOjaxMfn5ASYpx2lKgGySgUIuA
	FreyaEFjR0k7l5lnIufUlet7vxEkYbsZ529emxDe2/tIT7wcUKWf3Tt4sKuRP077UkAaPzJYQz1
	wLf4yw2Et0rro9vKw+bzzH8n4bGXtKd8ZX3DHs6rNwSKYpdMY2cMK5LW3XVrFlymCYeBP2qmgmI
	wDLXN3+9OHFQOBEAnezsQsesYc9cl1Ovvgsq318hnsnCFyyPLJhgeEmcKAlg==
X-Received: by 2002:a05:600c:4695:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e706b26fdmr135960625e9.17.1778491738974;
        Mon, 11 May 2026 02:28:58 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e89fbsm157606675e9.4.2026.05.11.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:28:58 -0700 (PDT)
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
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH net-next 2/5] net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
Date: Mon, 11 May 2026 11:28:37 +0200
Message-ID: <20260511092846.120141-3-marco.crivellari@suse.com>
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
X-Rspamd-Queue-Id: 660A750B19C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com,ti.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286564-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,stats_work.work:url,ti.com:email,suse.com:email,suse.com:mid,suse.com:dkim,infradead.org:email]
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

Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155c..7d6d6692d819 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -69,7 +69,7 @@ void icssg_stats_work_handler(struct work_struct *work)
 						stats_work.work);
 	emac_update_hardware_stats(emac);
 
-	queue_delayed_work(system_long_wq, &emac->stats_work,
+	queue_delayed_work(system_dfl_long_wq, &emac->stats_work,
 			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
 }
 EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
-- 
2.54.0


