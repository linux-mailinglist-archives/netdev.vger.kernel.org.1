Return-Path: <netdev+bounces-238937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8BBC6179F
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 16:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A10BB35AD82
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13A130C377;
	Sun, 16 Nov 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ehaiAA51"
X-Original-To: netdev@vger.kernel.org
Received: from sonic305-21.consmr.mail.ne1.yahoo.com (sonic305-21.consmr.mail.ne1.yahoo.com [66.163.185.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1486277
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763307600; cv=none; b=JH/6ky6cQuQF7wF4AlHiwlG5ZpXGcSP8j62Yai8NEhxxifGVzItHBa99iAKDz+G5ecFg7JIbfJYI8BZYiQRzcXvY8Zb9i6sk7tGWUFJqN85nW66wOF5SswQGRhtL9/bFrdcyKrzAB8qvjI7UlMl3eyCiU4mBFESk5QftFjlx2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763307600; c=relaxed/simple;
	bh=WzsAL97xxnLZa4HC2bSfwRjz/+VmJIMewbmXzEFmQ5g=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=S48itVnPhrL88u0befJG0dTGQ8TcBMYAofBXjG63JJOo3dtYiJ48hwEwdvlD8qvNG1JLaXAhtyOqf3vdWochTvocN3bTiyNBJsfUOH8Folku4EDH3hw8Bwqo0oLxLJ3M3qT358UHi7777VKL6XEP9iljXPrrDhubTH8XyujQ0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ehaiAA51; arc=none smtp.client-ip=66.163.185.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763307598; bh=WzsAL97xxnLZa4HC2bSfwRjz/+VmJIMewbmXzEFmQ5g=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=ehaiAA51rO91loZZkwervezrXpnPSIIT0qdRXnWB29g1A4TRQTw5LLlCF7BKzWiLZFoA2jcJgcGmh+IneSO/hrvyfNxLpQMMSnSnAtScFp3UcHzhig2DrpR/cOwvDWS04UTmiV9fYavUcV+q7g2QRKQDqZ6Tdatr+Xzr7XpaD714auHLFGsW7l2z3jKJZMvKI41AMw+y1X7TLBSqfkfEh1BIAsz84ci6SXZ+Ll/RahGuWb1oHYaVNB8Ub0BAlUi13VV6XsZEsRTOAvtd1nhTmW+920/CJQmMF+iLoV4suhZ6cby4EI4CVKfNDrEl43tuv4L1fUgXl1DHDrEGWYg2cQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763307598; bh=ryGfLL3CFaHiU63ysdUMTpQQxQMft/sZeFja4L7CeTX=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=BnRV2DuZDs3adkHI9IaOu6WIeIv3qNFnc6a5PGw94qFnN1AWQ8xy7mU3l8rsB2YhYnyo77I6tNOOVKMYBU8PWOZhqTSsYzt3VoNRRdfQG4w1dab1bF0flgfpog2IyTNUYmKyzgLvxgJln94LdHxBpuKKeYi/eJw0oKfTuohIo/G1RBuE4RMBBRlcFHfLlF9xWaVSdbjneQdMwH7g/0sJjtVP/tObDJCq40xE/bZcJ08dSJZKoSsvJhzR5H5xoAgFq18zJlScvFQmz53gAS3ASY2snAyWy1M2moSYOuwDn+CspxWAg/R+NYTAZAyP73gvsHSsL0fSBEn6eZuhlF9FrQ==
X-YMail-OSG: 0JAX2pUVM1mRZ4mwtUZhICyR9iY.ybAiwFenN6g4qtMbAgWurKjEoD9q4Lh4Fz7
 Ddk7PjZJ91ifgk.Xu8wy0bH_.5tRnvZFof7UzTE37PGbPvfNuF4h1b.tzZtPTiV9X.DffElTDvNN
 K1iJvwXq0hxzGxY2H412h2mtrOfMilvY6pUfJpWLqnCSMy3YHDncCoYGObeT6XHuaEG5XyOKb2oX
 VVhD2Ds3OPPu2PDl81F_Vkb77HiQuwu00WUv_GZFQCFvySCpBPNJZslHJMSfkngNravUIkNH1asS
 cgbA4iyxwqLRYUNAaAkFd6bt72MPekkzNccwhTI_9zXH860lE5_nWjaAZBSNgJgZRwXg9ZAR.l9w
 SOohtvihIKvFQmNThw6nogmUF.yIRPz0g87Rj3v.L1m_m2YNqNVBHC65.fVBwZ.uCIxbOl0wUKLS
 ZaWwL3Nt7JETU1qbwtNHSpNcfcSfYctWSf80FNxxuWzSf7qrxPUt9uGr8u3M0XYNoVFpwDwORaEn
 AyjD8VZSUlheHQb_GWYh1D5s_u.UC8WiXvMsVskbHHjds7CCAIxppw4jRSnlrMqQLWREGNZrTHsG
 SEyh4Im4fFFrm8pDFma1UYTPZGHQXEYfrLfqdZ7kuTDC0_AztSIAWO5qaRTQlcImtjKfQQ.w6PHa
 F1rhnFtf4B1W1CKuKDBelOO8P8lvcvJiknAeoFBt5fbs0o6Me9aiGhggPvxTvLEhOg771BDPw8Gf
 4SnxsWnyPnweWxR418bim_4oEqwrry_M6ACK8GbQcAAWNmHp__IHGdk87UENzuM0OIPZbTn6XWdJ
 fLbcIPKrBm.lNgpqZXVkD33JpjgYUM63W6oLsJ9PaGW2t4DsNYlbHD7asknGjRi0Xh7VKUmpyYRi
 wvM3amtIyfw4HBp_hKgCTBPq5.PLDGRuUWpnH9h9ho_Xtl7ZgqyeIxSO6edX.PIRpJGKx.XsLO_l
 1anj8L8JGD5m4sRdrxzZHZGY2nfsLPaqt8w8ooKGPlmavpnchMf9Y.jAMRyUVZoMPyspaDXvU8z8
 GQQNDQrTUquY9CxtCW7miCi2TMuG0S0DOWxMZjeN1.HvQnfDIS50SC4L0WebBy8JAAfR4U1yJjVu
 Fpv7SCBI_VWrKZffx1Q_vgbf4aIcgVVIQ9jQcie_UfQeqA9PoJSQLWrbpqvxwGYl7fZvR2yjzEtO
 hnU3wRdK39bHc_6Qp38sidMs3QOMr2KAt8I6GjIwG9OMplCSjSZoWseCCTy7Ha2V213Bj0NWu28c
 a7WvMyDk9ZWLctolbgl8NmxQ_NNb7ZXMWNei0BSws85gFkz4Xl8yte55DLrFs_nKqAkrJANpIdyr
 dOVMc3QVMEGwlKEuweUlR_e6zOZPXtyqKJgGjT0M_DMdqz63NQv8aPE855khguxWdlP8UXk7i0Hu
 fkcoXSBiPBBPwwi.CMzRco9zOPlnV9MQS_Q4_W1G1WwgCSWDnq.R0QHPgJcsWkZ3VGX_zTQ9mD5G
 .gyamkof2f1i_Xm0ibXzzo8Xm_GcatgtRsw7VmI5WiYOhl6L8cPOmQAdL.yS4B7ZDR9XqZVLNSs9
 vB7G5TTi_fs_SDa9fjo.2fpoCyNsFqlWev31As80CGHWV073Da1ZJ_2aSpvXQKTQhhKeBNBVlRmf
 e4Vq2.jqGRk.ImweC.iv7GD8flY5jerfeBrA8jY6ThmYIZN1zuWyLLVyQl9kI3UKvCYB_1Lpnqve
 .3bwXYRlAnYV1EszlXeSTks3AU3QPw2sH0I2cj6V4Uvcc1dzgQOU0lxd8us8N41rzBslh0egp0RH
 _9fP2mOicg34veukmMI_B69eRgh3VsMnCJon1VB_ZDhc8sGun0ym_.SONaz3KnqR3sNIVsnwssIj
 W4y51FWcY2VAWh0YVAqJslcvO2IxpC5Ekp7VlKjCcikNbv6BEYxGuEV8IGh7qa5LOb9P136UloYy
 i.YhpIupWzKis7zpbYzhVoKXmr7JtJtJ_l1y.hCsukg2ll3T8281umJ3nGiXJmt2tGX6OZiyD5OF
 3A3lO7x910j8K1zE58boESICzlmig8hmXUtYxydmMP41RYNyoMogqVSJ7_clZXQVokgbFzWGQAqx
 vfxctworDvArh1tS9zV9kb2vkae_lET4zeW2.ekJWIO8cnbEpUWEyHbIf.ANbVvgdX7yTUNk.heq
 qVfDC7dcFyr4ztfkVsT.7eEdQFEIDLphd7F48KWKyQNAxTgSfv9UQiBftNVGQGPpq1xJD2Dbk.wv
 R64hpfbJHWHMTaqP3X7G4Dxpf3NrtZArZALwfsshh6k7WHHhrwuW_XA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 93d1412e-098c-46be-bf34-efdd093e267f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sun, 16 Nov 2025 15:39:58 +0000
Date: Sun, 16 Nov 2025 15:29:45 +0000 (UTC)
From: Mietek N <namiltd@yahoo.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, 
	"andrew@lunn.ch" <andrew@lunn.ch>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>
Message-ID: <686180077.8704812.1763306985880@mail.yahoo.com>
Subject: [PATCH] rtl8365mb: initialize ret in phy_ocp_read and return ret in
 phy_ocp_write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <686180077.8704812.1763306985880.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.24652 YMailNorrin

This patch fixes two issues in the RTL8365MB driver:

=C2=A0- Initialize the 'ret' variable in rtl8365mb_phy_ocp_read() to 0 to a=
void
=C2=A0 =C2=A0using an uninitialized automatic variable on some execution pa=
ths.
=C2=A0- Propagate the return value from rtl8365mb_phy_ocp_write() by return=
ing
=C2=A0 =C2=A0'ret' instead of always returning 0, so write failures are not=
 silently
=C2=A0 =C2=A0ignored.

No other changes are made and the PHY OCP helper functions themselves
remain functionally identical except for the corrected return behaviour.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

---
=C2=A0drivers/net/dsa/realtek/rtl8365mb.c | 6 +++---
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)

diff -ruN a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/r=
tl8365mb.c
--- a/drivers/net/dsa/realtek/rtl8365mb.c=C2=A0 =C2=A0 2025-10-12 22:42:36.=
000000000 +0200
+++ b/drivers/net/dsa/realtek/rtl8365mb.c=C2=A0 =C2=A0 2025-11-16 14:02:57.=
000000000 +0100
@@ -690,7 +690,7 @@
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 oc=
p_addr, u16 *data)
=C2=A0{
=C2=A0 =C2=A0 =C2=A0u32 val;
-=C2=A0 =C2=A0 int ret;
+=C2=A0 =C2=A0 int ret =3D 0;
=C2=A0
=C2=A0 =C2=A0 =C2=A0rtl83xx_lock(priv);
=C2=A0
@@ -769,7 +769,7 @@
=C2=A0out:
=C2=A0 =C2=A0 =C2=A0rtl83xx_unlock(priv);
=C2=A0
-=C2=A0 =C2=A0 return 0;
+=C2=A0 =C2=A0 return ret;
=C2=A0}
=C2=A0
=C2=A0static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int=
 regnum)
--=C2=A0
2.39.3

