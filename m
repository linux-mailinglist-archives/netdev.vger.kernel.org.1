Return-Path: <netdev+bounces-238954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5922C61959
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7153A3552
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291930C359;
	Sun, 16 Nov 2025 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NrHAjF6I"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-21.consmr.mail.ne1.yahoo.com (sonic303-21.consmr.mail.ne1.yahoo.com [66.163.188.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD52DCF69
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313434; cv=none; b=hzl/H85TfxX9t4xh4GX4oniiIsoPsI+fD0bvpkOi5rSasJCUai+IWDsObNsXA9xdR3i+siqCxkFGC85p+ksUAModuwzSgRUBx4Hj0ih/a4YNtj3FYY7FPcwgvDo1KSC28GqZAxCU4Wh5rrPp+v06UAfv7ix/qX2jmI80l17seI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313434; c=relaxed/simple;
	bh=JxMWQwAU4b9C2bCjmzdkCCMeO0o9Soh43PFQuy7c2AI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=RcVPg4v/VTY8uH32AH2GvPZEN7dm6rUdBabVMmyjzsOzuVX5wFKDmSykMDC7gY6RJuVH6892UGUFGqE67Fx9KxXWjyWGe4Y43WsgdhZ+OgKHOq+0miFTVJm9KWhOKJEdnn7LFxb6lJ6bYLy3jaJ7tQnSUMcDH3gJ0ZIZmr3NhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NrHAjF6I; arc=none smtp.client-ip=66.163.188.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763313431; bh=JxMWQwAU4b9C2bCjmzdkCCMeO0o9Soh43PFQuy7c2AI=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=NrHAjF6IREKbCzlBCUyx1TLHk76kF1X2bjaU4k/F7SQ6+mAPu3pIJqWy3BRxcJRbDKIzV3SlNsT8BJBKFiwBa+blV8+dEOQIFVD6e4/eeo+Jam686tvBXnZ91kMBcq+ZAx/KaXfGvCumWLU1jmd6GeY+aNV6H6DF8FPyaa9sCeiRQkrIvLHhni1Ll2Y3bkN69I1kr6IsQ4yveg/2s7eo/HRY75/BPB/CG7DDcuMu9d0HoAG2A38mdLv18efgZGUXZQwT4Mqu5FXYdaffu2abbXui2AbUIC8fAlIUsXjNd7zkm0npFMv4tomP4FNVtzvuvnRnZDajO6jYwQjS73WeyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763313431; bh=uwxCzb542pIidImFb7zj0jALkGoRVOnwIoO10U29pLb=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=sIVtbCxpy6BzVxogM6H5l11Tl2FKQGs3YxXkVsNAvtm20vnK6LMNTgeMf25TIcS83PPU/z/p1LBX8DUebq37nJxpvzM2g9bmM3qxH7NaKU2iiftu2vFj9i0L6kEqBjVq7UuW1rgOZnCz91+6o6b2/9Pbesh8zJoXmicUGVCoqRFWzqyJhJjVOqxJ2SBdMvfcwOQSJPhVUnYmtJ0aE2JBEWheTvr/0NUvL0TK8tbTlsZdG8YloWofAbeEUFL+Ux5eI6ddAISqzLnHSAthsHasJSjmi0Zmb684bLP1bcBhJbaXNjm4yx4ywA6enROnEdKPPV1rzSOgjFhJk1XovgV7ow==
X-YMail-OSG: VvsL1r8VM1lijBZjagzAlqpCuJ0BMk0o_nj8A7T9cZ_wJXa8UUr9sNZh618GhAo
 GX2ulv9QbL7IT3QIaNS5ZECSu4XpDSnITlW4L5uRpU3bjzgTSTDWbDRten8mmVgx3EarSK83rLBM
 XylKsIKV7DwWs2kiySE0HIM6lalf_LfFzH0eOPX55EKTm9y4kn6KmxnzvzzMbs4DnGQX42wEbzYU
 VqsjeUJsfMb9WUbX9s7QesYDeUqprfdfmFt5tZ.6KUoxDgraZs6Om.yIWXFgHLHZK63Q4Bjs7G3x
 T5XBNXBkVC2Q9fILYEwOpkeMwsagdf5eIOT6t_Fu6FtHwFXM0ZPyb5PgWvh9kuI42yfZkxa0L6ZS
 pBprnTzgGDp94aHrBBSYfmMm7m9UQQg1EMWMa3RZ1a84yMMtauuruEb98kNXybYWEoYJ3bd3POiX
 MD0AGilxXyhe6iZw_c_d4t1W0JECtWvgKA5BAbmFnLVFh4AnDbSxZTmqspoegHKbOujK23YyZimd
 Til6_xybJmOCcnCeMqYvMYBpvctGCeULwTW_ASZhUQZx38AstaBEdYZhOe5Cl00V7p5Eek4lM6.p
 euzFYHXYUP_OGOYdaIwfgXeP8lypdVz0UN0pS6H90K85ozia4xhwWEKjrLO_Y.e4OX87ZWrc.pbr
 cqXBK2MPCpI_BOcoIGf2iJqdA8j9c3mBrtUlkFnC5loNSCs181oC9gEj_H.FlWmHPwIsJsCEK1Ow
 A_zEKzl04LLN5DC0LJCC3nhpIVpd5xTR21p3KoSnSKCQT7cC4aEnBb8R3nPnhrRoQ48XCDFrut8U
 uSjXMdMtogMUW.RycXGCamHXZWa2y3kpRRiBQ_7rNZANzFLCoPfMZjYmz4y_tcOtoxEM5LUW6Egg
 mwqlEx77chNC0JTMk5cWtUTSpYKnhJfpXGg.4YdOaZR3WsGRtorRhuAXFL1sLVv4jLI0n8BWQq6l
 TZZSk_RvUhWgtaNo6Qkb8mYl2jxB8vpCzd.al4ZzYIlxckfbtfiRBq.BYGH6O0dCqlzKtwhCaWNO
 zgh.3hQWYvHS6BrabUEkv_7zMFrrCENgl0aBp9fVVdiXKz3mmmmNyF8EvRus6qD.mLaX.S74x4fe
 S.ga66Iu1HeUX52I8QuS6Dx.8alqIMu1XcGkGloFHSSzuGg3AiDeUl1eCg9mpobSuh2BQYEu.d5r
 51s9XJQkuV35mnIe3FkuNikfF3KpNJOuoLlDc4nbTSvTGDUbUbizBhhP3dmZuAS2dlnmjz0RJYRN
 6RF5FtqpKIqV0jTv6LLZ_Rd4IASE2ougyZgmtMfwkvolVRdT7EsRpZOMfjA2Wiy4IYQpN_ccxhy4
 w0untREOs68oJcfuRSoyU9j0nVijJVJxQ.W7HEWSe59ZQli6WSG3.3bhETUggE1y.SsTr_f.qgUU
 4C1tSIZD5_71C8tdI5y4tWJLOEQxVNCNfmh8ELyasG5f8Rm7_fOnYOjJlqNQm6yRKgHmGJUJRO2Y
 YXLKOD2myL7KkWUYuTW670G.Eqv0kBld2IK3W9wBDcsRY6QeJwiP9.IGw15O2SW3oL.aYuweREdf
 CnEWKuKRWDNRe9LOuAASu4VHjcdmHUlWCsqhcvuujcDt.L9SxRupRLzfpuXA8iP_wDXGzi8qcBp2
 is5DrlNdfDSmsfq2jPTBVWw4j_5Oz8k212vy4J1OR6.659AeDX0Fl2BZMG99eNbUyztyk9qgIK7e
 AMd50ZRsbA7uK88U01.gaFoQVSCyWttndMbXdgYVFysHHdsDEfMKibNnmvvoGRJTEXJHqHtirABi
 sWepuHzpmzwFKKJLnCgEDZD8eQ1YecOURzwMkGKhfX9qV4Olrz045eldl1PhOR7xXREsnADw2SCs
 6QYyCDeNv0yvgdPo3zs4qsjryNVQvLSrfq5VbgGR2kQLbdxlydmleZgXYZU_HnMqogWwxkjsccNj
 NNNGZb2uDoUEb1mZ4DHalVFd5Xk_0AHgIKqrS9yAJCO2gjsu3AiG9ps6pozcO._E6b0L0PUyZsmi
 _Sf.zAkMOabVDc.4uoq08mE0jkdPzwRxOwUpNgN6lAtLj1LFCdUhdc2qloeCT3D68HlArg8mv86K
 Zso_E789euwRQQ2WJBmQf7UdmaJhFGTlZIGjQnnwNIbqaFh20KWmmjHRzvGMG9kg1ELcjikxPkg8
 IDVAtwDAVvs41_2OJQwHnYy5r5esMsam0O6tHg3niCEVwWLXr8Ma9GdmKBUoY.DQF6tYBC1vo.oQ
 _wRE.EeDmoxoBfZHaz9ap4bGbN991z6GG6ERs9GrNj7dDe0yYaG7SUOeD
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 383bffb9-b322-40d1-9a54-691721ce7965
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 16 Nov 2025 17:17:11 +0000
Date: Sun, 16 Nov 2025 16:56:24 +0000 (UTC)
From: Mietek N <namiltd@yahoo.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>
Message-ID: <2114795695.8721689.1763312184906@mail.yahoo.com>
Subject: [PATCH] net: dsa: realtek: rtl8365mb: fix return value in
 rtl8365mb_phy_ocp_write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.24652 YMailNorrin

Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
occurs during register access. This patch fixes the return value to
propagate the actual error code from regmap operations.

Fixes: 964a56e ("net: dsa: realtek: add RTL8365MB switch driver")
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
out:
=C2=A0=C2=A0=C2=A0=C2=A0rtl83xx_unlock(priv);

-=C2=A0=C2=A0=C2=A0=C2=A0return 0;
+=C2=A0=C2=A0=C2=A0=C2=A0return ret;
}

static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnu=
m)
--
2.43.0




