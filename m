Return-Path: <netdev+bounces-222690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF319B55724
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04227B46BD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328228466A;
	Fri, 12 Sep 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbDd/84n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740542C027F
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706840; cv=none; b=l9zkWsBzfxNr5jaODU+Zcf1dID3b03ieVF0C3qUaVvTrX3IlhRRniw4rHZRNJ+9sLjstgk+INR7eSxs0B1o4s0gsnBQSO5BsnM2DfOBOhGZNPGvVEU8yWbMyDOTilyG/54DaVIpwi2aTD/dthmg2ySgY9/o4dPLNXvR1HIJq6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706840; c=relaxed/simple;
	bh=/Cagp1ejGJLtDHkq62m/CGsX+fy3cFxlMkW0wgB3n0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHmstIQa8gkuoX55Gq53Zbfr841IrklHGW0dsr4nuxzx0NmMbcviqMD0fy0lb0UOTPL3ofZfRPKbvYGLaQsmI15d81aQmaIqDPdS8OzQ5qYYFvnV6sCdG0mpy32KrafgpmWDkLSgNAIKECyR/ptQtb+Bf3w62R7oyOolnTMe/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbDd/84n; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e76766a172so929174f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706836; x=1758311636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tBjQATVO5xgZ/yr5nMn7Qw/eeQsWnjOzogH+eIF8tM=;
        b=kbDd/84nAUyiUCf7ebIch5zkxHCn1zGhzMDolcCdDpYazKtrQpGjm2lo7EWQBeDhhU
         sxEGuJrob7SwNVkxEYd+duUZjx0+wWelpSv23B9b20Jc/Uo6FJ+Zkf37cmb/6vhRh0t6
         PkvAHqNp8TxfM5aHMFZkTGp3Q0MnVilKgKVfZzwqRyKhkdCi14H3nrmTwWu8u4qi2rpT
         PCtKDhneg0Sx6W0xtuc8reWm6yqclPU4UNVXOv5RMPYFgg42Qg4j+0fevcyTG44KMKd3
         kbpjAYj9U+VphQPIGziyy6Fy9uVNJU7DSygulJdYZQkFQN2RC5OYqUnl+HSNdIzsjX1/
         Fspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706836; x=1758311636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tBjQATVO5xgZ/yr5nMn7Qw/eeQsWnjOzogH+eIF8tM=;
        b=R4W2fcFHb10Eaqe09yq9oEyGhs+RfrvfoKj0+Ual1x2RFKXbp2siodXsmnauV9rjux
         i4DMX/Gg3SACxqd8TYU1G4w8fl7P5YzGsBPGq8JKxhYqR8CHNpkbWBSmWUDtZKeIATXG
         VhKwOFvSnPfNgmvszzqWS6zBpD+YzwYmOv5UPymtiPUlK0oq/tom2WWS3ZLsw+DYT/XX
         fTRsX/UsehKUfxkFguCRYZsNi49Vesc/imQ8wykWbN47IDi4dtrdc5FypHHH2rsWmJKv
         f9atgtTq4zlNSJynWPRbCGRIxtnulgLIofa3jl8UIYlbgRG6hAchsHs+yXyLf/NqfRbv
         gI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRobLrea7Ym0K1Iic80yTV5pAe6L9vv8IAaG9PLcBxDxZQGY//a8wFiMQCE69sTEAbbe+asVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1anHpetOkNSa+q4/FmcEZ+PkT186cADaUMMkUvV3ZuSfRUA3
	gflz2CIbzgkgJjMCPgI1aVbMdeET9nzLAGQiiuuzN+LYZAeymizIw+WK
X-Gm-Gg: ASbGncvpEKR6/5nDb+iZW0ESpv+oOvMmLMWAKhnmKy3QcLtmovDENUWRr9REMuUYObj
	4fXySk9hpPaTFY4zwrBdd0VA5qTbx068uQpHiYHhEHbMVodq3w4sPHI05eMbuamqltlQX7CYdtm
	OIS5Te6pl8JCrQDfe8jSC0mmP5n90LFMSoKBzqe0ApgphTtJmp+nelWUmxLh/9a7jOZX8ap7+77
	fw6R381+oSLSDpVAvOtEtcZ+4VZvz/iA1tcuQFCSPZD5TkX/cpJhCkWqQ7cOGTKJYyzJKnfnemr
	7nl2ny8n9Xzqti6OIWZjFuNhU4jKM7zkXh75a/ujKeDUkwEl/qyKogumivWaPolVTMDSKXQGMW3
	F21cjL7Yr/59cWppjKHUlKnbjCiT+zisItvcgDIAdJFBXt5/vj3lGTagRg3TX6oZHM27C464V
X-Google-Smtp-Source: AGHT+IGcBKOgx53Jm65PzbAADPlQfjhpj7kfAQIi9dZIUIhMC1gDPjWogKL7/mHKeareCdzLDUBraw==
X-Received: by 2002:a05:6000:2c04:b0:3d7:cd09:ae1e with SMTP id ffacd0b85a97d-3e7657975f2mr4308727f8f.17.1757706835502;
        Fri, 12 Sep 2025 12:53:55 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:53:55 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 02/15] genetlink: add TEST_GENL family for netlink testing
Date: Fri, 12 Sep 2025 22:53:25 +0300
Message-Id: <20250912195339.20635-3-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement basic Generic Netlink family with:
- 4 commands (ECHO, SET/GET_VALUE, NO_ATTRS)
- 1 small command (genl_small_ops)
- Multicast group support
- Attribute validation
- Mutex-protected operations
- Error handling with netlink_ext_ack

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 438 +++++++++++++++++-
 1 file changed, 431 insertions(+), 7 deletions(-)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index c50c0daae392..69bcad98babc 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -71,17 +71,16 @@ static ssize_t show_genl_test_message(struct kobject *kobj,
 
 static ssize_t store_genl_test_message(struct kobject *kobj,
 				       struct kobj_attribute *attr,
-				       const char *buf, size_t count)
+					   const char *buf, size_t count)
 {
-	size_t len = min(count, sizeof(sysfs_data.genl_test_message) - 1);
+		size_t len = min(count, sizeof(sysfs_data.genl_test_message) - 1);
 
-	strncpy(sysfs_data.genl_test_message, buf, len);
-	sysfs_data.genl_test_message[len] = '\0';
-	return count;
+		strncpy(sysfs_data.genl_test_message, buf, len);
+		sysfs_data.genl_test_message[len] = '\0';
+		return count;
 }
 
-static ssize_t show_genl_test_value(struct kobject *kobj,
-				    struct kobj_attribute *attr, char *buf)
+static ssize_t show_genl_test_value(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d", sysfs_data.genl_test_value);
 }
@@ -146,6 +145,424 @@ static struct kobj_attribute my_attr_str_parallel_genl =
 static struct kobj_attribute my_attr_str_third_genl =
 	__ATTR(message, 0664, show_third_genl_message, store_third_genl_message);
 
+static DEFINE_MUTEX(genl_mutex);
+
+#define MY_GENL_FAMILY_NAME "TEST_GENL"
+#define MY_GENL_VERSION 1
+
+#define PATH_GENL_TEST_NUM "/sys/kernel/genl_test/value"
+#define PATH_GENL_TEST_MES "/sys/kernel/genl_test/message"
+#define PATH_GENL_TEST_DEV "/sys/kernel/genl_test/some_info"
+
+// TEST_GENL
+enum {
+	MY_GENL_ATTR_UNSPEC,
+	MY_GENL_ATTR_DATA,
+	MY_GENL_ATTR_VALUE,
+	MY_GENL_ATTR_PATH,
+	MY_GENL_ATTR_NESTED,
+	__MY_GENL_ATTR_MAX,
+};
+
+#define MY_GENL_ATTR_MAX (__MY_GENL_ATTR_MAX - 1)
+
+enum {
+	MY_GENL_CMD_UNSPEC,
+	MY_GENL_CMD_ECHO,
+	MY_GENL_CMD_SET_VALUE,
+	MY_GENL_CMD_GET_VALUE,
+	MY_GENL_CMD_EVENT,
+	MY_GENL_CMD_NO_ATTRS,
+	__MY_GENL_CMD_MAX,
+};
+
+#define MY_GENL_CMD_MAX (__MY_GENL_CMD_MAX - 1)
+
+enum {
+	MY_GENL_SMALL_CMD_GET,
+	MY_GENL_SMALL_CMD_ERROR,
+	__MY_GENL_SMALL_CMD_MAX,
+};
+
+#define MY_GENL_SMALL_CMD_MAX (__MY_GENL_SMALL_CMD_MAX - 1)
+
+static const struct nla_policy my_genl_policy[MY_GENL_ATTR_MAX + 1] = {
+	[MY_GENL_ATTR_UNSPEC] = { .type = NLA_UNSPEC },
+	[MY_GENL_ATTR_DATA] = { .type = NLA_STRING },
+	[MY_GENL_ATTR_VALUE] = { .type = NLA_U32,
+				 .validation_type = NLA_VALIDATE_RANGE,
+				 .min = 0,
+				 .max = 100 },
+	[MY_GENL_ATTR_PATH] = { .type = NLA_STRING },
+	[MY_GENL_ATTR_NESTED] = { .type = NLA_NESTED },
+};
+
+/* netlink families */
+static struct genl_family my_genl_family;
+
+enum my_multicast_groups {
+	MY_MCGRP_GENL,
+};
+
+static const struct genl_multicast_group genl_mcgrps[] = {
+	[MY_MCGRP_GENL] = { .name = "MY_MCGRP_GENL", },
+};
+
+static int my_genl_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
+			    struct genl_info *info)
+{
+	mutex_lock(&genl_mutex);
+	return 0;
+}
+
+static void my_genl_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
+			      struct genl_info *info)
+{
+	mutex_unlock(&genl_mutex);
+}
+
+static void my_genl_mcast_msg(struct sk_buff *mcast_skb, struct genl_info *info)
+{
+	if (info) {
+		genl_notify(&my_genl_family, mcast_skb, info, MY_MCGRP_GENL,
+			    GFP_KERNEL);
+	} else {
+		genlmsg_multicast(&my_genl_family, mcast_skb, 0, MY_MCGRP_GENL,
+				  GFP_KERNEL);
+	}
+}
+
+// Functions for Generic Netlink TEST_GENL family
+static int my_genl_echo(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *data;
+	int ret;
+	char *str;
+
+	if (info->nlhdr->nlmsg_flags & NLM_F_ECHO) {
+		msg = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
+
+		data = genlmsg_put_reply(msg, info, &my_genl_family, 0,
+					 MY_GENL_CMD_ECHO);
+		if (!data)
+			goto error;
+
+		str = "Hello to mcast groups!";
+
+		strcpy(sysfs_data.genl_test_message, str);
+
+		ret = nla_put_string(msg, MY_GENL_ATTR_DATA, str);
+		if (ret < 0)
+			goto error;
+
+		genlmsg_end(msg, data);
+
+		my_genl_mcast_msg(msg, info);
+	}
+
+	return 0;
+
+error:
+	nlmsg_free(msg);
+	return -EMSGSIZE;
+}
+
+static int my_genl_set_value(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *msg_head;
+	struct nlattr *na_path;
+	struct nlattr *na_value;
+	char *sysfs_path;
+	u32 new_value;
+	int err;
+	int code;
+	struct netlink_ext_ack *extack;
+	struct nlattr *attr;
+	struct nlmsghdr *nlh;
+	char cookie[NETLINK_MAX_COOKIE_LEN];
+
+	if (!info->attrs[MY_GENL_ATTR_VALUE]) {
+		pr_info("%s: Missing MY_GENL_ATTR_VALUE\n", __func__);
+		return -EINVAL;
+	}
+
+	na_value = info->attrs[MY_GENL_ATTR_VALUE];
+	new_value = nla_get_u32(na_value);
+
+	if (new_value != 0 && new_value != 1) {
+		pr_err("%s: New value is incorrect\n", __func__);
+		goto error;
+	}
+
+	na_path = info->attrs[MY_GENL_ATTR_PATH];
+	if (!na_path) {
+		pr_info("%s: Missing MY_GENL_ATTR_PATH\n", __func__);
+		return -EINVAL;
+	}
+	sysfs_path = nla_data(na_path);
+
+	sysfs_data.genl_test_value = new_value;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg_head = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			       &my_genl_family, 0, MY_GENL_CMD_SET_VALUE);
+	if (!msg_head) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	if (nla_put_u32(msg, MY_GENL_ATTR_VALUE, new_value)) {
+		genlmsg_cancel(msg, msg_head);
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, msg_head);
+
+	err = netlink_unicast(skb->sk, msg, info->snd_portid, 0);
+	if (err < 0) {
+		pr_err("%s: Error in netlink_unicast, err=%d\n", __func__, err);
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return 0;
+
+error:
+	// sending error ACK
+	code = -EINVAL;
+
+	extack = kmalloc(sizeof(*extack), GFP_KERNEL);
+	if (!extack)
+		return -ENOMEM;
+
+	strcpy(cookie, "000001");
+	extack->_msg = "Incorrect value from userspace";
+	extack->bad_attr = na_value;
+	extack->policy = my_genl_policy;
+	extack->cookie_len = strlen(cookie);
+	extack->miss_type = MY_GENL_ATTR_VALUE;
+	extack->miss_nest = attr;
+
+	nlh = nlmsg_hdr(skb);
+	netlink_ack(skb, nlh, code, extack);
+	pr_info("%s: Message with TLV was sent\n", __func__);
+	return -EINVAL;
+}
+
+static int my_genl_get_value(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *msg_head;
+	struct nlattr *na_path;
+	char *sysfs_path;
+	u32 value;
+	int err;
+	int code;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg_head = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			       &my_genl_family, 0, MY_GENL_CMD_GET_VALUE);
+	if (!msg_head) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	if (!info->attrs[MY_GENL_ATTR_PATH]) {
+		nlmsg_free(msg);
+		return -EINVAL;
+	}
+	genl_unlock();
+	na_path = info->attrs[MY_GENL_ATTR_PATH];
+	sysfs_path = nla_data(na_path);
+	genl_lock();
+
+	if (strcmp(sysfs_path, PATH_GENL_TEST_NUM) != 0) {
+		pr_err("%s: Incorrect path: %s\n", __func__, sysfs_path);
+		goto error;
+	}
+
+	value = sysfs_data.genl_test_value;
+
+	if (nla_put_u32(msg, MY_GENL_ATTR_VALUE, value)) {
+		genlmsg_cancel(msg, msg_head);
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, msg_head);
+
+	if (info) {
+		err = genlmsg_reply(msg, info);
+		if (err != 0) {
+			pr_err("%s: Error in genlmsg_reply, err=%d\n", __func__, err);
+			nlmsg_free(msg);
+			return err;
+		}
+	}
+
+	return 0;
+
+error:
+	code = -EINVAL;
+	netlink_set_err(skb->sk, 0, MY_MCGRP_GENL, code);
+	return -EINVAL;
+}
+
+static int my_genl_no_attrs(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *msg_head;
+	int ret;
+	char *str;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg_head = genlmsg_put_reply(msg, info, &my_genl_family, 0,
+				     info->genlhdr->cmd);
+	if (!msg_head)
+		goto error;
+
+	str = "Reply from GENL_TEST family function with no attrs";
+
+	strcpy(sysfs_data.genl_test_message, str);
+
+	if (nla_put_string(msg, MY_GENL_ATTR_DATA, str)) {
+		pr_err("%s: Error with putting value to MY_GENL_ATTR_DATA\n", __func__);
+		goto error;
+	}
+
+	genlmsg_end(msg, msg_head);
+	return genlmsg_reply(msg, info);
+
+error:
+	ret = -EMSGSIZE;
+	nlmsg_free(msg);
+	return ret;
+}
+
+// Generic Netlink operations for TEST_GENL family
+static const struct genl_ops my_genl_ops[] = {
+	{
+		.cmd = MY_GENL_CMD_ECHO,
+		.flags = 0,
+		.policy = my_genl_policy,
+		.doit = my_genl_echo,
+		.dumpit = NULL,
+	},
+	{
+		.cmd = MY_GENL_CMD_SET_VALUE,
+		.policy = my_genl_policy,
+		.doit = my_genl_set_value,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = MY_GENL_CMD_GET_VALUE,
+		.flags = 0,
+		.policy = my_genl_policy,
+		.doit = my_genl_get_value,
+		.dumpit = NULL,
+	},
+	{
+		.cmd = MY_GENL_CMD_NO_ATTRS,
+		.flags = 0,
+		.policy = NULL,
+		.doit = my_genl_no_attrs,
+		.dumpit = NULL,
+	},
+};
+
+static int my_genl_small_cmd_get(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *reply;
+	int ret;
+	char *str;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &my_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply)
+		goto error;
+
+	str = "IT'S ME from kernel";
+
+	strcpy(sysfs_data.genl_test_message, str);
+
+	if (nla_put_string(msg, MY_GENL_ATTR_DATA, str)) {
+		nlmsg_free(msg);
+		pr_err("%s: Error with putting value to MY_GENL_ATTR_DATA\n", __func__);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, reply);
+	return genlmsg_reply(msg, info);
+
+error:
+	ret = -EMSGSIZE;
+	nlmsg_free(msg);
+	return ret;
+}
+
+static const struct genl_small_ops my_genl_small_ops[] = {
+	{
+		.cmd = MY_GENL_SMALL_CMD_GET,
+		.doit = my_genl_small_cmd_get,
+	},
+};
+
+// genl_family struct for TEST_GENL family
+static struct genl_family my_genl_family = {
+	.hdrsize = 0,
+	.name = MY_GENL_FAMILY_NAME,
+	.version = MY_GENL_VERSION,
+	.maxattr = MY_GENL_ATTR_MAX,
+	.netnsok = true,
+	.pre_doit = my_genl_pre_doit,
+	.post_doit = my_genl_post_doit,
+	.ops = my_genl_ops,
+	.n_ops = ARRAY_SIZE(my_genl_ops),
+	.small_ops = my_genl_small_ops,
+	.n_small_ops = ARRAY_SIZE(my_genl_small_ops),
+	.policy = my_genl_policy,
+	.mcgrps = genl_mcgrps,
+	.n_mcgrps = ARRAY_SIZE(genl_mcgrps),
+};
+
+static int __init init_netlink(void)
+{
+	int rc;
+
+	pr_info("%s: My module. Initializing Netlink\n", __func__);
+
+	rc = genl_register_family(&my_genl_family);
+	if (rc) {
+		pr_err("%s: Failed to register Generic Netlink family\n", __func__);
+		goto failure_1;
+	}
+
+	return 0;
+
+failure_1:
+	pr_debug("%s: My module. Error occurred in %s\n", __func__, __func__);
+	return rc;
+}
+
 static int __init init_sysfs_third_genl(void)
 {
 	int ret;
@@ -253,6 +670,11 @@ static int __init module_netlink_init(void)
 	if (ret)
 		goto err_sysfs;
 
+	ret = init_netlink();
+	if (ret)
+		goto err_sysfs;
+	pr_info("%s: New families are registered\n", __func__);
+
 	return 0;
 
 err_sysfs:
@@ -271,6 +693,8 @@ static int __init module_netlink_init(void)
 
 static void __exit module_netlink_exit(void)
 {
+	genl_unregister_family(&my_genl_family);
+
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
 	device_remove_file(dev_genl_test, &dev_attr_info_genl_test);
-- 
2.34.1


