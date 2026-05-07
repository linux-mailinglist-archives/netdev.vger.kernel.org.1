Return-Path: <netdev+bounces-285153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zs/gMK4q/GmYMQAAu9opvQ
	(envelope-from <netdev+bounces-285153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:01:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 338374E3462
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BEA43017BE9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155E2F1FC9;
	Thu,  7 May 2026 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g4FnWQOI"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-20.consmr.mail.ne1.yahoo.com (sonic306-20.consmr.mail.ne1.yahoo.com [66.163.189.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F328313D
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778133674; cv=none; b=S1wV8kdFC5d8ilyIEnXWmkfQIlde0RcZc5wXFCan3mYuANQHK8hw2zz83Tad17m0sR6ulqJtoyy4b4nhiFsMGAUfukciFzVEQKM+8XL/3CEpuYZ96qC951MOMuk97oCHJ17G/4SsopCOVE03OjkvLKOKpO497i0GSk1Sg2IkOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778133674; c=relaxed/simple;
	bh=uDO26NzXRe0w7VaaIgivvtebDqr+B0rKbSXqyVrNtQw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=emdxrhoyfggFblDcKLnIIFA34qVmfXGIYpCqEJdLMurxX1A4QNrPM/kiUaYX0S+8BJmqXfQAZ0zTGgnlolG94KNu8N1YvF2jyvUOAH7RYzT1i/JfWTnEp1+6cSIcqZsVodLCKA45jUvLJnsAvogn5gWcNNNIvV7fRJQQK8j2n7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=g4FnWQOI; arc=none smtp.client-ip=66.163.189.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778133672; bh=1eExD8fXvtg0MiD2e4A+S35UIIDK1vkajP07rKHNXuk=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=g4FnWQOIiVuGb6nhfPgXVnrD/wawBS+bwVUC7jur8K0m/F3wPaqN4WIn0Fc0VwzwSzbWQWDFQMzqfBOaBDtzHNzMAO/UfJpUDnL/GNbMFRzfjMzAej93PcEskDFwMEsnW7Fu2SlUyl+Rch0zBGz2NsOZlCYBLZu45PSMktBHHSTTafJwllwBXECNlV55rZ4C0AZN9SA8zcBIyAPD5F9xfVfkG7RwWpvgzr/NxOdmDyhZiYCtinyhu0o1bcUauBI6rtcu9JuqD+i/GR8ZUfRbSIQ+Z3ezeupfsIGR9x4oQsd9+aCgF8Z00YudwGbCSUzdkVoAsQvDQ1Q9Q9F5WM2ZPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778133672; bh=LXr8HzlAZ+z9xxLQYjh/Ay7hxSAToseoJ1MS00M1yPs=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=Yni/Vfx3qQf4Z6ebBGaBuAs5bL/Z5+9OFXnA2MMDgEBk/hcaqzjKxwYm5wn4Zi237+xoyAjbpSjee4BGdQKPah2iUOy6kP1uUthZCN9vuAONoF3oxrHyl+iNhpm2YpV60cj1l39l8JXTYxVNd94C57uQya2BfoBwp68GiRWuhmlnHfffJD9lxioDm0LOcuzaRRNTLkWyfmKv2u4pP7zeyIdgfwN2GB3S0puCyZGtoYdz9JDZHlRFa6azYq4AssQ8OBel5zwe45X6pafdr3DId2jECtPfC9Kfbi+yqCRCNEyA+51w8FuRRSS+bCiVgeNcsaRXwXjmDczCOXNTXz+Niw==
X-YMail-OSG: rK9k4PIVM1kxEkq_Mm1hLICOO4T.CXvVzqINlpA9jhraBEZKPNbv8dh60m3_.HW
 NeZHaCQB5UYN88Hqp2V1h3C6TjCZBeJQkZ3FZeCnXHCOZapcsb1Yp5CpwVEvaRXRSQNw.kvNMmWH
 o33z_G2hg1ciWWirxPdWamWTUrEBQIeJl3EhrT.sFRasvxgwsbBdn9PclMSR5WuWq_5Fn4q8u5ve
 N_Tj7iKNAmsh1rS.A2W9O1AO6tl9fFQccbG7GdTj_oP3eEqcK3jXgDI1Nroy_hzCEGdQH307a2XR
 Ggp7Z2dyhmcVDPDdXuJ8.zBs1K5tZna8dxuaw3.t3KgSLw6L2z.8Kl7HiNzqHq9TeQfiMeHPr8qx
 VpPzxouM_snPqHk3VgdmuVLOl1uG0rN4BD02n3n6qwHJvDpYHlVtUazDYU48UvWEuw4Zl8CFu7pE
 LD7m.josFroJ9OtE6B.CCzuj2QDW3q3unfTAMdMImjEEFKGFKK4Bun_2nqzKGcmhjDtpxEgtICda
 zOb7hEpXxOkDlBQJfHcyDPO4pyBb6lRvsyFDWVJyZWD88qwdjxLdjU4qP8glW0Y3DrOjC7QAl9iX
 Yp6.Z0Db_GdN8YWYoOCZpOUgA.Gfl.dAeeQOwrS.Olbioh.lR95VvleoFO1RG324VCinhHSJHpkt
 ziX2Cn9MNBn6g2mMZgQ6KpfmrSCUAywr3IBUejgx6penUVGrYmWYr0sqGqi6uSuumadV_BEPaERu
 l7WvWkzY6MzwOHcPNASQtrrP0ZMOlmAm.fX3dDfapWaZvpCzjcVbTbH7pxjWrbhEub0K49PVBP68
 mE0IxrjpiV_WQ.pOn6MRgpjphVJ2RuthEtt68htpp6iz4jw22XRHdQrWhITl9f.Z7_AFRXXzRJSq
 mB9shdSnTyOyFQDuCQjnwfDIg3EtHNgs3cNw.v4nZ2dBEXZw6CBOE.rkiuouQttvdSD7LGEBXQNw
 eVESzJnZxuKeIrekhyL2y4FTOhKM_eJYlgef1vqHepZsQt4NkqMWM._1bEMTSsbMkrwh49AMJeNq
 .YFTNRoKoMk2flvFfUpFExnVUntBO3_gd52gxRQpjI8J2x79cIFBahWoW48bS9vicARmtYBcq4wg
 rj2PrxsiXhhFgBX.J6xNqoVSkbYyKZuQW25iWIN1dt204DSWWdX9m4uh6pBYCzOpmzP6wxxnna2r
 zlGvczBR4pYlORc7MPezwq4OtTRMUC3dE3yH9LcOHp2QWr4U7hD8wRbB5ls4XbbIulTGF4kDh42I
 c1lhS8AKUYMT_1ZiIAh4sEof6J_7kwtCxGRslPXFcLZm4yW0pupMnc.dcmI7yKhFBpAVqa1L5C3H
 upUaPMReLL2Sp1vs2n52bTu9jg69Cq6ADb0nDEKNNNdVp1MAgrzUiXpbOWiAsFQowJaXY1piFL9B
 ikrwbOZYvZDe.SNmSXjtDIpN9wLdWkk1d8GNLfbxt8jX73O1bUfIkeJIWUMQAucT8_e8Q8BzM_Bd
 m3Pu0BaPyPll1mtN9uyFTGO7uqbDjUJb7RqLYZ_SF6nSgPqyf3x8Mlx.ISfu3PqfU7avzq7fV5qo
 0vJF67dxCLFj5KZJif1gVifPDckibvHZ6KfQazzbQHuUYBKkjDj4HOWNi4viJAf1y0BhADy24FpX
 mi4paWtkoHt3G7cot4vGpxlKzhOOnuEiPk4bXpRjXNxKm9ToWAdsYtEzOTv8jTSxMrpMdZl9IBgJ
 jfk1RmHrM6WUoupMYP.u4N6Byub5Bi5Hc_ssZDhnef.V5N_kVWTvIbYeS3gb4sw2naXRCUV_KuBH
 K9AdzoydbwWXfKNKMaURTXpSW8Y4bWiDzQhQijcM0dwXNGS_93Q0DTzIVcgKS3BiKiy_DCnXeQVZ
 4N_H1VueeIBx6uTa4XkwqJmz65IcDWdm3YUUYtazKZU2gwAQz5n6QdwfuCkqaQ.J8qGYN35nYFUN
 apRuSLYa6Fd6Bat4XR.KmeED8Qp.8fSr.tl7GH7.Llud1qUhLnzlm7FAQRUQvMXJzn6G1ofuoUGf
 RBc0ZNvfzLmfd3EnQ74vBeSWd6K6.2EUID79dWDIYqPcPhXxx4frooUWr5GbM8RcquSjPx7bjvVQ
 Dl4OSjDo5L727yuxnwes5vOas.oiNIQ_JDMmyoQx6Kr6rfWH.UpUaLaE6.OldEJeo1e7OB2xyN.L
 5ICnamAGIbZQlcoV_uf6AMcdDMVJH6XhgR.97DYqf9b8Mm46LOc0Zpf1R3tY2DqKj6zxRAIGAwFY
 KGOZveWUyMpEWmGIJd4amJ2TQ8IpDoME9fWiWND1TdBTETSX2rjdJyxP7VzRjrRtK8L_Q8AGBf1B
 Mv0WHbuoOPQSkPyin1ymBl2t72pZt_.w-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 86ba1ad8-339b-47e6-b1bc-118530bd6420
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 May 2026 06:01:12 +0000
Received: by hermes--production-ir2-89844b765-p4qxl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6fae3b7e8c85ce631e8b1256ad265239;
          Thu, 07 May 2026 05:18:38 +0000 (UTC)
Message-ID: <2a52d7a8-3a39-4dd5-a0d5-c746122a9f73@yahoo.com>
Date: Thu, 7 May 2026 07:18:31 +0200
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
Subject: [PATCH v3] net: dsa: realtek: rtl8365mb: add support for RTL8367SB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2a52d7a8-3a39-4dd5-a0d5-c746122a9f73.ref@yahoo.com>
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 338374E3462
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285153-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Add chip info entry for the Realtek RTL8367SB switch. This device has
chip ID 0x6367 and version 0x0010. It exposes two external interfaces:
port 6 supports MII, TMII, RMII, RGMII, SGMII and HSGMII, while port 7
supports MII, TMII, RMII and RGMII. Use the existing 8365MB-VC jam table
for initialization.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 05412c4aa976..6451e8a31452 100644
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -545,6 +545,20 @@ static const struct rtl8365mb_chip_info
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
 	{
+		.name = "RTL8367SB",
+		.chip_id = 0x6367,
+		.chip_ver = 0x0010,
+		.extints = {
+			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) |
+				PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
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

