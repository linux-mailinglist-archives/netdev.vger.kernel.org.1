Return-Path: <netdev+bounces-115821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB2947E3B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14567B26A16
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A893156C74;
	Mon,  5 Aug 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUjcTmPI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDD1547DC;
	Mon,  5 Aug 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872150; cv=none; b=Ap3ZkDqVbFnsxDQFnOIjzQkuOQ6w3xNVHvPUfmyHvqasSTZZb7HU0CquNwsDXCszgaCnFnXa/WyJfQKHBrZT05gYll1hXDQRIYxHIvXfcI0UcQjVSF4HWpeFWWS71a2Z5O+XH950jCgMkR+C3G4WKOXt/vyq0uUmfRUYeUGVKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872150; c=relaxed/simple;
	bh=1T65BTREZAzA1mwKODA15SxcPeUL6S7m/EuVSSny7ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bs37CNZm4s6x7S1DGzMLfnWkndGjhNi0dPfK7NYH+FmqQ55bb8mFkmm7m4u8OsflcveifPWxWXAg/YNrqWEwaFkqbzei86TLgNv4k594mbYELmtau8gMD6KsozLbRfVN+00q2EAn3pcH/byzsGR9/JvIXv0AxPD4h922ZKrWfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUjcTmPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D485FC4AF0C;
	Mon,  5 Aug 2024 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722872149;
	bh=1T65BTREZAzA1mwKODA15SxcPeUL6S7m/EuVSSny7ZI=;
	h=Date:From:To:Cc:Subject:From;
	b=tUjcTmPIxnQU3NeJkkLkZ4dkbX6uao1ubb+JSZtl3HjNouOS0BmolbYBHsvL/ISp/
	 ULENOkg9xJr8p+5mIQ2Pg4ppWgf0zRpACpdkyQCkHCnRTgL/AV1IC88sSrtMKzlIdo
	 uEqgrS96gn2E+RPLNrnrNKw3iSRwhcTjj1AaYX613r8JWDKApORboicyh5kbTp90RC
	 c5sUoCITKnXrcSk6XcNDayWhTMNsHs1ijsUvzTp8X/Mnx5njHhQq/YDgFqWyjwyBVO
	 81JOK4x0gYJ4v4+8vYJsjN0JNf3xxtny9Z2U3HHuYMyVhaWZbUIZY8ElR8gVBgxpt+
	 S4DCDwUGs1naA==
Date: Mon, 5 Aug 2024 09:35:46 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] sched: act_ct: avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ZrDxUhm5bqCKU9a9@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct zones_ht_key` is a flexible structure --a structure that
contains a flexible-array member.

Fix the following warning:
net/sched/act_ct.c:57:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/sched/act_ct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 3ba8e7e739b5..b304ef46b5be 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -54,9 +54,11 @@ struct tcf_ct_flow_table {
 	struct rcu_work rwork;
 	struct nf_flowtable nf_ft;
 	refcount_t ref;
-	struct zones_ht_key key;
 
 	bool dying;
+
+	/* Must be last - ends in a flex-array member. */
+	struct zones_ht_key key;
 };
 
 static const struct rhashtable_params zones_params = {
-- 
2.34.1


