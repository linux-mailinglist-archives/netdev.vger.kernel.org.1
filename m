Return-Path: <netdev+bounces-33217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8598279D0BD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC181C21084
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809718049;
	Tue, 12 Sep 2023 12:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F39443
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:06:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 331E510D0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694520399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tX6yWckEp0zjVKcWR1lfoEzSymqYQ6Dx9WYErV4NIQ4=;
	b=VnjOmMSuPjuuQECxjmWKr7GF8e/bcdyosQr94G8tPJcsbQWXtwadfn2Wexu1jjrJelqbMd
	ZoLq7PwExUsoBvJQtbO6dP8eTBw/U18h6tghUXtqZXYMbc0Mwj/CsQJht/SyB80pgr1Lc+
	H7NgP0hN7kBiY1CQ0FU42Gp+OngXQu8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-SxgM-UXoMPmCmZdOPiUJOQ-1; Tue, 12 Sep 2023 08:06:35 -0400
X-MC-Unique: SxgM-UXoMPmCmZdOPiUJOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 952668D3BC3;
	Tue, 12 Sep 2023 12:06:34 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55D5710F1BE7;
	Tue, 12 Sep 2023 12:06:33 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf] selftests/bpf: fix unpriv_disabled check in test_verifier
Date: Tue, 12 Sep 2023 14:06:31 +0200
Message-ID: <20230912120631.213139-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3

Commit 1d56ade032a49 changed the function get_unpriv_disabled() to
return its results as a bool instead of updating a global variable, but
test_verifier was not updated to keep in line with these changes. Thus
unpriv_disabled is always false in test_verifier and unprivileged tests
are not properly skipped on systems with unprivileged bpf disabled.

Fixes: 1d56ade032a49 ("selftests/bpf: Unprivileged tests for test_loader.c")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 31f1c935cd07d..98107e0452d33 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1880,7 +1880,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	get_unpriv_disabled();
+	unpriv_disabled = get_unpriv_disabled();
 	if (unpriv && unpriv_disabled) {
 		printf("Cannot run as unprivileged user with sysctl %s.\n",
 		       UNPRIV_SYSCTL);
-- 
2.41.0


