Return-Path: <netdev+bounces-27425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74E77BF17
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8796280EB4
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8150C8F6;
	Mon, 14 Aug 2023 17:37:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE58C8EB
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 17:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD1CC433C7;
	Mon, 14 Aug 2023 17:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692034621;
	bh=cDPlgBw5S5xhkfFBWcoL5zvdNPpfcmEUkF9ljX0IBW0=;
	h=From:Date:Subject:To:Cc:From;
	b=kAz1BARj+fy/6hDM8NgaPXUfMGHgk32ZdC4Kfg+Re9UODLQZk5/B3K5pWK/qV2svD
	 wAIdPaZHfZ2tYlrFqaCybahKZPRgHEVqHKsWuF+BYw2Z379CgS0O1Tvsj/cKnBIrau
	 F0dqZ2HOouAOnlRYcAwYysV9YkepoPhFpX7oUQyuA5WxGjmlezTf30L2zOeqX2/kp+
	 hG+MHZX3hAeFFNx9GSr8RGRWy4MwTZSVe7kCguSpC9tNCPQgwouiI3E7W2Y4ZPIJWW
	 gRjZUCjAdccoHraXKm3YdUoPt8no9K+7yartQz7wBhUB4SvUY8iJq3gRFhRppPFxzD
	 IovYPoZmyRxJQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Aug 2023 13:36:54 -0400
Subject: [PATCH v2] sunrpc: set the bv_offset of first bvec in
 svc_tcp_sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-sendpage-v2-1-f56d1a25926c@kernel.org>
X-B4-Tracking: v=1; b=H4sIADVm2mQC/22MQQ7CIBAAv9LsWQxQGtCT/zA9tLJtNxpoFkNsG
 v4u9uxxJpPZISETJrg2OzBmShRDBX1q4LEMYUZBvjJoqVvplBEJg1+H6kdpnDWIXpsL1HxlnOh
 zrO595YXSO/J2nLP62T+TrIQSvuvUKL2dnJW3J3LA1znyDH0p5QtSzhfloQAAAA==
To: Chuck Lever <chuck.lever@oracle.com>
Cc: David Howells <dhowells@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cDPlgBw5S5xhkfFBWcoL5zvdNPpfcmEUkF9ljX0IBW0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk2mY7awGmJCfeWTAgJEK6AXhpQK9BLSR8YVKkD
 eC0cjAVIL6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNpmOwAKCRAADmhBGVaC
 FXMmD/99S58weqEFaFFrknujoZRCHQK0ghaf+4FZXASFOik851ITWAa0AFylrb0WMRfmvZ/p8Nj
 gsMuJQw1ULJB62jrorHKag3is7uzp+6kn0acwowaPlvGGPEK6yjkuOk/klovWk3QjdROM+/Rvn5
 7wHwCxSvMgoLhWVpJC5zx1wifiYMdW7TKJanfX1ckgTxc67+2XRC0vskr1/aauqgPjcaXDx/RvA
 MEq8dkI/0R3eFB1AUtRZvgKSrBOg+RwFIq4GjQ5FoG9OvVt/ofONz0vQZgl5QCwfbLtyA0BfC6G
 AM6S7T3vwURd5f3S+bIL4pkzdhWyAuqeHGdsB6HlvD9m1+rAzlw7bWqb7+Qi9AK55UECcEGZb6p
 3a128ouN6h6vArdYh+T2RcvZzNODkZtsYuvDe7ABhQFbwIeTfuUxFQG+ZETxp7ILIFJ5I5GnvRU
 JSu9AZsNKlPgvPjXwu5+LVxHRL+6miQPrRy2tmMbJQ2jtLXvGtjdWza8hWpptchzOpsYmrVBWZA
 DGzDHrne0tppUgwrieYFPxyIeSJBuLE747shk8d7vn0Qnt7YMiMD+m+JRsWvnQyw/UaoZhWvbnB
 XeYTsZJaMJ1u18dALl/Buxe2tlutIbOdhiI1tzzHFRiMEtDiqXEqKFqBqeZwKwf/zF+Dcw8wlh+
 LZed3xv98zDCdAA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

svc_tcp_sendmsg used to factor in the xdr->page_base when sending pages,
but 5df5dd03a8f7 dropped that part of the handling. Fix it by setting
the bv_offset of the first bvec.

Fixes: 5df5dd03a8f7 ("sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- limit the change to just svc_tcp_sendmsg
---
 net/sunrpc/svcsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e43f26382411..2eb8df44f894 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1244,6 +1244,9 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 	if (ret != head->iov_len)
 		goto out;
 
+	if (xdr_buf_pagecount(xdr))
+		xdr->bvec[0].bv_offset = offset_in_page(xdr->page_base);
+
 	msg.msg_flags = MSG_SPLICE_PAGES;
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
 		      xdr_buf_pagecount(xdr), xdr->page_len);

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-sendpage-b04874eed249

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


