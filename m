Return-Path: <netdev+bounces-162596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5089A274E3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67D518820C3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C492135D9;
	Tue,  4 Feb 2025 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="33m66whL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8D3D76
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680956; cv=fail; b=XYNAIol+MvQJCKReaQbCjcdqWGSEDhQS6CJTDFjxZWQDBQ1fJuDhMMllSDDckmThE87xyLfTT9fc1GBsOnJr21oWExwRbTQvkBcg3lW9xk62Bo7DUdLZ0GUQFQ9/OvW8jcZArRlRvlm7o2SbA9omYof/TahLDVUFmJ08TotID/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680956; c=relaxed/simple;
	bh=KGomg7qkqs9Afb27xSqtjpY+bYdU0YiYDueDm2W7G7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nltfmrb/eyRZ22VEpeiE1bgh0iMnBf4/fjFe1aWMTmDtLHzgRhGNcsjy+sZDV04fjE69HsUPKjyJN1IKK4dLIg4qsK0n7X8HKh8gYh13NYDvQJe54XouUU7rUb1OkxfGWK/z4NU/ELyrE9KBCanDqDO/yJU6LpgaIHPipQzpiYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=33m66whL; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1mWn62Pech9Hzg72wXkhgcDaFFofliyoCG/vf0dkP3ldiKf/Oogj56A8Qtv9c6Xm/QgAt0YLWJhgAig5lhqTNkti0lw06f35yY/LB8xJFXhBDCdJnzQKBISs5+RLiD7OFBsP0WAZAEdo27kBOFmlhAmkgv+FhMmpueTzsEjcdmoHFkAdxj1jbVHLhkFeykWxmzc4HzINwDMPwgsZtCpN2DcLtOZD97+JopbAxH3Av/EhsjeUFEtSVnRO5FYi2st6hs/fxvjhOexFwox5YJUZvwLnB6pb2Ba7DPbCvBcs4GtZG/d2IwOMCmyCYaa3vrwa2IKL6uXrGAyFdet/xYKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWH41KV2Sk5p4ippjhyY9JLMGNL3VCEUiOo4ID8oMIQ=;
 b=AktP9hDX7zISIIqwBLeCZOAIGaiprAq/JY81jzSyzH7dMeYU0z97cc9wUMd63pRld/CdasUaLEh/fYqZqnw8zRdY5Fx0k+wZdU370u5ipc57ZD2AjJ+dvb8IZCI9LCXHnnX0/1+XHU3vLbnR4nzOovXobxdJ4TmAry+KBs7zB+6MHuy1oG5CHi5Z+I56wZuMneLuLR5bNWsN6Qh20Xhtk+ihdcHSQhRcjntGUu06nOwqmpwNQjT/VOTnGp0E6wtTswtBD+ZlCBYoTeOhShwj++I44+hkiY6DCflHYKnzTi0xhlvLnTI/LTybO9PM2DcYylTAX+iqwShTBpoRPU7b/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWH41KV2Sk5p4ippjhyY9JLMGNL3VCEUiOo4ID8oMIQ=;
 b=33m66whL//uPX1XfwatnW7Ks4mb+VmKfGnS3Tm8lUYqdfNrvIL+3e7GMxeh46l+mov/7d0z+ur5vAD/RH/Rex3MBhtBNhp+Kdd9tayiP8umOW24IxtL2QijS0DygApwqOQnzw7l1zSypQN0ESG1BNecSuvg1XC98r4q4+lnxo9Zt++QTXfcYj+aYvJfbFfR+xvHjBWmgQzIZKtIVkOgyogzHuTFUcvFiJTgGwdebquid48C0AQ6OQnndzkBp9ICH4ovcSWoTBfZHCDN9rOzTdDeKFOJwnzt0eujJQNST8iTKTDdX9hCTbglVncRef4XIBMXITlkjHuWhyx3fqPP1Ew==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 14:55:51 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 14:55:51 +0000
From: <Woojung.Huh@microchip.com>
To: <kuba@kernel.org>
CC: <frieder.schrempf@kontron.de>, <lukma@denx.de>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>, <Tristram.Ha@microchip.com>
Subject: RE: KSZ9477 HSR Offloading
Thread-Topic: KSZ9477 HSR Offloading
Thread-Index:
 AQHbcZ/V7BrTHsAdqUafWk3/ZoT41LMsd0oAgADjJgCAAArSgIAANkeAgAAFAwCAACgGgIAANNSAgAAc85CAAOiAgIAAXJhwgAX6CoCAAFhmAIAAAfnQgACIzQCAAQeAoA==
Date: Tue, 4 Feb 2025 14:55:51 +0000
Message-ID:
 <BL0PR11MB2913ECAA6F0C97E342F7DE22E7F42@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
	<6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
	<1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
	<6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
	<20250129121733.1e99f29c@wsk>
	<0383e3d9-b229-4218-a931-73185d393177@kontron.de>
	<20250129145845.3988cf04@wsk>
	<42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
	<BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
	<1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
	<BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
	<20250203103113.27e3060a@wsk>
	<1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
	<BL0PR11MB2913B949D05B9BB73108A5FFE7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203150418.7f244827@kernel.org>
In-Reply-To: <20250203150418.7f244827@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SJ0PR11MB5199:EE_
x-ms-office365-filtering-correlation-id: 17a54134-aa07-49b1-8da7-08dd452c0496
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B6UMq+m9dDTsF9jdHGjVAQfFJ4X+Zeg2E89BIf4UBFp5SSSKORE0O+Atssk9?=
 =?us-ascii?Q?w9TfF/ErzPIfQV+ixA0iRDohSqgdDZOoW1Ku87Okktaimk2rCsL6c/kAfnTY?=
 =?us-ascii?Q?7H9Wg8fstrQzaJ35k55+xAq+Kfg701lN0SGoxEdCUYCTXsIlHd3mmvwXLj/+?=
 =?us-ascii?Q?OAGk96Ig1Z+PVMI7aN01EBbiM1QpgY3qjntg9GfuA3kAUgXnltiqHocDPiv3?=
 =?us-ascii?Q?gS6RgmeyC2w9oR0pCCtXL8D8CX/lGTH/x6qkEHrlXsVH/00ouM3opolNCDiv?=
 =?us-ascii?Q?7PCY85PK80N+Kt1QiPeo47xk2bsGmYyVKiwVdTMQtX/d6PLUs7+JWu6Fyn0Q?=
 =?us-ascii?Q?JeuCiw5hrjssJCkNvpYaIcocZam8eZyNUMIaXEwCHm2sBcmBccPg3qS4xMUq?=
 =?us-ascii?Q?XiXTAqhG2YBdCzdUA0lq0zMffN5K3CB0TOlOrZofAiw2hfrjaP3g/3CUrkDM?=
 =?us-ascii?Q?zBh2iIOFJySH/6L4xZZ9tNuVHyWo+zd/mZnZH/rNBd8yt40zF7P6ZI8uZvSE?=
 =?us-ascii?Q?kLQD8tRVMWmzeI4zhPGeC0m2ih0UmdyKx2PKgVR6ofAvgsHh4qMj7zuqR6kw?=
 =?us-ascii?Q?vUpQBqmZRhf9aSDZN8N3wGVTZmFWcFMLNNYMY4jb/61a8LAQH71VHbS8+SVr?=
 =?us-ascii?Q?VrhespVjntNTCzkbfpSEEGX1V1H41uUxVf6sfxGk7afanDLszUUqW9Y2JL51?=
 =?us-ascii?Q?JjgR+0cwQXgQRO2E/BCwgGVV0AwOPS8VVIq+YADkvfGvH7d5Wbch2Co5esIe?=
 =?us-ascii?Q?52DAaU6fcvOi74sqwPUzcxbezz4s0dOjZI+JbdzJantTYGmp2RWOYVvwTMkM?=
 =?us-ascii?Q?t6EVGxbz1WGCdsu+GDvILekuoumOuC011gmy6K6D+diUNkW08dcFpzLG8ZLT?=
 =?us-ascii?Q?TuQXS1VyhgQT0gz/eRB3ZEXWJh96U+XuyPBWYpusoTTQqkBGuI14H5iHexch?=
 =?us-ascii?Q?Ws0ByW4YCXslBs23yWOOM5JQjwtyaqUi+GhNBh/G8O7jAS9znSHOvHS7JlMB?=
 =?us-ascii?Q?cTgf/pQtXOkDUqb1YmKMHBY8YghWgVzD/Tl3d9HEUSMNYvmUuSJ9bw0iolOb?=
 =?us-ascii?Q?l+71xueintXrk0G2mbrglqK7vRzgzJiY2dW6gtX2J9/TnBMr4AdH8AVuQtw6?=
 =?us-ascii?Q?g43H1RjViXGMNM9oi1+qlAsi128/el20EoLkI9bBoau+Mmt2Cme7QR83WeO7?=
 =?us-ascii?Q?DV/Gepd+fhvVTUs3FlE1ZX5pZzz65m0pyP+PlTiXU8nGszpRU0QxKN+StzL5?=
 =?us-ascii?Q?mdUyn45FQg/PjsMq5RvWMMNemm0fLebpvCHb34pWaYAu/GGk6e6mKNKx+oHj?=
 =?us-ascii?Q?lApcWvzyZ+dJGZ+2Y1xBZP8AIGPAKAJ22IP0EJth06r0RIvoVWYcORbASkqy?=
 =?us-ascii?Q?oYXC+pIT1cmA54FRoefw+PJpYVR4vKsjqcpG0+3xqwXSNZAlcZ/rBxMry8cX?=
 =?us-ascii?Q?fd0WoUWWZ/tZy2+mmoghZW0vVBwygOZi?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pXd58Mc43Vo+qixxOC9AfTqRXQIZLYK4kyzI38iF30juk3XWSCSj88uMZM4o?=
 =?us-ascii?Q?bnMmlQ5hKCnlTJGjITzDRqHyGw81FF0ij4jIW0b/V/KNB+CWf7yzYKDIqke1?=
 =?us-ascii?Q?EbzrtCU4C2eH9ImPnemlLCup4x0GwUQRWhSc9AkS6WbFoLCYlP/jSsisE+2G?=
 =?us-ascii?Q?jbkg2N78pG80ONYoFpa+2h4kRVXmxzZVKl1Z7K3lvMDthK4kfIhYwsRbD8mA?=
 =?us-ascii?Q?ryDLWP9hnGT54ePk+RB9cwZ9kOVXN+1P1wEm56r9xeXjJUuYveh2VBKqCdzv?=
 =?us-ascii?Q?nBztB4rT3DICMDBG/Q7b+19Wd1Tw94g85IFwJmaa0hF8FggYvXh0PpaB8t1D?=
 =?us-ascii?Q?xOP1xjXg5oFTMUIUp9AtFTvZwMMzwgfh8YZE8j8NNoKdZn4fdw6zj7tEEMIA?=
 =?us-ascii?Q?2mp4enHfUd0GM7aYpZ/0jLO/PaHdJ6ORw/U6XIcxaZpoGuJ/CSzask3/z2Vm?=
 =?us-ascii?Q?w2RtWAb5LHaYdbt8Qe5bJfQNxlEeUREt+ktgR9nzpOJ/oVy7k/pMQVcA4MBU?=
 =?us-ascii?Q?Oae8B8xPIBrSWR2s2PAiRBw+9v3xOQIHQRWplrFTYt+3dtuUCK78ytK8/amV?=
 =?us-ascii?Q?u0jDBB7nSluXIO5FTrRTqKrmkqu0qz9ZJ3VYbbSrFqmABqZ5yA8ekqFxBx5m?=
 =?us-ascii?Q?1+dlW4OfNqnr80a6OPeCYx1CbhbRf+KZUokA2cNfFzNK2/dYRgcOJNS4vsDg?=
 =?us-ascii?Q?cOL7FDAf5XeO5MxS6rW/o5IJ3C37sINsCow+z7v45W32FX61q9Ln2CyIHP1g?=
 =?us-ascii?Q?sYexcOYm8xVFukTcQ2Hc42CO8jp1oQSuWVR63m3eJjXU8mSHiMP5COOSFUpm?=
 =?us-ascii?Q?6JOQ/FwIhQnl6nM5wkVvv2U7X0yq3Msh9mtd82Mdxk6K/hf58+GabzB+nEPW?=
 =?us-ascii?Q?oNr6YpUUG/Ni1YaXQYGcxL7BcS7kj6/h09E9f4xyMRz0aDHZf1rZn8Lntawn?=
 =?us-ascii?Q?BE/ochYN0z+uX03rcDfugdWb/bKSLlEn+a2PZxn1uWDY7MSM390BpWvnRGZW?=
 =?us-ascii?Q?ByDbH7Zrw2wUPk3ULLzaWPSIJfmivkNAD/SQmJcwF3ZZpnxV+s1C6nO2U0Bo?=
 =?us-ascii?Q?iNKuz8odH1jxZNXRB11IX1sJhomqj/mNRRyP6+GQTdMnC+rIRcN2XPL1TPxw?=
 =?us-ascii?Q?TCkdQKy0F+vgP/fr5rXA6ELo1gF23jhVa9GHE1WjQeydomUOUavwaTHDvbS/?=
 =?us-ascii?Q?ACMCQKlunVgG6joRZeWr6jnYA/of0bese3sEKRZR+XcbgBfn0BOZ2dWf9PFV?=
 =?us-ascii?Q?BfQGQWL6Okd5Z3aDDEE6RDGxT9jaOAsqTVjdub4Rl00bEjn2xGtzh41PWd8+?=
 =?us-ascii?Q?XYz/j4h/WbTeDGVFr7zuIDb5kHeiEid/Vgk8o/duef3ghCUY1PafkBDrDAO2?=
 =?us-ascii?Q?2sNT279cg0Aw49BnEfy8uB8PCWE7npNS8TzsOy6UExMSa+k8e/Bjf9m0trO3?=
 =?us-ascii?Q?qoGE8kD14EcvbF8HASVLkUK3Kep1Do1jNoH8WCQhY7G5eFV6ZCRHbhbQt24i?=
 =?us-ascii?Q?OnXWq0ZgV4eCqVTs1I1q7IKgvLjFto8v4EbkUvnauL8se3LOcLcmIGF2FI66?=
 =?us-ascii?Q?4GbJsOwXSifdxxW7mx+aP1GrvL+OlGRLrx66FaED?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a54134-aa07-49b1-8da7-08dd452c0496
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 14:55:51.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7eeTaP3cH+kuSA8W0bkJVldt8Zjc02xtsvW7rS8XIAsHY07YowSVaMpbpl95D5oV2Arls6jHPXmqZwZhNzrzCg4l6pZJUGMklSkLtmsn1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199

Hi Jakub,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, February 3, 2025 6:04 PM
> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
> Cc: frieder.schrempf@kontron.de; lukma@denx.de; andrew@lunn.ch;
> netdev@vger.kernel.org; Tristram Ha - C24268 <Tristram.Ha@microchip.com>
> Subject: Re: KSZ9477 HSR Offloading
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Mon, 3 Feb 2025 14:58:12 +0000 Woojung.Huh@microchip.com wrote:
> > Hi Lukasz & Frieder,
> >
> > Oops! My bad. I confused that Lukasz was filed a case originally. Monda=
y
> brain-freeze. :(
> >
> > Yes, it is not a public link and per-user case. So, only Frieder can se=
e
> it.
> > It may be able for you when Frieder adds you as a team. (Not tested
> personally though)
>=20
> Woojung Huh, please make sure the mailing list is informed about
> the outcomes. Taking discussion off list to a closed ticketing
> system is against community rules. See below, thanks.
>=20
> Quoting documentation:
>=20
>   Open development
>   ----------------
>=20
>   Discussions about user reported issues, and development of new code
>   should be conducted in a manner typical for the larger subsystem.
>   It is common for development within a single company to be conducted
>   behind closed doors. However, development and discussions initiated
>   by community members must not be redirected from public to closed forum=
s
>   or to private email conversations. Reasonable exceptions to this guidan=
ce
>   include discussions about security related issues.
>=20
> See: https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-
> maintainers.html#open-development

Learn new thing today. Didn't know this. Definitely I will share it
when this work is done. My intention was for easier work for request than
having me as an middleman for the issue.

Best regards,
Woojung

