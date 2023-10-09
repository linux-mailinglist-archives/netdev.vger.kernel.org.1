Return-Path: <netdev+bounces-39284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5430E7BEAC3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709E21C2094D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17B93CCE0;
	Mon,  9 Oct 2023 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xkJkVuNc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D123C681;
	Mon,  9 Oct 2023 19:41:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3646893;
	Mon,  9 Oct 2023 12:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGU1GsBYsMfDNKq/cnzhpMxOZwSRQ5zSmhBza22ajCxyTKAChP//oeB8xFDL7NFde7tImnJFkIQOUxTdNCFJeCH91XYZkpNq4mpKn1mRUqQft7bcHBgvWtK32+MDigPaiV71NgIMQc7+nv1JccZHxy5KHUxn26K2GOyqRajnxGVzcm92jkLwE7gD2ogWK/zHi5OdYXr5T3CsPaXz3arghd0b5vbbZj4TIJjQLFxL/9mEpW8hqQ3wxvdv9NqpYX3yKI92eKcSIK9R7d2fE0exsPrYeV+M52m/CyWcsU5oaz2OXpV1Zn3SKK1dbMJABiQ9IWlM80R5axIHkZtE+LdUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDMMqxH85fLmcdCIBZFXzefqCnwprD99MF/4DLVFG7o=;
 b=TFSUys6d9bhrksxPluyC9MQWo646P+NtKKXWzYWtj/lGUWTF9Gyoy8ZWB9HeiHLEysMfyb6SEkLRxRwO7qAJjyVph4Z9/gAhHZBclQk+oy+RZl68ZPqdYyG/7QE8/2Ox+Pzfwx+PSgUgjpoASdb1ncsmIyNbZnAlLo/PxtkMnEVOPSnXjOtWN0sdIhA9xP8nm7PADoBcbC7kZm1a+Y7bdY6ntQhL66Cv8NwJJ6tATuP/KsJikD/S1Q+20Bf0nbvMkmlLyTSVGgufyg2lfViZjOFuXqcFn4aOJdTotCDC7U51hjRPmL0OQqpJ6YtKVVm4nXKlOzSqTeoubcTuFYYTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDMMqxH85fLmcdCIBZFXzefqCnwprD99MF/4DLVFG7o=;
 b=xkJkVuNcWYjdfBPDrD+6qfEfSXKyN/DLQK3Sc7g0PO4abovIzDKms0ozA6fihgXu9qW5j9Ng5BalqIpZELBOtxwYDgFYaX3FtWJCL7mLK2i4yWQYbltlIqa89LBwcF+YT6FJJ2o/B/L6W6TrgBVL3oq2ER1Z4RQ2o/yGzmAaKaY=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 19:41:36 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:41:36 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine support
Thread-Topic: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine
 support
Thread-Index: AQHZ8XmjDysNxqIG3UGZtitzZHc+JbA6JqaAgAL7GNCAADSGAIAEbQqw
Date: Mon, 9 Oct 2023 19:41:35 +0000
Message-ID:
 <MN0PR12MB5953E37D081382AF52C309E2B7CEA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
	<1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
	<20231004135317.2b460acf@kernel.org>
	<MN0PR12MB5953B3DD4936EAFC7BBD944AB7C9A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20231006143230.4230fdc2@kernel.org>
In-Reply-To: <20231006143230.4230fdc2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|MW4PR12MB5643:EE_
x-ms-office365-filtering-correlation-id: b04800bc-306e-40bb-5cb2-08dbc8ffbfa5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 O/SqrOx1U046nHE/OaxT+vheymgOQ2WDDj3kP1mpRGqaddYyAn7kCk4Fl6yV9Q1OiH+npzj2vTOHyKTbebFV1X1IhU4NyoJJy6Rk93F8Cy6u4ePtDVaGsJ4vzMig1CDSVtNpI2wqoSiAGY0/q60ewZZYagXm5/sjtwhBadtopsVhaEKrf5Gcc7MxCKE6AIVAgC5TfvA18DnoUkakYkcObDNmWXM826D1Zq86ymIHDdeKDxFoJsBGwIW8u0eGJE5iECprNRC/CBvrEUR53AXOpgTSZpyJQsZ38r+ApQ7lfDLsPw/QqqSwd26KBc9e8MaDEHAE+3sG/U4NS8I01HVnKyVTQg1DB68gwjX/XUgHUdCoSabXiq8bIUjFLHkDhdOwaAqPqG0EGOFLeQhcwR9UxEoe7iPvL20iogtOjVOxdM8h8ObDJgHSGZIdoVtH7zWiXmm2e6zssFm8mzOadObGf/XX6dAnQUF875+PWk2pdTOSG6YyyNryrn9CaOOUd6ryNDX9xQas9WY42OFHg6d84xD0GmPBmwrsK98EVxATBucPxdLR6lHInWfgeWyCl/Rv6CGEyKeQ4iVD9Pc/Y18dU06Lcrtyl1tzxWr0+PbHIGcaPWf2d1/zkeCvUqaelADk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(52536014)(8936002)(8676002)(4326008)(5660300002)(6916009)(9686003)(38100700002)(53546011)(41300700001)(38070700005)(316002)(7696005)(6506007)(66446008)(76116006)(122000001)(66476007)(54906003)(64756008)(66946007)(55016003)(66556008)(71200400001)(86362001)(2906002)(478600001)(7416002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ei6rOXaAuxspWq2/6jFA3z6c1auLiP/ANqsUJ1gSLbdENR/V9qxeBzKZXI9x?=
 =?us-ascii?Q?Rpxj2dT1vfOCi2lrH1o3iYAEUJn0hwav3y7CvaxsE2DHSKWHTV9ej4BT/hx4?=
 =?us-ascii?Q?fXPe4f+qplf0blHAl32SIt6q5UgEGtYI858kXMliw6ocTzGNrtIRDwlZNPKg?=
 =?us-ascii?Q?L8lYYO2gl+rGjvlMV1IB5LgYnCytJX9FjP1fUv9M4gL/vKPTw7HMa3chC0FA?=
 =?us-ascii?Q?Jgj+j02b9PoQlVNMRuM82TfeK7iu9SYuvgcJxWoCsAPmLmnagfW7RqrJifcN?=
 =?us-ascii?Q?8eSYrOid7JEKOJRPJ+U4a7tOnIY4g3jNC5KqoN1GnZKj1VfHMWiQZQ0I/n70?=
 =?us-ascii?Q?vsqPZo+vM7Fh5r02+us3gNt6eoDPVtQ2mbqHu+iYCc8g0aIvrCP+EJkI1Nec?=
 =?us-ascii?Q?cQc+6WzzJxtwhgktRwVJyB3EEBfRvrCQw71zoynSdw2JSaUF0kTKHzRvG0T5?=
 =?us-ascii?Q?RXb8KzByYpjuXOhJ0SKc0QvnOV0Uxneuh5BODocGCLkwofEBqxjb93Yz0lUj?=
 =?us-ascii?Q?Mb5g0mHdyi1kbEmEP1lErYURR93qhhKii5wBPoSRIkY1V6SZREa0YLdqNuwA?=
 =?us-ascii?Q?Z9EsSiESnuto3TaM28dZ+I8jEyJDyBHpojXHN74ZSRjgqcUPJfz28KhLOja9?=
 =?us-ascii?Q?5Ao/n7iQCYGWGVzoazuGkwrbuLW07TRD4exHMq0ifcScTG0fQMiT+hdVmBAI?=
 =?us-ascii?Q?i9P+CF7uisJSTDKdFCaSm28TftORTCF/8W5L0Zx+hLf2yVOIdrjsgZtfE3jH?=
 =?us-ascii?Q?Gj4HQdsALJ7M8CYRvY6/t4sovZU+jQSR8PF3eKHKPys1Vvx6nMZPlyT4QaWN?=
 =?us-ascii?Q?Ewwls3CX8A0TanThSPLR5nE8WcczzXv+mFtNkcv8iU6wgINTShwhtuDkyyRg?=
 =?us-ascii?Q?+QFpvAr/Lmxo+JbkDemmp6dCuToLuMik76h2q9l1ZU8HkzABRu6d+A+Fxv57?=
 =?us-ascii?Q?VkNdu/hXJYctC7JdSUEkMvSBpdpd9a1ZjoVp3NmXD6wXNXwqOd2gipYrFu7y?=
 =?us-ascii?Q?ReJ07UWxniO+qcFTe16U9ZxbXWXf3P3ToWnBsOIW2ZGbsUClwouIHF+dF6Ta?=
 =?us-ascii?Q?gkrRHOJJy54tvOugCM/wZdGhBfFTfMfLDIc8d+RhRI6yiWI7z43mTZojyaO1?=
 =?us-ascii?Q?EvHSKqfUB5bR5L2ACyKLLCgMZNszGB6EtKgHjc43Kmqc0E1rSTYAUHzEo5Dn?=
 =?us-ascii?Q?XUZunvPte9mFZqHv2DZYK/oKnca2aL12QvIAVM9AWPyp5VYrXcQ1AnzsccAp?=
 =?us-ascii?Q?PznhQfBBjSRBWiHoaq2HjH0rp05X7cPArr7vBMlWeLzk8/1K16nBlFW9MRd+?=
 =?us-ascii?Q?/AGVBKtTnZ5RGakTFEPgN38CZgz61EO2ewuzHIgs+J8dzJ/Ob95R1H9PgfWY?=
 =?us-ascii?Q?uZU4cvzYvZWUKNV4xQfdHfJRdcVRgebCYVPcWW1yzp4i6qF57WfAyoh+IT6k?=
 =?us-ascii?Q?iqEqwQMGxaPzssojfSb9qSSZ1FlQbkT0SvZCdBm12qs7Fca7rp+gb20gCL5e?=
 =?us-ascii?Q?ke1uw23B1PpLMI819pYCNpYQvXCvOjUj+jUyqorVS5VhDeNJI4H/IZyzPJB1?=
 =?us-ascii?Q?lFylHuid9Eh44K+Jny1mOF4qNEC1mLVbsqfF0jUnb4Jl0L0dXyibbj4PYy28?=
 =?us-ascii?Q?a+J1MuEtqDSsdRE901VJ03k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04800bc-306e-40bb-5cb2-08dbc8ffbfa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 19:41:36.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfGwNBkDTxbQVUapvy7I6QyGwymOZiEjDvxW1rx7/c64ZMUyrgRwJai2Ra+0+Cdz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, October 7, 2023 3:03 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> linux@armlinux.org.uk; f.fainelli@gmail.com; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine
> support
>=20
> On Fri, 6 Oct 2023 19:04:29 +0000 Pandey, Radhey Shyam wrote:
> > > > +		netif_stop_queue(ndev);
> > > > +		if (net_ratelimit())
> > > > +			netdev_warn(ndev, "TX ring unexpectedly full\n");
> > >
> > > I don't see you stopping the queue when the ring gets full, am I not
> > > looking into the right place? Otherwise this is sort of expected to
> > > occasionally hapen
> >
> > We are calling stop_queue if TX ring is full. Is that what you meant?
> > netif_stop_queue(ndev);
>=20
> But somewhere else or just here after printing the warning?

There is call to netif_stop_queue(ndev) just before this netdev_warn.
I copied below for quick reference.

+	sg_len =3D skb_shinfo(skb)->nr_frags + 1;
+	if (!CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX)) {
+		netif_stop_queue(ndev);
+		if (net_ratelimit())
+			netdev_warn(ndev, "TX ring unexpectedly full\n");
+		return NETDEV_TX_BUSY;
+	}

However, I noticed above check doesn't account for all frags - so will=20
modify the if check to see if available space is less than sg_len. If yes, =
then=20
stop the queue and return busy , else continue with xmit.

>=20
> The recommended flow is to stop the queue after enqueuing a packet
> successfully, if the remaining space is not enough to hold an skb with al=
l frags
> populated. That avoids ever returning BUSY.

