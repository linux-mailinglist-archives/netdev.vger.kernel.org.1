Return-Path: <netdev+bounces-246942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1014ACF28A3
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D65DD3047192
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813BA328273;
	Mon,  5 Jan 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="it6Trsk+"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-56.consmr.mail.ne1.yahoo.com (sonic308-56.consmr.mail.ne1.yahoo.com [66.163.187.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8EC27FD71
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603130; cv=none; b=PQ/1xeqJeJKwFie7GAc982Y6/VdWbEwHi+WrHjitHtJjZJHB3m3vaUrPRQKlBMMreGXkqRduQSqCSqpphwaemLScdJT+RLyWRybxCBzLyyCIuXUTTDnjFWt5UDshcZcmRm2r5WJHGff/Yd8tZk3wgaJolV5lU50vFQlCB2fQp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603130; c=relaxed/simple;
	bh=Cw/FMlTXarZtVteX088sR40Fwtw2M01Wiec8Jert3vs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=VPMJxZJQ/7jVouhKJw+v8/S4dAWEfz3GRar1yRL7tIIhQkRlmAjpQKs9ka8u6p10QlBDtQWa7tCEPlCf2aB6kDFq+HLJ1ilwNKZNyO8OLnfxrRRdedjV2L1fK7kafGr1qJ8gFxHxalhGrPby6nfZ1+E5C7Qdabf1XIILUE+sNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=it6Trsk+; arc=none smtp.client-ip=66.163.187.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767603125; bh=I4puilb+/0igPZuVWPCQlp1Zx2e6vsKB5MfRvGN3pgg=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=it6Trsk+SZogd7YCHLghemqP85qpTLLSTTTC4k8qqQ7a8jN+FZ4jpUIvqTfWEVyMwUZuPUPEmOlMuy2vWHaPSjpBcNPgDl3lHouTcFlrH85aypfl0a5v6gUYEE0blXs+YobUsgiJfKP798TCP8A7ZvzJWK33XOqmV1vTxtFnHjngELvFFNcm41DDrohXEBW9QE2/MLGciJIRaRpbV4gnFYyEOV5kG8jpYSmhI1e6PXHJP27TOXUdN9sGp+8WReLVt46rJ7KwfD6DCC2wOrCJmoRDUlAkp3hrNJw6JmN5GeH6l1QtUL6ZfDDib5QHRmvsTKS2ifadZncxL2eupuxRrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767603125; bh=9HZdSjQLxNy7xS1S8xcpx2B0F24C5QHjkcWGXNpNJ07=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=Madc9O9gnROjKbGsHiX5Y7gsIuXeu5GDdexIffusYYw8Sluam5MpMFjMYymGe/7Ls5JbZBpBdFAxecoqso6KS+5N/fXbDBbu2onyrEfFKiJ+LOlO5u3pBVkuwqdlPj4q0p4cuvgPEP4/GnDncsNi6wmPy93Z7fDQcsjCoJJ7WwkyuWBNN0zQHjZKqWKXh6vLdbvMPkEUxVqjEmpaNIYJ/ysFLuTLjxWMKgmz7Fy0iII7j+Ejv65nexgjBh0HdH0aguJUaPDiVwY1wQw9DcIIauuFKFYBD5fhqe/vcclyVtg6crHCOL3wgsjGtxtjPj2JpE4br0+BkufuPSiTaSFtJw==
X-YMail-OSG: Go5npF0VM1kUX1ucL6BY1N_YKp425qOqQuvBcE4XWAKY22u75Ru7psfLGJY_CnF
 5QbU5NUbktpL6owsfR.0tRfT7LvDv21AJhblxmsviT.9rZ2dyhu4MNjYjjPuwY8LlbX7.rDJPGbt
 AVnNnHnyw0cEI1BSLDeuFh4H6rKu1fTmRnrJRdmNPCiQSq1V.uv17c5FU8AKtGeZzzQx1628q8xz
 pmIK2ldl_qTe5slAX05GZ0Bl7yc28VHQ6jiWMLy9g4rzQqDIsnDSunUXLjclfs.eEHv8zuH_8Uzd
 dp66ukNtwwKXVlAnb0T3gUcCLVwUzHG8euoCLrK16xaEQbj1SdiTDryHs6mwKoxgSknUEmGCpjkY
 b4ZnBoxrwpTrrCDRFkkSQdjmf6SzN80izsEYw6rdfZeZWdczDEhVT624aKJInsqxCYYnoBj9esv6
 BbtzVBbqVXFajryLTGnCaJ16wfHoPqI8wJ6HhvlYYELODvyklYUfDo50KuE8_IqyONliLb3jWqK5
 Id4pCJ_yW0IFxylakcwBWTsiD7jT_F_fsH2Np7llbW8PIvw0B0RYJmKP0GrizqXaSJzjbiLo_VW3
 a4_RCNrbiH_qPWCq0gCptMyv1gteV.qDgJAsSeCJp2qkt586BWWqIIsZ9TIG91YWNY0OnRpdgOl6
 7isz6C9gZvOXn0CNdZFUQa3loVQS0dQirFvn3xaZ3JW_qJ7VYcsCEA0cuGeHaSvb_v4Vg0lTlcTR
 nBL_aXqLaRTjpoZWgv.547qQCa_xipiOGPwrTWszwCzJ2KFNqrSYesCkr1mdLszc2KYV8_MtGlCH
 .xj0YKsJ6Xxo.0.nOBRffV00CvgCPszR__Q6aF1l.o1kOyAnkvL1YI_ez58T3GIohtqHMypUjUTo
 j_6f9c9Ejg5ISJtV4OQTbbqhG4fAyeTVozWVm1nAEMa.63xEyVZwPwTVVzvWO1jlsfz_gBDSAWgt
 UH.EZe0xtmBY00sfkUQbqhFH1uKXhLz1kWtkBZTT1USZ1LfG8nZUT3D1Z69RrkAhxXebB.6ZN8Sr
 vOoUHZ8Hnqu3iJeA9irEJQBz6.Udi_79nNr9Ijfmtvo..lzJimWu0gk4XyzmOeC0l8Z6b.5_YRJv
 9kVSVRDULE.zu6mxkZdMD4U8kYTJ48w8IMJ82BhXIV.gQOT3hvZY0vWWmsbjcEvgO93.auPdFf1m
 biZm2NJdzHUWrQxjyD3w18GHDK1DfX0W.TZBCZwlqPaa.TjGvuiiZMFMpWDxC_Bj1zSYCGshvWbX
 ApPONts.Cq6yohLuYbGK9EdGviG3HAOfUbMC0Q4VZbooNxs3KDQYdpMYyplPdeJA9ecF6B0PL7R7
 lL.EuxALZAENcaak3q9RNm1tpS0P6ntqZaohtrKRgGEvGiVpkwYVH3OP6FGS78emgQoDjIn.M_a8
 KOa4O6daELff17XX_Ytb3zUfQ7P8xVY0v6n75dC9pcuaRhfL7bXidpf9zobWxI1OHF9rMJHQYMOm
 CFHeFydQccwI23iiU9LB79gIYv2QBpG8zpkVquqnFoPNWBIhR0whwWKKTl5mxQdf7L15umUnPjZ9
 dcndQnpqRvsUbHTY24_Z6GB_9KaXZNtratOT_rI50BtQMQkX2L6vvl2x6idlEHSkEnp_hSJmg9nl
 kQ4q335OC4Fk8OmLeXP7xtb0270108NwyFASkYQXhFIe6u5i.Hcc14cyftR1_s94q_nM4f1EHS4o
 vM09kdYcVbkYkyuSbU_K8YFNPLmnlERsKXJdYs3Z7189fK7wuen9sA5do.GteKfq.2jR1SlqVfvl
 ElZHqZ8kHuaSMH6vM_BGULLVgz0bXjClwqbgR02mJfAU2HT4UEVdnuhsRziOz_JbV2KwWvLMK2jG
 eYen6h.H4q6FX_ybkjCm_pec4eP16mpfldnf26F5.bfqWEYbmMnI1htI.0eAcx5v4YWY6pD5MBlW
 dSAl6cxPfexKmen5Sk0AEO73wcYGPknNLnclb.OOiSnQlfF2ZO3FbAWhFCutVfPf0jjlfO.ftVRo
 PAlqoQaXDoUYdH.F9CA35uFp16Av55Cm52FUlsFDbgvrTvGD1HuycSsSfJ_w_eH8c3udPIfKNn.R
 3SDCUdztLYIBmd42332eSyxkpXX2GQu.RCHHlKuQvgaHq8ASEtQMsPGubAlmeIZ_RRG.h2AZFPUJ
 d.LXnba0W5NXRn5kWTbUWB6Cvc6z2b9MXnfHyncc.aRWn2UPgABhFKjC3Q0w_rorL8fRuLhG98l4
 pNchHa1pqUaOyzu.cojQ1Axk.a.JlsBVeJhz.QDY06DiiQsTqm_A9.u8LyW2E42JIUYf3Ndk3kqi
 X0oklstJgqkTk2k1RVuNmTeBpTCgtKx6bmG4-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: d9cb3152-cec8-4a9b-85e1-dff798632ccf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 5 Jan 2026 08:52:05 +0000
Received: by hermes--production-ir2-7679c5bc-tkgbm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2db1a589037ffe348a251c8327e3e26a;
          Mon, 05 Jan 2026 08:41:54 +0000 (UTC)
Message-ID: <a2dfde3c-d46f-434b-9d16-1e251e449068@yahoo.com>
Date: Mon, 5 Jan 2026 09:41:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "olteanv@gmail.com" <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH v5] net: dsa: realtek: rtl8365mb: fix return value in
 rtl8365mb_phy_ocp_write
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <a2dfde3c-d46f-434b-9d16-1e251e449068.ref@yahoo.com>
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
occurs during register access. This patch fixes the return value to
propagate the actual error code from regmap operations.

Fixes: 2796728460b8 ("net: dsa: realtek: rtl8365mb: serialize indirect PHY register access")

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -881,7 +881,7 @@ static int rtl8365mb_phy_ocp_write(struc
 out:
 	rtl83xx_unlock(priv);
 
-	return 0;
+	return ret;
 }
 
 static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)

