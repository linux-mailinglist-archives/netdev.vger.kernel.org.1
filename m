Return-Path: <netdev+bounces-284454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN0kDroG+mkEIgMAu9opvQ
	(envelope-from <netdev+bounces-284454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:03:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8836B4CFE21
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3BD630477F4
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716842317B;
	Tue,  5 May 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="E+8bQDAu"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-56.consmr.mail.ne1.yahoo.com (sonic308-56.consmr.mail.ne1.yahoo.com [66.163.187.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E113E868E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993200; cv=none; b=X9mN2ryGNu7sqwvDN2ffr7UxGxfL6/l7DJEyxmnZXClhDzJtt6cQsxEAQ3p7IXcJcbRJQO6aJwfTVSARnc87d/gHvDLd7MJ4T81KU1m0v0RHBzNttrkHBF+faQBg5g5BB+fS2NSdfgIDQ1FQ+fV8EdItypHDi7Av5KYNgDE37nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993200; c=relaxed/simple;
	bh=8ZvHiRf4z8++p3P+aibZvYTARv7s/QIDad/VcQq9u9A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=FHAxHJc8O9LHuczJRrVMlhA6pHUktSx3KXWa2NRlngCxGXtN0JkUD0jhQa2KEX57KXUXsu1B6Yz5svMFbsIUXeONnXOxzpBIek/qRZMKUdXeu1KYEmv5FERk4NjF+EWqJ61bszygans/2uujxN/cxO1seFnQUbhnuNlzCKK/Obc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=E+8bQDAu; arc=none smtp.client-ip=66.163.187.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777993198; bh=GaCB3dkZrFSDuqe/NVRFFWp4LwsBt1eBcyvZB+LlCj8=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=E+8bQDAupgf2Y5kxUUsVaVmmR1O5x912iGPzGYxGJcuczPGwywCUMd3ukAgFpXHNRJSSjwaYqo6KYmjD1ZJ2RbbCD3WnZGr4aMcbh53AgR7m3sBQJFpnmGuirquo5nq4Ikqb8V2VZeSd8tu5McC3Bu9L7YP7adltEBHIouWrEz835Gsc+aNbH/6BzTcRUpb6gEDF7bAR7n72FqNZKH2G3NdokM0zOLqcEtiUdmiDphEnnK6FufqoKg0vlHpRKRlhmdj0COK42XNl68D7jBxu8D/o7TcUSfNzTmBel5e3r8cA4L8m88SaHbk8jXdUI/NzdprOAmjrfN1eerGVzrgo4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777993198; bh=UBrtZ7nnrUr2vctV8fcau/2SncT/VMtJ9Yd7tV4ZNVh=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=Kpv8EURg0JW1bJNQgt/RcITAf2Vico7Bl1QMy3FvUY3Euohj0gtEQ7DmjBhPb5V0DgqPowQdgTNGyHhBAU7gTQVqn7DEK6WkBpd04vqjSdBWRUbpIzhAkCi4qH8lrQfV6cvnpNihL9PB/Ilz18urX2TBoggexNdE63cEmAwy6m9t71hmpJjuqxoO5IKWivA+QpJzrv3QRW8CCvbyE1eSCLfYAsGLPVE8J9AKPipTFv57r77CSrkurqD6fIwxCeWY2loKwqRI1rVeAji29mF/D1Is3we6bHG0NaRT2+dM/nxCKJsuWEc0bPFWlpWtx1R2u/jEfye4qXzUTX7KEJlFGw==
X-YMail-OSG: 7YOYRpgVM1lfEUv6n02KljxHjADMr9yKxJjJnIQCFT8iJBQ1J.dM4a0yDemC5Un
 Ny6KJGY1u_03tR2OB6Kg31UCDZQRrT.pLbZG_YELypiuWceXiiUl84SzLc16N56s_Ox08Laqy_tP
 VSvwYaTSUe2J3YejAAQ8my_P6ivbjIfL7rUSP3f0XmHm.gr_6.ta2jr3aQOHpcjp1JyFVXl45TEA
 2f9v9XMN98HpxhPkshZpUX5c44ySkp7ic8Xj7fDbjauTb2kNj8lCvFAHGFtkqpI.2EPay4zF0K5X
 O9r9NSwhopmJblBVm3YpjdcnRsDQyJJ1r4vJbWEhnIN7JPvXpMHaIpa.x5ZEFO9QaAN6YiRnU5wP
 n9KpgfYGeplhnEHoTkQ2RYBvdgg9nwdapz2a6QahtCvb5OJv9NBU7LoEMMTfjToD.xZVLvolySQY
 Vd2.dUT4Wz3Ayqop.jpsZCbsPnnotJTuNpu1uxFU81F8QAQo4PlMKPbmR2M0jmYdBSSZcituiL4F
 AQ45LjjG5bECQx6tHUSvCVBdHrURZK6fb5rlor2HbvPyQpKk0fOPzZiVamhSmXJktHM.g_Cp1Ws1
 ohFyDuNvC59lrjcjfxBlftFuik9ug7UE81nEAEDbNNVbRt5jrIw8sKvgCYIOMGsXlPC2aj8r.z9Z
 dOoQpyYmwtZOVjXBFNTT3y0pFogH8UakPPm56rux_i.Q9ULFdVoqrHFE.ITvf4Zsg24zJ4rTkvqV
 cKzouk9u7Wj1PSlWB9j8viaUs1ks71yt_t8BEqoFeBhXLvS5YxYG1KPjoML5uLJR8V5kM4zIaMOk
 pK_NWUGOJPRLGjONqYeJ.nvyA3pQY6Dkvy6hty4qA6NseFFvOSOrCzyVwB95R4lWer4naTGNS9Bo
 SvmquPj.kxdHE.HNfd_y55SvVRkZhN.1_AaJ0_NDycrg_Q.AC1dRvlbrVwj7sWbCl2uwcwIlqUaI
 H3oRYF7QuAp2HhKwe9BWF8nnB6EZMEpXqfZCvhsD9P0OIyc30Jm2BsP.76tJ9eUN4.TSLmukaT0l
 cVlvYFw6OUzJ46paXNvJvAKM6.4ZEuCQhqQxnVP4of1Q_AveD1GoR.33XGfJS_gIExhAsdKWjMDw
 GNij3W2zz895ndoX0nYMKzzGNM6fQDM828sSAMCeu8Sl1jPMTmvpneQK0g.y2OrEmaIjbb1hjrup
 6RMvCpyXz1Oybu3R3xUYlwi7p64D4y8cC48Yp0kmtBp7ww17irtzD7BNXgbqnLsKXjeBvkVYKfBK
 Yx1MmEI..Vt6Y4nn2iYt35B9Pr6Xjj.78vvroEMgC78RLDM3Rwzocu9ybERTP4pq_p90v7KPPnAH
 9tgWiTvLomu5MtUUOVQhzstU1E4UUyXdqVSdYrMZAWar7HwwZlfkn5qamSY5nGdy60GqyKlJ0J53
 Fda9lABqccZCNUVyJxdFHQfuPgQQIb.ClskX4rne2oP70ROqKzPkA.Hb..sSXB7ZoDRpU5k7.0iQ
 nTrcPnSfeqeWPdgcqF.fcAWVwDmbv1YrZk7GlSzDGeeJ4PYobuspND7T9Q1qHp5LxV00vkbLBrnc
 vn8fuCiCIJaI2UejdDwcuRYULey31YReaXGSwEKegkhsXlAksRpZIc0LDypt7DwY.6lq9SNK0Qj6
 95ojRMJ2vN7miAamVYLKDQmkSdJFMIxyeZj1qBYE9gP.pdDlTzuLqtmK5gCbXxGbr6TgiY3pfYV9
 pMuNUH8KXrIen7GyRV1xsirYLmWrfTTpV0nWRgkQ1rsF.XK_xu_osnPTttP1Hpw0hpiObVr6fyvE
 xiOeIBit4Wf5zZ7DvgdjR9IJuHQg1toALZKh8utXHr8fesdxTIPiaF10_t9R6OpScVVY37TxCmfJ
 jrI119BlGdUHT6uRH7i8RWRLvBQyVlu333.fzsMWoqmNss0yua88btg608Y6DETDB5qRU7w58WMS
 jgQsH_vkWqEz3TNxuf3s6QMAw7adGgLtA4xeI51bn8dJojqACJp9ET2g_DX0MKU9BjZCUgY9s5jc
 bs3TPqwVIdReIMHhe2hReKfAcB69HRGk3I0_GdT2Jgg8f1c7m7mCVeMMzxSz_vUstRHcYwKt.Bbh
 _nI1XsuhwicHn4Q5N1RHSWckvqziXouWDfOyRhVeAcScRac.G0OHI_.ChG.UZMCl2kb0X5rbKjML
 UHRLT5OaagMVpFhnRCcsCsjjMeBiLRuU4hEjLZjWPOcGtrfPoMs942mNQnoF3BCMmuqV1vUtAxW_
 B3Q..5XITuzStpnKiSw87yz1I1UUaJkr4MhXjlqO1AmA5xX1SzC2PXjPhmj7yH3Tyd9L.9iWp8Rk
 yqIaHQsW7zbwVPo6DWVxfxAh8
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c7639cf0-ab2d-4378-94ea-92c2562fe143
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 5 May 2026 14:59:58 +0000
Received: by hermes--production-ir2-89844b765-6g7zf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8cc2601c87302dd76303eb395609c9f4;
          Tue, 05 May 2026 14:17:22 +0000 (UTC)
Message-ID: <05921e1f-693b-4322-a762-c8f03c386a78@yahoo.com>
Date: Tue, 5 May 2026 16:17:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH v2] net: dsa: realtek: rtl8365mb: add support for RTL8367SB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <05921e1f-693b-4322-a762-c8f03c386a78.ref@yahoo.com>
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 8836B4CFE21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284454-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add chip info entry for the Realtek RTL8367SB switch. This device has
chip ID 0x6367 and version 0x0010. It exposes two external interfaces:
port 6 supports SGMII and HSGMII, while port 7 supports MII, TMII,
RMII and RGMII. Use the existing 8365MB-VC jam table for initialization.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 073f12ca8028..84d6fdb94a96 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -545,6 +545,18 @@ static const struct rtl8365mb_chip_info
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
 	{
+		.name = "RTL8367SB",
+		.chip_id = 0x6367,
+		.chip_ver = 0x0010,
+		.extints = {
+			{ 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
+			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) },
+		},
+		.jam_table = rtl8365mb_init_jam_8365mb_vc,
+		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+	},
+	{
 		.name = "RTL8367RB-VB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0020,
-- 
2.53.0

