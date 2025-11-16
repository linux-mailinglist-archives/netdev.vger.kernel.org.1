Return-Path: <netdev+bounces-238955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38DC61987
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A14B44EF155
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262F2D6E44;
	Sun, 16 Nov 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qHYeyzEA"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-24.consmr.mail.ne1.yahoo.com (sonic311-24.consmr.mail.ne1.yahoo.com [66.163.188.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E123FC5A
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313516; cv=none; b=ehiuHhM27BEYasnvn7ha/0xLvHGmwNzEqLye2ZJ+SIr5KyK1hXK5FBHvS5dzdlApfq+/5gkItYBeXtZcgFXm1gmpjsYCgfaZ0QB8Cak1lR2cMxPvnlbbc3Ed5Kp8OqIBSs3GBfjY19Q4C8xHKZr615dRH2RyfXIwHYXAR1S8aPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313516; c=relaxed/simple;
	bh=aS/4lWztpprWgHZCxEzb9mDPbnyPCguuID2jbu9mQ/g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DjHQXzTCc8ecil7XI3j0x9H2CgGLLRIIdal2sXtkwhXrsrSFDDgZbOQjUR45au0z/7OtGb7lW0fbrHUgzSCnJ0m8lOqYLJY3ziKa99TPWFkNAH1bbNWewCshOKdLc1ZVR+eVg25S7sTeIR7H3O1YHMXiYv+Yvnqif4nqTRnLcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qHYeyzEA; arc=none smtp.client-ip=66.163.188.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763313514; bh=aS/4lWztpprWgHZCxEzb9mDPbnyPCguuID2jbu9mQ/g=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=qHYeyzEAAOh9jfY4IE+5PPZZ590Ulbq95gSjwC9eIS/FzWLN7+CFFeKYEirGNE0vEsWkkx/al/FZDSQsai8JLTed+q3nMeVzc1/SYxa2UA7eBWvDtP+0apJ4t1tiYA9LC34hA8PYydZhQKhJSiubRJHASIqLJpObFSlirQQ8Ys84DJX3n0xXLLxa7BhcSyILd/Dj4ILUDOhQXL8hIeNt0lDEn5xVF2IgwpibnOr04TUakIbTZ/832FcquvJKIw4EwSuF1Dy157LX4dmwOZ0YQhM3J1MqHZXMZsAmFqqwj+f5yhEHB599dfsJVnTZoGxXldzkGfH5acFhoaCy0DTVLw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763313514; bh=mnMqNsSH03RAH+4hP0N+bkyWzV7uw9CGnY5b43VfiPx=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=UPngdodj+WIsjjYbcsVeJoExv7N1fj9dWodSITtdZ57iz36IY2d0LzFyLpYe0GMpkKp70vx7+BsLv+XAbBEs0cSCrsAo7U5eNa5oyrjEvzzRXsXW12QTW2kEKELa1tcJaO2y+nHWqKbAzYKZbRBJ4uuyRNuxc9ijlN5q6xzPlVhQzN5wgjJfk8nOPXlJpHhFG2nqcqqhtBESrPU2uZN67km47cre0UuIGIhGwJfGBj1SgwX27h5Hp2AjNjmJGQAQF6LYfW3iDM4W26wn8D7Rw4MLvqxUkAZHjrHy3Mg9ftQd+Outgam5AqmuzHSS9WMpe55/swvXFfdUEUFQpSuOrA==
X-YMail-OSG: odc_IjsVM1mXN0bshzOflTdk5Vq4t0132m4twRH9G8PcdvGFZ55oEGz.lObZp.c
 ..Tp3izsmskfvBTWj4sYnVbZMM4ttaTr_3e4l5oHsgUzga2ZW2w7zgjVh2ihwedpKI5gVEd9mN4m
 sjLRzlSHbBqAYagtTaX1BRA6YP8XuuK9NDXIxuzGocgNh4NXxAAg4DnXGLHIYgbz5OA_Mad4FxtN
 9GAeis2hjUxStkgo52xGd7lf2CJAj7SavULJ.YY3In6nIVb5fsj6FdtHSOw.47KTJgniuWKyuNlX
 EZ7WqnfBy3NF2G_80ttA6CABL44zRBwWoEDLLDKJ2YdnGtxNn0vpyYw3p2q2uagToHVcf2jnPbnv
 kDXXXgItQqfs2h5GwdygOvMDhYnkaQEJHASY8zDINGJ7wkXRdf5008twde4oXq0e0_sLhzAu5ix_
 Z8HKptMjaFDmQ40hVWlsgGYGyoGvbawyAKXwrimL_LyI0W1FA2T_rWX67qTUcUwu.ZwbOyaT_CF3
 BKXkQfY0P8c_9S4G.qqDlJwM3CzFpcz6y4Gt8KxT3OmjBYlCHb3uF0WGk19csZFJS1z54EZQpEcd
 gMBdKUn07uNcRAki6PXReAolsHxcjDh6vaP1c_mmG5XmzUB2yeFumKpvKwyRR69UVDxL1A94i2G8
 519FnZ2B88Gh1J.73yNpUuylO93PKYv6HUfwN072VkROBAiZqJT0HOoK4x0hUZyuRAL0OFA1kz81
 rUOHIlQOF8bIc3hDZNkyWM4yvlW0oALflFEoS3uYyJh5n6DL3bLddiZR.4Zkj9SmCG6U1d1E49z1
 hlKBQzg0j3Sd344Vn6mWYB9GZiCbmJ_f28ndFmkjWmSM0FvhcphArMAz86E0JKS1RIT_0sfDLKTd
 6f3f50Jls4y4KbaK_n62EaktaA.AtzL6r_OBXBioQVdiaD3On5VVAfWKuCvPLfrI7WMlTxE4To1t
 7h4hAYbbjqik6lXDVHUwSBHdH2m1rE162Kc9aG0hewXG6hm4L9EaEYkTsqOBDA_YKCAguJvdmWsC
 NJ0wJ54J_lXkWu8VCw7kXSCoNGnAEnwGHJGDicbeT4y4z_kWMqsb.ooK9ceZmWI9aF5Mbl2dtlQI
 3cxn.mfwEw3OvIXzCJZ95NbUVuB.SDiFB.gHOs6.q546uFiTGjyk.ArAEBTKdef9CKpjtQMxqbdF
 ONPTyoMuSmh1c4Ynd5fOd2pwdft3JH05HyzBfsmEuvTbHdHWdUrTdUBo2pjVrQ1wc5qkyY_YI9er
 BtRr8_3KjF8TbESWmhjr8oisy95lnUMFi3yqeC0.wPrDs5Trjw9alRpJk_Mg1yZQkp59jcn9ZnJR
 c5qeNYHfj4.cpOY48plZwA3pnWk_2zy_mopCyTbYMaFYDxYWteTO9gK.bt97MxPMx_pupTgtfKQ5
 Y33MW7Sc.nUm8STSgKGDmQLbpA8wgDGQ9kc.LWeXcBPDLavEFuFGpej5QgqTpYFWc.flfuwVvFlq
 wl4XuwtVtsD20hZjI4Stqpfy3vyA0nEWysP1zSfJkyBHowZsoMqf8XBe1nzIba5.ny1j7NuM0ypz
 JrvC_aVqOk2i5YxE7kHcDAO3YxfeYUhGqDm13m_MeuwdZIdFupv6lJ2UmXIKklqFfTVXhs1Ao35e
 kTveXJTS8zSIK8blWaFN0QOFi.7vmxHKDhf7vZGC.cq_YwUN4nCg_yPaa5BijxzYGh5wJvCkSZAx
 Q1RCmmjwdx33jymJn5u34hAvp778kvFub1sS6aDKqZjbRlM4Ih6WT02GRfcHne2nXBkIW0QDdEoO
 gnkxj9A5IH0cvu31rbedTeG.j9wMVHbnF2LBgG5VATHx1DW.6nqF6mVvfNeoL65xebp9XGiupSmH
 8EgP303Sg_C.oKI1UZTd7HZVlrwO89iYWHqVKVjXj_RWoRCFhxzpXxv9UuId8g8.mxEheaXebaXP
 n.KgZDl_whgw2ZKs.B7StwSVJnUetcKNAl9p.006tUqvFg.NOgq1qBO45REkP_1agjvlZGQnBFkt
 ViVJ1h4HnzGryT.DGPM1Zi.kD0qjccJ6vRsG9WCp8tpT_mZQPvMecqkKSjel5BlQkpgap6cxIrMi
 ql8B.Q.ORAno2fbCLyEy.UJgxJZWNTrivWy7UuUL11TYE5BAkT4kVLOWmbio7O6cUG2Mx2e3mL2m
 oeHvFQLa8sIqdBOCgp2a4mBGkAkidJ8iH4YyT1JP0sg.delLzSSsizSnSrcXNArT7QnohoGcW7PB
 Z3UJY9wcDFc8hUyDiFsuz34wsmNLvwl5aTQfZY.B.E5AfwBINvQKF6pVfYlEO8tTIUfa8wuh8WA-
 -
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 2ea3f582-e93a-4b79-aef5-9e7fa5e7725c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sun, 16 Nov 2025 17:18:34 +0000
Date: Sun, 16 Nov 2025 17:18:31 +0000 (UTC)
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
Message-ID: <234545199.8734622.1763313511799@mail.yahoo.com>
In-Reply-To: <2114795695.8721689.1763312184906@mail.yahoo.com>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com> <2114795695.8721689.1763312184906@mail.yahoo.com>
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

Function rtl8365mb_phy_ocp_write() always returns 0, even when an erroroccu=
rs during register access. This patch fixes the return value to
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
=C2=A0out:
=C2=A0 =C2=A0 rtl83xx_unlock(priv);
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0return 0;
+=C2=A0=C2=A0=C2=A0=C2=A0return ret;
=C2=A0}
=C2=A0
=C2=A0static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int=
 regnum)
--
2.43.0





