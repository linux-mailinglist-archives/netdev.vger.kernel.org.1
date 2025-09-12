Return-Path: <netdev+bounces-222695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A5B5572D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED70B600FE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708B33EAED;
	Fri, 12 Sep 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjxY9xfs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB03375A9
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706846; cv=none; b=X0m0QlM3xMgBAlFEMURkw5e0iPWAlEVZ5RrnaXAyei+sI0GLrcq9BHo/KKsLQBDzW4B4gEP00nSQWMlFxleDuAyT/b2s43M7B6+VKwEQlKfwTUiqsrqC9tPYnIbGg8mJk+AOJ+mJwiTOp3FgN4fxkqSbON9UXFdTcu9PkwsDCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706846; c=relaxed/simple;
	bh=vtDr/kO1KchOCd5UEjGrTzcH3EcLOyUzNxhEjmZWIks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BORQzset7ouT+L/Or8nmIjSmBfe6gX1DQkgNmL1UOWiEgC3FLE3upzdVDG9nxJh7gTJziJkSNbDDzbqhGLDyApZORCVNIGUghkBqOfynCqOH5p7CfegBkGxLQXP8gPZB+ww5ksuX526GguZPwwoFBaTB6TUfNlii0g8hNb0pJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjxY9xfs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so1537583f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706842; x=1758311642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMaCvv0Npwgx9oOEe08/7S4E7IejpQl1+Xgtp1j/Fs0=;
        b=DjxY9xfsTYSWk4yR99ILE8xz3o2YSg36NeLT/0A2zoMV3EWUuOrsgn1WIyXCR6ANPo
         UYyLI6YmX1CE6xVed3nBQyAt0A6is/FMJ/Q5g/DEJDDoMmkEkPdijK+A0J0q7OBB4rwz
         ao0Ubnqb49/zIRFbcuJGVOvYy0AIXEeQ06wEQCJaNHDQswIy0JICDIZLzwlh58zNmNkS
         KBj5/TlTzGm79+LWErw8FPdnSzmR2MWhRJiosaZh/CryQAfQfMYf4wLsObNr40kdOsrT
         C+RrSBMBvYu7A3ZT8o70mVOUP8W0JK9FHpS1HXmQwaIawQXHynkVc+tBUjGxuZNMrrv5
         6x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706842; x=1758311642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMaCvv0Npwgx9oOEe08/7S4E7IejpQl1+Xgtp1j/Fs0=;
        b=xUWBJu9b7g1N8XeoVNo04FXsgJkw4UfDcHEyLC2PAZ51L31gHe5Am9LsiemsUDCrq5
         wMK/c0qSHpGqEYfilEdGYIFtJoJvfRTKxDzEKFYaszdsOhsZE2HhdGYZzG/qJHtxK8L/
         BKvY0UgZ2AP6+RfM7G/3uVZ8ky7xwbjLgjxzr9+LpU3tSzlhpON93A64N9Z71MoM5idL
         nX6KvbQRsEtYL63vUiizQUpabrm0xJZS1I+h7PZS/TQ7GtlROI6TwAaivNJ340F62SDk
         UYJh5sw+bTNb/pp91jNWgVYk3Z2TGP+2T9J7pFdB2Q029zF53D2HctMW+8tdrQUXK+af
         040A==
X-Forwarded-Encrypted: i=1; AJvYcCWWoeY/RmcAS6hKajlwOsq5o8lOr25QRqCY0wDuLnd4ch40BBMIRkaAkj/5u4QEqz4d3uJjpQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaJYeZMPoKIJSGqvQriBqPyXye+HUminWsNezjAu5LUywb+3y
	XQSv7l2v7OhdsK/tV89G3FvY4RpbQKBp1GrRTKx9UwIvi2nLS7J0DU75c++Ymg==
X-Gm-Gg: ASbGncvYkOl2XN2KPFGfTAG/6kMliyxAl+9H6nY4RFR1tI7p1kpJ7EobFjpFpV82IDt
	2EJC7WjoAjFYoBaHBldGppp5vTWTEBNDzZphrxTpgwRDhhSuT2VtXFOgsbHPz0y9w6VQoiVMLX3
	g9bw4yr3c0PhXy+JYv5jg7i1qsEKMd8GPr9A7zU2IHRP5qmJz3VLVaYrjcqwoVUAwM7o4p4ZTMB
	MP6NlkCTbGiBw8OWGJlKk0xIah0/hRQA+ahQyqA6FyImLfeZ5Dltn4I8lUevqB6s+pYMCAolCr0
	6nuwuypwz88ZMpNQOLlS0LpwNU/qqAQWnMJkgKJC/LYxdVWCRcPS43ZDvgLjVwpoNbgsu2+ycxT
	1SP1742QaD9H2cNZ/NhiYvBG8CKKL0UFxcNA/aDDqV8gSy6RkFzZrKCBLNJtkpgpGpJc2jk3J
X-Google-Smtp-Source: AGHT+IHOezLJRLoDEw/gyTNCxGzG6tpMAlxv09ll/ErrKIIhPmloNLfh1ZLyplu0Cr/e++Aufdl6nA==
X-Received: by 2002:a05:6000:178e:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e765a53ca5mr3716925f8f.63.1757706842098;
        Fri, 12 Sep 2025 12:54:02 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:01 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 07/15] genetlink: add THIRD_GENL family
Date: Fri, 12 Sep 2025 22:53:30 +0300
Message-Id: <20250912195339.20635-8-yana2bsh@gmail.com>
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

- New family with echo command
- Supports string and flag attributes
- Sysfs interface at /sys/kernel/third_genl/message

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index cdedd77b2a1b..f651159a311c 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -152,10 +152,13 @@ static DEFINE_MUTEX(genl_mutex);
 
 #define PARALLEL_GENL_FAMILY_NAME "PARALLEL_GENL"
 
+#define THIRD_GENL_FAMILY_NAME "THIRD_GENL"
+
 #define PATH_GENL_TEST_NUM "/sys/kernel/genl_test/value"
 #define PATH_GENL_TEST_MES "/sys/kernel/genl_test/message"
 #define PATH_GENL_TEST_DEV "/sys/kernel/genl_test/some_info"
 #define PATH_PARALLEL_GENL_MES "/sys/kernel/parallel_genl/message"
+#define PATH_THIRD_GENL_MES "/sys/kernel/third_genl/message"
 
 // TEST_GENL
 enum {
@@ -205,6 +208,8 @@ static struct genl_family my_genl_family;
 
 static struct genl_family my_genl_family_parallel;
 
+static struct genl_family third_genl_family;
+
 enum my_multicast_groups {
 	MY_MCGRP_GENL,
 };
@@ -1077,6 +1082,94 @@ static struct genl_family my_genl_family_parallel = {
 	.n_mcgrps = ARRAY_SIZE(genl_many_mcgrps_two),
 };
 
+// THIRD_GENL
+enum {
+	THIRD_GENL_ATTR_UNSPEC,
+	THIRD_GENL_ATTR_DATA,
+	THIRD_GENL_ATTR_FLAG,
+	__THIRD_GENL_ATTR_MAX,
+};
+
+#define THIRD_GENL_ATTR_MAX (__THIRD_GENL_ATTR_MAX - 1)
+
+enum {
+	THIRD_GENL_CMD_UNSPEC,
+	THIRD_GENL_CMD_ECHO,
+	__THIRD_GENL_CMD_MAX,
+};
+
+#define THIRD_GENL_CMD_MAX (__THIRD_GENL_CMD_MAX - 1)
+
+static const struct nla_policy third_genl_policy[THIRD_GENL_ATTR_MAX + 1] = {
+	[THIRD_GENL_ATTR_UNSPEC] = { .type = NLA_UNSPEC },
+	[THIRD_GENL_ATTR_DATA] = { .type = NLA_STRING },
+	[THIRD_GENL_ATTR_FLAG] = { .type = NLA_FLAG },
+};
+
+// Functions for THIRD_GENL family
+static int third_genl_echo(struct sk_buff *skb, struct genl_info *info)
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
+					 THIRD_GENL_CMD_ECHO);
+		if (!data)
+			goto error;
+
+		str = "Hello from THIRD_GENL!";
+		strcpy(sysfs_data.third_genl_message, str);
+
+		ret = nla_put_string(msg, THIRD_GENL_ATTR_DATA, str);
+		if (ret < 0)
+			goto error;
+
+		ret = nla_put_flag(msg, THIRD_GENL_ATTR_FLAG);
+		if (ret < 0)
+			goto error;
+
+		genlmsg_end(msg, data);
+
+		genlmsg_reply(msg, info);
+	}
+
+	return 0;
+
+error:
+	nlmsg_free(msg);
+	return -EMSGSIZE;
+}
+
+// Generic Netlink operations for THIRD_GENL family
+static const struct genl_ops third_genl_ops[] = {
+	{
+		.cmd = THIRD_GENL_CMD_ECHO,
+		.flags = 0,
+		.policy = third_genl_policy,
+		.doit = third_genl_echo,
+		.dumpit = NULL,
+	},
+};
+
+// genl_family struct for THIRD_GENL family
+static struct genl_family third_genl_family = {
+	.hdrsize = 0,
+	.name = THIRD_GENL_FAMILY_NAME,
+	.version = 1,
+	.maxattr = THIRD_GENL_ATTR_MAX,
+	.netnsok = true,
+	.ops = third_genl_ops,
+	.n_ops = ARRAY_SIZE(third_genl_ops),
+	.policy = third_genl_policy,
+};
+
 // genl_family struct with incorrect name
 static struct genl_family incorrect_genl_family = {
 	.hdrsize = 0,
@@ -1144,8 +1237,16 @@ static int __init init_netlink(void)
 		goto failure_2;
 	}
 
+	rc = genl_register_family(&third_genl_family);
+	if (rc) {
+		pr_err("%s: Failed to register Generic Netlink family\n", __func__);
+		goto failure_3;
+	}
+
 	return 0;
 
+failure_3:
+	genl_unregister_family(&my_genl_family_parallel);
 failure_2:
 	genl_unregister_family(&my_genl_family);
 failure_1:
@@ -1311,6 +1412,7 @@ static int __init module_netlink_init(void)
 err_family:
 	genl_unregister_family(&my_genl_family);
 	genl_unregister_family(&my_genl_family_parallel);
+	genl_unregister_family(&third_genl_family);
 err_sysfs:
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
@@ -1330,6 +1432,7 @@ static void __exit module_netlink_exit(void)
 	netlink_unregister_notifier(&genl_notifier);
 	genl_unregister_family(&my_genl_family);
 	genl_unregister_family(&my_genl_family_parallel);
+	genl_unregister_family(&third_genl_family);
 
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
-- 
2.34.1


