Return-Path: <netdev+bounces-240727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA0BC78CB7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 026EE4EDAD9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920634AAE9;
	Fri, 21 Nov 2025 11:26:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2732F0C7E
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724399; cv=none; b=HPlpYTnxt5VjcqWx3JqU4809BcJHx190kyGe6oCDXIR/FsHR6tf1ifjfGUrZDxm33pM/c5hcTYRgjPG9XXAffdwOR4Q3lC87nVXvqb6LlsGRieKq/ZgIBuTBbPPdUB8xHsU7BfwIqVKnKXN4qnu+JgllLm3XoI3BjEPLkQhTUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724399; c=relaxed/simple;
	bh=Up/1xSeBkB0p2W4yVcqFz2y90IusIdqbhG7Z3DkQyOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3qRvcbASLQpwsp+Bdito7Aw1f8IuU+tjed3+C3Eje5KvyHu9U6zQ19hETdO7cRHz1/g4Y1y8BT61ValfbYqlIw5redrKnGg+LnID0I32xjOUclpliYnhGX+uhQcoGZGS2jJj4B3C9cZEqmMlbkC/WoOeFLVOtMD6uR/m6XWsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45085a4ab72so830614b6e.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724397; x=1764329197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HeQ3fv25z6pOuPgCHIWGZAjgHMbUF84qDxUXEpKs5xA=;
        b=ZJm5BnLpp4nSHv4wC2zlAKufs9A5idnuMGj4H5z/lHGPyyJLqbFY4kQkbZ6bhv1s8X
         u30e7/ploVanQwnUFDsxzG0unPvGUZ02vyoarWw/vLOcMujqXwA5MJ9GH/HI8UjuGIUP
         TI4zjUVg0wUyqC5nx0KsQ4SUM3wZ7eJ5XWMQ9VXDFKyOkQu/FAWU9KdCROs1SuaDFbt3
         3qoFYsmPZnYZsR1jfIYd4I2ANVI1yL3/Y6jrZDUCIPWmr74hjIQ2Ji7PHPBWBUK6xDCs
         M3axi38Qf9phTuG5p8S+D/7zHrk2szTVxXB6yhO8xzQQBpufQcxAPjIMLIGPfPTSvRCm
         +MLg==
X-Forwarded-Encrypted: i=1; AJvYcCUM+jMv9W0Y29zQehrdlSgFTUTAEYYDR+V4PitOkiuq1qBJiK+HUbiBIGcba4Ka14s7n7y8x0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQeBYi7GrjPHdYXw0+ygXh2YkDRyPqxLJerkAjc4wS+Vvoh+Br
	pm2sqxLSwJ13f0WzE+Gn6Tow8EdO78WzQg06p3jEryGR66FzDPK3rGgS
X-Gm-Gg: ASbGnctznIw2EQKigqTONoaasGNKF3lZBqIkvLZZ37koTRi4F4C1y8jayh7iXEjGfBB
	wtEvPHijVJehY7k1p632LA4rlMByNt6Dg2L9x6Im/v9eE1+avPNuL3ZKIT24aIgy58SNdiEooVG
	mOzvKTIt0LNcgRz9p/oSdbtiQp6y02ZAivbU8ZMEP3Y2GH2HoAK2BbP4lyDpnE/SyWVHmDnF1UO
	hiX9YyUC0qC7fDIaofPbTtC83K5/naebmr9t4f/MEMshNByh8J7FBqj43KgNl/R1f94kxQdG87r
	KgogQJ9ua1pWv2bwYaSzaLBeDpL20g3/HEPzDFY38BqF8bE+lRBBJjtUMQXanwM6K0PCoR9ih27
	IM3X3+oYrcGycILQ/OnNTjcO4m6gFc3+M2dD7RDTOUzoS1epMNQaaoamATbQz7yi8bwYVq0WNcp
	AP9e/k5mJcLaAGHw==
X-Google-Smtp-Source: AGHT+IFJloyur0rQ9obs1zwpoSsUNIFlCUAqnRwKRBTiMrW8I69Xl0Dp8rUnZV0AbBobB8c+GozWew==
X-Received: by 2002:a05:6808:4fe5:b0:44f:6d6d:4a04 with SMTP id 5614622812f47-45112cf9e04mr777367b6e.58.1763724396661;
        Fri, 21 Nov 2025 03:26:36 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a38456sm1567810eaf.3.2025.11.21.03.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:26:36 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Nov 2025 03:26:08 -0800
Subject: [PATCH RFC net-next 2/2] netconsole: add CONFIG_NETCONSOLE_NBCON
 for nbcon support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-nbcon-v1-2-503d17b2b4af@debian.org>
References: <20251121-nbcon-v1-0-503d17b2b4af@debian.org>
In-Reply-To: <20251121-nbcon-v1-0-503d17b2b4af@debian.org>
To: Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, 
 horms@kernel.org, efault@gmx.de, john.ogness@linutronix.de, 
 pmladek@suse.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, calvin@wbinvd.org, asml.silence@gmail.com, 
 kernel-team@meta.com, gustavold@gmail.com, asantostc@gmail.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4833; i=leitao@debian.org;
 h=from:subject:message-id; bh=Up/1xSeBkB0p2W4yVcqFz2y90IusIdqbhG7Z3DkQyOM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpIExoZ2WNk6LTQhAcz9lZEqVAXeRsGFwqZGYaR
 1CcayasFTKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSBMaAAKCRA1o5Of/Hh3
 bd+ZEACGDuzNg3IOH6RiePIP06/7OidbUKYcoTtMZY/n08GFE/EFxsXgvX3iJ1/5PJwz3gpLoi2
 2xs0hlsJZLeBnU92MkeJJK2GcJ2XV/GzXewvnyKS048jlA9Z/FjfGL3IzR8IGeXnpJcmEPDkkyD
 lKZcUwc7niTGDkuwDMOHDhnH2L2NwOadwvENYdMOPtrblpYYmTYppty+7COcvPotD0Hw/uwBq65
 ibcRriGq2CNxinDXa3nRbvm8BPBAsFrMggnBhhLCAceg9i+RqPCpihIzat4eBjgPxR58rqexrAt
 9F7tpL0yrU2NTMtdSHK1nuJ51soZUMV81QFhbsVxZ5cxOWko89JsAHDwzRiv6b0F9UnljiMqcfx
 elqhJRxJofnCS8ciStv34kwFFb9aiQBITUBeTz/vXZq4IHv7A/nPnCNCTLlHyCnZ0ZMQ56M2PlG
 kioZXGkLLTrKAdeN2LZKzBJfCMMxgEMb6g/mmOui7T0kP5m70eqYlexNz/JvVW7QDLD9x8Au8yy
 GEh0TZyUUDXS5jB9V/Un6VrOAwqPEIHHNwt8YF3Us6V1Cv0Z4s4ck4ZiGJbAqZtUeVz023BbNQY
 /kGuSCsVSjRG8owd/mhTH0GFMtBidGXTfNL/JGZ8HXDlbNnbDUaup4vBSCrXOdgp7p0ddSX+CS8
 sbihCqt0r79hccQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add optional support for the nbcon infrastructure to netconsole via a new
CONFIG_NETCONSOLE_NBCON compile-time option.

The nbcon infrastructure provides a lock-free, priority-based console
system that supports atomic printing from any context including NMI,
with safe handover mechanisms between different priority levels. This
makes it particularly suitable for crash-safe kernel logging.

When disabled (default), netconsole uses the legacy console callbacks,
maintaining full backward compatibility.

PS: .write_atomic and .write_thread uses the same callback, given that
there is no safe .write_atomic, so .write_atomic is called as the last
resource. This is what CON_NBCON_ATOMIC_UNSAFE is telling nbcon.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/Kconfig      | 14 ++++++++++
 drivers/net/netconsole.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ac12eaf11755..aa8771b5b723 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -369,6 +369,20 @@ config NETCONSOLE_PREPEND_RELEASE
 	  message.  See <file:Documentation/networking/netconsole.rst> for
 	  details.
 
+config NETCONSOLE_NBCON
+	bool "Use nbcon infrastructure (EXPERIMENTAL)"
+	depends on NETCONSOLE
+	default n
+	help
+	  Enable nbcon support for netconsole. This uses the new lock-free
+	  console infrastructure which supports threaded and atomic printing.
+	  Given that netconsole does not support atomic operations, the current
+	  implementation focuses on threaded callbacks, unless the host is
+	  crashing, then it uses an unsafe atomic callbacks. This feature is
+	  available for both extended and non-extended consoles.
+
+	  If unsure, say N to use the legacy console infrastructure.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f4b1706fb081..2943f00b83f6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1724,6 +1724,57 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 				   extradata_len);
 }
 
+#ifdef CONFIG_NETCONSOLE_NBCON
+static void netcon_write_nbcon(struct console *con,
+			       struct nbcon_write_context *wctxt,
+			       bool extended)
+{
+	struct netconsole_target *nt;
+
+	lockdep_assert_held(&target_list_lock);
+
+	list_for_each_entry(nt, &target_list, list) {
+		if (nt->extended != extended || !nt->enabled ||
+		    !netif_running(nt->np.dev))
+			continue;
+
+		if (!nbcon_enter_unsafe(wctxt))
+			continue;
+
+		if (extended)
+			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+		else
+			write_msg_target(nt, wctxt->outbuf, wctxt->len);
+
+		nbcon_exit_unsafe(wctxt);
+	}
+}
+
+static void netcon_write_nbcon_ext(struct console *con,
+				   struct nbcon_write_context *wctxt)
+{
+	netcon_write_nbcon(con, wctxt, true);
+}
+
+static void netcon_write_nbcon_basic(struct console *con,
+				     struct nbcon_write_context *wctxt)
+{
+	netcon_write_nbcon(con, wctxt, false);
+}
+
+static void netconsole_device_lock(struct console *con, unsigned long *flags)
+{
+	/* protects all the targets at the same time */
+	spin_lock_irqsave(&target_list_lock, *flags);
+}
+
+static void netconsole_device_unlock(struct console *con, unsigned long flags)
+{
+	spin_unlock_irqrestore(&target_list_lock, flags);
+}
+
+#else
+
 static void write_ext_msg(struct console *con, const char *msg,
 			  unsigned int len)
 {
@@ -1765,6 +1816,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
+#endif
 
 static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 {
@@ -1923,14 +1975,30 @@ static void free_param_target(struct netconsole_target *nt)
 
 static struct console netconsole_ext = {
 	.name	= "netcon_ext",
+#ifdef CONFIG_NETCONSOLE_NBCON
+	.flags = CON_ENABLED | CON_EXTENDED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netcon_write_nbcon_ext,
+	.write_atomic = netcon_write_nbcon_ext,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
+#else
 	.flags	= CON_ENABLED | CON_EXTENDED,
 	.write	= write_ext_msg,
+#endif
 };
 
 static struct console netconsole = {
 	.name	= "netcon",
+#ifdef CONFIG_NETCONSOLE_NBCON
+	.flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netcon_write_nbcon_basic,
+	.write_atomic = netcon_write_nbcon_basic,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
+#else
 	.flags	= CON_ENABLED,
 	.write	= write_msg,
+#endif
 };
 
 static int __init init_netconsole(void)

-- 
2.47.3


