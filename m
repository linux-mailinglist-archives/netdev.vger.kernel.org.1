Return-Path: <netdev+bounces-279648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ98CLqV5WnrlgEAu9opvQ
	(envelope-from <netdev+bounces-279648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:55:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9CC4266F4
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E5A5302001B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52B37F734;
	Mon, 20 Apr 2026 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lnT9nnbp"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4D37EFE2
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653713; cv=none; b=ZqcNFw9dCk4aSqAUZdjKr8rRU7ZS7sTzLvh8qQLz4DgLpZWXiXVWw+9XZRWMSbdvm5nJgZh6Rav7KbmRgdmP+oGx+YG2iH59PHnU4v6YEQKktuzgv0f3CiU2/5A7XACkrqGM7oxItTRAuyGdQ43UMaatRRfILsjil0Zz01s8Edc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653713; c=relaxed/simple;
	bh=TRQmr5m2Pb2uWL2kgXGK5YQvYZA5Wl9ljtXrjhhoGzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLxEBRd7vezRfzn5spyLIc5N+Eif66p/TAysnw2zTNWKROhMp0Nu0DVRlj1n8W8oC6wTup8WE04yci6iDXK58ArKOPKyQJhWZAMlDFH9p/FfIVOd6f7ZQF/kaf04Dy8iq8aX5JUDkWUCy/gHt6p9ASB9JRL3KvkirJbssJ8LpQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lnT9nnbp; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776653700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YFCGag2+RARMnL+MuWGy6ZpexdQQulX1NigU2jaRQH8=;
	b=lnT9nnbpxaHOTA4jVlYHs9/NOASScjeuENcxVZZ/xvWqlOmydsneyGVfoAYhhAf4XhdZlW
	WUtAqxpDEJ9Eyfq4FKfoG30AOem9ZRd4/qE1ZuYwTh6YIOi3Xx0aPcL2OghCNqo5VSuXDQ
	dyb9AOUzazo9f5grLj6wtr5V8HLhTR4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/2] tcp: symmetric challenge ACK for SEG.ACK > SND.NXT
Date: Mon, 20 Apr 2026 10:54:07 +0800
Message-ID: <20260420025428.101192-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279648-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D9CC4266F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 354e4aa391ed ("tcp: RFC 5961 5.2 Blind Data Injection Attack
Mitigation") quotes RFC 5961 Section 5.2 in full, which requires
that any incoming segment whose ACK value falls outside
[SND.UNA - MAX.SND.WND, SND.NXT] MUST be discarded and an ACK sent
back.  Linux currently sends that challenge ACK only on the lower
edge (SEG.ACK < SND.UNA - MAX.SND.WND); on the symmetric upper edge
(SEG.ACK > SND.NXT) the segment is silently dropped with
SKB_DROP_REASON_TCP_ACK_UNSENT_DATA.

Patch 1 completes the mitigation by emitting a rate-limited challenge
ACK on that branch, reusing tcp_send_challenge_ack() and honouring
FLAG_NO_CHALLENGE_ACK for consistency with the lower-edge case.

Patch 2 adds a packetdrill selftest under
tools/testing/selftests/net/packetdrill/ that verifies the new
behaviour.

Jiayuan Chen (2):
  tcp: send a challenge ACK on SEG.ACK > SND.NXT
  selftests/net: packetdrill: cover challenge ACK on SEG.ACK > SND.NXT

 net/ipv4/tcp_input.c                          | 10 ++++--
 .../tcp_rfc5961_ack-beyond-snd-nxt.pkt        | 31 +++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-beyond-snd-nxt.pkt

-- 
2.43.0


