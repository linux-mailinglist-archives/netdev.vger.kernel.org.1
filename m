Return-Path: <netdev+bounces-267940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELCFKLritmmkKAEAu9opvQ
	(envelope-from <netdev+bounces-267940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:47:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03985291863
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81D9B300D69C
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9B366043;
	Sun, 15 Mar 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZbacsZm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E202D739C
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773593271; cv=none; b=YUSGHwbmw8D5POlBFZECpMg0c5HDZtFp5yLylAAnwPCZueHcsWyTCKoqxcvFy66LcOIsVet5X/lq98kBBvy76YmmFpNoaKtLiGAu4u1B4PvQRG2BnYjRMnjbxfGvb3kztADDx4+u2PUxwU9gSozqyQQ7w4mDP5X5N1i7kBCxwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773593271; c=relaxed/simple;
	bh=+Y4ynhNriKUYfmbqW8zN0eSQ5GNE1oJxqjkaTlxkscs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JcNVYwcg68FpzMPH2Uhbe6sjrRXb5QYrqGoG/IXv+oRL0AyJspSslsleWvnJDMlXyvoArSc0t1AfTnkGrU563n3KNOuPQOgiUALQS/w/b+Jjgt9jDLSrLMOHBdGybRi/oQseEj8QiJW+OIGoOxmUhn3rVTF6n7FMG5YF5fFWhZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZbacsZm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso31490425e9.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773593268; x=1774198068; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrxv2HLiIJDNWEqTvGIziEdTL4sk4CtNDSGCcqyAKpY=;
        b=jZbacsZmdK1FfBLs6NEn8yUUqYHk6FElNrpKV+1D24VwrkBjSkuhp0N1YeenUe1LVU
         vtBpqsrRMzEv04k+KO47z+NhIalcc5Wye7JIkUYh8pv4P2YaYQ9wgiFlMj8I4NeipGci
         nyqEM2Nx8hdp+yy3zQf+XVLGTIO9gLMRrYcUOtNdoNfWGmndLt3oj4+o2IiJEciLhd3a
         0yKp3Om1/ALxY4X7qqA/TrgxD6lQ48ARPCBobkra3LUFpNtWVyanvPaIlH8i44hj6oIc
         8RHnKn8p42CR/IMnULsAVOi2kNRg12Vxhm2+rXNviu3YOpyWKTV5jhVypE6Kja6uli2J
         Ifxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773593268; x=1774198068;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrxv2HLiIJDNWEqTvGIziEdTL4sk4CtNDSGCcqyAKpY=;
        b=fDce+02i+Fz+N1O6xaGBZHSxxEM/EGwmLj3Lyh10weqSD1vaHAmNz/7WrjM6dpzRSx
         e06SMCvDmuO7vi9/F/SbLTFBRaCovShmfUuSONKyntYUxLSuT6paGpakg1/AmQZw1fbI
         G1Tcm/mpjmxakdse77iMbrpJupNaqex6yS/1uLvIR1JghKol+bYCoVv7Qe1xTDsLUNY2
         MJ/y/E8rMD+RoOe0LnAbE3EUSh0jhyCO0SmjDh9VC9UPmjEBgd14yP64vfPF3EQDrIg2
         rSsp/fLa0wxC7DVPshKR8GS6NTQSPG5XwoNrqEHNG4MKcca0r0KUjxwQQz1XRlT7YDOV
         thOw==
X-Gm-Message-State: AOJu0Yz0gjCGZ3w9rg4tBP6LDOhN8EuIqQWThKI0oju2pgVloTJXXdnB
	fx/jUtJR//MLCSzLwtIS4uI+YqLa3sImrXBm40X+/qV95Aj2WDKU3Wuqfxe2Bg==
X-Gm-Gg: ATEYQzw25b05ObFU3Pcrv91+RTI24pcw2Dc9U3fjEQQ9Wu8MNt8cAoLR3BQo6tdWIeD
	XMKrkzjfg0xoEWYDGcrlRht4wv7P7jEeptcMPc2sqxKnsLsTER4n/32KdaU2qttaGl4onU0nFou
	sPQwIFeDe32poYjqUJfUTHJRUIcHVZNeHdybosD4CBFNdC03xecPnSuicAXV11aBWFqHLA9QjQu
	j9pPY05AYC3kLahLpT5ncNhtlOu3SiwxZw1eNn5VphgYktQHXND6dDbbgfMIuCDx0ndERj+fAm9
	8znEx75vbNjiWnt8Lnd5evB3JhjupZ+TTBzJ38c8jMJBQEtksAewIDkGlxzU9tA/UZaHaZ4Sgpz
	WtcQJ4IMGMipBrJKwtnCW7BVYwYwIY/FGfN6hIrf93C7+RB4L/T/RTQAvcJ4vMg8deto1WRy78A
	D4z5JvVrLqVvoUE3j438pCGpjt+zko+33GNMrCFTXTXJdlTpevmmYXNSQEAYOhpTAfbvn7PYmP8
	UCLAwQUjXm5F1V4/VfnHKwDW8+3KJIh5aCbdr75SAsUWzJSv78Lx2CA92Rl0FJRRA==
X-Received: by 2002:a05:600c:3b17:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-485566fa9f5mr165176505e9.17.1773593268192;
        Sun, 15 Mar 2026 09:47:48 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45? (p200300ea8f19c4005d7d7d8bdc1aae45.dip0.t-ipconnect.de. [2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm458699945e9.8.2026.03.15.09.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 09:47:47 -0700 (PDT)
Message-ID: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
Date: Sun, 15 Mar 2026 17:47:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] remove Kconfig sysmbol MDIO_BUS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03985291863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MDIO-based regmap is the last user of config symbol MDIO_BUS.
MDIO access needs a MII bus, which requires PHYLIB for the provider part.
Therefore make REGMAP_MDIO depend on PHYLIB, what allows to remove
config symbol MDIO_BUS.

Heiner Kallweit (2):
  regmap: mdio: make it depend on PHYLIB
  net: phy: remove Kconfig sysmbol MDIO_BUS

 drivers/base/regmap/Kconfig | 2 +-
 drivers/net/phy/Kconfig     | 6 ------
 drivers/net/phy/Makefile    | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.53.0


