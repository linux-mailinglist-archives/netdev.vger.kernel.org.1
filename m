Return-Path: <netdev+bounces-246784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82CCF12B4
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 18:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A410E3004183
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F798238166;
	Sun,  4 Jan 2026 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C2emQFIg"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA720B7E1
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767548402; cv=none; b=h06v7AQuTalar6RpHercJymM53Oc4bCVyHhAf5g+57yVqsaykkUZmnUsfxD9pGcdu/4ts+cmYXLZGOqW1wJ3WQD3RaaDzrhZzGo85Wlb8GQ3hdh4vfWUnrHWS6VECbfl7asSEqovx/ceCRmpLVJ2hzEC12XX1GA7SFqeQqI+cZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767548402; c=relaxed/simple;
	bh=7y7uc8SsGd5Gxhp6RENJEvWe72fAZOJIRpzUV51VhMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alVOPCymsQwnT1c6aaV4IwF2SGvLp5csXIgb3cED9i80Y/W7h+dJx7dmh1JaaOwr2/8gxkXnIrNqATdhkhRiBHsz/fhcVGSP3KMgatOLDKfMXL8xWqYGrY9c9x8s/iPvojTN5br4qACwRt3W6ZD4vb+g87vQhmxPUBmK7gcD2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=C2emQFIg; arc=none smtp.client-ip=66.163.191.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767548399; bh=TH1JNcRG53WzTMGYaTV48YaEQu6wMn5nOuGAFPDY09M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=C2emQFIgS7tKCSTQLRLeyqqRjzVokTB5ykCOCXeEVKjwukyxJrhI/TDwuNKTBO7O9V4eGjDvyMiEfU1OO6Y/aVeBUTUSyS0HDQvtxsniygvHLTOWV467/Vz5mJo3/dlV6ZoGk2YyKzF7WwuoYEASyvWWfU9N2igagAQqAXolVq8GeM2ozZHIAAYXDLwLaJrcV27jEHAjYAiu7aAuiqTIxvwh+Ds02u2g0pd6mIy8TSOEsmLznuA9s9//5Dm2UXpjLc/chccU3JPp44DcKoERq/DBKRf40sXHrZzrmpK9l3k4u56+TQh7AccTK56ELl5qXf7p8cZSIxC4UFBTE8UOzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767548399; bh=5C9GJE0SpmVynxAht+pT8Nf3yRFMCDwoMFyMk2ZBBEn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HX4zLktluFMLkLZlq589iDwT6uWoAXQpZPAqKmWPrdZ7Or9/aNGBzkrW2nmZAOTZLwMIWHT5dkA3j2QDuD8IpjXOXig3X74sU4/eu5TvvBgBcGqG6iIg510ZSsVMHeLDWeElITbLodTFajJDak3sDOsiz4+6J6Jhaz5ueB3XM8knpe2jTpNhhSQfE/HM6cuPpms6Liv7T7wYRWoPL6FGk2KhCAIBHwu8edeuAtoBX/oOoTtXPZUp60nc9kBf74C7mcGDrSVaL8wScvOK3dI+YpjfKNIcCa3WKsvfPDQw6FTfUkAX/bX3iEC1A9iIFFBNrXkFU2N4+bmBJ0DI7Up3xg==
X-YMail-OSG: mLZbDzcVM1nQxzIlDiiFMJuRapAFMbR6DteWMAz.JOoLDI6BGWI9PW.9GNdgd3N
 tfexZtC3DjbD6IfagSz4JWGtpW9c6rUOSgRSPYhuV9IaxGUny4yVUeBizY6aFavhSeEeWCq7SUxX
 jY.bq5lGM3rVibqqUlEsZNXukATevbp5qVZs3YnZO6lr.LccylALf2b85hNotfyApeiHGwCZDq8w
 lsrj0BG5OkjUG00P5OYu1.idBVn3tOgUte3lEuzqVzLLmPsRNlaA7Ep.6miHfqUM2r_KCgjHgdHl
 4aklg0DWr65CO0CgutU2bUGKYbz4L.2V.zTmW.C_m9l5OTzWehInO9X9xwpfNoAKohgkVyzRN9xQ
 LQu5w7Slt_xR8bMydratcdu5xijAhmveo78j9Aa.s0m0qpXrjrbfDrZhGo9LGnpKydX2QpU07DEY
 jIUnL0.rEO0rkE8aY_feN8iM26Z3oupiRvDkB8xI2cp1mFid.83o.n25wcWuP9yWIYLFYuwbzGNe
 lwdZUxD4GFi_tdIGMt9T6HDO4rOfKyzV8W183.1HP11LVZBwDDJSGdHidmofeqXE7OihcjYUYn1S
 WWmzSPsHBPAdiK46E7sNEn2hB3s.WjVB9eJnf3UZh5B0rl5jfk_qPSXpByT3tf7xcObWJJr3TFO5
 _oo3OFAocPmZxBovz8y7iD5GQH.v1lvor3Oo2zjPvbk2DaINORceVX1j7eMC8mAJDl4FJetjyY70
 Dwn_O.nVw7BK6LzmqEctyCzYOip2qdPABDHkDnHxp0wQgLQr2b1bUjJLaTmIIow4T.KStVTid.Gz
 7TjlBGBkfvkfEfXKdwtEq2H5u86gzrhXR_OT6YmAtHbN.yHVB0FVSkgYGMay.J8HE1.v4XYvmOYW
 yVLEwlvBnWRdDonSppeRRtcWfCv66cSTGjkBW.cGK7VzL9LE1HAv3tx4uQTR0zLt95GE8b1j0ERE
 vMgwmufFu9xfsoMuCq6_vfLUInEisj.iI3_TtAbMgrP8lg4mNApUmu873kaBTcaAzIS.S8zyG.WE
 XytDOSbb8ANGrXxxt7U6yGXYPlYl.WTQoSZ4LkuxjnSaKHQ71LspC5c16ct1.1WBdbldUE9N9sjz
 DdTOP3rHU.ZZbL8AMXI9scufzAt4qDVYYNYe29Orgfb3fgOV7ppampqQQ5enB7sjJaAudJ_SoI64
 a3EQEsgRvUoFV4uFN0jx7IKkFsH7Joi485YwQGuOZH9q6zfyJO.1VY48zQM9I6rrZfFkWWOd5cKp
 SKg9qLoPgtV3cfwgeiGVJqF9i2B.ZABHlVyrLVitp07CMpBgeTGMPEtZA0EYq6x9iF0ZSi6TcR44
 psmyFkIqvw4XqdpMRtoGIvUnQwLFG.EhFqZ2GycTUEahAoeNulQfuXya4MqcrJpIZ3rPIe7Tn9yQ
 zCZDRiyOC0UprKMWFMZdHZP5DgJQyEFKJdH2xa849P8M378EwIwqvn8rxiB86I_0iHImYuwk86a0
 NiwxFmqGnxZ_6Q.HDK5YnK_BF_R7GdPSb09N4l_zu9mCZDBsJ4CpPtAC2.RPMnz0noV5n2e4sF07
 tu64xswGIzQdlsaNy9DdHcCU7.fFk8qMGRODUxTmC24yEXdYIYLnx0Xe0TZflX9rEDwDUvcDc8XG
 LZUbq4Drhmg44vI25r2bML2k95cIf6DP1ke4x91g7KZIKtZgs650gORO_sETCSzYKx0JIxKo55nn
 _7PRlr0d7QV3dxWH43wWpkmIMCyZUMczynlg7idmAITMey_BwSy0_tYsEme_HBW6D4h5.nFDk7xw
 HgCS7DJwIyy7qRx_O03RPM5hwTuyiCz4abKbsICXkqhifFShg5G5ny6Om47wd72UOGMTHJYfPMq0
 CDv9cIgSgawo7k8GC_JojWlGESsVR2kESGXGsJsOSjbhcCQRKkxWwIff_C.NSRUGeryy4MjyRk5S
 VilQ8rEY39Js93md.OZyKf7YdR0qejCwr26eyuujo7h4dU8A8GeWnbtLb7k4ksH2avs.0rw3Lzji
 w_4ajmnP_TcPszicCV_rzROFOKyFDoHj820KlxBxBiSHpgXzdxuh3f2w_aPum0aWUt237zXMrqJf
 i3CQZLCV_udIjh6ZRmTszqp7J8TiD3mRczb5lmqTJj06L4Qj3Sm1gJiK7HKjLGspAOBpPuhrdtqp
 1HrPJPcW0OoT4vT8928J2W7OA8py.gf_0rj8fQOxrgoNVgpZVzN7JZuJB7xJ3I561ieVzQJZxhpw
 eTHiwqMeugN_c.tM8rcMBh3PF2or8GDwQUdKfVZwQwvFmVrXIScVBDLCLVcB0lNo8xE5jCaDrdmQ
 TiQGOUQgBgoU1VcwCxywZygEJfJMi
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 0087bf0d-00f0-4a2f-be82-b1cbd7a95e03
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 4 Jan 2026 17:39:59 +0000
Received: by hermes--production-ir2-7679c5bc-p9m2d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3b97d4d12194b08cffb160ecbcd74830;
          Sun, 04 Jan 2026 17:39:53 +0000 (UTC)
Message-ID: <09c19b60-a795-4640-90b8-656b3bb3c161@yahoo.com>
Date: Sun, 4 Jan 2026 18:39:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5] net: dsa: realtek: rtl8365mb: remove ifOutDiscards from
 rx_packets
To: Jakub Kicinski <kuba@kernel.org>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "olteanv@gmail.com" <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
 <d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
 <20260104073101.2b3a0baa@kernel.org>
 <1bc5c4f0-5cec-4fab-b5ad-5c0ab213ce37@yahoo.com>
 <20260104090132.5b1e676e@kernel.org>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260104090132.5b1e676e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

rx_packets should report the number of frames successfully received:
unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
counter) is incorrect and can undercount RX packets. RX drops are
already reported via rx_dropped (e.g. etherStatsDropEvents), so
there is no need to adjust rx_packets.

This patch removes the subtraction of ifOutDiscards from rx_packets
in rtl8365mb_stats_update().

Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2180,8 +2180,7 @@ static void rtl8365mb_stats_update(struc
 
 	stats->rx_packets = cnt[RTL8365MB_MIB_ifInUcastPkts] +
 			    cnt[RTL8365MB_MIB_ifInMulticastPkts] +
-			    cnt[RTL8365MB_MIB_ifInBroadcastPkts] -
-			    cnt[RTL8365MB_MIB_ifOutDiscards];
+			    cnt[RTL8365MB_MIB_ifInBroadcastPkts];
 
 	stats->tx_packets = cnt[RTL8365MB_MIB_ifOutUcastPkts] +
 			    cnt[RTL8365MB_MIB_ifOutMulticastPkts] +


