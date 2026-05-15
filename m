Return-Path: <netdev+bounces-288320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COc8H5YnB2ppsQIAu9opvQ
	(envelope-from <netdev+bounces-288320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:03:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8306550F28
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A3F430C3A6B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31847481FAE;
	Fri, 15 May 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YNqYG62p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A8481FBD
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853116; cv=none; b=Qxjk+fJyejA1fv7XdOUG0HRY3+PQUJIZ+Y4D1aLbK1NhAk0n6m9nzB5/BghunVi8/8Oje8EiiS/EjD7KdRstMm77dugYIzIzeEyuU35y7RLq84MiBibeLZpMKucry2+PPZ8+dKGzW5PEMs1qHFsSkS5Jcrbj7RvLi6QXfCj+Oc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853116; c=relaxed/simple;
	bh=bQwIl/CC7a2u7dBKqkiDMG3yTlhE6vWTrxK3I/e5Zes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wm/PfBPxL/Oul3wT8BZ1UyS1T1l9NhOue4xfKTe+fYzqbIqBAF6TeuELkNHMP7YgFFOriztiHaYqM3VWELit0fp2ac/+fOrPx1PHFXLf6XK4Mc9LdGS/xeWZC8tNJJBlTUxs+Gk0pLkMTyFC+F7IGn+Y+dkHfsb0w63FEowjNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YNqYG62p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso82850275e9.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778853113; x=1779457913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xZrGgRDaGVqySYoubClm2QP08yGTEdoXS4C6fMI9nE=;
        b=YNqYG62pwAPg1wCKdQKu4sHdL6avJLzOXyDjHvQQxUX7u7e/xgo2ZDcNDAZeD5AmPj
         vF0tjzHj7aT5eWiZQRL1eWk4CwUoZQIzHj5hacYTUIBvpXA/5BvaDA4Vijkbxum20qqT
         YXtD/neG5ILxHKZLEFz/Zeqou/ztoD86niwSsDWWejlc9ho3mfxUahrz0HJiV08storx
         pdFaebv1B45e0+1k1WnpLJcvDqM+9bc85atB5dQwPBHOZ5V/do/Pg/Z4QUcp/JEpZB+E
         MDhpVJ2i6Je1p8KTkuDTUFslioSoG59tAJvyrl1O7CuLJNke3wfZgKadwJh3TpY6p/fn
         Q03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853113; x=1779457913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xZrGgRDaGVqySYoubClm2QP08yGTEdoXS4C6fMI9nE=;
        b=koS93McQorhWxgt/1GaTH9CJBPDUuYTmk5XlHqBahV/RaKCMKwC5oa53BMuqz2O0Qr
         U7BtrU437/ezjOh1dum6iRJgnpbzNfaDGYoXc1Ex+vCYiDwG9RZC/9ctsGhBFf5R1dyB
         m/Dsl63ykWpXdsrJj/bSTK+UgzdQPZt+bLmlWcjH0YnMoeeiUXGTd9Tsd34rW0he4Q4H
         d5dKeHfwJsgdrEVp81+JdNgrSohO+wj1e3HMzi0Mzc4k7+NV6SPtrIAprdU4tquaUc56
         mLR5wG7E/aa9IkNYR6ATlmdbO2SjC+wv8j0RnZd5wPhIrBhnykuDDddrdjWEWvJ6nwr/
         GMHw==
X-Forwarded-Encrypted: i=1; AFNElJ+rt/NCl1nvfb/7JnClCDbdaUiEx7244+Z0xA8TocWqW8beAUUhffNpnqgDoROYZVkWUTBGl0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCUfk2A+e7X8sDdiPJ/T317Gbe724ZDnfSVgKyAA/2sJbB77w
	ORdKvMkTxxMlHBKxzZ+5n0xZ4rknFYdMjPErwgNbV3RvirbqeJfNeh+fsFkOle5jRDE=
X-Gm-Gg: Acq92OFDVDBRlYirFsD6x3WIVnrWlvk09o5koVn1KmzOHkDjg6YgtUAB1dvesikwRD8
	wNAO0onsIQ/byzDCpGXrRjPSRXZ4vBkC6rUx5vf6wcn3zBNVwkGZ45rtBruXIiMU67dLXc6KJUr
	fGuYyWzrAvW2J7PlMAABmd2NofZ6mSYIsxcNWmQ0kpo1Ja0yiSOzK2Hyijx0i/09NUmsVy/jpcI
	AEE7d/x912H4JsO8l5WnNmkVBj0+fCN+ruUEsUep8kJRPkqZFgBAkKV8UXtSwxsKAABYgMOuf1i
	Eg1GppmODY8djgyIGS54FExwkl+iuXtvyVeNYh/N+dkQYUwwBS6uIGkRvJPrtBNeVxCTAzPtmDY
	TYi4VpyZJ7zgkiNYWLr1DlIIrMiBJYtNi8+SEMk32febPPoYtUHAPJNNR6sw09AG7ZHRxcl1gyL
	bJnLm5LBJQHv2hwpjcI+UVHYFGPcbyEDF5ERpsC/cqXO3HnjeFk053o/FIhQ==
X-Received: by 2002:a05:600c:3104:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fe651b57fmr53453825e9.27.1778853112877;
        Fri, 15 May 2026 06:51:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdafc6741sm79592675e9.2.2026.05.15.06.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:51:52 -0700 (PDT)
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
Subject: [PATCH v2 net-next 0/2] net: Replace system_unbound_wq with system_dfl_wq
Date: Fri, 15 May 2026 15:51:35 +0200
Message-ID: <20260515135143.259669-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8306550F28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,strlen.de,nvidia.com,ssi.bg,netfilter.org,nwl.cc];
	TAGGED_FROM(0.00)[bounces-288320-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

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

1) [P 1] Replace uses of system_unbound_wq with system_dfl_wq

2) [P 2] Replace uses of system_unbound_wq with system_dfl_long_wq

No behavioral changes are introduced.

Thanks!

Marco Crivellari (2):
  ipmr: Replace use of system_unbound_wq with system_dfl_wq
  ipvs: Replace use of system_unbound_wq with system_dfl_long_wq

 net/ipv4/ipmr_base.c            |  2 +-
 net/netfilter/ipvs/ip_vs_conn.c |  4 ++--
 net/netfilter/ipvs/ip_vs_ctl.c  | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.54.0


