Return-Path: <netdev+bounces-288186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGvIHaCpBmq8mAIAu9opvQ
	(envelope-from <netdev+bounces-288186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:05:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE4549644
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 749C2301484F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 05:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9E3DCDA2;
	Fri, 15 May 2026 05:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA1cU1jG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FE356764
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821530; cv=none; b=kM46G7Ye6M9ifLWhUWqYQlQJioWib2ReikVn7XKIvUFAis5ox54cY20gpWHX7avHQgktGSm0KYuKJzvIcJR6MAEVDp63idvqiKT6RbuuOIMm7PppQSf2VqiKLHBtSAuwvmYnrbrAyZBcWLmpdHtgdE92nC9OAxSvJOlXZG+pOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821530; c=relaxed/simple;
	bh=jekx5lE2mdrCcppdU6M6DAKIW6FzIJoRBoEUNcts1dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AxhAdy4XOx0CRtloggpRFFvozqj196/HuqZqhyhlX8tU6OoUIl559JIqb4o4g0qVT6QTmvELROmbYbAxXOpLjuV/m5pMW/6GEkrr0GXD1MZWjrVz06E0wKDlP7WL33qqkD3dc5fCECVGzOuRAE866WsLrG1AEKVK3f0t5OWO4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA1cU1jG; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-366139223e4so5325152a91.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821528; x=1779426328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mRMHbhwrF0T6A/xFTOvfROoIDN2E/QbJJf71F9Y5tjg=;
        b=YA1cU1jGz5uodXGhq1VgdUEUu0GagNQUr+JmioewTjPeH8I+1IQUMsQofXsDJ4vXrs
         ndnJlgZiJFSHuawl2rmQq+9O+7Ad4ceyeBIByd2P63FYHEOWD1F9vOcWmkHtnYzvnzdZ
         qnznp7ushqYbRhdsbtQBhpnnkKpV5QdHOOwQ1HVqnXmVfUCfg2Wb+tIDLSfgmiGVZaqf
         2nflF2rUti3VzxQYruJqF6CuovdA/DHuxBO5Qo9VjC3DpwgpeiTB/qVIpJxV0sgSWOcc
         w3P2q41eaM+3O6w5Q+frmnwi/fyQ72gmw1IfaF75CpopgYUerXFcvoVZq5dS4AFkrioI
         8Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821528; x=1779426328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRMHbhwrF0T6A/xFTOvfROoIDN2E/QbJJf71F9Y5tjg=;
        b=plKDmxhXLwS06U1dPFeD2MK+pIuGE6Y4PtSopQYmAdxOUpAVlW449S+bTe3L47PDaw
         wDgdoFtveNdXJpx7YZRC+uRIlPqf71u2go25PrSnkAwQKj9LDuMv6S5RrlL6z7WGKPWj
         BQ0WUqIFwbhG8pP0czbTnTrLyllyn83tyfzpWpNu8CBSdOn2Y6ShISI8IGYW3AQEMTZQ
         gdg6u3KvKiJ6lygm86OA6ya+d6FFmWDtx8FhidqFy/BONqZBkxqnszCdAM1vn3oFrnD0
         WOR4wvBMG8A0Hu8f0SMh3e5E3rjdzbF6enF1xknbD15/9U83Uety71PFarqZqq3k6z4Q
         Bc+w==
X-Gm-Message-State: AOJu0Yw7XlsFeRP4+dLVhF7h6zq2tDCOJZ59Nj3BpJ/M4Lob1nrqeZRz
	Nal0Sc2GJt9yum+pEhwu+yz6xvqhMtK5vXUlI0bYmoIQgCpJlr8SqzOdgdMJ1FdDy08=
X-Gm-Gg: Acq92OGIQnUnboCmUPEZGxFWAnUTJs4x6RQmWuL/zazbV9PXEozWUTtORbg5taQOGWN
	T1pjg39OaURNMejsGUuvvcGmVz1i5GiMvI77jFnNYc5CoofW2gbySS9UuaqAU2krBXCA0NezlOl
	nF/9AnaSci0HU42+oGGc75rdkDLXUOHlg7nofYwR1IKNIlgNWxNUyfUwxA52HsV8zaCh5Q3gw5o
	nhxruYIWV8xbruH78T8AI2H6uXJOLZfJqEj0CzDay6vmTjvbEqTOZWgNLwBfFW7bRQumNRA0EBf
	gko5ctYFsgEHKOew2MRls7hrQkd8wedX8kMeZ7m9XKxxgG3LVXR8JJ+LdkJUOWVqDg6vd99T+Wk
	WBPZVwwL7WWPsrclZqO3+rYmOfpQ4fu47HS7kY4zi9R3/2VfuUWIwK/o+Gi0sIgHSYCJiNHrVb2
	B1uhfpfE070wZqRj2vURk4CEQ7qGU7BR6zumXL95Q1uw==
X-Received: by 2002:a17:90b:3505:b0:366:aba:4c86 with SMTP id 98e67ed59e1d1-36951dd5abemr2320416a91.27.1778821528123;
        Thu, 14 May 2026 22:05:28 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369515895d2sm1318167a91.8.2026.05.14.22.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:05:27 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH] netpoll: normalize skb->dev to the netpoll device
Date: Fri, 15 May 2026 13:05:11 +0800
Message-Id: <20260515050511.106309-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72DE4549644
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288186-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

__netpoll_send_skb() always transmits through np->dev and queues busy
packets on np->dev->npinfo->txq, but it leaves skb->dev unchanged.
Stacked callers such as DSA and macvlan can reach netpoll with skb->dev
still naming the upper device while np->dev is the lower device that
owns the netpoll state.

If the skb has to be deferred, queue_process() later dequeues it from
the lower device's txq but retries it through skb->dev. That can
re-enter the upper ndo_start_xmit path on an already transformed skb,
and if the upper device disappears before the lower txq drains the
workqueue can dereference a stale skb->dev pointer.

The buggy scenario involves two paths, with each column showing the
order within that path:

path A label: netpoll enqueue path   path B label: upper-device teardown
1. A stacked ndo_start_xmit calls    1. Another task unregisters the
   netpoll_send_skb() on a lower        upper stacked net_device while
   device netpoll instance.            the lower npinfo stays alive.
2. __netpoll_send_skb() uses        2. free_netdev() releases the upper
   np->dev and queues the skb on       device.
   np->dev->npinfo->txq.
3. The queued skb still keeps       3. The lower txq still owns the
   skb->dev pointing at the upper      deferred skb.
   device.
4. queue_process() later dequeues   4. queue_process() dereferences
   from the lower txq and retries      that stale upper skb->dev.
   via skb->dev.

Normalize skb->dev to np->dev before the direct transmit attempt and
before any fallback enqueue. This keeps both the immediate and deferred
netpoll paths in the same device and queue domain that already owns
npinfo->txq.

Sanitizer validation reported:
KASAN slab-use-after-free in queue_process()
Read of size 8
Call trace:
  dump_stack_lvl() (?:?)
  print_report() (?:?)
  srso_alias_return_thunk() (arch/x86/include/asm/nospec-branch.h:375)
  __virt_addr_valid() (?:?)
  kasan_complete_mode_report_info() (?:?)
  kasan_report() (?:?)
  queue_process() (net/core/netpoll.c:88)
  kasan_check_range() (?:?)
  __kasan_check_read() (?:?)
  process_one_work() (kernel/workqueue.c:3200)
  assign_work() (kernel/workqueue.c:1201)
  worker_thread() (?:?)
  kthread() (?:?)
  ret_from_fork() (?:?)
  __switch_to() (?:?)
  __switch_to_asm() (arch/x86/include/asm/switch_to.h:9)
  ret_from_fork_asm() (?:?)
  kasan_save_stack() (mm/kasan/common.c:52)
  kasan_save_track() (mm/kasan/common.c:74)
  kasan_save_free_info() (?:?)
  __kasan_slab_free() (?:?)
  kfree() (?:?)
  kvfree() (mm/slub.c:6876)
  netdev_release() (net/core/net-sysfs.c:2227)
  device_release() (?:?)
  kobject_put() (lib/kobject.c:730)
  put_device() (drivers/base/core.c:3810)
  free_netdev() (net/core/dev.c:12164)
  full_proxy_write() (?:?)
  vfs_write() (fs/read_write.c:668)
  ksys_write() (fs/read_write.c:729)
  __x64_sys_write() (?:?)
  x64_sys_call() (arch/x86/entry/syscall_64.c:35)
  do_syscall_64() (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe() (?:?)

Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

---
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -319,6 +319,8 @@
 	lockdep_assert_irqs_disabled();
 
 	dev = np->dev;
+	/* npinfo->txq belongs to np->dev, so retries must stay bound to it. */
+	skb->dev = dev;
 	rcu_read_lock();
 	npinfo = rcu_dereference_bh(dev->npinfo);
 

