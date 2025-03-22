Return-Path: <netdev+bounces-176910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19FEA6CAEE
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0391B85E28
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAF7230BEE;
	Sat, 22 Mar 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="G6UITqIl"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA922DFA7;
	Sat, 22 Mar 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654620; cv=none; b=TDiOmaZpzBOfrBjfB0pJSUpUO4TZp53zZu1W+r64vQ1ccQsSDREEreR0237ambGIV9D6/jCKTMzl32NvsDVwpGclwTWY1FCIlv4mD5cmtQPsjkxk/u1bciBL9eNX4qHaB38owNF9E8wZo0PW5mjl/wcF7AHvSbdX2DOgdXIa4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654620; c=relaxed/simple;
	bh=7yG/PXfDqwyI4cGBCoEIAcdeDS7CWAFlIQcXhywI514=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruwGtdvOxugpHg5JHWNQ0Gc7k4uS7B4baxAj/8BEZi0uz6nb9eD17ZDptQT+U6mBB/GEtLjoQy++Z+fa/luPKi/Uo0aPVDCIb3ruoF77+QIvxN/faeoaUcq+oKVUHdrWnG3e1xUoe0ITAwY2P7A2vcjatZLap1hhzGCm4fT0EuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=G6UITqIl; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:4795:0:640:c576:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id C1D9360C65;
	Sat, 22 Mar 2025 17:43:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YhN37KXLaqM0-YnNXQIWB;
	Sat, 22 Mar 2025 17:43:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654616; bh=rxAS9CPftJgSLLRDAiW0KeAGjWyu0a/SCLO12hf8k7Q=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=G6UITqIlY3O+MyMTpCbanCqEmM6UaTdmp8FF7f3RLuhTlyK7EJAq0168xiDCF/Aet
	 +SgMYR4CMP/37sbcd9yCDLHsjaXFURKDvq5ll519VC9tPWbxXF6HJpYNL7n83sWYCg
	 nzisc2pgCDHzckuAw6NL8XinYi0Y17SNBPF9AGdU=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 46/51] 6lowpan: Use __unregister_netdevice()
Date: Sat, 22 Mar 2025 17:43:34 +0300
Message-ID: <174265461407.356712.9206164277601393221.stgit@pro.pro>
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

->dellink is going to be called with nd_lock is held

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/6lowpan/core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index b5cbf85b291c..bd77076b125e 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -71,15 +71,19 @@ EXPORT_SYMBOL(lowpan_register_netdev);
 
 void lowpan_unregister_netdevice(struct net_device *dev)
 {
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 	lowpan_dev_debugfs_exit(dev);
 }
 EXPORT_SYMBOL(lowpan_unregister_netdevice);
 
 void lowpan_unregister_netdev(struct net_device *dev)
 {
+	struct nd_lock *nd_lock;
+
 	rtnl_lock();
+	lock_netdev(dev, &nd_lock);
 	lowpan_unregister_netdevice(dev);
+	unlock_netdev(nd_lock);
 	rtnl_unlock();
 }
 EXPORT_SYMBOL(lowpan_unregister_netdev);


