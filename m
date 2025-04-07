Return-Path: <netdev+bounces-179622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B1FA7DDCB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C478B3A6C93
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76EF24C082;
	Mon,  7 Apr 2025 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WF4fTGRO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921524886A
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029439; cv=none; b=Y3eiVxknzLovN4Bw853gnfDXr1uV9yDmmj2Cgbw5KwyfqEs5w8iKj/VTEDk0J2aLIGjTNfu3RfsVX/0F44uHD8J6FG4zNGXO8wd25rGWS/Qfcvly29L0DSUlwHGaFzHOOg7bhpFIQE/OFYO327954uWuM+Ky6Bw2s0zktV5aft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029439; c=relaxed/simple;
	bh=r/T5Mvgm+4E8BMHpVYH3ATZZcktSIOl0OSw2kMJvrD8=;
	h=From:To:Cc:Subject:Date:Message-ID; b=bwJHelLS5uxA7deIiRezEykqaNi5AA9DNZuThFNG8dL5c6xe+U8aKmDRQ6hki1zZZmB/i64i8H2rGhuP7ALvkAde5spLdhSghhP4mh8kdRgASuhF8B8mC+QlDX2pfjaM2Bi3TR4d+OAdI/rjbpJoEBdqvaLFt3RVhHTPfzNwCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=WF4fTGRO; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso2358747fac.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 05:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744029437; x=1744634237;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21ud4a7PpzHTsE+w/yzFe+lHiyhoei8BC1Tfj/sZr0c=;
        b=jH9vzRW9KvXHwOXHDSzUBgmzvZs0ZhQ1S2ShexpGejIr5Pn/t4+ax3vH569NeRnG7i
         6Sx3XIqnPKdadW9qFRq1FJd4CHMasfWF0x9H/roB7zq7kHiESbCVslCRsXMyRDElthnS
         shIWz2i2EMhQ9ArKmJ3SQ9ZPPk3XRMbTSIq5N5GqQmdUN7hljIpn1O5yzpxvqMzkdUG2
         v+gvY7axVeYUCERwKvxMETpQzQjayoAcufQrFgqA+6SIDN15HXSsPhtqxrXALOS8lznJ
         bYc6N6pNzStwjlExcf5SI29WwzZivvlE6hSmXxTLCODwqKWLJ1dwr0dvcEmkcOcvrWyG
         P0xw==
X-Forwarded-Encrypted: i=1; AJvYcCVoiAE+Xi7tFcgQJcOI5F5NLrAyyyhv2meH4bsLj9qHGD5eROxbCDmS3DNBnKtXwXYWUuLpg5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bJVqAxUrg3aRv2wucq0kTWJCaXYpeTbZSuRJtl8GnIWubR35
	N33mliuMb7YbEHJl//RLvbBhnRrwprDQfBcZezsStYOinZ69pUQlyaU8c83j7PNxPi8xCiE8sbM
	KsBanj5IHpvoxSQIHySDm358yXpSoTw==
X-Gm-Gg: ASbGncvIACi1qhNmrCB8RL+Tix1YKXrUBYe1x5rFXsnfmCCVMmyNMBvJqPtvFnBEajw
	MjbPOBsd6JSTWlS0jS50LzzFMv6tW5g4RIKeMLD1KIF6CewAg/56FJ7qtVfcqUj94jn3pQjwT43
	WnQ3NwL4wRpQr1pW/LAUEj7qsPHIaAuRe4dOHpm9ISorf+MbyxttgvJBKhBMld8oB07IBCb4i8B
	SFSzwYhs5avJ5Z4AcAeV+Hk7HknI8WVsvIxLGwpa2S+9ZVPTQHwgdc0LNozoVPxl9PeTQmQU7Qh
	QxiwkT6GEFKIV786/3GzoPRakkE=
X-Google-Smtp-Source: AGHT+IFwD3N3azBjTuz63ahaMy52lmrJaPVlJJNJrWOY/OnOBkQkkoZFOugtTieb0gKL5dsL3XIPsVIQhsY6
X-Received: by 2002:a05:6870:9c84:b0:2cb:c780:ac52 with SMTP id 586e51a60fabf-2cd32f45081mr4230230fac.23.1744029436705;
        Mon, 07 Apr 2025 05:37:16 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2cc845542d8sm638112fac.5.2025.04.07.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 05:37:16 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1744029434;
	bh=21ud4a7PpzHTsE+w/yzFe+lHiyhoei8BC1Tfj/sZr0c=;
	h=From:To:Cc:Subject:Date:From;
	b=WF4fTGROUngYoKZVX7o687VHDF3//y+V1ZeOlVvIKNMYZXvXmuzOdjIY9IY0aLl+/
	 FaEvgWzVzhOdPMgz21C8E0ueAEqVmEWHozh70iYFJtt65h8LlW+cBqBDdz5+UA2gu0
	 V7bttLm9A0H0m0c9Y5rHdL6gX8p0GG2wxFRnVniL8lWbHfixZztxI9U2OLrsJHDTKP
	 owwr0aMD3lulmaNzyf901YaArthAlftfRm1U6Gui/1XjUaWQsZmQXmOEM1XcnXoAWG
	 XsJrBltB7Ie2IQIAKSkjgsx1wFIjMW5nupqATvSG8y9nDOCQpfnjmApxBsbGBrjJsH
	 4I6gHLODN9Xng==
Received: from mpazdan-home-zvfkk.localdomain (dhcp-244-168-54.sjc.aristanetworks.com [10.244.168.54])
	by smtp.aristanetworks.com (Postfix) with ESMTP id D55FE10023B;
	Mon,  7 Apr 2025 12:37:14 +0000 (UTC)
Received: by mpazdan-home-zvfkk.localdomain (Postfix, from userid 91835)
	id C0C3840B13; Mon,  7 Apr 2025 12:37:14 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Marek Pazdan <mpazdan@arista.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Marek Pazdan <mpazdan@arista.com>
Subject: [PATCH 1/2] ethtool: transceiver reset and presence pin control
Date: Mon,  7 Apr 2025 12:35:37 +0000
Message-ID: <20250407123714.21646-1-mpazdan@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Signal Definition section (Other signals) of SFF-8636 Spec mentions that
additional signals like reset and module present may be implemented for
a specific hardware. There is currently no user space API for control of
those signals so user space management applications have no chance to
perform some diagnostic or configuration operations. This patch uses
get_phy_tunable/set_phy_tunable ioctl API to provide above control to
user space. Despite ethtool reset option seems to be more suitable for
transceiver module reset control, ethtool reset doesn't allow for reset
pin assertion and deassertion. Userspace API may require control over
when pin will be asserte and deasserted so we cannot trigger reset and
leave it to the driver when deassert should be perfromed.

Signed-off-by: Marek Pazdan <mpazdan@arista.com>
---
 include/uapi/linux/ethtool.h | 14 ++++++++++++++
 net/ethtool/common.c         |  1 +
 net/ethtool/ioctl.c          |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 84833cca29fe..36c363b0ddd4 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -289,11 +289,24 @@ struct ethtool_tunable {
 #define ETHTOOL_PHY_EDPD_NO_TX			0xfffe
 #define ETHTOOL_PHY_EDPD_DISABLE		0
 
+/**
+ * SFF-8636 Spec in Signal Definition section (Other signals) mentions
+ * that 'Additional signals such as power, module present, interrupt, reset,
+ * and low-power mode may be implemented'. Below defines reflect present
+ * and reset signal statuses. Additionally ETHTOOL_PHY_MODULE_RESET
+ * in 'enum phy_tunable_id' will be used for reset pin toggle.
+ */
+#define ETHTOOL_PHY_MODULE_RESET_OFF            0x00
+#define ETHTOOL_PHY_MODULE_RESET_ON             0x01
+/* Not Available if module not present */
+#define ETHTOOL_PHY_MODULE_RESET_NA             0xff
+
 enum phy_tunable_id {
 	ETHTOOL_PHY_ID_UNSPEC,
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_MODULE_RESET,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 0cb6da1f692a..3d35d3e77348 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -101,6 +101,7 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_MODULE_RESET]   = "phy-transceiver-module-reset",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 221639407c72..f1f4270cdb69 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2954,6 +2954,7 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_MODULE_RESET:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;
-- 
2.47.0


