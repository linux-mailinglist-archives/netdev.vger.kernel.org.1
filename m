Return-Path: <netdev+bounces-222692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B21B55723
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CFE5682BE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8BC2DECCD;
	Fri, 12 Sep 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK/4lTVy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DE2C08CB
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706841; cv=none; b=ig46067FFsUBuldNnzsFTwsfNysrqv47siTksOcI+3DTevx8aBzpXLZ0kgzHzXfQ6qDOZZFBu6+7vCqxg5BcdKSXcuNmPZg5ZbybntMKuYseMsIAY/hsyQ2Aqi/7h4axleeX8D3T0Fa4v9zaU41dLrLBrwXr38F4Dhpnji25v7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706841; c=relaxed/simple;
	bh=TNwvDQajDJwinfMN+rc6pDxOnb11XL5FJGmkglwQ850=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+67KXpJhG8zlbj558H1uKCvR4R9JLiQ0nCOwGU89se239M1icHIvI5mJ/iA10V8PnUi7x/SiON7pofMWPAYrcJzc8XL7jus9mLVVXFMcV6fLHxJnNnZGG1rayqc4RIGdCF3dVsXlxfcRXwRkQmHEJojwUzQ0Vqg4/uBEcBv9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK/4lTVy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d44d734cabso1831077f8f.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706837; x=1758311637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPWRU5hljCQOOfEb+EXXggcIU6tx3t1+caDvvYD1FG4=;
        b=ZK/4lTVy470vdkEKBTDhMdyDfMbEWwSBfi1lTrG4QJPdfey2vUSJ6mXgFT3MybT/ER
         NORB5QnzL/Up63RSAenU8IybMdzgtWO6ZoUusqX2JoYbHQNRj2dxRW+21DjlnN8E+cAk
         AxFGS9f5cHniLWeGhodRMJI5LZR1pzqu5v73FYbC8YF9udKHzy1dxBRbLu3pYJKiHKG3
         S5DfrCTuk1QR4ZWTwf0IMO2Sm2HGovWSc+mJeUp6V/o0NysE9diq5bjn94WiPll1/PZO
         eIZc3AKjXsfcKnsBAPOYtPybiOM5IBasn8+iWatkD5VakG4x+jUykblvxccSaO5pcLeZ
         nSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706837; x=1758311637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPWRU5hljCQOOfEb+EXXggcIU6tx3t1+caDvvYD1FG4=;
        b=k54M6muRM81EpT2Yv1VMYV9+JBi9LE91d+EpL0BhnhFcZQ21R/gc0wtM7HicQYeEYl
         gaJmLoPFGVNDPI4vCMRxuS1bNXSGDok8E4g6SWSgsFPck3AzWWRFGPaTe5Tl6jlq8lge
         TmoG6Zc4L2PjJBmmO3wEbC04WaIKrba3JETn8hrdSAxwOaxLKSYB+BDLfGHGvrIbb8fz
         rNtTPcQq0nMXV6Uo7Pvg7iniotIX2CGMl5zq82sST37oG3M65a3lcaF+pxGpEs786af8
         ZXPmAf9mPrIOrJV40gyQPsTWtVlDri2do6PlmMZlr18VDjHu1hRypFNbVXaw1Ol9NECc
         FiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlyUuTJrH3iT6rmP2GuuONgnAxLJWn/GQlahULpq70jja3t5iejg+XFBBRNbXS8V3LzHCyWfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HzVbVHEQzqPcLdSUO25/CODvZro7QvOXlJzy8YyrckOCCyzD
	vzUxcJ+1b51yHftpPvUNkmfp3h8laAXTIFOpxPmw52Hv4bRD/bwdOtYr
X-Gm-Gg: ASbGncsTaCyZvoJ4PRJgyOEXAS6IbieFeW5IW1cD8Ko8V/zwYvzT0eg+YUNa1goXQSP
	GDhMA76/2e5Kten9Ro94sVmZb8yCLYja7cOBnnM/IvtzVQLY8regU9w9wyJuSUGzSxd5CMF1/9f
	gyobjPqVBtvZWCVhfpuWCIb9+dHSn/SMyLXD0RTNoSFOJUvBeLaAJFSovHgG2pjjIw5czKep7eW
	THoKGwgUeP2xpAlVM1FPEzmYUyc2pCb3QeJDUqYTb241T2O1VWbZx0ktczmCQnoEYvp+SDvsWna
	58XPxy9YEODfaHrWWbDBRv5Hh0zXMKHguyf6Ix9e6Kvfeb4hugq614nSZQUYb5cO+jutVEd6Gz3
	6307YZJ3a3Y10w3lrS9spMB6563d1UKraCf/tg7DDkSWj5G8dibhO83zDLUCZ4A==
X-Google-Smtp-Source: AGHT+IHVc0vSQuTGul1kjR1NEWN+wdKOnJm4ZMECOAgedHoMAITsiioS4A+FpNwFGvjZtFNBcl9gaQ==
X-Received: by 2002:a5d:5d8a:0:b0:3dc:eb5:51f6 with SMTP id ffacd0b85a97d-3e7659d37b9mr4149963f8f.39.1757706836871;
        Fri, 12 Sep 2025 12:53:56 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:53:56 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 03/15] genetlink: add PARALLEL_GENL test family
Date: Fri, 12 Sep 2025 22:53:26 +0300
Message-Id: <20250912195339.20635-4-yana2bsh@gmail.com>
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

Implement PARALLEL_GENL Generic Netlink family with:
- Parallel operations support (parallel dump)
- 4 commands (SEND, DUMP_INFO, SET/GET_VALUE)
- Command with reject policy
- Advanced attribute types (binary, nested, flags)
- Multicast group support
- Proper error handling

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 547 +++++++++++++++++-
 1 file changed, 544 insertions(+), 3 deletions(-)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index 69bcad98babc..17f869ece2d6 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -71,7 +71,7 @@ static ssize_t show_genl_test_message(struct kobject *kobj,
 
 static ssize_t store_genl_test_message(struct kobject *kobj,
 				       struct kobj_attribute *attr,
-					   const char *buf, size_t count)
+				       const char *buf, size_t count)
 {
 		size_t len = min(count, sizeof(sysfs_data.genl_test_message) - 1);
 
@@ -150,9 +150,12 @@ static DEFINE_MUTEX(genl_mutex);
 #define MY_GENL_FAMILY_NAME "TEST_GENL"
 #define MY_GENL_VERSION 1
 
+#define PARALLEL_GENL_FAMILY_NAME "PARALLEL_GENL"
+
 #define PATH_GENL_TEST_NUM "/sys/kernel/genl_test/value"
 #define PATH_GENL_TEST_MES "/sys/kernel/genl_test/message"
 #define PATH_GENL_TEST_DEV "/sys/kernel/genl_test/some_info"
+#define PATH_PARALLEL_GENL_MES "/sys/kernel/parallel_genl/message"
 
 // TEST_GENL
 enum {
@@ -200,6 +203,8 @@ static const struct nla_policy my_genl_policy[MY_GENL_ATTR_MAX + 1] = {
 /* netlink families */
 static struct genl_family my_genl_family;
 
+static struct genl_family my_genl_family_parallel;
+
 enum my_multicast_groups {
 	MY_MCGRP_GENL,
 };
@@ -544,6 +549,534 @@ static struct genl_family my_genl_family = {
 	.n_mcgrps = ARRAY_SIZE(genl_mcgrps),
 };
 
+// PARALLEL_GENL family
+enum {
+	PARALLEL_GENL_ATTR_UNSPEC,
+	PARALLEL_GENL_ATTR_DATA,
+	PARALLEL_GENL_ATTR_BINARY,
+	PARALLEL_GENL_ATTR_NAME,
+	PARALLEL_GENL_ATTR_DESC,
+	PARALLEL_GENL_ATTR_BITFIELD32,
+	PARALLEL_GENL_ATTR_SIGN_NUM,
+	PARALLEL_GENL_ATTR_ARRAY,
+	PARALLEL_GENL_ATTR_NESTED,
+	PARALLEL_GENL_ATTR_FLAG_NONBLOCK,
+	PARALLEL_GENL_ATTR_FLAG_BLOCK,
+	PARALLEL_GENL_ATTR_REJECT,
+	PARALLEL_GENL_ATTR_PATH,
+	__PARALLEL_GENL_ATTR_MAX,
+};
+
+#define PARALLEL_GENL_ATTR_MAX (__PARALLEL_GENL_ATTR_MAX - 1)
+
+enum {
+	PARALLEL_GENL_CMD_UNSPEC,
+	PARALLEL_GENL_CMD_SEND,
+	PARALLEL_GENL_CMD_DUMP_INFO,
+	PARALLEL_GENL_CMD_SET_VALUE,
+	PARALLEL_GENL_CMD_GET_VALUE,
+	__PARALLEL_GENL_CMD_MAX,
+};
+
+#define PARALLEL_GENL_CMD_MAX (__PARALLEL_GENL_CMD_MAX - 1)
+
+static const struct nla_policy parallel_genl_policy[PARALLEL_GENL_ATTR_MAX +
+						    1] = {
+	[PARALLEL_GENL_ATTR_UNSPEC] = { .type = NLA_UNSPEC },
+	[PARALLEL_GENL_ATTR_DATA] = { .type = NLA_STRING },
+	[PARALLEL_GENL_ATTR_BINARY] = { .type = NLA_BINARY },
+	[PARALLEL_GENL_ATTR_NAME] = { .type = NLA_NUL_STRING },
+	[PARALLEL_GENL_ATTR_DESC] = { .type = NLA_NUL_STRING },
+	[PARALLEL_GENL_ATTR_BITFIELD32] = { .type = NLA_BITFIELD32 },
+	[PARALLEL_GENL_ATTR_SIGN_NUM] = { .type = NLA_S32,
+					  .validation_type = NLA_VALIDATE_RANGE,
+					  .min = -100,
+					  .max = 100 },
+	[PARALLEL_GENL_ATTR_ARRAY] = { .type = NLA_NESTED_ARRAY },
+	[PARALLEL_GENL_ATTR_NESTED] = { .type = NLA_NESTED },
+	[PARALLEL_GENL_ATTR_FLAG_NONBLOCK] = { .type = NLA_FLAG },
+	[PARALLEL_GENL_ATTR_FLAG_BLOCK] = { .type = NLA_FLAG },
+	[PARALLEL_GENL_ATTR_REJECT] = { .type = NLA_REJECT },
+	[PARALLEL_GENL_ATTR_PATH] = { .type = NLA_STRING },
+};
+
+static int parallel_genl_send(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *reply;
+	int ret;
+	char *str;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &my_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply)
+		goto error;
+
+	str = "NEW family - parallel_genl";
+
+	strcpy(sysfs_data.parallel_genl_message, str);
+
+	if (nla_put_string(msg, PARALLEL_GENL_ATTR_DATA, str)) {
+		nlmsg_free(msg);
+		pr_err("%s: Error with putting value to PARALLEL_GENL_ATTR_DATA\n", __func__);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, reply);
+
+	if (nla_get_flag(info->attrs[PARALLEL_GENL_ATTR_FLAG_NONBLOCK]))
+		goto overrun_nonblock;
+	if (nla_get_flag(info->attrs[PARALLEL_GENL_ATTR_FLAG_BLOCK]))
+		goto overrun_block;
+
+	return genlmsg_reply(msg, info);
+
+error:
+	ret = -EMSGSIZE;
+	nlmsg_free(msg);
+	return ret;
+
+overrun_nonblock:
+	skb->sk->sk_sndtimeo = 1000;
+	ret = netlink_unicast(skb->sk, msg, info->snd_portid, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+
+overrun_block:
+	ret = netlink_unicast(skb->sk, msg, info->snd_portid, 0);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int parallel_genl_set_str_value(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *msg_head;
+	struct nlattr *na_path;
+	struct nlattr *na_value;
+	char *sysfs_path;
+	char *new_value = NULL;
+	int err;
+	int data_len;
+
+	if (!info->attrs[PARALLEL_GENL_ATTR_DATA]) {
+		pr_info("%s: Missing PARALLEL_GENL_ATTR_DATA\n", __func__);
+		return -EINVAL;
+	}
+
+	na_value = info->attrs[PARALLEL_GENL_ATTR_DATA];
+	data_len = nla_len(na_value);
+
+	new_value = kmalloc(data_len + 1, GFP_KERNEL);
+	if (!new_value)
+		return -ENOMEM;
+
+	strncpy(new_value, nla_data(na_value), data_len);
+	new_value[data_len] = '\0';
+
+	na_path = info->attrs[PARALLEL_GENL_ATTR_PATH];
+	if (!na_path) {
+		pr_info("%s: Missing PARALLEL_GENL_ATTR_PATH\n", __func__);
+		return -EINVAL;
+	}
+	sysfs_path = nla_data(na_path);
+
+	strcpy(sysfs_data.parallel_genl_message, new_value);
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg_head = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			       &my_genl_family_parallel, 0,
+			       PARALLEL_GENL_CMD_SET_VALUE);
+	if (!msg_head) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	if (nla_put_string(msg, PARALLEL_GENL_ATTR_DATA, new_value)) {
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
+	kfree(new_value);
+	return 0;
+}
+
+static int parallel_genl_get_str_value(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *msg_head;
+	struct nlattr *na_path;
+	char *sysfs_path;
+	char *value;
+	int err;
+	int code;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg_head = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			       &my_genl_family_parallel, 0,
+			       PARALLEL_GENL_CMD_GET_VALUE);
+	if (!msg_head) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	if (!info->attrs[PARALLEL_GENL_ATTR_PATH]) {
+		nlmsg_free(msg);
+		return -EINVAL;
+	}
+	genl_unlock();
+	na_path = info->attrs[PARALLEL_GENL_ATTR_PATH];
+	sysfs_path = nla_data(na_path);
+	genl_lock();
+
+	if (strcmp(sysfs_path, PATH_PARALLEL_GENL_MES) != 0) {
+		pr_err("%s: Incorrect path: %s\n", __func__, sysfs_path);
+		goto error;
+	}
+
+	value = kmalloc(MAX_DATA_LEN, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	strcpy(value, sysfs_data.parallel_genl_message);
+
+	if (nla_put_string(msg, PARALLEL_GENL_ATTR_DATA, value)) {
+		genlmsg_cancel(msg, msg_head);
+		nlmsg_free(msg);
+		kfree(value);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, msg_head);
+
+	if (info) {
+		err = genlmsg_reply(msg, info);
+		if (err != 0) {
+			pr_err("%s: Error in genlmsg_reply, err=%d\n",
+			       __func__, err);
+			nlmsg_free(msg);
+			kfree(value);
+			return err;
+		}
+	}
+	kfree(value);
+
+	return 0;
+
+error:
+	nlmsg_free(msg);
+	code = -ENOENT;
+	netlink_set_err(skb->sk, 0, MY_MCGRP_GENL, code);
+	return -ENOENT;
+}
+
+struct parallel_data {
+	char *name;
+	char *desc;
+};
+
+struct parallel_data data[] = {
+	{ "TEST_GENL", "one" },
+	{ "PARALLEL_GENL", "two" },
+	{ "THIRD_GENL", "three" },
+	{ "LARGE_GENL", "four" },
+};
+
+#define DATA_SIZE ARRAY_SIZE(data)
+
+static int parallel_genl_dump_start(struct netlink_callback *cb)
+{
+	pr_info("%s: Dump is started", __func__);
+	return 0;
+}
+
+static int __parallel_genl_fill_info(struct parallel_data *info,
+				     struct sk_buff *msg)
+{
+	if (nla_put_string(msg, PARALLEL_GENL_ATTR_NAME, info->name) ||
+	    nla_put_string(msg, PARALLEL_GENL_ATTR_DESC, info->desc))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int __parallel_genl_dump_element(struct parallel_data *info, u32 portid,
+					u32 seq, u32 flags, struct sk_buff *skb,
+					u8 cmd)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(skb, portid, seq, &my_genl_family_parallel, flags,
+			  cmd);
+	if (!hdr)
+		return -ENOMEM;
+
+	if (__parallel_genl_fill_info(info, skb) < 0)
+		goto nla_put_failure;
+
+	genlmsg_end(skb, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(skb, hdr);
+	return -EMSGSIZE;
+}
+
+static int parallel_genl_dump_info(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	int ret;
+	int idx = cb->args[0];
+
+	for (;;) {
+		if (idx >= DATA_SIZE)
+			return 0;
+
+		ret = __parallel_genl_dump_element(&data[idx],
+						   NETLINK_CB(cb->skb).portid,
+						   cb->nlh->nlmsg_seq,
+						   NLM_F_MULTI, skb,
+						   PARALLEL_GENL_CMD_DUMP_INFO);
+
+		if (ret) {
+			pr_err("%s: __parallel_genl_dump_element failed: %d\n", __func__, ret);
+			return ret;
+		}
+
+		cb->args[0]++;
+		idx++;
+	}
+
+	return ret;
+}
+
+static int parallel_genl_dump_done(struct netlink_callback *cb)
+{
+	pr_info("%s: Dump is done", __func__);
+	return 0;
+}
+
+// Generic Netlink operations for PARALLEL_GENL family
+static const struct genl_ops parallel_genl_ops[] = {
+	{
+		.cmd = PARALLEL_GENL_CMD_SEND,
+		.flags = 0,
+		.policy = parallel_genl_policy,
+		.doit = parallel_genl_send,
+		.dumpit = NULL,
+	},
+	{
+		.cmd = PARALLEL_GENL_CMD_DUMP_INFO,
+		.flags = 0,
+		.policy = parallel_genl_policy,
+		.start = parallel_genl_dump_start,
+		.dumpit = parallel_genl_dump_info,
+		.done = parallel_genl_dump_done,
+	},
+	{
+		.cmd = PARALLEL_GENL_CMD_SET_VALUE,
+		.flags = 0,
+		.policy = NULL,
+		.doit = parallel_genl_set_str_value,
+		.dumpit = NULL,
+	},
+	{
+		.cmd = PARALLEL_GENL_CMD_GET_VALUE,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.policy = parallel_genl_policy,
+		.doit = parallel_genl_get_str_value,
+	},
+};
+
+enum my_multicast_many_groups_two {
+	MCGRP_TWO_1,
+	MCGRP_TWO_2,
+	MCGRP_TWO_3,
+	MCGRP_TWO_4,
+	MCGRP_TWO_5,
+	MCGRP_TWO_6,
+	MCGRP_TWO_7,
+	MCGRP_TWO_8,
+	MCGRP_TWO_9,
+	MCGRP_TWO_10,
+	MCGRP_TWO_11,
+	MCGRP_TWO_12,
+	MCGRP_TWO_13,
+	MCGRP_TWO_14,
+	MCGRP_TWO_15,
+	MCGRP_TWO_16,
+	MCGRP_TWO_17,
+	MCGRP_TWO_18,
+	MCGRP_TWO_19,
+	MCGRP_TWO_20,
+	MCGRP_TWO_21,
+	MCGRP_TWO_22,
+	MCGRP_TWO_23,
+	MCGRP_TWO_24,
+	MCGRP_TWO_25,
+	MCGRP_TWO_26,
+	MCGRP_TWO_27,
+	MCGRP_TWO_28,
+	MCGRP_TWO_29,
+	MCGRP_TWO_30,
+	MCGRP_TWO_31,
+	MCGRP_TWO_32,
+	MCGRP_TWO_33,
+	MCGRP_TWO_34,
+	MCGRP_TWO_35,
+	MCGRP_TWO_36,
+	MCGRP_TWO_37,
+	MCGRP_TWO_38,
+	MCGRP_TWO_39,
+	MCGRP_TWO_40,
+	MCGRP_TWO_41,
+	MCGRP_TWO_42,
+	MCGRP_TWO_43,
+	MCGRP_TWO_44,
+	MCGRP_TWO_45,
+	MCGRP_TWO_46,
+	MCGRP_TWO_47,
+	MCGRP_TWO_48,
+	MCGRP_TWO_49,
+	MCGRP_TWO_50,
+	MCGRP_TWO_51,
+	MCGRP_TWO_52,
+	MCGRP_TWO_53,
+	MCGRP_TWO_54,
+	MCGRP_TWO_55,
+	MCGRP_TWO_56,
+	MCGRP_TWO_57,
+	MCGRP_TWO_58,
+	MCGRP_TWO_59,
+	MCGRP_TWO_60,
+	MCGRP_TWO_61,
+	MCGRP_TWO_62,
+	MCGRP_TWO_63,
+	MCGRP_TWO_64,
+	MCGRP_TWO_65,
+	MCGRP_TWO_66,
+	MCGRP_TWO_67,
+	MCGRP_TWO_68,
+	MCGRP_TWO_69,
+};
+
+static const struct genl_multicast_group genl_many_mcgrps_two[] = {
+	[MCGRP_TWO_1] = { .name = "MCGRP_TWO_1", },
+	[MCGRP_TWO_2] = { .name = "MCGRP_TWO_2", },
+	[MCGRP_TWO_3] = { .name = "MCGRP_TWO_3", },
+	[MCGRP_TWO_4] = { .name = "MCGRP_TWO_4", },
+	[MCGRP_TWO_5] = { .name = "MCGRP_TWO_5", },
+	[MCGRP_TWO_6] = { .name = "MCGRP_TWO_6", },
+	[MCGRP_TWO_7] = { .name = "MCGRP_TWO_7", },
+	[MCGRP_TWO_8] = { .name = "MCGRP_TWO_8", },
+	[MCGRP_TWO_9] = { .name = "MCGRP_TWO_9", },
+	[MCGRP_TWO_10] = { .name = "MCGRP_TWO_10", },
+	[MCGRP_TWO_11] = { .name = "MCGRP_TWO_11", },
+	[MCGRP_TWO_12] = { .name = "MCGRP_TWO_12", },
+	[MCGRP_TWO_13] = { .name = "MCGRP_TWO_13", },
+	[MCGRP_TWO_14] = { .name = "MCGRP_TWO_14", },
+	[MCGRP_TWO_15] = { .name = "MCGRP_TWO_15", },
+	[MCGRP_TWO_16] = { .name = "MCGRP_TWO_16", },
+	[MCGRP_TWO_17] = { .name = "MCGRP_TWO_17", },
+	[MCGRP_TWO_18] = { .name = "MCGRP_TWO_18", },
+	[MCGRP_TWO_19] = { .name = "MCGRP_TWO_19", },
+	[MCGRP_TWO_20] = { .name = "MCGRP_TWO_20", },
+	[MCGRP_TWO_21] = { .name = "MCGRP_TWO_21", },
+	[MCGRP_TWO_22] = { .name = "MCGRP_TWO_22", },
+	[MCGRP_TWO_23] = { .name = "MCGRP_TWO_23", },
+	[MCGRP_TWO_24] = { .name = "MCGRP_TWO_24", },
+	[MCGRP_TWO_25] = { .name = "MCGRP_TWO_25", },
+	[MCGRP_TWO_26] = { .name = "MCGRP_TWO_26", },
+	[MCGRP_TWO_27] = { .name = "MCGRP_TWO_27", },
+	[MCGRP_TWO_28] = { .name = "MCGRP_TWO_28", },
+	[MCGRP_TWO_29] = { .name = "MCGRP_TWO_29", },
+	[MCGRP_TWO_30] = { .name = "MCGRP_TWO_30", },
+	[MCGRP_TWO_31] = { .name = "MCGRP_TWO_31", },
+	[MCGRP_TWO_32] = { .name = "MCGRP_TWO_32", },
+	[MCGRP_TWO_33] = { .name = "MCGRP_TWO_33", },
+	[MCGRP_TWO_34] = { .name = "MCGRP_TWO_34", },
+	[MCGRP_TWO_35] = { .name = "MCGRP_TWO_35", },
+	[MCGRP_TWO_36] = { .name = "MCGRP_TWO_36", },
+	[MCGRP_TWO_37] = { .name = "MCGRP_TWO_37", },
+	[MCGRP_TWO_38] = { .name = "MCGRP_TWO_38", },
+	[MCGRP_TWO_39] = { .name = "MCGRP_TWO_39", },
+	[MCGRP_TWO_40] = { .name = "MCGRP_TWO_40", },
+	[MCGRP_TWO_41] = { .name = "MCGRP_TWO_41", },
+	[MCGRP_TWO_42] = { .name = "MCGRP_TWO_42", },
+	[MCGRP_TWO_43] = { .name = "MCGRP_TWO_43", },
+	[MCGRP_TWO_44] = { .name = "MCGRP_TWO_44", },
+	[MCGRP_TWO_45] = { .name = "MCGRP_TWO_45", },
+	[MCGRP_TWO_46] = { .name = "MCGRP_TWO_46", },
+	[MCGRP_TWO_47] = { .name = "MCGRP_TWO_47", },
+	[MCGRP_TWO_48] = { .name = "MCGRP_TWO_48", },
+	[MCGRP_TWO_49] = { .name = "MCGRP_TWO_49", },
+	[MCGRP_TWO_50] = { .name = "MCGRP_TWO_50", },
+	[MCGRP_TWO_51] = { .name = "MCGRP_TWO_51", },
+	[MCGRP_TWO_52] = { .name = "MCGRP_TWO_52", },
+	[MCGRP_TWO_53] = { .name = "MCGRP_TWO_53", },
+	[MCGRP_TWO_54] = { .name = "MCGRP_TWO_54", },
+	[MCGRP_TWO_55] = { .name = "MCGRP_TWO_55", },
+	[MCGRP_TWO_56] = { .name = "MCGRP_TWO_56", },
+	[MCGRP_TWO_57] = { .name = "MCGRP_TWO_57", },
+	[MCGRP_TWO_58] = { .name = "MCGRP_TWO_58", },
+	[MCGRP_TWO_59] = { .name = "MCGRP_TWO_59", },
+	[MCGRP_TWO_60] = { .name = "MCGRP_TWO_60", },
+	[MCGRP_TWO_61] = { .name = "MCGRP_TWO_61", },
+	[MCGRP_TWO_62] = { .name = "MCGRP_TWO_62", },
+	[MCGRP_TWO_63] = { .name = "MCGRP_TWO_63", },
+	[MCGRP_TWO_64] = { .name = "MCGRP_TWO_64", },
+	[MCGRP_TWO_65] = { .name = "MCGRP_TWO_65", },
+	[MCGRP_TWO_66] = { .name = "MCGRP_TWO_66", },
+	[MCGRP_TWO_67] = { .name = "MCGRP_TWO_67", },
+	[MCGRP_TWO_68] = { .name = "MCGRP_TWO_68", },
+	[MCGRP_TWO_69] = { .name = "MCGRP_TWO_69", },
+};
+
+// genl_family struct for PARALLEL_GENL family
+static struct genl_family my_genl_family_parallel = {
+	.hdrsize = 0,
+	.name = PARALLEL_GENL_FAMILY_NAME,
+	.version = 1,
+	.maxattr = PARALLEL_GENL_ATTR_MAX,
+	.netnsok = true,
+	.parallel_ops = true,
+	.ops = parallel_genl_ops,
+	.n_ops = ARRAY_SIZE(parallel_genl_ops),
+	/** .policy = parallel_genl_policy,
+	 *  needs to delete policy from family to test reject policy
+	 */
+	.resv_start_op = PARALLEL_GENL_CMD_DUMP_INFO + 1,
+	.mcgrps = genl_many_mcgrps_two,
+	.n_mcgrps = ARRAY_SIZE(genl_many_mcgrps_two),
+};
+
 static int __init init_netlink(void)
 {
 	int rc;
@@ -556,8 +1089,16 @@ static int __init init_netlink(void)
 		goto failure_1;
 	}
 
+	rc = genl_register_family(&my_genl_family_parallel);
+	if (rc) {
+		pr_err("%s: Failed to register Generic Netlink family\n", __func__);
+		goto failure_2;
+	}
+
 	return 0;
 
+failure_2:
+	genl_unregister_family(&my_genl_family);
 failure_1:
 	pr_debug("%s: My module. Error occurred in %s\n", __func__, __func__);
 	return rc;
@@ -599,8 +1140,7 @@ static int __init init_sysfs_parallel_genl(void)
 		return -ENOMEM;
 	}
 
-	ret = sysfs_create_file(kobj_parallel_genl,
-				&my_attr_str_parallel_genl.attr);
+	ret = sysfs_create_file(kobj_parallel_genl, &my_attr_str_parallel_genl.attr);
 	if (ret) {
 		pr_err("%s: Failed to create sysfs file\n", __func__);
 		goto err_sysfs;
@@ -694,6 +1234,7 @@ static int __init module_netlink_init(void)
 static void __exit module_netlink_exit(void)
 {
 	genl_unregister_family(&my_genl_family);
+	genl_unregister_family(&my_genl_family_parallel);
 
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
-- 
2.34.1


