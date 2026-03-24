Return-Path: <netdev+bounces-271099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PdILlChwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:36:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8930A3F0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCB28305E9EB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDE43FE361;
	Tue, 24 Mar 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PWLelmAb"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9D382379
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362931; cv=none; b=T2NcIVTP/9UgqmL9V3/wQyK4Rj7OAerd+hN+0g2FUkFSTojSpQVoLCwkVBynP+qTQbF6RYSvAWdA1TbvaQ5j12cvTOTMH49TmPPUUABaPVrpE4nv7CAuyBhcEqzMJWYuScY3t5FSHGIm6KCQTyyjL6nC+4D+V8k+3wCi3UfTb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362931; c=relaxed/simple;
	bh=81VOhGcHXZyF8zdCvhyo0ZfnwPehL4xyOIFjX3KSt5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xe+EP957BuioeleybwMfO4PW3av0kAb2mSpiSqe+sUTQKyTfRouIafB8/x0mGcuTvpgvJVoSIHOdjuZmiDp+FTMx/v6orqy349xWL73Uoegu4xL/yo2iuoW5//Py3jf9XtNTZEsMvxAYuNOVj0ejUdShdPtMDkFCr+uC0UGmIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PWLelmAb; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774362927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qIgbMiEXTu7RBk9IkhYKoH//hpYhoBi+5ucoYj9R9cM=;
	b=PWLelmAbNZeEwu1bINzpeWD6gTneJ4+kq/79p/2HPSVL2STskQ+gedtT5Qx3wrZP/5eT8r
	3OuCgY8Gvs8cbNOzEcV5PesE4jCaSV2dG84FAMVdnHbEJ3vp1VfQXmQYJIlgIYBPWumB+Z
	Oz8l1sJ98T8ibycoawEakYH2Kg0Y/e4=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 0/4] net: hsr: address functional and concurrency bugs
Date: Tue, 24 Mar 2026 15:34:59 +0100
Message-ID: <20260324143503.187642-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linutronix.de,vger.kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271099-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 6EA8930A3F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

This series addresses four logic-level bugs in the HSR/PRP 
implementation identified during a protocol audit.

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

 net/hsr/hsr_device.c   |  8 ++++++--
 net/hsr/hsr_forward.c  |  2 +-
 net/hsr/hsr_framereg.c | 38 ++++++++++++++++++++++++++++++++++++--
 net/hsr/hsr_netlink.c  |  7 ++++++-
 4 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.53.0


