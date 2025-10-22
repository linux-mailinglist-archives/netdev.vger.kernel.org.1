Return-Path: <netdev+bounces-231858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F372BFDFFF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64383A7D52
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE993502AD;
	Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkwvQ5rj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6933502A5
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160641; cv=none; b=pTZHMO6DIdiJGiZNLrmxbw0+HPOVco5uuntuvr5Wvguoubcmh+t4BBbblTnDy0C7R9VgHkvLPV1tfR2nNq7VFmEvH0V1PZMyBgnaMzYiihesdHVHvGvwF1saCkSJ61sTrNiww97okat/XT54tsPOqM7x5vMVgscGnCDMzjN+uPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160641; c=relaxed/simple;
	bh=BekswomAkNGto5VBQeZ3T7Kq0QJvaaY2EIHL95CGDDE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huFwdfH5um3NsJlDFfoG1LqLoIVhNSok1AkY4hWQPDb7BEi++aubDSFEzczuigUUaRAwS84DL5KksM1QaR8qAfxjVuUqLYuuOMVLO2vTdAJSdQT5eg9OsZwCOYOkVSbGs+jU2Ok/44vNbMe3TPuORKX9e/sQy8TqXNP+WzGLaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkwvQ5rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2F7C113D0
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160640;
	bh=BekswomAkNGto5VBQeZ3T7Kq0QJvaaY2EIHL95CGDDE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pkwvQ5rjSZzfB5NERMLcKHC0DOYqIzeweRbCo4IkgLj6v6tgea3YWrcmIWb9XwcjP
	 vWpRG+d9srcqPU2AyGKpimf9rUFtpxqH8w+L5hQTYezxk2BL8PXqB7xxvbLFS/dn4M
	 XlSwBsr5CDBXcMzLSKqUTBWNXAj4PtYOU8EPbaDY7ZDLLHvhz/ZstUp8pNpT4BPpbz
	 XokCBaIPXw8nq5mO2ezk+bJDMhkkXCvVz7e4IrNjiDu8lsEpofIyhWi54C0YlcQ7WO
	 /ZT88Spn8uUx0kWs5l7OTyU4Bv7lU2jHBOCpl3DM29bpDHFs1RQtu/YlRNxK1OXlas
	 AeLmP7ljjFfkg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 10/15] net/rds: Clear reconnect pending bit
Date: Wed, 22 Oct 2025 12:17:10 -0700
Message-ID: <20251022191715.157755-11-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
References: <20251022191715.157755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Håkon Bugge <haakon.bugge@oracle.com>

When canceling the reconnect worker, care must be taken to reset the
reconnect-pending bit. If the reconnect worker has not yet been
scheduled before it is canceled, the reconnect-pending bit will stay
on forever.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 8680b4e8f53e..99709ddc80d7 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -437,6 +437,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 	 * to the conn hash, so we never trigger a reconnect on this
 	 * conn - the reconnect is always triggered by the active peer. */
 	cancel_delayed_work_sync(&cp->cp_conn_w);
+
+	clear_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
 	rcu_read_lock();
 	if (!hlist_unhashed(&conn->c_hash_node)) {
 		rcu_read_unlock();
-- 
2.43.0


