Return-Path: <netdev+bounces-222700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF004B55739
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABD77C7569
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F4352FE3;
	Fri, 12 Sep 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJObfN5x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E934DCEB
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706854; cv=none; b=Vm6TY5eVdNJ8CGAPtmx+syRAnbfUwNsNF+Hb9VrguY0yHII1ifmsIYTb2mjEK8xZ/xa+99A2GXkfqaTA+HEGhvQGdy/6Ma0/wYFzC1lAPs8rZrsPPRF6C3+e8dZauymD57L+kT6ObXcNoe5gx9RIAIcmCe969VjX+pyQZ9efJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706854; c=relaxed/simple;
	bh=pJHnhqWiYo5cTWEwaTkSoKMKgT9nRFnFPrONnJs+rKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iEyjXI7wJmCAnreDD3Gug36WFRnbMbAs2yetgWUqZ1d0LKWxIm/Tc40kx7+u7+bAscePwvk3gPqrxHX4Kt4zyi6qweZA+xOx1vy9Ra9rwe+ln72kZL25So3gOEp7nxTWopL9AkTxJkJtQ9TXLByBGb60ijnzCni2zT12IHdLRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJObfN5x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45decc9e83dso14819155e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706850; x=1758311650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xHrm3UhjY1E+duBeU+wutMGux/GWwKkhqrETHzmbNA=;
        b=SJObfN5xO2ypN+zFwaCUnHARdTguBmwU95Woh8dBTFmHHbvrEV8+mabV9F6LqOB1UT
         VCvxUHTPC87zuA+uMn6qn2G0KXpB7W/xohrrr6z6/0tAygWo97TR0Lzi1mLPX/Pocwll
         u7DOHzcuDbcWz2z6r+miHHzxpB3C8729Eu221REfZ5x1Hvuc5apgf+/w/KTGSJAdb/iR
         H00yA+xHeKBv9rNL0zFkLZ98w9UWcCibGTFBvdzFd5sQwGDgQXkb28NPPlZRNy2UFzGC
         BVrzeohCu42mNS0XNYzcMA4crqjDv+lOar3uLUIy5SU0G4PrvzL1R+H4X2+ZNLHxQOSV
         a7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706850; x=1758311650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xHrm3UhjY1E+duBeU+wutMGux/GWwKkhqrETHzmbNA=;
        b=dmNaYIcuGSvPgsaB6q4U9Wbj/NA7prxLvJaEtiGyif3rJARcKn5TJjkdQO7Fk/WwJ6
         K2ACq+NSEm0L3ASoR4/6xFiCsmtUL3+j4S9PiGSoctPNMOmdveW5WCh2LktOTQz8pI9Q
         G9JlkIX8VKSTA9wqO/Ifj8WxelNJrMaaBrKVHv0qZXB0M1YzmqbuW/iFw4P9l4Cs37Rx
         UcoUzBleiM95RJW6DINKO2K6DICeZacV6Vb/eDPtVt0x2EfbSvZvQSKdwF1Jax7V1XwB
         fxEh0BWEGBPtxZVnmhEYt9SAIrUVdREw9o6tSKzvJ/K3MM43je/NIk7moOoKenT+uIRz
         hSfA==
X-Forwarded-Encrypted: i=1; AJvYcCUkOH1Uy20Dkx/1sXNBckIDF6cR6z95JnDIBYq8WcleePPXZlKEKYtAd/acjNadkhelKa+GdvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPoSm9Mnk8c6SAKHs4g9G6vMXCOidQdrgFmSaasLhp4k++8co
	iLCtaatvTcKBvjONGs3QIbSh2Bbm35cYx+Uz/3yAOuN+88i72ezX0xeO
X-Gm-Gg: ASbGncv6Q09LKw+C+kUii9z9a2jSL7PF9tSuC8FwzgAaxeSY/GOZua3kFO5qmeeTKNb
	ehpqTEbF30vVGvPVoaMIXkoDRcT0KpJCKFjgWdfJEOaigMyXq+fGTikf2p7hR14Do2CUP0DqGyA
	wEXUx9sWT622VxGi/6j82BVIbd9dQ8ocKqmhwohXSOIKDbY3baZNlJMXlI85a+9Xg1CfzG6axfa
	lKPnBA5salhlu6HpCHbaLoRc+mqo8EuJ1m47ss590zPik00UTyDBk++BJv6H0aRDGsdKRkfkp5V
	J8nJDDlBHI9BKqcTOoH7eRySyPKzOk2MeGdPdEzOSGVMIWqflsgZ4UYYc7g4FFTEwY43In21dAz
	2hLHtyPJj0nA9YcXGrMQ9otd6ZGxK0ZxBl90D2S8McsaPCrkWk7+doAqnrJQVpQ==
X-Google-Smtp-Source: AGHT+IEj7jZtshMFUnczbfQcwbELhSqa75oEUSkRUcNPLeWsst/HzcrhQTmsQxXD0MtH+3hn9mT7LQ==
X-Received: by 2002:a05:600c:198f:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45f24df556fmr27201995e9.0.1757706849638;
        Fri, 12 Sep 2025 12:54:09 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:09 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 12/15] selftests: net: genetlink: add Generic Netlink controller tests
Date: Fri, 12 Sep 2025 22:53:35 +0300
Message-Id: <20250912195339.20635-13-yana2bsh@gmail.com>
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

Add comprehensive test coverage for nlctrl (Generic Netlink controller)

Add my_genl_ctrl_resolve function for resolving family ID

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 925 ++++++++++++++++++++++++
 1 file changed, 925 insertions(+)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index f8231a302c36..0a05402caa20 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -81,6 +81,404 @@
 
 #define LARGE_GENL_FAMILY_NAME "LARGE_GENL"
 
+/**
+ * Callback data structures - used to pass data between test cases and message handlers
+ */
+
+struct callback_data_ctrl {
+	int family_id;
+	char *family_name;
+	int op;
+	struct expected_policies *expected_policy;
+	int family_index;
+};
+
+static int elem;
+
+static int id_elem;
+
+struct ctrl_policy {
+	int id;
+	uint32_t field;
+	uint32_t type;
+	int value;
+};
+
+struct ctrl_policy expected_parallel_policy[] = {
+	{ 1, CTRL_ATTR_OP_POLICY, CTRL_ATTR_POLICY_DO, 0 },
+	{ 2, CTRL_ATTR_OP_POLICY, CTRL_ATTR_POLICY_DUMP, 0 },
+	{ 3, CTRL_ATTR_OP_POLICY, CTRL_ATTR_POLICY_DO, 1 },
+	{ 4, CTRL_ATTR_OP_POLICY, CTRL_ATTR_POLICY_DO, 0 },
+	{ 5, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 11 },
+	{ 6, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 10 },
+	{ 7, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 12 },
+	{ 8, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 12 },
+	{ 9, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 15 },
+	{ 9, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_BITFIELD32_MASK, 0 },
+	{ 10, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 8 },
+	{ 10, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_MIN_VALUE_S, -100 },
+	{ 10, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_MAX_VALUE_S, 100 },
+	{ 11, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 14 },
+	{ 12, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 13 },
+	{ 13, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 1 },
+	{ 14, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 1 },
+	{ 15, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 11 },
+};
+
+struct ctrl_policy expected_genl_cmd_get_value_policy[] = {
+	{ 1, CTRL_ATTR_OP_POLICY, CTRL_ATTR_POLICY_DO, 0 },
+	{ 2, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 11 },
+	{ 3, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 4 },
+	{ 3, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_MIN_VALUE_U, 0 },
+	{ 3, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_MAX_VALUE_U, 100 },
+	{ 4, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 11 },
+	{ 5, CTRL_ATTR_POLICY, NL_POLICY_TYPE_ATTR_TYPE, 13 },
+};
+
+struct expected_policies {
+	struct ctrl_policy *policy;
+	int count;
+	int matched;
+};
+
+struct expected_policies parallel_policy = {
+	.policy = expected_parallel_policy,
+	.count = sizeof(expected_parallel_policy) /
+		 sizeof(expected_parallel_policy[0]),
+	.matched = 0,
+};
+
+struct expected_policies genl_cmd_get_value_policy = {
+	.policy = expected_genl_cmd_get_value_policy,
+	.count = sizeof(expected_genl_cmd_get_value_policy) /
+		 sizeof(expected_genl_cmd_get_value_policy[0]),
+	.matched = 0,
+};
+
+int validate_cb_ctrl(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[CTRL_ATTR_MAX + 1];
+	int ret = 0;
+	int family_id = -40;
+	char *family_name = NULL;
+
+	ret = genlmsg_parse(nlmsg_hdr(msg), 0, attrs, CTRL_ATTR_MAX, NULL);
+	if (ret < 0) {
+		printf("Failed to parse attributes: %d\n", ret);
+		return NL_STOP;
+	}
+
+	struct callback_data_ctrl *data_ctrl = (struct callback_data_ctrl *)arg;
+
+	switch (gnlh->cmd) {
+	case CTRL_CMD_NEWFAMILY:
+		if (attrs[CTRL_ATTR_FAMILY_ID]) {
+			if (data_ctrl->family_name) {
+				family_name = nla_get_string(
+					attrs[CTRL_ATTR_FAMILY_NAME]);
+				if (!strcmp(family_name,
+					    data_ctrl->family_name)) {
+					family_id = nla_get_u16(
+						attrs[CTRL_ATTR_FAMILY_ID]);
+					data_ctrl->family_id = family_id;
+				}
+			}
+		}
+		if (attrs[CTRL_ATTR_FAMILY_NAME]) {
+			if (data_ctrl->family_id) {
+				if (!data_ctrl->family_name) {
+					family_name = nla_get_string(
+						attrs[CTRL_ATTR_FAMILY_NAME]);
+					data_ctrl->family_name = family_name;
+				}
+			}
+		}
+		data_ctrl->family_index++;
+		return NL_OK;
+
+	case CTRL_CMD_GETPOLICY:
+		struct ctrl_policy *exp =
+			&data_ctrl->expected_policy->policy[elem];
+		if (attrs[CTRL_ATTR_FAMILY_ID]) {
+			family_id = nla_get_u16(attrs[CTRL_ATTR_FAMILY_ID]);
+			data_ctrl->family_id = family_id;
+		}
+
+		if (attrs[CTRL_ATTR_OP_POLICY]) {
+			struct nlattr *nla;
+			int rem;
+
+			nla_for_each_nested(nla, attrs[CTRL_ATTR_OP_POLICY],
+					    rem) {
+				struct nlattr *tb[CTRL_ATTR_POLICY_MAX + 1] = {
+					NULL
+				};
+
+				int err = nla_parse_nested(
+					tb, CTRL_ATTR_POLICY_MAX, nla, NULL);
+				if (err < 0) {
+					printf("Failed to parse nested policy attributes: %d\n",
+					       err);
+					continue;
+				}
+
+				if (tb[CTRL_ATTR_POLICY_DO]) {
+					uint32_t do_id = nla_get_u32(
+						tb[CTRL_ATTR_POLICY_DO]);
+					if (exp->field == CTRL_ATTR_OP_POLICY &&
+					    exp->type == CTRL_ATTR_POLICY_DO &&
+					    exp->value == do_id) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+
+				if (tb[CTRL_ATTR_POLICY_DUMP]) {
+					uint32_t dump_id = nla_get_u32(
+						tb[CTRL_ATTR_POLICY_DUMP]);
+					if (exp->field == CTRL_ATTR_OP_POLICY &&
+					    exp->type ==
+						    CTRL_ATTR_POLICY_DUMP &&
+					    exp->value == dump_id) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+			}
+			id_elem++;
+		}
+
+		if (attrs[CTRL_ATTR_POLICY]) {
+			struct nlattr *policy_attr;
+			int rem;
+
+			nla_for_each_nested(policy_attr,
+					    attrs[CTRL_ATTR_POLICY], rem) {
+				struct nlattr *tb[NL_POLICY_TYPE_ATTR_MAX +
+						  1] = { NULL };
+
+				int err = nla_parse_nested(
+					tb, NL_POLICY_TYPE_ATTR_MAX,
+					nla_data(policy_attr), NULL);
+				if (err < 0) {
+					printf("Failed to parse nested policy attributes: %d\n",
+					       err);
+					continue;
+				}
+
+				if (tb[NL_POLICY_TYPE_ATTR_TYPE]) {
+					uint32_t value1 = nla_get_u32(
+						tb[NL_POLICY_TYPE_ATTR_TYPE]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_TYPE &&
+					    exp->value == value1) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+
+				if (tb[NL_POLICY_TYPE_ATTR_MIN_VALUE_S]) {
+					int64_t value2 = nla_get_s64(
+						tb[NL_POLICY_TYPE_ATTR_MIN_VALUE_S]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_MIN_VALUE_S &&
+					    exp->value == value2) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+
+				if (tb[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]) {
+					int64_t value3 = nla_get_s64(
+						tb[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_MAX_VALUE_S &&
+					    exp->value == value3) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+
+				if (tb[NL_POLICY_TYPE_ATTR_MIN_VALUE_U]) {
+					uint64_t value4 = nla_get_u64(
+						tb[NL_POLICY_TYPE_ATTR_MIN_VALUE_U]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_MIN_VALUE_U &&
+					    exp->value == value4) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+
+				if (tb[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]) {
+					uint64_t value5 = nla_get_u64(
+						tb[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_MAX_VALUE_U &&
+					    exp->value == value5) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+					}
+				}
+				if (tb[NL_POLICY_TYPE_ATTR_MIN_LENGTH]) {
+					uint32_t value6 = nla_get_u32(
+						tb[NL_POLICY_TYPE_ATTR_MIN_LENGTH]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_MIN_LENGTH &&
+					    exp->value == value6) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+
+				if (tb[NL_POLICY_TYPE_ATTR_MAX_LENGTH]) {
+					uint32_t value7 = nla_get_u32(
+						tb[NL_POLICY_TYPE_ATTR_MAX_LENGTH]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_MAX_LENGTH &&
+					    exp->value == value7) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+				if (tb[NL_POLICY_TYPE_ATTR_POLICY_IDX]) {
+					uint32_t value8 = nla_get_u32(
+						tb[NL_POLICY_TYPE_ATTR_POLICY_IDX]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_POLICY_IDX &&
+					    exp->value == value8) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+
+				if (tb[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE]) {
+					uint32_t value9 = nla_get_u32(
+						tb[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE &&
+					    exp->value == value9) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+				if (tb[NL_POLICY_TYPE_ATTR_BITFIELD32_MASK]) {
+					uint32_t value10 = nla_get_u32(
+						tb[NL_POLICY_TYPE_ATTR_BITFIELD32_MASK]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_BITFIELD32_MASK &&
+					    exp->value == value10) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+
+				if (tb[NL_POLICY_TYPE_ATTR_PAD]) {
+					uint64_t value11 = nla_get_u64(
+						tb[NL_POLICY_TYPE_ATTR_PAD]);
+					if (exp->field == CTRL_ATTR_POLICY &&
+					    exp->type ==
+						    NL_POLICY_TYPE_ATTR_PAD &&
+					    exp->value == value11) {
+						data_ctrl->expected_policy
+							->matched++;
+						elem++;
+						if (elem != id_elem) {
+							exp = &data_ctrl
+								       ->expected_policy
+								       ->policy[elem];
+						}
+					}
+				}
+			}
+			id_elem++;
+		}
+		return NL_OK;
+	default:
+		printf("Unknown command: %u\n", gnlh->cmd);
+		break;
+	}
+	return NL_OK;
+}
+
 struct nl_sock *socket_alloc_and_conn(void)
 {
 	struct nl_sock *socket;
@@ -100,6 +498,100 @@ struct nl_sock *socket_alloc_and_conn(void)
 	return socket;
 }
 
+int my_genl_ctrl_resolve(char *family_name)
+{
+	struct nl_sock *ctrl_sock;
+	int genl_ctrl_family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb_ctrl;
+	int err = -100;
+	struct callback_data_ctrl cb_ctrl_data;
+
+	cb_ctrl_data.family_name = family_name;
+
+	ctrl_sock = socket_alloc_and_conn();
+	if (!ctrl_sock) {
+		fprintf(stderr, "socket for genl_ctrl is NULL\n");
+		return -ENOMEM;
+	}
+
+	genl_ctrl_family_id = genl_ctrl_resolve(ctrl_sock, GENL_CTRL);
+	if (genl_ctrl_family_id < 0) {
+		fprintf(stderr,
+			"Failed to resolve family id for genl_ctrl: %d\n",
+			genl_ctrl_family_id);
+		err = genl_ctrl_family_id;
+		return err;
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(ctrl_sock);
+		return -ENOMEM;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ,
+			       genl_ctrl_family_id, 0,
+			       NLM_F_REQUEST | NLM_F_DUMP, CTRL_CMD_GETFAMILY,
+			       0);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return -ENOMEM;
+	}
+
+	if (nla_put_string(msg, CTRL_ATTR_FAMILY_NAME, family_name) < 0) {
+		fprintf(stderr,
+			"Failed to add CTRL_ATTR_FAMILY_NAME attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return -EMSGSIZE;
+	}
+
+	cb_ctrl = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb_ctrl) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return -ENOMEM;
+	}
+
+	err = nl_cb_set(cb_ctrl, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_ctrl,
+			&cb_ctrl_data);
+	if (err < 0) {
+		printf("Error setting callback\n");
+		goto error;
+	}
+
+	err = nl_send_auto(ctrl_sock, msg);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(ctrl_sock, cb_ctrl);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	nlmsg_free(msg);
+	nl_cb_put(cb_ctrl);
+	nl_socket_free(ctrl_sock);
+	return cb_ctrl_data.family_id;
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb_ctrl);
+	nl_socket_free(ctrl_sock);
+	return err;
+}
+
 /*
  * Test cases
  */
@@ -217,6 +709,439 @@ TEST(open_netlink_file)
 	fclose(file);
 }
 
+/**
+ * TEST(genl_ctrl_one_family) - Tests resolution of single Generic Netlink family
+ *
+ * Validates that:
+ * 1. Controller correctly resolves family ID for given family name
+ * 2. Family ID obtained through direct query matches cached resolution
+ * 3. Callback correctly processes controller response
+ *
+ * Test flow:
+ * 1. Creates control socket
+ * 2. Sends GETFAMILY request for target family
+ * 3. Validates response through callback
+ * 4. Compares with direct resolution result
+ */
+
+TEST(genl_ctrl_one_family)
+{
+	struct nl_sock *ctrl_sock;
+	int genl_ctrl_family_id;
+	int family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb_ctrl;
+	int err = 0;
+	struct callback_data_ctrl cb_ctrl_data;
+
+	cb_ctrl_data.family_id = -30;
+	cb_ctrl_data.family_name = NULL;
+	cb_ctrl_data.op = -100;
+
+	printf("Running Test: getting family via genl_ctrl...\n");
+
+	ctrl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, ctrl_sock);
+	if (!ctrl_sock) {
+		fprintf(stderr, "socket for genl_ctrl is NULL\n");
+		return;
+	}
+
+	genl_ctrl_family_id = genl_ctrl_resolve(ctrl_sock, GENL_CTRL);
+	EXPECT_GT(genl_ctrl_family_id, 0);
+	if (genl_ctrl_family_id < 0) {
+		fprintf(stderr,
+			"Failed to resolve family id for genl_ctrl: %d\n",
+			genl_ctrl_family_id);
+		err = genl_ctrl_family_id;
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ,
+			       genl_ctrl_family_id, 0, NLM_F_REQUEST,
+			       CTRL_CMD_GETFAMILY, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, CTRL_ATTR_FAMILY_NAME,
+			   PARALLEL_GENL_FAMILY_NAME) < 0) {
+		fprintf(stderr,
+			"Failed to add CTRL_ATTR_FAMILY_NAME attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+	cb_ctrl_data.family_name = PARALLEL_GENL_FAMILY_NAME;
+
+	cb_ctrl = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb_ctrl);
+	if (!cb_ctrl) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb_ctrl, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_ctrl,
+			&cb_ctrl_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		printf("Error setting callback\n");
+		goto error;
+	}
+
+	err = nl_send_auto(ctrl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(ctrl_sock, cb_ctrl);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+	my_genl_ctrl_resolve(PARALLEL_GENL_FAMILY_NAME);
+	family_id = genl_ctrl_resolve(socket_alloc_and_conn(),
+				      PARALLEL_GENL_FAMILY_NAME);
+	EXPECT_GT(cb_ctrl_data.family_id, 0);
+	EXPECT_GT(family_id, 0);
+	EXPECT_EQ(cb_ctrl_data.family_id, family_id);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb_ctrl);
+	nl_socket_free(ctrl_sock);
+}
+
+/**
+ * TEST(genl_ctrl_family) - Tests dumping all registered Generic Netlink families
+ *
+ * Verifies that:
+ * 1. Controller correctly responds to family dump request
+ * 2. No errors occur during dump operation
+ *
+ * Test flow:
+ * 1. Creates control socket and resolves genl_ctrl family
+ * 2. Sends GETFAMILY dump request with NLM_F_DUMP flag
+ * 3. Checks for operation success
+ */
+
+TEST(genl_ctrl_family)
+{
+	struct nl_sock *ctrl_sock;
+	int genl_ctrl_family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb_ctrl;
+	int err = 0;
+	struct callback_data_ctrl cb_ctrl_data;
+
+	cb_ctrl_data.family_id = -30;
+	cb_ctrl_data.family_name = NULL;
+	cb_ctrl_data.op = -100;
+	cb_ctrl_data.family_index = 0;
+
+	printf("Running Test: getting families via genl_ctrl...\n");
+
+	ctrl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, ctrl_sock);
+	if (!ctrl_sock) {
+		fprintf(stderr, "socket for genl_ctrl is NULL\n");
+		return;
+	}
+
+	genl_ctrl_family_id = genl_ctrl_resolve(ctrl_sock, GENL_CTRL);
+	EXPECT_GT(genl_ctrl_family_id, 0);
+	if (genl_ctrl_family_id < 0) {
+		fprintf(stderr,
+			"Failed to resolve family id for genl_ctrl: %d\n",
+			genl_ctrl_family_id);
+		err = genl_ctrl_family_id;
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ,
+			       genl_ctrl_family_id, 0, NLM_F_DUMP,
+			       CTRL_CMD_GETFAMILY, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	cb_ctrl = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb_ctrl);
+	if (!cb_ctrl) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb_ctrl, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_ctrl,
+			&cb_ctrl_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		printf("Error setting callback\n");
+		goto error;
+	}
+
+	err = nl_send_auto(ctrl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(ctrl_sock, cb_ctrl);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+	EXPECT_GE(cb_ctrl_data.family_index, 4);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb_ctrl);
+	nl_socket_free(ctrl_sock);
+}
+
+/**
+ * TEST(genl_ctrl_policy) - Validates Generic Netlink policy retrieval mechanism
+ *
+ * Tests that:
+ * 1. Policy information can be retrieved by family ID and name
+ * 2. Operation-specific policies can be retrieved
+ * 3. Retrieved policies match expected structures
+ *
+ * Test sequence:
+ * 1. Retrieves general policy for PARALLEL_GENL family
+ * 2. Retrieves operation-specific policy for MY_GENL_CMD_GET_VALUE
+ * 3. Validates policy contents through callback
+ */
+
+TEST(genl_ctrl_policy)
+{
+	struct nl_sock *ctrl_sock;
+	int genl_ctrl_family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb_ctrl;
+	int err = 0;
+	struct callback_data_ctrl cb_ctrl_data;
+
+	cb_ctrl_data.family_id = -30;
+	cb_ctrl_data.family_name = NULL;
+	cb_ctrl_data.op = -100;
+	cb_ctrl_data.expected_policy = &parallel_policy;
+	cb_ctrl_data.expected_policy->matched = 0;
+
+	printf("Running Test: getting policy via genl_ctrl...\n");
+
+	ctrl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, ctrl_sock);
+	if (!ctrl_sock) {
+		fprintf(stderr,
+			"sockets for genl_ctrl and parallel_genl are NULL\n");
+		return;
+	}
+
+	genl_ctrl_family_id = genl_ctrl_resolve(ctrl_sock, GENL_CTRL);
+	EXPECT_GT(genl_ctrl_family_id, 0);
+	if (genl_ctrl_family_id < 0) {
+		fprintf(stderr,
+			"Failed to resolve family id for genl_ctrl: %d\n",
+			genl_ctrl_family_id);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	printf("Start first message with family id and family name\n");
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ,
+			       genl_ctrl_family_id, 0, NLM_F_DUMP,
+			       CTRL_CMD_GETPOLICY, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	if (nla_put_u16(msg, CTRL_ATTR_FAMILY_ID,
+			genl_ctrl_resolve(ctrl_sock,
+					  PARALLEL_GENL_FAMILY_NAME)) < 0) {
+		fprintf(stderr,
+			"Failed to add CTRL_ATTR_FAMILY_ID attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+	if (nla_put_string(msg, CTRL_ATTR_FAMILY_NAME,
+			   PARALLEL_GENL_FAMILY_NAME) < 0) {
+		fprintf(stderr,
+			"Failed to add CTRL_ATTR_FAMILY_NAME attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb_ctrl = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb_ctrl);
+	if (!cb_ctrl) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb_ctrl, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_ctrl,
+			&cb_ctrl_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(ctrl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(ctrl_sock, cb_ctrl);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+	EXPECT_EQ(cb_ctrl_data.expected_policy->matched,
+		  cb_ctrl_data.expected_policy->count);
+
+	printf("[OK] [1/2]\n");
+
+	cb_ctrl_data.expected_policy = &genl_cmd_get_value_policy;
+	cb_ctrl_data.expected_policy->matched = 0;
+	elem = 0;
+	id_elem = 0;
+
+	nlmsg_free(msg);
+
+	printf("Start second message with family name and ctrl_attr_op\n");
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(ctrl_sock);
+		nl_cb_put(cb_ctrl);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ,
+			       genl_ctrl_family_id, 0, NLM_F_DUMP,
+			       CTRL_CMD_GETPOLICY, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		goto error;
+	}
+
+	if (nla_put_string(msg, CTRL_ATTR_FAMILY_NAME, MY_GENL_FAMILY_NAME) <
+	    0) {
+		fprintf(stderr,
+			"Failed to add CTRL_ATTR_FAMILY_NAME attribute: %s\n",
+			strerror(errno));
+		EXPECT_EQ(0, 1);
+		goto error;
+	}
+
+	if (nla_put_u32(msg, CTRL_ATTR_OP, MY_GENL_CMD_GET_VALUE) < 0) {
+		fprintf(stderr, "Failed to add CTRL_ATTR_OP attribute: %s\n",
+			strerror(errno));
+		EXPECT_EQ(0, 1);
+		goto error;
+	}
+
+	err = nl_send_auto(ctrl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(ctrl_sock, cb_ctrl);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	EXPECT_EQ(cb_ctrl_data.expected_policy->matched,
+		  cb_ctrl_data.expected_policy->count);
+	printf("[OK] [2/2]\n");
+
+	cb_ctrl_data.expected_policy->matched = 0;
+	elem = 0;
+	id_elem = 0;
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb_ctrl);
+	nl_socket_free(ctrl_sock);
+}
+
 /**
  * TEST(capture_end) - Terminates Netlink traffic monitoring session
  *
-- 
2.34.1


