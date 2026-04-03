Return-Path: <netdev+bounces-274938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCj/F+t6z2mvwgYAu9opvQ
	(envelope-from <netdev+bounces-274938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:31:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6039219E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED7D303989A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F90B372EC2;
	Fri,  3 Apr 2026 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfzU6jsS"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03A2BFC60
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204636; cv=none; b=dkRi/1C3uIT1gifybY2pEwnwy5liCLdeJOsZ+o8CbNAG2bxIMtAcS4E03w67WgPwMW96FVTL2IUHUqmHZcGQ/5I+vuYIKu5VQ6oYczt9msyuOsKJsRx8tcIDtVIRR6xf35uhFK8Erf0VC8h8QcdCgtUBNBd1+CGcGVsIYL5kZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204636; c=relaxed/simple;
	bh=hTsslI0Z4XPKfpQPNF/pjG2gBW6ZCUbjArtm7AN+VYs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sONnZepn+MErc0FKK41tT0O+Gd8hQ4DkDtgUoDWXy9Vyj26/CwTS2d2rYmeiX8pIGzOv+STwGmVHKdViyOS1/l70BRTJ2rRtQWNS6ja88J+ApUzN7owVvcu5sKJ3yEu9/MnlsIyHbMnfD3s6jx4Zo3QdygD/o/g5A8346jcapjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfzU6jsS; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 03 Apr 2026 10:23:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775204622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+Y5FvcTlFgFN2SNN70xIA2iRj8AOL6L5zCnK8NYSpA=;
	b=YfzU6jsSMYkGjW+dM1NzvctmmMgu3rk4l4KeGBkxoE7aSsZDJR2lUFz7oKeTAZ0YbdOzFT
	COP6uMo8Qza9UTyWgOmccf4tx0910dOXSC9sl/cYe9uUrKpMc8juHNMla3yS8ZsUycQP4s
	RZ/bLJmOZeZCY22IprH328WgwSaqkbE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Frank Wunderlich <frank.wunderlich@linux.dev>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 =?UTF-8?B?QmriiJriiI9ybiBNb3Jr?= <bjorn@mork.no>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Eric Woudstra <ericwouds@gmail.com>, Alexander Couzens <lynxis@fe80.eu>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Felix Fietkau <nbd@nbd.name>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_net-next_5/5=5D_net=3A_pcs=3A_pc?=
 =?US-ASCII?Q?s-mtk-lynxi=3A_deprecate_=22mediatek=2Cpnswap=22?=
In-Reply-To: <20260402095300.hujib22ag6g5wkts@skbuf>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com> <20260119091220.1493761-6-vladimir.oltean@nxp.com> <e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev> <20260326215404.krh6v3mmnqdlndli@skbuf> <d9639ac711ff8f1186a684fa120ba77247669051@linux.dev> <20260330190443.bol5vjfqqitz7kuo@skbuf> <4dbc3dabfdbc3bdf6b8d411e62a27fa8988e3388@linux.dev> <20260402095300.hujib22ag6g5wkts@skbuf>
Message-ID: <C59EED96-3973-4074-A4D8-C264949D447E@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,fe80.eu,arinc9.com,mediatek.com,nbd.name];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274938-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank.wunderlich@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B0D6039219E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Am 2=2E April 2026 11:53:00 MESZ schrieb Vladimir Oltean <vladimir=2Eoltea=
n@nxp=2Ecom>:
>On Thu, Apr 02, 2026 at 05:50:33AM +0000, Frank Wunderlich wrote:
>> Hi,
>
>Hi,
>
>Please don't top-post :(

Sorry about that=2E Try to do better future :)

I keep context for now (not removing my findings from early mail),i hope i=
t is ok=2E

Maybe daniel or mtk can respond if my understanding is wrong=2E

>> i tried using these properties in sgmiisys0 node (which should be mappe=
d to mac0 and the mt7530 switch) without success [1]=2E
>>=20
>> it looks like these properties are not read somewhere=2E
>
>Can you please clarify whether your problem is with the SerDes connected
>to a switch port or to a GMAC?

From=20my tests it looks like the issue is on switch side=2E

>Because if to a switch port, mt7531_create_sgmii() doesn't have any
>phandle to the SGMIISYS=2E That was from existing code=2E
>
>		pcs =3D mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
>					   MT7531_PHYA_CTRL_SIGNAL3);
>
>The LynxI PCS will be instantiated without a fwnode and only the
>defaults will apply=2E

This was a good hint, i had only seen the pcs call for mac=2E

>> the flow is
>>=20
>> mtk_probe (eth driver)
>>=20
>> if (MTK_HAS_CAPS(eth->soc->caps, MTK_SGMII)) {
>> 	err =3D mtk_sgmii_init(eth);
>>=20
>> and there calling mtk_pcs_lynxi_create with the sgmiisys-node (for each=
 mac, so imho mac0=3Dsgmiisys0)
>> but handling the sgmiisys only as syscon, not a "real" pcs node [2]=2E
>>=20
>> but your new code calls phy_get_tx_polarity and should read out this pr=
operties, but from subnode "pcs", so next try was
>>=20
>> &sgmiisys0 {
>> 	pcs {
>> 		rx-polarity =3D <PHY_POL_NORMAL>;
>> 		tx-polarity =3D <PHY_POL_INVERT>;
>> 	};
>> };
>>=20
>> which results in completely strange behaviour (looks like sgmiisys1 is =
mapped to mac0, but based on code in mtk_sgmii_init 0=3D0 should be right):
>>=20
>> [    2=2E765218] SGMSYS_QPHY_WRAP_CTRL =3D 0x501, will write 0x500
>> [    9=2E143849] SGMSYS_QPHY_WRAP_CTRL =3D 0x500, will write 0x501
>>=20
>> but nevertheless i tried changing sgmiisys0 to sgmiisys1 and got the da=
me result as before
>>=20
>> [    2=2E713644] SGMSYS_QPHY_WRAP_CTRL =3D 0x501, will write 0x500
>> [    9=2E061509] SGMSYS_QPHY_WRAP_CTRL =3D 0x500, will write 0x500
>>=20
>> i can only change the second serdes with sgmiisys0, but not the first=
=2E
>
>I assume the second SerDes is mapped to a GMAC port which does
>instantiate the LynxI PCS with a fwnode, right? If so, the behaviour is
>consistent with the code=2E Only mtk-soc-eth uses mediatek,sgmiisys AFAIC=
S=2E
>
>> mapping between mac and sgmiisys in dts in mt7986a=2Edtsi [3] are like =
this:
>>=20
>> eth: ethernet@15100000 {
>> 	compatible =3D "mediatek,mt7986-eth";
>> 	mediatek,sgmiisys =3D <&sgmiisys0>, <&sgmiisys1>;
>> 	=2E=2E=2E
>> };
>>=20
>> &eth {
>> 	status =3D "okay";
>>=20
>> 	gmac0: mac@0 {
>> 		compatible =3D "mediatek,eth-mac";
>> 	=2E=2E=2E
>> 	};
>>=20
>> 	gmac1: mac@1 {
>> 		compatible =3D "mediatek,eth-mac";
>> 	=2E=2E=2E
>> 	};
>> };
>>=20
>> maybe it is time to revive the PCS framework discussion ([4]-[6])?
>>=20
>> [1] https://github=2Ecom/frank-w/BPI-Router-Linux/commit/4846a7bb352fe5=
911136cba33813f099bac035fd
>> [2] https://elixir=2Ebootlin=2Ecom/linux/v7=2E0-rc4/source/drivers/net/=
ethernet/mediatek/mtk_eth_soc=2Ec#L5001
>> [3] https://elixir=2Ebootlin=2Ecom/linux/v7=2E0-rc4/source/arch/arm64/b=
oot/dts/mediatek/mt7986a=2Edtsi#L528
>>=20
>> [4] * https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch/20250610=
233134=2E3588011-4-sean=2Eanderson@linux=2Edev/ (v6)
>> > pcs-framework itself had not yet got a response from netdev maintaine=
r (only other parts)
>> [5] * https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch/20250511=
201250=2E3789083-4-ansuelsmth@gmail=2Ecom/ (v4)
>> > discussion: https://lore=2Ekernel=2Eorg/netdev/20250511201250=2E37890=
83-1-ansuelsmth@gmail=2Ecom/
>> [6] * https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch/ba4e3595=
84a6b3bc4b3470822c42186d5b0856f9=2E1721910728=2Egit=2Edaniel@makrotopia=2Eo=
rg/
>> > discussion: https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch/=
8aa905080bdb6760875d62cb3b2b41258837f80e=2E1702352117=2Egit=2Edaniel@makrot=
opia=2Eorg/
>
>I'm not exactly sure how device+driver for the PCS devices would help in
>this case though? Because the LynxI PCS driver would just retrieve the
>fwnode on its own, rather than it being passed by the mtk_pcs_lynxi_creat=
e()
>caller?

Imho it could be more general and cleaner than calling "external" function=
 in code=2E If pcs acts
as own device i would see which dtnode is assigned to it=2E=2E=2Ehere i gu=
essed both calls were
from mac,but one was from mac and one from switch=2E
I tried adding prints before the lynxi call,but this does not make it clea=
n from where it comes (i guess because of threading)=2E=2E=2Ebut this could=
 be understanding issue on my side=2E

It looked like this:

root@bpi-r3:~# dmesg | grep 'SGMSYS_QPHY_WRAP_CTRL\|pcs'
[    2=2E155221] mtk_soc_eth 15100000=2Eethernet: create sgmii pcs for mac=
 #0
[    2=2E168308] mtk_soc_eth 15100000=2Eethernet: create sgmii pcs for mac=
 #1
[    2=2E699744] mt7530-mdio mdio-bus:1f: add lynxi pcs for switch (port5)
[    2=2E706773] mt7530-mdio mdio-bus:1f: add lynxi pcs for switch (port6)
[    2=2E707881] SGMSYS_QPHY_WRAP_CTRL =3D 0x501, will write 0x501
[    9=2E081259] SGMSYS_QPHY_WRAP_CTRL =3D 0x500, will write 0x500

>We need to have a very good model of what happens when the PCS provider
>goes away, especially in multi-port scenarios=2E It is a similar issue as
>to what happens when a phy_device goes away=2E
>https://lore=2Ekernel=2Eorg/netdev/20260311153421=2Eu454m3e4blkstymt@skbu=
f/
>
>I'm not saying "let's not do that", but we'd effectively introducing an
>issue that currently does not exist, with the PCS lifetime being managed
>by the consumer=2E
>
>Do you have any better idea by now why SGMSYS_QPHY_WRAP_CTRL is 0x501
>for SGMIISYS #0? Is that its out-of-reset value?

We guess that switch takes this value somehow from an efuse or similar=2E

I have 2 ways to fix this broken state:

1) to keep dts backward compatibility and due to undocumented behaviour i =
prefer this patch:

--- a/drivers/net/pcs/pcs-mtk-lynxi=2Ec
+++ b/drivers/net/pcs/pcs-mtk-lynxi=2Ec
@@ -129,6 +129,9 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynx=
i *mpcs,
 	unsigned int val =3D 0, tmp;
 	int ret;
=20
+	if (!fwnode)
+		return 0;
+
 	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
 		default_pol =3D PHY_POL_INVERT;

2) document pcs polarity (i'm still unsure if this is really correct as i =
cannot measure in hardware,just from software debugging=2E=2E=2Ebut not sur=
e if the SGMSYS_QPHY_WRAP_CTRL offset is valid on switch regmap too) - it l=
ooks for me that by default is different between mac and switch side:

<https://github=2Ecom/frank-w/BPI-Router-Linux/commit/f693e2ed24287ce1e125=
d7f6202e14e263cc564d>

And add dts nodes like this:
<https://github=2Ecom/frank-w/BPI-Router-Linux/commit/4f7bce943dda614d2443=
1d63adad65f1117a7f6d>

If i set same polarity to mac it is broken (thats why sgmiisys0 is disable=
d)=2E I guess the pnswap property means "invert the default behaviour" and =
not "use inverted polarity compared to standard" and mac and switch use the=
 same polarity with different values of the corresponding registers=2E

Based on my register documentation of mt7531 ("MT7531_Reference_Manual_for=
_Development_Board=2Epdf" page 729) i see

000050EC =3D QPHY_WRAP_CTRL
Bit 0
1'b1 : inversed TX_BIT_POLARITY TX bit polarity control (TX default invers=
ed in MT7531)

Where bit 1 is only defined as "RX bit polarity control"

So my guess is that tx is inverted in hardware,but tx-bit is set in efuse =
to get the POL_NORMAL=2E

I did not find the register in my mt7986 register documentation=2E=2E=2Ese=
ems complete networking part is missing=2E

I do not expect that board changes polarity in hardware=2E=2E=2E

Regards Frank

