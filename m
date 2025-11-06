Return-Path: <netdev+bounces-236402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB1C3BDF6
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F41502BD7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E73451B2;
	Thu,  6 Nov 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="DlZ9/6P3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB403451CC;
	Thu,  6 Nov 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440328; cv=none; b=TNTgGXHp4vVV/ITw+FiE6+I92PBzly/TTH0kGS0Mt1TJA75OIZsiFBVQSeYvG+lubNGIq7NpIEDGeVxBK7FbwMIu63Q34+AyU5pZc+dxLLPW1rnNBl0GWEenIynREY3pZOXSNcgNeF1wlZRmh6DLDWSm4MBANHuVhi6OuLThmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440328; c=relaxed/simple;
	bh=SLO8XAogt0p729SfzU22YkQQYIdKzpqYUaujwFZtnVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kbKpAbfue9AehfeGr1yd2CkjTxboKb2ZXJbeb1oMpP2lsiNVVDXyHXowmdEtFRgFZCD49Gvpq5YXg5OZD/MPowK1V7MT0tN0WBZBRb3abkQS7yWrjkr7K5A+XQPCIyZfUDNOwuNeoXS5sg7XkPNx6l1IusIzIBxWPynAcwO5q10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=DlZ9/6P3; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28a8ce3b9;
	Thu, 6 Nov 2025 22:45:19 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: chuck.lever@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] net/handshake: Fix memory leak in tls_handshake_accept()
Date: Thu,  6 Nov 2025 14:45:11 +0000
Message-Id: <20251106144511.3859535-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a59a10f4403a1kunmd877133e7b53ae
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTEkaVhkdQ0tNTBlOS04dQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=DlZ9/6P39YXgRBCKj/eN1c64gHzSaYNZ98eMYYeRuIN2U04fHOJfsinKq/JtEGEqfWQYzooLP875v2rzex5eeTYjtlg2mnkGqPqHkdIXsr6+FXB63rmTgnqUlfsj+18b4U5UOEM894SuN5P08CGroqXt1iHFwipnwyclqRa955Y=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=h0YUkunlqJUAnhC/gNJ/0mAwbV93Almf7qIwemX0/vQ=;
	h=date:mime-version:subject:message-id:from;

In tls_handshake_accept(), a netlink message is allocated using
genlmsg_new(). In the error handling path, genlmsg_cancel() is called
to cancel the message construction, but the message itself is not freed.
This leads to a memory leak.

Fix this by calling nlmsg_free() in the error path after genlmsg_cancel()
to release the allocated memory.

Fixes: 2fd5532044a89 ("net/handshake: Add a kernel API for requesting a TLSv1.3 handshake")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 net/handshake/tlshd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 081093dfd553..8f9532a15f43 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -259,6 +259,7 @@ static int tls_handshake_accept(struct handshake_req *req,
 
 out_cancel:
 	genlmsg_cancel(msg, hdr);
+	nlmsg_free(msg);
 out:
 	return ret;
 }
-- 
2.34.1


