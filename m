Return-Path: <netdev+bounces-280471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEGZNEPz6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:11:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 456BA4484EE
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C358E3003994
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431372FD665;
	Wed, 22 Apr 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VfJGIJUr"
X-Original-To: netdev@vger.kernel.org
Received: from sonic310-24.consmr.mail.ne1.yahoo.com (sonic310-24.consmr.mail.ne1.yahoo.com [66.163.186.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FB1A3164
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874141; cv=none; b=ObRXJrxhwnXr0pjt2B/4c/Egpbpuay2TwQ78so2jkzq3fMEbVBghTZOgXTUWnGpDmWycnQOpvEmwdltf340qmCspDqmaMge1MyycYxWuJJN5S+wBwml9mzZ879pFD+fk/lfuZJEmH8PeD+NuHTFyaMIH7wNse0XCTiETZXYUdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874141; c=relaxed/simple;
	bh=8ZvHiRf4z8++p3P+aibZvYTARv7s/QIDad/VcQq9u9A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=FOI8mo93t6uTWJgIJQCq5Y60y1N2xsP4xvDjIgG06Gr+ihkPqT/DWWYB46LSquLwB9wMbBsBov78y0sSXC/TVzMla7nZIgubKo7wvOKKApNtrpjVgBfhONocg7xpMpo8h9n4AT7PcQrAzUeqGMuCSAMAns1l9EZ+tM7KPCjLNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VfJGIJUr; arc=none smtp.client-ip=66.163.186.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776874132; bh=GaCB3dkZrFSDuqe/NVRFFWp4LwsBt1eBcyvZB+LlCj8=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=VfJGIJUrZ5msPAKyR3t8ZHdkXbnJ7S0qOjxvM2DwXS+76tY/R4ig/H2Wv2ORRqANzPWrONfXwjfjIWlCUn8hX75e865QxS9V6EMFNRoo8+WhO20XvNMcKGqIIsfPSoz6ddcllCbNTlh/6gtvg7YvsVlMhade+wk6Quo+s5cQh470cgZyT7N/fWXXKRoqfYbLeIYm823AFWESGWMXRqsaVYMwAJizMK9LbghIIwuMNsWW482lTbricIeJ8k1RDfB0HZrni4HNsi+xJ+uNOoeRGBpGXTH7lTplNNnQsMh4ctqAkvHzOiEaIXNa5owD+kEaz461ok2CkuMNMYzQE6aO7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776874132; bh=IfEhLCH6+JaIcolcSd6uHMJHFzZe2eR9+lPKPRGVhUG=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=KO9g5HWy7FQb1F9hSYVHgo5sMPNccv4BuVFmJbTRejQ2htlzeVJUFWc0ONj3eHdL7kNn+r9GA4LegIb1ZZqRfSQdvXhqz6UMJ8wAbP+6w/WAmJuwmUcSfx/Q0SSDDF9mqrdOsl9SC+Dfys12NDXLpJbsJD27puEJoCtytfl+Q0SH2S1pXG8XlY9Dlvf1fFOXZj/v4XXBIYBOPJ4GapyC4wp6LaMVN0biLl1cGTmGFReuI2DB8jLKhmHap1HiVV9h1aaI1RS/G/BlRJLmi0ZuO5Aq1VUg89TCzFDmwM9l0mhqrqXmb6H1zPE7C2rv7SgkrF01It3khvGgMEAICQvGVw==
X-YMail-OSG: uTMPa3sVM1mX03.SUFXlTrT9_q1cfPyDly2sPXp5D911AdsxkciYA5o9fJZFUyc
 FApOcceH0o0po600oAXlVRaEV17BKI_reMAJ3fWvIzHkgKABY92mNg0CZwvZn2LNsGyFawQccVjK
 j4m_geJjqLGsZGS_knYszI76hnJnfrttGQjyTWolBWu6wJxReJULcJ4Hpht00Y_XoOEw89850J9l
 PIPCfTlG51gJQKzOs4kuVqH8oYgHVNjFY5iJ_NZDYwvRsbeacb_GQHyJQKd2bkhL6I910U9KzuE5
 o6gNcgalqiBAnK9j6xJJI4VoerpWPJiD6VanNIDhxf2HHY.eXJ3LXikl27u.pFGYPAlEzKCza0Jg
 PLgEHJICM1nwLj9uhgYVDgpOgFM3JA34lnLCbmisnHLrXDeS3h_agB8MdhfNKgGnabJggbJ6EGPn
 x1S2A.APgzLdHTzxvSjvacmHCIuMw0WwggtXKNtIle57ha2_IQHoE2sfAl8pg8Kz.gW1_GHnGDg.
 dmNfHjWnda.ipJZUkiFOyCeX2qr_d1tJKZ6LHqmcWDg9xIVZ1Z1BRXwncwPCHqKxS6ejETNq1jji
 HEJDh0Q83vRi8__fSLWjO6L8siFAN0p8b4FpSUeYk2_O3YM0o3jZJZW5uG9vmydHjTTwl3OTSQS0
 zqEh163NInMxdLBrsLYLlnsL62WbYyWPKOu_kY6DoYrrbeJRuYmHs30.xnZDIOWKRfdRKWdWPVF5
 eTTag0K5yYCsaCLUqwqAkMNe3ZvH.XWUV_PZW47xe9TnT4H6drNQsvnD07aZhPnPhF_KbY_MP022
 NlyaO62P4nPqRj5mF_IvFcmLqVG8Pqd4fO1Af0ybL4pTjSL2MO3d0sorEZoL2v_4_Tom.XC9uZ5u
 JECeCVdmjHLQfgRbSQcd9h6t1ACnb17ZFGbJhgFGZHgDR9GFS441CBILFJwDfWV9THp1vTZkZSht
 tPS7mKUBG2ERFqXoi8Q8tipTsmkfy5yCDDswT1bSvys5We0M4ArAxhjpPaJ8VZ_jeAODMFK3uvuw
 Egd21C9CGYmzUArjfRK2Oma0fEvUTzXMDiBnR3xyOlu1HhqY6DPWYTBbg_uU33Xd67MqKCUkT8sy
 NopB7zPfcUo0DrjXJBAvCUSZjGm968tENP.KRvv1OiXsOuMBTY8QmSHLhXJX6yqw0XF6KueWJLps
 O.RM7q7RQGCZdWWqnAHnz83RV_PWumuJwElS2HaWhAWEKR1tv5yGPu0kcWngkYj8AX7o6MYyamUx
 Qg.5Hd6w3lF9O9Dc3y8At.sTGYE66WUoq0m.qYo.fhDFqKIjWSjaHiKaELzqG5E8RY.qu8MCDTZa
 1HYL_8.LszIGBGSorZIkWay5bPECQh7e3pjkm28l5kF.hIND5zGugyAWTNmCukCgEpaAcRfbhxt3
 .6qaJlA1GLJmduLRtJ6eFJCBzVbiLWpq3E1u2HhfIuexdxcnujqKgVekzJAE9UHQADxnqYF5uyhB
 Oh6osR9Fqn0eq1Ifgwu01WTn85yRIIX_fYbeg1UxTCw1xs8GhiFMucvDIWPl8Wkg2AXNOOAv1wMV
 FwF3Hlur.4_d.KXJm6HW.Rq96AAZkyUob6WaJvIYaWc1904KrT9nj_9Wb2Ep8Vyrc_eZiyP5LKTS
 2aHRUdx6PrjlpuNqXKKABhtQHtPjn2mYOBD7tLL1X1IYlOH7L4qyknQkCdXbNcDzh6bu29Jd8WKK
 nzTIZg6UuJZrf9cDhduahN3xzbcys6XbJx064vUscNWlqgpqcw3k4iac5uxbIPdlkoZEI0pPH9mE
 ST1Vuzi_lkNjouA6NvrvGt3gFpUxrcqdRAh4Iqymlvkztm7kRC1yO89ZUrSU0lIU60AaJtmxWLGG
 yGW3ZsJ7lhUpQ_qs2RDuBT2XJjhEMXxSadG71YLbIBFzE.eQQgoijSQ0Z4vQjQS1O6uUTiEZYSiv
 4exZeZBm33qMh68E1Hfx5Jbm16LZWB.oYT.7eCoNSEjkuGbedzGFj_EPVbsMjgtkeAOmkUOS2lK6
 ovK2Y80C9tAm8wsDzaVj2oFNKKjB_7wa1MX4appKeNgHi6g2AYaJ7UcAGDefFdg.3Wpy_A6WjcoY
 Ih5_cnlheUWJsqTIoztjitIkdO39pdcHnP1SkQ0p8TC8A3EU.BdwTo0wmCbEOtV7WmaS2CEh56SM
 WwSoo7G6GP.749aiQhHxD4FoSRvvtXMUqfCYm8AwtOFUSGHNqmricCwdMk8VgNWzxSG1dwTMmQO0
 S8I56HAHq6KzpOnNOf9gY0P.ezC5SkuM2kYMHXGXk.VCcnCOucIV_6VX2jvfShaZrmrYGmObnnY0
 bZJtqX9Y-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 4b7ff493-bf8a-44a2-83e4-f8d164aa6258
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Apr 2026 16:08:52 +0000
Received: by hermes--production-ir2-bbcfb4457-24w5t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12c9d26ec1d4f5f656ef177b8755f686;
          Wed, 22 Apr 2026 15:58:33 +0000 (UTC)
Message-ID: <f5ac420f-0087-4af0-bb43-b9a5b6228fbd@yahoo.com>
Date: Wed, 22 Apr 2026 17:58:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH] net: dsa: realtek: rtl8365mb: add support for RTL8367SB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <f5ac420f-0087-4af0-bb43-b9a5b6228fbd.ref@yahoo.com>
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280471-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[yahoo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 456BA4484EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

