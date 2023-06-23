Return-Path: <netdev+bounces-13398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF273B6FE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778DE1C211C1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B32311C;
	Fri, 23 Jun 2023 12:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDD211F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:20:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5971BE4
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687522824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mX02EQjfhnvNS52lhiZUHESdDzM2wywpph+bQHFJGEw=;
	b=MJ3l5OBqNNqfkQIYemXKX/XaL9JsE51oTfxfP3jiabwcyrbORqLG8nVoKuTr8fJDesxf7i
	CPaS8RiCaHc+x1PGy9SOGtQUOjoKPaOfvC2soLYNUOFxgkedBiMavQckHI6Kf7zdQINy3S
	eKfvkARV1IRpOco7rBKONRUX1ngU2UQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-ic0HvJDqMSC6QC2RFc0Bxg-1; Fri, 23 Jun 2023 08:20:19 -0400
X-MC-Unique: ic0HvJDqMSC6QC2RFc0Bxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C7141C06EE2;
	Fri, 23 Jun 2023 12:20:18 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E3E3422B0;
	Fri, 23 Jun 2023 12:20:16 +0000 (UTC)
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
Subject: [PATCH net 1/2] selftests: mptcp: join: fix 'delete and re-add' test
Date: Fri, 23 Jun 2023 14:19:51 +0200
Message-ID: <927493b7ba79d647668e95a34007f48e87c0992a.1687522138.git.aclaudi@redhat.com>
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

mptcp_join '002 delete and re-add' test currently fails in the 'after
delete' testcase.

This happens because endpoint delete includes an ip address while id is
not 0, contrary to what is indicated in the ip mptcp man page:

"When used with the delete id operation, an IFADDR is only included when
the ID is 0."

This fixes the issue simply not using the $addr variable in
pm_nl_del_endpoint().

Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0ae8cafde439..5424dcacfffa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -678,7 +678,7 @@ pm_nl_del_endpoint()
 	local addr=$3
 
 	if [ $ip_mptcp -eq 1 ]; then
-		ip -n $ns mptcp endpoint delete id $id $addr
+		ip -n $ns mptcp endpoint delete id $id
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr
 	fi
-- 
2.41.0


