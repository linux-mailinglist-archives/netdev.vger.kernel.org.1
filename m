Return-Path: <netdev+bounces-262135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A4fIxH6omkZ8gQAu9opvQ
	(envelope-from <netdev+bounces-262135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A91C38A8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00C6310F031
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FD392811;
	Sat, 28 Feb 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f5tGin5i"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297F371048
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772288450; cv=none; b=Nxa3jTGthnzyK2yxDw5jUVUpp96JBE5XnvyZoY3QdEW5fMasH61J4/+/fAPUfVcrtNkG09sQIdiAczs8VlaAP6Lt2njlKIblFguejT8ox0zwyKiCrgTXhOmzmVtkEPW0PKptYbvGNlv1yHv9fBCNnGPoiznRYtf/0P6JHr0yooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772288450; c=relaxed/simple;
	bh=dKGoRK0khX66iE1X2O4AAX9o0uorB+HOAo34WYqi7Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stLdy1GOO7FYu5j6elk2QUxlOxQZossPoe8ahAzMddNB7SNhDWz3D18KSwZSx+yMtdZplUqGFn21eSu1G+MU8mBdfa8vwH6x3bDEYs/SZExwhLc2tTt+cuk5Cmb4AZBoF1t4ZR7U+ZD4KFr0tzr3Eblni4/083FPvYSs965/wE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f5tGin5i; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772288437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ploXD4qKyGErpi2h+6GFoldO2iGJIFZ6IgaMbXbP9Uw=;
	b=f5tGin5iSOmhU2iID2/zFOti5Z8DzbJC7ulhLGGryEYrVJ++a2+qy9DKv3a8kQy4Q2iYVs
	KtKhbGs8LIa3HSygX7IhUZK2Cva97yzJo4GguhIbLbtG/zA5s3+Vt5Q+IN+FrwN2ljAvBS
	CbREK2Lrc78F+xacxiniKL0yMMXXEfQ=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Daniel Sedlak <daniel.sedlak@cdn77.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] cgroup: improve cgroup_file_notify() scalability
Date: Sat, 28 Feb 2026 06:20:15 -0800
Message-ID: <20260228142018.3178529-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262135-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: C71A91C38A8
X-Rspamd-Action: no action

Jakub Kicinski reported that after the commit d929525c2e30 ("memcg:
net: track network throttling due to memcg memory pressure"), in
Meta fleet, the network intensive workloads started seeing extensive
spinlock contention in the rx path in the function
cgroup_file_notify().

cgroup_file_notify() uses a single global spinlock to protect the
cfile->kn pointer across all cgroups.  On systems with many cgroups
under memory pressure, this becomes a bottleneck as multiple CPUs in
reclaim call __memcg_memory_event(), which walks the cgroup hierarchy
calling cgroup_file_notify() at each level -- all serialized on the
same lock.

This series reduces the lock hold time by moving kernfs_notify()
outside the critical section, adds lockless fast-path checks to avoid
the lock entirely in common cases (torn-down files and rate-limited
bursts), and replaces the global lock with a per-cgroup_file lock to
eliminate cross-cgroup contention.

Shakeel Butt (3):
  cgroup: reduce cgroup_file_kn_lock hold time in cgroup_file_notify()
  cgroup: add lockless fast-path checks to cgroup_file_notify()
  cgroup: replace global cgroup_file_kn_lock with per-cgroup_file lock

 include/linux/cgroup-defs.h |  1 +
 kernel/cgroup/cgroup.c      | 50 +++++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 22 deletions(-)

-- 
2.47.3


