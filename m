Return-Path: <netdev+bounces-307079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w1nZELKeVGpCoQMAu9opvQ
	(envelope-from <netdev+bounces-307079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:15:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA83A7488CE
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:15:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KaeE6Otx;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307079-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307079-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 230543005AA1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AAB39EF2A;
	Mon, 13 Jul 2026 08:15:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EAE3ACA40
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:15:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930518; cv=none; b=RMPy9G7HRa27zFOwBo+OgsGGbGNuzaHLbnnk4YySj56inyCYAGDznDtwbF3OhwzC0aREsK/n/sOZ17BOVe6I1dSVlFGefl3zGz1HXOqHlYGnlcHmZRS8JZElPWvBObq4w2Oa3o9mPTKevlhUnhDTUfeqY8KhNqnSL04DF9KsNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930518; c=relaxed/simple;
	bh=GTnpMpJY2clbb+WtLUxt4Qh84eiEmLW5SnRc/gJZHrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrDygDGGr4qOtWV4hlyWMUYwQ54Uysi0rdpdHHxfpAKCZw8/yA/PTVyseH/3twTGgn8DGYg36IPmwlvXJSI7fqIe+q4ucRgDDmry7CfROgKaQuLOHRmbqIlObkQthk0WDIafE4foAnyJLOrFxxTJOzJPH4Zsc2MtfAFEIMWS9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaeE6Otx; arc=none smtp.client-ip=209.85.208.180
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso19562461fa.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783930515; x=1784535315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTnpMpJY2clbb+WtLUxt4Qh84eiEmLW5SnRc/gJZHrs=;
        b=KaeE6OtxNAf8J+7/7hp97pDAjWsVGeZf8IbfcUA96PXgqgtSz4bDD5uSQqJr/Y4QQV
         fXjGrCc3NJb5auzMRo80niQHsN13sHuzHehEmiRNGSo6e/iSZWMWYikkHnpNXaxF3Y3p
         jXucpy/074WK42u2Sz95gEerIFGao+99hmGVQkaS8TPPlhbb/86OW6+LPO53/5y8EKBT
         uYVtFCih8ddUDnAN/Lo2RRVKnTRKCEbIlrFDaSGFz1bwBjCVJx+s76q3hQUO+Pkv82Bo
         RkYtDnophW/e02J0WXbgcRSEN236FaEL9Q9cCdz1JYQUmLF0N2Fhxzn5wr2GLqxzKTUD
         V1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783930515; x=1784535315;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTnpMpJY2clbb+WtLUxt4Qh84eiEmLW5SnRc/gJZHrs=;
        b=oRZeJ2vbXrV5j0URw9bFr0ADr/8+9MlAo8Chh8u+HZGrjn39Pm6sgJ1Dy33WM/Wyip
         PQe/k3djghU40+zNSJbwAdW38zVbX6wejNme2/c/F4iryMrZcidz3XG5UI+wLaVFr0FL
         9fHJfbR92fQKAF0KbQeuKajw1s39QzSxpNf+epUAD5387E96s+iKOLlQNcEtlh3EODmK
         lN5pHdGuSLdMeWhYPHSbMMkM5K8j0/UKe9ucS94XHUjVXXYMtSl+g/U2JTOEdv4a6zY3
         v0OeHfA5XyAjJdbznDBqp8N6TFPFwEKvyMwG+qKRwDEhfBlaG0H3itYrZR6AS+4LeVYL
         l6aw==
X-Forwarded-Encrypted: i=1; AHgh+RpWxnw+UC42nxm38vFQ9fwJOu9u3+vEtlCUeLmYGzk22OTpfIFQMMsCWjFAF3V89nR81S/ORdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPhjBHrdJ51SxiNIH0a4dR+V7ajEXyqS4XL6gk7Vxc05IK3xp
	bvkeb0nNwkJJ3/aaaXwv4EZhlbetFR9qVXNN1p84VA+x2fZEv118F8a8
X-Gm-Gg: AfdE7clPzeuvxLQ4qgy8v2qSSWkKmZ1nHU0LOCLI2ONKOYFED/Cva9g+xrnCSCEl8cO
	kl3pkVOUgV9Fq2aZyDYpzaKvtqg2kU1g5XC80noNTWGcilvbLU5l18aQYgiIDmLmioIdipcxw4l
	vtzGmXH/Wc9OVqpDSUp7RgI5zX5B3XmmBG9ZgQrln9sqJrPFNZXB4Fx+SOhzOspP/Rg+VbjHMTO
	pWP1k+w5r8yc15mH2Zn8xhs206IC6WX8UNX9xDUBZmUXoq/61Ax9Aco24sp6vkQ5LuEWMLh/nTC
	owbuAyhGEdnsqIq+TZSOM4TD0VtUqDbqQ0a/qt/d0vpop2jSWF7EqH4C2UDlyqTHSlgqTiAHCNs
	dQ2OaVEdUuObcSjlWH6BZzyLDL3v8SFQKgh7MwhjkJjt5rt4OWzGo3VJ+sPwyLydWEPNIF7BzS0
	9aTUoYPGk9XWR9AN4sr6imGVHe3t8eslu642UIFzADQ/1DJ+jejNcZfa1YrQmePJoxFWXUhgQTq
	0xH
X-Received: by 2002:ac2:4c10:0:b0:5ae:c3c1:8208 with SMTP id 2adb3069b0e04-5b0236b3a79mr1270972e87.51.1783930514628;
        Mon, 13 Jul 2026 01:15:14 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs58215.centertel.pl. [91.94.100.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca9ddf0sm2644281e87.50.2026.07.13.01.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:15:12 -0700 (PDT)
From: Stacho_P <kuncy7@gmail.com>
X-Google-Original-From: Stacho_P <stacho@venco.com.pl>
To: Johan Alvarado <contact@c127.dev>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Alvin Sipraga <alsi@bang-olufsen.dk>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Stanis=C5=82aw=20Pal?= <kuncy7@gmail.com>
Subject: Re: [PATCH net-next v6 2/2] net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S
Date: Mon, 13 Jul 2026 10:14:37 +0200
Message-ID: <20260713081439.18379-1-stacho@venco.com.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev>
References: <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307079-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,bang-olufsen.dk,kernel.org,armlinux.org.uk,bootlin.com,yahoo.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuncy7@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:andrew@lunn.ch,m:olteanv@gmail.com,m:alsi@bang-olufsen.dk,m:linusw@kernel.org,m:linux@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:luizluca@gmail.com,m:namiltd@yahoo.com,m:netdev@vger.kernel.org,m:kuncy7@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuncy7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA83A7488CE

Tested this series on a TP-Link Archer AX55 v1: RTL8367S with the
SerDes on external interface 1 running HSGMII (2500base-x fixed-link)
to the SoC (Qualcomm IPQ5018 stmmac gmac1). Base was OpenWrt's 6.12
kernel; the only adjustment needed was dropping the neg_mode parameter
from pcs_get_state() for the older phylink API there.

The trunk comes up at 2.5Gbps and passes traffic (all five front ports
are behind it, NAT routed through the CPU port plus wire-speed L2 on
the switch). Warm reboots and short power cycles bring it up clean
every time, no SerDes firmware involved.

One observation, quite possibly marginal silicon on my unit: after the
device has been powered off for several hours, the first boot brings
the link up (2.5Gbps/Full reported, phylink happy) but the data path
is heavily degraded - 60-70% packet loss, the surviving packets at
normal sub-ms RTT. Re-running the PCS sequence via admin down/up of
the CPU port re-rolls the dice (15% and 40% loss on two consecutive
attempts) but did not fully recover it; a soft reboot (full re-probe
including the chip reset) always restores a clean link. Short
power-offs (~a minute) do not reproduce this. For what it's worth, the
vendor firmware for this board keeps the DW8051 link-management loop
running permanently, which would effectively keep retrying out of
exactly such a state.

Happy to test follow-up patches if you want to poke at that; I don't
think it should block the series - the feature itself works as
advertised.

Tested-by: Stanisław Pal <kuncy7@gmail.com>

