Return-Path: <netdev+bounces-306401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sYt7JmVIUGpEwAIAu9opvQ
	(envelope-from <netdev+bounces-306401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 03:18:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 801087367DA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 03:18:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=kq7kcw7K;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306401-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306401-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E615E3017527
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693492F8EB3;
	Fri, 10 Jul 2026 01:18:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCFD2F6184
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 01:18:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783646305; cv=none; b=kXnrvMjcekpv1wJDHPLOfABfBDvIbn1nk0zW+fx/RiI5qA3aseIVs0lMjd3aeXAiy/tZkSUV6PSEgD7j6g/In10VMe/qGbuJWPgVQeXw08EoiBpF1/9EYg8Js13YwE7q7OCCGbEqUl0PN9nkrKxvkjpvwOEuxZdODSS1rO7jeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783646305; c=relaxed/simple;
	bh=KcZ7kb032dm7LsVMPNALHhb3NlGbqCd1EM6xN7A7q1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfR0Gd3fcAtqcKFULTPN7Cb1bkXOnnvbQsg4aBplVYTKa1KgcthCZJQgC2iiUae9yCMjhJ6VxT87swLwqa2qOZ5rOy1tjnwLR3y9Q+VyTpt+dY1cX9Dbz0LY5Oj5sfurwnk1SY2b9Rsk1egyGCfTEPL2T6+mEjI1JdvJsz8wYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kq7kcw7K; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783646298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r5pSf5Af22QGyjixoYkd7KHTq4uqLa/w2mYECvbCsV8=;
	b=kq7kcw7K6EMK7bdAHmTVu6GpxCTxAlg+1FffswiQ+cWGk7YhFANBSKlLxztnoGuELQSMca
	mFHejeREZo7xknDEcf+8++MoPXQ5VKDcDbqg1ZCa+jktfWkv1u4nfWnCCa5YfK3/T/OMfo
	XOGfjdbVWnGWJRe8zhfSVOi/NfeLcds=
From: Tao Cui <cui.tao@linux.dev>
To: dsahern@kernel.org,
	leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH iproute2-next v5 0/2] rdma: display resource limits in curr/max format
Date: Fri, 10 Jul 2026 09:17:57 +0800
Message-ID: <20260710011759.378893-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-306401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cui.tao@linux.dev,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 801087367DA

From: Tao Cui <cuitao@kylinos.cn>

This series adds support for displaying RDMA device resource limits in
curr/max format in the rdma tool, building on the kernel uapi attribute
RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX which has landed in linux-next
(kernel commit 5911f6d6e7ce [1]).

Patch 1 syncs the rdma_netlink.h uapi header from the kernel.
Patch 2 updates the rdma tool to parse the new attribute and display
resource usage in curr/max format:

  $ rdma resource show
  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768

[1]: 
Link: https://lore.kernel.org/all/20260615003646.168704-1-cui.tao@linux.dev/

Tao Cui (2):
  rdma: update uapi headers
  rdma: display resource limits in curr/max format

 rdma/include/uapi/rdma/rdma_netlink.h |  5 +++++
 rdma/res.c                            | 21 ++++++++++++++++++++-
 rdma/utils.c                          |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

---
Changes in v5:
- Split the rdma_netlink.h update into its own commit following the
  uapi headers sync format ("rdma: update uapi headers").
Changes in v4:
- Add a Link: reference to the kernel patch; re-send now that the
  kernel side has landed in linux-next.
-- 
2.43.0


