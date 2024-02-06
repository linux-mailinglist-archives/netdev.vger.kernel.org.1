Return-Path: <netdev+bounces-69618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004284BDFC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FDD1F261B4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012313FFF;
	Tue,  6 Feb 2024 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N12K86ug"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24A13FE7;
	Tue,  6 Feb 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246993; cv=none; b=Yowj6iz9aY1c6iA+Rcn86wZwZUJKH0sb9eHY3gipGr6hBmGB8REIeyOseM97Jdcf2Gur0mThjPNyccdz70wbvZOG5xoSb8u65N5rWQDxs91jCOd9U7ADi/zyqYVwp0Ze35yAATT7v+rDBVhfYupT09gNdhWKJ2QpcTv3RsDG9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246993; c=relaxed/simple;
	bh=y3hv8sPsSl0G1Lga/qGKny5Osq0bSrG1cNFcbeb8xaU=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=r0m6DAQcIkB6t6RDmB4QAPyWuzRIIMtDtZ0J55pQqsY50icVUTShwDGr1XDrYFZKYRPbZrkLBgSxX9ocbIoVkpjE2E10lCdSVawOxp79m2GKXcsg4CUuiropNHR8IzLhT6hisPSsKIf/R2QMSogcoc85+K6dMJR4zIR6c1DU/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N12K86ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326ECC433F1;
	Tue,  6 Feb 2024 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707246992;
	bh=y3hv8sPsSl0G1Lga/qGKny5Osq0bSrG1cNFcbeb8xaU=;
	h=Subject:From:To:Cc:Date:From;
	b=N12K86ugLm+uZZfUBvgb1Y3RPKlDccq1f5TKlzVfL/28EnCWpz2rhkFzAB1szXXt3
	 WIWAtY/O0NCfVWu8GwfXKFy5PW+DiAWkvxAC6/sEvUCr/iaIklCQNMAM+Rd4idMHZi
	 AP+/4rQvBzZt66g2isCzHBdq3sIuumMYNQPBsi70IoNdMCp2mW6Nty93dNOqRbR86O
	 Gw15v/6DMj9iLA9RsJ8GGxS7MGmUnsZoWHD16Rji2EfVTgjKcnfX000F1xLt8LdDe7
	 HokvSrPRPZvVaLn7iUPim9h4c4U5mJC4fDdzE1AOIUTlMnCSWwhnq7sDK3lDTVnKfO
	 cKBk57BXQYOeQ==
Subject: [PATCH v1] net/handshake: Fix handshake_req_destroy_test1
From: Chuck Lever <cel@kernel.org>
To: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 06 Feb 2024 14:16:31 -0500
Message-ID: 
 <170724699027.91401.7839730697326806733.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Recently, handshake_req_destroy_test1 started failing:

Expected handshake_req_destroy_test == req, but
    handshake_req_destroy_test == 0000000000000000
    req == 0000000060f99b40
not ok 11 req_destroy works

This is because "sock_release(sock)" was replaced with "fput(filp)"
to address a memory leak. Note that sock_release() is synchronous
but fput() usually delays the final close and clean-up.

The delay is not consequential in the other cases that were changed
but handshake_req_destroy_test1 is testing that handshake_req_cancel()
followed by closing the file actually does call the ->hp_destroy
method. Thus the PTR_EQ test at the end has to be sure that the
final close is complete before it checks the pointer.

We cannot use a completion here because if ->hp_destroy is never
called (ie, there is an API bug) then the test will hang.

Reported by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/netdev/ZcKDd1to4MPANCrn@tissot.1015granger.net/T/#mac5c6299f86799f1c71776f3a07f9c566c7c3c40
Fixes: 4a0f07d71b04 ("net/handshake: Fix memory leak in __sock_create() and sock_alloc_file()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/handshake-test.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 16ed7bfd29e4..34fd1d9b2db8 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -471,7 +471,10 @@ static void handshake_req_destroy_test1(struct kunit *test)
 	handshake_req_cancel(sock->sk);
 
 	/* Act */
-	fput(filp);
+	/* Ensure the close/release/put process has run to
+	 * completion before checking the result.
+	 */
+	__fput_sync(filp);
 
 	/* Assert */
 	KUNIT_EXPECT_PTR_EQ(test, handshake_req_destroy_test, req);



