Return-Path: <netdev+bounces-300806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCLACgyENmokAwcAu9opvQ
	(envelope-from <netdev+bounces-300806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 14:14:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7B6A8DD7
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 14:14:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=icloud.com header.s=1a1hai header.b=k1FV5e9f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300806-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300806-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=icloud.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EF85300620D
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E292DC32C;
	Sat, 20 Jun 2026 12:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2002k-snip4-6.eps.apple.com [57.103.87.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A91190473
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 12:13:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781957637; cv=none; b=dymHgyTuCywUZL0P6eWtL9W5wUH1eZLZk0supMY1MVxJV43fEOYdnRZB1wm+1Pp87dShlm4qp8bZwgznO6tkSEAbOtZJULYo4Apu76COEnsJtYsPDWUYv2YwvUOOWppEz7hfC1VrBGcrvLWWIxaXGFk+Gzx5J4q6u5igkSI3KGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781957637; c=relaxed/simple;
	bh=aeRCG9IbJCYM/pLLbDklq0PuQs1TcxJY82pk0IPGOaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/8OlFcnEC9zUvAjXGvaMNaJhr276jVMQidJSQLwUnQhIqzyo2cvoOAv4J8WEPESk1qc2z2c07Dzfdd0+sj4Op3ijlqeX3oWqOdZEuLwrXdeY/Cy8+BDvIrsF+hHxLrs+uPgoH03hy+2Qq2ue80HqUv2N3Fe4BnHhWFdtCeIAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=k1FV5e9f; arc=none smtp.client-ip=57.103.87.237
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPS id D0AF9300017A;
	Sat, 20 Jun 2026 12:13:51 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYLWxcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUKTV8OXh8EF0YZVQRHHl1WQh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD18HWQRAD0oDXAVaAUIIVgdYBVkFXQhVQARTD1oRSwxbDl4JWzBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781957635; x=1784549635; bh=SaO0TQnbwTAbu9emSwCT5mBn4ilASYCmpin95gfilp4=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=k1FV5e9f6BDlf6nI50sDjBVADxNC6Pz3mFN6NeH4nx5UufLAaMRMBqMAMJsjfcrXkxU6zLlm6htC9uS78vMmQ0ytSgnxr2fRgXWyQWdjWAecjPbdI43UkdUWl9AbDhU5/Tk39qFUFHWUYQJv3ITVXGHt6mS63VtBuXxU2nAXjBS6apbRnwvcPkbKpuSrEUXqSK7pKJsNOarorjVlVTHHmDxTjPx8TicBFXIEK3ScQLB0q+S/SBS0icYbIi1GSTHf0GCdHGPKakDPRRjwbWlbv7vkBekq0PTLwINeYceN0bb3GhZo2oQXiJBNcmKnIUNHCQurCfh+CLCNffTq9otABg==
Received: from cibi (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPSA id 12F463000179;
	Sat, 20 Jun 2026 12:13:46 +0000 (UTC)
From: Siddharth C <siddharthcibi@icloud.com>
To: ast@kernel.org,
	kuba@kernel.org,
	hawk@kernel.org,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Siddharth C <siddharthcibi@icloud.com>
Subject: 
Date: Sat, 20 Jun 2026 12:13:12 +0000
Message-ID: <20260620121321.45227-1-siddharthcibi@icloud.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: op2Efvtf60g00WP6aSZVh7xoob9iGw7B
X-Proofpoint-GUID: op2Efvtf60g00WP6aSZVh7xoob9iGw7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDEyMSBTYWx0ZWRfX7u+BgaOek0wq
 9vqprgTUg2wDJwOUdOSynKkyHLga9jkJSreJ4xI80CJ1FYFr6oFrGz7XChxYseN2PUX012z2KQJ
 P2OtMSm0Gp6fpFro+N0x5NT5fNXKQC7zLOhx3+IgId54CVH1zXt3i4A6n1si+RTtysUBFDVNqYq
 mHQKZ9tcJidbXB+7zgPO3GNObVd7nqVHkdm7jmJ/Qcb8GzldOU2inFStRIARwwsrBNy4Giv5zOD
 4au6WisL/vA/NOaEnKz9+QmaZSvHlCKWJ80iHX7Da44upapve8oWH/XgwCkrJ9dtmowBbRpcXRY
 MNO/utzQtTSAAG/sBkW
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	EMPTY_SUBJECT(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:siddharthcibi@icloud.com,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[icloud.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,icloud.com:dkim,icloud.com:mid,icloud.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15E7B6A8DD7

Subject: [PATCH 0/2] bpf: preserve rx_queue_index across XDP redirects

XDP programs executed after redirect through cpumap and devmap
currently lose ingress RX queue information because rx_queue_index
is not preserved across xdp_buff to xdp_frame conversion.

Preserve rx_queue_index in struct xdp_frame and restore it when
rebuilding xdp_rxq_info for redirected execution paths.

Add a selftest validating that ctx->rx_queue_index remains available
through redirected execution.

Testing:
* Built modified kernel objects
* Ran tools/testing/selftests/bpf/test_progs -t xdp_metadata -v
* Verified xdp_metadata passes
* Added explicit rx_queue_index assertion


Siddharth C (1):
  bpf: preserve rx_queue_index across XDP redirects

Siddharth_Cibi (1):
  selftests/bpf: validate rx_queue_index in xdp_metadata

 include/net/xdp.h                                     | 2 ++
 kernel/bpf/cpumap.c                                   | 2 +-
 kernel/bpf/devmap.c                                   | 5 ++++-
 net/core/xdp.c                                        | 1 +
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 ++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 +-
 tools/testing/selftests/bpf/xdp_metadata.h            | 1 +
 7 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.53.0


