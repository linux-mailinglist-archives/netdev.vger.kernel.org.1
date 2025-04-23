Return-Path: <netdev+bounces-184987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ACCA97FED
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476433AEC07
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2CA265613;
	Wed, 23 Apr 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="rRvB7UGL"
X-Original-To: netdev@vger.kernel.org
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AE264602;
	Wed, 23 Apr 2025 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391501; cv=pass; b=l18hu/WHfafxYEQDwvA1o+NdUMjE/b/i//UzXBqWvLffu74yfjYaaDRU7tH61/AjoJBgnGpoPmmQzTZIDfGP8s6Lip+Kq+8xKiMQYYtSOoXJEZnL9AnXYMxKT7iBXuGHmQBkZ2dy5n8zDe9eufQqoxZG91pHGwY/pRaaSDqhT7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391501; c=relaxed/simple;
	bh=9Pv/UqOlGAz6M6uYoscsoU17c6hsgoL6aNA1kJI82qs=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Date; b=pQE/Ta7rkcSJ16ciQgvaggtRHIg77T3jk5OE0+d8eg97hjcAV0rq4owQjYLjeVjeXfrQO2ThZV2GItSyZ+Il6vUGwozyJZz9qJ7sVDS6L727c4qKVUWZNxnqM1CBOC+YM/6SB2aVuIxNPYeaYrzlxmEh2lTbHgRRGi7SGwr3/70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=rRvB7UGL; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8F84B8439E0;
	Wed, 23 Apr 2025 06:50:25 +0000 (UTC)
Received: from fr-int-smtpout9.hostinger.io (trex-9.trex.outbound.svc.cluster.local [100.113.64.21])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 853AD8454F4;
	Wed, 23 Apr 2025 06:50:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745391025; a=rsa-sha256;
	cv=none;
	b=qb188cWjCtdZiVZpRIaoNuQW3H0UKtf7otGdFXrbvLzX9aoJPDUeTZU9aTZdydp2u7q/22
	xGa2ZIUDQAcdI/TqYrrZmAvqHXPIpgBSgH4MZVyE+QjQsoBJ+DtOMS3KwxWymZMa3UDk/g
	ukMnxM0q7kPB0Ibm5SLS8X7bHfgB5zLqB9shoMnOyrSkCP24iy6a6yr/I8HC/iw6ShT/Ex
	U5+hlUxiA0CI5ojAWeC5O5hROuKHLpKs7BE/CBf96XgzJy9epJFwC3uE1ZXIqGhE2dQhRZ
	flgctoRv7vvSxJUgvf+2c9oBb/TKSoN3hJyVIWtpEfaupoS+yO6lfXxYu0xy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745391025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9Pv/UqOlGAz6M6uYoscsoU17c6hsgoL6aNA1kJI82qs=;
	b=axu470fjexr5bBgpmPZCQ2/FBnMxiy0wl7SLsnALI/P/egdVmRWUKd99dKA0WDabNZiyFx
	r6sncISV6RL7ej5JUUv1O/vqLC1QGhX4emtL97N6ZMFeSrLtcMdLlEszq/8jjoXYpcBH+u
	eXGflSWVo7WrbTeMcydps5giED9lvdwPlINjFU4MJvRbOVBR0vQO+ckn7hjfESpyDL7ysv
	fRWA/ZwV4n07I5NfKZIO92egYRZkH/N7Cy/uzrYdi6wIe31BPoV5UQ4B/ug/hR13YM8eQK
	bxBjPQtXfyRbUVyRyfdrOZKGm/g216jKAl4JmjQLIsvZhLtjXoFl5MjIfs0wBQ==
ARC-Authentication-Results: i=1;
	rspamd-5cfcf5665-kj6cg;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Madly-Rock: 5ce5863d4316f6a1_1745391025410_3471300557
X-MC-Loop-Signature: 1745391025409:59469947
X-MC-Ingress-Time: 1745391025409
Received: from fr-int-smtpout9.hostinger.io (fr-int-smtpout9.hostinger.io
 [89.116.146.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.64.21 (trex/7.0.3);
	Wed, 23 Apr 2025 06:50:25 +0000
Received: from [127.0.0.1] (unknown [82.165.193.131])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4Zj8qv5Zy7zH9gKF;
	Wed, 23 Apr 2025 06:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1745391020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Pv/UqOlGAz6M6uYoscsoU17c6hsgoL6aNA1kJI82qs=;
	b=rRvB7UGLlhnr2BbHcKSDyclrFwluPsInB4qipbV+vlBsPug9CFdnHftTOskq2E/dCz2xUp
	AcLog4x5bbhEaidnEpJdHReYT5zNwyBRIQbAwZnC1VYkjQUSPC136hBUFskj0dKs4Us7gx
	ozVSucH4wd/TpmTrkeu6wM0CDc9oi5P2nsNy1xxxv8VN4kz5pb83jTx5ohx1sI2tNDpvQX
	FyRIWOa8FOKrneq42GIaa735xlx05dCACwg72o0LfCXWYtmOCYEZ+qCltD14Mvt9T3k0cq
	P9A1Y3GxWaeFOQdQ0WU7vNeGo9Ts62fghjqPtPWJxJmR/BhPzCguHzPo31M6lQ==
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Neal Yen <neal.yen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net=5D_net=3A_dsa=3A_mt7530=3A_sync_dr?=
 =?US-ASCII?Q?iver-specific_behavior_of_MT7531_variants?=
User-Agent: Thunderbird for Android
In-Reply-To: <89ed7ec6d4fa0395ac53ad2809742bb1ce61ed12.1745290867.git.daniel@makrotopia.org>
References: <89ed7ec6d4fa0395ac53ad2809742bb1ce61ed12.1745290867.git.daniel@makrotopia.org>
Message-ID: <F9390C07-3C4F-47FD-A89F-FB5A90D38A84@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Apr 2025 06:50:19 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Vv1xAP2n c=0 sm=1 tr=0 ts=68088dac p=VT4XjZGOAAAA:8 a=TIbRxBwJK3FFcHPSi+5Ynw==:117 a=TIbRxBwJK3FFcHPSi+5Ynw==:17 a=IkcTkHD0fZMA:10 a=puQWGBksFvoA:10 a=mpaa-ttXAAAA:8
X-CM-Envelope: MS4xfF7jBa0YSLhlk6TV6ePe0WqoEsEHXS/cCyxaL7CiN4ZJkDGyZ+GqpqGiK5D+idyg+8D8/oDxxYUsTDDfLVfPAJS+bN6nhtEqFUDRvS7JSJujUR6lyArD umz16IOW50tygTML3dnxJ/Ax9NSrfrkKHctd+ZAXuDTP6A+pbEamzCG8T7CJxcIW2QfGEdWvL9FIkMfJSkzpbHmf4W5kcxkqMr12YPKtnSnFUZrzYtrNRGK1 X8cbF+cP/MOjv0UfEDkG9c5yuU1qIJluG86fbzi9kZ6GfO0McKSWn8FSWNwgYw2ziPbaDJmzHIFf0UVaQzJ8ADXCKBk9tPCCWIFbSW+2ui6M3qfgzZrBVfDq xMoH6IQHrW5wt8uT8dakwQ7OhBTXGB8LP2DK43Fo5DKcT/IimXk16yutnIQ6Vry5FxKsU1AzNjXZWwRoEpxEsvuK6MhTVrT7l9C60DUwrbyu7qSAhaeGooQi X3w11FSs70oyJHslOoksrjK0AR2BptQDW5j+LrWsU+jg9NivyRf21mIroMbMQ+NV+VdKmHdKt+kIKbgseAYtZlsLaVm8u2KQBtsfblT74ZT+sCLXehykNvpK JceIUJKaPv0SGPjKQbsHQS7TktJrHIK22G+QOng0ZCWYiZ2hiJkuj0ho/h5vOzWt2L+fl9+UZ3RuD8e1mcLBgOdu+XnoQaLl+aehny0T/1WsKyb+OtZ1Fwor EwWeHCjocX5uSJ352MjgzzdoNkd1IOez
X-AuthUser: chester.a.unal@arinc9.com

On 22 April 2025 06:10:20 GMT+03:00, Daniel Golle <daniel@makrotopia=2Eorg>=
 wrote:
>MT7531 standalone and MMIO variants found in MT7988 and EN7581 share
>most basic properties=2E Despite that, assisted_learning_on_cpu_port and
>mtu_enforcement_ingress were only applied for MT7531 but not for MT7988
>or EN7581, causing the expected issues on MMIO devices=2E
>
>Apply both settings equally also for MT7988 and EN7581 by moving both
>assignments form mt7531_setup() to mt7531_setup_common()=2E
>
>This fixes unwanted flooding of packets due to unknown unicast
>during DA lookup, as well as issues with heterogenous MTU settings=2E
>
>Fixes: 7f54cc9772ce ("net: dsa: mt7530: split-off common parts from mt753=
1_setup")
>Signed-off-by: Daniel Golle <daniel@makrotopia=2Eorg>
>---
>See also https://git01=2Emediatek=2Ecom/plugins/gitiles/openwrt/feeds/mtk=
-openwrt-feeds/+/b4204fb062d60ac57791c90a11d05cf75269dcbd

Reviewed-by: Chester A=2E Unal <chester=2Ea=2Eunal@arinc9=2Ecom>

Chester A=2E

