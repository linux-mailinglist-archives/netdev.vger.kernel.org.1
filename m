Return-Path: <netdev+bounces-282390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIMpJ08H8mkimwEAu9opvQ
	(envelope-from <netdev+bounces-282390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:27:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DD494CB8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0630301DBB2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADCE3FCB27;
	Wed, 29 Apr 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIoD06gR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859C3F23AB;
	Wed, 29 Apr 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468949; cv=none; b=h1YREqD/q1IZEF+4tEcVuiIxHLdj07xSeaOigS2d6DN3Buw8OnODx6TcX7hqtNumNFPcVpVvKLX9/sTZ9oVMksDF6/QualY72J8aDqUmWqWYg0z1q8t4KC4VaYCMBXL0YtJgjY2SjLOUqhzgvi6YSxFf8nfgjiXR+aamDQs5IQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468949; c=relaxed/simple;
	bh=0q4Kb+0MtHIIchjg9qK9s2IuUDQ6rf+FF6oXl0WBVmY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t9e02iGA57dJOa99Owp1jLNWqv1dWFMyi2w++q6yzTQad+Z6iPoLodXij4baskonbvE1XzrG+I64NvMWJJ6zMQh0OKlsj6cAGmLZtdxgLXJnyt0ae3e93R/JtIYK4q7yljUh0W+K182ZkCIDprDiD/BMe25uhtIiqLmSoXbTuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIoD06gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB103C19425;
	Wed, 29 Apr 2026 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468949;
	bh=0q4Kb+0MtHIIchjg9qK9s2IuUDQ6rf+FF6oXl0WBVmY=;
	h=From:To:Subject:Date:From;
	b=GIoD06gRdm6t/17QcjvIQ1PqvZOIfpf1Sh8/UIkzYtRzmgYHoIYe+PETjvlFoMekA
	 nAiT1SUMXdL+ITGT2ym2wDSgo00EgabvZmuEW2qK/a1GLvqgpsXU0y028PJ62cqZtj
	 v0nuz1tYmh5Ud294f8eNXJ7VU8/5bWNnddF0FDz7nF+PuVr3EKa156US+bO5Pv+QwA
	 06My+oMY2kVXjUBenZ/6I23uIwaCW34H3DTkE7P8GcgsSBHSFsMuGgdYUGgkpY460y
	 aobYYVFRsuOBTNZuxwBO5Ugz5IVN3JzXLnGczofCUpsgTjK9DL1Uy7k+CKi5QyzkD8
	 IZcliNk3Fs28Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nfc: llcp: fix use-after-free in llcp_sock_release()
Date: Wed, 29 Apr 2026 13:22:11 +0000
Message-ID: <20260429132218.3548644-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E9DD494CB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282390-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

llcp_sock_release() unconditionally unlinks the socket from the local
sockets list.  However, if the socket is still in connecting state, it
is on the connecting list.

Fix this by checking the socket state and unlinking from the correct list.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/nfc/llcp_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index f1be1e84f6653..feab29fc62f44 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -633,6 +633,8 @@ static int llcp_sock_release(struct socket *sock)
 
 	if (sock->type == SOCK_RAW)
 		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
+	else if (sk->sk_state == LLCP_CONNECTING)
+		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 	else
 		nfc_llcp_sock_unlink(&local->sockets, sk);
 
-- 
2.54.0.545.g6539524ca2-goog


