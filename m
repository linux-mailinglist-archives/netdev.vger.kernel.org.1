Return-Path: <netdev+bounces-177047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79EA6D819
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB2E188E13F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD925DB17;
	Mon, 24 Mar 2025 10:09:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EE1411DE
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810992; cv=none; b=Nxn5ICqH+kBXVZDo1fu2ufE7xKHPOe7QvUdOLIO61Boc/KGAW/og5XoeLYcLi3EgLrJ3IlZfVyUYZUc97lqS+IpEtdBmDwWdM7vxRRb0/V3Y6x8dodkvKnuh99mO1mJrfDsJF3Tqhbf7IvRGFLRu/eKaaBhMnB5y5MjhxIf19Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810992; c=relaxed/simple;
	bh=KN1ZjYr5giw4pmBjg36m9j7GCqdMQVq4Czw31VTPGz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9fuCb0bl9eQSRplJwcQKo47BTsGqOknrJXA1P8K4hUKpJopQsF/A2crt+M9q4j7lM0iak/c8eJPcD43SJN/iKGOg0Rwfs08Bx9agacOrf6I5iPciBBzl7recalBxBk8/XYtNgH4hoIhqBwzGRj5slCoD8jTNxjhRGmyp15I3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1742810928t1mora6k
X-QQ-Originating-IP: OYjC0sDLNHU5Yc/+m9nhcyHC1Q4o0ZkQZZxLL2Ut2Ik=
Received: from wxdbg.localdomain.com ( [60.186.241.229])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Mar 2025 18:08:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7884627779381070769
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 2/2] net: libwx: fix Tx L4 checksum
Date: Mon, 24 Mar 2025 18:32:35 +0800
Message-Id: <20250324103235.823096-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250324103235.823096-1-jiawenwu@trustnetic.com>
References: <20250324103235.823096-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ONcd5u+FjiuQtXD1GL3EyTcCEgeilGfG3WYlZNkR0QiboltiMM2BzUW5
	ZGVMY8HHqvCsz94jWXdOY0ljtcaEicSmqdvqh3ajQgkJEVWIa0uDNgimNaQW2cLsgcuRVhn
	mq1KdaHXqTtv+U/mHM3k5SYJ2+fUiV5MQfBjHdyA2D7CmG3NRhuG2Kc5yY8XNfnCd0G/nyI
	gbIZ1c4UDhHtaxp4B8KBANCINg7hTY7sYt7sJHmjgkay6zO3d2T1ZSbG5CwtxQu+LmEvF1r
	7ZNVXqhLoqsi/t9NPjEaZaDLRrP6PmaVmUQCGWVGy+Gr2waaSR0HSwWlI5Up78/8h64/nS/
	DDP88C66oC0a2XWyelilFAFNPKi+jKFGUXJ6jG609Cs0Whl0exmAfqTdQ9B6d1V1QhCp9R+
	1RT1OtqviD3mXMcFaF7luilcBbbPIexJSWJFP6R1bFFsgQdZRhPIYXDINwPnxw9KS/1iuS3
	Iqt922UDPQpDrPEmy4qOjeb2wYWl+TvDeDnlPcdR+EIeE2tn+yZnmWBzTdiZi3jbSThmAeA
	x2poWwmpzruM/9fh73Z7JU9kBF0eYv5D5+AmO0/BMvsmefQH3lNYNZkfltDXZE6bo9jQBgj
	7PyuCvXXk7VHZncOoiM+0XmehJ5t71fKi0XIUh5z7vU+1eB1htneaXHbjWBwBdTQnBakQhq
	qgFjIRsqkGOTJL2i9jb4uUAGqbxcltVKfTBX3ugsAGoE4fKEigrpJfP8Z0E80zIUFiyjYsI
	tDJYFl8P/RNQ08kO47KzdQr9nGJR9L555n/MoR7A1SKIh7IQwB4L4mFSQKFfSh7CL+aOd8P
	h+jKfZmC/sQ8MGUR+JTo4shKkEMwfkq3HECmR1H5vNRWK8ihNK2pPLddP6kYOJ/yplNtzXR
	sTXrEGi7VoBkkDW2zNin31fqRfnWhmxyh68WlgzD3f4eDHBqlBB3uCnM78akCVDrGX++Ic1
	EvgZgsKr1QCkNt4aptdsOnRMpsj4cqaazwk0zE21amyS9JlwvnpqRziBk7zpOLW63kMt+u3
	esx4xDgg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

The hardware only supports L4 checksum offload for TCP/UDP/SCTP protocol.
There was a bug to set Tx checksum flag for the other protocol that results
in Tx ring hang. Fix to compute software checksum for these packets.

Fixes: 3403960cdf86 ("net: wangxun: libwx add tx offload functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 9294a9d8c554..497abf2723a5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1337,6 +1337,7 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 	u8 tun_prot = 0;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
+csum_failed:
 		if (!(first->tx_flags & WX_TX_FLAGS_HW_VLAN) &&
 		    !(first->tx_flags & WX_TX_FLAGS_CC))
 			return;
@@ -1441,7 +1442,8 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 					WX_TXD_L4LEN_SHIFT;
 			break;
 		default:
-			break;
+			skb_checksum_help(skb);
+			goto csum_failed;
 		}
 
 		/* update TX checksum flag */
-- 
2.27.0


