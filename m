Return-Path: <netdev+bounces-250368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70581D29733
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9594A303E402
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0FD30F53E;
	Fri, 16 Jan 2026 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JIxmQowp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD030AD10
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524646; cv=none; b=TLJKKCVdcBxs9S3+dPVSsijaJ6xp+zm6EGlOy3qki+yvwXBxpwm2s9jJo2SfojN+UPFTw+9ptAuVrBPARNO1vKWv7NsldWY/4l04ZyJ/Xt9xOTKTcBXw9UrVWmupSpoSfaxpJLY7f8M/suhC3kmBAZ4B/ZGKQaxjR7pl5OFJ5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524646; c=relaxed/simple;
	bh=f0OIUVxI0PgOWhExbU1FecOBaSLnmmkg1XtjgJTX8yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxyiyCqWfmEBxed4n3Xbw8YxxCRprQNaP9I1cuPnQCkh+jcsV6esIqBfeLTgBlQzzYOs5hlOKTK5YiIAkjyz7rwCebM9VJa5qX53P4ksgSRjpgEiimWL1qwJBsJTmIidnEvCggAuiyg2pXqNfKHwAGEesJpsgdk12lFzJZztnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JIxmQowp; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7cfd48df0afso993461a34.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524644; x=1769129444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdegUEJa3UjiBfkCLkRNHs7XLVuHULtTod8beQSblao=;
        b=JRFsyCGgKI9F+akQcA7QxygvmGAByuORomX8E3h10SMiMtCs3VfAZo1hFX5uMhTFxz
         KX/ywMqfgZe0kbNdRMYdKfd1iWnhP1iWShO7kwyBZXl8j6+ZHs5WZTARznGsNxPJSvwi
         fzp50nNzKdZmbuhAcJKRPhg3dlJO6EJgbazJj276yspkuHV3wYZ3W0UJAgRZLyX0sChw
         subBf1xjJa7wEFyJUTOgK5KsvVzlsCEBMVXnldedUEfBJYqfzztvlEZdK4QFoKdF/UlP
         ie7O6sgpFRF0nIWmbI6R5NUwx2Jf3fwiPxotVsXzzePgjI/WoKdef+jBihG/cWrXJH3M
         lGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX74rZjltgNHEOmmEHEwYZE2VUGtKH2cEMhWGXV+lObKTkzjx40kBZag/oBfCGfAbchjg898CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCWnhqob34B7ScxZ6GVn9nee/+yN2ETZqBt7YQig7Ae65VU3S
	q5BXjidmnuKvNGJBbSDoEVc3u153aD+K22em8ifN7WuTZy+NL3EtCkd3OC7xJravoYlRqACckGP
	GSbrB3mhUlvVqag2TDHzUzXOEKSwRUJh6dRQDu1YXUTESnoHUfRjaR5c0hiphg/dVY5ISj/NZDJ
	qmUDVfEufAj1XO1EVrF4cS8jngZnwkOHL8ZzF7uApbr5fOTLh0kX+x7D9qJLLUV1gXBtqrflTXB
	dQxWtkjvQ==
X-Gm-Gg: AY/fxX5y6Q3yHR4qsB+8gccYpynj8hOgx/tYK024+ccUveP/U07fsl6Bvo2TftZwLYJ
	nrDgOHiyg7rUiOnSXsq6XAwsW20kHuXZ/b9tNuBuIICQV1KaMOor9qZCYm4Aooc2fhVSF8LRLNU
	PkPl62bi+SP2zgcDhnYAHkR9qxWGInn7/1zUX5Gmjcgt/ZWA923aQUQWllgYwmrzgj9jS1lug0m
	mY3jvujgz8cogPglstzWbjcmJP4ENLoMfGA2MX+PBftoIhxw7sc7VF13+4zBBbSjXSJyujwDj0b
	51HellRBFClCR/fUZZtbhbYFEyFBR8eigCvwSVq7GiguFylpPbYL17prWEPxQW9tBeGfehQw0p8
	RPMFMOLM+YWGjgcUqNhiT3/UHfG1Zy9psZtQy2rKA9AVTK+ITVuN97SdNnwek9Le9U2LH3meNvi
	Pq0Osv58wca3tY5/Q7ieLPPIKBAkwVq/sno5bR1gs7jCGJ0A==
X-Received: by 2002:a05:6830:82e4:b0:7cf:db30:bb5f with SMTP id 46e09a7af769-7cfdee80c86mr866380a34.33.1768524643805;
        Thu, 15 Jan 2026 16:50:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cfdf2c89fdsm112806a34.8.2026.01.15.16.50.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 16:50:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ae56205588so2243542eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768524642; x=1769129442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdegUEJa3UjiBfkCLkRNHs7XLVuHULtTod8beQSblao=;
        b=JIxmQowpgj3I/MPSWWd8HudrhO8LVHMvKHiXANL5zEZBSQS4JEO79o9ATcVw7dAkN8
         M7AUlVDnBlTAX5eDfy3Stezos6YmzXF1BpMlrek6Z2NFzE1jRxWVZEEz6oy6xvmQYeLh
         gZEi0gofACiwuDOuV+inL3ZhLhejIMt+i4YoA=
X-Forwarded-Encrypted: i=1; AJvYcCVSFyIfyFYMwY5xcQTZ7TRcsA+YRrTpouctotehg472mQk5eyEXsYZ+TxJrcjnRAJSx7dq7Aj0=@vger.kernel.org
X-Received: by 2002:a05:7022:6085:b0:11a:51a8:ec9 with SMTP id a92af1059eb24-1244a766aefmr1471424c88.29.1768524642507;
        Thu, 15 Jan 2026 16:50:42 -0800 (PST)
X-Received: by 2002:a05:7022:6085:b0:11a:51a8:ec9 with SMTP id a92af1059eb24-1244a766aefmr1471413c88.29.1768524642030;
        Thu, 15 Jan 2026 16:50:42 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm1162305c88.5.2026.01.15.16.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:50:41 -0800 (PST)
From: justin.chen@broadcom.com
To: florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 1/3] net: bcmasp: Fix network filter wake for asp-3.0
Date: Thu, 15 Jan 2026 16:50:35 -0800
Message-Id: <20260116005037.540490-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116005037.540490-1-justin.chen@broadcom.com>
References: <20260116005037.540490-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Justin Chen <justin.chen@broadcom.com>

We need to apply the tx_chan_offset to the netfilter cfg channel or the
output channel will be incorrect for asp-3.0 and newer.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 5 +++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index fd35f4b4dc50..014340f33345 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -156,7 +156,7 @@ static void bcmasp_netfilt_hw_en_wake(struct bcmasp_priv *priv,
 			  ASP_RX_FILTER_NET_OFFSET_L4(32),
 			  ASP_RX_FILTER_NET_OFFSET(nfilt->hw_index + 1));
 
-	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->port + 8) |
+	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->ch) |
 			  ASP_RX_FILTER_NET_CFG_EN |
 			  ASP_RX_FILTER_NET_CFG_L2_EN |
 			  ASP_RX_FILTER_NET_CFG_L3_EN |
@@ -166,7 +166,7 @@ static void bcmasp_netfilt_hw_en_wake(struct bcmasp_priv *priv,
 			  ASP_RX_FILTER_NET_CFG_UMC(nfilt->port),
 			  ASP_RX_FILTER_NET_CFG(nfilt->hw_index));
 
-	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->port + 8) |
+	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->ch) |
 			  ASP_RX_FILTER_NET_CFG_EN |
 			  ASP_RX_FILTER_NET_CFG_L2_EN |
 			  ASP_RX_FILTER_NET_CFG_L3_EN |
@@ -714,6 +714,7 @@ struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
 		nfilter = &priv->net_filters[open_index];
 		nfilter->claimed = true;
 		nfilter->port = intf->port;
+		nfilter->ch = intf->channel + priv->tx_chan_offset;
 		nfilter->hw_index = open_index;
 	}
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 74adfdb50e11..e238507be40a 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -348,6 +348,7 @@ struct bcmasp_net_filter {
 	bool				wake_filter;
 
 	int				port;
+	int				ch;
 	unsigned int			hw_index;
 };
 
-- 
2.34.1


