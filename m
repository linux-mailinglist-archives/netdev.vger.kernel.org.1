Return-Path: <netdev+bounces-272181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFzALJtyxWkU+QQAu9opvQ
	(envelope-from <netdev+bounces-272181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:53:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5139F33987C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18646309EAAB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F403A4509;
	Thu, 26 Mar 2026 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C4BS8Uyq"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2F41C30B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547202; cv=none; b=kuUOQUDmwxp84OFTxVfUz0I2pxwrhuK7bJzcwSkZNAiH7+E6SB9h2w4SDlRX3DMdV6fOwvu/mv9a21Ju9nVEZCtJTDAQI/I6ujBx6TK7Vda/HUrI5pKeoHWf3GFhcK+AFV75j5JcfK9iB+FHuTk+U371abKuC/J5XOYwGwxLL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547202; c=relaxed/simple;
	bh=U2Rk1go9BVcJuJ2EEhHc1TGH3yM1ERqWLgCMnpQumYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZBVAnE3W54gOvmQAGI/YPmZ176/hXvGNoqQpVvKAxR1z97cMTfyG7S9dK2Oo0T7jKBbrmKHp0zVW7nUp6eVlV2fKufD0yFPdHRoRChPQBurA2gPqZ+XuEDRKCKwVrocCB9piYMm/kM1Y4G5gL8jdPsS6DgPgSJDzrJ8bJTHrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C4BS8Uyq; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774547186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IDT4pyIhCwz8AX4AEf5QuLYdDUNg/3ZyvF/XHwUhyjw=;
	b=C4BS8UyqMjKT5a3W1vu9ZrMFRDPXnleIQTHjI58434eGtLPBn347tRxENpBAHqWava/0do
	K9sPIIVtFatI1ZdpRqCo96SkYmGbpVj3TkupWQrR2sxFjb6K+b+j0iNbZJosnR6ZELHa/6
	kfD/TcWSeU0XE5/Ads5rbo34s07G3U4=
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
Subject: [PATCH net-next v2 0/2] net: hsr: subsystem cleanups and modernization
Date: Thu, 26 Mar 2026 18:45:58 +0100
Message-ID: <20260326174600.136232-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272181-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5139F33987C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Changes in v2:
 - dropped trivial cleanup-only patches per netdev clean-up policy
 - added AI attribution for cover-letter/commit-message wording only
 - dropped fallthrough/BIT conversion patches per review

This series contains two focused HSR cleanups with practical benefit.
It constifies protocol operation tables and replaces a hardcoded 
function name with __func__ to keep diagnostics correct across 
refactoring.
Assisted-by: Copilot:gpt-5.3-codex (cover-letter/commit-message wording 
only)

Luka Gejak (2):
  net: hsr: constify hsr_ops and prp_ops protocol operation structures
  net: hsr: use __func__ instead of hardcoded function name

 net/hsr/hsr_device.c  | 4 ++--
 net/hsr/hsr_forward.c | 2 +-
 net/hsr/hsr_main.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.53.0


