Return-Path: <netdev+bounces-236483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E45C3CE04
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC81890AA8
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18134F251;
	Thu,  6 Nov 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wwbIo3/l"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CC340A74;
	Thu,  6 Nov 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450611; cv=fail; b=sloqskW8mdBqF1MZ23sjSO0ko//d6qeJkpMpNqly19cDuNGwPxNZXWEzjxpSqZfMG/4QR5h688yT/R4FqpQa73rJiEnUShNwzLNZxA7OJI7MdiLNi18wqQoswRWV8fZijyyQM73gMyfV6m5UMCjeokXbfmFa0pWKhsKkWuVgOhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450611; c=relaxed/simple;
	bh=zdyYepPC0gVmLhgbO5LCYcI2bsp9j1LS+PL5BxxJzjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9w4n+3jjEsGNYSjQj2Z/xnl5pAOKNZfDuvL24L/ClXXN1LJNKENy+gBEV3pkrubqiiS8XzfDNrXuIghZTVcjkPuzzPaOcBsk0o0CyVo5kTYQjGOCoc89IxJ60uNkqA4+6aXqK4MJFUw0/kgyuAA2hcXvjTWPCFJjL+dW4dgwvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wwbIo3/l; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPrB++HTupj03ZRFDBNrkr05aL553CGq79P6vWiRjrJmErsaRpnhnORsQ/2wXcHpOaP31dlk2BdzkJ97xNljuEcK3GvxYZ8bBl63fmjvjq3SxwIvkkvnqIxyZ4w0RWjlcKgXEGZ6UMtYYVFK4MFmAOoNmzJTwl2jlXS+0ufgNe920KkRUQgyYf2PBquxAA3AG4+sqbohrCYhKMR9SK4aFGNqEbJJYoA1r6332eo8NRbwoVw89+d0m6siH+1xD25V2r9MBmKvN8iwVGtleOLL5JglP3QumrBRLeyKsMS57Vd/ETCMkC1datQYDvT723GfVh5nQhviv0DIKmSF/q33Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdyYepPC0gVmLhgbO5LCYcI2bsp9j1LS+PL5BxxJzjw=;
 b=L4NtnMH+AUjTMftZzsGkvfVXvB2LHJrQofSBpphegXcAnZJmAZav4Z+YNLZ1M0rzV5Hd0XFt8XWb4y+m/Z4TArRsL20o+M90UdDsgt0TTwAld8LQ8UjFXGc6Z9gxPKcy8Mxoh6/ZtCXJFExIfXpqyP04hKSIoei7ZgDAbbEsAl0UROMJu5LCLDTykgtjUfV7qTXTxpOEN0lRop9GYs85irlan86kmhqkR9ilSUUoeWMMYjpIBxGUvJoQpSJlM0IX+Epgi9ujlZnaetV5/j354jdvkMFHOv4AgrFTmS01FtmX66c5OAfaztECY5FBplw9GlvOJQtEsPkVn8MPsLoWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdyYepPC0gVmLhgbO5LCYcI2bsp9j1LS+PL5BxxJzjw=;
 b=wwbIo3/lUwhFCiQ0oP+isGbpfZgSqGS2fC1ovYoWdTnTFO00reXYkaep0CZ547NveJDbMr3FOOxt91Zk//e0aNR33WDnJ+wSwnK25aB96ruVRhG3XrtAVumJck0ylWe1yBLBKrhtPs2SQafgyc23KIv+Mpp9sAcZZuoijlQBRDDdv9v5qCydROh2C8ff8FgD38sihoSZ4i8OAx6OTO95/1dIwXGj1gC7oTQUrFUDgq9rwXmpXq3Lii4wyee8sXBteBRQc+erUAERodZ0UY3PT5NrezNpEJUZoccuTfnoz0An8IzPN9Yog0bA8zSC2co5yUcQ64J6Ix7jpRQCurRRNQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM0PR10MB3571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:36:45 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Thu, 6 Nov 2025
 17:36:45 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "robh@kernel.org" <robh@kernel.org>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>, "john@phrozen.org"
	<john@phrozen.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "bxu@maxlinear.com"
	<bxu@maxlinear.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "fchan@maxlinear.com" <fchan@maxlinear.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "hauke@hauke-m.de"
	<hauke@hauke-m.de>, "horms@kernel.org" <horms@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Topic: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Index:
 AQHcTLxDDivhhsZUI0Sg1sdKzKnvuLTiKW4AgAOg3QCAABBvgIAAAuwAgAAO0wCAAAHjgA==
Date: Thu, 6 Nov 2025 17:36:45 +0000
Message-ID: <c1b631eacec2f138eb44fbfa4c0ae056bafa4610.camel@siemens.com>
References: <cover.1762170107.git.daniel@makrotopia.org>
	 <b567ec1b4beb08fd37abf18b280c56d5d8253c26.1762170107.git.daniel@makrotopia.org>
	 <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>
	 <20251106152738.gynuzxztm7by5krl@skbuf>
	 <471b75b6971dc5fa19984b43042199dec41ca9f3.camel@siemens.com>
	 <6c4144088bbf367f6b166b4f3eceef16afdc19c1.camel@siemens.com>
	 <20251106172958.jjfr3jbzlyexmidg@skbuf>
In-Reply-To: <20251106172958.jjfr3jbzlyexmidg@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM0PR10MB3571:EE_
x-ms-office365-filtering-correlation-id: efc2147e-6673-479f-5e7a-08de1d5b0e5b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ym40Nm5PcW8wbEd0NkU0RjFrZWtWOVNMZ0wyQ0g3eUQxTUw0cU5DVmVCckZO?=
 =?utf-8?B?cjZMRTVNSlRVbmpRMFZWTkViMG91TnFRQnlobG0zdER2c28rdFk5bHl1MUZh?=
 =?utf-8?B?WGpmb2wrNjJmM1dYRGJ0enc2L29wZ25xNE1JZkhXUmZPbUo2MnFQdVZLVG8x?=
 =?utf-8?B?SjRBYUJmNm03d0h3dUkwd1dab0NhQXQ1NVBjdmhSQTdLRGNFZjNzUER1YlpS?=
 =?utf-8?B?RGpXbE1vaGZNdzNLOUFFRlI2RENmVHhKbFVRVGRCVEk1YkZtaVVmRCtzVkVa?=
 =?utf-8?B?UFBua3U3eGd2Q3BzMmQveFVhRGxuZXR4dVRYUTZweHR4MEU0UUg5NDJ3ZUlM?=
 =?utf-8?B?QWVuOXFjVTE4bmRuNm5QWEs0RXZSODJNUmthWUIyREcxVUtKa05QZThnZWZp?=
 =?utf-8?B?TzNkSU0zYldZVForWnJFL29CYlByc0NFTVhBRXVTOGF2aUQ0N1l5WjgwVHZQ?=
 =?utf-8?B?blBGaW5zUFQwRmgxL3U2dE85b3ZYQjRSUSthTnVGWi9DblVETDREUEh4QzdC?=
 =?utf-8?B?SitXNEphY0tITmdIRzkrakNJeFVwRVBYZ05IQlhuSjlMWDgzRzNJcHhFWTQ3?=
 =?utf-8?B?Yy90SXhlQnIxR0hUYW8ybUcwMkI2QUJLS1FiNEZpZmFIc2laK01zRXQ5Rk0z?=
 =?utf-8?B?TGd3a2FYbFFMK20xdXlobFVtbVlQWkRIcnlhN2t6Uzg1ek40Q0JidlJzK0pB?=
 =?utf-8?B?Y29wZXhzaUN1QW9BbUVsU0hGUUxLb2YwcVVlalJDZmQvbHc3TForaVJtZlhh?=
 =?utf-8?B?MDBLV2NtVnVYNFM3emtoOEdUR3ZlSm5zK1MrYXp6WnlzYTRYRHArRml4UGtU?=
 =?utf-8?B?Z2w1dFNYZGdaalRHTGk2cXg3SWtmbFVkQUFhdEc3emhXc01NVjIxUjgraENx?=
 =?utf-8?B?VnIwRTFqQVR1NDdudEFUQXg2ZTR4ZEFYZWdOOTJKOGg1ZGt1VXRlVTVwQ1BL?=
 =?utf-8?B?QmRyMlZpNFUwaXlzN014NW0wWTM5R05kZkpJTzRqbU4wS0RHemM3dm9Vb0ha?=
 =?utf-8?B?K2lkUStyTEk3MUVuNmdFTU81OXBKNmRBN0hsTTcyWlcrT0NycEVMM2p2dEgx?=
 =?utf-8?B?TWpXSGpIK1F6SzJJZ1BEa0pXNFFQbXNuWERaR0FMWUZPcFhSQjRwSWRpVDlE?=
 =?utf-8?B?Sk1LbkFZb3E4OWc4dW5JOHBmdUx1cVNveVRjamY5MXVVMGFRR2wrMENNY3pl?=
 =?utf-8?B?Z2VnbVhCeFdMS0xFYnQ5NC9WdVVoTFhTUWhiU2ZMTjg2Mmp6a3owTlU1Ym84?=
 =?utf-8?B?VHBRaEFQTWhjdmxqQTZNazU4UXZ2Qjc5WGtCay9xK0pueVlzMFJ4NDQwZG1I?=
 =?utf-8?B?Q2syK1MwdDRLMFNXQm5XQTRXMUVJVTNZeWZUZW5reGIzZWp5N1Y2Z2VSUTE2?=
 =?utf-8?B?anJlL0xRWUlVdkJpdjRORDlMTmhKV0tRRENuT2wvUlQ5eUxhMit5a1dKTytr?=
 =?utf-8?B?SW1rQ1BhdUhyMW9hWEJ5bWJUQTJLWTVMUE44NmlzQ245aU5jV0paK24wZHRl?=
 =?utf-8?B?NCtHVjBMNVhXSGNnT3JSaE0vNFc0T3lxVUxCeHdDbmdkNlF4WFU1V1BQclZz?=
 =?utf-8?B?TE0xOFZja1oxTlQ4VUdCOXcwdUJlMFZCWXRjbmlCSGFNQ1gzNUFMMXJDSTVj?=
 =?utf-8?B?b01uUkc1S0JtM3lGS1lQRTJ1VnE2aFQ4Qi8yTXd1OFJJOGdtYXV2OFhtOXBL?=
 =?utf-8?B?b0JkTUJ3aGxRMEQ4dVBQOFRIZlFHT25FMkZpb29sR1RtdWVxU0lra0FoelM3?=
 =?utf-8?B?WmFKUk9QSFNVbC91WU5LOWtFeXRuaVEzdFd6RWN4M05adEllYXlHZG1UaHk4?=
 =?utf-8?B?WVpJZytYZUhOa285VWxwK3J3eHBDVDFUZWI5TkdIZmlTNGlzdzlhTy9IRVRi?=
 =?utf-8?B?V3IzR0xSZXJMVmJ2b2M0VGlqT29RcDRML2hyRG5qOFUvTmoxYUdrZCs4dXpi?=
 =?utf-8?B?clFiMk85Szh4eDdvY1BIMEZsbExBQVkzWmNGTnl4VGJJcDlUdDlpNVVwaDk3?=
 =?utf-8?B?Z1pCa3NGVWV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjRnUm1wV1JzOTFCZmllSmZQOElwd0ZqdmFCc08xTUV6WTZ2dTlvN2Y3ajFh?=
 =?utf-8?B?a280a2t5eE5GYXFxdFd6cWNUQ1ErODlqUEJySzBKeGZBNmxaazdmVGlUN1ZM?=
 =?utf-8?B?ODMxc3NzeXUrOTZVQVJ5TVBaMEtkblQ4dWMwbFhWTVlmZXZMeFhPamhLRXBu?=
 =?utf-8?B?YVFNUmFySTVSaTFsd0J1dmdWTzRKZ3o2QjNra09MdDd1Z2ZmbngrZXBUYWdy?=
 =?utf-8?B?akpJNUlHRDlsOS9nT1Via1lIaEZMZzYwckNZL1NUUkYvM25WakpWWHRFK2Zk?=
 =?utf-8?B?cFR0a1FIMlR2OGhBUi8rMThTc2p6RlRPa2tlVDdjWGJ0TlNITVBEQXdSS04y?=
 =?utf-8?B?OFNwVVJTdXdBdnZmVVNuK3NMclQyUDNBQ0pSZnNBblNPYUxXSExiWUQ3cEpw?=
 =?utf-8?B?K2RxWSs5amZZaktVL0JGR1dtOUxyMGR6elEvcWdnbkN1SG9PeXkwbU9wZmpm?=
 =?utf-8?B?cW8yaWJ0V2pCL3ljUWpSWW9WdFo1VGp4TTEzSktweXMxUUNkS25tK3dPOUx1?=
 =?utf-8?B?SHpOaG54Ym5PS1lNUXpyNFFOaThMUGRUcGhYTXhXTU9adXY1SnkvbHY4UVRr?=
 =?utf-8?B?bEFma1h3b2E3TFRwd1VmNWVxbFlJS3lDSXNmaU9zd2c4OElpNjJTeDdWb3RF?=
 =?utf-8?B?Y2JJakNHY1hlZmpXRVZHbnBxMk5qS3E4OW4yMlFhd0h4U0o1MldjRWMyWGFQ?=
 =?utf-8?B?dUJsdTlEK215UWJYMXNFT2t3bHA5SXlPbElrWEtKN1hadFZYeGMrK2dIQytz?=
 =?utf-8?B?ekFNZXlCem9XRnNqQ1JBZ0QzdVBHZkxWN3Y0SXJSMDVrZzdBWWVINXpoY0dM?=
 =?utf-8?B?di8rbFlQRUhyMFpiUXBzMU0vMGY3TVY4QXhGdFZHWkk2NzJOOGtLTUpkOUdn?=
 =?utf-8?B?OHVZTitjeUdXV0hYbGF2SVVPSFNoVHNScE4zVUtpQjFlellwZTJCWkRJVUs3?=
 =?utf-8?B?eGtYdnNRK1R1ZDBOSWxRRGkxSGhrUHZYVFd6ckZCeUV0QVc3VmowKzRxaE1w?=
 =?utf-8?B?ZThGZGxic3BrUVFnSU1aSGxWTmxvTWkwNkFXb05kZ1ZJWVFHMEJCQk5hTU1l?=
 =?utf-8?B?elJZR1JmSTVHVTMzdk9VT3VJMlg0dmxsSHNSWW43VVJhSmJyUVh5dnpJQld3?=
 =?utf-8?B?ZExNQy9ONktCeFBJYldRRlA2OWdQQ2tNbEJJcllabS81L0RsU0xLcFlFUmRY?=
 =?utf-8?B?cVh0aUpkejJEbktWcUd5VUZ4NnpsVm53aXR0L1krS0xhMTFmU3F3WDZEVmtF?=
 =?utf-8?B?WHRIL0lEY0RtbVN2OWNsT2dBRDJEVk1NelozSS9BcFNKZmpLM0IxQjZ1QXpZ?=
 =?utf-8?B?ZDhIV2dkdnI2elFpb3h2QWI0Y3N6SHZ6Q3ZrblZ6WW5VMUlzQUN0MTNDQjJY?=
 =?utf-8?B?NHU1S05za3dUTFpZN2ZscFFjQk14UmpQbkFxMS9MMk5mM1lSdTlGWVExdDlt?=
 =?utf-8?B?OGxpUTNPUGxmRHYrdHVRYW9CK0lCU0V4bXU1WXZ2MGpiY05pQmhMZ2pqZzlK?=
 =?utf-8?B?TEh2Lyt1L01mWTRJZVQyeEpUVis3VlRkNmlyVVpJNHBraVJtS0ZlSHEwSUxI?=
 =?utf-8?B?cDE3Z1lJZlYyOS9XWVVPNnVyQjJoa091Nnc5ZllMTFY1bWU1N0RLNnpub3ZP?=
 =?utf-8?B?MkhodnRoTytwNUNONnRBMm9tS2lma3lPRWh1U3JEVlJVMnNqZ1JZbVdLR3pH?=
 =?utf-8?B?aDZXMWJ4Y2JtcFNCMndXTE9SdzkzaHNnd2tkNGltVkpqcHNVQXR4YW11V0Fh?=
 =?utf-8?B?am5XNkpXZ2pFVjNIc29tYWg2ckM0am1ZK0daK1NTWW5POFozZzRaY1hnYTJE?=
 =?utf-8?B?Z216dVNuKzhMMXdXRHRGaDVuRzVnWVVJQjlRTFo0SjVwM0xmVlM2WEJQUjR2?=
 =?utf-8?B?VlpJTXZlb0d4WTlLNXlaQWZrTHpHVFN0eTNTZFNQRVN2SHBpamZBQVZsck5Q?=
 =?utf-8?B?ZXRlV1VnTHRlUStnTjg0WS9UbWhsM3hoUjV1Q1pTeC9NN1M3TklyRWcvaVR5?=
 =?utf-8?B?YktwbVMvWHhKMHBJYXlkMVhQa245UllaNFh1SmZpNHFTeW1DQ090VXdCYUYx?=
 =?utf-8?B?Y0hvWGwyMHdBOGRxWlhFYnFlZEdEWjYrcWQ2eGcvYnlaR2hJNGc0MVN6VUxX?=
 =?utf-8?B?RXkxd2d1Q0RHUmFWcDRoWmdNbUtBSXlwQUc5dUVOZTNlVWtxMzdlZ0lhb09N?=
 =?utf-8?Q?Q51PE8lIKRYM5JGrPjqw+0I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71CFD465122A484ABF5181B6210F72F3@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: efc2147e-6673-479f-5e7a-08de1d5b0e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 17:36:45.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8wQadnzKV9a1ctyEcAMiFqTtVA9WHOgQM4hNTws8i2qjHStvkQAEInaVBpD1XmGI9aNnPq6lxyq+HnC4Qzl+shhBPvSlOuQ4yZCO4o48Gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3571

SGkgVmxhZGltaXIsDQoNCk9uIFRodSwgMjAyNS0xMS0wNiBhdCAxOToyOSArMDIwMCwgVmxhZGlt
aXIgT2x0ZWFuIHdyb3RlOg0KPiA+ICMgaXAgLWQgbGluayBzaG93IGRldiAkZGV2DQo+ID4gNDog
bGFuMUBldGgwOiA8Tk8tQ0FSUklFUixCUk9BRENBU1QsTVVMVElDQVNULFBST01JU0MsVVA+IG10
dSAxNTAwIHFkaXNjIG5vcXVldWUgc3RhdGUgRE9XTiBtb2RlIERFRkFVTFQgZ3JvdXAgZGVmYXVs
dCBxbGVuIDEwMDANCj4gPiDCoMKgwqDCoCBsaW5rL2V0aGVyIDAwOmEwOjAzOmVhOmZlOmI3IGJy
ZCBmZjpmZjpmZjpmZjpmZjpmZiBwcm9taXNjdWl0eSAyIGFsbG11bHRpIDAgbWlubXR1IDY4IG1h
eG10dSAyMzc4IA0KPiA+IMKgwqDCoMKgIGRzYSBjb25kdWl0IGV0aDAgYWRkcmdlbm1vZGUgZXVp
NjQgbnVtdHhxdWV1ZXMgMSBudW1yeHF1ZXVlcyAxIGdzb19tYXhfc2l6ZSA2NTUzNiBnc29fbWF4
X3NlZ3MgNjU1MzUgdHNvX21heF9zaXplIDY1NTM2IHRzb19tYXhfc2VncyA2NTUzNSBncm9fbWF4
X3NpemUgNjU1MzYgZ3NvX2lwdjRfbWF4X3NpemUgNjU1MzYgZ3JvIA0KPiANCj4gSXQgcGFydGlh
bGx5IGRvZXMsIHllcy4gVGhlIHByb21pc2N1aXR5IGlzIDIsIHdoaWNoIHN1Z2dlc3RzIGl0IHdh
cw0KPiBhbHJlYWR5IDEgd2hlbiBoYXNfdW5pY2FzdF9mbHQoKSBzdGFydGVkIHRvIHJ1bi4gVGhl
IGZ1bmN0aW9uIGlzIG5vdA0KPiB3cml0dGVuIHRvIGV4cGVjdCB0aGF0IHRvIGhhcHBlbi4gQWx0
aG91Z2ggSSBkb24ndCB5ZXQgdW5kZXJzdGFuZCB3aHkNCj4gbGFuMSBvcmlnaW5hbGx5IGVudGVy
ZWQgcHJvbWlzY3VvdXMgbW9kZSAtIHRoYXQgaXMgbm90IGluIHlvdXIgbG9ncy4NCj4gDQo+IFRo
aXMgaXMgYSBzZXBhcmF0ZSBlbnZpcm9ubWVudCBmcm9tIHRoZSBzZWxmdGVzdCB3aXRoIHRoZSBj
b21tYW5kcyByYW4NCj4gbWFudWFsbHksIG5vPyBCZWNhdXNlIHlvdSBjYW4ganVzdCBydW4gdGhl
IHNlbGZ0ZXN0IHdpdGggImJhc2ggLXgiLg0KDQpZZXMsIEkgdHJpZWQgdGhlIGFib3ZlIG1hbnVh
bGx5Lg0KTGV0IG1lIHJlcGVhdCB0aGUgdGVzdCBhZnRlciBhIGNsZWFuIGJvb3QgYW5kIHdpdGgg
ImJhc2ggLXgiLCBub3QgdGhhdA0Kd2UgYXJlIGRlYnVnZ2luZyBzb21ldGhpbmcgZGlmZmVyZW50
IGZyb20gdGhlIHJlYWwgdGVzdC4uLg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVu
cyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

