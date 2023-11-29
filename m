Return-Path: <netdev+bounces-52251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147097FE059
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C43282A67
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468FC5EE64;
	Wed, 29 Nov 2023 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awrgNbiN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D85E0DB
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 19:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC03C433C7;
	Wed, 29 Nov 2023 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701286586;
	bh=79dosphHR5M91WboD4NS+WjCpX1ctQsCyv3C4mQvWEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awrgNbiNMl/hhuy5zrqMO4CBqZI2Mt2XHstc41eM552JkQ5TOSSYVJzPpChwnivcE
	 IbUpKHYyauQwlGE6rwHZ4ew/73N57qDrRMDVYf04ZU4/E42LgIOvw9fRbTY4a4m/jQ
	 DZ9h29bTEhe/TN8TFOG/W0tbYrUzsrQAzKqRHILFOkamI0PZJIXkmR6M9bJKkLoQh7
	 F0ULOWq60AKzE62kkyNwg2AGui5qks4RxNKq9Db4Rw+6ZSTOn0bPq9SAxsf6478rbk
	 ofdrNedki6rQkreIazn3oHlA98KcYy2hDI2nkI08Urzt7DIktuRW5SFAXAdn1F8Jyh
	 N25Jna3/vTT9A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org
Subject: [PATCH net-next 1/4] tools: ynl: fix build of the page-pool sample
Date: Wed, 29 Nov 2023 11:36:19 -0800
Message-ID: <20231129193622.2912353-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129193622.2912353-1-kuba@kernel.org>
References: <20231129193622.2912353-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The name of the "destroyed" field in the reply was not changed
in the sample after we started calling it "detach_time".

page-pool.c: In function ‘main’:
page-pool.c:84:33: error: ‘struct <anonymous>’ has no member named ‘destroyed’
   84 |                 if (pp->_present.destroyed)
      |                                 ^

Fixes: 637567e4a3ef ("tools: ynl: add sample for getting page-pool information")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
---
 tools/net/ynl/samples/page-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/samples/page-pool.c b/tools/net/ynl/samples/page-pool.c
index 18d359713469..098b5190d0e5 100644
--- a/tools/net/ynl/samples/page-pool.c
+++ b/tools/net/ynl/samples/page-pool.c
@@ -81,7 +81,7 @@ int main(int argc, char **argv)
 		struct stat *s = find_ifc(&a, pp->ifindex);
 
 		count(s, 1, pp);
-		if (pp->_present.destroyed)
+		if (pp->_present.detach_time)
 			count(s, 0, pp);
 	}
 	netdev_page_pool_get_list_free(pools);
-- 
2.43.0


