Return-Path: <netdev+bounces-88833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C882D8A8A51
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF951F22D60
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CFD3AC01;
	Wed, 17 Apr 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="gJPOJ/mV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDE1E48A
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375502; cv=fail; b=Kon9VudQepxCZha7dHRCgXwIt8UnBcIwieByhneNEDBFB0x6qrmGLNT2rm67dJ9emaVE7cCiqIwbUoQqCWtDhOJMM0a/GJmLgWo3TkOeukALVISry9OrPmSyQOiydYs4AVV4+4EwlyNvdFcAI+l55K5+zUd8dh3FTY9sZkaT4lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375502; c=relaxed/simple;
	bh=dlg7k9MbmF9Y+O+qr9WTr0c1HIJ0or9l8oU/E+Cu/Qs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bvzgukW5sIgVr3CFrxTFzyg9QjzBzGVHFvhI8CgoEUiryLS87yKinz+EfdO7/N+S/f8pyJ/nXQ/JI3GghB2bmAulgoQRfgYJQZSpRbKY2CBUnFICHB7yFIU6qY8OpivpdLdGr5pwhLax1poaYiI9pbJvbPHAmI2s6LE9uZpVexU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=gJPOJ/mV; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HGjr0J013050
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=9mUhCW55ijpeK3aKTlNIg5wmUG8fXhS26McIO7JQirM=;
 b=gJPOJ/mVPgCJBkXSIodqSuNGJ/0DBK1PycF+lpyeNaP0eDFwJ6XRzWYpsX4xSfIh+Kvf
 SM9hXQkSvRv8bafbUDfFXLsVCpLARUsbfaM89EaDN6Y+eWhMNNH1dVzAKRSlFfy8R+3f
 KyrHQJtudCT9wP/rnRB6YjUded5lvouytik+Mz4fSkDRH7cO9pU0PmK5SHY07T4nLyaQ
 /yyzrdnqPML3IU5uacmxZZwPrTPXFLShbtcFjTTgsxTKW39AzTzWbNkPkucTTtI6OzLh
 o6nbw8+5hgncBfhVdjt2C1kI49EESg0DySiJ6K18JFJd/rnKmcXME/xDCCYag0pPdTxf OQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xj8xdnh0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:38:11 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6855212B6B
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:38:09 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 Apr 2024 05:37:42 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 17 Apr 2024 05:37:42 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 Apr 2024 05:37:42 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9GmrD0F2OAKdWudCxayaxGofmLk+Mo7UAxITaxS4K1b2aP9sojGBrA+6zNMSaGihs29ZT3u1vd/X3XbD6v2MmnxVbyU/hGNdk63BiIJDplHWngsyy7eG9lNoFMYot5O+ylN3w3DTPU2UJ1AaH/mBuNfz+tSjP4GEHKvM1id++OumkB8/6IGrvRvdNId+pnQqzVvbJzvORYAGUUajGvfPvzQpPOZ28YN8QQQPyx7NBAN2CyhwY+JJUa92AWYft3HVdZhRyKsYm6ycULBEedpcfs3oisuC50aOUc1v8u2xHm8/uogYZTIEYPh0oG4TBVMpch9CZ9lJGqNuJrO8eN90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mUhCW55ijpeK3aKTlNIg5wmUG8fXhS26McIO7JQirM=;
 b=Nf+yhIi1XseUXsa2KgB9k1P4T4JiC3iz7ZZFS+p41g5Qj78OWcDevlxiUPzjIV2Sxzme1p+PIS7yy+fobIog6c6s1YUoikpL23faHp7SdKrix3ARHqNw2vYihLA0fLVWiW8uevAsLFnaSMy+B93qjDNIrla8VFBg9cbtxox5I/RvmgmRH12L4qg5Td+AF8t84Sz/OVflDo8l3Xzwf3FRcEblmPUyXaKZ1XLTr8Y058CJ50JRt7MpGAa/QhVMoplmuZetVcZZml/xqvtHVkDIzGuyAAML82j7f/FlmeDkdX/hXWR4DeQnOEnzdzKiKwuT1h1ZpRrX2mfln5P7qr8PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:84::11) by
 MW4PR84MB2091.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.37; Wed, 17 Apr 2024 17:37:41 +0000
Received: from DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ef0c:b3ba:2742:2d90]) by DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ef0c:b3ba:2742:2d90%4]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 17:37:41 +0000
From: "Tom, Deepak Abraham" <deepak-abraham.tom@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: 2nd RTM_NEWLINK notification with operstate down is always 1 second
 delayed
Thread-Topic: 2nd RTM_NEWLINK notification with operstate down is always 1
 second delayed
Thread-Index: AdqQ7cAMWV93xDQiR2asZ6QhL+IuJQ==
Date: Wed, 17 Apr 2024 17:37:40 +0000
Message-ID: <DS7PR84MB303940368E1CC7CE98A49E96D70F2@DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR84MB3039:EE_|MW4PR84MB2091:EE_
x-ms-office365-filtering-correlation-id: 735b0170-7463-4a9d-e82d-08dc5f0514e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7G8x8wylfMB2XyWMazzFrs+Lb3Ihgg2XFZiL3MK/Eo5DalwGOVNDGIdSKsg1xStgqx3XiZbwagkPJYDohY4dK6IbLH/nvqjk3an6q3FjTXuDzdYs/zYnbsNwVvYfL4GQ05CYwNFY15wptkosOR4oKS/QIDfs8/kl+4KlrVmRjkM9iMqq1Rw5BEoaDQAY0/QkbNdtZhbqiPQqsaesCuPE+Kenm2+eXiXjYuMnOHaz2Pi4qCy6UUnRqBVCr1iT5DymUup+hqumG9qjs4RMn8rwuEfHWxL15ujrpmZoCPLzXb7hxNnNFHwnMwb6yTjh4Le49pury7HEZLVoqcjaxLZyAA4IBTKoRdZMW8sgV/g8QqBkJlnjxvcf1vHdXbfPxV3/eHakctpZD9aGy22ItZLaeuatoiJCnrudY/984sXNdwum/xDpQrEeGpFQyJ4C6Vmv1BAXGdHX6624DiNY7Fwj5Puk578rpDp0UqiQvzcR6VBHvAm6U3QxiHTG9UKDlJdfZtdGy3p0XKI9oy2vIjx/FEzRTMa81n2+dEb3DVpZQlpu0RE9z5wWq9V77xL0m+a0doMV7uExU6hVkIP0jMqfNQ3D6F7AyGLwBAddTcnuY+EABcb/BvbtcLKjxICAFv6HdQI0+rFDUExwStYMSkCf3y+/I8WB6H3bUZop4p2V1qcKFHnXycH6npz90mqRSoCXsln7DdnWEb8fBFbE1IAPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WHpMHXr7BzHB8RAPyDDdtuXYNRmYmC0nQ2q+ukel36lCJk1X/g9QwDJrVM44?=
 =?us-ascii?Q?lQexMxVTHjqwg45ryBQeWDtOYN5Iogz9ynbOG4G44Hm+OsEguBwizw6oa/w4?=
 =?us-ascii?Q?y1VuzCU8ItW7m9ak5R7hCqBMxUL9fY1UipM/AUjr52mYbKTvZN3p+iY5DmPm?=
 =?us-ascii?Q?2jtGRbVGEpVfktP0D6CuchiOq5sE29g08kbBufsql9wlBbNMGIi15pD5lSOf?=
 =?us-ascii?Q?LmcAULeEzaTj2HgXXUbb3P8VBNVksuUtZNB9pHX7YXEC9JQLLejKZKEtbE1A?=
 =?us-ascii?Q?nPVE5AsdNtuf77nsBm4y49eI6iE28PrT++J2zTC42p4chC68MCKRB5ZYy6ba?=
 =?us-ascii?Q?PrP8xGcFHfIj1IN3Bpi9ZqivfVfC8j8q9Ypg0Qj1hdRo5MkDbZ5Fsl329dXQ?=
 =?us-ascii?Q?rVcGzOrRrJUh2h/48YuUrRV70gxkZD9oRHbqj/bLIe+qNcsmuF4s8FdPyvFA?=
 =?us-ascii?Q?+pYJq29OKRB6FQFsZkXer/N4FUuiB+/wDWYl9tY/Jy6E2jclHRNFiib34WY6?=
 =?us-ascii?Q?t/ijet5KwGciLm4yLmE+NsnQfOy5ejO4GYTjvzl/s4SyVqs+Mu0EFI+h9f+M?=
 =?us-ascii?Q?PFqTizhXbstf3m7Aew5F1zD/riR5tOv5qpFP2VS3y6U+HkH+zsTQpiYos9pb?=
 =?us-ascii?Q?xQ/jPhD9KHpey/mrXvz7OhTEAgB0aJCKXiWMArmrtOv88Hy9vPLUgSg5gXBb?=
 =?us-ascii?Q?chgZ5CyZmEf5MJ2481W2Egt7jS/fa0oZ6f4jn471/k9fsaRy6t2kF8b1qfwh?=
 =?us-ascii?Q?Us4oXPbsUIMY93dD8MoReG69DChzD66G4QAoe2Ev0QgySoTl+EJs0PuTf6F8?=
 =?us-ascii?Q?o/PEvoG/tDmCCciVAlFZL5LuSv3ffn5f+AYTKW2KNPiu0E3r76/tKHw09e1X?=
 =?us-ascii?Q?7wAzkMB4L2z+8kO36hc2vPGEFVQXCzMtssAJLwNUrIHOUc9uCBDVU7wukRgx?=
 =?us-ascii?Q?AYqsZyRIFccAqngWyzP/6fq2mB2ZeLGXBzKr7Xzf1DkcEBoK4gdqzVVQfnq6?=
 =?us-ascii?Q?zEHg94zqUwMtvYTndN/hlTOxEve1dU8N1stPZuvr66/V9Sslz4IdePrA9YwW?=
 =?us-ascii?Q?Ic5CSMqdb9hjsTUMQaG/bpU5mmEVpBWdKP2SvG3UcY2Tu2b+An55jjt9/qBz?=
 =?us-ascii?Q?EPgto8rilP61SICbx73l0HnPpQfgIWkJ9MVmpXAFaWsKtIQzPLqFdYlOUmNj?=
 =?us-ascii?Q?o59RrGIzyR5fIoPoJBcUe0Z1hoVOz/rF7PC5ozfsJ+VWbeJY1EABG0UxKfbI?=
 =?us-ascii?Q?3TKVqnvFcb8NU6vP6Yx9jOQ44zrOBHQZhbk4q80KNvQciEKrxh3gJFpcMaBy?=
 =?us-ascii?Q?dTWnG6NoWeIOxqvbCqnA1RxhYuKID0/2WVH/3eYCMgZ/jGsZAJFI3bp36pEi?=
 =?us-ascii?Q?Zl0ma5crh67gl9YzvKubD7wN9GY/xKEdUirZLCXbMBQEXs+ECLU55xNCwut4?=
 =?us-ascii?Q?DMjZZ1z8Jx/RGTbGYiuxi7aLMIlya/vqC/CxlRyxo8GaW2CgK3C7EDKpY7lh?=
 =?us-ascii?Q?oLhLBDBBryrwU7t00TBucLNMOi6fCNf4AUN6RMQ37FAkuHpK265EtDb60Pmx?=
 =?us-ascii?Q?kyJA8zQHU9tnnIwVgKEuc5kg94myg5XFEgVOXIHQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 735b0170-7463-4a9d-e82d-08dc5f0514e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 17:37:40.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxNCLFJ4Dcr1jGvQYPloN9vb8cSI0/gV9yimSXOsCeOnO8o1nlyQJgufXU/+pWy6MCu+quLA2dFhWePVmFTdfqVVO9YBPaZzE6yx+2YqVOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB2091
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: DjwOUebh6MoYr2F87Ret_r7OXdOni7gf
X-Proofpoint-GUID: DjwOUebh6MoYr2F87Ret_r7OXdOni7gf
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_14,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170124

Hi!

I have a system configured with 2 physical eth interfaces connected to a sw=
itch.
When I reboot the switch, I see that the userspace RTM_NEWLINK notification=
s for the interfaces are always 1 second apart although both links actually=
 go down almost simultaneously!
The subsequent RTM_NEWLINK notifications when the switch comes back up are =
however only delayed by a few microseconds between each other, which is as =
expected.

Turns out this delay is intentionally introudced by the linux kernel networ=
king code in net/core/link_watch.c, last modified 17 years ago in commit 29=
4cc44:
         /*
          * Limit the number of linkwatch events to one
          * per second so that a runaway driver does not
          * cause a storm of messages on the netlink
          * socket.  This limit does not apply to up events
          * while the device qdisc is down.
          */


On modern high performance systems, limiting the number of down events to j=
ust one per second have far reaching consequences.
I was wondering if it would be advisable to reduce this delay to something =
smaller, say 5ms (so 5ms+scheduling delay practically):
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -130,8 +130,8 @@ static void linkwatch_schedule_work(int urgent)
                delay =3D 0;
        }

-       /* If we wrap around we'll delay it by at most HZ. */
-       if (delay > HZ)
+       /* If we wrap around we'll delay it by at most HZ/200. */
+       if (delay > (HZ/200))
                delay =3D 0;

        /*
@@ -187,15 +187,15 @@ static void __linkwatch_run_queue(int urgent_only)

        /*
         * Limit the number of linkwatch events to one
-        * per second so that a runaway driver does not
+        * per 5 millisecond so that a runaway driver does not
         * cause a storm of messages on the netlink
         * socket.  This limit does not apply to up events
         * while the device qdisc is down.
         */
        if (!urgent_only)
-               linkwatch_nextevent =3D jiffies + HZ;
+               linkwatch_nextevent =3D jiffies + (HZ/200);
        /* Limit wrap-around effect on delay. */
-       else if (time_after(linkwatch_nextevent, jiffies + HZ))
+       else if (time_after(linkwatch_nextevent, jiffies + (HZ/200)))
                linkwatch_nextevent =3D jiffies;

        clear_bit(LW_URGENT, &linkwatch_flags);


I have tested this change in my environment, and it works as expected. I do=
n't see any new issues popping up because of this.

Are there any concerns with making this change today? Hoping to get some fe=
edback.


Thank You,
Deepak Abraham Tom

