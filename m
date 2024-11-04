Return-Path: <netdev+bounces-141408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C79BACF6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62861F220E9
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F23218C91E;
	Mon,  4 Nov 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DQwCRK9m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07617583;
	Mon,  4 Nov 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730704110; cv=fail; b=VgpxIv9pUm2HzTdlMU4iiRfS3ULvpFmfCJ2lY3f8WBzfw7diT8LxqDDA1tHB23H8y2siPZgrAQDpi5aarVl+SFWw0/rkRN1zQ/ioCZht1Vca6pbYd3Od/G+D7SpZOGkihKrV+UNIb/foo4cP9puGuRSw9JQ5/Lx/XYwps4YPYqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730704110; c=relaxed/simple;
	bh=CJ1tB0tVqaqpi4zhFO0IzeYwSNrR2niI3jT8p2HXI7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRO443ertv12vglGf3DiWIlyQ61x8xbL/6aPW4d0qFWiXaOtvMm8ZjFJAR8W50GEK30Dwwvewglo6BVG0mmzYKs6IG3JWo9s1CuV2ENrGmGM9vI2TXWKU15Kn1QVtloLNzuAgAM6r8EfPmcKKrzbxQg4zz4hbojdLMfSV097B98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DQwCRK9m; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuGjVWYcqPbOYU+PRAD2kkmtJA0sP/wh1B01eGj1z6/bIzT4LzK9Lm+HIR08pNoZZKL4/8EdcaYHS1+mjT2WQk5j8tki3A+7l+EPp5lD3QBgGBni8K5afwpAX6sh/JHx/9FUVyUKY6KmveU14MLqh7ynHycuZkM3tK0liGZ8kMcRx72CFLeJRovisraMkVOjKNvR5Kbi9UNLdllA256T/CcD4tuzP/G8SGfYPA0NmDuR6cAqKmGi6jJ2oPiJSIgcqVKdSSlthuYkAIfGXesfwqGCnisgi5nHc9q0c5mh6Utk9YZv79RjkAhDEr6fgJdJCnVz/ECtiuEVxmpm0HaBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ1tB0tVqaqpi4zhFO0IzeYwSNrR2niI3jT8p2HXI7M=;
 b=bI+qsxdaq8mYP5ZwPrOLNxQmkWoIRgSqkWlheEHQ0zv1ICjHQkSLk59ruNmoaZEJA2c2I2w7HljxSoHDMRaRKACN7OiqICcF2aSYP2DiWihEToqS0EametN+xegq34vv+Vm50k2/+7GD5+fXoADufrYAAAm/izC4DDJLWUtd/O2wPr2iKrG/zYxygaul+c0dcj3Jao8t78ljP7CjAhEUdb3mZ3rn7NNXS2uWUVswlMGG4e+gidnxkcy+Q5l8ViWkpExJK0j8sDS9gkI/Hr+5KfQ6uX1r42zlYthLrrO/m14GKkfIV5tf08g0IlTXau5XlRFeue50Uz4DE56g7vo0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ1tB0tVqaqpi4zhFO0IzeYwSNrR2niI3jT8p2HXI7M=;
 b=DQwCRK9mMAp/WuhI/j+UEd4OkWrROBPsD1G+eZyRgLim5/HGsiy/6ykz8/hxkAHVnC2o0OZxQMWVy1Si/InC8lWvGRMlOZpARUHiQSPgqm9Ej5g2mj7c8vvZTogFoQtHe30vzyMlvnqQRCu7SFBVGfcv3jwwjQ2wyfqu+PKeuJo=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 07:08:23 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:08:23 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net 2/2] net: xilinx: axienet: Check if Tx queue enabled
Thread-Topic: [PATCH net 2/2] net: xilinx: axienet: Check if Tx queue enabled
Thread-Index: AQHbKpSwiuiyx3qioE+hYG8VIIZTcbKmLKEAgACOHfA=
Date: Mon, 4 Nov 2024 07:08:23 +0000
Message-ID:
 <BL3PR12MB6571B8EF92F67BA98DF1B07AC9512@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20241030062533.2527042-1-suraj.gupta2@amd.com>
	<20241030062533.2527042-3-suraj.gupta2@amd.com>
 <20241103143700.3ce70273@kernel.org>
In-Reply-To: <20241103143700.3ce70273@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|DS0PR12MB8200:EE_
x-ms-office365-filtering-correlation-id: 7573caef-ff13-429a-ab3f-08dcfc9f78da
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?m0J4+JTunZMBcntnwSHarnx5dCFUGi9akzQGJMNlTTR+wqrbbOtngTojFaVQ?=
 =?us-ascii?Q?A8dUao63bWo3yzx1opmk8Y6hdyIQW4+0XNjHl2Q8UJt8ViQz9cX+cI+a59g8?=
 =?us-ascii?Q?1RF9Vx90XNigk5G9Xa9riDQW46EOZSaU7TUHidvjyvnK75x6yk1Nw05v8IgF?=
 =?us-ascii?Q?vbDZ4M6XaC+c2dIOap1jBGfJXXP7dWGCRis6UqYlKsLeimZGdlZhAcxBA8Zu?=
 =?us-ascii?Q?tUamppDAH2ZecHu5GnUKfIpaEDREdTOliiN/UlQBsYySDYrK13kcSqMU+IDN?=
 =?us-ascii?Q?CinqTp1N5qRstDp8q9OoSkqIqSwczKwGqCmtRQ3JKm9LAs861aalVuI3i4NV?=
 =?us-ascii?Q?0v1605cB3t4JUD4Jt2sjItWDb0EW1utBOgRUClOWsdDBJmWX1gGnQtO38eyJ?=
 =?us-ascii?Q?xgbfi+hp7GyKEZaNjIuAA4cFWgWPUBlsQHmFi+L3A4PULM9baUxbeio12SRz?=
 =?us-ascii?Q?nqO9DOJHpkOb0B8MWHpXq3RLuHp9R3r8NRAjdEXYggooKtnz0/CyP1WQgju/?=
 =?us-ascii?Q?L3ltozeEHujXeqN7WJ9oWL4klZZDX+OvJQVYhitXBQM6N9w8C7ofl3RNeKB1?=
 =?us-ascii?Q?p7abnkaFUpWAzX51vy4PalcIGRJUADeXFjRC1xtN3LC0Z92icTJbcXv/zvfr?=
 =?us-ascii?Q?1Tv8F+mjmrNIL3oDu3aZwMNn2FePZ0g9D2ox3Napq1wUPKxScgD8zAFN9B8c?=
 =?us-ascii?Q?+DMYTKYxnGgcJWAOyUcfheIdd3CzQevWsAIvnJErv6mCtM4Yct1poHbSFC+w?=
 =?us-ascii?Q?eBHbae2N7DbVdt7jtIvJVUeC2d49CXY2jxqHH8C9JFvUiSbjYK8kWPwWhG0j?=
 =?us-ascii?Q?cV+VsCvGzjV+CMDDrqSf5HpOJB1NQMFXUQ0BWrdE1Fq6ZNdIJBl0EITRPvmr?=
 =?us-ascii?Q?vHpBQIEhqedzRac19AmYuxIFtfZ2uMLiTbpAu+PTTfsO1YXkIi3cufQsQ1Y7?=
 =?us-ascii?Q?ygmTpa4QKjO1RLztZajMr4hg+ogqhtVTEMx8Slf62rSQ93GOX8Q1TZ7Ww042?=
 =?us-ascii?Q?7LHt+w717WrjYzlB5wcouRhb/M/DzdOSCCx30mA61nbxJawQpO7WZ2TfhZvl?=
 =?us-ascii?Q?N3L5rt/kAsVfIImajrdek+ZVsv5Ag0Un6rq5rke95fO+WROfMbokThDLAVtr?=
 =?us-ascii?Q?qetf1TE9fbsMwRtifdJHn8LEB50g5D3+ttASmPXhX9INCI+Zd+sEgrpXVFYh?=
 =?us-ascii?Q?digs497FJJ5j7AOF7Fq2LOASmUBVyYuDQs0dDZSNltvJ/ldPVZJe06Ywd/lw?=
 =?us-ascii?Q?6hZXXhTsEWEbFNqZz500eohfeAM4Eqm79oYuOZQ6zgNB5e7uqqD1HOaMyjU/?=
 =?us-ascii?Q?CbC5P7NsYPrGRpNl9KxUbRTC3mstdM8hLNjTmYo1iqOulJM9AYejsCZOd27Q?=
 =?us-ascii?Q?jchFjCc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3eYhD+rEVCeIwM+yC8Evfq3PyITfcQT6yBwSs/899LgG28s2HYYeRCAEyYp/?=
 =?us-ascii?Q?4rjF2kMb5YEr/shwYbxWgvdSIQJThThPVTY/V/AtuDgKJ3OhyHSKH0Skvf0u?=
 =?us-ascii?Q?m7XF3UxQB2Q9XiQ5K2OE67oInbciK9HbNBD8moT7EQ9kMphlKroeZVaoglcD?=
 =?us-ascii?Q?IRj5z5jkxEV/4jtuoVs8kI44p0DgQQKdoMvkU/2EAeJJG/vOQVG2wZPzXLl5?=
 =?us-ascii?Q?qFssuwoYQ7brlXgFEA4WV2SoS3wNX/YylP7MNd6zIyfGSjRa5F/Qx+1qvanq?=
 =?us-ascii?Q?d4y+TGW+QEYuKBBe774jdrcV6omC9Co9WsP7xgs5vkZXV/HqeLZCYy3b9k6n?=
 =?us-ascii?Q?p3qza8KoOxGRmF0W/YotCAwXHu1iL+dtCvCONs5Bfh5SGAvM/4JEpietZTwo?=
 =?us-ascii?Q?nFMIPE0GkXWAHZnGQkvvO+QDbdfzOd+Fml9bbaEKWRkMTb1E2wwntNaYX0+z?=
 =?us-ascii?Q?E0sQm0Ez6d/IAlAldxPQMpxjcLZ9v7xvB1aooui0xnYj2oWtVhjXq6ozQuNo?=
 =?us-ascii?Q?o0zatfrsrp/leFShm6zG/7AR2ilO8tX/5i4fdN1LcAGHNrosvSFMQFdkEfEd?=
 =?us-ascii?Q?mqVvWp3VnIkAKJVqM0Qkz9CWpykrItlAk88Wj9JVPKxWgOmN/Lxjfjhx1a2I?=
 =?us-ascii?Q?8EwvouRkujfVgTnCxbBVeAKr3ixDSMWDXuHWIFjabzBssUuKV1vI3ReVlg12?=
 =?us-ascii?Q?DCLl77JItdXRzrVWvOf0r6SNxxBtUdt6WDnEv3fdDcVIpPebnmI9Ow3r/XUo?=
 =?us-ascii?Q?jSdynn03e2gpnjv0FS618BJUOn9ML4cvkWLBYG1GDmsFCqyeKsKKoTqXMXLW?=
 =?us-ascii?Q?zsSPpFPSgKlyyWK4QW/maO6p7k+T7Nv2Xh9Aqwyo8xadCzBewL54qQnDx79m?=
 =?us-ascii?Q?IZ67ZeoC5uDlCAT5tJTjBJEUHW593QLdX8sthALoGnNif+nECQRbNy8JXz+t?=
 =?us-ascii?Q?tMbRPktulwrWaJWtPnw5n5m9sgZfuSDNko003wkiwXx/5c71F3zBA46qVbD7?=
 =?us-ascii?Q?pk0MxqQT0cMxkdCfHF+gQDi/ExYr760PFwFzHiyi9marwu9e7V3UtG/aV7Mb?=
 =?us-ascii?Q?lZJ80x9JT6HhTmhw/77O5hF5rmuBKLtAHgaO0MqQGRPo1hC7QUhcMHsg3w10?=
 =?us-ascii?Q?zRWWxRAPy/aKSNljMC8YRQUrUdXu5aQY9DpehtHXZw9HeKJp/HRoEEG1EqJs?=
 =?us-ascii?Q?ehgGEgMand/M1B/iDPSR61YqxeQxcvEqHEZC/sXRkwpkm3GtdRqI5NSGar5B?=
 =?us-ascii?Q?GsLbtPT92hz5q7/mLUQS8mhYeBSHpJ/kVyC4ups/beiBQR0mcKbSwRhsoolv?=
 =?us-ascii?Q?2Pon3iLozS954d11XrT6JGvlpVOVOqW/3gHgtKNWplzrtxv97lkeCW4cyd+1?=
 =?us-ascii?Q?LSrSisYI6SLg4mD9kImKearhd45RhgygzalG2z9KpgbIvobetrr7D1soZcW8?=
 =?us-ascii?Q?/I+y5QNJTRXtf+Gm1bI8v0qAim5OzzDZXzz8ayaLXE8xBJ1cNefb25GumizW?=
 =?us-ascii?Q?ZEOy9Olqn++I8/EzP+bMR1H/eOS6sueiXnzthIPmpNDyNuR1u4uqhW0PUCKu?=
 =?us-ascii?Q?DRDcJm+bqxBg0xpK+Hk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7573caef-ff13-429a-ab3f-08dcfc9f78da
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 07:08:23.7337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okGvglCmn1GG+xAhUKnvbMGskVCAfpB6TSnwe3rBG4jZr9XIPWa4vXYD7Jl2dw3LUUSICbmP5Zk0Q/YzGW7vGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, November 4, 2024 4:07 AM
> To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net 2/2] net: xilinx: axienet: Check if Tx queue enab=
led
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Wed, 30 Oct 2024 11:55:33 +0530 Suraj Gupta wrote:
> > Check return value of netif_txq_maybe_stop() in transmit direction and
> > start dma engine only if queue is enabled.
>=20
> The first patch makes sense, let me apply that one.
> But this one I don't understand - what is the problem you're trying to fi=
x?
> netif_txq_maybe_stop() tries to stop the queue if the *next* packet may n=
ot fit in the
> queue. The currently processed packet is assumed to have already been que=
ued.

I was under impression that it tries to stop if "current" packet may not fi=
t in the queue. This check won't be required then, thanks for applying firs=
t patch.

Regards,
Suraj

