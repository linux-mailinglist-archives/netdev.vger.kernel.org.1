Return-Path: <netdev+bounces-118932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9319538D3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D0CB24995
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD61BBBF9;
	Thu, 15 Aug 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="inR4uRql"
X-Original-To: netdev@vger.kernel.org
Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA21BBBD8
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741955; cv=none; b=Bo0jNvn219QKSqALwYBJq29xk8fzizPfl8MZ2qC03haJO51oX01tdV1nfzeFTsw64fzzzOqhh3yGAJbrHExA8z+bDYIGVv/kdDmGp8LJA1FeXC6iaFSNoB+fOaGzOPBGsqW0KIPqFoo8c1atgiglprgo4L+UABdonPtDxxjdjH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741955; c=relaxed/simple;
	bh=lYUEl1XVPD1jZ7DhjDyxDLKxd3yzMhhp3z659zbB0eU=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=FRdo1mBk1Pg+o+lAUxOKzXPcsz3mJuNzQGN/v0S9PqudAmm5Yu0M2vANHrKf1fFjDZq4lxbG0AC1rXKfc1uyO+eBtW9WTg5OaIp1ira8Gwi80SzP+9SjrGaVeg4UWaOT0ftmOlNyvo7dfbB0Q/vHr7BRMAuwZwqtw7E7wbBTrhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=inR4uRql; arc=none smtp.client-ip=17.32.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SI90068OP0ONG20@ma-mailsvcp-mx-lapp03.apple.com> for
 netdev@vger.kernel.org; Thu, 15 Aug 2024 09:12:26 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_08,2024-08-15_01,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version : subject
 : to; s=20180706; bh=kHz5m41UDU7o7FJ0TMO6Bsux3MV3M+DyAeVlI5ZqRJQ=;
 b=inR4uRqlYiXIcr6tdi0UDqu6rIGZMAlorQvBSZC9efmaTSmmgxVRLAoethhi/d7NmRHY
 rdA3bMz4SJDZsxNkZPce/DIlmVFCnn9AJc0HXH6beNpay1l+kLFoJxcG8vGceMgYMLIh
 Mfc5XvWJ9cYjITV2+roSgGAMc0prPUWVkYm37NvcIhzmXziGZmi2HLm0920irdBE72Jf
 zNug8oCaew5p6TEdbypvpXdv9Cd+Ke5llPTkHHpyrYhjnzwxSB/usUNsKvh2dzqqrxmc
 /0reb1gPrjHw7MsAVcedTOuT+1SBjpiWBSILnywhngY76Jy8KoUQU60phfMTqyK8TuFU Kg==
Received: from mr55p01nt-mmpp02.apple.com
 (mr55p01nt-mmpp02.apple.com [10.170.185.213])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SI900XA9P0PBDJ0@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Thu, 15 Aug 2024 09:12:25 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp02.apple.com by
 mr55p01nt-mmpp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SI91FG00OHUSK00@mr55p01nt-mmpp02.apple.com>; Thu,
 15 Aug 2024 16:12:25 +0000 (GMT)
X-Va-A:
X-Va-T-CD: 30e61456e7e9114b505ce39b52d8e203
X-Va-E-CD: 9bf68b8ba10c9adccf24272782329134
X-Va-R-CD: 8202cc7e594c7587a7908bcdda2131e6
X-Va-ID: 650d4493-71b7-4bf9-bac7-8cfb2638a508
X-Va-CD: 0
X-V-A:
X-V-T-CD: 30e61456e7e9114b505ce39b52d8e203
X-V-E-CD: 9bf68b8ba10c9adccf24272782329134
X-V-R-CD: 8202cc7e594c7587a7908bcdda2131e6
X-V-ID: 3327a812-5922-40e3-a56b-300e6d5d6554
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_08,2024-08-15_01,2024-05-17_01
Received: from localhost.localdomain ([17.230.192.119])
 by mr55p01nt-mmpp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SI91GC17P0O8900@mr55p01nt-mmpp02.apple.com>; Thu,
 15 Aug 2024 16:12:25 +0000 (GMT)
From: Christoph Paasch <cpaasch@apple.com>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
Cc: Roopa Prabhu <roopa@nvidia.com>, Craig Taylor <cmtaylor@apple.com>
Subject: [PATCH netnext] mpls: Reduce skb re-allocations due to skb_cow()
Date: Thu, 15 Aug 2024 09:12:01 -0700
Message-id: <20240815161201.22021-1-cpaasch@apple.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit

mpls_xmit() needs to prepend the MPLS-labels to the packet. That implies
one needs to make sure there is enough space for it in the headers.

Calling skb_cow() implies however that one wants to change even the
playload part of the packet (which is not true for MPLS). Thus, call
skb_cow_head() instead, which is what other tunnelling protocols do.

Running a server with this comm it entirely removed the calls to
pskb_expand_head() from the callstack in mpls_xmit() thus having
significant CPU-reduction, especially at peak times.

Cc: Roopa Prabhu <roopa@nvidia.com>
Reported-by: Craig Taylor <cmtaylor@apple.com>
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
---
 net/mpls/mpls_iptunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 4385fd3b13be..6e73da94af7f 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -106,7 +106,7 @@ static int mpls_xmit(struct sk_buff *skb)
 		hh_len = 0;
 
 	/* Ensure there is enough space for the headers in the skb */
-	if (skb_cow(skb, hh_len + new_header_size))
+	if (skb_cow_head(skb, hh_len + new_header_size))
 		goto drop;
 
 	skb_set_inner_protocol(skb, skb->protocol);
-- 
2.39.5 (Apple Git-154)


