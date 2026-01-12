Return-Path: <netdev+bounces-248937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AEDD11915
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561D630DCFA3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334034B66F;
	Mon, 12 Jan 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSDeJSk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBF34AAED
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210876; cv=none; b=WwoTPJf8FqDxvp3spq6R0ENjKtYTaceTfqj1j0QdZVdTDJZWmyxbxdQ3Bi+5ZY5XLLzW/33Z79kbxbhMPfVC57T7tF/RmnqqpcwaIqCBqEOdZZ8ew/GIT0SuGRurkWlj3F2y/v4JkzVFvXajWjhIwqqx3OH/eqtpxa7RTOLITKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210876; c=relaxed/simple;
	bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vr+vDOOgWe02gbxA0buXCEPBu2xVF0nkQMoWUuw8Xs0w33u4hrkmWqQV8cagSV6bLP5xOaFLzzKxl5XdW4BA4vuwrzvDKrO+XD/adHKqBX56S0VRaJmBNpintw+atN/32rZZ0ewyo7mAvA+ugdphE9lh29MRwkAfhduchOtYek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSDeJSk6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso12499596a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 01:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210870; x=1768815670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=fSDeJSk6UbcouQREN8szTwgwXT7/oN3dbamr9B5x8ykQKVu+JN3o9WqPalWaHCNSO3
         WddeZlN7uUdMHNvnNuvzU/49Iju7ZI6eG/2Pub3oxNmwh43GDr4P+n7HnHToNeVU9NQW
         vX4Ur4okH0gswRREWihDMbGR8wdnrOv0yh9oEk7TQF6k6sCEQiSVYK7+6Z8MMZzlxIeb
         dhnYiBbtKLqSNGNNhDfA1JOwywJpe7/IXzmK8xPvsZxsSSkxnoULitSeT1SmTkexzP3g
         Vm0V1NfhL+SNjMWBa3vvX1Ekk4Ih7/lApfgWODl8/kVZ+ZG34oHCrLR1l9uarqBsXise
         6oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210870; x=1768815670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=TtWkHG130sJ6Iv2bHC/WxCujuVa6+1ohJS05aSjgRk3h2sZGa0SWODsTx7mbD5FBDr
         cN+ehjR0Fer5mxZ1+kboQr2ILJ1IhDkaTh80TIOSeSxCjskj9SayA7nqfjjASOiPmagK
         xE3oRBuJCLfVC9C69npkqewVuZh0u4JO84/vA7YyQQGxEZv81xz5njJETUBtZAxF13u/
         i0Ji70ybNmgxHmeOaFXw7dVEFkaf2uPZfz2PNtyO4mbIWsr00mNMsDfCYKGpOnXBVGzF
         erVXcT7wTv9/P47ZcTbfuUNTbzZvzN4dwjzpIADfPE100xcJBSNsIqpx7K+Ss92LowG0
         5l8Q==
X-Gm-Message-State: AOJu0Yy6u48TYpvpr5T5rhbXzRQLhliL27vOxvqcQeKJxEgytUw6E2Tk
	D1/PTeaiM2pZeV6tUQE3AegkpXsFrCnVYoyfbORCF8L56mtrk9ryVUn/
X-Gm-Gg: AY/fxX6CZNmJs0VB8R3INHNQLlEv7BnyrA0o2EeyZSCucryvddUVpdkvUkKaU3IKLN0
	WJYreGiIAuCnkXRo0wBxqh7V6XxhAcviW97MTnuqpg8IPZRyYNvpQCG60CcI2wrBWx0/Nn5ydht
	BAFYqTkXp4Rcmzf2KUTFexR0LMqdIRzf71BAiWcIF7pPouvWCNcpZfkWCZ70bNFH2yvbI/R/PEY
	ftb/wDMTzIaEC5402QwVLlmGT+KpCrrtQfzazqoVH7yCgjEslFxaKggDlM+oulYyUJmgSHYHTYE
	nieN7kJe7IUn5aFZ9IeZf9XoClX9RXGVojkToMB2Q/z6WlQ4r9l7MizClxCETeXtBrsYLUpwGqP
	B1IY5gWVVRGfpzmAu6TG9c6gudflII10o5DpFxRTjoRamusbjgRvQJxTncuWo/3udf4nlWIUVme
	rOxuXNHHcpWCsVhw==
X-Google-Smtp-Source: AGHT+IFgXG9FtTcTI9askJdKeBxyq33PRdfuWUfeE7I+aLtTeSoRzhvi45RlIzresGDM0bGDZBuCdw==
X-Received: by 2002:a17:907:96aa:b0:b87:2f29:2075 with SMTP id a640c23a62f3a-b872f293a8fmr29106166b.28.1768210869514;
        Mon, 12 Jan 2026 01:41:09 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:08 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:55 +0000
Subject: [PATCH net-next v10 4/7] netconsole: clear dev_name for devices
 bound by mac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-4-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=1518;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
 b=mJMvftO9vWbVYBySQMvlOwCMj5f4rBUZtkx2lrLq584MFm+ltB+706sfwMCzDJQBx7wk+Xlci
 w5HTBqvAje/B7OnUjjgU7ShiKQmeex/RTuKoFvg47OT8MDh8V3xwf3q
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch makes sure netconsole clears dev_name for devices bound by mac
in order to allow calling setup_netpoll on targets that have previously
been cleaned up (in order to support resuming deactivated targets).

This is required as netpoll_setup populates dev_name even when devices are
matched via mac address. The cleanup is done inside netconsole as bound
by mac is a netconsole concept.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a1e5559fc0d..02a3463e8d24 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -242,6 +242,12 @@ static void populate_configfs_item(struct netconsole_target *nt,
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -284,6 +290,8 @@ static void netconsole_process_cleanups_core(void)
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
+		if (bound_by_mac(nt))
+			memset(&nt->np.dev_name, 0, IFNAMSIZ);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
 		 */

-- 
2.52.0


