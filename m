Return-Path: <netdev+bounces-279009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LhIBfTG4GmjlwAAu9opvQ
	(envelope-from <netdev+bounces-279009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:24:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B540D552
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F6DB30106B1
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639D53A75A6;
	Thu, 16 Apr 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cRkm60GB"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD339B964
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338666; cv=none; b=iASmEZLgnF5qnT0uNkU2hMrPQwuPavt6YINBBiFaZFCVv+zdt40dxQlFlJrudLcLCIj3bLqUN1tIbUZvwEZ8YbMhB9noIvu+8JAJY92rKYJCFkeSTw+q+Ru1ZCLCbiGpd27K0DCqzc3A+QZ40/xGE1j2VhvISN8nfuirQ3f+SPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338666; c=relaxed/simple;
	bh=wkO+W3b4OI89v/KKCXuU7JOPO3UqcCSDyYqANd9YPOg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EKWfXvXIVG7ra1DejFjF1T37RZxVk0qRu+Oubxw5/Nl/47Eewh2daKYkBbF0a2R/3wl59XNGvITXFdVyhrqCHfBcW212ZablPCNyukDBqku0u8oNciE8T2ZQ7/++TveDKaa1F1i9ijFLRjsi/42pPRggwChVQlUnmbAHSPcNHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cRkm60GB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776338652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GQzGijXLGNbuq7icCuIcljXiHVxyhjq8+F6R9MdoBzA=;
	b=cRkm60GBXbJRlkyJZBd6kPmGCrRZ8WN5lQUoYW0p0B7QNOanhZO04xlt8a8IgEJjCfX47F
	M8B4+i4bXpHMGwWJz4zGht1bjucGypK2DdnPNVMQEyA5euAdPbUhBIsIStGFJm4YyZjmEE
	hvyLVSU2P1IAYNoWXmJbTePnK1+l2W8=
From: KaFai Wan <kafai.wan@linux.dev>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	kafai.wan@linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf: Reject TCP_NODELAY in TCP header option callbacks
Date: Thu, 16 Apr 2026 19:23:06 +0800
Message-ID: <20260416112308.1820332-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279009-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[23];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 060B540D552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This small patchset is about avoid infinite recursion in TCP header option
callbacks via TCP_NODELAY setsockopt.

v2:
 - Reject TCP_NODELAY in bpf_sock_ops_setsockopt() (AI and Martin)

v1:
 https://lore.kernel.org/bpf/20260414112310.1285783-1-kafai.wan@linux.dev/

---
KaFai Wan (2):
  bpf: Reject TCP_NODELAY in TCP header option callbacks
  selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks

 net/core/filter.c                             |  5 ++
 .../bpf/prog_tests/tcp_hdr_options.c          | 54 +++++++++++++++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c     | 40 ++++++++++++++
 3 files changed, 99 insertions(+)

-- 
2.43.0


