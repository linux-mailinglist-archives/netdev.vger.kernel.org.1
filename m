Return-Path: <netdev+bounces-286656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BwYO13gAWptlgEAu9opvQ
	(envelope-from <netdev+bounces-286656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:57:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B15550F781
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3995230570D6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6663F20F0;
	Mon, 11 May 2026 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JbdPmzEp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C023ED10F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507289; cv=none; b=hwtDhYkNv0e+NS5W7qT76OQUqHkRF1x5s5zTIwmMn0y76cHp7s7g+/j7LckuWcxTS+ZdZfalrCc74Ifs8JRXw5wdnO7olezos+/lvAJABUqMEHcRRUnMXOGgpt8oBD68O/Lrrdw1e+2enBdWDBKQKGa3vhFxuBlpkU8vWRAP0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507289; c=relaxed/simple;
	bh=GoLlNaHkE1akE0f93QRoUblRpC+C96KG/0o1YlxklZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WepZfnRXR24dD7zWTPP8fgU6OwwVlQCszjqCZo7se3m9RZLUzcXywPsCCjXiW7Lu9H/HgIeYbVQkibDksZ/Q7zN6nOPYbL/slNUaoQHrMUPzN8WdqzY3t8X2z/RVHjbX5zr8e0S1Ba0q7Xp+oKrDOLixGZJa8iOFN+YIn+SSovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JbdPmzEp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ad135063so35186355e9.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778507286; x=1779112086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhJZtjFF03rg0m+wcwHXl775x/e81mVhXuO5Ve1tobE=;
        b=JbdPmzEpostAhjFw0JxV/jEe2/EfPyvjj51D6TV1Z1Oi34hVyjKIjK0CWKi6OOiGp2
         CKD24oscXynpGq4/EjO7u83ESmfgD9EZF4jm+KLHcRLY/YnnSDZzW94BBgi3H+O4xs3D
         TEXqdppgzfZ2lfSrhAM26Agx6mJ+8hFoBVxiz9UolSgxMrrDlouhKG0oF67BnshT3zwg
         Phz5giiq07WrFkn+vVwESyV25eKlkRvgs2jRmSbUQg+QPePQuLtrvlMdD8pe2oJZYQpG
         eHaYSXdXXU4HWQkXL6nxPwgjVRc78LwyOlMfpa25TmSO+4uE+jaZtgn/2cQ5EMPQyM2N
         XRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507286; x=1779112086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhJZtjFF03rg0m+wcwHXl775x/e81mVhXuO5Ve1tobE=;
        b=KmNq3QIfUH+dtTSwjZtRfHTFoq7V8l3bEFJSCu2k7E2yFessUBcrJb1Mm3oWEMPNrJ
         PmC58ljhU2j96CXT4AYmIi186geXCoDCLakHxqhXKf8TB2Vqn7EC/rNrvZ+W/jFhQfJk
         yVaOe9Jb0i+uml4BxE4q/3hYAXIZ2QHrYLJDjnRVvWvFJO/+HM4XkVvgxS8PCOm9Qu1O
         M/2d6yHCh1Y/3jftJwn/Yy9Q0NefzSEu1zOmcRr6gNdY/c3aue0vRzL8Z5Wc6JmARaNk
         jKRWa49/HThXhQ/zeXSefjiUBM62iZkk9zpzSl9s7C9zW6/uAvBYGD25HoTHxSt850Fj
         zbWA==
X-Forwarded-Encrypted: i=1; AFNElJ8NgSMp9D4CchtgW6tQPDOE0X04/pvHwShwqMLoLWvvZvH16OO1/BYB9qXd2t5lP7F7XPXAhhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFj8MC3M7nHbe9DOPryzGZO7rgFzgJR4bj8UwMKlPOPEZZfrBC
	qbjJkaniWmUsFW11GKc+qtP2Yy1TO6ue88/Oz2ayE1HckwQW14H5E7QcSmxIPVDYBUw=
X-Gm-Gg: Acq92OFN9GmJ1OLTGxyTOb9yaOfEvaadp3bmPOwLzaBBbNtIxoCURJ61jsVarvHyiuN
	FjSvqhA2XcMPt7co24GqDT30Bq9MDEGdZMYITKMCK06i4wwdMIxYFCfyGp+IXeMwozUasONn7xM
	paH4Fa1UIuKi+H6k4H2R78keg9QkKI0yulzgSZmuU0D1CUUC8GIw2zd6Dc0F0XBznUrHxUiluBq
	ZzBDXWHU6wh+eZTIlET2ud6EkIZ3ZI2z3qsN7N8n1VakaYel4QCdnkJd/s8zL9LqmXQSigK+CpB
	STuAmqGrmpxc1/bmwgpPzPkoKxpzE8O3HdOwvSKUqEJe0v0W7wzsFB5jt5v7VEbKLHkT0fSKY8l
	PMctE1qaQi7fp+OhLF3ZmDJQTD4ZHWiOCPDFt8ddHAL5HLbviR+g53n4WeB6MXZlnLpKXagiP9s
	bbGpmHa4xMCaVpGH8ZkUbgR576PcK2CaRRB60soAWku7LL1f4=
X-Received: by 2002:a05:600c:8012:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-48e5fb8fac9mr299489115e9.24.1778507286514;
        Mon, 11 May 2026 06:48:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e957asm188062665e9.6.2026.05.11.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:48:05 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/2] net: Replace system_unbound_wq with system_dfl_wq
Date: Mon, 11 May 2026 15:47:35 +0200
Message-ID: <20260511134744.277032-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B15550F781
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,strlen.de,nvidia.com,ssi.bg,netfilter.org,nwl.cc];
	TAGGED_FROM(0.00)[bounces-286656-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2]  Replace uses of system_unbound_wq with system_dfl_wq

No behavioral changes are introduced.


Thanks!

Marco Crivellari (2):
  ipmr: Replace use of system_unbound_wq with system_dfl_wq
  ipvs: Replace use of system_unbound_wq with system_dfl_wq

 net/ipv4/ipmr_base.c            |  2 +-
 net/netfilter/ipvs/ip_vs_conn.c |  4 ++--
 net/netfilter/ipvs/ip_vs_ctl.c  | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.54.0


