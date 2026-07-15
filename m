Return-Path: <netdev+bounces-307705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hvlqOKxGV2rwIQEAu9opvQ
	(envelope-from <netdev+bounces-307705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:37:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2143C75BF13
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:37:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=linux.dev header.s=key1 header.b=L6OFFdD7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307705-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307705-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=linux.dev (policy=none);
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670F23010DBE
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6103264E9;
	Wed, 15 Jul 2026 08:27:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8F3CAA51
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:27:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104040; cv=none; b=VsSFILn3e8EchS/q3viIGQH5WsLKMcCdX0vFeeMe2gvATK1zdJCCygjiykBfs1oq4jAmU5Ok5VMDNYxlJqOQGEWE3FGqMwVFj+CDZH8FCTEUWscOmTfPO+J0YGaBZIT1T91ig7umJr9WFjtNyX4WVJJqCJ1wXeV4dbHJ5GF0Bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104040; c=relaxed/simple;
	bh=BnL9n5nc1HHvkHTyWo8BziebfQkfqWKCqTNLPrakQ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAmIwU180pohn/mmTrBgoG3QSSKm5EUSlPyta+IherSyGA0V/b0mvqEMMxw5e04Do1LNZrV3i7uQGZ312lx0JKlv3tmuvQzyRHdxWa+wKVeolZ27dhO7Ecc59CoJDNxncxh3jEV0a7yWX3Iqw8v1MkKVwzHtp61TrOpIA3peB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L6OFFdD7; arc=none smtp.client-ip=95.215.58.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784104036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IQvzwDlyfedqq++oUVQVScJTnk4XMFNZlSdaiPo68EA=;
	b=L6OFFdD7xzHaeR1tD7FeX03tM5T3O+Y5ZtrOyr43D0CkdPnVb+Ckm9dYV00naJW8zMgszr
	SxJfLf0ECh5latFnHck1c1OcM9bv8tu3YyRkgYUs4UKmj/STg5miOLT0R1O81vRMmQ0tg9
	bNWS9DyBHbWnEu75e19EtxqkEp6AKSQ=
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jagielski@web.codeaurora.org, Jedrzej <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH iwl-net v2 0/2] iavf: fix two memory leaks
Date: Wed, 15 Jul 2026 16:25:46 +0800
Message-ID: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[linux.dev:s=key1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.dev : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:Jagielski@web.codeaurora.org,m:jedrzej.jagielski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:andrew+netdev@lunn.ch,m:mitch.a.williams@intel.com,m:gregory.v.rose@intel.com,m:sudheer.mogilappagari@intel.com,m:netdev@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2143C75BF13

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

This series fixes two memory leaks found by inspection in iavf. Release
the ASQ command buffer when initialization fails and the QoS capabilities
buffer when the device is removed.

---
Changes:
v2:
  Patch1:
  - Move the ASQ command buffer cleanup into iavf_free_adminq_asq() to
    pair it with iavf_alloc_adminq_asq_ring(). (Suggested by Jedrzej.)

v1: https://lore.kernel.org/all/20260715061131.34420-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (2):
  iavf: fix ASQ command buffer leak on init failure
  iavf: fix QoS capabilities memory leak

 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 1 +
 2 files changed, 2 insertions(+)


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.43.0

