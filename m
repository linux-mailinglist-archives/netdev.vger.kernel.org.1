Return-Path: <netdev+bounces-214781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FD2B2B30D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 22:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE99A1B2343A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB39278172;
	Mon, 18 Aug 2025 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlzPjmj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D6275863;
	Mon, 18 Aug 2025 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550640; cv=none; b=fTcnXgPXYQDXmqAFWkXsdlxNTp3e9amooNh3zh8eHuV9rRBXyZL80viBpBJO5kru6ljW1axNPS1Y32NrAr5w9sKRfYkFBKUAZI8dnCB7KrKs0sfzKODwf3M1hkRiQfL7edCzpBsmZ0v1XUz+EUTXOyAivzXJSC5XOvRnauZfUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550640; c=relaxed/simple;
	bh=UzeZX8fOjHw0e510IMB/ad2rM/hW7VREZRVqo/Zesl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3V5H2bUVgzuuXCemkv5ygwTdBjZ7V+QOPRk4mIa5k96fHXY5JNEgglZ+jBYt8c2WyDTe5M0HEBmhrhXc/vqigs/RYU4nGpLgolc3PvkM8DnCTrI4xy2ELSihr3B0w4G7CrUBMXgv8VRKWVN3bFqkX+X2+/4Vc6rcrsBRTnBR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlzPjmj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B65C4CEF1;
	Mon, 18 Aug 2025 20:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550640;
	bh=UzeZX8fOjHw0e510IMB/ad2rM/hW7VREZRVqo/Zesl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlzPjmj/VkbdNBtgJSfkFnvdC3fAG9hYzmetv/0JmuMhuGYmI1BZ1vq3LkiP22aai
	 dmo2KSe9DUK1WHi3k7kpR+8madfTa4Xklf9YelaSjgyCQlSPb2YRs94zb3iuNiJK+5
	 B8GBAGrDxC6jwesT0Nkeh4knBLZLD2xy1y/pD2xKO5iD/VdOysZ3NdwfhacpfLJ7WN
	 eI4AN+os5wPjfVd36y8Z7Bm42WDvyw/7rDxGEk2mSxzecS9FWKQ43rgMrjUasm9hR1
	 iND2Tn1hdYJ9V7RBcpM+uky/TgBEZJecdp4CWsewAxDest9kX5Xb9boL/Zkac4jlik
	 d/WdzzxO6OAxQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next v3 5/5] sctp: Stop accepting md5 and sha1 for net.sctp.cookie_hmac_alg
Date: Mon, 18 Aug 2025 13:54:26 -0700
Message-ID: <20250818205426.30222-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818205426.30222-1-ebiggers@kernel.org>
References: <20250818205426.30222-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The upgrade of the cookie authentication algorithm to HMAC-SHA256 kept
some backwards compatibility for the net.sctp.cookie_hmac_alg sysctl by
still accepting the values 'md5' and 'sha1'.  Those algorithms are no
longer actually used, but rather those values were just treated as
requests to enable cookie authentication.

As requested at
https://lore.kernel.org/netdev/CADvbK_fmCRARc8VznH8cQa-QKaCOQZ6yFbF=1-VDK=zRqv_cXw@mail.gmail.com/
and https://lore.kernel.org/netdev/20250818084345.708ac796@kernel.org/ ,
go further and start rejecting 'md5' and 'sha1' completely.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/networking/ip-sysctl.rst | 3 ---
 net/sctp/sysctl.c                      | 4 +---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 3d6782683eee7..43badb338d22b 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -3509,13 +3509,10 @@ cookie_hmac_alg - STRING
 	Valid values are:
 
 	* sha256
 	* none
 
-	md5 and sha1 are also accepted for backwards compatibility, but cause
-	sha256 to be selected.
-
 	Default: sha256
 
 rcvbuf_policy - INTEGER
 	Determines if the receive buffer is attributed to the socket or to
 	association.   SCTP supports the capability to create multiple
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 19acc57c3ed97..15e7db9a3ab2e 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -399,13 +399,11 @@ static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 		tbl.data = tmp;
 		tbl.maxlen = sizeof(tmp) - 1;
 		ret = proc_dostring(&tbl, 1, buffer, lenp, ppos);
 		if (ret)
 			return ret;
-		if (!strcmp(tmp, "sha256") ||
-		    /* for backwards compatibility */
-		    !strcmp(tmp, "md5") || !strcmp(tmp, "sha1")) {
+		if (!strcmp(tmp, "sha256")) {
 			net->sctp.cookie_auth_enable = 1;
 			return 0;
 		}
 		if (!strcmp(tmp, "none")) {
 			net->sctp.cookie_auth_enable = 0;
-- 
2.50.1


