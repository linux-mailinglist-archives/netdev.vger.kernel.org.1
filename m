Return-Path: <netdev+bounces-274992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKenAxSlz2mZyQYAu9opvQ
	(envelope-from <netdev+bounces-274992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:31:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DAB393B33
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CEF9304D174
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CBA3B4EA1;
	Fri,  3 Apr 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DboVWLTC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660463B27D9;
	Fri,  3 Apr 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215793; cv=none; b=lYRRsyX2pEh0tTbOOjQRfgcoSSySXTDMss6fKELFJecveNqSIXpTx1mkBuCFJPmu/vkMP+c6yRKpHoPK34yzvX3vD3t/78jiavUdSLhxFJtY2xVtFSnwZ6S2yCg8ECDdxM10fAx/g35nO8FQ6ASfnrd6SwG3bRyY01fj0DUWFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215793; c=relaxed/simple;
	bh=krb2FERuTjanQZibFTkED3yxvhTzQbpCE/57yPzfCfQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zie/oMD1cS4EYEgdMosa5PqSLzDu16SgIqgqLhuTnQ6uhPF4Mp/NnSiHfRS5aqcswDqI4bx2fRclczQBk6LJuBN8rHZqCr35/WKqtGEZpVokS+qp56Vzmxe4WoeenQLezolJDsY7jlnAeig80la7OFUoz32U2go5nhnHKcg5xRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DboVWLTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D104CC4CEF7;
	Fri,  3 Apr 2026 11:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215792;
	bh=krb2FERuTjanQZibFTkED3yxvhTzQbpCE/57yPzfCfQ=;
	h=From:Subject:Date:To:Cc:From;
	b=DboVWLTCyQceR88whm41jQCMKGpmYH7Hd4lJdfR+P2i8aCxAxqsUlQ0Q/+twIYahD
	 BRUHKJZ+5jL3JGzOeDuvq5K+wWru7TA8qyVnRm3p25tYI68bg/MIj7ALqCgB8qmCCH
	 ROLvSbo6nL1DzQ6X7KkdjMup4OT5BAJdEi1KNM5yLIue20eg3F89MxFyLznlAS836b
	 JWC8JVD1WM0qAzAfcp2b/bnZ9/4HcWNzgBFEAAuSSuqFPo66JCxxgT3A+ImdBcVdMC
	 njVrWiGCtkFct5ttKiY2v2L08HozHUcsLGfHQBDMa696Zqbk7Uk09j5qlSX+AUnrph
	 dAbCbiYSYKDZw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/5] mptcp: support MSG_EOR and small cleanups
Date: Fri, 03 Apr 2026 13:29:26 +0200
Message-Id: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMQQqDMBBFryKzdiBVG6FXKSJ1MrVTSAyZWATx7
 k1buviLx+e9HZSTsMKl2iHxS1SWUOBUV0CPW5gZxRWGxjTWdKbFwLlsy+hjpohe55GXhF6U0E7
 d2fbOtb0jKIWY+C7bt36FvwjD79F1ejLlTxyO4w0vdn9liQAAAA==
X-Change-ID: 20260403-net-next-mptcp-msg_eor-misc-6b4567dd37dc
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=krb2FERuTjanQZibFTkED3yxvhTzQbpCE/57yPzfCfQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPL1nJf9LnsJLvonc6h+skPvGtWnVYcMm7io273k9d3
 zZTQe7Bw45SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJ/OJlZLj9Xu/lgtrpqUvf
 W65gYj3+bdex32V3zu3k33o5+dndh+ZiDP9sCksU5PXruo8Xcdp0n97wrpV9rWpf/aLfUXdfWd9
 4U8UAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274992-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75DAB393B33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series contains various unrelated patches:

- Patches 1 & 2: support MSG_EOR instead of ignoring it.

- Patch 3: avoid duplicated code in TCP and MPTCP by using a new helper.

- Patch 4: remove duplicated condition.

- Patch 5: adapt test to reproduce bug and increase code coverage.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (2):
      mptcp: reduce 'overhead' from u16 to u8
      mptcp: preserve MSG_EOR semantics in sendmsg path

Geliang Tang (1):
      tcp: add recv_should_stop helper

Matthieu Baerts (NGI0) (2):
      mptcp: pm: in-kernel: remove mptcp_pm_has_addr_attr_id
      selftests: mptcp: join: recreate signal endp with same ID

 include/net/tcp.h                               |  8 +++++
 net/ipv4/tcp.c                                  |  9 ++----
 net/mptcp/pm_kernel.c                           | 24 +++------------
 net/mptcp/protocol.c                            | 41 ++++++++++++++++++-------
 net/mptcp/protocol.h                            |  3 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 +--
 6 files changed, 49 insertions(+), 40 deletions(-)
---
base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
change-id: 20260403-net-next-mptcp-msg_eor-misc-6b4567dd37dc

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


