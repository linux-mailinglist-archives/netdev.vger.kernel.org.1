Return-Path: <netdev+bounces-176917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F645A6CB01
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDCF1B8077E
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C751A23535C;
	Sat, 22 Mar 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="U5tGuG6I"
X-Original-To: netdev@vger.kernel.org
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B64234966;
	Sat, 22 Mar 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654726; cv=none; b=Va5PZzfnVKBR8EvYrn11Hwi+Cb8n4lBgUdxhYP4y9Bhmp+4DxxY8EaimUcm20Qolr33zECITiE4VxQEVBhosAmHY10FV+V+hNGXSaaLwpt3HeujSesiuieFq9kINxZp9Mky6X2172wTQE9EiZunhgjRx1dEWoGu8vaDhTcxWkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654726; c=relaxed/simple;
	bh=lwt8xFs2dgnWD1K0YeMznmUwtEpAJmetLixpEhJv+ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgvyyVLc0pOFLWaPmAf0+KBt4W4YL0bVKhz7erQ8/uWm9E9UXs09xf4wRaAUo6k/Ot0eEmQcIb4Ri5iLvG/cd62fleQcaQaJSm/jt3jvLUBSupSI0xhqoojQiClrWxBcUGKNG/yXCDqJyvtQCrogBSMv/QxT2ukROPsJoaFXqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=U5tGuG6I; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id 0B68D64B8C;
	Sat, 22 Mar 2025 17:38:34 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1c87:0:640:51af:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id C0C6360A5D;
	Sat, 22 Mar 2025 17:38:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NcNK62XLZuQ0-Tfz7Zx8B;
	Sat, 22 Mar 2025 17:38:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654305; bh=psm2NTZgiGVUXs/Vk4r/HGHRKPXv/92GFNMm0K46VZs=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=U5tGuG6IzVN40D9MArvXOM0TbRawg0S+qPR9DzgWuB4JfKSdO6oYfIc4NW+AWjMnQ
	 /GEqIzSfEBx+VTZ+RXUuwsGn3shdO08yyWxkcI5QGgaa9ZdnZ6BJRjI0eYAdgFZid4
	 f0DbpEr+txBM86mcgh20dOEL1Krxb+CLraS5XNPQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 04/51] net: Extract some code from __rtnl_newlink() to separate func
Date: Sat, 22 Mar 2025 17:38:23 +0300
Message-ID: <174265430298.356712.7238852286966358693.stgit@pro.pro>
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
 net/core/rtnetlink.c |  167 +++++++++++++++++++++++++++-----------------------
 1 file changed, 91 insertions(+), 76 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a5af69af235f..6da137f1a764 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3563,6 +3563,80 @@ struct rtnl_newlink_tbs {
 	struct nlattr *slave_attr[RTNL_SLAVE_MAX_TYPE + 1];
 };
 
+static int __rtnl_newlink_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
+				  struct rtnl_newlink_tbs *tbs,
+				  struct netlink_ext_ack *extack,
+				  struct net *target_net, struct net_device *dev,
+				  const struct rtnl_link_ops *ops,
+				  struct nlattr **linkinfo, struct nlattr **data)
+{
+	const struct rtnl_link_ops *m_ops = NULL;
+	struct ifinfomsg *ifm = nlmsg_data(nlh);
+	struct nlattr ** const tb = tbs->tb;
+	struct nlattr **slave_data = NULL;
+	struct net_device *master_dev;
+	int err, status = 0;
+
+	if (nlh->nlmsg_flags & NLM_F_EXCL)
+		return -EEXIST;
+	if (nlh->nlmsg_flags & NLM_F_REPLACE)
+		return -EOPNOTSUPP;
+
+	err = validate_linkmsg(dev, tb, extack);
+	if (err < 0)
+		return err;
+
+	master_dev = netdev_master_upper_dev_get(dev);
+	if (master_dev)
+		m_ops = master_dev->rtnl_link_ops;
+
+	if (m_ops) {
+		err = -EINVAL;
+		if (m_ops->slave_maxtype > RTNL_SLAVE_MAX_TYPE)
+			goto out;
+
+		if (m_ops->slave_maxtype &&
+		    linkinfo[IFLA_INFO_SLAVE_DATA]) {
+			err = nla_parse_nested_deprecated(tbs->slave_attr,
+							  m_ops->slave_maxtype,
+							  linkinfo[IFLA_INFO_SLAVE_DATA],
+							  m_ops->slave_policy,
+							  extack);
+			if (err < 0)
+				goto out;
+			slave_data = tbs->slave_attr;
+		}
+	}
+
+	if (linkinfo[IFLA_INFO_DATA]) {
+		err = -EOPNOTSUPP;
+		if (!ops || ops != dev->rtnl_link_ops ||
+		    !ops->changelink)
+			goto out;
+
+		err = ops->changelink(dev, tb, data, extack);
+		if (err < 0)
+			goto out;
+		status |= DO_SETLINK_NOTIFY;
+	}
+
+	if (linkinfo[IFLA_INFO_SLAVE_DATA]) {
+		err = -EOPNOTSUPP;
+		if (!m_ops || !m_ops->slave_changelink)
+			goto out;
+
+		err = m_ops->slave_changelink(master_dev, dev, tb,
+					      slave_data, extack);
+		if (err < 0)
+			goto out;
+		status |= DO_SETLINK_NOTIFY;
+	}
+
+	err = do_setlink(target_net, skb, dev, ifm, extack, tb, status);
+out:
+	return err;
+}
+
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct netlink_ext_ack *extack,
@@ -3570,11 +3644,8 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
 	struct nlattr ** const tb = tbs->tb;
-	const struct rtnl_link_ops *m_ops;
-	struct net_device *master_dev;
 	struct net *net = sock_net(skb->sk);
 	const struct rtnl_link_ops *ops;
-	struct nlattr **slave_data;
 	char kind[MODULE_NAME_LEN];
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
@@ -3585,29 +3656,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #ifdef CONFIG_MODULES
 replay:
 #endif
-	ifm = nlmsg_data(nlh);
-	if (ifm->ifi_index > 0) {
-		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
-	} else if (ifm->ifi_index < 0) {
-		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
-		return -EINVAL;
-	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
-		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
-	} else {
-		link_specified = false;
-		dev = NULL;
-	}
-
-	master_dev = NULL;
-	m_ops = NULL;
-	if (dev) {
-		master_dev = netdev_master_upper_dev_get(dev);
-		if (master_dev)
-			m_ops = master_dev->rtnl_link_ops;
-	}
-
 	if (tb[IFLA_LINKINFO]) {
 		err = nla_parse_nested_deprecated(linkinfo, IFLA_INFO_MAX,
 						  tb[IFLA_LINKINFO],
@@ -3645,59 +3693,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	slave_data = NULL;
-	if (m_ops) {
-		if (m_ops->slave_maxtype > RTNL_SLAVE_MAX_TYPE)
-			return -EINVAL;
-
-		if (m_ops->slave_maxtype &&
-		    linkinfo[IFLA_INFO_SLAVE_DATA]) {
-			err = nla_parse_nested_deprecated(tbs->slave_attr,
-							  m_ops->slave_maxtype,
-							  linkinfo[IFLA_INFO_SLAVE_DATA],
-							  m_ops->slave_policy,
-							  extack);
-			if (err < 0)
-				return err;
-			slave_data = tbs->slave_attr;
-		}
+	ifm = nlmsg_data(nlh);
+	if (ifm->ifi_index > 0) {
+		link_specified = true;
+		dev = __dev_get_by_index(net, ifm->ifi_index);
+	} else if (ifm->ifi_index < 0) {
+		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+		return -EINVAL;
+	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
+		link_specified = true;
+		dev = rtnl_dev_get(net, tb);
+	} else {
+		link_specified = false;
+		dev = NULL;
 	}
 
 	if (dev) {
-		int status = 0;
-
-		if (nlh->nlmsg_flags & NLM_F_EXCL)
-			return -EEXIST;
-		if (nlh->nlmsg_flags & NLM_F_REPLACE)
-			return -EOPNOTSUPP;
-
-		err = validate_linkmsg(dev, tb, extack);
-		if (err < 0)
-			return err;
-
-		if (linkinfo[IFLA_INFO_DATA]) {
-			if (!ops || ops != dev->rtnl_link_ops ||
-			    !ops->changelink)
-				return -EOPNOTSUPP;
-
-			err = ops->changelink(dev, tb, data, extack);
-			if (err < 0)
-				return err;
-			status |= DO_SETLINK_NOTIFY;
-		}
-
-		if (linkinfo[IFLA_INFO_SLAVE_DATA]) {
-			if (!m_ops || !m_ops->slave_changelink)
-				return -EOPNOTSUPP;
-
-			err = m_ops->slave_changelink(master_dev, dev, tb,
-						      slave_data, extack);
-			if (err < 0)
-				return err;
-			status |= DO_SETLINK_NOTIFY;
-		}
-
-		return do_setlink(target_net, skb, dev, ifm, extack, tb, status);
+		err = __rtnl_newlink_setlink(skb, nlh, tbs, extack,
+					     target_net, dev,
+					     ops, linkinfo, data);
+		return err;
 	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {


