Return-Path: <netdev+bounces-243549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C508CCA367C
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B163E30239CB
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF633C189;
	Thu,  4 Dec 2025 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RAn/QVcP"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBB3314A8;
	Thu,  4 Dec 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847053; cv=none; b=chkAkdCxDsiwYnf/bqkZxB8cqAQJL6fkupE6EpyIcaPkYyjb4B452moZniK82E4pi/Jmjml1j/2NZ+DL1tpWE5fVzIx0/uugLFjBiRLECHsyFh/ZBL1h7nEFaFvVBKH63To1OWwZIcm4XkbLTLCLa2FscXzSKG7GFopu5m8cwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847053; c=relaxed/simple;
	bh=obpZcy8c5ZIhRY8/ruGUQpQEg851Br+FNMRq+cBGys4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YXHORO/9xq8vUCPB422NvM2P+YcpO9S5BxBSswzc7XjtmhXxqIZyrwbFCZ687HzpiK+rpCfdaj+HtSFFHk7sC21gLEXCAr7/hpbfKmU39gvVucKy6xs2AkjD9mMN0YTgzkbwn/GAKmfItPEpva2nhkUzGedwX+GQKL3NxEk+erk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RAn/QVcP; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764847045; bh=vkec2dBL4iEa+ghPt34mvPpIcLrEp/CJKk6Ok1yJD5o=;
	h=From:To:Cc:Subject:Date;
	b=RAn/QVcPx4bleRHbRAJGSXV4+ZVN2wDDfIe70V4TqR5kqzq8HVbHmnEl6hwWSa811
	 +B57Eji3PunTUdha4qAr6qLRgSrhn4b0LhhSl7i8q6S6pT+kyOOkPV141j/OOFKo5i
	 qzLMX88FuDQAikDY8ELWJ/fs8tAGRD3mFafzykoA=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 4560D250; Thu, 04 Dec 2025 19:17:22 +0800
X-QQ-mid: xmsmtpt1764847042tmy69q9gz
Message-ID: <tencent_4312C2065549BCEEF0EECACCA467F446F406@qq.com>
X-QQ-XMAILINFO: OYTBn1rNHH7tL02hQweI2TVihFqLbfTQydV6JQ91XSfVOLrtILE9hpdXmIHwz6
	 P0o+Mg5/aot+rAbDrlwovnAoSHA0qOXFmlYA6a+VPNEPsEK+l7yFiAmhaUthkQVEd72mUFEp3eyQ
	 r8N9O4CjjgmKaGooip4zLCHkPbXzeuMkXTfLP3VZioeNSTVDl340wm6Rv9euUUlU3rhFQP/0SNqC
	 tCINd4d0Mx9WSzDYQFoMKh93LQWWuXMWXANN0ZTdt6f4ZAUmXvnQuU8xCIRUUjioiRBy14Hrktye
	 0ziBjEC1RnxxvlLLeavq4sNbCLGpTHATmDFkW2sCJyqQ5ha37wGncr7FSzNxsxV5DMAulcNYX6jj
	 1NQvmeWHe8ZYXInlO6q3SdkqdgJ66FU6DSofzjcn91MQdVTFan8I8uZ9TGJoeIF3yg6prDu87HBu
	 EajATJrAHUjLp3xTBm+I/66yk56HY3+9373NoWS2Pm5MHqZ3iG4fzQquMyKCHGaaRZ55wtBlZExm
	 wKJ3zKPIxXELiHi3+9pCv5XnCfeBkMwb/z/PYNd+wphVYr/n7O5BJt1hb0GO87SLLvQRgMPDhhFy
	 KVD1grk5LTO7ftTU4dpjgYwuu4JgMg1ozrBRpklu8c3qE8yzHfdrfWrYqEVsaza5znOsTCJ78lrA
	 s7+oUVkplRL3KzUnp93H+g315ozO2zoNLJoviEKgDdAc1/gKuZ/ZQ10D871kKFA39pPkrHE0/b2A
	 7DYop1c+JDq0FiLpwFJcSrJVFLJZtzYPJ/QENelRUNd/Z0TRuNtNIXiJZvo27P2yB8LOv3rllpqr
	 q9mts4JX1TuQweAxPhDmiP5LtlYMLHxNlP9KWoNK8jbLzNJoFgnuZFqdouFMbeezYCaSFOXe58iN
	 kT4VizqEyLDpojwdW1g7yj+7jWl9+ZhaCB0sI3idLJ4GGjtqWvAjrRS++E+M1nWzSwgKMDYiiq8A
	 vb25ATjaCRYCyJPVDzx9qHZArmHZhMekAn8RK3MZG9FRIHQM8rteChMNDXj89wXulU6vzo1tNSNP
	 WRv0OrJDl1blGpXaOmj0wRiytsREpV7qbSl3JBNg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net v3] net: atm: implement pre_send to check input before sending
Date: Thu,  4 Dec 2025 19:17:22 +0800
X-OQ-MSGID: <20251204111721.332235-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot found an uninitialized targetless variable. The user-provided
data was only 28 bytes long, but initializing targetless requires at
least 44 bytes. This discrepancy ultimately led to the uninitialized
variable access issue reported by syzbot [1].

Besides the issues reported by syzbot regarding targetless messages
[1], similar problems exist in other types of messages as well. We will
uniformly add input data checks to pre_send to prevent uninitialized
issues from recurring.

Additionally, for cases where sizeoftlvs is greater than 0, the skb
requires more memory, and this will also be checked.

[1]
BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
 lec_arp_update net/atm/lec.c:1845 [inline]
 lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
 vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v3:
  - update coding style and practices
v2: https://lore.kernel.org/all/tencent_E83074AB763967783C9D36949674363C4A09@qq.com/
  - update subject and comments for pre_send
v1: https://lore.kernel.org/all/tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com

 net/atm/lec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index afb8d3eb2185..423503d2e7a7 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -340,6 +340,23 @@ static int lec_close(struct net_device *dev)
 	return 0;
 }
 
+static int lec_atm_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	u32 sizeoftlvs;
+	struct atmlec_msg *mesg;
+	int msg_size = sizeof(struct atmlec_msg);
+
+	if (skb->len < msg_size)
+		return -EINVAL;
+
+	mesg = (struct atmlec_msg *)skb->data;
+	sizeoftlvs = mesg->sizeoftlvs;
+	if (sizeoftlvs && !pskb_may_pull(skb, msg_size + sizeoftlvs))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	static const u8 zero_addr[ETH_ALEN] = {};
@@ -491,6 +508,7 @@ static void lec_atm_close(struct atm_vcc *vcc)
 
 static const struct atmdev_ops lecdev_ops = {
 	.close = lec_atm_close,
+	.pre_send = lec_atm_pre_send,
 	.send = lec_atm_send
 };
 
-- 
2.43.0


