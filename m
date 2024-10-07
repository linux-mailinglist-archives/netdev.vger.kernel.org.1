Return-Path: <netdev+bounces-132680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C7992C43
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBDB25EFB
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1F1D8A16;
	Mon,  7 Oct 2024 12:42:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB71D415D;
	Mon,  7 Oct 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304927; cv=none; b=RtKWL3mbfZougyLPulFQuUxtlnGfQHZVamMC4Kb9EP0oVLl9nx+kJsRz8t2jIo1lHxHAhnATO0gw6mN4fRgDgU/umDEqvgWcCF9Ab9RTzw6m6w7NjvMsMdGd9T7OK//iYpsh6ykUINW4vM4TAHudRdfI78kokp4XTmAucTlEdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304927; c=relaxed/simple;
	bh=0ecxNdjjMUusXLGDujDykGlXNP8253S2c5pvZV3R9yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXdeylMJahFFFgYvZAz+4sHVevFs4fgtJ7pBMPXisrGDKbCTYUDQqXGMuSFUtvOHIM6MoygJrjhRCnH2TZ73k33HdCNvPFGpoDRUrHDZygrgwuLLSJ1g62eqYQDEfGlEbQUa+CX4ZuJnqy6BbwRd8uhNGd+FkQbYYKmoJ21aP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XMdwB3yvRz6LCv0;
	Mon,  7 Oct 2024 20:37:46 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id DC187140B55;
	Mon,  7 Oct 2024 20:42:02 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 7 Oct
 2024 14:41:58 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v01 4/4] selftests: net/psock_fanout: socket joins fanout when link is down
Date: Mon, 7 Oct 2024 15:40:27 +0300
Message-ID: <8965036dce0ad6c52acfdf93637fb9f5c10aff76.1728303615.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728303615.git.gur.stavi@huawei.com>
References: <cover.1728303615.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

Modify test_control_group to have toggle parameter.
When toggle is non-zero, loopback device will be set down for the
initialization of fd[1] which is still expected to successfully join
the fanout.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 tools/testing/selftests/net/psock_fanout.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index 64edcd661d43..49023d9b85b4 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -302,17 +302,22 @@ static void test_control_single(void)
 }
 
 /* Test illegal group with different modes or flags */
-static void test_control_group(void)
+static void test_control_group(int toggle)
 {
 	int fds[2];
 
-	fprintf(stderr, "test: control multiple sockets\n");
+	if (toggle)
+		fprintf(stderr, "test: control multiple sockets with link down toggle\n");
+	else
+		fprintf(stderr, "test: control multiple sockets\n");
 
 	fds[0] = sock_fanout_open(PACKET_FANOUT_HASH, 0);
 	if (fds[0] == -1) {
 		fprintf(stderr, "ERROR: failed to open HASH socket\n");
 		cleanup_and_exit(1);
 	}
+	if (toggle)
+		loopback_up_down_toggle();
 	if (sock_fanout_open(PACKET_FANOUT_HASH |
 			       PACKET_FANOUT_FLAG_DEFRAG, 0) != -1) {
 		fprintf(stderr, "ERROR: joined group with wrong flag defrag\n");
@@ -332,6 +337,7 @@ static void test_control_group(void)
 		fprintf(stderr, "ERROR: failed to join group\n");
 		cleanup_and_exit(1);
 	}
+	loopback_up_down_restore();
 	if (close(fds[1]) || close(fds[0])) {
 		fprintf(stderr, "ERROR: closing sockets\n");
 		cleanup_and_exit(1);
@@ -527,7 +533,8 @@ int main(int argc, char **argv)
 	int port_off = 2, tries = 20, ret;
 
 	test_control_single();
-	test_control_group();
+	test_control_group(0);
+	test_control_group(1);
 	test_control_group_max_num_members();
 	test_unique_fanout_group_ids();
 
-- 
2.45.2


