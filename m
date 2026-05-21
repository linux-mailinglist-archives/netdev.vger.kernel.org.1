Return-Path: <netdev+bounces-290310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL1VLqbNDmpoCQYAu9opvQ
	(envelope-from <netdev+bounces-290310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:17:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 565055A21A7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E652306F75F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D536827E;
	Thu, 21 May 2026 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+MIFfqm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F93624BC;
	Thu, 21 May 2026 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354737; cv=none; b=nbe14S34wBwmG1Ch8LRy3D1Rb5QW3cn77imrVl7hP5Weeg+TKDJ1xgqL0zZhfjUAZWUQtiRZz07bFM6ujTVniuSUK7k0/3f0VoGP9sj+N3B7OGEQSq8T+mYnEclqzgBXF/hhdHZXz6weqBsP4i3Nf/eREIyJsjZaMDqS5l3Luto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354737; c=relaxed/simple;
	bh=HQ7R9CO8FJLI0GtdVE1mo0kd2+tkBwu+M538/cDAZb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jA5N5VjJeal6V/pjRAMnFhUKPrUHIwOHzc4NDGmZ+VBQ29lqpKA/c7LZATeSBnzaI1SxPsnTYQurQVgNV8CNAnVk0FU+dMjK7HqAVK5SLp+fRnJCZQ2bgigE72j/h/ukRQhBJPnx2Ki5VK4WBFi1cfsElRY2DDTgMhdcH5Z/zVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+MIFfqm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81691F000E9;
	Thu, 21 May 2026 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779354736;
	bh=9/mz1TdWdVwg2aJEiIGQQfoQdFIwTlPnM+glR/xdong=;
	h=From:To:Cc:Subject:Date;
	b=X+MIFfqmGSlBLo7yN1F/JuV5Q0tYudmbXB8X0NUkq/rnv7IMEBBPMlmQ9lo2oFyEr
	 y/JJm2NIS5ZSL0wp6pWH0cb1cLduAO5qDk8ecbbeHXw90FJqLqssm56VoELadr77pg
	 xNSnNEh2q3x9arpBSOpfIPb6pPjclTH8NY0y6U3z289tYW643v9RapeX3JvRSJaUC8
	 AcUBdpaaFT6z1sxX+Bfiq+UusSsRR6Uhl04pqfj/uKh4JI5jhzn4OeiAPZQrJSUP2R
	 Ubbeq797qKyAG5RxSC2u5TYGVErOLrLKEUlgwS/GIZMWtJTn+uqwwsBh39K9Jjeg2U
	 m7E1de99IU7ag==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: tls: use ASSERT_GE in test_mutliproc
Date: Thu, 21 May 2026 17:11:53 +0800
Message-ID: <0ee9f412b6bd1a260a547d19f979f73b396746ac.1779354585.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290310-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 565055A21A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geliang Tang <tanggeliang@kylinos.cn>

In test_mutliproc(), when send() or recv() returns an error (e.g.,
-1), the test continues to execute the remaining code and fails
repeatedly due to using EXPECT_GE.

For example, if a TLS connection is broken and recv() returns -1,
EXPECT_GE(res, 0) records a failure but does not stop the test.
The test then proceeds with left -= res (where res = -1), causing
left to increase unexpectedly, and the loop continues indefinitely.

This results in a massive number of identical failure messages:

 # tls.c:1686:mutliproc_sendpage_writers:Expected res (-1) >= 0 (0)
 # tls.c:1686:mutliproc_sendpage_writers:Expected res (-1) >= 0 (0)
 ... (hundreds of identical failures)

Fix this by replacing EXPECT_GE with ASSERT_GE. When send() or recv()
fails, ASSERT_GE immediately aborts the current test, preventing
the subsequent undefined behavior and endless failure messages.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 30a236b8e9f7..9b9a3cb2700d 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1549,7 +1549,7 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
 			res = recv(self->cfd, rb,
 				   left > sizeof(rb) ? sizeof(rb) : left, 0);
 
-			EXPECT_GE(res, 0);
+			ASSERT_GE(res, 0);
 			left -= res;
 		}
 	} else {
@@ -1566,7 +1566,7 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
 				res = send(self->fd, buf,
 					   left > file_sz ? file_sz : left, 0);
 
-			EXPECT_GE(res, 0);
+			ASSERT_GE(res, 0);
 			left -= res;
 		}
 	}
-- 
2.53.0


