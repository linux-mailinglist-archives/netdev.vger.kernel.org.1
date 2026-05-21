Return-Path: <netdev+bounces-290534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDY0BlotD2oiHgYAu9opvQ
	(envelope-from <netdev+bounces-290534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:05:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F41FB5A8DEC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23A333043A5A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F5634B19A;
	Thu, 21 May 2026 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pczUz5ZH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02613A3F7;
	Thu, 21 May 2026 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377206; cv=none; b=oQa2Mjl0UxUVd3ujNODwb48uaEzy+nkjeAw7iieCWkee8kmhaJdPdtF4lIz1UomdbeYJu/+K5q+t1ciWWQOmC4WcYJSZDGO7LYUkgs7tTYCbaz+ewp8k6MfH970NLBVLeOXlGj+1VKRjQwJoRBYjjcc53/4+Tu0eaURGLJ+LPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377206; c=relaxed/simple;
	bh=NjTV9wErr90HIRWMANQCbcIn81/Ww7SxNE3IXLcUfL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CK4A4kwdOUR3Sdx1P9OXf/t4UIZ25QrtSdhxG1hagO70z+3umINVNbnhmRXlvOk0q6bYbQG79qA926x0Wybbep00OtVzLJg/hMsqxtaJey56RWdIrZuWOR1LlbgboGxW2Au+t7iZz/GQxrV3cvTvkYoKwaHhtVBfWMWaVaasMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pczUz5ZH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFCVOq602544;
	Thu, 21 May 2026 11:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FmZKf
	l/heQb5UySQH7tRcGdMLc4r+FfsLwQUy8vSFMQ=; b=pczUz5ZHaEEUWimyhdAQD
	JLDGtoaH32hI26LtqRgE94iHLr+KV0i1m+lWsoxulGIukAEcjdQdATm+w2XCxd0U
	ibRGjuF2Hml7nvxEbThI/lIL/nXk6W8u2PEIQlXnCTqyxyEFzru2hpxorBPfS4d6
	G2lDvTJDmzbpjxA+E/exGPov+6Z9d0+ejHNYah6bkn29dZjk3DeHeHj4H/vgRZfB
	5UWor2FxrN5DXaeDklx5L+Hx+JDgyLX0seH5nuWXTLPL0IN110neCZ8dDcYySPrf
	ThmaGHXh7Rm6ocoT6qJVlMUTloARvuYm2kulD/r5CGWkBDg/O/WwWta1ROd9n29W
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e96srxns3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 11:26:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LFQIfO056633
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 11:26:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 11:26:18 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912]) by
 ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912%20]) with mapi id
 15.02.1748.037; Thu, 21 May 2026 11:26:18 -0400
From: "Regus, Ciprian" <Ciprian.Regus@analog.com>
To: Andrew Lunn <andrew@lunn.ch>,
        Selvamani Rajagopal
	<Selvamani.Rajagopal@onsemi.com>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Thread-Topic: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Thread-Index: AQHc2osAciE43cRop0O+PxH5WaJSLbX77fcAgADmRoCAAAjwAIAby2dw
Date: Thu, 21 May 2026 15:26:17 +0000
Message-ID: <7a533f60e3d04098bd0671ce0e925f9a@analog.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-2-dd043cdd88f0@analog.com>
 <aad9cb98-8f1f-409f-8d58-0318e125210c@lunn.ch>
 <CY8PR02MB92498A398D3F05B94EEB7ED383302@CY8PR02MB9249.namprd02.prod.outlook.com>
 <77df32ed-3e22-4e9b-941b-3046de25b88f@lunn.ch>
In-Reply-To: <77df32ed-3e22-4e9b-941b-3046de25b88f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: EE2ERHwi83D3olTG_Kg58ltA4dJFUxU8
X-Proofpoint-GUID: EE2ERHwi83D3olTG_Kg58ltA4dJFUxU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE1NSBTYWx0ZWRfX/1tPD3SIz4lV
 Ui0//c2FeOR0nLSThYlXINIQQ6Mj5FxuNNXftwa4s1dhIIuHGE2XEM8rqnHZgRB5DrcaY7GY2hj
 S3MJJZBBxzT7ubaqQDlR+A3F8DaMECtVa7mMgasQxQEFR4FXbxqN07NqLlhZ8HAPG/3l6evQQoP
 IdzaiNzZkaO36nhKVKGbfJg9vjofxp7KM1C0uABry5jw9XeILVgE+NnbkWgZRsriJGdsaj/R6v6
 gV5x7zmyV3nos1+fQZ2bEiTF1xbiyg/N/uoUKD8LNBIi0SfohHg8XK4ZNH97ePpD+G+b1Ug3KPe
 yYOPIlGgh9nI0IQSsWcWABYv2FD31JFi4mdxBdu33sjp9YVjF0tsQ5kglsdCiRnFCJaMpk6m3fS
 J2UaKtApaC6OJOrlJFnQpCieh7FE5TP/tbG7GZVtfQtZkgnZxgiByZglJl323nvFeg2cWyvZSFR
 kflW0N2kc/nYsMNlohw==
X-Authority-Analysis: v=2.4 cv=CZs4Irrl c=1 sm=1 tr=0 ts=6a0f241c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=xqWC_Br6kY4A:10 a=3zxtOzucoeEA:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=Kcc3aBsA6gr13z1jP8UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210155
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290534-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,analog.com:mid,analog.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ciprian.Regus@analog.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F41FB5A8DEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> > > This all seems pretty invasive and ugly. Please could you think what
> > > happens if instead of passing in an mdiobus, you pass a phydev. Is th=
e
> > > change to the core simpler and cleaner?
> > >
> > > Andrew
> >
>=20
> > Kind of agree. Initially we were thinking about changing the
> > existing code (Microchip's vendor code) to alloc mii_bus so that
> > code would be same across multiple vendors. Either way, it would be
> > invasive changes. So, we decide to go with minimal change to other
> > vendor's code.
>=20
> That would be wrong. The standard defines this, so it should be in the
> core. Anything which the standard defines should be in the core, so
> that drivers for hardware which actually follow the standard are
> minimal. Also, we try to keep workarounds for broken hardware out of
> the core, hide it in the driver. That is not always possible, but the
> aim should be to make the core clean. We don't want to penalise
> vendors which got the implementation correct because of vendors who
> got is wrong.
>=20
> > Trying to understand your suggestion. Are you suggesting to move
> > entire mii_bus allocation/APIs implementation to vendor side and
> > keep only phy dev usage in oa_tc6.c?
>=20
> No. I'm thinking maybe extend oa_tc6_init, similar to what you
> did. Add a quirks flag, and define TC6_QUIRK_BROKEN_PHY. And allow a
> phydev to be passed as well.
>=20
> If the quirk is set, don't call oa_tc6_mdiobus_register() or
> phy_find_first(), nor oa_tc6_mdiobus_unregister().
>

The issue I can see with this approach is that we should have already regis=
tered
the mii_bus and read a valid PHY id from the device, before passing the phy=
_device to
to oa_tc_init(). Scanning the mdio bus requires OA TC6 SPI transfers (readi=
ng registers 0xFF02
and 0xFF03), while oa_tc6 has not yet initialized. For the ADIN1140 driver =
this is not an issue,
because we can return cached values for the PHY id, as you suggested. Howev=
er, that limits
the usefulness of the BROKEN_PHY flag, because every new driver that cannot=
 use the default
init sequence in oa_tc6 (and wants to set the BROKEN_PHY flag) has to fit t=
his specific case.

I think the approach which involves the least amount of changes in the core=
 would be for oa_tc6
to skip the oa_tc6_phy_init() and oa_tc6_phy_exit() if the BROKEN_PHY quirk=
 flag is set and
leave it to the drivers using oa_tc6 to handle the mii_bus alloc/register/u=
nregister/free and
phy_connect()/disconnect().

These would be the only changes in the core's phy handling path (besides ad=
ding the flag itself):

@@ -585,10 +586,13 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 {
        int ret;
=20
+       if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
+               return 0;
+
        ret =3D oa_tc6_check_phy_reg_direct_access_capability(tc6);
        if (ret) {
                netdev_err(tc6->netdev,
                          "Direct PHY register access is not supported by t=
he MAC-PHY\n");
                return ret;
        }
...
}

static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
{
+       if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
+               return;
+
        phy_disconnect(tc6->phydev);
        oa_tc6_mdiobus_unregister(tc6);
}

> You probably want to start with a patch which breaks oa_tc6_phy_init()
> into two, since you still need the phy_connect_direct() and
> phy_attached_info(). Then add the quirk, and lastly your driver making
> use of the quirk.
>=20
> The quirks flag could also be used for devices which have MMD 30
> mapped into a vendor reserved MMS.
>=20
> 	Andrew


