Return-Path: <netdev+bounces-73354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CFB85C0CC
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB91428417E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBBB763E5;
	Tue, 20 Feb 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEBjy4eJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9289762FD
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445478; cv=none; b=ocnJGI4u1F3ghvxtXczGF3zlJcN9/ea8jEemoVKMGJoWYbl2ucM6anWuo0LekjGOFCdmCR4Ad1j9Q277zgc5zFEsWwBMzBCF1QbK5kNDTG37UXaIKhY0a7gCCDhy9auO2pCtBVQ21tfRTc2gl5NJ9THejb+++VkAyxm230TgVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445478; c=relaxed/simple;
	bh=BkRoByV+nAICi8CId3r6ZBlADUfuNfb9jDo7SCrPZXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehDAFj+mdZWDddsi3AtLV19YQGkwXGyyAjAO0OkNMal5dCw4IX7plXiGAmdioPkZ5YSUBSsl04muA7W8NdLgY1C3f7XDDKERvnOIRboIQI7uG2L6ahRusApOchCcziLKk8Hrqv7ZynP7tYBODSDwaExDrjcT6sHQ6R8gvA6a1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEBjy4eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E18C43390;
	Tue, 20 Feb 2024 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708445478;
	bh=BkRoByV+nAICi8CId3r6ZBlADUfuNfb9jDo7SCrPZXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEBjy4eJ0fNphXNM6P5jsrDsfeG9xnYY16J00M6FYVV4A0aZytXkKqFFHwE2Ypbyi
	 q6NKSAXwPqnd5AZ17gVlacWHffrBBYZ6bvsdF+na+c5+LZe6lhVyJiCLe3qWzWyquo
	 GkQtlhAUPyiAaZsWvIuG+PRcQTEEWcg92ZFXFf4AxQvcipcvjNdiqGXJuJ7kOHfcSl
	 Sq8I00sfdT6cV1feIjxiHrgBPfVW0Cn+li//WQTxV5zvTEf3QROetseeRecBwDgo+W
	 +NzS73WFUAotIjJPfud5AoDZub5lmGox8DzyvfV7+Bu7MO0j+AvOlEx0wg3HZmw/+B
	 bOrW7SnX8VnDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	chuck.lever@oracle.com,
	jiri@resnulli.us,
	nicolas.dichtel@6wind.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 1/2] tools: ynl: make sure we always pass yarg to mnl_cb_run
Date: Tue, 20 Feb 2024 08:11:11 -0800
Message-ID: <20240220161112.2735195-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220161112.2735195-1-kuba@kernel.org>
References: <20240220161112.2735195-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is one common error handler in ynl - ynl_cb_error().
It expects priv to be a pointer to struct ynl_parse_arg AKA yarg.
To avoid potential crashes if we encounter a stray NLMSG_ERROR
always pass yarg as priv (or a struct which has it as the first
member).

ynl_cb_null() has a similar problem directly - it expects yarg
but priv passed by the caller is ys.

Found by code inspection.

Fixes: 86878f14d71a ("tools: ynl: user space helpers")
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Further cleanup to enforce the types in net-next..
---
CC: nicolas.dichtel@6wind.com
CC: willemb@google.com
---
 tools/net/ynl/lib/ynl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index c82a7f41b31c..9e41c8c0cc99 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -466,6 +466,8 @@ ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version)
 
 int ynl_recv_ack(struct ynl_sock *ys, int ret)
 {
+	struct ynl_parse_arg yarg = { .ys = ys, };
+
 	if (!ret) {
 		yerr(ys, YNL_ERROR_EXPECT_ACK,
 		     "Expecting an ACK but nothing received");
@@ -478,7 +480,7 @@ int ynl_recv_ack(struct ynl_sock *ys, int ret)
 		return ret;
 	}
 	return mnl_cb_run(ys->rx_buf, ret, ys->seq, ys->portid,
-			  ynl_cb_null, ys);
+			  ynl_cb_null, &yarg);
 }
 
 int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
@@ -741,11 +743,14 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 
 static int ynl_ntf_trampoline(const struct nlmsghdr *nlh, void *data)
 {
-	return ynl_ntf_parse((struct ynl_sock *)data, nlh);
+	struct ynl_parse_arg *yarg = data;
+
+	return ynl_ntf_parse(yarg->ys, nlh);
 }
 
 int ynl_ntf_check(struct ynl_sock *ys)
 {
+	struct ynl_parse_arg yarg = { .ys = ys, };
 	ssize_t len;
 	int err;
 
@@ -767,7 +772,7 @@ int ynl_ntf_check(struct ynl_sock *ys)
 			return len;
 
 		err = mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
-				  ynl_ntf_trampoline, ys,
+				  ynl_ntf_trampoline, &yarg,
 				  ynl_cb_array, NLMSG_MIN_TYPE);
 		if (err < 0)
 			return err;
-- 
2.43.0


