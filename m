Return-Path: <netdev+bounces-176874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2342CA6CAA5
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31FD7A75EB
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0303F1D5CD4;
	Sat, 22 Mar 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="bfi7R43X"
X-Original-To: netdev@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AB17E0;
	Sat, 22 Mar 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654332; cv=none; b=ZYzvDXcaJWIl04Ax/0D6XbkiLzQr+SClH6s1WRTi+5Q4A1RAyY27BFkRWKQCLNAwJRKYgQxsh2MKGfwMTy6FamozT7pU58MivvAEIruhpbTMGGnVslwXVRrWXaFdJNo4r2MuA/qJjY/WpVtjfWrCntdHjX9fI7r0J7wHew8eRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654332; c=relaxed/simple;
	bh=pA83tXaHJuOWCTHFqHXTxdLSW0PjB8UQ6GR9qR5EQkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOc5yUIj3Hv7hhtHO4VxsXIDuEPTd/q8yQfL/oyy/UaWEkn6pUhtGQxoQMY4/0cv+hHezcWOw90dThfgB/7kq9XvMORn16Rr128Atk2xmLRCDV408uglbqJtLMYhwLlX89bruNIOJBGPisi4irBUXX94zegB+CMF//OudOggyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=bfi7R43X; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:8f27:0:640:e8c0:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 857F16090A;
	Sat, 22 Mar 2025 17:38:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id dcNdUcXLi8c0-v3OzHOUO;
	Sat, 22 Mar 2025 17:38:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654321; bh=1kxHxTSZ00eTFJgJpsEPY67mm9vRJL+lv1/STG7AAx0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=bfi7R43Xrug4B9D2kN3j9b1jLUpfN55h56SByJi7rtPIbongY/Fv6jCdvoQHpbi24
	 DKKxwM3EZajktvYELmeA39qf+UvCCy0zqL/VUHtjlgIt0SgX8GLHMAaEeaphw3fXAf
	 5xOw+qmjkRTPLwFwcQ9NBV+EPLJx/kEQHBb9yYtQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 06/51] net: Use unregister_netdevice_many() for both error cases in rtnl_newlink_create()
Date: Sat, 22 Mar 2025 17:38:39 +0300
Message-ID: <174265431926.356712.5975031863253028010.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/rtnetlink.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a33b60d1de2d..046736091b4f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3503,6 +3503,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	struct net *link_net;
 	struct net_device *dev, *master = NULL;
 	char ifname[IFNAMSIZ];
+	LIST_HEAD(list_kill);
 	int err;
 
 	if (!ops->alloc && !ops->setup)
@@ -3576,13 +3577,11 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	return err;
 out_unregister:
 	if (ops->newlink) {
-		LIST_HEAD(list_kill);
-
 		ops->dellink(dev, &list_kill);
-		unregister_netdevice_many(&list_kill);
 	} else {
-		unregister_netdevice(dev);
+		unregister_netdevice_queue(dev, &list_kill);
 	}
+	unregister_netdevice_many(&list_kill);
 	goto out;
 }
 


