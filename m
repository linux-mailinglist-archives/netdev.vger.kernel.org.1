Return-Path: <netdev+bounces-238978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD9AC61C28
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 21:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1408F24225
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C424169F;
	Sun, 16 Nov 2025 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qbpne3mn"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-22.consmr.mail.ne1.yahoo.com (sonic304-22.consmr.mail.ne1.yahoo.com [66.163.191.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390CA3B7A8
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763323832; cv=none; b=kPgZmrX7JmGh38lH1auV/S+AOSYicuZBZbyZJU5FU9apqY/pT8a//AKh3+EMG+9mg34+QAjDPgIxmXeLp6KtJvCgixfR662vcY0GylnGZRYO2lPp8uA5OoMyUc0oocHRi+5pvXbXcfM1e3NAkPC0lGi7s48jziGvAmXhZtETDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763323832; c=relaxed/simple;
	bh=0ug5ufT/t2G7HuM/Fn+T4cX7IOGu0QeyxeU+/BpMOJ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oKhepM8GcK81VK2wSsX3fVAibntEklQkNcQV59+q4Dv5k3THN5wYNQ3DwHgUabao1uqtgWQdEKy2E/XyC8ZltF5ny3dpHThTbrIrrkzw7F5rSE7pCqELXMB+3Z3ofrMGDY2mR4IsgQTHthIEbqI8lVBU3ogUnhSJ1/OHwCtmUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qbpne3mn; arc=none smtp.client-ip=66.163.191.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763323829; bh=0ug5ufT/t2G7HuM/Fn+T4cX7IOGu0QeyxeU+/BpMOJ0=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=qbpne3mnZY+F1YopSMzMCxWfatIaSCux9v+87QDy+yxgy1p8xX/jRukKE3aHs3MePTs6PE7OCHerlvXkJaV3f1mGYx3IeixLS4QyGYwr3MWxbp4NmWcRTzg3b6XvGlK2elSqvIFjAnFYPG0hv6dfAksraWOLNyjclbFOaoyrs02ATkkZzPXR6lqu2EO5H1CAm3aLviUP1pKdqE2gW1iOwxNauhnhTwZpreltuAwQ4CvWgRgV2iXvdKLWq1VNTeCXhxBRxtnpPnMYNfhzMA4jDkR+Z5qv61OGSYI1IQdLq6VtCToR3WwT3aS6FlbmVNPSy+fXDqSpi1vVvX96R/Y7vw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763323829; bh=TnscNVtEomcAuI4WP06WSN3q7NRNz6TqZGAVwEKYGp/=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=MQIZJSnDm5Y3mpU0Vd1sV+bYiNE5bWfLp0yCJ7/s2Hzdt2FWipaPQton0NhrHyaMkCV07UTOhSQxtXmjI/BshpGsFOBtg0zzTAQLPGqf7tGJy7z27yc0y4CywLufKGAqpN5qAm/svtAUKg1hrkDB5//JcY1jDicQ4y64JSqJjOjBOQYc1gDGgJ0pmIJfp//7r08DOJEbsx7PxRyr6LaXABvrQqMt7hyLV3zYDBolhX/q0zEcS/4Tf1bxjWl82sEM4V3rZGMDr4pJVHNK8IbWI7YpmJm8+Qa/kMfcBb8kh2HFt5zuotPT4B/bWZabQJE30OBjH4Thl4mL6S3hP1swkw==
X-YMail-OSG: LJHohl4VM1mcfzqpZ5yBfHx2ulIuFzTqVjEZn14Dtdnf3wGSRUFLlnYdamoJQoA
 rm9115bRleJw.S6lLnxEGPskHrzGhj._kI27FhMw34HbFZ0KdrRzgXeY9q91KSuP4_uqHtXMtwJT
 gVjLwvjEF.U7PTrDdaap_3PspPQNc.Fdpc2ECJ7NBqIOPO89kgW7lAnVs9tUDgCkel802VwqfkPG
 aZ6DhBS.59Ox3SKOLOW2sZ6K6S09Izvwz8778S1LzflrgRsAPFZN3GGJzpq0BtGL9Qt1Pmkbrsp4
 BKZjGWdzznBzQkOgypUfrkI8.QfzXiI1AHKFYGqvWLnMyqHy5_ppyL43jawW7e_Ra8BtgBkuSqCe
 nNK5GZ0PMz7t2dP1RmIZRqvkZ2JdnyqYdLcIePIaqLQkzMVdYrvn3wiDy3KJ_NV94OSjBKOVBZ1u
 RdZK3gFuRNVjnqI4xrdcrjaWnkYLeZHhOpYC2zaQVt9HrrpNUbD2IiBTuBsMktamPv6uaIUvAHHy
 5ZEgCy8006ghyKZL7S._S8_J8cU4kpFChJ40vi_A2ytmBhByEdS2UUyBYv1L5iMWfAolXxs4THt.
 eeKTF6N.LIYRrDbZvN2S9OMFpHoHl_5927SBeMoFWtN_WgBq85VOrWb5Jbgq5fYTDAT9jbIDhAd1
 PWrMR69EmWXXjCSPLr3nCq7PZUGwZNHhqGIYwDu_RQOoTggFklFKawOqRywJpQFU5tkjcIUSSx35
 Zbia50pp3rtjJam24iUZDnOLzytTCBNYq852KcAHxqPrZzesR4wF6VuKnLX_bF8Ltfwl1LlJOuxN
 ILI_2AHkLcOMDLIGQv2O7JOOPC3X1JozoslPnWuU0KwnOIolpYprfBdE4vUGPL9C.S_ivKCYy89v
 UEzv0udWB1QdKYCUB1xGnOCDP4JJda10_Rg6a6erFua6vJwUie9Zg1IanWTPTnVB2yBTsK2li5os
 p8dObcH.wgEz7dfMrnPSCFSSriSnLr2iiwvX2dGoomndeOTsL3ZanbqyJ7AqGiWdxcBeu5TofSLF
 PDuA2l5bQSs0my4SmNQ3Y8xFQ_0_F95aoWo_CFmrm8B8EZPNclw5OUXoBBGX8W2XHYY_fTBreHZY
 MzwLSHGu3u0dTBTrJpGiPHm1Z3whJGHtLX1JuhD3WI56LdwMpJj3cYpoIFl4QMYsqrSpg7Lj.BZo
 QeUY_e966_c6EJxnSfkz.J4tpUPEgbx7g7FSujVE4cGJMhf6A9wOrrAPdmna5I61vJe8cp_noa5Y
 tZhi_XiktOeen1TEDJR3duImKAP3l46C_ltpgflz9lg_MuUADlLV6Pj6pG0OtE_F9fOLJ2njK5xU
 _9VMyNfHbHwczwaKRgC.33lhFjdZZQHI0Buce7NYoFaA_tyKqT_Y3xUJeu3lvluy06ZtuZGDJsCv
 O9E7LsCaWee_ZnQ0KmawJuTbVEyZHUQQwaJ9.kNufgE1PbogGNMXGFkAl32QA_6.2lrITfFfR1TL
 jMtpCMQ5BPZ357IIHJUestXzzDlPtQLBGWUIUsddIrV2dU_sWW0HsMuN1lil_sefyB6pPm1oDxlz
 UFdDhrmRVfLQ_4FIvlLISVmiMQJs6jjFgEDrSPGWS4WnFvxoFrEuualE0aazhpTPc6XIFNmXAT1o
 DUbuDw3v8Jzpnc0itRDZsC3w1bdxrmqloL3CppiAgoEweIBY.r2gCe6Mtnk8MV9k9Sm3jI94Ozvt
 JeZIB6nL39EPvD4NpYP3I6izafKBeFzil909E7k4STneQTyWzpx4LnI.hS_QHIUt8CT_Pcdb6G75
 hA90KAUzZgZyz2ye5YwFRzY29ZkBe4oEGqcVEMJl69.6zc0rj1W2dfzmQQPdLdc.Gz_qtz1DwgVr
 .vCPrRV_WkUAoTmwCGThYJluqilITLLNVNOSa9Vbdde3BHpB9Dt2194ARpEGU_DN5FhVm.0liUqQ
 ilbFySzhKxiEeNZY0N3pSplp12lB_5agCYpLMVveAmt77yhOnsdnXPjNsfpqcFD.iV8dp3yxw5PK
 6E1Q4HbAACVChjrsXxr6acyWFauLWFPdnGiDS2hn5oYSxH1ocABGX2CD9QB4mNwnZlduWrljomf3
 eIcvwcSFPkyieyL_Mdh2_4nbyhwly3UCYDuwRn_V.vfXgq8C2ztY4ODRCK4o3HPEhwakIDlTteV_
 ejEDeFVFpu4v08RR8zYU9lI66mcoVxrgwZLcaCGiF6VgbWnRPrErL84fjkV21XieK9px7aQKK1Vm
 zerB6huRKG4RsnadKhNagsJPwTXKZjpRYfRVZYkOBy.brD8Ir9p68NA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e782e601-5a69-46bc-84d5-ce5cfd0d5164
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 16 Nov 2025 20:10:29 +0000
Date: Sun, 16 Nov 2025 20:09:40 +0000 (UTC)
From: Mietek N <namiltd@yahoo.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"davem@davemloft.net" <davem@davemloft.net>
Message-ID: <546988473.8766254.1763323780441@mail.yahoo.com>
In-Reply-To: <1c0ee3d4-2b24-48ea-b34f-b5653abe11d4@lunn.ch>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com> <2114795695.8721689.1763312184906@mail.yahoo.com> <234545199.8734622.1763313511799@mail.yahoo.com> <1c0ee3d4-2b24-48ea-b34f-b5653abe11d4@lunn.ch>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: fix return value in
 rtl8365mb_phy_ocp_write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.24652 YMailNorrin

[PATCH v4] net: dsa: realtek: rtl8365mb: fix return value in rtl8365mb_phy_=
ocp_write

Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
occurs during register access. This patch fixes the return value to
propagate the actual error code from regmap operations.

Fixes: 2796728460b822d549841e0341752b263dc265c4 ("net: dsa: realtek: rtl836=
5mb: serialize indirect PHY register access")
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/=
rtl8365mb.c
index 964a56e..d06b384 100644

--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -769,7 +769,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv =
*priv, int phy,
=C2=A0out:
=C2=A0 =C2=A0 rtl83xx_unlock(priv);
=C2=A0
-=C2=A0 =C2=A0 return 0;
+=C2=A0 =C2=A0 return ret;
=C2=A0}
=C2=A0
=C2=A0static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int=
 regnum)
--
2.43.0


