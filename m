Return-Path: <netdev+bounces-236634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B747BC3E809
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B85E4E6590
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E8274FC1;
	Fri,  7 Nov 2025 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JLaCvzYK"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010016.outbound.protection.outlook.com [52.103.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D5F50F;
	Fri,  7 Nov 2025 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492891; cv=fail; b=FalrJFKhhxyoVZZRnz2BsNFM5XhFr8cOYViGh2Kj9IYS/oxVtiz5M7Fji76AhyCE2NNDRI40bqW3RPLXSQzxMlg489731BfFWC2KzC99osVANFGM/yS+H5NPC10ngLpU8MUV6L2ATL/OifHKSI4e31dZ66O/uRrksYHSyHmFscA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492891; c=relaxed/simple;
	bh=iTC9PV62inXYrplfJqHp0Cdlv5QGy9Es8y0pftrTgpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8QmWxDbYnKP+Aek/Ck4UBBdd0DJybFl5iz4Lrms8Y8RG8qZ3WCh3AYtrnnNf+pKp1Dkz+kq9y2axt41cRMmItLfsGmLDkuuCwEPN1KowH087RFWGintc3kuGf5B38ep+0IvYGv3N+BtGWGfPoKgVSgL2vg3ucrhxrjIwjZJiRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JLaCvzYK; arc=fail smtp.client-ip=52.103.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ca/WMDbsmCxilaiuykTNGx92UvjY+w1jBAGQiad2KZAfWLPEPqJK4YxMUZgqi3dH0Gk0sQ0M4p86S5TCBTCeCN+dB9bGHMtQ93/N9V0jjfIS8E2qFnmQmIxUn459Gf3G2CvLdigh0Z5nGHjkntvjygRmBWLgRYhz/4+iTirC52N5HlRf4HP5wOXh20dClKZPli4fKZ/uL4m9ZsxzNAbftidBs1B5U/WZQDa6Y1y7rQoGPsYommPpifXTZxeiMoRLIzDLDaLpVXdFQ3Z6Vj352srVDPoSGvAYJ77gnn3L5E36LGFlr8Y1AOH7UsvBAmLP0ivApAMtQqKBkcrekTGt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09axz0DRSTcUp8RpZndO0LfoBeJ4RuE7OADsJDv0ddU=;
 b=tNBSSB+qlrKJT8FSg5gI1KkRb+HrqksPTymOpSEiGhw0Ax5W39USdZMr7vK1krMiv1OC3+lfXHGf9wFRPDjIB2fSgeOEqT2Spea8mkcaVQ02mSeC26GS7KY7hjK74jyPflbiyfcQ0Avgj8pOzU4aYCSx3kkWu9d4LQLaSkQ1NZm12VKd+SB+MQZU09G4nHTZOe6HxMEBJDtBXxaeR8YLKm6pUnOb8n0EJYZI4UlKW19yfjijXW8DP8CeWu7MdBjsiY2fR0JuzUTe3Fy6iEbh+UaocY5TV69JTqI9HSNsJGsQ7c45JguNdzyYu7YMYxpwQuEA/kJkhwGSr2JwDi4uDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09axz0DRSTcUp8RpZndO0LfoBeJ4RuE7OADsJDv0ddU=;
 b=JLaCvzYK9NfbNfKOOt6RFt/lV6q0wcDNHU4FRf6GJSZ/BOPWeRMTB5jrjFP9tGdd9ReeQWdCceg/9sG0dBrmqgiMRn4pmBbPNXE3lNaWefnSfOjgglPHfTmSMqFPPCMm55kVKX5Gpy6yOQQIfcByOdNPMOnVHc7KkKTpFe/sWeQtAN1xzhl11akgmCHSMM0Vj+h63wD5/dmkZHu9rj5UOi2+6v1x5x79H6t27js37x/LP+4spZByRf9IFli1RSpfe6eKRoAqBvwA6/L471hlckvnplM6n3smTv/czmG5xeKsSnUHZwThl6kk7iDKvSFNNE+2lvIXieTc2JB54oqi7A==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME0PR01MB9633.ausprd01.prod.outlook.com (2603:10c6:220:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:21:23 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:21:22 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: linux-kernel@vger.kernel.org
Cc: pmladek@suse.com,
	rostedt@goodmis.org,
	andriy.shevchenko@linux.intel.com,
	akpm@linux-foundation.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	mchehab@kernel.org,
	awalls@md.metrocast.net,
	linux-media@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH 3/4] media: ivtv: use scnprintf_append for i2c adapter name
Date: Fri,  7 Nov 2025 13:16:15 +0800
Message-ID:
 <SYBPR01MB7881E898640B21ECD10A9F4BAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107051616.21606-1-moonafterrain@outlook.com>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::22) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251107051616.21606-4-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|ME0PR01MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f934f3f-0ac7-4e65-21a8-08de1dbd7c59
X-MS-Exchange-SLBlob-MailProps:
	02NmSoc12Dc43FlQvP2yewYSt45NTkBZi1kInfGnmyOToGMRrMBbgeq2dn7geSo3MUgl9QfPNupmAV3CydcWoCzop8xWgb1ZbQ8pfjPE7YIja9c8A2ud00S8XwsOu0VxKxmNR9MkbwBYgUOGvBJIqfRb4jaYn+hB3puoBsufCf2VdYhyKMNAlTQtWpU5VmBYbkHNzRGj5Yht/Jaz1MK+o1daOAhPdp4N/GuXo+tTc1f40HKeVqWYdzzoWxHCWXOt59wtx5QAyMusHZr4igFS2eKTrcL5EpXMvknCLDask7j65Gc9Rikv0+V5KyhlOOF3Y328l9U/IWobVSirssQlPCtRaNmAXcTC00HEoHju9vmcu32IW0VFDS8ttORRDskO1OOWenkTJV3+6WUUZcqWELxuueCxZBDRKAcWZEkwwMgmPB/edFCD3UGJbTTqBYgy7dH+zlzjjA+QzC6ghyXNPT87yZhyenHzTAsRP/Z13uRep5ftrXNyjYMW7dRKvb21nQJLMFipYO27JIQURtbam32HsDWW6dmztqbBLpVSuNURsY3bCdB+HY8iXm0kv8endPMx7MSATR084n0gZGWuwjlRu3wHgyzrrDEaLabzMQ8Vet+GdWv6z80YrPJA6XJOQn6mLBIAsHsiYW4R+q9q6Mou4lcHDR7va6hPrpbbW5ceJZNnuzr5nMG3Ho69kx2S8oI4oMLmC2o6YPliPHGPYEolHgj9T/rriuqfEak1V25tJ3OQzeZps5HYFiSCHCpn
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|461199028|8060799015|23021999003|15080799012|19110799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fi95URHs1v2cLilqsvrTTAs+d6YS3KDjo3Oz0z8h0B2O5PadO0NSgRNm5q9i?=
 =?us-ascii?Q?kqz2kW5fkdyTL+20bDo7k1Uh+wu2m5R8vqY51Ocupg5PHlvIr4Fe3JeNL/7M?=
 =?us-ascii?Q?prLGZ2dU3yBmd3OrXiuo9fLwETh84FFWrKwIFQEaXimTfPKOaYsQ7uQQlBwX?=
 =?us-ascii?Q?E+7v/uuJ37OkeGHMWFGi7n8IKeq/BfcHu84Z9eBxodevIb7wE9kkB3pLawjJ?=
 =?us-ascii?Q?DKaJgcAJc/fH3ZRwem7jeSAFvs3yJGFNndmXYH8zDJwhUcgDflPpWqLtQKR2?=
 =?us-ascii?Q?EKKWUGrrrPv6hG4vPaz8DPnvYlHyArZj7l6dKbl2yYYRjS+y5+c3AK5TNWEu?=
 =?us-ascii?Q?SMFD+/V+t7NDpR7ynkdgBFM0XKi/5bySHjXdj7oVxj50VSc47R9N+MtESJuq?=
 =?us-ascii?Q?bJXxlcMlxJmP5SNn9COTeUfKF5W/E+ejx7ZTWE/Swr4jdRRoJEebbeUCUCAS?=
 =?us-ascii?Q?SuRl4aZoaa2VaHOvOpW2qLcxDzlY1g6L4TZK8mtUdZlPelyh5rnOM3+IuQHN?=
 =?us-ascii?Q?PCSZ1FobGRgFMypngwAm4uOP4WhclBWhgzbbV6ueKE5lk8zRskJrcHjRYVKe?=
 =?us-ascii?Q?pS31j9fOTow9hb13973eJF76b5yeZ2Uf/C1q/6Jnvi+Uu+/likGS03u5J08P?=
 =?us-ascii?Q?L1UTgtEpLXArj0EiodRcfpNZfleSBCGzTkjzhG9DWYki7UlFt51IIMmVHoYM?=
 =?us-ascii?Q?D2d+I5vlUKbWIaDCbdEvNkg+DqQ/neOXgfkuBXgHklsGWwzibeuK23QOcLjy?=
 =?us-ascii?Q?lNCyy35bXb0Vi0StlOABYaDy5du+V+WHDJjf8YjKnCO28h0fbnzG2x/5KOn6?=
 =?us-ascii?Q?HxTPugC2SYLNrNT14BNkXigTZMiKweiAVDQRpRUMgJE+4iw0v9b9SlKsyS3S?=
 =?us-ascii?Q?X3nEfvXMcYHHV9VlAgIvj6l5vXqSfDk2hNKxwViWMZHEyYaS1m+vv7Ceg98K?=
 =?us-ascii?Q?dxrcqGQ22VpTcoYIHyLfUdOrV/pdZ+0e1ons/AnZec2baCTes4xI3gzmn+ij?=
 =?us-ascii?Q?xq8tXajmC5i1HX0LjorW2r2olFoLgri1v94k+Y1mwHYTVmQ0iCvPwJAW0SGY?=
 =?us-ascii?Q?CRXi0TNxKvWjk0HWFrN4hGrGLuHvpMeWMTa52Dfn6yzRByjdICOhhBrbAHUS?=
 =?us-ascii?Q?dwwr+mxXKwERScXhDWix2OJddGmpsv+5LWlC8Sp73gNEWo8y0iRCUS9ey64E?=
 =?us-ascii?Q?nAkrcZOYX0hJgooTUkWQS/5QPNXrrBeI5Ip2rA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i504Nevx3UPYznU/S0CAzfqr2pVLpQBrIqLehNCDDrqeU9FdB8pNInWUBHED?=
 =?us-ascii?Q?sqt/C/+ue8whX6IEhDVDAcw4DlwgpEhLRmRBraLGF6IYOfpMukx1A0TZ9c1o?=
 =?us-ascii?Q?gn/PfNUgoHYBYu+dJbXS8CBNT457S98RboZwm5q6e54o0MpEDBInPkX6AQ2f?=
 =?us-ascii?Q?5DsnkJzRUoKg500QZ+YjeajTupy06V51snrMtOhn7joPFMPk+n3FrNzTpJQB?=
 =?us-ascii?Q?nlJzoL+PbqMXmcxbV8Py2B5u0UpGfjEjbSYegCEGievEEXm91GZKwPVFnAfI?=
 =?us-ascii?Q?dtghF7AbcIokfIWGHmz1/kOH+QSR8DTFIUewD424qT3iOYLJcoa4ZVVXjpgD?=
 =?us-ascii?Q?L17mqcc5du0/WvIaUpVd4RoLsP2oo7bnEG2/s9R7H833GNnmoy7vje9uic1n?=
 =?us-ascii?Q?GPb52gCGfld2hALyDP0XPc4GH7lVsTXyG7Kd0B7i7Hq0CL+0XAHIg06CLLUB?=
 =?us-ascii?Q?Z8W3wXhmBf3hpVA10aOou70b6/ctK9DM6GZ/RtlX95drNNpPSY7MEfWixMsC?=
 =?us-ascii?Q?mBHGhGSWrmrlArUpPMlXUEu5emRNz5+Ps6xyHK7XdPn6hwuF/1zeFC/bhEsU?=
 =?us-ascii?Q?uHhEmk6T0mOt+fWCR7duFSf5ptk1PZZZyeLzf+t15/+TujDC9wS3JMROti5o?=
 =?us-ascii?Q?KyNn3PvASJkbIbVFdoa4/PceUhIkgiaUUkc7+UAgSMNW9o6aD/wAkEbv+oBm?=
 =?us-ascii?Q?++ureCgUIkT+DnHcROF9unsiod2DrCsmqHGXXnySRwKU834K72LTCPiRPK8o?=
 =?us-ascii?Q?c14Bbkl4ze95YPbwYZQ25D2YQ2d/S9zyyGwTok69olKoKRP25mbQ3nwNaFxe?=
 =?us-ascii?Q?Un2kVTCNXOR76cktOltiMeTuUL7tp5jTWbAS0D0uKopH3773QqAJRGMjAA6H?=
 =?us-ascii?Q?ZLKa4E7dULuusjwCC9Z5sKOzqs9RtVzoLYp+AiojOul4elI7HLS3+ebBSm56?=
 =?us-ascii?Q?pG8AKgFHZmakp5kYAwk96Tk1dn5t3URqANlNXkgYv89P+1ip9CAPkbJUPDjQ?=
 =?us-ascii?Q?IM9O2jBQm0QO8S5JQxsgZ7rYnbRi3LUV/w5WqOAOmLAf01e7eIlTfvAqm/7Z?=
 =?us-ascii?Q?HT++euYJbQfo3zaYdTv+89yEthHDkaQytVum/j2qVON6r8ilvFt9eCb7xKXZ?=
 =?us-ascii?Q?eFduAtBd+kcSBj5SauVfAmjchqELubqE7ptVtKtr4IM2cqg9Z8z7skJT9g1H?=
 =?us-ascii?Q?7dpc0sAle+DaaoRaaFqFDNfHcdaYxrqwkYBit4vVlqZ2QexFgezJFPNX/Otn?=
 =?us-ascii?Q?7MuC/Zn4Jfoh2qORJJDD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f934f3f-0ac7-4e65-21a8-08de1dbd7c59
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:21:20.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0PR01MB9633

Replace sprintf(itv->i2c_adap.name + strlen(...), ...) with
scnprintf_append() for building the i2c adapter name. This provides
proper bounds checking and improves code readability.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/media/pci/ivtv/ivtv-i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-i2c.c b/drivers/media/pci/ivtv/ivtv-i2c.c
index 28cb22d6a892..a12c6b9fb4a7 100644
--- a/drivers/media/pci/ivtv/ivtv-i2c.c
+++ b/drivers/media/pci/ivtv/ivtv-i2c.c
@@ -711,8 +711,7 @@ int init_ivtv_i2c(struct ivtv *itv)
 	itv->i2c_algo.data = itv;
 	itv->i2c_adap.algo_data = &itv->i2c_algo;
 
-	sprintf(itv->i2c_adap.name + strlen(itv->i2c_adap.name), " #%d",
-		itv->instance);
+	scnprintf_append(itv->i2c_adap.name, sizeof(itv->i2c_adap.name), " #%d", itv->instance);
 	i2c_set_adapdata(&itv->i2c_adap, &itv->v4l2_dev);
 
 	itv->i2c_client = ivtv_i2c_client_template;
-- 
2.51.1.dirty


