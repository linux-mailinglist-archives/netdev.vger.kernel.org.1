Return-Path: <netdev+bounces-13399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15773B700
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8B5281B33
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A579CF;
	Fri, 23 Jun 2023 12:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33F847D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:20:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213361BE4
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687522826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7w28TmyVUkzxBrhSnDkK83nu5AG7TtMwzVrLBGQioEg=;
	b=jQixV3sKSfMAKX+0UaJ+vQcR9AnKxBDCsGhMCUe4kiTarCzqZdpqb6ZKAmFkCwm5kucRbz
	Iy7Js6aNcnVc0GDX5RI9L88oF7BvTzxvdox5z4uu6wBXi521rBvjS+q/xa1mUR7gLjLupI
	6Cnfd4TokEAkbwg68NXdiNub3hb786I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-3cnU_LpROiOZ9NZwEaM36Q-1; Fri, 23 Jun 2023 08:20:22 -0400
X-MC-Unique: 3cnU_LpROiOZ9NZwEaM36Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D1BC29A9D35;
	Fri, 23 Jun 2023 12:20:21 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B5ABF41C8;
	Fri, 23 Jun 2023 12:20:18 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net,
	martineau@kernel.org,
	geliang.tang@suse.com
Subject: [PATCH net 2/2] selftests: mptcp: join: fix 'implicit EP' test
Date: Fri, 23 Jun 2023 14:19:52 +0200
Message-ID: <70e1c8044096af86ed19ee5b4068dd8ce15aad30.1687522138.git.aclaudi@redhat.com>
In-Reply-To: <cover.1687522138.git.aclaudi@redhat.com>
References: <cover.1687522138.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

mptcp_join '001 implicit EP' test currently fails because of two
reasons:

- iproute v6.3.0 does not support the implicit flag, fixed with
  iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
  flag")
- pm_nl_check_endpoint wrongly expects the ip address to be repeated two
  times in iproute output, and does not account for a final whitespace
  in it.

This fixes the issue trimming the whitespace in the output string and
removing the double address in the expected string.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5424dcacfffa..6c3525e42273 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -768,10 +768,11 @@ pm_nl_check_endpoint()
 	fi
 
 	if [ $ip_mptcp -eq 1 ]; then
+		# get line and trim trailing whitespace
 		line=$(ip -n $ns mptcp endpoint show $id)
+		line="${line% }"
 		# the dump order is: address id flags port dev
-		expected_line="$addr"
-		[ -n "$addr" ] && expected_line="$expected_line $addr"
+		[ -n "$addr" ] && expected_line="$addr"
 		expected_line="$expected_line $id"
 		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
 		[ -n "$dev" ] && expected_line="$expected_line $dev"
-- 
2.41.0


