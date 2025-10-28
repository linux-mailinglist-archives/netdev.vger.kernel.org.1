Return-Path: <netdev+bounces-233454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43BCC1380D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C21C584EC4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CF2DEA71;
	Tue, 28 Oct 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAPu/e7X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC52DEA68;
	Tue, 28 Oct 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639445; cv=none; b=AbTYcjt+ISsXqs+10uRKOah5ple8IKxIvNVeXt8FOWNWwRvJJqggHOWJ/GpjetLL+8GRaJROyssjwJB4pLagBOpMWMaN4xoGzoPqDJ0cT7n0yASDeYB+0ZUYbOixlDwydw/vlbuRk91rNQxUQAyi4sTp1dkblxo2CzapxFKepyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639445; c=relaxed/simple;
	bh=yJ6OnFD0p0J2q2ViCKgWUNewRrcdoQHh3ztvy85qnmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ufe8qsRuDyKWspR5JGln+/yNCAXqfue1O6uaqJTv9T8zxSpnWIq9IhCC3hL+5H6j7yV9f7h3XPK8nfll7Cs4wdHgeYmIFVZlv9VXdZWrtFRZsMECBr4raS32k/zuM4WzDvAer09boCkXI7vvll9jooWB+hgaVYPgxVWtMyLIkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAPu/e7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AE9C113D0;
	Tue, 28 Oct 2025 08:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761639444;
	bh=yJ6OnFD0p0J2q2ViCKgWUNewRrcdoQHh3ztvy85qnmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vAPu/e7XntGcsPEN/KZD9G1NbFP84vH19IgqZ27EjaQPKNcGe489i7ixPMBYO94Y2
	 JjrE4g7bp42tur/bO+pdMMnAic0Vu/DEFsWXaaB7hpUr7woEqibb3TGpY27Q4E5q4A
	 C4WdEzVKScmZqTmACTS51smBVajGsTlDa3QmtQxqID00GFt5oQTYcyTSIHiNOM9gJn
	 aGv7xy9NdFjo1WYfzMuPGvH7K/48uauiVyhNbHFYh0T/sPm50bY4LhgTr/JISg/2KX
	 4W3o8ZY8Vt09mTVnOGakxYrHdedxv9mW5B5PxIafk7pOM5Hzn0pGBpkcINF7clu/T7
	 xQvvHVWOHdwWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Oct 2025 09:16:55 +0100
Subject: [PATCH net 4/4] mptcp: zero window probe mib
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-net-mptcp-send-timeout-v1-4-38ffff5a9ec8@kernel.org>
References: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
In-Reply-To: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Yonglong Li <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=L2OKjKKGhGjF8C+8RuWZFoc4maf4q5B5EWamzyvqW0M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZathyAp/Ps5/rtmDn0qMNAfae9c+fcjSJfCpaPTmr6
 9iD8DfCHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZt52RoedoSO4jCV6jWsep
 y8L//o2w3Xi/VzXgrcNH+7PrOgU+LmFkuCXK47n/yc65Bcf53q23Ky0N3S6toaN80MTsVb6V0TI
 XfgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Explicitly account for MPTCP-level zero windows probe, to catch
hopefully earlier issues alike the one addressed by the previous
patch.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 6003e47c770a..171643815076 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -85,6 +85,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
+	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 309bac6fea32..a1d3e9369fbb 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
+	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2feaf7afba49..49fed273f4dd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1346,6 +1346,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 mpext->dsn64);
 
 	if (zero_window_probe) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_WINPROBE);
 		mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 		mpext->frozen = 1;
 		if (READ_ONCE(msk->csum_enabled))

-- 
2.51.0


