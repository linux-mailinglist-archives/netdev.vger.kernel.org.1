Return-Path: <netdev+bounces-293810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBSBNnmkHWr5cgkAu9opvQ
	(envelope-from <netdev+bounces-293810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:25:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71559621A68
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B39C53035F0E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F023DB628;
	Mon,  1 Jun 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ5iYbJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4F3D9DBF
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327509; cv=none; b=efEqYahnUXT9LaNqgj0yqLzXo4E8BpqmQPmjpjIJO6BffojofMYGXT+lqtI8zjrHNHOmo5rfrG815gJu1uBx4CR3ASml5DCGYRS3Uc/CHl89HzMimak7RtaWswfy/2W6zATPS3z+tfNkHqSK7YVqmQkneDTud8zt79N7BoIu1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327509; c=relaxed/simple;
	bh=52onxtZqZKJ077Jn2t4aGL/qYm9bdgzCixapPxXr94k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGhh9KUyWIsGs6imxj+vWtjhwWAatgaJu7qEAvrZtooXNlyXjQVDV62QSfwftVvOP4fWHH8Fo6cqe6PaROj1nM/lkBxLTZvVA19CmctmlY6OEPrPID4jGLh7e2esHjWBGcdCGVaCKb3jgvBkbxZ+S0PCHrvM5/NzBiVH6urtqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ5iYbJF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490426d72f7so89864615e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327503; x=1780932303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwdlyjOEGoLEOnu8PlPpT2qsoqG2kN0gtcCpk4MmNhk=;
        b=nJ5iYbJFey9HT9aFA9eN3yTf3VRDDZFdgqQGKr0alBWih1nfIHo+PiWL0pSkJRqiou
         FoOdFPvYvLaq8w615kua9vA9maeXFm38y5pbvfmOEj0dghJ4qLOoQ1yqn+1YO55Kbt7s
         QSWFHGtzqux/cnZZQStFPEcaYWBoul9D+NmT/YDsnHYHHeDX9LOykbv7s0NNqoIwSFKU
         WDCYVoTdoeVt/L6EWV2nwK26bHk50XL98u6pZ3rDYnMQ0G7QQojbGzwBonIq0VVMbnK9
         rA9ssIXKe5Tg7J0zXRpLIpNmc4dt4FSgm6rssw6p27k2mGjrM6K2ia1zvfcrhQ2He9NV
         HArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327503; x=1780932303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TwdlyjOEGoLEOnu8PlPpT2qsoqG2kN0gtcCpk4MmNhk=;
        b=CTmunp2JkMWl8QoiDt/b3DevQ4pWaRcUWIQKY9Q7e4CziP1be3aAlkMZiRCL027KAv
         xJV3UW8i/2B5bVPg0T8wy1LHNm86C3ZdbgW45EKfHqpKR+OyDVK0477E5y0eBGNQeZxb
         AHz8cDer9IL5rDFMBOD6stajGnKGcME9SeQtHkGMD2rwdg5eGukiJ5yq10CFoMZlBOpH
         fQjxK2PaOSVvv6WqbzKyPJ8e9GgXVDwrcWlJuxwrbgMzLRg3qt+4TsREx+PdSQELg7oB
         MCcVTVqsmma78z/WFmHFd9dsWmaFLWJvyew+4d386zEB0c7M1o53HLP88QYbQAl3G6Kd
         e4CA==
X-Forwarded-Encrypted: i=1; AFNElJ+ouC937l7SUPYd+KAnViSnk84Wg4QSJbLDpTxzzTIimHnBK80nx8VTGmoYd5OSMiHyvddBG+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfY5M8IKqJpipUc5jx2KwRdQ7jXl2V8lbwKWYw3kvuA/zD0K8
	3V2z4n0g35nESGGNb2XEJtv+K+xFBNIm/vjOpSIeoQYIA7I6oYZ+w1ZU
X-Gm-Gg: Acq92OHKbUb94e8n66VapcLwGRB6hZoAMeeF/B/is95wsajAsigm9hQABv2AHmkUMLe
	a4Fq3k6/OeySdSfJQ94xbxk/eTeV5KwNtwwLpX16EAPPiIp3PZl63W5Sv9SolAXwrSCe3BVjOyZ
	yhb2UGg9ospdaEw+EHvEdYufDxGwzKaLcRkvTmcnDX0uQ4Inmmp54WjrqPYmtiIKQyNrrK+DfIN
	thghUUf8XRibfoNBhRDdnuVFVkfDHTJGEj9akrIeWBXlB++baBhPLNOqRA26Sxia+3Q2vYrJ2UX
	RSF6bCkbfzp3lb94Q1eVHyVYHFF54/7EUyKVUfSRXvXoZliJQHF1vPscRzqIhMwMaxWbfqLuwv5
	mAYA+L8HZGQ43j5NeliPOwfk+toI+TEKvjEt+G7b72waTXxc1COMRvZ3LQ4nKpLYaYI78vIFTqu
	qBu/DRfn5vRA0pb7X0eKa3/2fp/Cz7cDGbGGedw0lU5xsya87uFRDdP1j5xeM4ZH6Zziy3rtLNb
	91kefQE1R/6X4mMzs0n
X-Received: by 2002:a05:600c:6592:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-490a2904ab0mr231921935e9.6.1780327503254;
        Mon, 01 Jun 2026 08:25:03 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e26050sm26035e9.9.2026.06.01.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:25:02 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Mon, 01 Jun 2026 17:19:56 +0200
Subject: [PATCH net-next v9 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tristram Ha <Tristram.Ha@microchip.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, 
 Fidelio Lawson <fidelio.lawson@exotec.com>, 
 Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780327500; l=2676;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=52onxtZqZKJ077Jn2t4aGL/qYm9bdgzCixapPxXr94k=;
 b=84q6A1cCirRAqZTuX0NHOBQerjgJ5Vtn5lqw7hTHKGi9bEPwHCXIOzbNK0d8Hj2j1RzWSEUNg
 zZD7lTyKlBzDjrbNeVgMD70rK4xf2vD0r0LxpUCLUEaQhSFwlNcSH2w
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
	TAGGED_FROM(0.00)[bounces-293810-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:email,exotec.com:mid,exotec.com:email]
X-Rspamd-Queue-Id: 71559621A68
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

Reviewed-by: Marek Vasut <marex@nabladev.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 include/uapi/linux/ethtool.h | 3 +++
 net/ethtool/common.c         | 3 +++
 net/ethtool/ioctl.c          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 1cdfb8341df2..a2091d4e00f3 100644
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
index 84ec88dee05c..a24d3a8a9ec1 100644
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
index bd97f9b9bf18..fc2542422824 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3114,6 +3114,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
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
2.54.0


