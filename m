Return-Path: <netdev+bounces-151033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82729EC8A4
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A92813ED
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439A205E06;
	Wed, 11 Dec 2024 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="DT11vbxL"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3812040B2
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908544; cv=none; b=X1IDNUy2k1pmb4KnahaFXNSm087s4sFC8pZtBPNA0QdqvdkmPfZMcMYgHgZevkfK/FrIGwKmoZecmifqXEqsFrnFbkbgiszuhvEyy2EbKiJXyYYa8cY/BC2LpqKLpUzqlvOlgqoDfg+USQcCI19K8O4BCUtTriqAa7clKuDV1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908544; c=relaxed/simple;
	bh=GTn8h1cILJZxRD/WPjB/UJpuuiM1eVhQlkQeJgDh5NM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GUvEUID4qHJhM3q0aJtJpoP8f1NLU0DAjBWYIZUNWsVOL05ieqqtnCTC2aa51YBB6dgKM7yGx2wQYwwVUqQKlyziyP94QePzhA5S9HODmkn4S/lTe3Jc7W1NDx3DdbYxy6ybWRRbIkD/wFVDA5GnEA5pXy3Cl0CDcGdLL85jzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=DT11vbxL; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733908231;
	bh=cqjMnbVmK1LhKXPepmKCsyi8lbW9EtlYn+9I8xwf1ms=;
	h=From:To:Cc:Subject:Date;
	b=DT11vbxLmQNpOd8UdLbru5oeVdXR4VvHUpXyY9PjI+yuNZ1OjN8LRg3kpO9wIjCRw
	 6N7D3/T+rkz1JKgJT7ckKrMdxddCkY+u59oTeMVwuo39EnK4oJKwUELgY1pHJYZa+x
	 ctZDsqEE4OkmWvFpHTn2uKLCVnyJdZpHqz/hhkU8=
Received: from yangang-TM1701.. ([223.70.159.239])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 1011BCCC; Wed, 11 Dec 2024 17:04:01 +0800
X-QQ-mid: xmsmtpt1733907841tzs7a4spc
Message-ID: <tencent_0FE3ED0442E69C9D86C0AEEE338A49F90305@qq.com>
X-QQ-XMAILINFO: Ni8Yhdca2hoVflPFEakEGBA6MZIsGTtyedeHR6Bjr8xZsS8Ftp/KmRfYPTocQY
	 dAjPEpChLf3eygMKsdRHTNa0mzWUI3OhiqBBod/+j4YIA0RHYhftZwzlj7KAeQDhNZyZcRXu4nfe
	 4ASDtftpblDf9yDGmlvX/6FKHe8SlQZOp+UU6eqoUDpbH/OAUix9i57OXrJgFdXoMUFh/2lZkQ9y
	 8VdHPLbF3S9fOMhOptuF3zGHP/m2Uz1tD1a/eGJ02+jY8tMqJ7AOx7GU85KPUiF/3+oJx9HXCmCT
	 LUM4ckSmOwMSY06xK7Cn+puH27Mb45yH0O9X7mInLMUsByP9TN6wIQrg3gG7N/eMq0F6NPp2U9Iw
	 oQtk/De7aQweLL0lrdU4A73Y5YED5mhV9KlKtam+DuqAzs3N7sClRuVD6f2gVymjoWBzmvhIp8hM
	 Wv2JfINXg1Ynf7/61ZW9GxgyZUvv1hbL0VJzqVv97/m7y50SUrymPRCToCei2cgqwIUu39QvIXoI
	 vkMhp+7dVKWTqK8gi9guo32FSEM/jF1HIVUOyQKV/B4eplxThvIm8e6xIXIykZbwqoOhZwiwqfG8
	 3Ye268FLWtygR39u3NwFzWodk88in9sGFDeaLtheuC6URKLhivRDiivAsFFN+JUfT0SXD4MlXkNG
	 u6QPt388m0N60YzpDJ9OOC3v8fI0C6aPr6Lt/PNYOMsh8ztTcQRYemNemI8dxfCu7K4fA2fYQz2R
	 YqGYqp8dzKzIuFnji5Img0JAuuTGoFSPRyQf0+Nhu6on8pBr0Zfqn1o3dRcVWNTOQOyvURAWYW/C
	 +YNdWAFv/NuTFISRGJpCeZDujOqZte6FQy8tffkYvB9cfJbI0msicBqzVoTnuaSkwFYYBrSxG3d3
	 NmmudrE/Oi9Ea6iB/rlpePhVSlF9eHQU/LLCwBBwoUFIjtMO/zWrl/yHwHTpq4tsKK0+wZC8lyXB
	 p64OirwF4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [mptcp-next] mptcp: fix invalid addr occupy 'add_addr_accepted'
Date: Wed, 11 Dec 2024 17:03:58 +0800
X-OQ-MSGID: <20241211090400.4646-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

This patch fixes an issue where an invalid address is announce as a
signal, the 'add_addr_accepted' is incorrectly added several times
when 'retransmit ADD_ADDR'. So we need to update this variable
when the connection is removed from conn_list by mptcp_worker. So that
the available address can be added in time.

In fact, the 'add_addr_accepted' is only declined when 'RM_ADDR'
by now, so when subflows are getting closed from the other peer,
the new signal is not accepted as well.

We noticed there have exist some problems related to this.I think
this patch effectively resolves them.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21bc3586c33e..f99dddca859d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2569,6 +2569,10 @@ static void __mptcp_close_subflow(struct sock *sk)
 			continue;
 
 		mptcp_close_ssk(sk, ssk, subflow);
+
+		if (READ_ONCE(subflow->remote_id) &&
+		    --msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+			WRITE_ONCE(msk->pm.accept_addr, true);
 	}
 
 }
-- 
2.25.1


