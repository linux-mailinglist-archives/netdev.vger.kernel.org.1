Return-Path: <netdev+bounces-27166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610E77A971
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F6C1C20985
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF38F5C;
	Sun, 13 Aug 2023 16:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC58F4F;
	Sun, 13 Aug 2023 16:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9539FC433C7;
	Sun, 13 Aug 2023 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691943203;
	bh=B9U2WhH6qvrp2oanbhd9mLyE74XLBa3gs4ieu7EpVvg=;
	h=From:To:Cc:Subject:Date:From;
	b=Ot2J8h4PIhgHFWIYjHzKsLoBOWuahnSxa99j1NigOcrW7yxYXaFd2vqi3pL7Pl9I+
	 XuA6worun6aBnFbaIA7tO6Xzw5mmFDMSFRE9CsPrOa6GRfXuR0HTMFqb8iAInl255M
	 x3HtNFatr6M4oKWsS6uPuAh9cCmYoVVZYO2VXWbde1DaNgkGvhZPrcgQLIeH31hgyf
	 BdQSNnpK3hizloaQxmZ3IDolwDjyPLYHJZWNVwTEM0muf0kpym3Cg+QIrpJk2nrhbM
	 RkO8soJarXGmRqZQTuS55/OGCAe/izhLjyl+kUVUrVZ0iGs5yFrcLtFVjhezLEYKJT
	 p4HfCiDaEvKEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Simon Horman <simon.horman@corigine.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/13] 9p: virtio: make sure 'offs' is initialized in zc_request
Date: Sun, 13 Aug 2023 12:13:05 -0400
Message-Id: <20230813161317.1087606-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.291
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <asmadeus@codewreck.org>

[ Upstream commit 4a73edab69d3a6623f03817fe950a2d9585f80e4 ]

Similarly to the previous patch: offs can be used in handle_rerrors
without initializing on small payloads; in this case handle_rerrors will
not use it because of the size check, but it doesn't hurt to make sure
it is zero to please scan-build.

This fixes the following warning:
net/9p/trans_virtio.c:539:3: warning: 3rd function call argument is an uninitialized value [core.CallAndMessage]
                handle_rerror(req, in_hdr_len, offs, in_pages);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index f7cd8e018bde0..6b3357a77d992 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -409,7 +409,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct page **in_pages = NULL, **out_pages = NULL;
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
-	size_t offs;
+	size_t offs = 0;
 	int need_drop = 0;
 	int kicked = 0;
 
-- 
2.40.1


