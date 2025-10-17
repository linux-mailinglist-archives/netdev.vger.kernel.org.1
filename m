Return-Path: <netdev+bounces-230357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDA1BE6F50
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF15A625393
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ACB23507B;
	Fri, 17 Oct 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Z2Ynal9v"
X-Original-To: netdev@vger.kernel.org
Received: from sonic305-19.consmr.mail.gq1.yahoo.com (sonic305-19.consmr.mail.gq1.yahoo.com [98.137.64.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682051FE45D
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686660; cv=none; b=BPKc/qg911KVZBL2z9mrG1tcUrhqjCYlWSWXz+I7Sg/P5W0PbVEJ0yrCAXLpaqicL0xiRN4UQ0MHS6h+HHjqX6K3g86MMoWOFexq+j318LYnER4IA4o5a1ZY20Q2bEdZBdRbjwOgFPQL+woQhHFN4CLDbD16vLFRspm8XIgcpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686660; c=relaxed/simple;
	bh=eGJ2lbEygjb3vDu/kdCzOwnlN6UAw57ABUXeozoNoVk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MZBPdG3mUYicKQE6o9qoEGyhAYdFqEKgM8/e7cX/t9Mb7GlNEY76ovfh5XX/oaCKVfolwPJwZtlMGqOEDKQY1U10ySYmhFFeEGvWxkaGoVf6iMHAHUYAh9f5g6pV+TPsMXWYgTJ2rbrPMqq5vZDck7pb8oOIRGDf2sprBmmMfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=Z2Ynal9v; arc=none smtp.client-ip=98.137.64.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1760686657; bh=eGJ2lbEygjb3vDu/kdCzOwnlN6UAw57ABUXeozoNoVk=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Z2Ynal9vZdmbFKoAN4mY1qnbLexXpnnEHrHd+0iooD8ftPPsy2wFcjftk+nMYVVNz51dLp9CR8CcOXm/cPIxwdBTn4j85/euNlxlwyWb52Nmm5Ytqd7TNSQGXXoNHFvlD+1YJSt7Ir1UZrwdqiJJsSRPRruy85EEM7/VAcQWbqpQ2BQ4QVI7HXoJb1g4c2lJxLOH3YO2qtFz4P1BrHHvrb6U4HOywM7Js7Ni7+NblAvZRIUZWPQKVhe7vzon8eVwZvQAQQKSKTmEdhnBAuQ4UYm4GpX1aKh9bSIMU2cGI42f185rxvXAOmBNVObJBt3bMuJSoZsDGjG8l9xU4kmZrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760686657; bh=BZEQSyrKkJpUwqAswWXjmyqxnmfwEF8MSSoDYh7KX8X=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=quiJpMpyKUkFATMFxDX9MR+e+tiCny6WY/D/gCC58Fj3luxWJOYxvB2v+QUU4wVfzOySTQgsJZYNHILLQpn4Qq9jm6FxB2aciH1AwdNP+CSLK19tMPdeXtuHZ+Hz12pSDCDKfapsF9fZHuLa3u03NS41DEHHBjzKAES0oVvywzMSm/yyCWW+GHBUqqOAidOx6JEfLcisFQAMSXIi7VktpYa/Kp7WKXUc3N80T9Y4KFRE2bnAZ+oQxl5vU8bvILJ247bpR7GQasKcFh1aFpEmrvnTA0GpNL8i1IyvMqQzOi+Fe8fjwgbkCzYjmcZ11IVm9tcRTqoFGnCWAMtGKuCdKQ==
X-YMail-OSG: kCHrmywVM1lVOwVRPKwXesa894dbosY42nDZC7BKdQgsW8s4aohoZqugntn_Ms6
 y3yGH_LZl3UjoEMMTuzFdjFBcNfQdXmlH9NIX2q679mCSl8Sis59YDVHnM5OmuPeWobh4fK8hkdE
 _ST0DYJaAHxViEvOrgMP5a5f_FLgFM61lRKvNCiHvrF9.nWpwVat0AJ..rv32IfYVKICwaM2pQX2
 _FkOW10Ttn4U73dC4oDBtphAq0qrkUQt1OdKz_5R.9g0mMS7_0hPKmxRBpYRYNdWZlBiOm0rqLO_
 MO5BmJxHc6lYIw93Jez0jiydB95hvNyNaHprxvlUULQptvp7fdvh94drkvfjlqls04__3hI3NKSE
 s0K1xJXVqzKLkHXPPgxvR5lyFuFsNqmmZN11ahR7EoQkXDz0Qg74QJDbnwA6B23miSQ2xtEFnTuh
 GeBvSA_taqObKBbFeWHHWKZaJIP7ZKyFiD2r.MI5F4clv32OrQ85rpTqH_JAXVZcXVO.9B8Gp6ZS
 TWGFD38FFZJYz8pw8cr.yeAf2qGQJ6snhvTs_4e1STbVsITTVHSgxl_pdSTxdrHV2z__mbDsu6Lc
 rorHAu6ul1u17wr2Zr7S08szh6vZ6Rq.gpAFqeIdwxawsUQCRtdaxjbBUGgGwWiRrn4pp3_Nxb52
 OcRV0WdLGW4.fR9O18k1ncVyTcbdI4iNxEqleDjn44YcseahmBPN9Bs0DpF0lgQhJoRFXcbiqjc1
 11ba4AvTNoe9G9l_euHOuscekKj9m2LtlVFrOjZElAP_OrYCmUKg3Tglj4J9hxF9Tph9Mzc1yaSA
 rIWErsgWFMy9RAOrrp6T5w2ZafR3_rnyRu6KZKyU_yW7bOJaHlkUNYe_B753PRMo2vks_W69fcSP
 vIfqEXmt47AQJNzzh3Y.705zG7d_moJmqyALrG2vz_R9pM0npu_cK630TQxTCw8ACvWgrA3g1.hL
 02GvtCylp9QwcrAIcL_zozbYxgwXUOuMSlfX1oB.o7C87i7_6jtTlpqUOo0M932pdrAWShVNfvlV
 ZGaNU9CAz73RuIiND08jkVVhdgkin8Dw51hXpU0VU8_0AZYwr4Zz8.il9O9xraT9Cd6WvLPmsDbd
 xr2LWTNOuCNkLMOHDi6zwY4vOMXy0BEQmxP5Z8ntZboSBZFzrPXsso4.y0mLeHUa2VAAkmnHJnWh
 emN5NVrzgC9xCzMaaJ6V5mJp0ctbO98jW7wFhxjLdhYSDc.T04B1AyXw2WNvQhgwqvSuJE_y4vOt
 ascxQfBODisy.tF0R1clep04_0Ub.TiWVQStMwWohboTothn0a8yj3_FC7Ga6ydIWfmXzoXfLgXD
 oTX7uW_itnGfXByzG3GItMrVrO26Zj_44z3snHeXgm43_JJocLeE3ZKp2oakvIxk6Rz5RsNZo_7U
 PIIu0xU1TNWELSy3h3.Hg_ZFFtDUm3BO9GEWYFPd73ENyXPzs4H5DQTKe7xaov8GawlUPPOXCSE5
 i17P8FenQ3dI7Aw3mUNfSauQ4LQm28v0bjCqNGQu1AwwJZfVD50rWiKxPl_ubU.H9Locq3430TFG
 vH6rr5B8nQd_n8FL_h2zg4hFURmXSNFvZ8F.9E64pO5QDt09ylkUEup93Xe2tpgzuOaPV.h9xqc1
 KP76wS1bucMNXp1cVXlVCPjxB.cOgTL4PNXnhGbIm.gwymo9WZyOpFzdf7IadI_9742E_1TXEvYn
 iqvuNx3.wfZJrkyrN1XUsKVvPTKRjKdUfXxl02Ui55UZ0wExaoIL84zH6BF2L62YZRyAxW0zBmLy
 zvDZyBe7.GbCY.iR5_7URB.qfKdXmUYL3cOtMyd6TMgUtNtndFz5TLJVB7hxtpjV07bf7QMEdNdX
 R3.eyItFcaHx9MlnVU11B4OQuuRZ0bBD9jbeJt0sXuIEIlJp6mkbEF2aTPxt9pYjpOvjShoV4ICI
 DVKSQcfbMW7sFHy.waYq4SnhQgMxajAfMUshlTCgN1iOT.J_4u8dEiC3jOTcyHnSOKRTjqqtgjyS
 nUE6AdkG1dR4Lrz3RcwpHEpbzBsI9o7ehdTl0XpWdMR3rPha0qlBVSVR9D9LefVxHaW0bugeuTKj
 h78cVTeVFZqfxufJBG6GoI9DqwqtycfDGVOL5r31YKSTZxNI0IwICN6NpWIurEam.2sXmhPOR_8A
 6ToYdzStz2u_N8gmzn24_tlbBKalGnTbD6M8meSqaAv1LwnPmYq43TnUfUu4WuWfihL6HyKb_
X-Sonic-MF: <canghousehold@aol.com>
X-Sonic-ID: f7e434a4-8690-403c-9d7c-042bedea88de
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 17 Oct 2025 07:37:37 +0000
Date: Fri, 17 Oct 2025 06:56:16 +0000 (UTC)
From: Household Cang <canghousehold@aol.com>
To: Vladimir Oltean <olteanv@gmail.com>, Lucas Pereira <lucasvp@gmail.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, 
	"David S. Miller" <davem@davemloft.net>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Sylvain Girard <sylvain.girard@se.com>, 
	Pascal EBERHARD <pascal.eberhard@se.com>, 
	Richard Tresidder <rtresidd@electromag.com.au>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <21658780.3286902.1760684176107@mail.yahoo.com>
In-Reply-To: <SJ2PR22MB45547404DA1CA10A201B2BE0A294A@SJ2PR22MB4554.namprd22.prod.outlook.com>
References: <20231218162326.173127-1-romain.gantois@bootlin.com> <0351C5C2-FEE2-4AED-84C8-9DCACCE4ED0A@aol.com> <20231222123023.voxoxfcckxsz2vce@skbuf> <SJ2PR22MB45547404DA1CA10A201B2BE0A294A@SJ2PR22MB4554.namprd22.prod.outlook.com>
Subject: Proxy ARP NetNS Awareness
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.24562 AolMailNorrin

Last light the Linux Librechat was focused on digging the kernel code surro=
unding /net/ipv4/arp.c and /net/core/net_namespace.c to answer whether the =
proxy_arp feature enabled by sysctl is namespace aware.

After many hours of tracing from namespace-generating unshare --net command=
 all the way to the kernel net_namespace.c gave us some clues that the main=
 ns and new ns converged at=C2=A0arp_net_init() in arp.c. And I am currentl=
y stuck on this line 1497

proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0siz=
eof(struct neigh_seq_state))

It is unknown whether this function creates a "view" to the ARP neighbor ta=
ble such that each netns has a different view to the neighbor table, OR eac=
h netns maintains its own neighbor table. Either way, the implication is wh=
ether proxy_arp enabled by sysctl is restricted to the current netns.

If proxy_arp is retricted to the current netns, then the Debian documentati=
on on wireless bridge-less pseudo-bridge=C2=A0https://wiki.debian.org/Bridg=
eNetworkConnections may be wrong in insinuating that the proxy_arp feature =
in the modern kernel can replace parprouted userspace program.

The current documentation with sysctl net-related options are really vague =
in terms of netns interaction. arp_ignore, arp_announce, arp_filter did not=
 do a good job of disambiguating whether any of these arp features can or c=
annot work across namespaces, or the reasons for the behavior.

From the arp_filter option description, this line "IP addresses are owned b=
y the complete host on Linux, not by=C2=A0particular interfaces." is a sing=
le-netns statement, but highly suggests that arp operations are per namespa=
ce.

When a virtual ethernet pair is created between two netns, parprouted users=
pace program can relay arps across namespaces, but the kernel proxy_arp can=
not.

Thank you for any insights and feel free to forward to subject matter exper=
ts.
I really want to get to the bottom of this.

Lucas

