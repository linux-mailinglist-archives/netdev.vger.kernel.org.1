Return-Path: <netdev+bounces-279313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG0vMmEr4mns2QAAu9opvQ
	(envelope-from <netdev+bounces-279313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:45:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ACF41B4A8
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9564E3071725
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC539DBF8;
	Fri, 17 Apr 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrxtEQ6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3139B4BF
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776429896; cv=none; b=lsTP4sftoQ3V/Pp/tT1w3nOimUtEuxj126TiZFUQqIGywGL2NWm5ZK9LAq5cdSc6KZkuT75C7VB3JIMTDWQALf8oLe1LMX1OOmoFq38TaCfzd8h9pNFmkei/xYP1hYcL41KVmlmeYcwRoDD2P/kPrWiQSWWzmof38hUsF+tFcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776429896; c=relaxed/simple;
	bh=Fs9VVuBPOJN07xoYLx1JLlEnA16IiWjsvm6UMCkZ0AM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqUXWT8UKyFC5yrcdrgNVZJUjhmZBCaFpcMLMMYreth9H3dWjNt76S15tBewOL/oTr3ui5M3gROc7UViRxBmI8MrtbpfoIzZ7MINH0/zQBxVKkanCpoHH4BVZsMhjiKU+VIGhizWYO8r5G15vUlAWAkrsQx7FmpbGe7nxUbcR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrxtEQ6g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4888375f735so7581565e9.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776429894; x=1777034694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eZVvumaL4Znlvx432NO7Lk63ndA9Vnlz6LqVg/cXUQ=;
        b=YrxtEQ6gxYnF8qyghSnS1plIE0NcBJtLgpYnEhvarpTCdDzOJ/wq8p6DswURxivKUU
         9h0m2peUmA2QqAl5ElclXxlTahuhEVtV559Hp/w06tf61a1Y+J6GXopm2DSM+yTQwh0i
         aqOdZqLSbrS2B79PYclhS0mzLU6UsgytgrCJkxTyYDKThn8FM45PFuP8oA4wQc5+WjuR
         yCAx2XjyoMD+Y2cWmF+Fcfqk0RXk3UXy0YbvkZxsyu7QzPNo729glDErUAVn34fXM5RM
         XQbFi4uke4keP4HXj0Vgj0bT63STMqR9Q8Buz/+NeYIRlo1laEMjKzKFnl9aL252+XTf
         Aeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776429894; x=1777034694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+eZVvumaL4Znlvx432NO7Lk63ndA9Vnlz6LqVg/cXUQ=;
        b=RXx0BfV2OzgKf6yEnMfIJWMQlO4kj/MI1J6412OY3xXPHV+hpyrNGa2Oskk6zpJWvT
         8iopd9C3ExwrDLw/NCLaLR3SATGw5j0VFcIhOz5ehzgke9N/0OlLJz1F1iirdTQbrV7t
         keAlCOpSTcuTJyUwXUravs8VoY0Re5s9tTvvNNWGQp+bDvKts9UPZZUmvTOjkuuoLiPl
         bBr/KtHvgz5MlUjjhkylHwop7QjdeC3At1BGZpEMeZmFjAg3Ihdb7pt9vj0S1fRJjOYq
         5RguHlmEx41N58cgBhCR7pH/SaHpp0dEH4J3+cWZKB6A8/7hTPgAyz1jR3UOuK7eIQPw
         RZWQ==
X-Forwarded-Encrypted: i=1; AFNElJ813RkFJ2hqcf1Qsa4CynosaEA5s78LLYne9eyF0zVfuI3XqseVTQ/leRPJEEhT+eXQBhB6w0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNL+fMTQT7gtt0aFOVeY968lXOfnW7RS8wioLSyvXmc7K0SSBl
	wXIrK/28T3FxIfFdPVzCWt9YaimLPGkVKAZeVOaDpWJeDkj1FQTr1Ir0
X-Gm-Gg: AeBDieszrUXOIXswT3zpMiICjxyJiCxwNsu+Xpu6qYond93YUbGJckKO82HemhKhV+g
	bthiM3cssfpnkLWlOzwqZggQHFs3X7ho66yCgBrjHcHzqyMISywELhhUovawHLvFmI46YyiYi9T
	u0MePI57lsdjrxsdyVQ/trcv4efJ+QjuJ/zm1ON3wL3c0Uv59xQ/i4Maxyig4kAwIuCsZxuXdXr
	GmN2LuqoTy5H7ty1cfAZjafATAnjUbNzEqXzWiKqYMGv79HhYzVZZPpcACpBlFKsMF7RMXfgaEw
	oAcB0utsE1z7HkYGi4HsnluFYMq+5//4QWbtk5bmj78no47VL+dbzhZLvZZ4rJyAo/LKOY4MTQv
	B9BPGfdIs3BoUfReFeF0TuEhSLo9UTezgWgpqlQAiTyhdEIcXZAKmiSc+KmR7UbO6tttbgEY96v
	QzrdNuH0GQEuDuP/rdsst010Iw8IZm2E5Q7mutIoKxB+XxSe9iG30RoMApgX1+8ifMVy6vJmWsS
	JvmTsGcaNwxR1/LFFGY
X-Received: by 2002:a05:600c:8706:b0:488:d6eb:e635 with SMTP id 5b1f17b1804b1-488fb753abdmr42181725e9.12.1776429893542;
        Fri, 17 Apr 2026 05:44:53 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm47416315e9.5.2026.04.17.05.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:44:52 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Fri, 17 Apr 2026 14:44:28 +0200
Subject: [PATCH v4 2/3] net: ethtool: add KSZ87xx low-loss cable PHY
 tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-ksz87xx_errata_low_loss_connections-v4-2-6c7044ec4363@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
In-Reply-To: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776429890; l=2581;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=Fs9VVuBPOJN07xoYLx1JLlEnA16IiWjsvm6UMCkZ0AM=;
 b=mR4AkNjPhMZn06l06xj9UdqZxxVGoI0Xd+48Hhme7bU98YKoUJMqaMTq2ISA0VHrfL51yhyMl
 1G/ru9nOvQ4CYDLg0hVi4SfUTzaTVAnnw8CYJgItHlUjcdHrGDhejF+
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279313-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85ACF41B4A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce vendor-specific PHY tunable identifiers to control the
KSZ87xx low-loss cable erratum handling through the ethtool PHY
tunable interface.

The following tunables are added:

- a boolean "short-cable" tunable, applying a documented and
  conservative preset intended for short or low-loss Ethernet cables;

- an integer LPF bandwidth tunable, allowing advanced adjustment of the
  receiver low-pass filter bandwidth;

- an integer DSP EQ initial value tunable, allowing advanced tuning of
  the PHY equalizer initialization.

The actual behavior is implemented by the corresponding PHY and switch
drivers.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 include/uapi/linux/ethtool.h | 3 +++
 net/ethtool/common.c         | 3 +++
 net/ethtool/ioctl.c          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..081d8f2191b6 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -291,6 +291,9 @@ enum phy_tunable_id {
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_SHORT_CABLE_PRESET,
+	ETHTOOL_PHY_LPF_BW,
+	ETHTOOL_PHY_DSP_EQ_INIT_VALUE,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e252cf20c22f..9c2fe5b626d6 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -101,6 +101,9 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_SHORT_CABLE_PRESET] = "phy-short-cable-preset",
+	[ETHTOOL_PHY_LPF_BW]	= "phy-lpf-bandwidth",
+	[ETHTOOL_PHY_DSP_EQ_INIT_VALUE] = "phy-dsp-eq-init-value",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index ff4b4780d6af..5b66e4a96f67 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3109,6 +3109,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+	case ETHTOOL_PHY_LPF_BW:
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;

-- 
2.53.0


