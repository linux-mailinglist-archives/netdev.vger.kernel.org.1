Return-Path: <netdev+bounces-27145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B2077A7A0
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47E91C20941
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531DC8479;
	Sun, 13 Aug 2023 15:49:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EB6FA6;
	Sun, 13 Aug 2023 15:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC52C433CB;
	Sun, 13 Aug 2023 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691941791;
	bh=x3HieLW9cfurSYDpothN2/+z9d/SdO6GPKjgP7Yf04w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+iMDuC1UgA1kZKApI97/cnWgmdLxwqYR4CXLdkZDP08yn1NIWPWxKcBwXViQgCFA
	 7ZkQ9hhMfzMvQI0+CWlgGkG7asNxv1UmjX5ol04KfmVOeu++kXHxUqGkUDBqSKEz56
	 p6PoRP4s5RRBMC8yoESZz2s3q5wDtQjZ4kf1010+scMc7mSILdUD2UCHrjWQ+VW/k/
	 qEA4/KLgp9pAWJPEjhGbKzJ3TPzZAHqifUTPtwJtIWAMbgpoWtAxNpmIAHldZb8YeY
	 5eMR+Qwg/8KYvGIjZvQIa7q/qd2jl1q+cbNOy6+J+sPfi3fEHsHL82Rki+mSxCCI4J
	 HQLwOSFyDtvgA==
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
Subject: [PATCH AUTOSEL 6.4 09/54] 9p: virtio: fix unlikely null pointer deref in handle_rerror
Date: Sun, 13 Aug 2023 11:48:48 -0400
Message-Id: <20230813154934.1067569-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <asmadeus@codewreck.org>

[ Upstream commit 13ade4ac5c28e8a014fa85278f5a4270b215f906 ]

handle_rerror can dereference the pages pointer, but it is not
necessarily set for small payloads.
In practice these should be filtered out by the size check, but
might as well double-check explicitly.

This fixes the following scan-build warnings:
net/9p/trans_virtio.c:401:24: warning: Dereference of null pointer [core.NullDereference]
                memcpy_from_page(to, *pages++, offs, n);
                                     ^~~~~~~~
net/9p/trans_virtio.c:406:23: warning: Dereference of null pointer (loaded from variable 'pages') [core.NullDereference]
        memcpy_from_page(to, *pages, offs, size);
                             ^~~~~~

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 3c27ffb781e3e..2c9495ccda6ba 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -384,7 +384,7 @@ static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
 	void *to = req->rc.sdata + in_hdr_len;
 
 	// Fits entirely into the static data?  Nothing to do.
-	if (req->rc.size < in_hdr_len)
+	if (req->rc.size < in_hdr_len || !pages)
 		return;
 
 	// Really long error message?  Tough, truncate the reply.  Might get
-- 
2.40.1


