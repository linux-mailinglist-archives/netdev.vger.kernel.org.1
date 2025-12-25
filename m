Return-Path: <netdev+bounces-246030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F7DCDD28E
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 01:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37F893019BBC
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36B1A08A3;
	Thu, 25 Dec 2025 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bWH2mfr0"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90BEACE;
	Thu, 25 Dec 2025 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766623178; cv=none; b=P7UU53ZhV5T/OP+RJy7hueyM34cqUJjzwrFsbpr4td8VPk3hQguoizqSli/+lssBbm81hGDX1MUvbX07+T3o9CTF4DAW9qWHYMn3dQ5j4wHrtOXLVENSIspdFnETjBVbUiNPyjPW6XBjcvVP6OBAitylltZgyivB6uOaYPkHQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766623178; c=relaxed/simple;
	bh=cTpa9slDDP8mIuLtQ0c8nEGgOjtP9nDATw4cwgNi+R8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ARqg4f165kyXc9Po3nEl3vONhQm+3W2NLu2yDyu/slxLjaVsonaBEcpPiVug+1fILx5lDmZaqqxJJJk91nUMvgwGgif6xcw2jiFpQGPfmKUJGbVGVou+vwma2CiHTDii19MWdWZ54bKhyfs/2qRoabRxr284DEs4zzi/9aE8VoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bWH2mfr0; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1766623167; bh=9lDPljmxxpWOrB9/2KIpPiYqV9rnijI2OneHK6N8CvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWH2mfr0YhOCwi+i4EgP61AoNc/yJJsvAZbGH1qijARno3qsYXTJvAmusYn3x5ZUq
	 fso648Sc2n7DJ8oGYEIONp4dl0LnE3JtLDIV2WDl26eaHPLV2H1ikeN8IpcFbyT90J
	 XxSGaF7b93a7W114weRAC1VBRjsD3mdESTx1JUkg=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 902AAEFF; Thu, 25 Dec 2025 08:36:02 +0800
X-QQ-mid: xmsmtpt1766622962tlrisy3kd
Message-ID: <tencent_ED8C80A7CB46C0D2FF064E4987AED7AEDC06@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CiLLBdYSKfHubH75ygG1My3V5D0YPUyeHZDYmCRmgGZOT+/jksz
	 pAogx2tp5jPf5xHHCCAfTqTZp2COMoBSPT3KBFOLKs204FVsev85p6RRmgtVLEAPJCq3KeVaRP25
	 l/pX2NilOqLP5VErfK7x4aerYdoIy8GnMIO3zjaQcn5IUvhh482RbBCNFY9mNCsKONqem3w345Rp
	 7rXGYj/gwDkwegKTi+dqzdAM7GjoY9evtvT14VGwVpkYqW3W+xXfpjfQigoiQkW+KJ3GvvNXMyC9
	 fPb1+pSQKYumbscBITqJogiEmmSrq5r1k6paHym42Zl4EhQZt7hVHvMPjThzYnlcnnqEhsfRwn+B
	 n/YfWFJ9CSg/8ZzSmHcvL6vo+SNV+nOCBCJJJkk3g1+5h29/clNI5r/IjQymt3Pofv92qY1GsgS1
	 xYrCVgOiKZ3DhHjWIRsaA6OkP08EOfqFAGo2M4DkuHqTo7JkLhcycQaZRSUeszV7NzisSx3jaKwl
	 pBBj6Aoi0BvzXKJ4yRpzh6VrTwK8KN8glhtxw+Bcfmng+sEhYTUmAkyQOKvde3elGmXzuDVeNuie
	 EQfkCUk3gXn+Mzwj3+CZjBgsZp4WLkaVt2+luQ1xSP0rJnLGqhUkyhUxJtv73x67IfbWqkdeVy3b
	 ALxtGcjmTSrt4J6k9vBM+AxskvzLT2Nu4pg3IdQs28DqZu79vZzSCjoSC2xcyIsauEJaRuFSGvW0
	 LMbxkKEDYZbecNNe1gkxDxL1OOQB68WL5Y58gDRDGzkgqKkCditjqTgm4ohLLaFUfHowv2aY+B/6
	 2bAhVRewwL5BJJDnVV3z6RPDlLwOawwADdZNYXSM/hcBSScDOOvnQnU47E3KbEyc5UC2ovVG6MGB
	 HGjQJzvaPptWnj4Dn3cxtQUEfrPOggxvjS3ghd33I6Tzielige6c/6Cwr8xTb95uzMY7RpdUj43c
	 cSUbMArCf8i7h7BOjnUB1rRdXw2S2PrKbPqLjHpARH2jtgxyO9/u7vyM06AFOLwYzVMLPsAb8=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+dfffb6c26ee592ff9e83@syzkaller.appspotmail.com
Cc: chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] net/handshake: fix null-ptr-deref in handshake_complete
Date: Thu, 25 Dec 2025 08:36:02 +0800
X-OQ-MSGID: <20251225003601.34147-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <694bcddd.050a0220.35954c.001c.GAE@google.com>
References: <694bcddd.050a0220.35954c.001c.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When retrieving the next request that has not yet completed the
three-way handshake, a null pointer is returned if the operation fails.
Patch fe67b063f687 did not consider this scenario, which triggered the
issue reported by syzbot [1].

Added handling for the case where there are no requests.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
RIP: 0010:handshake_complete+0x36/0x350 net/handshake/request.c:288
Call Trace:
 handshake_nl_accept_doit+0x3c9/0x7f0 net/handshake/netlink.c:128
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115

Fixes: fe67b063f687 ("net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()")
Reported-by: syzbot+dfffb6c26ee592ff9e83@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dfffb6c26ee592ff9e83
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/handshake/netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 1d33a4675a48..a36441d4372b 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -124,6 +124,8 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 		fd_publish(fdf);
 		return 0;
 	}
+	else
+		goto out_status;
 
 out_complete:
 	handshake_complete(req, -EIO, NULL);
-- 
2.43.0


