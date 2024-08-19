Return-Path: <netdev+bounces-119680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DF2956925
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA9C1C20D46
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F01607B6;
	Mon, 19 Aug 2024 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="AMLiNDe3"
X-Original-To: netdev@vger.kernel.org
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BD3770D;
	Mon, 19 Aug 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066150; cv=none; b=CqGJ9OWns+ddPIdGx5rELXDZHQtkqB9idi5K1j+InRjIKfPSQVon3bTViqqNFuwe3gOMQNeBqULwB2eiBAT1Cn1BwzIsZsQoNc4nmlxaXvPTj6cyE0V8HmcIC5vIdrV7cRw5+/g56RJQnpKZo91JFbZqfZZObA42atinNGgIL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066150; c=relaxed/simple;
	bh=c8qfwgZxy4k7M/QwM7w2kuwv3erS4hiHEc0RQnttndA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m9c3oJv0cQEtoYevkMmy/f1sHHgTasjmLu+I1HG9sl+ElgbxrlkWljGSgxwfHHuqrQ/4MGMTnPbrNkNJZh5oJylUajLi3JMF3y4qKvNmpoYq5YuoabHUfCXYVzTDvjS/PqoLX7BBHp9r3Jd0rbpx0Htm8NmDv1aqhoBi7yOkZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=AMLiNDe3; arc=none smtp.client-ip=140.205.0.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724066136; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Uys0qyfgUd2dGS1I54Uf8szQ663XAB0LixdjJgQcSmQ=;
	b=AMLiNDe3GIKfOJytthPu8hlZb564tus153sstCTxf3USK+xfVDhLgXV5GRX4YbaLajzlvXc7ciCEbn0edCIDlq9W2ijj9A3KvdPhiczXxOvkZ+jUkjG2Pgzj0UKiYOXc8KiQXwakfDFpLAN6sHKyq6f+Hg3YBHy2MVv+7ivI3zU=
Received: from localhost(mailfrom:amy.saq@antgroup.com fp:SMTPD_---.YwXg47r_1724066135)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 19:15:36 +0800
From: "=?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?=" <amy.saq@antgroup.com>
To: netdev@vger.kernel.org
Cc: "=?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?=" <amy.saq@antgroup.com>,
  "David S. Miller" <davem@davemloft.net>,
  "Eric Dumazet" <edumazet@google.com>,
  "Jakub Kicinski" <kuba@kernel.org>,
  "Paolo Abeni" <pabeni@redhat.com>,
   <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: fix csum calculation for encapsulated packets
Date: Mon, 19 Aug 2024 19:17:41 +0800
Message-Id: <20240819111745.129190-1-amy.saq@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes the issue that when a packet is encapsulated, such as
sending through a UDP tunnel, the outer TCP/UDP checksum is not
correctly recalculated if (1) checksum has been offloaded to hardware
and (2) encapsulated packet has been NAT-ed again, which causes the
packet being dropped due to the invalid outer checksum.

Previously, when an encapsulated packet met some NAT rules and its
src/dst ip and/or src/dst port has been modified,
inet_proto_csum_replace4 will be invoked to recalculated the outer
checksum. However, if the packet is under the following condition: (1)
checksum offloaded to hardware and (2) NAT rule has changed the src/dst
port, its outer checksum will not be recalculated, since (1)
skb->ip_summed is set to CHECKSUM_PARTIAL due to csum offload and (2)
pseudohdr is set to false since port number is not part of pseudo
header. This leads to the outer TCP/UDP checksum invalid since it does
not change along with the port number change.

In this commit, another condition has been added to recalculate outer
checksum: if (1) the packet is encapsulated, (2) checksum has been
offloaded, (3) the encapsulated packet has been NAT-ed to change port
number and (4) outer checksum is needed, the outer checksum for
encapsulated packet will be recalculated to make sure it is valid.

Signed-off-by: Anqi Shen <amy.saq@antgroup.com>
---
 net/core/utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/utils.c b/net/core/utils.c
index c994e95172ac..d9de60e9b347 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -435,6 +435,8 @@ void inet_proto_csum_replace4(__sum16 *sum, struct sk_buff *skb,
 		*sum = ~csum_fold(csum_add(csum_sub(csum_unfold(*sum),
 						    (__force __wsum)from),
 					   (__force __wsum)to));
+	else if (skb->encapsulation && !!(*sum))
+		csum_replace4(sum, from, to);
 }
 EXPORT_SYMBOL(inet_proto_csum_replace4);
 
-- 
2.19.1.6.gb485710b


