Return-Path: <netdev+bounces-242888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B59A0C95B2C
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 05:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AB274E03D8
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 04:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1499F134AB;
	Mon,  1 Dec 2025 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s8bEoRdg"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE773FF1;
	Mon,  1 Dec 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764563555; cv=none; b=JicCSBe6ApjpULgndi+5jAgPhwaNWFWBkLPk8hU0y6daM1hPtb5d7LANYNaVJLqMN1WFjciSw0mnbaBw31PSgw58uGy8h5uxce6KeNNG1R8r+4UDWQsEqr6f6rGSZPFmIMBl4n4A6b9JgNCPu3r34HFYQgzZOFUmqYOOp+a/DEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764563555; c=relaxed/simple;
	bh=aIsmLS28js9v+qMK69BeAdTkTc0T1prP2RjT0y4XJsg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=g0dUWfqEI7A2pY5pYHKKQrPAf19pI+H/9lkC6a26DTWP8zSm4ASaj7k2b12vbDbGJj24KARQCEwA85LD5HBqx4WCkfWto2qGAVhfe/CARg59CYO76U55t5dxmO9Px7YMEBJjnebT4ohMW+66QmtvT3fWLCWKe2d8o62tPsNLwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s8bEoRdg; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764563543; bh=7W8fmnRYbgpMXROOPMJtWpH15NqeQQrDdkNqgTI8MxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s8bEoRdgDrsl2HdyHhmh+FABEtlg4GpCERSGZQ0P/VhmwmjumbuyUuUfJy2DpMs/k
	 FWGyrULnWkz1NNI7Yb79yYyI7QBaoUyrPvbtYr4niFTuh22gXPA6SdF3mnXuVAmel7
	 VNIefDXakL27ZxQBE5pjiPc55AfgZrnMiUDGD47U=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 7C9BDC89; Mon, 01 Dec 2025 12:31:09 +0800
X-QQ-mid: xmsmtpt1764563469t85pkbrpw
Message-ID: <tencent_E83074AB763967783C9D36949674363C4A09@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+TNOM5q4bORcDsgzTrtF+TOdMGg0IZy1TeprqxoPgB/Zm8exzvD
	 jmXN/yx5dY+GV/umKjOmz36hH/v7YUawWXnLfKOTKH8kaL9FHMGXXhPgQXO9mJYZ81BTKBwYfsD5
	 afuCjSDju0wU+BxfwRbcihJkh2YnWTjQZ3xNaxUEeJfcFFG5A0wCHf+BR+A+SS1UJB124SEDvQA3
	 2EbaLW+J2pNHUqEtSfcECrszcRrEyw9nMEpoa3DxvczmM9rb1WouL5cOtz+GcS17TWPbiepIgqn5
	 llmz+z9fEH4XLTEiZw5qsTaP9j4wHdgljkUDfSbCWDJ0Nty4iUC2wEM8ZhOPo88VrllC1iRFXOt/
	 c2QyKL+LNDHPrtB/ci8r7WHbqe+L81nO/XeBf7Yw11Ikfe4UFfWSogkhBx+ZEPZFk3sGUE3usSSV
	 9gZAaoI1pZ+UCwoPiRLw15Atv3BgZZJlVyc/F/YFXaR9d6n7ut+iHGHBs485LiZimAJPzSnHrKsV
	 mPxHL/w7gqZHnxsacHrqd2YwLlYDLoYEjdmBy9/ekkiYII67lop85LWW15kL1hADLlygJLiw8zv/
	 vD+FrGrzDjmypvv/nBnnuVNe7zju9gRCXj9CZJkuLDtGRk9UbCICPwUuQFFZ4d5WQWPn/lk1unmc
	 WZpj05g5RymEd+CV0FSz4PXxLBx7BE6NY6Gqv4YhqYuHk4gbbp1TV1sllNyXUtLAAsg2SB4HuBgk
	 XO0eEvDsdjXk5MEO4JygmXdRBt7Z92y6EBXAXyHtqGSJ6Yg66b/rd4cELGS/e/FwgpIt6oTX/Zcp
	 uAM8l7s09hy7RLLZMjF2mk/fqgQaZm120nd3x3pLAiI07w9dSPsyNLDXsqOoo65UMMdZdukBwY5H
	 vlHBM3/U3cOWdD30X4DjGLIamaRMLsljTuBMmoPd66wUpIo9eIUqDxz5K+IN9EZejhr9U0RrrzLx
	 85j1fhl2EPa+KBY9Jdi9Sk9+1vYhjmamLrHw+oyj7wsTOxRDwc56mMoW6xqfU3q3I4WOjSzPrdJh
	 sB0x1KLccYaCms0Qv05uEQM3lPDDwCf2bNiSgpHg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net v2] net: atm: implement pre_send to check input before sending
Date: Mon,  1 Dec 2025 12:31:10 +0800
X-OQ-MSGID: <20251201043109.209601-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aSxpOjsmyMPlB-Mg@horms.kernel.org>
References: <aSxpOjsmyMPlB-Mg@horms.kernel.org>
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
v2:
  - update subject and comments for pre_send
v1: https://lore.kernel.org/all/tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com

 net/atm/lec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index afb8d3eb2185..8a9660abd134 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -340,6 +340,23 @@ static int lec_close(struct net_device *dev)
 	return 0;
 }
 
+static int lec_atm_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct atmlec_msg *mesg;
+	int sizeoftlvs;
+	int msg_size = sizeof(struct atmlec_msg);
+
+	if (skb->len < msg_size)
+		return -EINVAL;
+
+	mesg = (struct atmlec_msg *)skb->data;
+	sizeoftlvs = mesg->sizeoftlvs;
+	if (sizeoftlvs > 0 && !pskb_may_pull(skb, msg_size + sizeoftlvs))
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


