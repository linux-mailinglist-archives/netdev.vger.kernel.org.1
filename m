Return-Path: <netdev+bounces-305600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a4RSDg54TWrL0gEAu9opvQ
	(envelope-from <netdev+bounces-305600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:05:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD271FF83
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:05:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=breiti.cc header.s=google header.b=MHgkDJnJ;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305600-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305600-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83A9A3016032
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A1F3859EB;
	Tue,  7 Jul 2026 22:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC939989D
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 22:04:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461897; cv=none; b=RLOtugMH4EoWfyZVxNf25qUisCvNTzp1JnKoohSQUKtGMKEDwNsTaBX4Zyo9v3O/FrWZpKXnTJ1HAA9ATifW07j0y5aKkJiDeDuNAq0dV/eYJJmgXN4EyqFHoYjXx8QCI6+UBSod/BwWtFq3ZZecdlgFuQ9HW/pFQ+OskrgSA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461897; c=relaxed/simple;
	bh=bH3gk7RWnvE3hlcnw01+4CMtuv42q3VTAN/STxJ01j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwKfzFM73KgawgiuAI+FOnXrg4fRuPGwDyLFJYYo+0/CTh377zC7yCdTyxaTliLvkKM780WB76nd81x/URzhrul1PRfpzU5+2mnkpEPWXMWDspK17zBCTafwiI4dokspoX3+qNJxPSaGxSxtUKySnhbuvr2AZNv8DFDqEGouEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=MHgkDJnJ; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso460285e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783461895; x=1784066695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itsXGIDk7WLLBfalclN3ttCU0xEyv6kkTFRPr/iZ59E=;
        b=MHgkDJnJXT/hJF4wUpX4BgCERs+G50kCwgLARYdsVL0xmM2dmrblY0BLVPIBovNYva
         hdcbWmcZSRgt3euA2ZHaj89RaGus+c0XGovBxw912UB6NkJvQ7e1gfKXdpUF9IWe1ITh
         Xddbi5PUFTQr+YONPrlAmYoMQtyJjDw+9H+sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461895; x=1784066695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=itsXGIDk7WLLBfalclN3ttCU0xEyv6kkTFRPr/iZ59E=;
        b=o1r9t1fpS0xJzOdGb2tPqMQ7ZxsFFADj+p2AesA0ovBUZQgY3C2JbhWRFF1/sIgdOx
         qY3/z69sGhq91f4StrI1NCQIUpmeMe/fqkEZj2f5U7lRguv8295I1gBO9HW/+oSMiYWj
         uTDgkf08zMEu5WrSnQ4/MQID7FtUWI/ZnKRa5EBD4Qpd7z0LMma33xOJssWXWHVrmKpb
         UoITJHSqB4OmhYUjinCJUNdqGAQd5RItuSMikSQEaPN2NMbzyOceyOpgHkewe7vcIX8L
         rEFdQn6xgKGn8aDjzggKTHOXuKwJ9TdN0XKznSeUyLmvwbAC8XoObrGx1SlCW16y7OX8
         B+sQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiluwxIOBzYDBfNOo6MYMD/RSP0yYgu3F7x9yVJodYCvO204UKT95Mry2VP/joCTi6yF9UUUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOobCVlP0h8FwyclVmQIpBGEuRF9jeV6CmZUwtD9GcHnnGx2yX
	Y8a3mxEckWk33buRNWm9LnWPbN6yGEWxX4l6ZwReGIJs9La4XRkY/Ql0sF2ZXk6p9gIixsrb0RO
	NIt0V2e3f
X-Gm-Gg: AfdE7cmOyR/LqnQ36475cw/xyeWRKRLidBt7jh3bq0zZP2hAK5GPTHg1VwJnwQILuIU
	zS7Q35FwahEs/nr7gvTGXCozzdMy3FEv/ZWRIDwhQSlXQSz/nXUeeaLdDWRDumCP02JttAbXktK
	eTuoKDzC2ulZr779EEQJz/fxJGab2mg5PI8P2hHA7nl6jU8bawjZhlFNT3Zxdpz9qP1lDAcJSAe
	G+zs5RqehnT/lPWcgbM9ikv5suLmjs87cDAqjJrEwGQcJOMWNJXsl9OHUF8qQ4VL9tfbVMFDuNY
	sSi8UEwWefhkIo0MhJUUoI/7tkSZ7QRC9fFBaY4zvM6AUbWSN5mXA+YFRt/2/zyXuqrE0Jam67k
	B8sIvyNV6BR3xiUZ0ZlIRUOLOY0b/JBwY2ybHg14wpVIsAvWvqqG+7HmYNzX1oqF8XSrFQAeCAS
	XYalwc9A4GMYnqinmuB3zLpBD0swfOc5fcgTb0bZwm+4dG4Afmzg==
X-Received: by 2002:a05:600c:4595:b0:493:bd67:316 with SMTP id 5b1f17b1804b1-493e1fa35c9mr45147655e9.16.1783461894949;
        Tue, 07 Jul 2026 15:04:54 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f3318dsm78535105e9.3.2026.07.07.15.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:04:54 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	bre@breiti.cc,
	bre@keba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	yong.liang.choong@linux.intel.com
Subject: Re: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on unchanged mode
Date: Wed,  8 Jul 2026 00:04:31 +0200
Message-ID: <20260707220431.108611-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <565c18f3-8b1b-4832-b060-617b7d683eb6@bootlin.com>
References: <565c18f3-8b1b-4832-b060-617b7d683eb6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[breiti.cc:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[breiti.cc:+];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:bre@breiti.cc,m:bre@keba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:yong.liang.choong@linux.intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bre@breiti.cc,netdev@vger.kernel.org];
	DMARC_NA(0.00)[breiti.cc];
	TAGGED_FROM(0.00)[bounces-305600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bre@breiti.cc,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,breiti.cc:from_mime,breiti.cc:dkim,breiti.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BBD271FF83

Hi Maxime,

Thanks for the review, and sorry - my commit message was wrong and
sent you down the wrong path.

> One thing is that now we 'blindly' rely on the bootloader / fw
> having correctly configured the initial interface.

That impression came from my commit message, where I wrote that
"firmware already programs the ModPHY for the configured interface".
That was incorrect: the kernel programs the SerDes rate itself, in
intel_serdes_powerup(), from priv->plat->phy_interface. I'll drop that
claim in v2.

> Maybe instead the serdes interaction logic can be reworked so that
> you query the serdes rate, see if you need to adjust it based on the
> selected interface, and if so you re-configure it ?

That's a good suggestion, and I'll do exactly that in v2. Instead of
comparing the cached priv->plat->phy_interface, it will read the
current lane rate back from SERDES_GCR0 and only run the disruptive PMC
reconfiguration when the rate actually differs from what the selected
interface needs:

  cur_rate = (data & SERDES_RATE_MASK) >> SERDES_RATE_PCIE_SHIFT;
  want_rate = interface == PHY_INTERFACE_MODE_2500BASEX ?
                  SERDES_RATE_PCIE_GEN2 : SERDES_RATE_PCIE_GEN1;
  return cur_rate != want_rate;

The callback selects between the 1G and 2.5G ModPHY programming tables
from the requested interface, and the SerDes lane rate is the
observable state that tells us whether that programming is already
active. intel_mac_finish() applies the selected table to the shared
ModPHY LCPLL through the PMC IPC (intel_set_reg_access()) and then
power-cycles the SerDes, and that power-cycle is what disturbs the
on-die AHCI SATA PHY sharing the ModPHY on Elkhart Lake. Gating on the
actual rate keeps that reprogramming out of the boot path when the
SerDes is already configured correctly, while still handling a genuine
SGMII to 2500BASE-X change at runtime. If the read cannot be completed,
the helper returns true so the reconfiguration runs as before.

One caveat: the read-back covers the SerDes rate bits, which is
the setting relevant to this regression; it does not read back the
full LCPLL DWORD state. I'm keying on the rate because that is what the
initial mac_finish() would re-apply on this path, but if you'd rather
key the decision off something more specific I'm happy to adjust.

Thanks again for the pointer - reading the hardware is clearly the
more robust check.

Markus

