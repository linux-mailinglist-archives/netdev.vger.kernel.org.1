Return-Path: <netdev+bounces-74727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AC1862914
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 05:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC631C20BBF
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 04:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA12610B;
	Sun, 25 Feb 2024 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MWg1CTzB"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602C7460
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708834288; cv=none; b=Zdxb37qIQQ+GlKT05okXG7qvo5TvxXoHMyh5Yn2F8gAO1xWdKWkNee4vlfXFlFW7p2T+XYFKKfg9Yfg6BTXI+4UkXE95cqaAgwFCPg3XinBJLkAy7n8WyCDnycXdrnoRzDQgVMgCrQIzyQ7VKVIbSqhTB14F49C43lBrW0X1hco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708834288; c=relaxed/simple;
	bh=v0u0UY6IZLeK7m5DJpMpA2gcsbr5QD2SeoS8vKGYb4s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QsTt/5jFXi4oNY6jbujblvk5gt6gpHP48tl8r9rQNml2X0oejEV3SxQ2kHM+iTEWwHmQLtEMFWarYAxEGyYLeYtd1d5E1DIJY3a5PiFSXH8Svpj1zJMFSqfrTeOjVB1vXwPjyE3+SuiRD+hqV9bMV2UGgLeCkHAfzm19OJBXZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MWg1CTzB; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708833981;
	bh=eeuZJq6Fxo2cYyc6x11JY0tSqm747i90EQ3x4JLdDpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MWg1CTzBCcYkNXIeWTckng8BjAbOVlYgk158ElE+Vt8ArDpGlcViwMkRMQpqthccZ
	 W/nncZjO8yhbo3iNSutc8OuH6kXRRJUyYaH5MHSLMOK577r/6+f/e5Pe3YfJg0ZF6h
	 3POEwVzul5tPfpwvaH7ZpO6zkLH0CE8AOwfejP00=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708833973tqo6zfhr6
Message-ID: <tencent_95D22FF919A42A99DA3C886B322CBD983905@qq.com>
X-QQ-XMAILINFO: OQ59tfF64tJLisGDfjHLssboL2wrAS+OJRngdWOM2ugGCBYT8TEY4f7nQdWleK
	 PZVJRFePG7rTc/H+tpBH+NvaJHtnD83UM6gNBWzQM990fbc40e+g4u3PweR79sjfEm6iCPdrF2si
	 mQtoR7zWd4JJQtkYm6YzFCyU+6JHD9hi/6A1S+Er1yDoeg57zcHZUNNEhF2JHmhjb3bKP/FIzE4/
	 AULq5O9opHJxz0dp+qwsX08fJHP5FgOToRSBE1F/VFqh2Wl8FnA8ENIErQvKdfG6wRn0jxuCUCwt
	 aEaxjWRpKGGczA2grKZ0ynSRZrQf+8PRJBjRDdyOLGXqsH69itJeDIYf71HMse992xWfC4giiyAX
	 TDX+qkmNG7YY3jrfcg5/wvXfv+pnOZU3qIdiDAylAgPS5zBWMBJzHFH/BAyIdb51vkusD2Ww/7sp
	 q1MY7uPGasrnH2Z0/NbUBj7g7BV1fDL/ghsuBOZVKaP5RFfUzjKaNrt2LcrMHVh+blNgW8N9SXhF
	 OYziCHd7hKAq8t+it2WdV6Vi/Qiv1MVltuY6Fat14O811aUOb7rQK+ovLCpoHVyHH71f4E8rJ9h+
	 ONVj7VwwAZyqcKkHrHWeVs7lol0BObISUSCfY2B2MVi/y2X2gVmWScumxI4+Pg5XXU4XfQypyNS8
	 TjlRCks2BCiY+1xGFVr/E4aLwopXT5Hx7vy94CAGtIuH446umSkDsW9H9trWt5wAbCqlj9uhXG4D
	 uYaeG/pNU23GE4AEY5WLueV4tyt7pdkIEIA6MyWZcIOHUZJcteqzAvMmfciM95smvStIx7OLcWpc
	 eNk8KnNpmPHRo6c2CEtmSiRMgBLZtazBB2hjogd3PWRAzhBrJdEzLOVvJaY0AuciMRkxc5Q6hCh+
	 4SChtu1tXpw5VXGqKxBqCUxWxJv55w1qJFuTrsqasjWtFhW7Yeo7HGnzyt2JirbVk1v76FPVUV9m
	 /lNPJ0+PJlZJqpuu8Qvd77dFceAqi0Pu0We1raKJAOL2E8cFaRwFarZbT/OZTnF+nKlTmLvIs+yW
	 XojuIqRzpZK1wegq8+qa0jwh3Y/PHGj0lcx/jwC0xiL1XUeqJN
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] sysctl: introduce sysctl SYSCTL_U8_MAX and SYSCTL_LONG_S32_MAX
Date: Sun, 25 Feb 2024 12:05:31 +0800
X-OQ-MSGID: <20240225040538.845899-2-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225040538.845899-1-wenyang.linux@foxmail.com>
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

The boundary check of multiple modules uses these static variables (such as
two_five_five, n_65535, ue_int_max, etc), and they are also not changed.
Therefore, add them to the shared sysctl_vals and sysctl_long_vals to avoid
duplication.

Also rearranged sysctl_vals and sysctl_long_vals in numerical order.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/sysctl.h | 15 +++++++++------
 kernel/sysctl.c        |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ee7d33b89e9e..b7a13e4c411c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -45,19 +45,22 @@ struct ctl_dir;
 #define SYSCTL_FOUR			((void *)&sysctl_vals[4])
 #define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
 #define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
-#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
-#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
-#define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
+#define SYSCTL_U8_MAX			((void *)&sysctl_vals[7])
+#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[8])
+#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[9])
+#define SYSCTL_U16_MAX			((void *)&sysctl_vals[10])
+#define SYSCTL_INT_MAX			((void *)&sysctl_vals[11])
+#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[12])
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
-#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
-#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[11])
+#define SYSCTL_MAXOLDUID		SYSCTL_U16_MAX
 
 extern const int sysctl_vals[];
 
 #define SYSCTL_LONG_ZERO	((void *)&sysctl_long_vals[0])
 #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
-#define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
+#define SYSCTL_LONG_S32_MAX	((void *)&sysctl_long_vals[2])
+#define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[3])
 
 extern const unsigned long sysctl_long_vals[];
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..e1e00937cb29 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -82,10 +82,10 @@
 #endif
 
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
+const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, U8_MAX, 1000, 3000, 65535, INT_MAX, -1, };
 EXPORT_SYMBOL(sysctl_vals);
 
-const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
+const unsigned long sysctl_long_vals[] = { 0, 1, S32_MAX, LONG_MAX, };
 EXPORT_SYMBOL_GPL(sysctl_long_vals);
 
 #if defined(CONFIG_SYSCTL)
-- 
2.25.1


