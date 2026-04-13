Return-Path: <netdev+bounces-278029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBTkDM3H3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:39:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 815BE3EAB9D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9E0D302E316
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223A34029E;
	Mon, 13 Apr 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cBGtahUB"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C581A08A3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076521; cv=none; b=RYmVlQexzuPr8thy/EFVpTFeaox90fH5JQaJ58fS0iVmN8Md887j+DSAcvIOJUBnS9z6DWFIptrqRlA0gVfQgk26ZsDdMg0Hkk64hAuFDlR0Y8IQqtQUi53jwXDFTuQwtACdNYVg5A4EqLwQHn/dqMIW5pW8DC+wUHbwxlWbujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076521; c=relaxed/simple;
	bh=MJMGlFoHmOgcTF0m9x8IW19F5KeEe1oKZKbG+3Z0pYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qu7YPeTULE2AmkiIyu6qhNcjO6rjJ58B5O2yhKjGVlIr312zU3X1zfF51Z7EJyV6DEXJSU24pZjipjK6ehXNzsEEE+yL7GQnsjX6Wvm/JwbQ4qj5UCHITEVKEo8yZYZmMnGnbunmRlh8uPApOae4cnT97XJvB4EKNHl+yzvZwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cBGtahUB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776076517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8oOYZXHA0JcJjaaCeyKcKCUwn5KT7rWJLc2/kdQ/QYU=;
	b=cBGtahUB9JvQdavLXYLl6yKIP4zL7hs4t4zWLk115kphFJX+JPoZUB0HdZrwobVofwKn+/
	8EeY9KcjsAjZruizN/Urfmz6mpXIL6NrpLHpEZD+whhsKyFiPMAh8eQgPqYQaq0VvlxfEs
	SWfjh+CHKUyrDYaNGG4oFTsMbbeuKLY=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v6 0/2] net: hsr: strict supervision TLV validation
Date: Mon, 13 Apr 2026 12:34:47 +0200
Message-ID: <20260413103449.169913-1-luka.gejak@linux.dev>
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
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278029-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 815BE3EAB9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Changes in v6:
 - Dropped capitalization comment changes per request of Jakub Kicinski

Changes in v5:
 - Reverted TLV loop in Patch 1 to strict sequential parsing per IEC
   62439-3.
 - Retained pskb_may_pull() logic to ensure memory safety for TLV
   headers.
 - Dropped Reviewed-by from Patch 1 due to the logic evolving since
   original review.
 - Added Assisted-by tag for AI-aided translation and formatting to
   both patches.

Changes in v4:
 - Split from a 4-patch series into 'net' and 'net-next' as requested.
 - Implemented a TLV walker in Patch 1 to correctly handle extension
   TLVs and avoid regressions on paged frames/non-linearized skbs.
 - Corrected pskb_may_pull() logic to include the TLV header size.

History of pre-separation series (v1-v3):
Changes in v3:
 - addressed Felix review feedback in the VLAN add unwind fix
 - removed the superfluous empty line

Changes in v2:
 - picked up Reviewed-by tags on patches 1, 3 and 4
 - changes in patch 2 per advice of Felix Maurer

Luka Gejak (2):
  net: hsr: require valid EOT supervision TLV
  net: hsr: reject unresolved interlink ifindex

 net/hsr/hsr_forward.c | 6 +++---
 net/hsr/hsr_netlink.c | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.53.0


