Return-Path: <netdev+bounces-230706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50507BEDDDD
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 04:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD6214E12AC
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 02:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0511DEFE8;
	Sun, 19 Oct 2025 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jVh0cqPA"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22481C6FE8;
	Sun, 19 Oct 2025 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841566; cv=none; b=PsqHTcaT8JYy09lS0Jr3RCB1wHHGMiNYmNYDyTRR77thikkkZ4FS5pTyGKPuw5la+ELbqX16TwZZALN7eVrMWxT1kMOZXYEF/zymATzcJp3w5O8urRskvjZWKnal7MRmZkSJmIvycVQV4X+dKtcNCpP/RzOnPqYAfdMxs069WxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841566; c=relaxed/simple;
	bh=sCtsbj6s9oWOlzyh+nVvunK7ciprDxlQlO5meosER2g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aPzJ4+AgE3ssqrfuLMDu/ijRJ4gV2BbBxSTV0Umha15lY6r4PUJetuoH7brokc4gOQj+KM+bZsvkOQ0Z4Q146nGS4stQtcXMKJhMcpyJkLkvpNGmYBKIUgODfF2m1CUh09Iv8jThhjB3ZFDmbfF8NXdVfY2vFgAC9QkhiiJjZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jVh0cqPA; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760841253; bh=gfJdpZg6Mj7jnPrEFI526WVKOg9mgU+VkBgk5IUIq98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jVh0cqPATNBEAWRQ98psdQ9aEZ7S8+pcVMqIbMjUytle0Huo1TPEG/lQaN1yD1ort
	 BctcRQi+IuHJNbLuCk/93KeOwjUGRVVAJNq0TnRX28giQJGghkLBRMXfAEKbPdBGjN
	 AoOQAMGykuRkhFExeL5OkAF5wltuhf0A6wOmb14w=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 88B06417; Sun, 19 Oct 2025 10:34:11 +0800
X-QQ-mid: xmsmtpt1760841251t29lg3kol
Message-ID: <tencent_57525DE2DDF41911CFDB8DF525A08D9D9207@qq.com>
X-QQ-XMAILINFO: MrK54zaStYC/mP5UifaMTcP2S/rcYU8ZKdmkuw0SyrrjBp0Mljn4X0BD9pjcdZ
	 V364lhPTMJOJ8WcE7hnLRf+KCVtRM9Z7eYC/+FP5yh9ILVn6Gf0BVoV/KoQOe3hcN4ss0H2ub+0/
	 VzxbYa8anVhr8MDthz4eXcr3iWahklvlWYzFWtNF3pcaQ8+s67b3u/jd5PImBmPd4UpA6lB+IYKC
	 xqLQdxNg7at/28NtH9+pFQOjh7uVAJQIO/oyhcnPPCB49wPWiakyHQFkeOezSypDoqfsp8rd+Exw
	 tAnFgucY6exr8w+Ngex5NKBBNo2GF1F9R1hy2xE9h6WAV40p+EO54b+bJBZ+Y804xdWXz1Ljr+CR
	 VPsNN7NEQtjEbnxbzdBeqlwsB3hGrrlPoJeTbMlCY/2rsW50HxuKnvc8SsqAy2em7wMB+RqTdZM6
	 Yck568bCYiS3sBKSC6eGmRe+uWnSaNo+P98Rr41Mn0xzYaUae4lTyuBidT6o1hJGduK9aiFMDJoO
	 ylqUnMcofhYUMvnHeMh3mvtyAQHVvXragcJNiXKvCxEbIjF8Qre7NeK7tCXreKGBRmKWcD9+K2Fe
	 6iip3GyJEEhKBXRXLr6xWXcGhsD6RaJqHG2IpdrY2nwvmzMRx7yIX/Nn3ov6PpUFgwG080Y6EfsT
	 PJEPhDFoD2o/QYwQDIxxrKU1djE227JwOF8UcnZ/Q5S/cM+YrlXaEcypN+ai2MiBp92NJgAF0zvq
	 0WWqn7wp9VuqZf5uF6Glrbm87OG3qisMwo6NrFYB7zHy7WAfTRJeQ1r9+eO7hHiPyG0PIh1ujAXR
	 UniNiv3IGTOoYRh1fzxVbPyuX2GsTFoDiLKTihx2ad8b0logZbY4Oj4cCLxdnfOGwrkiH30ON67U
	 MOSprYV58WHbw6p9f4lqdFmi0Nnmoq0tmkoPU6gGOr/AyJ+v2a0Ve9NHWhJjjO6T+39V7PCooMAU
	 tzq/gUBsmHe67geXG+bJMaG9DblDrATkHZkFkFE2tKcg0BfV5nFUkqB28bNCKW
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] key: No support for family zero
Date: Sun, 19 Oct 2025 10:34:11 +0800
X-OQ-MSGID: <20251019023410.2613678-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
References: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting the extended skb data for sadb_x_ipsecrequest, the requested
extended data size exceeds the allocated skb data length, triggering the
reported bug.

Because family only supports AF_INET and AF_INET6, other values will cause
pfkey_sockaddr_fill() to fail, which in turn causes set_ipsecrequest() to
fail.

Therefore, a workaround is available here: using a family value of 0 to
resolve the issue of excessively large extended data length.

syzbot reported:
kernel BUG at net/core/skbuff.c:212!
Call Trace:
 skb_over_panic net/core/skbuff.c:217 [inline]
 skb_put+0x159/0x210 net/core/skbuff.c:2583
 skb_put_zero include/linux/skbuff.h:2788 [inline]
 set_ipsecrequest+0x73/0x680 net/key/af_key.c:3532

Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/key/af_key.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..e658c129b38f 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3526,6 +3526,9 @@ static int set_ipsecrequest(struct sk_buff *skb,
 	int socklen = pfkey_sockaddr_len(family);
 	int size_req;
 
+	if (!family)
+		return -EINVAL;
+
 	size_req = sizeof(struct sadb_x_ipsecrequest) +
 		   pfkey_sockaddr_pair_size(family);
 
-- 
2.43.0


