Return-Path: <netdev+bounces-137778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6689A9BE9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E09B22A5E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626314A09F;
	Tue, 22 Oct 2024 08:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D31547E7;
	Tue, 22 Oct 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584164; cv=none; b=cJF/9BqFdCShYO/cPkI0TLbc20gq7/Tw7lFmTwoRHb54iZU8OT8ua0e67EjBl5zyC0SOuMp/xMoVJeUaKBDWXNo5bCX98nDHtkrHDnJV7KRrm3oxHDDB6iy54R3CRnMO9Vb1xNOuYxWMszDmeNUcF4K3q8Jjne52tj30ykmfXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584164; c=relaxed/simple;
	bh=oCUTSGwDs7RFdUrI4qSb5E1YozgvfzPLYAgYrjMGUB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/7lHAvbxnnfDlUGolOxvpM7hwlJ22WsRWoG96dxc/w50rkbREGwAeLvN+7fYGTeDoJ1UN7RfruCG96VCM2OX/naB5sb+2QEhLH3pUGHfBeV3IoriMRuqazB4J3cK36XfMGM9j5DGFpZ87kcWo0HHeBwcHmYav6dRb/y8+FpSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fc8e6466904b11efa216b1d71e6e1362-20241022
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:915dfc21-dc4d-4c7f-bfe7-792eca6b2949,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:5397b80a9d1b813ee247a6ffe9014e6d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,URL:1
	1|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fc8e6466904b11efa216b1d71e6e1362-20241022
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 82723815; Tue, 22 Oct 2024 16:02:30 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E0F13E000E85;
	Tue, 22 Oct 2024 16:02:29 +0800 (CST)
X-ns-mid: postfix-67175C15-7706351480
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 6A248E000E85;
	Tue, 22 Oct 2024 16:02:28 +0800 (CST)
From: Yunshui Jiang <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Yunshui Jiang <jiangyunshui@kylinos.cn>
Subject: [PATCH] tests: hsr: Increase timeout to 10 minutes
Date: Tue, 22 Oct 2024 16:02:23 +0800
Message-ID: <20241022080223.718547-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The time-consuming HSR test, hsr_ping.sh, actually needs 7 min to run.
Around 375s to be exact, and even more on a debug kernel or kernel with
other network security limits. The timeout setting for the kselftest is
currently 45 seconds, which is way too short to integrate hsr tests to
run_kselftest infrastructure. So, HSR test needs an explicit setting.
And to leave us some slack, use 10 min as default timeout.

Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
---
 tools/testing/selftests/net/hsr/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/net/hsr/settings

diff --git a/tools/testing/selftests/net/hsr/settings b/tools/testing/sel=
ftests/net/hsr/settings
new file mode 100644
index 000000000000..a62d2fa1275c
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/settings
@@ -0,0 +1 @@
+timeout=3D600
--=20
2.45.2


