Return-Path: <netdev+bounces-306015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ITxSM2zfTmqNVwIAu9opvQ
	(envelope-from <netdev+bounces-306015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:38:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 295DC72B37C
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:38:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RelSXqIH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306015-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306015-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C480A3045388
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 23:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473B38B12E;
	Wed,  8 Jul 2026 23:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CF39734D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 23:34:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553673; cv=none; b=fg9jteL2dzx5QjoE58pqLbIjPEYeIVV2+SbJ32EmdEwi2iSZKx7xgQpj6BHR8cHBa/5Dp/3rwPC0mRYRQo3keYLzIUrg8nXrU5y80c50EV/g0ElRzTtbuTZOmzfx9PlxW0wfDTzI0JSEr9Itne8k+Wb8ISBplxWj//woo2/K7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553673; c=relaxed/simple;
	bh=by8a3ZobOJ/8ByTSJnV6u8jfzUou4z6FmlbfwtxeMwo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 In-Reply-To:References; b=oOMOL4NWPaiiZvVV9EXpgaGpkfv4r/YXQucg8fjT0xzyFt5NY3d+Hfmh7TPgZ5Azuqpo09n+tzPJS0z7vI/tNl5ZdRTtjW3kHTLLXoX5x/ilPeAhVmsIWZGl2t1IAUbx1FPziQDDWnQi2sXUUkqnTQfS1YA7oauDije6ucvP1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RelSXqIH; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848595b338cso167458b3a.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783553671; x=1784158471; darn=vger.kernel.org;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcfqpyklPdRJm8BTRultdJ4ZxpQ7NoW5CVhgwgaydYs=;
        b=RelSXqIHUXyAUHZOvTuYL7WqKhJDgG3qJ6Y6xyQ7DqApePnO7c4GMqeElGA0JavG0G
         T3WCWceW6+4a/mL5/HdCwwDst5BfuBXFhivC8CqoSQkuGo4Q0evRYxHfIpFZ5AdIT4VY
         /tz8tZsIA0zIngWGf1o1NY60jj1VBi0xpUA+ritYrOiDvRz9i3z2SWO+6cFDSMHUTQ5p
         0B+FqqZosPixUVmyPm9p0vZHWL5TEdOfn/Sqm79Rl5tSd6gknbeZphGmgvJqe+pSkQUh
         LF6OqRdAnf2v106Qil6kHU0CGeGJgzp8zgN7IEuDiO55eXachTDO3FI29+f8PGCprGxg
         7O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783553671; x=1784158471;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rcfqpyklPdRJm8BTRultdJ4ZxpQ7NoW5CVhgwgaydYs=;
        b=DdyXmf1wAWKWBMV0cYEFpxaxm5Q+4Pe+/9+zCpUddw14oFx3x4It7BcVIMq1ibVUv9
         XFsrRlirdK6ZqP8GuZjjXIPrYB38YRxReCKyzA1shSLptjcq3pkoZjIpnki1cEDEWNkg
         Bf2ro4FLAwLfHw8cFLaR0yiwue4A3LoBpjURQDSMEP1bpA6O8gfx5eGbH50Spneg38am
         12Jh8Jma0395vWtIqFnCuFoo/buOTYR5DW3FoArPCdyo1tmks8fC5+piExfad/DAev6n
         ChVvYbo45EREkDdraH0zmWP1uENyNGFNEUZj3NJ3EZ6ykPNzVlezyLw1+AKtBpLoHc7b
         FFyQ==
X-Gm-Message-State: AOJu0Yy2YE3uB5iQH42OVd3MFrZq1szT1Z+qpxymIqAysfsW+Fh6g3yN
	T6WvO5ZkiHLCxYaR4HDBv456IbFqGGBhlLzE5PcUUsk7mDt690TDN6+QJ0dLFJfhWTE=
X-Gm-Gg: AfdE7cmrlwlxrv38l6Kp5+A5GkEDnJ/SzKnfx8iRgxhsNL3Z18Rw2BPkleDG2Uf5GrU
	ZZPqZhejl2cUZu7DvwHJZuDScHYU0HJ1AmN1jxLOVcilytTmSWQnDSld+v6gQ3hefPw/kyAD+bE
	S4Zq7FXTslKK3ilNLGnZIDF+iLmtF8y24xCIqOhN3EdGP+QnSLhFN7l+IwSpYAK36ceKJWWVWco
	nJTXgJ4UgZTyDTFxqKVXxkYntlotvPCxJPNqUM1DFxP9z1JdpPCkVzoziP9xg/SXC92BD2rC/Yb
	tELg2HnSXNMsanZZpSwP0ICqdnwoRNEe2CRDiQ+x8T+Ci5yKZi50LTL9nxFI4TAxfuBB1vzQdrO
	CWz8V5OcAPcW84pnpUtq22zPyHCQswvWTUg+Mvbq1seIPt629Ekv1uyYZ3QZ9SdOk0s10DiaIP4
	8/0AVNcw==
X-Received: by 2002:a05:6a21:3a85:b0:3c0:9c18:d5ac with SMTP id adf61e73a8af0-3c0bd237362mr5073243637.73.1783553671195;
        Wed, 08 Jul 2026 16:34:31 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3c1f77fsm2927638a12.32.2026.07.08.16.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:34:30 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang <SkyLake.Huang@mediatek.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: phy: mediatek: split Airoha code to dedicated source
Date: Thu, 09 Jul 2026 00:32:00 +0800
Message-ID: <178355366449.113894.1139754683497248912@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260708102341.53919-4-ansuelsmth@gmail.com>
References: <20260708102341.53919-1-ansuelsmth@gmail.com> <20260708102341.53919-4-ansuelsmth@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306015-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:daniel@makrotopia.org,m:dqfext@gmail.com,m:SkyLake.Huang@mediatek.com,m:linux-kernel@vger.kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org,armlinux.org.uk,davemloft.net,makrotopia.org,mediatek.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 295DC72B37C

Hi Christian,

One minor typo in the new Kconfig help text:

In drivers/net/phy/mediatek/Kconfig, the help text for
AIROHA_GE_SOC_PHY has a leftover "d":

    Include support for built-in Ethernet PHYs which are present in
    the AN7581 and AN7583 SoCs. These PHYs d will dynamically
                                            ^
    calibrate during startup.

Should be: "These PHYs will dynamically calibrate during startup."

Otherwise the code split looks clean.

Best,
Wayen


