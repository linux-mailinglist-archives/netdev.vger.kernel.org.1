Return-Path: <netdev+bounces-225612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E627B96141
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536B219C4429
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2BF14A0BC;
	Tue, 23 Sep 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHxbRLjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0171A4F12
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635296; cv=none; b=TpOeuJSuIvKo8BmZVVvgWY2Wfl+9pM+gbWzwaxNTxczJRlH6NWN3LrlIhfuYqp/Qn/odamRBQ+8aXH87El7jJ0ZS3gWn8ow7HuQ5B6rGAJe+gsi5SHlZPQPHHoBXt6tJg/29MB2LSRiTacPih/Hcc/pEsjBnYjfXjpZtGc/oNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635296; c=relaxed/simple;
	bh=I0JMVMkxbiDYQyEkwL9i4HgJzjy9iFcQ8Je4BhdWpi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1jtGg1JPiLH7+VczEYei256flZEm9FW+TvA2p26EY34PzE/1fD0NBbv5k9WUcxqhFWVL7PSfHrzBEyfWSTH/h2pk4Lf8A6/HmZZaJkSSsDQ1V8FzYrYv9uoDInzKLh3hJ8HoHtHsHUVZ/ztbaskDCM1F+9DT4QQgtCuzmxcZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHxbRLjS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46d40c338b8so16661895e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635291; x=1759240091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYrEAYGhHvjaVQ7/HWTUrwRP3myHModbarlQ+DQ3Xg8=;
        b=NHxbRLjS3u1V8AtEHbkzEvFPfMr1tRjDVqpwqjp2OhMBwv4LC7uCcwrC++GDq57ogJ
         sRVXvOLwwX1+GoKfWbBrfKW/E3nmdCoCXIIpNX+3BFgJwKr5Jq7NG/3wO5Ro0JWWheDK
         yYUvSWr5P/87tKllkIz2pm6BkfYUMnApNUU+YyoPWlGv5zDiQgtLg/Zk/QykRaSducGB
         SkQMvmS+y04vlMXCMga8c1GzZhkRfzIBlbOkpRd4PAXAWVYDLjlUzpo3Oz1u8z/ppoOR
         dvANjSPNE7ME1bTANdy4Sv2cWwhxVlI6aEkGxW+keTIUC7CoIPgcnC8cHQUV2yDYB/Ic
         V5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635291; x=1759240091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYrEAYGhHvjaVQ7/HWTUrwRP3myHModbarlQ+DQ3Xg8=;
        b=C+wF9ogbGAF90rveZLUhkt4ohVp8VVMi/0zjweTx9AyJO1dmjQBocEE8mperkD5OK9
         Oyk52jm9t1u9T3KG81F1yA7IbCJrKZ+ISFu/xCV7UzN0h2cRNcsN1bFrZ3Tq2CSO83uy
         5k8Z7xNL5u/yBP9xWIHS/2Xnatc0gFHSMd2cpoZ7KKeTXVoiKK6G7HHQxNMqKZCSLtcl
         qaVjVyFL2qIMDlU53tbG5Ay9GuFaF7PB0Lu8gqT4wmhjZ+lyp+lcdWlK1Kru24joy8q5
         EgfPJ5Tc7nZ3AhXsHroNu8PgjJIJWOlxnLt0Vsncnc2RrzXtgj7Q67AdWh4bYbB5TaC1
         aKDA==
X-Gm-Message-State: AOJu0YyQHKL3gpv9nMMwpIdLR473xYEkZYkYB+2FI/BsrnQ3KXlno9dt
	DJQoh4REfqZVlIPM2QhI+ZcCnsRDBxSeiiRDQiWqRGEEF272tQmvQSOD
X-Gm-Gg: ASbGnctExGZzbMyDzLQQqsbQsiJPAzlI8C99R6mLSJ1SbAoAY5q+RrygVTb+Z/em9X4
	D9SYG2E6OQpj3pZTVw8yCbGvKuuk3LkpjNzPqr9oy7JPUAFTKIPr4dTPpvg/yI+qTZS1TEOHJ7/
	4X4n7lLgsnjpJLvyZUsHk+cqtHObcVzKOKTBxeX/ZVV1TLXYIKoAZi20kry73Crw+aQI8/N1pl5
	tmaBFsSdtJKDYD1qcEsPUIFCD6dxxjiFZUg2FgLU6b6FKxZFl5tl/58RZzZfz4fIqeLpqG5dhlH
	yeeKKJz/BCI7OI4hw/NULEBQ32SxhtTgdTgmQjDWU4/SPx/2WkUUKd2XJKr3amWAoj9Xp2tNnqK
	PjXXW+6abCEYZF8Re/VuwnILFeDAHQdKejZfJSEhlRSK1B35REJMzX0aynDA=
X-Google-Smtp-Source: AGHT+IFRMXpoozL13jL9PbE/34adZ6Mf2QbCNOVpGhZ4+6sUw5B5RIEzoAzh3gMJBBVLoPSgCCRSrg==
X-Received: by 2002:a05:600c:4693:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-46e1daca953mr29647425e9.30.1758635290962;
        Tue, 23 Sep 2025 06:48:10 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e1bc00695sm44964045e9.4.2025.09.23.06.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:10 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 09/17] gve: Remove jumbo_remove step from TX path
Date: Tue, 23 Sep 2025 16:47:34 +0300
Message-ID: <20250923134742.1399800-10-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the gve TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 6f1d515673d2..984a918433f1 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -963,9 +963,6 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 	int num_buffer_descs;
 	int total_num_descs;
 
-	if (skb_is_gso(skb) && unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto drop;
-
 	if (tx->dqo.qpl) {
 		/* We do not need to verify the number of buffers used per
 		 * packet or per segment in case of TSO as with 2K size buffers
-- 
2.50.1


