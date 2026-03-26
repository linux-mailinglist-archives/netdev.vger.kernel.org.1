Return-Path: <netdev+bounces-272122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBl+IKlYxWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:02:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C63380D0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 436EA301FCB4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3D4035B6;
	Thu, 26 Mar 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e8O/u/i/"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FFC402B93
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540065; cv=none; b=mDEYf74LrdsH/IhHtGI3svTnmQuwpav+6rCdf91qndIU7Z41AahozSOREGWYkcc7/Ddfh/z5lXHocFGvwuIqW8jrhAY+rqbkVipjn8ybtVeAcXhcLvKgu+RLMJTe6xK413blBYJaHX91tVmVtjZXL1AD56zBwv/gFad6x9BwWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540065; c=relaxed/simple;
	bh=mX+ILQCrh2iWQ+VacCEqBIu+QA+XAmglkGRX/+XASkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWTAaoAFnAnEhqjddc145RSYEbb09eZ9Iaoor7eNEmpIhpYx/4MYC5JJ90iCX4jtwg1qe23JgwLjrZ5RgzRRScGDrnvW9TEelZHAzQpuvud9Wabd/3iOGe+27lGmHoydNYSoGfAH6eJMaSnuIBZ2YKJ23FjxfDOhltmE/i6XDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e8O/u/i/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774540061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ogmn8aZwDBTrlleNlvMhEW2le1v/geqMTIbGdBvPoy0=;
	b=e8O/u/i/r+77IEnJlzjkedQz1N0UvgAhIoXKHStEAy9zRAZ96GUZVDD/MTQe0qKRNYBVK5
	D0qYLTjcBP7skEjtPa82OVlJ/6wT+KPKNknRczFdsyW85by/uXaGQNloFm0w5NxjlPgic5
	UHW+yUy53JD2OkMkaQqci3S6mDQSzFo=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v2 0/4] net: hsr: address functional and concurrency bugs
Date: Thu, 26 Mar 2026 16:47:11 +0100
Message-ID: <20260326154715.38405-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272122-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: E22C63380D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Changes in v2:
 - picked up Reviewed-by tags on patches 1, 3 and 4
 - changes in patch 2 per advice of Felix Maurer

This series addresses four logic bugs in the HSR/PRP implementation 
identified during a protocol audit.

The primary change resolves a race condition in the node merging path by
implementing address-based lock ordering. This ensures that concurrent
mutations of sequence blocks do not lead to state corruption or  
deadlocks.

Additional fixes include correcting asymmetric VLAN error unwinding,
enforcing strict supervision frame TLV validation, and improving Netlink
error reporting for invalid interlink attributes.

Luka Gejak (4):
  net: hsr: serialize seq_blocks merge across nodes
  net: hsr: fix VLAN add unwind on slave errors
  net: hsr: require valid EOT supervision TLV
  net: hsr: reject unresolved interlink ifindex

 net/hsr/hsr_device.c   | 46 +++++++++++++++++++++++++-----------------
 net/hsr/hsr_forward.c  |  2 +-
 net/hsr/hsr_framereg.c | 38 ++++++++++++++++++++++++++++++++--
 net/hsr/hsr_netlink.c  |  7 ++++++-
 4 files changed, 70 insertions(+), 23 deletions(-)

-- 
2.53.0


