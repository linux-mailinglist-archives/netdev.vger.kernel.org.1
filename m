Return-Path: <netdev+bounces-238956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376AC6198B
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53E3835EDB8
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F8E30C63B;
	Sun, 16 Nov 2025 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hXQQFvIp"
X-Original-To: netdev@vger.kernel.org
Received: from sonic310-24.consmr.mail.ne1.yahoo.com (sonic310-24.consmr.mail.ne1.yahoo.com [66.163.186.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEED30F94B
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313762; cv=none; b=kkri/S5UsC3TOfwZl/PkcwnZxygK0xggtURGnmayOboaV06hxQtGtYNFKNLyAapc1r5rpeVhAuiORX8zcadjhBZ/130ss0ZCuP9WVj+AsfzGDUYNL62irhICDH1mFVW8QTBO5GRfdW15z5OIdz+zAr9kFFk7MuahKN0iOGkjf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313762; c=relaxed/simple;
	bh=bIXaAttlvGrL2exy6docHV1rMA8TJx+jisa+P5rO8K4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eFYQJgnXOr6fHwGNwyrVwjHLu7PxfRVFOAJ9SufmNwVsPyNz4JLb8wDVhOCLnfQ4Czh3Cy+NRp8TtGz0UaUqg3z/Q6hlk9vpqRJ1u72TuqxVF5R0TPWzfed1NVzgwH3S1Ea3pZKg+xK1nVFUlG3KqahrUvXsPREYnitowLectzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hXQQFvIp; arc=none smtp.client-ip=66.163.186.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763313760; bh=bIXaAttlvGrL2exy6docHV1rMA8TJx+jisa+P5rO8K4=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=hXQQFvIpUK4cupWqOBtbGxhETbQigeejW6Rsm2ObDeJhLBRZsMXRtMpFKFPN6t8m8YQu0Bnm7RQr3RY1hAlvkHSJwa2P/5iaypy9vzjXCM9H4t3d6fSVzVJ8JqhXHXhWHW9lG6I0ZLsn9v03hMjNXeWR6OGCc96LnIrZW9v7azBeTP+JfL4TtLx8SxTgkyQmpgHc1MkVjW5f73TIesUz/6hAcm4WZV1U58H1XPXtulJ990f79WGghUWTFc3yX8DwrNq8i7CWKgY9E+E/rro823rELwA0oieEcSMTqxyFkpDCmFFnZbQ4y44iRgqmvIBQYuw0ItjSzEFJYIGYV2KbKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763313760; bh=HVXyxhPp6wjyHUHhsuP0QKEtWh16zPw2IsM68DE9l5l=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=M1IwT0+8qgdTUy3DWQoq6QLmDP9vAPKRyGIMv/Cn5HO6Y4T38pxgMgkJTLaHgzMDsUHpb3eIoYd4pDZdGHz3635sjExtVcTYYT3qfpe9yPW+6qHu8xy95hMskTmreD4TuG9LStQ5uL06dn4sHXpwQVoSIwb4gQSaaSqJCpwJQO8r532tcvG6xNyAeHRUvUn2r4PtngEImBHqt7ocYhjJdpy0CcnO4Sdk24z7UtG1ecFwArK7Q/PAGnY7sfykR51nA/v9rHHaABd1XMJrqvoHEINgk+uEZfz+oeBad/uwClMLw+dOi+x7Y/f9H1GP9V+uPnlXtur2TFcUrFv70o/SDA==
X-YMail-OSG: RjzDkBoVM1kZ26WvC028RY6iE9PoLnqSXaj56um_Dc2MfPZitv2Fd68bfwmhic6
 Mcmpo6FU.fuXTgiQfhJ2R01ywHJhoV3jnKYvunqjOjUXrP_JDWM2HzCcSMz2mtYNMwBljbm2Unl3
 nuLHq.ILvFr0TnxOgqa.S0CGy7Kq6oc3sG2T4hpv2V0W2GBDyU0P5EuU1Gkk7IXPKzLpViBQ1VGX
 C9h9GuVgTVrdCcjP.xVAoQEdEZf_N9NAxcXT3j7j0OyPps9diEMX54gkLKh9CjI4ePD1Hra9DhlC
 HbhCkq3oRJD23ISJT24wi0Y2_eQ0mvfXKQu1KzAZtkkmveo8gf1BTzWIfJvA.fwo9LGfgdV8j1df
 caLqeIbUi8qVjeMosy1SrBB9Mo65ClFM_nqHMJ.g2aRBeefJOBgBnAiP_TTXmlIrqmW_RvEqQxQY
 0Yoy0LQsg8koWM_7grJYHLg34m3m_gQr5l_ETG5OPsa_y1evmmRQ.dqlXkUtamy83jGcLMD.8aVD
 7ZVHFE_BgVs569tPk4y.eVJZt4_MoX9Kg.NRHB80MPaOO9HaH05V9lDRc62L0aJPbgu_le2A9nao
 8c1lNKXG7jD2DbhbqKzBNSYmcqepBCL6l6aV8VyrUTHE.Pu4POfIuaBRunVTv529tzEQ4O8taKwX
 28rzhVDN6.uYU1iOBo5bt3ueqhxnOEw8NTZlcvoqe07meCCvMH3vkS_EygRB4vOh5t13T35ulS7v
 iYKM41CAI5Dhhci9DZOYV.UMGwOp78GgaNzTC8YQpIvxCNq768aj8mo.O3XFu5qyjISQzagcwRS5
 pUb8xplXwzRYyuMBtLxB3p4YYfxPmFsy7nkTxJu7Ukji7OI.d9Ro4beUHpsi3C8H.WZQ6pN488WI
 bKiISDjLaGJHo83gcavM.6bNYWM32u.1uog.agIcZtZCYsCNm2KTdMEIV4mW3it0oPbceDHlN60T
 mL5kfx9HstiT9NVdwCjEYTe1XfpLMes0ZykDPO0T2l7zPAZoBPBFLl7q46OXJMZgobcnchGTijWW
 j2.oHQDa4Rsb.3c8Qd2zmjttc7EhoSf9jhuY7DLCPfOI6IHd.6B1ZL_5tGGv5VCnBXuc5LernSZ9
 JVFqfxqdmd7ETqsJ8ol5omnVQRqWOjrxxURQfOoy.udAvWVc8WGD53ymUKSSQQgnW9QRahAuD7Di
 DczrTJP_rZcHKYy0tzec0jZ3rkF2J7YYUtIKKCOXxhIo5AsorSS8qS30tU3TLSlMCp7Pd6XiKHsh
 ptpJkr2raisPsq.d.01OyhuG54d_4m4RXPACxgsVWl2msibUvfBlByHxmQVrCxNTgXHUn686n3HI
 6V_.maUZ4X.aHUCjf3mYIK40xxQRkM5foNl.iURJc3jRIHf3u3CqKatJ8l0cxJBKIB6oROTrtkbS
 fXtpsRFBzfFEWBOa7tzmDCV7PwRoMIf6tgvmDEGh9Gpwyo5W2HNg5n6hd8._4BKQdr9ksTLFcjf_
 CH8AtlZ8I1INgYBm_Iyhm7lVB5bx_.Y_kYcINw3RTV0Qe.5P5j16ftQV79_Lwv73hMt4aIdLigK9
 b_s.HuP7eLL6qwWdQ5i6jMJJw0Kjc0zi73OJROtxkAcODaorgzqceouofmDKgEU6EuH4LamjLqq6
 22hrFY1N2mufQfzWRVkYdu4wsURKguO3L7KAZnaekKZ9MyN2LnZRB3Y3CoR0TFVoHv3QNhtbzXDL
 25tNKKHeVKDwbarduqnC0PCL7LZMlhyiG3R3mQ_YdUmeXDjKUmZRvs6IOAszv78GWb0LCVzSOhoE
 GMEIWX35hbkGAug2ezOh5QmKl.jdkotnM32Cih_oUpu4270L7JyLWgUdPVnzbjB7Fn9bTP7U6mB_
 fKW7E5gisNf.Wd3DZXT98nAWXDACNjGunPWhrvx5skb9URZgAjI.Wo.ROg7KUzhKufveiUKsCgIg
 SsGTLI.z2Ss.shHU_w1XU4Z5_iBPqS1z2znE_379xjAXvUcsPbPJhLgfGAZv99g64QXJQMggsIsA
 ftgMpOC9RPxf62wQ2h41qs2Cp1ADRq5_TXlis6an8u7FRU5A_rR.ixWQ0njqHincvQr0fUir3TEw
 xs3QmffqwGdYjnawCkGB.Sy7kvQnDSzvTv8Gqw21Irw6W6E30wNOdDaDNw.q29kn9s5Ym3ItaKLV
 H6jmYT4N65xjJ9ncNp0Xzp3JvcHNZEqHnWpLUFjrJyZcYccf2Liec1H4W8tERCG.SrK9jOx46pLY
 PFVoWWlLWg7z00oX0.F8MbA6qpgP06mw0JqTXwpPCxEFBV9PQ92g-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 3e816e22-ddfb-4a97-a718-ded1f3499ba4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 16 Nov 2025 17:22:40 +0000
Date: Sun, 16 Nov 2025 17:22:38 +0000 (UTC)
From: Mietek N <namiltd@yahoo.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>
Message-ID: <965804965.8724119.1763313758578@mail.yahoo.com>
In-Reply-To: <924dbf67-9973-4f06-9945-05533df35cf4@lunn.ch>
References: <686180077.8704812.1763306985880.ref@mail.yahoo.com> <686180077.8704812.1763306985880@mail.yahoo.com> <924dbf67-9973-4f06-9945-05533df35cf4@lunn.ch>
Subject: Re: [PATCH] rtl8365mb: initialize ret in phy_ocp_read and return
 ret in phy_ocp_write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24652 YMailNorrin

You're rightTrue. I generated the patch again, this topic can be closed

