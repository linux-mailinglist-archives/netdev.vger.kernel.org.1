Return-Path: <netdev+bounces-176873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC084A6CAA2
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756BA1B65E37
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B191C84D6;
	Sat, 22 Mar 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="pfAFb6yh"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C2F9443;
	Sat, 22 Mar 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654296; cv=none; b=oNSvTvMZBEjfVG4C4nER1cxV0Ykdk5UkRs5xm/xjZEz/04ehQSx6jASYUAy+fLKx5VMzbPr2+6pjGZKdUyBkXePpOofOs8GUaH55rel1Pj4HbcLUCBcgmW6wwboskTPT9ZiF1qA1aocRjziBEsuJKwKQz+yKWGAO2n7l/I22bVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654296; c=relaxed/simple;
	bh=VgPGIbSSoaBSzoh5zDVNCloMZQ5wiuzBJLeCCPHPIIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbvFBJWwwaljM4JO8TZxsAftpgOmsjwarBymlC0+OEk6SnWWRDPuAnNgj7M6rSEF6YiMlmSM0G9ZfztWYwnKgDNmAo+DGDmQa0ARYhxAvI/vSlQzv1SXunBTBEvYmIgCvs2/0FvqLCltdLlj6hu7hxGh5mrrBo9l41XW8rdwfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=pfAFb6yh; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ba8:0:640:2318:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id DBEB160C65;
	Sat, 22 Mar 2025 17:38:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xbNK2aKLd4Y0-AbiTQcuM;
	Sat, 22 Mar 2025 17:38:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654282; bh=ppU99Pvz0ISJXPXOgf/4+zV/jSa/NBw7iZfBFYsLYEc=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=pfAFb6yhLqBZjavONpyi11K+0C7ssr5r0aFHQxhIAfskcbxM0HohGjQ5cuxKTG1d8
	 2SPMjZ019aVbCTwgjFeiiIM3rBdLNv8vCxfje2T4jic/YA0+b5rLs+0FdcLkN+yd9N
	 boGts8RTORltCzMxEHfaQvILRrwiY0sLWtROeQZQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 01/51] net: Move some checks from __rtnl_newlink() to caller
Date: Sat, 22 Mar 2025 17:37:59 +0300
Message-ID: <174265427912.356712.232014691192934956.stgit@pro.pro>
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

The patch is preparation in rtnetlink code for using nd_lock.
This is a step to move dereference of tb[IFLA_MASTER] up
to where main dev is dereferenced by ifi_index.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/rtnetlink.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 73fd7f543fd0..b33a7e86c534 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3572,15 +3572,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #ifdef CONFIG_MODULES
 replay:
 #endif
-	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
-				     ifla_policy, extack);
-	if (err < 0)
-		return err;
-
-	err = rtnl_ensure_unique_netns(tb, extack, false);
-	if (err < 0)
-		return err;
-
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
@@ -3734,13 +3725,25 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct rtnl_newlink_tbs *tbs;
+	struct nlattr **tb;
 	int ret;
 
 	tbs = kmalloc(sizeof(*tbs), GFP_KERNEL);
 	if (!tbs)
 		return -ENOMEM;
+	tb = tbs->tb;
+
+	ret = nlmsg_parse_deprecated(nlh, sizeof(struct ifinfomsg), tb,
+				     IFLA_MAX, ifla_policy, extack);
+	if (ret < 0)
+		goto out;
+
+	ret = rtnl_ensure_unique_netns(tb, extack, false);
+	if (ret < 0)
+		goto out;
 
 	ret = __rtnl_newlink(skb, nlh, tbs, extack);
+out:
 	kfree(tbs);
 	return ret;
 }


