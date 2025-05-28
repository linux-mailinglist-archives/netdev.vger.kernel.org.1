Return-Path: <netdev+bounces-194013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5EAC6D14
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA27A25502
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0428C5A9;
	Wed, 28 May 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dE2NzvrH"
X-Original-To: netdev@vger.kernel.org
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C428C2C6
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446961; cv=none; b=CwehtfQ0w19obQmzXgnH5uuHK8WQuqqrezjj2RYfrGe5tCh+0id1O/Z0lmmSNDb2g+qMlEO0YW3iC6+R7wnBAMs/z9yrvmVR1UXkBrhRb0FqAhCkPMFA3ep3EQqgZNIl+zpgci3ATrC343xUcTXJqLv0edOo7PJs6yuIJx6s0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446961; c=relaxed/simple;
	bh=0npsLd/6pFeEZup/Yh3eJaGZUNzviGnNc7rt69TQhiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okOfj9xdf3D1SVLFvAuNcCBVQCH/SwjD+UtCL5YW7ExDdnei33m9dWwTlpAA7WactcpUJLkSH/Ghsl1J6yba3Sc+Ybi9mvg1WAqwhbefAnTp/IrVigD36ECClAB8ShDGxYLtLQU9sNacYkmrhbxdwh2qSfGk3MU6DiT/ACVV+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dE2NzvrH; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id D34BF67792
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 18:36:52 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:5b1c:0:640:ee42:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 7B9BA60D1C;
	Wed, 28 May 2025 18:36:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id iaXN4rELj0U0-qdatur7l;
	Wed, 28 May 2025 18:36:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1748446604; bh=cSKubfbGT1GLAXRbLdQih6MQJBQ/UfRuwYW3g6Ku7yQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=dE2NzvrH0q3xfr+bySTSCO9xXyBubsAig7E6L2WKJbtrwycl89SDpGmnIBIapAfiw
	 7HXZXRH3RZ+6U2Iil7ocgzLwFWmLWRmmvDGdBmbjOMgmWxBbkQnsASG3mq2A4n441Q
	 5hvrrs3Duf4L9gK+ycGstXDrJNFYv7A8rKHMTqkU=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] netlink: avoid extra pskb_expand_head() in netlink_trim()
Date: Wed, 28 May 2025 18:36:28 +0300
Message-ID: <20250528153628.249631-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'netlink_trim()' processes shared skb, using 'skb_clone()' with
following 'pskb_expand_head()' looks suboptimal, and it's expected to
be a bit faster to do 'skb_copy_expand()' with desired tailroom instead.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/netlink/af_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..efb360433339 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1285,11 +1285,15 @@ static struct sk_buff *netlink_trim(struct sk_buff *skb, gfp_t allocation)
 		return skb;
 
 	if (skb_shared(skb)) {
-		struct sk_buff *nskb = skb_clone(skb, allocation);
+		struct sk_buff *nskb;
+
+		nskb = skb_copy_expand(skb, skb_headroom(skb),
+				       skb_tailroom(skb) - delta,
+				       allocation);
 		if (!nskb)
 			return skb;
 		consume_skb(skb);
-		skb = nskb;
+		return nskb;
 	}
 
 	pskb_expand_head(skb, 0, -delta,
-- 
2.49.0


