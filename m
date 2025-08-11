Return-Path: <netdev+bounces-212594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A82B21652
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C494614E7
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CCA2D9488;
	Mon, 11 Aug 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h4tzy/rv"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021139.outbound.protection.outlook.com [52.101.62.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512A2D9ECF
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943423; cv=fail; b=AI95Nz5mv3OsJzwoKMvD18M0hF5sbBKoxNI0UfP1eM3i0TGhA5l7pNxw8UNzdhfkGeyYmNGBYEm8C10zKLgG3v3Wa9Ai9Gu7YbzFsTWGvwkWDEl8SzYgkgIvCjgD9xTHJzvE1io0z5ZczeW8JmGkAyjfCPCzVH0RZf8PTDxUqKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943423; c=relaxed/simple;
	bh=N7ZD1SZC5k9T8JPY/807wNNjRCqn4zRov2pHDZOVt8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tGShlal8vwcSEoZomiC4qHtDsm2MgFdy82BgLCVzsZIYfIBrpIbTzE/dwibjx9nYLVrTVYMvX22TE4Xbaw3I9btL3iOBuK591hgU1g7QnCJt5voRp1iqsroXxCU+6H84/fsQNKzZRNQk7tIEJpCq+GGsjRAs359vxJVPSDOn/QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=h4tzy/rv; arc=fail smtp.client-ip=52.101.62.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS4TVad+4IPTT018Q8rZDx5t5rB5nOoDmdOh+siXu9NtfRqSxoYuGZGVInWk9L/jLfPFADXx6GRYfWt3zqEcF3+vzW09XP2BW0Y0gjwc2Lke5kbH4e3K0xvn2R4InJsU9/0c1p/5OpbXSnoglhStN5LYuh0GoV5Uug9KhzCYDrYuZyte0obO8sDi2mZCkJn/7ocfxx13YHBb6V9Ayc4pmRmwBFTPnXYg7DGRJ4lApXF0AtyDE3gtei9lKRVFS6FGrpLSjFhINerkT1HTGiA3kwpLiDKTwugnizyZaXNhW9bbjz0zSMPMW94fVfo+JmClvRP6d1suErUnjxRo9OJB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3opHrApfuroRecnPc2SF26fPChm2pejkzU2Yo1yczg0=;
 b=gxGsUr5IXhnxfdMVeHqJU74M8QxOom+akPdfrZHqixFCDCqHU571t1i90XE+WjX3t88CkZgbXmyuA6ta9iyXXDkdYLITjAnrb32PGEz7kLOVN0hWsvMdwQqUHPa/8Ic+CNJxjADX5I4ejDQAhImr/NE5CfnqXzos1IctRI8gPBvPf1vORHtgVwQsfzrANznMWkMf6YdpKHSNEEIcCjzUzGiQetYgjO0bH//nBc6d47wMd3lo6+f+Y3cX//wyD7VSk7QsTODpeQkvCCHdiAeIJ1En3sW3bKvzZEm82gdXpJNTQpJvQGH4TJyKiTDRBLCaf+ZfA2yI3D5nDjrXLg3nfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3opHrApfuroRecnPc2SF26fPChm2pejkzU2Yo1yczg0=;
 b=h4tzy/rv7DtO8xKZAKbHGulqq1wE28GVd9g0eTsRX5Mox6IXqPzNlNqShgL+L1TQedouh+pb1PDJWt+URN3vWT209pkVmmqeRFWzoIjsGHwKxehOpUr9jl78kuWuS1gAtNnTtb+PXxN2jhpKWbuoB7RDz8CpuD/NUm9750kj9/Y=
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com (2603:10b6:a03:546::14)
 by SJ1PR21MB3530.namprd21.prod.outlook.com (2603:10b6:a03:452::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.1; Mon, 11 Aug
 2025 20:16:56 +0000
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18]) by SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18%4]) with mapi id 15.20.9009.003; Mon, 11 Aug 2025
 20:16:55 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"dsahern@gmail.com" <dsahern@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>, Dipayaan Roy
	<dipayanroy@microsoft.com>, Erni Sri Satya Vennela <ernis@microsoft.com>
Subject: RE: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to 'ip
 link' for netdev shaping
Thread-Topic: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Thread-Index: AQHcCo5F82TcX0eVLEWkF6odjs6oPrRd4+Mg
Date: Mon, 11 Aug 2025 20:16:55 +0000
Message-ID:
 <SJ2PR21MB40134002E6E91397B9E6CD22CA28A@SJ2PR21MB4013.namprd21.prod.outlook.com>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=baacfa6f-1649-4203-935e-0ef6c9c1e0b2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-08-11T20:14:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR21MB4013:EE_|SJ1PR21MB3530:EE_
x-ms-office365-filtering-correlation-id: 3975168a-1c56-4c40-3f14-08ddd91404c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tDOUxxFjjByqV6ZAdnRm17+oAnkj+BXRJyuRzdAC2jFHIS3nGRWHzqPNN6mc?=
 =?us-ascii?Q?5ldcozep5QM04jV8lPvtzR0tfsuD0sV+jyM7sdoeLZy//IgGk1GPIE/yh9Zs?=
 =?us-ascii?Q?dQsvXMH0h5yhC3EsC+6ScwTp69EA7E2IoVHyZVIubWk1w7p1EOmu0nnvqkl0?=
 =?us-ascii?Q?aXjAmT+nYYniGhxG5oIQ2fqo+TqGMnGCaNhbsGKHrFIGUCjXpW1xvNoxlpP/?=
 =?us-ascii?Q?rbORe4QLNxZf4fYJ5S1Ehy2M6rnuep75Xore3NQaPjiSHmceydase0x0fVNW?=
 =?us-ascii?Q?m/sepL18ke7u0MrEK37EgJK1IIOA+YnR8JHPiedfIALc9W0NAJt0iiICp1sD?=
 =?us-ascii?Q?UtNZrDjV9tSh8SSUBS/DXaeovRu/qFKZWygBrYHo4KWH8VfJjPU5PU+CtVQk?=
 =?us-ascii?Q?nLGBt0i24q1LrWDPLbIVi/F0G/9uIw2QLud0VjLB2yDWhGm88YITTWgJwdPB?=
 =?us-ascii?Q?1oiD+XapmwjSPKV7bhIFSa0mQwAKHsBP8c6JejQUP4annzY/3QaQ6Qdw5rPy?=
 =?us-ascii?Q?LRf+LyBZO7lUTYx0cs/R3mQbpv+XOHifjnu4kyISxB2bsPDQkfgWcDTIFDku?=
 =?us-ascii?Q?R14wqRjDSNMsaMqt3FlSXp33gvjMhPbzwQgpW/d+PUhGvWdM/SjpffEyKh1w?=
 =?us-ascii?Q?YcwKZWlANEjWqrkQsS9wkgSGaQJPeTm1OKY4U7MWfFUh8cG9IeHFugUF0+dZ?=
 =?us-ascii?Q?UoRP1DcCMpjEfG2hX3PDHE2U9q0YmLJ4W/nqT8jXzsMkWGVKX+Ce+734uPxx?=
 =?us-ascii?Q?sv4bDNo5symzFojg2fPOmIp4xbD1a0b1XlvRquWHzTNJZGTuEaKVqpr3SCOy?=
 =?us-ascii?Q?aTj2ggXyPtq1CXBIwbA394dBJQPVtzjK/24NVhqfbYEWTCDw4VD69uZYkv+y?=
 =?us-ascii?Q?2p7z9nU9kyMc3ldWLZPo+8lRBLZ1+DC7V9xyTiO7UjAuNCs8Y7Dal7KcqdmL?=
 =?us-ascii?Q?qbo5zdbe07vWdPkqDCAT+yhXye83lq7N6JU8jHBi/bJF5W10Uo+YIKb8+3/B?=
 =?us-ascii?Q?Sl3i3JSvbuv/lf0AuNurVVqalj5zz37nK1sAmmoxFygXFbpdpNoMTmhEaM7D?=
 =?us-ascii?Q?m/8VCO+a7Lf4GAKN4xqA4AmuaZuiV7Jb5TGpJY77foxDp/HSeNaJ8cwM0U7Q?=
 =?us-ascii?Q?kCMZvV6Mh1merN/OtfAIIdUlkM2hMO/ianyGkRZ42KHsXgsSrqIhuRqXilyQ?=
 =?us-ascii?Q?Rmg6gLgyXkOHOtujKJoeoZRS3xFocLkOeqlxTaR3mZj4qj+hwO46KkJ3rnhB?=
 =?us-ascii?Q?kFuMBMGVmBqVp3iAPBwroqybQQmyshdjbgcDBr/OK9BbLH4RnnjK+Q2Be9+Q?=
 =?us-ascii?Q?sdaOdScDhkL0uM4eAMs3QUAxLwjVz7beXud5TiFOGKUz9ViWPTZhUYawD4tP?=
 =?us-ascii?Q?07rTcwJlNYdXnba3tZzUvmvNAg4zduoPcPoXkF2EdACvl3DEiUyGyhljQl0o?=
 =?us-ascii?Q?S8tY6ZEojfk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR21MB4013.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eWRNDqWMhbNi/TdXOd3oC6uYUMnJkf61umtcpCP0tmRGhkefXbyM3vWO89m7?=
 =?us-ascii?Q?winvFglZ3pfom1+3EDAxfmHfFq0TYatsy00FFdF5LAeNyHpsr1xIHHoSp3Lc?=
 =?us-ascii?Q?dTU7+RfxcOkx+Ra85vjC2gepi0LvsbwSRIwrNUlEX/NPffKkKzB5yNI18poU?=
 =?us-ascii?Q?T79u+xRR0j7zp5CKMJTwVnvmA9OtuDK32LzzrbYtVusj0bNa35V8XSmZftlL?=
 =?us-ascii?Q?BkwKJ98qcsVnOwQZkww65JT36QhRMq/kVRu25d0ulNPIC7M84J/l6bcFF44w?=
 =?us-ascii?Q?ns+7LkC7zHAzbYVw/X0n147OGaBXPBOn/A2jAzhsTNhA8o1zxP8fI1yy+tpM?=
 =?us-ascii?Q?HMbDjyB+og91Qcxa10eGfD9mCHxaKEyud1Ji8nUk0+BjR7nhk4tJQen87KLE?=
 =?us-ascii?Q?n+ssSkIOi5IydQLTMDSrYJwl0hUfYrBA/8YdmmtiiVQwFx/QTItJXGWSHgw7?=
 =?us-ascii?Q?WhJH9LFu5E/q4feQ6NjtnaVE8+6E8YUqHCgKWPrdJMSA5g8rGBxgmA3zS97S?=
 =?us-ascii?Q?uu7C1VwgrGa1h+SfUnU8t6OGRhdU+T6U/qrsZ1W/RAyBHk4/Rm2JY8nRbnkL?=
 =?us-ascii?Q?d78LUzLlmftU6lOzQQ18XwaHVrnMttbAb7+HrGcoxnnhX/c1ArOOXbfHVezT?=
 =?us-ascii?Q?v557AryCxSONEe7aZXBzkOokiNd1f/DolqdZ5Cs7UEcCEJxx7LpgK7nGpcb+?=
 =?us-ascii?Q?FmzLiflzDvB0S1sdN6fjo4wax2RszIsTqRlKJ6WzrG9D9eY2YV1ptmA+DMKQ?=
 =?us-ascii?Q?/6irAcF3UdLDvimiD1pJNXouNggwHMlWpXi1mwncAbY0/N41JN4IUQWenTKc?=
 =?us-ascii?Q?l1eTOReWzAKf6mMSbHoulln1O52GTWaowA13puJbdsW7oX1P0/1m/heGAi6D?=
 =?us-ascii?Q?W50dznn1klkwCa+PkuxmM2vQES+266SIX9GWXu87NI2rqsaMcGDaGKB6r4uU?=
 =?us-ascii?Q?QS+WU21EllrOcTdNYpylR9ZN5lMzr9LTkJg0hh4U1ZEZxJVe1IB4WIRRSZ9c?=
 =?us-ascii?Q?pYVoaJhFM0zNjUwYu4CPZQAVMSvlGqGS/d//hKUTcNSyrO0oD0NuBrD73YvN?=
 =?us-ascii?Q?CRzvbA3Xa+NGIJQMSkfZV1V9+2A107TzpLuGvJ6v0SkNY2B1Bz2id9PZLXlK?=
 =?us-ascii?Q?xphsQ1CWR/N7jpDUc15lI3iKWr0oIosHS5FqVIDc4p8fBsKJ+oa+knjXl1Iq?=
 =?us-ascii?Q?UFKCmzprpDm57kgH8hPOZX/MTK1FtKwUNKypbdGDX07U/LaIFeO9D9WL6Tbh?=
 =?us-ascii?Q?rIR5aPXcU9/Ef6Aq/Se4QAgnG66YBg2ln8vcOERpoHYjJGzDKmBxPAFD8Uqx?=
 =?us-ascii?Q?2CVbb2s3JGzyIStcBwMdv6GDHB/XjcpIOkBYYZAD3uajiz59MJocB0Y7sS6x?=
 =?us-ascii?Q?mIXkI0MlXE53iKegyYHVVcnp6B7ZHOTTY6osf1duWvg2LijUluOqCocjqXNL?=
 =?us-ascii?Q?7DmXKqUdd6S6XMC2NQFNtxrB6U94Ka5lCLMbl+tiubWV6MALv52L6k5eqFLq?=
 =?us-ascii?Q?q6oHRZ8QjyF/B1lYRDpfAmXCYlzWpZC8ieLr9mF8CdBDXhbs61ZMxlTcd7qZ?=
 =?us-ascii?Q?VNzm/ASjbAziyeahLOw+pv9BIUEYAIkQeFls0EKe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR21MB4013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3975168a-1c56-4c40-3f14-08ddd91404c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 20:16:55.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTYPNYUuNbPXW+f5AEXl7bO0v9389ETxa+pjUXH5KTA1DdUO9qbVHw7S4DyxSKWkUzYDBT2P7lFJd6DFTmruxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3530



> -----Original Message-----
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Sent: Monday, August 11, 2025 3:05 AM
> To: stephen@networkplumber.org; dsahern@gmail.com; netdev@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>;
> shradhagupta@linux.microsoft.com; Saurabh Singh Sengar
> <ssengar@microsoft.com>; Dipayaan Roy <dipayanroy@microsoft.com>; Erni Sr=
i
> Satya Vennela <ernis@microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>
> Subject: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to 'i=
p
> link' for netdev shaping
>
> Add support for the netshaper Generic Netlink
> family to iproute2. Introduce a new subcommand to `ip link` for
> configuring netshaper parameters directly from userspace.
>
> This interface allows users to set shaping attributes (such as speed)
> which are passed to the kernel to perform the corresponding netshaper
> operation.
>
> Example usage:
> $ip link netshaper { set | get | delete } dev DEVNAME \
>                    handle scope SCOPE id ID \
>                    [ speed SPEED ]
>
> Internally, this triggers a kernel call to apply the shaping
> configuration to the specified network device.
>
> Currently, the tool supports the following functionalities:
> - Setting speed in Mbps, enabling bandwidth clamping for
>   a network device that support netshaper operations.
> - Deleting the current configuration.
> - Querying the existing configuration.
>
> Additional netshaper operations will be integrated into the tool
> as per requirement.
>
> This change enables easy and scriptable configuration of bandwidth
> shaping for  devices that use the netshaper Netlink family.
>
> Corresponding net-next patches:
> 1)
> https://lore.ker/
> nel.org%2Fall%2Fcover.1728460186.git.pabeni%40redhat.com%2F&data=3D05%7C0=
2%7
> Chaiyangz%40microsoft.com%7C0ac998f8db0c4cf31d8208ddd8a5658b%7C72f988bf86=
f
> 141af91ab2d7cd011db47%7C1%7C0%7C638904927080914227%7CUnknown%7CTWFpbGZsb3=
d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp=
b
> CIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DWY7zqpx5F9Wnf0WbHUIxMDGbwmjwQysj=
TdD
> cPAZ5jzM%3D&reserved=3D0
> 2)
> https://lore.ker/
> nel.org%2Flkml%2F1750144656-2021-1-git-send-email-
> ernis%40linux.microsoft.com%2F&data=3D05%7C02%7Chaiyangz%40microsoft.com%=
7C0
> ac998f8db0c4cf31d8208ddd8a5658b%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C=
0
> %7C638904927080928775%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlY=
i
> OiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7=
C
> %7C&sdata=3DTmzKYLtKlU%2FphFWfa13toeOmJGAU1RgBBtRvp%2F3Wg5s%3D&reserved=
=3D0
>
> Install pkg-config and libmnl* packages to print kernel extack
> errors to stdout.
>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>



