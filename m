Return-Path: <netdev+bounces-134918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1A999B8EB
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 11:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F611F2185E
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 09:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B4288B5;
	Sun, 13 Oct 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsqmFkix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC45231CAE
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728811063; cv=none; b=cEk9a8+bu0spdAbyjFqDbG+/0RJ4BEWKQO52kQ4/SXaRi5lKqbUp5e6zjRlSyJIkpjX4+q+6cN+HApI24mqPpje5fZMkK9bjFHhj6iq0Y/BEjB77yO2Wu1geeg8R6WmecezvJsYxsl9PqMM6Prh3Ll/bzf3uuN9CpySSW0ot/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728811063; c=relaxed/simple;
	bh=jA999EtYcc46c5AVRSFuNpTW/swUY9sQa/A6PyRF8Kk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JtCqZaT5JWBqTIGZo/bmUEmC3lafRhB2MKEBMdcE2K2qaz88e/blYj+cUXym7sShC3Tcl++C4B4QS1/k9/9rYd3wNhm21xZ+fhz7odXRE+C9ktt6Z4HgQWVo77QgAlFoYvcsy9Mq/H76xGQ0S3hwxNRJyNtUEYlNqcx3JM/Flgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsqmFkix; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c94b0b466cso2362705a12.0
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728811060; x=1729415860; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWRZd+ObWk5LIlgE1sIM7Jp9NK41l65XCqKRDlS3dDE=;
        b=nsqmFkixMju/1i3PcarQvAqh3Y6RGS9CJIQLdM/N9EJWSjFJ6LAWi2OmhqcC52mJyN
         KiltQQ9RcIgqbodvDLnvBhU+YROE0+mjscp8daKq6pHbaTW7BaWi+EWxqJ0wtH15uy+f
         forFeZ+irJsCooaNmKBwFtZNMUtBWWu96a3dG7pSe9md6pJl3lz8FAFWHVACI/lASWVN
         VZt/A/FTuTeLaBXwPZ8TEV3yV7CEnvxbJoDIWMtgiJaCcKAOzA58tUi1z0nwOxJQZV5b
         43YJgHOhScVKm5PIMcxU3mUSkXAIBdr0sOFlQbFkN0SK9pw/U6bYsvW57my3MyLIRLpp
         y+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728811060; x=1729415860;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWRZd+ObWk5LIlgE1sIM7Jp9NK41l65XCqKRDlS3dDE=;
        b=Viek5gBimDJdHN00pYQfRlvCw38fZ8lGboqF21kuqJ4wH7y88zkzL9vfOOU8JNtnvH
         lt789OfU3G9W3+ZaSm/+HoydRYLzzr08Bco73H4uG7+8KWrMSfwG0n8dh06x+QhnCbt1
         iv53Voz9pHRixFGsjHiLRT10QpVA0iypzgAEQouUbPRQ4NB5U6iiBsaBhRcCd6Vv6odS
         90sJW4u6xusaiBdxET1DKCdBrzEJDAbBCWSKY62/yEMpByrMFW3O74y2Ph2CWIzDSj2Z
         yhm5b79Jl1oIL+Q9xM6VK6H5s+SaRlXCLVbZDW0bSn+1TgCqWotgT4sHQkzQ0j/57K6p
         5A5A==
X-Gm-Message-State: AOJu0YxMQV3974opGWXBLf9aAULt0LbyHlWdqgZM1zkFlnnrf8Sl1leO
	u7MPHLRHyqPdvhybdaWwhowv85H9lViIyKzDTNcmMgqMCQKxIlH/
X-Google-Smtp-Source: AGHT+IEJEYrOQd2LntAKP9ooI/KLPhlpyiAD/4g4XNTbgT2tXxGyqB63CdK2y6+tuS4uqeaaRYjTbw==
X-Received: by 2002:a17:906:6a07:b0:a99:f9d6:5590 with SMTP id a640c23a62f3a-a99f9d659f2mr239620466b.60.1728811060105;
        Sun, 13 Oct 2024 02:17:40 -0700 (PDT)
Received: from ?IPV6:2a02:3100:aefe:d400:a889:69f8:ae21:ed4d? (dynamic-2a02-3100-aefe-d400-a889-69f8-ae21-ed4d.310.pool.telefonica.de. [2a02:3100:aefe:d400:a889:69f8:ae21:ed4d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99ee8da1besm164960466b.216.2024.10.13.02.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 02:17:38 -0700 (PDT)
Message-ID: <58e0da73-a7dd-4be3-82ae-d5b3f9069bde@gmail.com>
Date: Sun, 13 Oct 2024 11:17:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: implement additional ethtool stats ops
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds support for ethtool standard statistics, and makes use of the
extended hardware statistics being available from RTl8125.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 82 +++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index dcd176a77..558921e32 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2161,6 +2161,19 @@ static void rtl8169_get_ringparam(struct net_device *dev,
 	data->tx_pending = NUM_TX_DESC;
 }
 
+static void rtl8169_get_pause_stats(struct net_device *dev,
+				    struct ethtool_pause_stats *pause_stats)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (!rtl_is_8125(tp))
+		return;
+
+	rtl8169_update_counters(tp);
+	pause_stats->tx_pause_frames = le32_to_cpu(tp->counters->tx_pause_on);
+	pause_stats->rx_pause_frames = le32_to_cpu(tp->counters->rx_pause_on);
+}
+
 static void rtl8169_get_pauseparam(struct net_device *dev,
 				   struct ethtool_pauseparam *data)
 {
@@ -2187,6 +2200,69 @@ static int rtl8169_set_pauseparam(struct net_device *dev,
 	return 0;
 }
 
+static void rtl8169_get_eth_mac_stats(struct net_device *dev,
+				      struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	rtl8169_update_counters(tp);
+
+	mac_stats->FramesTransmittedOK =
+		le64_to_cpu(tp->counters->tx_packets);
+	mac_stats->SingleCollisionFrames =
+		le32_to_cpu(tp->counters->tx_one_collision);
+	mac_stats->MultipleCollisionFrames =
+		le32_to_cpu(tp->counters->tx_multi_collision);
+	mac_stats->FramesReceivedOK =
+		le64_to_cpu(tp->counters->rx_packets);
+	mac_stats->AlignmentErrors =
+		le16_to_cpu(tp->counters->align_errors);
+	mac_stats->FramesLostDueToIntMACXmitError =
+		le64_to_cpu(tp->counters->tx_errors);
+	mac_stats->BroadcastFramesReceivedOK =
+		le64_to_cpu(tp->counters->rx_broadcast);
+	mac_stats->MulticastFramesReceivedOK =
+		le32_to_cpu(tp->counters->rx_multicast);
+
+	if (!rtl_is_8125(tp))
+		return;
+
+	mac_stats->AlignmentErrors =
+		le32_to_cpu(tp->counters->align_errors32);
+	mac_stats->OctetsTransmittedOK =
+		le64_to_cpu(tp->counters->tx_octets);
+	mac_stats->LateCollisions =
+		le32_to_cpu(tp->counters->tx_late_collision);
+	mac_stats->FramesAbortedDueToXSColls =
+		le32_to_cpu(tp->counters->tx_aborted32);
+	mac_stats->OctetsReceivedOK =
+		le64_to_cpu(tp->counters->rx_octets);
+	mac_stats->FramesLostDueToIntMACRcvError =
+		le32_to_cpu(tp->counters->rx_mac_error);
+	mac_stats->MulticastFramesXmittedOK =
+		le64_to_cpu(tp->counters->tx_multicast64);
+	mac_stats->BroadcastFramesXmittedOK =
+		le64_to_cpu(tp->counters->tx_broadcast64);
+	mac_stats->MulticastFramesReceivedOK =
+		le64_to_cpu(tp->counters->rx_multicast64);
+	 mac_stats->FrameTooLongErrors =
+		le32_to_cpu(tp->counters->rx_frame_too_long);
+}
+
+static void rtl8169_get_eth_ctrl_stats(struct net_device *dev,
+				       struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (!rtl_is_8125(tp))
+		return;
+
+	rtl8169_update_counters(tp);
+
+	ctrl_stats->UnsupportedOpcodesReceived =
+		le32_to_cpu(tp->counters->rx_unknown_opcode);
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -2208,8 +2284,11 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
+	.get_pause_stats	= rtl8169_get_pause_stats,
 	.get_pauseparam		= rtl8169_get_pauseparam,
 	.set_pauseparam		= rtl8169_set_pauseparam,
+	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
 };
 
 static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
@@ -3903,6 +3982,9 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 		break;
 	}
 
+	/* enable extended tally counter */
+	r8168_mac_ocp_modify(tp, 0xea84, 0, BIT(1) | BIT(0));
+
 	rtl_hw_config(tp);
 }
 
-- 
2.47.0


