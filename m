Return-Path: <netdev+bounces-253145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDEvKunVdWn0IwEAu9opvQ
	(envelope-from <netdev+bounces-253145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:35:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E14F88006A
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56AA03001FB1
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4B3176EE;
	Sun, 25 Jan 2026 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuQuDQh5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCC27B32B
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769330148; cv=none; b=Jeg5X/9dstSj+iaoQuFHwX4a2Y/CxuLrHQsdwEqlRgMTOMQe0CDs331q2L3ONcdY7Sxe/V5JFsthfLXM50hTTWzZq5LYRagYMmZb0j1oeWz6oD4AN0eeudYYcf3ekXCrSkNRsWczWPQZH0+cnXQCEjFsyDBezC7VON/YSYngfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769330148; c=relaxed/simple;
	bh=Dmm1TRrBtpj/3umYgMC5hu0FZAAmIQxX4Eo+n50BuMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dbnr9AiqnxORFrcVnvS41uqydjicXEg+MdmIAIgqLI+gUXtzpqYYHf/2ualXf0nMCBsLowrFYDQFZ/Nh7x+uzOs1uzf2RegY5847pK+h3EYzAxULLf6zJj5339VkNU5DfzTFduZ2uev7qCTVc/GDk8ZULZwz7O33gA4DinHV6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuQuDQh5; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b7070acfdcso4010331eec.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769330147; x=1769934947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Nn9yi5frFUwKKyJLlUjP9/sqJsKgrFiePLpLSnfMfw=;
        b=VuQuDQh5XItkZkBTO0ywduNOB6iaEzdIrhN7FNe7JjzeASmwvVQaq/acgsF3nF/zCo
         wxxNZAzbhq236VWH2842mwzXhqLgK+7hCf5Xkj5lg2xna4O00/JHS4TI6i+3epBVw8ox
         tHAAXay53PxotuI+AZll3LwkFjglRKmAmuN5P+f+FpAxsNBR+9PN0X+mZmhdVIkrLwdx
         QSaZslykCl1/4TVoYmRojc6d2jXPPHHCBpWofNc+6dYLTYSfBXdBfGnKyAPOSlRYK3wa
         MJGDzpddlpUmK2i3ytUuqLxyeFm1Z9+uEYWN9FnFFpetFBb+HlQy+9e32CbuO626VAMG
         5yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769330147; x=1769934947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Nn9yi5frFUwKKyJLlUjP9/sqJsKgrFiePLpLSnfMfw=;
        b=xRG2xL/+u0VhHuSgWKLT0K0KUuWOdJ8WwrqaJsTfhsncjbwox0RU8myFl5JYfNqxme
         hLlwxuRSlctLfG9rnEU4yLvJsjxjKS1vMX0AZ03wulzphLYwPmzf1DOXUYR8d0xjg9Kd
         CPK3LJZFcIMblHfepzH6k0erTY3tdJjNdIKyPaQSXyS7iK5NEhygUDauFMds7K7PkJnI
         qSZAep6w/VgOVG2DIFfSSABhMkvCp+uPG+ZdGk8XPUP46R5DLQcK676NV4MbNpKA8N+W
         Ao/y5/+hpv9T13EgNR3Q5+u2i/GN25MXB9EH+KJJDiHQFSQu+fLKB47Temv3MmQmMpkm
         PBhw==
X-Gm-Message-State: AOJu0YwZr7fys7iNo++FYKbci6UTdwLiCJpBbtJ+ck0kUOynxr/TmZp8
	bTgeSgy4qwH2xEdFJjzpbefvKUozRVvJ3IoJgbnApDniLvPU3fAILFaMe+LnTUEn
X-Gm-Gg: AZuq6aISm0sTXaAfx4tyJgVU/JA+clZOI770YQ2HVEsrkrMNRKUo1eZGPhtLlbywiLn
	4vWnhzSvzU5L/gb/UwlHYlAZV7J28k/oglqKG6NfkKxTAr76vuE3PPo6qS0dD1ImPhIQJAAVzvk
	ybyaMlJ1/I99o3pWwuQqSNzPrfxO+DbOefsuswR7n2OrDEhJwBI64MLivkm35LVpoTMIxeKUtOi
	OEo0m1UmDvuCsr9soJZ5RAwUKdB0M7JggQCdVKMVv1kWMKMDRlXDHuQ58h6xGoJolrq87wzilYc
	o/C4MOkNfqlJkdiuuCOE8Ps/2YcF8WJXFfC/DwdHbjDdtAZvBC+Wgp7VHwEfdsqvNI3OPbVhvy6
	GXZ0g4ebOht5J16iNj/Y/m7BUwfnWMKt8KJMKCT1XY4PJd66U3tJgz3sFNWVOOSz2MRTXPGVdZW
	zZH1XZYxI+PW73QDQBBWMY17SfKgms+uiPzlnQ1PdNskC/sS6+2P/NYlYXzFeFJL6vb3T5XxTb9
	HGQ9w57yzAtIxPXoT3qsIJlX/rgCzj8GSm04Xb+Or+BInvYXKuNTLvcUfE+opu0MCX58iNgTh7J
	OkHC
X-Received: by 2002:a05:7022:4385:b0:11a:2e9c:1130 with SMTP id a92af1059eb24-1248ebd10d4mr576281c88.7.1769330146742;
        Sun, 25 Jan 2026 00:35:46 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7410615c0sm7994977eec.0.2026.01.25.00.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 00:35:46 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] net: usb: kaweth: remove eth_addr_t typedef and bcast_addr definition
Date: Sun, 25 Jan 2026 00:34:57 -0800
Message-ID: <20260125083501.34513-4-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125083501.34513-1-enelsonmoore@gmail.com>
References: <20260125083501.34513-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253145-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E14F88006A
X-Rspamd-Action: no action

It violates kernel code style guidelines to define typedefs for
non-opaque types. Update kaweth to conform to these guidelines by
expanding the eth_addr_t typedef. Also replace the hardcoded MAC address
length of 6 bytes with ETH_ALEN, and use standard kernel APIs to assign
and compare against the broadcast address.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/kaweth.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/kaweth.c b/drivers/net/usb/kaweth.c
index c9efb7df892e..f3fe76e46490 100644
--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -164,8 +164,6 @@ static struct usb_driver kaweth_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-typedef __u8 eth_addr_t[6];
-
 /****************************************************************
  *     usb_eth_dev
  ****************************************************************/
@@ -185,7 +183,7 @@ struct kaweth_ethernet_configuration
 	__u8 size;
 	__u8 reserved1;
 	__u8 reserved2;
-	eth_addr_t hw_addr;
+	u8 hw_addr[ETH_ALEN];
 	__u32 statistics_mask;
 	__le16 segment_size;
 	__u16 max_multicast_filters;
@@ -882,7 +880,6 @@ static int kaweth_probe(
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct kaweth_device *kaweth;
 	struct net_device *netdev;
-	const eth_addr_t bcast_addr = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 	int result = 0;
 	int rv = -EIO;
 
@@ -991,9 +988,7 @@ static int kaweth_probe(
 	dev_info(dev, "MTU: %d\n", le16_to_cpu(kaweth->configuration.segment_size));
 	dev_info(dev, "Read MAC address %pM\n", kaweth->configuration.hw_addr);
 
-	if(!memcmp(&kaweth->configuration.hw_addr,
-                   &bcast_addr,
-		   sizeof(bcast_addr))) {
+	if (is_broadcast_ether_addr((const u8 *)&kaweth->configuration.hw_addr)) {
 		dev_err(dev, "Firmware not functioning properly, no net device created\n");
 		goto err_free_netdev;
 	}
@@ -1043,7 +1038,7 @@ static int kaweth_probe(
 	if (!kaweth->rx_buf)
 		goto err_all_but_rxbuf;
 
-	memcpy(netdev->broadcast, &bcast_addr, sizeof(bcast_addr));
+	eth_broadcast_addr(netdev->broadcast);
 	eth_hw_addr_set(netdev, (u8 *)&kaweth->configuration.hw_addr);
 
 	netdev->netdev_ops = &kaweth_netdev_ops;
-- 
2.43.0


