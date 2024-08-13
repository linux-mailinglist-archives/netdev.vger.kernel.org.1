Return-Path: <netdev+bounces-118238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA5950FCA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EEF1F241DB
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607E189F30;
	Tue, 13 Aug 2024 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPUvff1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18813635D
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588413; cv=none; b=bSgvtvtiyDvzAb47THO1tflVYxD6BMtH7KHMZeMysxM75GKVBDjSjitDk5ESI8QX6I+CJPpjx9U1G5vnZ94pOJAoG7Jy9otbzuaaP5KvwxRfIEKgSy9VAkAi6N3zo/eYyV+Cj25iS24/uyMkOkDerEtY5WAuFhIYOkG6+LoTWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588413; c=relaxed/simple;
	bh=1NguMnv2H4c5qrARBVNmrv6klQP7LOP9dqTIA1HkpKo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kHcCxrJiXJz3/pWlfOniY8KbFw2gg+WwkfxfebgqE5eViFoSlVUp/rVx11YUYgZ2Te5mvoFb8dE5UG7gZIm4HfVhHLJz1eU1UJN6uYzSu6ECgOn2ulOF2aw1QBDLLDwTX9cmXdhLsu3o2jLzUcvi/7OF3xsQlUiZdXRc/POfx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPUvff1G; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0bcd04741fso10317278276.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723588410; x=1724193210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N81ACx3SumoaZNLd3E+NxwXhN8uB5QQzYopeRnYUYA8=;
        b=EPUvff1GME0kodljV6CL1ZmVb9dFla4cZ0R37PWkHQbSeAqXOBAXq+RnxqDvgNEMkx
         b6ZjuLsZRsbHaI74oBBoPtpQtwuAE4QURefK1EZX8CUv0NZQPKZl1jtBz15a5DnV0Kto
         8TaiiLRTp7QrHweoJiGGMUaRyiSUM35v94QQG2nUKuLrFAYwKauRXK+4FulUVlBsWEDE
         QC59JRfeQk5MfP4Vwbp02QwXcjx2+z9gzxKV4QHQd5mLt+V8D/YT85xwoMP8zwbe22kr
         8yq7f6sZcWEvbFHiB9JVUHiKmW6uQa3RB5SXhgTSbQC5DwvsKVIF9fONxpmvYLOrfNyb
         nzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723588410; x=1724193210;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N81ACx3SumoaZNLd3E+NxwXhN8uB5QQzYopeRnYUYA8=;
        b=QNuQHSn6Xq9hQuBZurmwduJgmR4o3WpgZlIi3guYGjZ+2KQYWg23NBKLG6g3wxXIgr
         vrbN3r25yhvLFD4ycNqWgDpJ1bVSHX8e/vYOL6n2S/RSp6bQEggCCkRMf6V69x4ABO7N
         vGEhAAIHBDT2oEkJu6UImP8dx8qJqedxwSnGaMeCCb/HBroaRFNDP8h7i2x8XGwKA4tl
         MPI+9S8TNe2kjVZ5Wz7tsAJkgAkZsLvcGvydMdNVaL5R5ECZTFoWecqaUtd265CSEqfB
         4ewbRUDkvB4b9d/4txYqPAQiN+KzyNev5EPM2t5PjP3EpD9t/sfA0CQMbLcfKkrKMa91
         CcgQ==
X-Gm-Message-State: AOJu0Yw75fBJibEF2lTeRHKtKCWRaVKiW7Szwrj+t4hfPZI7gu+g+3KB
	GRKaWsCNUUgyXvC4s02ggbCwW7tjSS2hHqVzbE5W7AQRLQCjh3Wq7AMVuiHF7DZFaDELjg==
X-Google-Smtp-Source: AGHT+IFuvNeOsrOM8QDQyXjD6XJJz1A8pnH8YouTVMAH+oH2Jgg4abOoy5VlCQ8+veUy9FMdN55R/iXs
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:7199:1729:2be2:5cf4])
 (user=maze job=sendgmr) by 2002:a25:2157:0:b0:e11:3a37:f627 with SMTP id
 3f1490d57ef6-e1155b69745mr32681276.8.1723588410595; Tue, 13 Aug 2024 15:33:30
 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:33:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813223325.3522113-1-maze@google.com>
Subject: [PATCH net-next] ethtool: add tunable api to disable various firmware offloads
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, 
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Yuyang Huang <yuyanghuang@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In order to save power (battery), most network hardware
designed for low power environments (ie. battery powered
devices) supports varying types of hardware/firmware offload
(filtering and/or generating replies) of incoming packets.

The goal being to prevent device wakeups caused by ingress 'spam'.

This is particularly true for wifi (especially phones/tablets),
but isn't actually wifi specific.  It can also be implemented
in wired nics (TV) or usb ethernet dongles.

For examples TVs require this to keep power consumption
under (the EU mandated) 2 Watts while idle (display off),
while still being discoverable on the network.

This may include things like: ARP/IPv6 ND, IGMP/MLD, ping, mdns,
but various other possibilities are also possible,
for example:
  ethertype filtering (discarding non-IP ethertypes),
  nat-t keepalive (discarding ingress, automating periodic egress),
  tcp keepalive (generation/processing/filtering),
  tethering (forwarding) offload

In many ways, in its goals, it is somewhat similar to the
relatively standard destination mac filtering most wired nics
have supported for ages: reduce the amount of traffic the host
must handle.

While working on Android we've discovered that there is
no device/driver agnostic way to disable these offloads.

This patch is an attempt to rectify this.

It does not add an API to configure these offloads, as usually
this isn't needed as the driver will just fetch the required
configuration information straight from the kernel.

What it does do is add a simple API to allow disabling (masking)
them, either for debugging or for test purposes.

Cc: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Yuyang Huang <yuyanghuang@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 include/uapi/linux/ethtool.h | 15 +++++++++++++++
 net/ethtool/common.c         |  1 +
 net/ethtool/ioctl.c          |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 4a0a6e703483..7b58860c3731 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -224,12 +224,27 @@ struct ethtool_value {
 #define PFC_STORM_PREVENTION_AUTO	0xffff
 #define PFC_STORM_PREVENTION_DISABLE	0
=20
+/* For power/wakeup (*not* performance) related offloads */
+enum tunable_fw_offload_disable {
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_ALL,
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_ARP,
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_ND,
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_PING,
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_PING,
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_IGMP,
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_MLD,
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_MDNS,
+	ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_MDNS,
+	/* 55 bits remaining for future use */
+};
+
 enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
 	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
+	ETHTOOL_FW_OFFLOAD_DISABLE, /* u64 bits numbered from LSB per tunable_fw_=
offload_disable */
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
 	 * tunable_strings[] in net/ethtool/common.c
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7257ae272296..8dc0c084fce5 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -91,6 +91,7 @@ tunable_strings[__ETHTOOL_TUNABLE_COUNT][ETH_GSTRING_LEN]=
 =3D {
 	[ETHTOOL_TX_COPYBREAK]	=3D "tx-copybreak",
 	[ETHTOOL_PFC_PREVENTION_TOUT] =3D "pfc-prevention-tout",
 	[ETHTOOL_TX_COPYBREAK_BUF_SIZE] =3D "tx-copybreak-buf-size",
+	[ETHTOOL_FW_OFFLOAD_DISABLE] =3D "fw-offload-disable",
 };
=20
 const char
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 18cf9fa32ae3..31318ded17a7 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2733,6 +2733,11 @@ static int ethtool_get_module_eeprom(struct net_devi=
ce *dev,
 static int ethtool_tunable_valid(const struct ethtool_tunable *tuna)
 {
 	switch (tuna->id) {
+	case ETHTOOL_FW_OFFLOAD_DISABLE:
+		if (tuna->len !=3D sizeof(u64) ||
+		    tuna->type_id !=3D ETHTOOL_TUNABLE_U64)
+			return -EINVAL;
+		break;
 	case ETHTOOL_RX_COPYBREAK:
 	case ETHTOOL_TX_COPYBREAK:
 	case ETHTOOL_TX_COPYBREAK_BUF_SIZE:
--=20
2.46.0.76.ge559c4bf1a-goog


