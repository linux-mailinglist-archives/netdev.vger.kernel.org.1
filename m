Return-Path: <netdev+bounces-176890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C59A6CACC
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263FF3B3C71
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564BB230264;
	Sat, 22 Mar 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="QQvDSMX1"
X-Original-To: netdev@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2322D7A1;
	Sat, 22 Mar 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654474; cv=none; b=meV6a6VX+42sMzX5AQwHSd2hmSbMoNqm2FOh2S5rDyd3NzczuzypOfafiT2ZpF6xKM5omaqKdtcG8OkZmukSwokkrMwFORWS8jZIp82R40AM48v1ldKkMQ+lds/vj77XsXPjoJLYSl3vCz7N5R4VBKoYmyUrOzee4niAwghjQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654474; c=relaxed/simple;
	bh=tb5p+i4RGOXtseU+3CAkPWvzulPLmWT/jlCUUJasVGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXJnA0rtOjhRpOIMH/VgE0lIw5znZpzTdd5s3WU9Qae2pnx6vjX+aspixUqtoyoF0/1c6Wi0DcL0wqGbKRyQ+AIZEsTrVpO4btgIEhVjkT8R9Mh6GFtFpCJSnLZKJoT31nNp0N+/lZzsUi57V4VCSFbuPTFgLGKAOX+lP1NjccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=QQvDSMX1; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-72.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:472f:0:640:f355:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id A34A360B3F;
	Sat, 22 Mar 2025 17:41:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8fNnFaKLceA0-4aTpwJ8g;
	Sat, 22 Mar 2025 17:41:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654470; bh=xe2OMQz2t6ju5AjT3jlRd8HjwbMKDuwMDckkwQ7oxwM=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=QQvDSMX1eEOL8QWTmlrqRVRR/VGH5hrPbexL1a906dqu+YjP51bqWP/+ZVjdcj6TI
	 dOfOYjx2M5rEH0A85K4WJU3qy47DiHz2le6UaKpx86jPrDtO9YDGU5oJ8JxnKsCRzz
	 tFEjDtT4p6PnSbch+kDesd4iiwfFB1kSNW+Yl7VM=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 26/51] 6lowpan: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:41:08 +0300
Message-ID: <174265446855.356712.5159257797992093401.stgit@pro.pro>
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

The objective is to conform .newlink with its callers,
which already assign nd_lock (and matches master nd_lock
if there is one).

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/6lowpan/core.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 850d4a185f55..b5cbf85b291c 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -39,7 +39,7 @@ int lowpan_register_netdevice(struct net_device *dev,
 
 	dev->ndisc_ops = &lowpan_ndisc_ops;
 
-	ret = register_netdevice(dev);
+	ret = __register_netdevice(dev);
 	if (ret < 0)
 		return ret;
 
@@ -52,10 +52,18 @@ EXPORT_SYMBOL(lowpan_register_netdevice);
 int lowpan_register_netdev(struct net_device *dev,
 			   enum lowpan_lltypes lltype)
 {
+	struct nd_lock *nd_lock;
 	int ret;
 
 	rtnl_lock();
+	if (!attach_new_nd_lock(dev))
+		goto out;
+	lock_netdev(dev, &nd_lock);
 	ret = lowpan_register_netdevice(dev, lltype);
+	if (ret)
+		detach_nd_lock(dev);
+	unlock_netdev(nd_lock);
+out:
 	rtnl_unlock();
 	return ret;
 }


