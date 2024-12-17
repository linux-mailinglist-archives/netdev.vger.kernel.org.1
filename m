Return-Path: <netdev+bounces-152478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A9C9F411B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 04:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B834169116
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18F76025;
	Tue, 17 Dec 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2FvIFws"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D91E529;
	Tue, 17 Dec 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734404400; cv=none; b=SW4+d6soNhXAcrIqBf+G8NegteksbNn4madi6Gk+izd6QOJsJCT28nihQPgRaT9/38/MyntSIUCdULqD9DydMvNmHrAET7asN9pKTb3Eav8NkKRp+afXP7qg+B3nFYbLWlnFPMB4MI2Foxy3GD4LUrj1s68qJ9SLQ8KXYs8hCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734404400; c=relaxed/simple;
	bh=9dQhrqRK+R/Veko5MsdHHHznj3Ffk32kbXw0+H2KeTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MdZXKy+KCrjyemdPJ7yEzqGx4JWvSp+s6kmwKJ7m2ERxjt2CE8Y8S22oouNAsDA3FCDz28+tZjgYp+8at6wbzDDoXoSk6/R0w0uFM88FHrOyXaLNNoKguYDmpOAt680szryxgXPrpKVhSa1m3uBQb3T4z1AvxGhTkkMwbZVAP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2FvIFws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19E4C4CED0;
	Tue, 17 Dec 2024 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734404400;
	bh=9dQhrqRK+R/Veko5MsdHHHznj3Ffk32kbXw0+H2KeTc=;
	h=From:To:Cc:Subject:Date:From;
	b=P2FvIFwsRLdK9rBdwik1/dN2Po04NmqQQv93gE/PDf9K1t/s9RxO26AWq4HYo1oZY
	 BNXR2Op3kP9S3vle1dHmfCYRijh5LoKDfbJkwhv6fvFn7kMt182JqL8rhij3fvd3vS
	 Pw9AUWjLEh4RWi+6eZFz/3/v9OJeNj8OTBgX+NU66QtZHFXkNXVHkskUQ6gnnNIjgY
	 0+6YmXhoz65uvrA3H6UnhoX2P8gj83utw6kp34ieCZBAbRAuqiq9lCyAC4Zwym1zla
	 u3jLEcTvLdBOENNtN1QRDur3ZghAq3r76SniMmQk2qHTBS5l1dbYra6X1w2S8IgzgA
	 r8OtB6/UUMu+A==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	cferris@google.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex struct tc_u32_sel
Date: Mon, 16 Dec 2024 18:59:55 -0800
Message-Id: <20241217025950.work.601-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=kees@kernel.org; h=from:subject:message-id; bh=9dQhrqRK+R/Veko5MsdHHHznj3Ffk32kbXw0+H2KeTc=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkJL7W7cjrdvu/PtXR4fEG7UGH5mZdaMcpnchqmvA4S4 2uY+mNDRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwES8DjL8D/3hm9H6M+PvfKYz rFf1JlX7O+btyZO5puh35NvX7c2x1Qz/wxXFgxZ1J51TDd98VkzrzZPtD8R87Gcu2RKb0nhRai0 7MwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This switches to using a manually constructed form of struct tagging
to avoid issues with C++ being unable to parse tagged structs within
anonymous unions, even under 'extern "C"':

  ../linux/include/uapi/linux/pkt_cls.h:25124: error: ‘struct tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,’ invalid; an anonymous union may only have public non-static data members [-fpermissive]

To avoid having multiple struct member lists, use a define to declare
them.

Reported-by: cferris@google.com
Closes: https://lore.kernel.org/linux-hardening/Z1HZpe3WE5As8UAz@google.com/
Fixes: 216203bdc228 ("UAPI: net/sched: Use __struct_group() in flex struct tc_u32_sel")
Link: https://lore.kernel.org/r/202412120927.943DFEDD@keescook
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
---
 include/uapi/linux/pkt_cls.h | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 2c32080416b5..02aee6ed6bf0 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -245,20 +245,28 @@ struct tc_u32_key {
 	int		offmask;
 };
 
+#define tc_u32_sel_hdr_members			\
+	unsigned char		flags;		\
+	unsigned char		offshift;	\
+	unsigned char		nkeys;		\
+	__be16			offmask;	\
+	__u16			off;		\
+	short			offoff;		\
+	short			hoff;		\
+	__be32			hmask
+
+struct tc_u32_sel_hdr {
+	tc_u32_sel_hdr_members;
+};
+
 struct tc_u32_sel {
-	/* New members MUST be added within the __struct_group() macro below. */
-	__struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
-		unsigned char		flags;
-		unsigned char		offshift;
-		unsigned char		nkeys;
-
-		__be16			offmask;
-		__u16			off;
-		short			offoff;
-
-		short			hoff;
-		__be32			hmask;
-	);
+	/* Open-coded struct_group() to avoid C++ errors. */
+	union {
+		struct tc_u32_sel_hdr hdr;
+		struct {
+			tc_u32_sel_hdr_members;
+		};
+	};
 	struct tc_u32_key	keys[];
 };
 
-- 
2.34.1


