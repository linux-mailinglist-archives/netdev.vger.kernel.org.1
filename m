Return-Path: <netdev+bounces-176906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17DA6CAF2
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0B48A4D27
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDBE230264;
	Sat, 22 Mar 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="kK7sikh4"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0022D79A;
	Sat, 22 Mar 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654590; cv=none; b=U2E85uSB/3oWObnMD31t2s4qakhilACWHrIqqR33Tu7IDwAygEF+6XNKO91cw3UcZ3vU9ybd7Asy25+UXYOtUhnMX4s6Ui1ppEz0tQOZ7OBwi4cSIAQoZN5v2zAdgi2kDuLfPRdJNscT7g7l2lFUAaHec0kx8+rAbzIUpDiMp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654590; c=relaxed/simple;
	bh=A3/Bmt4AfDp5S3+hap59qfqQxAKJrH1+TLt47Ia8f6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijqN6hNRdhlK7hckit48xvqw78Keu8WxNw34QuFAxfU369QN+TxwZJ30h6LKIf0qmYwLbyaqkz6HdnFdZkEonl1Km7nWUJwvUJE0DO6pjCXcI4kr0yvqGTUiK4tOchV9xIndMD2IJAblvklSXkyqjtTMYMNwJRBHcuHkS4dYEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=kK7sikh4; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2ba0:0:640:9b07:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id EA86A60DBF;
	Sat, 22 Mar 2025 17:43:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4hNuaRKLlqM0-Wt3URiL4;
	Sat, 22 Mar 2025 17:43:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654586; bh=K3h6JaMDjHVJHpPW7T71KWH02F/2L9o7+M/ELUic214=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=kK7sikh4w1n89sY+12HCNOFGgBB1YI/A510EJrrxspUUlFLulH5k+2oiohGAnWOiT
	 L8IHFbOaficnm0iS9TIBDUnllO8aRMR+JNvp254bCLJD/ofhvB6hOgOcOfqYC8Pp7+
	 h6qUZmG0b+IeSVdEQkVVKQFSm1YqOhpdkOAeqnEM=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 42/51] bond: Make master and slave relate to the same nd_lock
Date: Sat, 22 Mar 2025 17:43:04 +0300
Message-ID: <174265458458.356712.53205870622253635.stgit@pro.pro>
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
 drivers/net/bonding/bond_main.c    |    4 ++++
 drivers/net/bonding/bond_options.c |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 96f5470a5f55..1140e01f72b8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4490,6 +4490,7 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 	struct ifbond __user *u_binfo = NULL;
 	struct ifslave k_sinfo;
 	struct ifslave __user *u_sinfo = NULL;
+	struct nd_lock *nd_lock, *nd_lock2;
 	struct bond_opt_value newval;
 	struct net *net;
 	int res = 0;
@@ -4538,7 +4539,10 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 
 	switch (cmd) {
 	case SIOCBONDENSLAVE:
+		double_lock_netdev(bond_dev, &nd_lock, slave_dev, &nd_lock2);
+		nd_lock_transfer_devices(&nd_lock, &nd_lock2);
 		res = bond_enslave(bond_dev, slave_dev, NULL);
+		double_unlock_netdev(nd_lock, nd_lock2);
 		break;
 	case SIOCBONDRELEASE:
 		res = bond_release(bond_dev, slave_dev);
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 95d59a18c022..a3ebb8d6c529 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1605,6 +1605,7 @@ static int bond_option_slaves_set(struct bonding *bond,
 				  const struct bond_opt_value *newval)
 {
 	char command[IFNAMSIZ + 1] = { 0, };
+	struct nd_lock *nd_lock, *nd_lock2;
 	struct net_device *dev;
 	char *ifname;
 	int ret;
@@ -1627,7 +1628,10 @@ static int bond_option_slaves_set(struct bonding *bond,
 	switch (command[0]) {
 	case '+':
 		slave_dbg(bond->dev, dev, "Enslaving interface\n");
+		double_lock_netdev(bond->dev, &nd_lock, dev, &nd_lock2);
+		nd_lock_transfer_devices(&nd_lock, &nd_lock2);
 		ret = bond_enslave(bond->dev, dev, NULL);
+		double_unlock_netdev(nd_lock, nd_lock2);
 		break;
 
 	case '-':


