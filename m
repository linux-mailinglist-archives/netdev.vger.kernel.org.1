Return-Path: <netdev+bounces-275906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHpgLz3E1GmmxAcAu9opvQ
	(envelope-from <netdev+bounces-275906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:45:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F493AB7BD
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8344F300EF66
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241753043DE;
	Tue,  7 Apr 2026 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaFx76So"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD02ED141;
	Tue,  7 Apr 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551531; cv=none; b=p4axW/UISuCqK+I/CYQavFUOkZ8wbn16aQdP/XAecwsO6Y0UNN8m8hmQNpz5iZQSEhTg3JyuijM4wpFl1cxIo6JM62np4u2O/E9cd4O1ihdaztnAnXmSjuzAWigPQp2AhNc/K/TlNsvbNvVZ5HcTf82qfgk1E2eyWXDMuOmwhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551531; c=relaxed/simple;
	bh=m3OfzQ/7lPnEqmiY2vJFdVN/V5m87Zv7hfY8AuSS9RA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mbtIFR4J4sfR4RPsZtR+PcUHwj/JaOP8QycwVzweCL6DEDdoqwdEI/2OCChsP3F6EKVqkPPR7o34RVopcGlW7cZ3O6vcWU+QISKy1zOZ8ThTIxD/3YTz6RoY/cnPoJ7vQ9zFdgdDiSAeQ0cbo32IkNlZouNbtFu7AES7XFD7ecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaFx76So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BF6C116C6;
	Tue,  7 Apr 2026 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775551530;
	bh=m3OfzQ/7lPnEqmiY2vJFdVN/V5m87Zv7hfY8AuSS9RA=;
	h=From:Subject:Date:To:Cc:From;
	b=BaFx76SozDlGLZVRZpQjNvzSxED0mV+e/7eEkieo6sW95XPQnWnk4TVJl7lVwrsaD
	 doyB6Gjc4E39SPNHDsN7OfGM8Vi0VbunthbVLKP06lmrl4rJgfT1sZokWnLZN5j32T
	 dPm7knRQG3Df4UnKYtcqXmBl/5GnkO/Hr9g5zMb2uCB03NZBht1VKUPE/cXsLObZot
	 fNoplZPYTlOtI1KEjmDG8I9pwjrX5gesNegO1XaxJrjKd8TPZnkG9HRObNPA3qjqWP
	 8MHRU3bfkyAO/XLiV9PFWa/7KKoz3rGzhLz6TVrcKsxqMBLcKkr1jIom75eKJzCqG3
	 BMEaDZ4I8YKyg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/2] mptcp: autotune related improvement
Date: Tue, 07 Apr 2026 10:45:16 +0200
Message-Id: <20260407-net-next-mptcp-reduce-rbuf-v2-0-0d1d135bf6f6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf8Xs2TVtwSKe/A/DAcoWGrWQbSEYw
 r/bEL16mMPLZOatEIgdBbgeVmCaXXCDT6COBzB97TtC1yYGJZQWmdDoKaYsEV9jNCMytZMh5Ga
 ymEutm1rbptAZpIORybplP7/DbwdVanoX4sDv3TrLvf8Kyn+CWaLAi80LqYS2pTnfHsSenqeBO
 6i2bfsAY5WdSs8AAAA=
X-Change-ID: 20260306-net-next-mptcp-reduce-rbuf-4166ba6fb763
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m3OfzQ/7lPnEqmiY2vJFdVN/V5m87Zv7hfY8AuSS9RA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKvHFH7vXXasvyvzg0n7d49PauwKbUxkuP5bVEl5bAVb
 7yiHZYKdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExE7ynDfz+LjKr9ce/booyu
 tx2/PufZixXyl5z/mWomur98Vxe6+ykjw6/F6+pYi69OXhQXdG/a6flfXr/X/8b+U1B4hfrVqiW
 ntJgA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275906-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 46F493AB7BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are two patches from Paolo that have been crafted a couple of
months ago, but needed more validation because they were indirectly
causing instabilities in the sefltests. The root cause has been fixed in
'net' recently in commit 8c09412e584d ("selftests: mptcp: more stable
simult_flows tests").

These patches refactor the receive space and RTT estimator, overall
making DRS more correct while avoiding receive buffer drifting to
tcp_rmem[2], which in turn makes the throughput more stable and less
bursty, especially with high bandwidth and low delay environments.

Note that the first patch addresses a very old issue. 'net-next' is
targeted because the change is quite invasive and based on a recent
backlog refactor. The 'Fixes' tag is then there more as a FYI, because
backporting this patch will quickly be blocked due to large conflicts.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1: add missing READ_ONCE() and remove unused entry. (AI)
- Link to v1: https://patch.msgid.link/20260309-net-next-mptcp-reduce-rbuf-v1-0-8f471206f9c5@kernel.org

---
Paolo Abeni (2):
      mptcp: better mptcp-level RTT estimator
      mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 71 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h         | 37 ++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 33 deletions(-)
---
base-commit: c149d90e260ca1b6b9175468955a15c4d95a9f3b
change-id: 20260306-net-next-mptcp-reduce-rbuf-4166ba6fb763

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


