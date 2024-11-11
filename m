Return-Path: <netdev+bounces-143687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B39C3A06
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DB51C21355
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6004170826;
	Mon, 11 Nov 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KcZu/Ms/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662E13A8F7;
	Mon, 11 Nov 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315026; cv=none; b=vBSo5iNL+e8yyJBpPA1R5ZU6No8p9eUP73Vk43IpSyXY+d2fNQY4ViMOa8ymhzhMxFtUOr6JmPmluoyE49lS+/lfcQ4zXBtwrEXH/HYmiF2jaBgOsPm708knShFTRWRJ9qZfHkqUjXKfMYw0qXQmC/hnzs4Z8KTgsZZqMKOFpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315026; c=relaxed/simple;
	bh=SVgfyvyQTyZIPX9wmYvRf49sg1l4I/UCe9jmDBB5m8s=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=Vw6YgwEEgriO7bhUkayFktmCg93QYfdjaBPlxznJ2YIFYiwG5z4tCo4Wp1D8uciRqFv/TUMTgyoW6TR/YQ9b6Jfgt8UsV/3IGPfLb2K4d1orSVrLMoKfQA8SpzSpqABZru71jUTQcKi7s8nKWXFgu1kS3pOKUJoVGWjckOBTDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KcZu/Ms/; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731315011;
	bh=SVgfyvyQTyZIPX9wmYvRf49sg1l4I/UCe9jmDBB5m8s=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=KcZu/Ms/rLf4nDhXnzfQg9eh+LFtBBukCgYxfkO0XEsS3T9+ArGghW5EQKbVcQLEV
	 XMxWWVjVqkY2xqQkBgRlugY/FdLH+AkaXjwAe9enZX616E/b3XG4KIBH1x/2SnhMsh
	 2JDtZrDziums5gMYj5lwFuTJQSD3Bqx2FUIGiOV0=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: wngOHNE9nD/oFnxaxhBrZOHVSLFe8z+T5PKahwXedpQ=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1731314988t5018863
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>, "=?utf-8?B?YW5kcmV3?=" <andrew@lunn.ch>, "=?utf-8?B?aGthbGx3ZWl0MQ==?=" <hkallweit1@gmail.com>, "=?utf-8?B?bGludXg=?=" <linux@armlinux.org.uk>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>
Cc: "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?Zi5mYWluZWxsaQ==?=" <f.fainelli@gmail.com>, "=?utf-8?B?c2ViYXN0aWFuLmhlc3NlbGJhcnRo?=" <sebastian.hesselbarth@gmail.com>, "=?utf-8?B?bXVndW50aGFudm5t?=" <mugunthanvnm@ti.com>, "=?utf-8?B?Z2VlcnQrcmVuZXNhcw==?=" <geert+renesas@glider.be>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>
Subject: Re:[PATCH] net: phy: fix may not suspend when phy has WoL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 11 Nov 2024 16:49:47 +0800
X-Priority: 3
Message-ID: <tencent_6310D0205C804DD005C7F8AD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
In-Reply-To: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
X-QQ-ReplyHash: 336625114
X-BIZMAIL-ID: 12981089765913251210
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 11 Nov 2024 16:49:50 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OJG2NVWVA7qwljwhc6kUZrqK1jWEz8IwNYOHngC6RBhWGv9WwVK84k2z
	/REjMoGGqu23+9ccutqmwHayXaZCdQtB0DlTBehxB1uKJ/X01kDb8GL7xeu5aLTgZ9pD6x0
	ptu8dq7tpy0dbB8s4q84Duw31tp4zmyy94CDTOKjtrBPnXTU0kLAQybbgz3xrMeX2mrfgCl
	I5M0HlNCWqSP/qxHyCaUAmK0z1ITICPEnIJsKLNfYkg965DhbrkNkzImg9LbMyPI9Lv8YPu
	IxRI2R5NhH1gjWOcKG6gj32cTvr6caO2BedwOKQz+wapCxLS8HK1qetLnEfpiVyaH4zWyJC
	zuinQmp9b9xEgKLgvz1ai004som1Rgw8/CUcbzQPUjLJZ3d2ZCO0v3xUtKtFgbi+o7GRUIY
	pEQ7zhWnM9zLMeNeFd0DGNNUgen+sbF9wtgOA9W/RuOiQSvruiHT8it/PpxR0nEIt5wHdw/
	M13ROhfjFWb6nbW3/EQQXSQpS5X/PESCKYG/UFYre65657zGeCasNZPekm45F9luZm/fpQW
	2UNbUEGWLl2KJN1hgT8cQpj6KrmUpgwkNubyBeTvyTglKEhaXHWBlexZ9bXmywqlsRNXc/b
	42ShIYs8nyTN8iGl+GuFmqi6HwRpyDmYiZwvpqyfkld9gCGW/zvHq7OwQj/70ZjeuzLXzP1
	+fIco4vniewJP70Po2ohmnVnm6umPJx72DqUmTq1Buhh4OzCo5kiKYz5eLCvgJIsCd/jG/Q
	bcR4JXwtUbHCM3pnCxAWZEV6sABiGglkIJLzTLxX7oX6btljSpPu8u/gP5gpSsodZQS+m/U
	AMr0o0BdWASxWhSOcsPRMnm7NHMAXCjTBmOtdjK5eapC/3zemuw5Tr8Osevz8BwWACU1Rgj
	wN1pfEj7O+sfTwo6OQlTqaEUJPMjz290XsPG3tvG/xTSD4lsYlpokcMBeGW+TPOg1EPFFdy
	poOLj93KfNRvXhCiCZQ/C7TCLoLWQqc6TEFL3itTxL7jPpnz6m2FIv1GBCBsyXVsC+MTS9x
	+LPqZBcdVjJkucGYMPflNraf5ef3WcPUWwRt6uHETLYPgo3BBR6hhz6OZtKnh6ypfOjKGoB
	g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

VGhlIGZvbGxvd2luZyBjb21taXQgaXMgYXBwbGllZCBpbiB2Ni4xMi1yYzEgWzFdLGFuZCBk
aXNjdXNzZWQgaW4gbGluayBbMl0uDQoNCkxpbms6DQpbMV06aHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1p
dC8/aD12Ni4xMi1yYzEmaWQ9NGY1MzRiN2YwYzhkMmE5ZWM1NTdmOWM3ZDc3Zjk2ZDI5NTE4
YzY2Ng0KWzJdOmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDYyODA2MDMxOC40
NTg5MjUtMS15b3V3YW5AbmZzY2hpbmEuY29tLw==


