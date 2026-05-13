Return-Path: <netdev+bounces-287703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLXIBjrEBGoxNwIAu9opvQ
	(envelope-from <netdev+bounces-287703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:34:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BA539060
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A2E3056611
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17325388E77;
	Wed, 13 May 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k9FOsbID"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE33A872A
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696850; cv=none; b=ftwbaBMfvn5bVPs2kmCDdxvg5eisZDpDWC4WGMTXy09j8cJEr3nGs+znDmGhY6iPqbqXnLK7bCPnOm/mbq0V3iwe9zZ6NZPmmoICG8JLHv357WMYHrYHd+rncOtuf+IQhT6zq+EU4H5HcH8zmInqN3JTaPn/8fA+Ze+Xngm4wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696850; c=relaxed/simple;
	bh=MJMGlFoHmOgcTF0m9x8IW19F5KeEe1oKZKbG+3Z0pYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVEoF3lbSdfqEtvGnZY6bRCYJMAcrpK0sxuSm+aOlTNK0Ncp7cQKJ27jklHrj1xyZkOXJwWBH3enBaGKATVzLpyWC4WzEpjvafjnkzUVKtVxM7Fh6TioIk6ASpvcUgJ/gaielcrLXmweYH3zwpvNK9MU0apMluQPhnd4RemnV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k9FOsbID; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778696846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8oOYZXHA0JcJjaaCeyKcKCUwn5KT7rWJLc2/kdQ/QYU=;
	b=k9FOsbID8tv+JTAGj/iBFG333ogH0EFRAnwxRK4ySndZnvuiRC8Y/5ms4E5meDp3JsgeR4
	5FaRUc3rljN5c9rHZ/uhW6Hz1lx1eiYH4muUKmmqio7nhcGTRc6A+XLDiuEoc0T11606/S
	ouPay58S4Hr+MqmQ5xvHUMzv2Ds0f3A=
From: luka.gejak@linux.dev
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fmaurer@redhat.com,
	luka.gejak@linux.dev
Subject: [PATCH net-next v6 0/2] net: hsr: strict supervision TLV validation
Date: Wed, 13 May 2026 20:26:55 +0200
Message-ID: <20260513182657.20346-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 670BA539060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-287703-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


