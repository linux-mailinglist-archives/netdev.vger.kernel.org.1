Return-Path: <netdev+bounces-207166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5932B06175
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD7A92008B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E627A904;
	Tue, 15 Jul 2025 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq6Wqct+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107C279DAC
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589735; cv=none; b=fcA6ESCspzydPLkTQt41ovPGRQRbFdqsMn0r3xu0S7Uw6ACN1bXr5LIGl3n36+HlQ7YUZVqN+kjpVZlfzlJwSZiY2OEoIsQyjjKvwsm/DUsyDG2NOVSg/8dfykAwqCzwcLoE+bhclYF8vCJ0+pf5QIy91KTqJXMHvK+LWqrghYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589735; c=relaxed/simple;
	bh=CgW09YMMU2qOCMALjeIcGCtKBMSJ9x+VlRHylVlt+3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taSngrSG+53xt4QQjAIAGw+jxaCptCt+GiQvv4MpXbE6kKc1TkDEU9hWWedKRhsT4mV84j+oye3j7TyOpX4TG7/IG5GtvKf9yelP0MSWVGju+P/pt3ILgg6XsIcwUnuZkMNSIyvJv3paQGO3OHIKkosypsbbXtelBCluwmOvT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq6Wqct+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAC2C4CEE3;
	Tue, 15 Jul 2025 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589735;
	bh=CgW09YMMU2qOCMALjeIcGCtKBMSJ9x+VlRHylVlt+3s=;
	h=From:To:Cc:Subject:Date:From;
	b=nq6Wqct+MNr46wMBt70qAtbZAX9NMFvCPbB/h1bcAE7asBux5nKZMA33pvUwJCvj7
	 XDT6I+8c35DXgK7MMS73D7y0kJgzBFEgjBOysvfNTgWhj8R90AlT7bzWN1RKeC6WkL
	 wSSgC8+lqWNj0IK/dwVmcetVENM3x7EVuMQlbwL8sez+NaEJ9Z88WqyURMAYW9TYQf
	 8pSsM04kfS2RSGL2dZYjyFGIIj6Kl8Pt/SlBcs3Tk6rraZbZYJCac8J2ESVi9LRmce
	 1Oz0r3kSX7yDAUbHX44YyVXF46+F8lnbO7rQYVjxzCtjzoiLZr0I3FHIY/Eyu+/2u0
	 aihWMH6eZz5hg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	ncardwell@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: packetdrill: correct the expected timing in tcp_rcv_big_endseq
Date: Tue, 15 Jul 2025 07:28:49 -0700
Message-ID: <20250715142849.959444-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f5fda1a86884 ("selftests/net: packetdrill: add tcp_rcv_big_endseq.pkt")
added this test recently, but it's failing with:

  # tcp_rcv_big_endseq.pkt:41: error handling packet: timing error: expected outbound packet at 1.230105 sec but happened at 1.190101 sec; tolerance 0.005046 sec
  # script packet:  1.230105 . 1:1(0) ack 54001 win 0
  # actual packet:  1.190101 . 1:1(0) ack 54001 win 0

It's unclear why the test expects the ack to be delayed.
Correct it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
index 7e170b94fd36..3848b419e68c 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
@@ -38,7 +38,7 @@
 
 // If queue is empty, accept a packet even if its end_seq is above wup + rcv_wnd
   +0 < P. 4001:54001(50000) ack 1 win 257
-  +.040 > .  1:1(0) ack 54001 win 0
+  +0 > .  1:1(0) ack 54001 win 0
 
 // Check LINUX_MIB_BEYOND_WINDOW has been incremented 3 times.
 +0 `nstat | grep TcpExtBeyondWindow | grep -q " 3 "`
-- 
2.50.1


