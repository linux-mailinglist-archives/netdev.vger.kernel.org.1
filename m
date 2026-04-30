Return-Path: <netdev+bounces-282714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB0eHsoY82llxAEAu9opvQ
	(envelope-from <netdev+bounces-282714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1A49F7C6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53CC830128C9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7803EF678;
	Thu, 30 Apr 2026 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DI4RWOBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A253164C3
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539270; cv=none; b=VEACJAXkrLEdnRCi8EkVQrmieHbv2V1N6t3iOldRt7ajr3g5XlUqPQeSowADwoIhc82u1bMqlN2K6zbaXMeVKPOKP6vyxxujWa+S6YXGYB0W885nCpD9O3qVyFJUkDoP0KiZ3NdKdsLpYlxhz1+9UKy8VauoJ0yTkDpFvcAJVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539270; c=relaxed/simple;
	bh=s/mRY8DfMR8DIXpcHgLYEU8aDoZ9DdH5IyZrbIZM1HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9NeaGywqUT7NPb6lBmE1UHYHnj6ZRs28x0k0P9ILF7uEwqyhICkPRVcIu9I2WRuYTmCqFfwoNpjSFs9Lc4XCKiX+5BOCKHbhQaTox0b+7DomTrbnqDNVsfeBayjEhQQZIeoXASO5nA0Gd5WOfYx6v4pORdAbARAKln1zHJqMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DI4RWOBJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso17213445e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777539267; x=1778144067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6A9BkChX+85bq148XRWnuRUsG5zQnCEzyenyeEOtadE=;
        b=DI4RWOBJuahh4eB++rrQhTMoTwFKxoIeuMBZUE3nCyMwGRCqkmfmL4KcxvsryNCjIM
         +oUt7drtBWksNHP3zw7RVWp+lTs7QVw7wYfTuHwWnbz1As4nzb2RRm8+FNODv5x28awH
         BQvJWIhe3+KDRXHYu9/IE/DUO1zB88gJJqLY+e/GqfwZPZKefybgwm5s+lIG7u7NgzbX
         cJHyp7SAEFAXMcLVSV4AM+NP2wa8JgRQDLT848SKE0ngQPWvUbgM+Kwl5Zy0SLCj0IbR
         077gAgIYnhC3W9nudNTA021ai1SqqJowK06JObCWkPfVOv/yZNOn5KUH85QGnyYt8BEF
         ixdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777539267; x=1778144067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A9BkChX+85bq148XRWnuRUsG5zQnCEzyenyeEOtadE=;
        b=DrAOQejyCeOBgU5LRHHQMcm3HfmW9qa5XD/yVhrG2MWbxaxql7Ll+L76ZQFYJS4UWu
         MQyBjqi33irBDkqdJUDtEA1TYwvP+yy3dTLbqqji6cX01t58V0gAYDl+kT0pBwchcjpI
         0h4BMewFLN358LhVpAXympZQ7v8k4+s2o4mRijBT5PAxGIZAN2S3+/2epqBVMu40tiGk
         CZfw5tXzD7doivJWikNdzk/Gwe1y8GZocgpA0SBye7wDKRAlDFAmjoIs118I79dxBxjH
         mpvGV1enmy6bREM2OhLEqwpCrmOqDH9D1UAaFogyLGw3RB273ZGdyyFfZg8DaQ9tUWlc
         /pZw==
X-Forwarded-Encrypted: i=1; AFNElJ+l7RljiByMDxUV61dXzuMi+QMf8Wdf2jnpCfE1OsvHWn9GXJm5NbVxGdIxiazKgX2lWrCi8II=@vger.kernel.org
X-Gm-Message-State: AOJu0YybjgO3D1O8enw+c8y2iPKkmpnZraOzaZkLpXADcXFz+gVr9xn8
	A58isT4K6zlPBm8HSwznMUw9WBACw1T/RGAYt6b3kLEwolwkDK4SiQ6OVJ/jSv3G9+4=
X-Gm-Gg: AeBDiesY7HUiExEyBaBvEMzwxVbkj7TCNPrYKFC5CVFuyC7U/vZF9p6Ncr840YFygys
	chMSjCRFftqMEbBm8sLyNxstlaI1jznlaEJIlT4wInSiEbSNXneLu40QG/ma7fxGjVm4d2zypJt
	pJZbC79VkLmCVeWfWwSmEOMAn/O4SDw4B72TVGrPnzZk90O074HVnmqFC85JolRPLxkY0X1F5h6
	fyfAFEA/zXQe5E7UyMD1540BtjQYgCvQKJgplQXhYYZU7og51kJ5vz+3LUHnVSQeGentHWL5Cxo
	4mULYal/WeY4suF7MV9W8obDGHBnumIJA1pFx/CFHEGXZ8KKorxAgl48S+b7itH+u/Zhg+cpbiF
	Lk8suQ8OBXzi0VHZ22/DvTHg09GMWibTJFSP0PvPObQJ5cyRJ2UPCRInqpPEqCTkzYJBTfv6csc
	3BkPGcCMkQaAW4+knPuKyWAeEK3UDxKj1Tc1oYo/OjERMu35POCsOJCLdndZl8ET5Vt/92
X-Received: by 2002:a05:600c:6291:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48a85e75173mr26204975e9.7.1777539266753;
        Thu, 30 Apr 2026 01:54:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2fb5c7sm52906795e9.5.2026.04.30.01.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:54:26 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH] xprtrdma: Move long delayed work on system_dfl_long_wq
Date: Thu, 30 Apr 2026 10:54:12 +0200
Message-ID: <20260430085412.96961-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E3B1A49F7C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-282714-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected, but it is a per-cpu workqueue.

This is important because queue_delayed_work() queue the work using:

   queue_delayed_work_on(WORK_CPU_UNBOUND, ...);

Note that WORK_CPU_UNBOUND = NR_CPUS.

This would end up calling __queue_delayed_work() that does:

    if (housekeeping_enabled(HK_TYPE_TIMER)) {
    //      [....]
    } else {
            if (likely(cpu == WORK_CPU_UNBOUND))
                    add_timer_global(timer);
            else
                    add_timer_on(timer, cpu);
    }

So when cpu == WORK_CPU_UNBOUND the timer is global and is
not using a specific CPU. Later, when __queue_work() is called:

    if (req_cpu == WORK_CPU_UNBOUND) {
            if (wq->flags & WQ_UNBOUND)
                    cpu = wq_select_unbound_cpu(raw_smp_processor_id());
            else
                    cpu = raw_smp_processor_id();
    }

Because the wq is not unbound, it takes the CPU where the timer
fired and enqueue the work on that CPU.
The consequence of all of this is that the work can run anywhere,
depending on where the timer fired.

Recently, a new unbound workqueue specific for long running work has
been added:

   c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

So change system_long_wq with system_dfl_long_wq so that the work may
benefit from scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/sunrpc/xprtrdma/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 61706df5e485..1a54993f7ffb 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -484,7 +484,8 @@ xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
 	trace_xprtrdma_op_connect(r_xprt, delay);
-	queue_delayed_work(system_long_wq, &r_xprt->rx_connect_worker, delay);
+	queue_delayed_work(system_dfl_long_wq, &r_xprt->rx_connect_worker,
+			   delay);
 }
 
 /**
-- 
2.53.0


