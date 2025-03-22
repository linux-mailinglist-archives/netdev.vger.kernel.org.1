Return-Path: <netdev+bounces-176911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED2A6CAF3
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCAF4A5832
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31847233D9C;
	Sat, 22 Mar 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="euJzr8cf"
X-Original-To: netdev@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F822F150;
	Sat, 22 Mar 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654629; cv=none; b=YB0jGZOgKP72WcUxH3JrK1pNZfGLfHbebGMptafBrBfQUJ0mpWV/33lxkEqSBleSEW3y2J1Da1ZCXC7hSW3nHcd3eGcJ/YnNXaI6kXkIuFNwWYScSzo1wY6PHe5HSnUCy7iNs8DitHpbEsZs4qGYx081x/gRkyUxQFNGqPrYG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654629; c=relaxed/simple;
	bh=VbPOLiZGFhs/dnM9GRqxHeyClazPP3Jwszk1hlGy1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNYzxNwaa9PW5DTrJ9HwfLxgeT/RxjpFwQTzi25n9AQTtFCHO5Ngu18J92D4o1PLlj6fvv6PEp7O5jO/R9JrFM9N6AdqqxNXDSESGW6Aa2OF97qA65Ne2lhpPIpNk8sjDZSKoq1YYFz5lquuuYEPsgN9brEBq+m85d4iMfmr/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=euJzr8cf; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:5b1c:0:640:ee42:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id F3D1C472D2;
	Sat, 22 Mar 2025 17:43:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id fhNjW2XLdCg0-Ia2XVoYN;
	Sat, 22 Mar 2025 17:43:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654623; bh=rXNdV4eDcKtTa7fQdd2S0RbtuIcq+/dV5+m0pfB7cYk=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=euJzr8cfjpJAGslkA43abi1Vp1kfqwQ4vWf8HqDnjoqWuEd/iHcM+kUBpUbBzfXNu
	 vgM/3jwgXLmQ4mFMZfl3920SMMU/neTKfS2w9h+a5pk/osGOoh0LwE1rDllG5CJVFc
	 04TA9NJ8MJbCl/A7Dy1Hd9KQEUv2eh72i2R5nEwM=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 47/51] netvsc: Call dev_change_net_namespace() under nd_lock
Date: Sat, 22 Mar 2025 17:43:41 +0300
Message-ID: <174265462185.356712.4688744451151879026.stgit@pro.pro>
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

We want to provide "nd_lock is locked" context during
NETDEV_REGISTER (and later for NETDEV_UNREGISTER)
events. When calling from __register_netdevice(),
notifiers are already in that context, and we do the
same for dev_change_net_namespace() here.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/hyperv/netvsc_drv.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index be8038e6393f..cc9f07f8d499 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2365,6 +2365,7 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 	struct netvsc_device *netvsc_dev;
 	struct bpf_prog *prog;
 	struct net_device *ndev;
+	struct nd_lock *nd_lock;
 	int ret;
 
 	if (vf_netdev->addr_len != ETH_ALEN)
@@ -2384,8 +2385,10 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 	 * done again in that context.
 	 */
 	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
+		lock_netdev(vf_netdev, &nd_lock);
 		ret = dev_change_net_namespace(vf_netdev,
 					       dev_net(ndev), "eth%d");
+		unlock_netdev(nd_lock);
 		if (ret)
 			netdev_err(vf_netdev,
 				   "could not move to same namespace as %s: %d\n",


