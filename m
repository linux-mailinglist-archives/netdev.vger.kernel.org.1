Return-Path: <netdev+bounces-176904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B2DA6CADE
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE90D1B839B6
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107122FF44;
	Sat, 22 Mar 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="YJQ8nczN"
X-Original-To: netdev@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BD233D65;
	Sat, 22 Mar 2025 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654577; cv=none; b=lEbpToVm9YJNGU7d31S7LTCKezO/FPvuvVRB/luTJMefOU9LMmYyp/yP8rkiGjAz1w6eQ+u9O6fKxIOQSE0j3Jw/pvkAB3YFsFhrGuZZL+usRMnLKKDypszIwMGldPXrJ9fbw+RAsqfHR0rGbq8Em8bhgVp6vkb1cPb3lRPe8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654577; c=relaxed/simple;
	bh=mbbQpAtwGd0Ots6gVUpNyx2w+IKYw6vKRkbTtW5NlvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcIEslFRQJVc2SPmd64+8SWE1ljWNpy2uwhnmXWfcZKowOsUPXkw3M6IB6Vp+Oyj02/39joaMmEeCgLJi2vGTvL6l1qXoEjSo5GLXhIuSmgZrLROK8NstjHRS0gLIKtqUEP9zGtkOzdhvXfZPkII3UK+Q1oQ468ylvDiWSa0a1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=YJQ8nczN; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b117:0:640:4e77:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 346C860904;
	Sat, 22 Mar 2025 17:42:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ogNOTYKLbeA0-VctP5Nzm;
	Sat, 22 Mar 2025 17:42:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654571; bh=fTTvNO9gcmxpSekZUmfZ8AVTATFVVZIUJjDC34sBHYk=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=YJQ8nczN5k9H1cWItzLGWKp8HMduzLNUhUjtbicdgUUsedwMMgj2WA94xED3WN9Te
	 WnO4UDDnQ84JLSlEicZ4UHVekVRJjy6ubkPkZCyD4wxKalw069NQbmgKOHtOsEKA0g
	 GnJ5+giXMHDERVRTAyztQUncMW/JRJeSZsTGmRvA=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 40/51] openvswitch: Make ports share nd_lock of master device
Date: Sat, 22 Mar 2025 17:42:50 +0300
Message-ID: <174265457014.356712.17642146869021358083.stgit@pro.pro>
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
 net/openvswitch/vport-netdev.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 91a11067e458..e629fc3c1442 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -75,6 +75,7 @@ static struct net_device *get_dpdev(const struct datapath *dp)
 
 struct vport *ovs_netdev_link(struct vport *vport, const char *name)
 {
+	struct nd_lock *nd_lock, *nd_lock2;
 	int err;
 
 	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
@@ -99,9 +100,14 @@ struct vport *ovs_netdev_link(struct vport *vport, const char *name)
 	}
 
 	rtnl_lock();
+	double_lock_netdev(vport->dev, &nd_lock, get_dpdev(vport->dp), &nd_lock2);
+	nd_lock_transfer_devices(&nd_lock, &nd_lock2);
+
 	err = netdev_master_upper_dev_link(vport->dev,
 					   get_dpdev(vport->dp),
 					   NULL, NULL, NULL);
+	double_unlock_netdev(nd_lock, nd_lock2);
+
 	if (err)
 		goto error_unlock;
 


