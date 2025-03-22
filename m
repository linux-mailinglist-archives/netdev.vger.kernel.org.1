Return-Path: <netdev+bounces-176907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB85A6CAED
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFD24A4081
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF7235C04;
	Sat, 22 Mar 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="aQaVByEJ"
X-Original-To: netdev@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D977230BE4;
	Sat, 22 Mar 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654599; cv=none; b=rMiAEFf4MAVL9XIYVzxszVqYdxwMyz/QrjYZ+xRs9fbCEsyHSYAgvZulAlrfmRMggxwKLIXeFEUAA+naweSt1XBMWuetkoWOXnfNHy2ub4BE8HtdkLqdSC2ZBotOubN1eHXF2hPbJPrpNHIDO/BbnzFulE4LbzB4/Q5gX90yqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654599; c=relaxed/simple;
	bh=0//5KW0MvUzNZj25Rdh1ZIvVvJjIbUhplA6DsjCXPcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWLBuXsytnLHAg314rRcotBALR9a/boHv6vR7otquFBASTkov+TnBLmWZaYPIAW47d6/X1xyJ7NHdoWBWRe3mVd/jnwY1CnFIoAahPUH1lCO399U8DoBTeirQaEjIlQaY7obeN04Y8djF+xLGm22dvD5hmj7hXGRpDm3kuWXYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=aQaVByEJ; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:36c1:0:640:ebf1:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 56EE360B58;
	Sat, 22 Mar 2025 17:43:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ChNcKLXLfGk0-NqrDNHb4;
	Sat, 22 Mar 2025 17:43:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654594; bh=yRbEh2sRIikvw15wQwUu5mbjGVsJkmTGpZ20A7uiBDE=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=aQaVByEJJzkaIJedwK0eq2BkirWwVoa7FmcFTOKgFxXST0IEgVjWAJPkALwHQVtzc
	 LLxmod7q1+FxKRo1S2TwSKGJFznp9urj4ONIEqu0oSo741MldLBjbgZxKUePCwwe8R
	 cE8BW6qdPJyPb5ZWghr4pE6xT4NQXwSG0uioz4I0=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 43/51] net: Now check nobody calls netdev_master_upper_dev_link() without nd_lock attached
Date: Sat, 22 Mar 2025 17:43:12 +0300
Message-ID: <174265459205.356712.8546283286984099636.stgit@pro.pro>
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

... or with devices not related to the same nd_lock,

since at this moment all callers are switched to follow this way.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/dev.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1c447446215d..55df8157bca9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8126,6 +8126,12 @@ int netdev_master_upper_dev_link(struct net_device *dev,
 		.flags = NESTED_SYNC_IMM | NESTED_SYNC_TODO,
 		.data = NULL,
 	};
+	struct nd_lock *nd_lock;
+
+	nd_lock = rcu_dereference_protected(upper_dev->nd_lock, true);
+	if (WARN_ON(!mutex_is_locked(&nd_lock->mutex) ||
+		    nd_lock != rcu_dereference_protected(dev->nd_lock, true)))
+		return -EXDEV;
 
 	return __netdev_upper_dev_link(dev, upper_dev, true,
 				       upper_priv, upper_info, &priv, extack);


