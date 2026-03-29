Return-Path: <netdev+bounces-272876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K73G8gLyWkHtwUAu9opvQ
	(envelope-from <netdev+bounces-272876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:23:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB15351C86
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8DCC3006B49
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B935B65F;
	Sun, 29 Mar 2026 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G5W1ULz3"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDF1EF09B
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783419; cv=none; b=bWb3jCxgJA5ClDiV0gfICYB22r2yPgsC91KFQ2d8q3fgyL+LCh8H+vZyFldQq0FJLO/prYiUAwEvzBYOYpmLLr3TfmZeCBRmMYIKqtpUHKyI/4R8KOCELtDS6cgdUUPzmYHpcafI75VC1Lz9aByagcwhRB+6ugDfRl3mQKWyQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783419; c=relaxed/simple;
	bh=3vK9/tBbRSldHkPs25YpfNuwM2slJNpwAvZdy8f51+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k16BPMvcHVlnOIIMh7w2iAbAJkf1VeCh69ZxAIZneCE8ldU7q/i4jtseXZ2TIkCPUDO8caF2kxazKS8AjesGy/UIcWpSsXB7Zmxr73GkbU6WNbdhUKhilzC2Um7VncumkznfeRwsz1WbNrDM2cne0i7ZjrlZPJd3X90A1pEBJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G5W1ULz3; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774783414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iiblowTcFud3mo8vGOdHH4Nz2g6KancUksIrQIRD5eU=;
	b=G5W1ULz311CmkDuQZlS0xlUPQZ2Q7WiwZAGlpGNEShsaKi9fV2c8hf9U4LfB22Gc8YZktf
	eIDQdTf/ci2rQf2AIGGJ7Td618RDyPsK6EOtXeIb3CVLJJPiSO4xAyW/gpkNsorj6cQS1j
	/6BC9BaddqP0P1RaqwjZQK1iYu9u+aA=
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
Subject: [PATCH net-next v3 0/4] net: hsr: address functional and concurrency bugs
Date: Sun, 29 Mar 2026 13:23:09 +0200
Message-ID: <20260329112313.17164-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272876-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BB15351C86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Changes in v3:
 - addressed Felix review feedback in the VLAN add unwind fix
 - removed the superfluous empty line

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

 net/hsr/hsr_device.c   | 32 +++++++++++++++++---------------
 net/hsr/hsr_forward.c  |  2 +-
 net/hsr/hsr_framereg.c | 38 ++++++++++++++++++++++++++++++++++++--
 net/hsr/hsr_netlink.c  |  7 ++++++-
 4 files changed, 60 insertions(+), 19 deletions(-)

-- 
2.53.0


