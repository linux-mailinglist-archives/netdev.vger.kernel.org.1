Return-Path: <netdev+bounces-307670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EqQ5CAglV2qJFwEAu9opvQ
	(envelope-from <netdev+bounces-307670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:13:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6275AE00
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:13:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=koTyQ5rO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307670-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307670-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D134E3010BBB
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 06:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E8333DEE5;
	Wed, 15 Jul 2026 06:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EC3909B9
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:13:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095987; cv=none; b=quQxiUtbBe+uM8JY1nuQgoMnxSMtblCZX/odCXLiMsAV5CUyp55USe7w+fuDR6EGq6mWhOe+1zJwATlIR8QXCJ43e/fnrtREm8b7GxiPadXo8iUtI4X7KqK02iGpxh7z7aAJY+XNSOY3zLYT0TaBHZtnehEcv8H4k6gHJGL7fvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095987; c=relaxed/simple;
	bh=3s/qCey1Oq93zdllqNccu7JHWUZm5oKkLoh8sy2O434=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KV/kcDMC4N+6k3zTAp5U3nzetovcmn7QzjZP7uD4RVxkevOl38bvANDJG/1EIkGyHtewr0WYBs9y+Bu33GS0urc7Cnvnaxx/t97llCRxygiFzaBMLrHBFevruguZ/dyTHlx4NJZ3wDD1MuDffyM47GEVGc0oIBP+mSH/PdOhw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=koTyQ5rO; arc=none smtp.client-ip=95.215.58.177
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784095983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RWpJTHJ8TyXGkDWqsB7xYyZHeqa3pjiQY10iz6i5Vhg=;
	b=koTyQ5rODfYlsV3CszwR0yZKArLEfwxG/IevGon6Bq25lCYwM5e+ehyL8vIXm0qwyLmbWN
	Nhbb7dCPR7giThL5KIzUTOsVo1VYia+rvnwVX1KkZ3/h6lEDvBTKQ0gomvHOeGaX9B28HJ
	wIvmlStPK4t3wI+/wv/xKEYpDL6tJCM=
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH iwl-net v1 0/2] iavf: fix two memory leaks
Date: Wed, 15 Jul 2026 14:11:29 +0800
Message-ID: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307670-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:andrew+netdev@lunn.ch,m:mitch.a.williams@intel.com,m:gregory.v.rose@intel.com,m:sudheer.mogilappagari@intel.com,m:netdev@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32C6275AE00

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

This series fixes two memory leaks found by inspection in iavf. Release
the ASQ command buffer when initialization fails and the QoS capabilities
buffer when the device is removed.

Xuanqiang Luo (2):
  iavf: fix ASQ command buffer leak on init failure
  iavf: fix QoS capabilities memory leak

 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 1 +
 2 files changed, 2 insertions(+)


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.43.0

