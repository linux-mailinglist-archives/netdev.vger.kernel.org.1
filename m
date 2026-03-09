Return-Path: <netdev+bounces-265618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMx1DhvvrmkWKQIAu9opvQ
	(envelope-from <netdev+bounces-265618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:02:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BECA23C5A0
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAAC304707A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541C3DA5B1;
	Mon,  9 Mar 2026 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKoDxmXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C333612ED;
	Mon,  9 Mar 2026 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071819; cv=none; b=lXV1o58nZrrND0Un+y65OXo1VT4/is8abt78oqzZOvMUXBhTid/t3lvmFwUuPedK8Kvate5au9jru+DbE2MtilJcUML1bf22Fm2PaIQPi5Oqn3xdHfIKgDKulIIJkVONmHtbXMoy+QlTiAdvOEB07hnndXbcfUL3gZNuQC9WcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071819; c=relaxed/simple;
	bh=m19SiCca1ygFfZ957YWTHCYVip5bKWNpMLJ1zuuQIR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L7stMfsq+rSMkMy200VdauIES7lD0945MxsFJP5oY8Qqf5eHVgNKmWAT0oWtePdHtmt3A/FEqvg7N3GU+uJTbOrTHFWB84xUleX1t51TXi+SHvfPR5AjUKHmHC4WBSv1s/gWOBQv6KniQMKOMDPc8RnZEXZkobh1V1IjjOd3lKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKoDxmXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE0DC4CEF7;
	Mon,  9 Mar 2026 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773071819;
	bh=m19SiCca1ygFfZ957YWTHCYVip5bKWNpMLJ1zuuQIR4=;
	h=From:Subject:Date:To:Cc:From;
	b=XKoDxmXcOeaGl+ijYEK62FrOgoEZFz4sw4keIlhf1oQrfDElGDmodvy3HasZL2fkr
	 v6yhfMRM81AhprduFxR2F1R7vbK5LQngKeYIvh39SYdoE2pPEQ1Xjsf0UixhlCBvwC
	 cx3zBTOjec9Q6NiS9sXeF9DOlFgI+BB+s8PvCU3HXEHfYBcjIvpA5dbGo4OgkzREJZ
	 jEAXTIZibZUUOVpYkI3vkASpR4+0w3KpLQTpZwzl/MYLOTbWH9ZQn0+LKlV0okooW6
	 4mDEG8p7LT+5Jj7eS97nXxICwDvr6ufcGfX9k3oLk7Pm+FF6FlGrEWHPQHEyojjhfm
	 CaonTNv3lXymA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/2] mptcp: autotune related improvement
Date: Mon, 09 Mar 2026 16:56:44 +0100
Message-Id: <20260309-net-next-mptcp-reduce-rbuf-v1-0-8f471206f9c5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALztrmkC/zWMQQqDMBAAvyJ77kKiZQv9ivRg4qbdQ2PYRAmIf
 zcIHuYwh5kdMqtwhne3g/ImWZbYxD468L8pfhllbg696ckMhjByadSC/1R8QuV59Yzq1oBPS+Q
 mCu5FA7RBUg5Sr/kIdwef4zgByYRGPHYAAAA=
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m19SiCca1ygFfZ957YWTHCYVip5bKWNpMLJ1zuuQIR4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLXvT3u9bZsZ9OB/4cmTYjTXZoctEtnr9jt6U0yp28HZ
 /Jo+HDqdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzE4TXD/6pEK1fB7D/ry7e7
 mS4sst3onuLy5vX8AzG3vnE8epYuuZ+RYZW9x71vp5Zvneb0Np5H7Ob0aVtUC7Mat3kXGr5ctS4
 vmRkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 4BECA23C5A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265618-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.921];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
Paolo Abeni (2):
      mptcp: better mptcp-level RTT estimator
      mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 71 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h         | 38 +++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 33 deletions(-)
---
base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
change-id: 20260306-net-next-mptcp-reduce-rbuf-4166ba6fb763

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


