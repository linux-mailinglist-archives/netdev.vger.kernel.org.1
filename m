Return-Path: <netdev+bounces-278408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGZRNdkj3mk1ngkAu9opvQ
	(envelope-from <netdev+bounces-278408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:24:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C623F9448
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B5393014D9A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317B3D9DBA;
	Tue, 14 Apr 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N61uzNTv"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3F3B9DAC
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165844; cv=none; b=TC9VlUZ42NvcoJT9+CDbY/6cXwKIcmL8mPF+Pt7Xkj+OxYMrh6eVjjFm81x9LPjvpkRtzjASnK9WYKWb1dp5onKo21YM0zLMBffMGxza5xaBPa9IEA9ai+8cqO0BUMOaad/MixLkUmmhzFXcweiZSIFUJotti7LH8HJPhYRN48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165844; c=relaxed/simple;
	bh=0vM8Wm0yvMs1PHZRliZhxIPfiXZ2NOCQ06VtNDnSSis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZHuOLPq6XNJIIAMrNWdqJP7S2X2QIy7sWAXpjmvHmPMnoBlyKnbvOVI3l8zueEsG7n6+RH4Ib9MSgrxRMZGTQ29PaAVM4Rh5Q6TrVZLgaaNuUBuTkmeINgHMR4Kl287Z9PXu4egtcsc0+y12xV4AbLFClEfEqR16/U9Ko7uglF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N61uzNTv; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776165830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nD3+pYkuUta613cN19y/PkEcTwKQ+sxBqJw2XDXKABc=;
	b=N61uzNTvbqRwJAPfiGs2bl1u9zlbXJ5Q9XC7AEX2fSmGy/yIm0C7aQM+fcz1qOGAs13T7H
	TjC/zsy6kPDbYtxxTH2YhBMGMbadzmTz3uifuW01J51dCRIpWmyYrXPJCQfc8YjC2NEwaS
	COkYCs+LVBgN/fJwE2Gqiv2MP2QGDf0=
From: KaFai Wan <kafai.wan@linux.dev>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: tcp: Reject TCP_NODELAY from BPF hdr opt callbacks
Date: Tue, 14 Apr 2026 19:23:08 +0800
Message-ID: <20260414112310.1285783-1-kafai.wan@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278408-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: C6C623F9448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This small patchset is about avoid infinite recursion in bpf_skops_hdr_opt_len() 
via TCP_NODELAY setsockopt.

---
KaFai Wan (2):
  bpf: tcp: Reject TCP_NODELAY from BPF hdr opt callbacks
  selftests/bpf: Cover TCP_NODELAY in hdr opt callback

 net/ipv4/tcp.c                                |  5 ++-
 .../bpf/prog_tests/tcp_hdr_options.c          | 34 +++++++++++++++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c     | 18 ++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.43.0


