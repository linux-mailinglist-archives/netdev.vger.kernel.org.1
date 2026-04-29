Return-Path: <netdev+bounces-282527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KbZF46G8mkcsQEAu9opvQ
	(envelope-from <netdev+bounces-282527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:30:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB149B0C7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F6B302813A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D394449EA6;
	Wed, 29 Apr 2026 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7N6tway"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5394418DB;
	Wed, 29 Apr 2026 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501804; cv=none; b=UJ0pO7edETEF9Ni+6MdWcVpIkRKGQf39OZ7BZwTOtwkfgm/cV45G5yz5Qo2+KKy3MHZ4fxbX5uJDLvXRmf8ewMol/N1GtxkbwmEqiQkPYjWd9uRdR0ckr1/1deeRiwCZLar/GBJtSX6pjyugkgWd7MiNlXEfav6LEUcqP4xOlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501804; c=relaxed/simple;
	bh=jTZAkYsXeC/7A1HFfUKgPHtA4EykRvaAc3+/tMxPEYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fad2Oz/qAUHkE/8ytsWNtU6piPpGhxqHJmZlfomlqR8ELKGqWkvGTzwY7yLi8CKoX2NPpT+tD9eATsvtns9gxSwxmdwQEbQyqYBXoCP/CkDTqNo3SDclYIqwsz6m0McSHewI9ovQDlTeJBBUT6Zdc/trcQMp93jKLNYziDEBxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7N6tway; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8B3C2BCB3;
	Wed, 29 Apr 2026 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501803;
	bh=jTZAkYsXeC/7A1HFfUKgPHtA4EykRvaAc3+/tMxPEYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7N6twayRQPXFgy0mI8SJDoJ8jakyAnEs7oZoyDREP2sxd7WuaMjTLvA5beW30vOu
	 XG6tzj3dxtD30s7gq0nrObjZsRQMuSOzVMuz9iiuzJalY+1OLwlilmIZ01BwukuxGn
	 DET1f6ukQZ58Wj09VzUuc1gVnrAGQT4cBM7Uy1iRwQ9ch57ahW5GCaa82AnfcnUdmK
	 bgvlFHsqGqoIJgZVoxYoLXUj8Y4ucnNvaEGBpSpg/C2/8bJeSAE3gwDhZLVyYJRE5c
	 DcApsevXGgHVApfgfD4uPMunKybD9s29p0OCY2tChRettlj4QyMAnaYbBANARZFmQl
	 w2S1LhyWG6OCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org
Subject: [PATCH net 2/7] selftests: tls: add test for data loss on small pipe
Date: Wed, 29 Apr 2026 15:29:39 -0700
Message-ID: <20260429222944.2139041-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429222944.2139041-1-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5DB149B0C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-282527-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add selftest for data loss on short splice.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/tls.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9e2ccea13d70..30a236b8e9f7 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -946,6 +946,49 @@ TEST_F(tls, peek_and_splice)
 	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
 }
 
+TEST_F(tls, splice_to_pipe_small)
+{
+	int send_len = TLS_PAYLOAD_MAX_LEN;
+	char mem_send[TLS_PAYLOAD_MAX_LEN];
+	char mem_recv[TLS_PAYLOAD_MAX_LEN];
+	size_t total = 0;
+	int p[2];
+
+	memrnd(mem_send, sizeof(mem_send));
+
+	ASSERT_GE(pipe(p), 0);
+
+	/* Shrink pipe to 1 page (typically 4096 bytes) to force multiple
+	 * splice iterations for a 16384-byte TLS record.
+	 */
+	EXPECT_GE(fcntl(p[1], F_SETPIPE_SZ, 4096), 4096);
+
+	EXPECT_EQ(send(self->fd, mem_send, send_len, 0), send_len);
+
+	while (total < (size_t)send_len) {
+		ssize_t spliced, drained;
+
+		spliced = splice(self->cfd, NULL, p[1], NULL,
+				 send_len - total, 0);
+		EXPECT_GT(spliced, 0);
+		if (spliced <= 0)
+			break;
+
+		drained = read(p[0], mem_recv + total, spliced);
+		EXPECT_EQ(drained, spliced);
+		if (drained <= 0)
+			break;
+
+		total += drained;
+	}
+
+	EXPECT_EQ(total, (size_t)send_len);
+	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
+
+	close(p[0]);
+	close(p[1]);
+}
+
 #define MAX_FRAGS 48
 TEST_F(tls, splice_short)
 {
-- 
2.54.0


