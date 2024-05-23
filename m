Return-Path: <netdev+bounces-97692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407698CCC44
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B45B21403
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 06:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989113AD3E;
	Thu, 23 May 2024 06:30:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0A45001;
	Thu, 23 May 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445818; cv=fail; b=hdtQaZjuhH4dVWkNqQ/7bAqsNsQ/ilP4CaSJALDdcgnyGn25cFB7As+MumVY/QK42fCwM3/8V2//A7A9ADwqf9a8RtB9Dci+xuWRnqVgCMi/ldnPD69mI/z/roARImLE65aaXDbTAD2/PRV9UkPes1qoAq2dCDousg1T+DjqhXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445818; c=relaxed/simple;
	bh=x4UoAojGZEQoAb3+OUZKPQS5RNt8gF13zXUAECpnj/c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ExhZRc+tmFGnELCqC89xW/H61GwzeTZMq+6Jp0NVOAnHtvzUteuS8/N3YJw4TUgEFs1HsE5bCmFU1TPCOec2gfXIQnkKlU7Z1jT8R5PrSNxvzsizegtOfvvUN3WRRVaKOwO0abQwMHlBOUp0qd5+sQJJNt36fOiXo/X3tv5JqKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N5DXPX007819;
	Thu, 23 May 2024 06:29:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y9ums86gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 06:29:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9q0j0SdHWbRRn4rHY4gv5teLSZA//nSIxwI8rfF+SoT1P5PEzmu/eYWOQiCVWrzs0cmXF0p0qdknMbztcQYdMqCkgWB64H0l98i36LhNdz/B/26ZmOk5cCHrd8Ag3ljxoAF4CXxlj7vgV0qY1oh/xWVXoyoh/A2lEoTcJ6VPX/UTJOS5Fz9dMoZns2WYI5wAHkU7ELPDtH0le6KVKR6yocuznjxx68Pn9K7kFXu49VoILq1+Sp8Aq8KiF5DQXIOpib2SwmvvHmNjKKqpnVzEikWlxftzHUnYl1PjBwJz2HWliq9v7KQLbhHa8WOFx7+Jp45mKuHBxCHlteW+n4ATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vObhtnNIi4Z/O2hhILG+nhGtaAchlnnWpQ8j73iIYTo=;
 b=Uu8YthrEMjNCS1wL0xP3m6cB48BZScIptLikCgwokB848nxtR4Fe086/haK+IIGegIaIlCpOQQpzz/OTNF0swH+JYHtocq1QIzh6MoZsqJoF+s7wNDxEbaYnIs6YemIBxcB4X0OhMVyJl+XwTEnkQT0WJzQ3mMLF04QuZtU9nfUCTihzoBDpXKRRDtEhGy49uyTrGsxzqKsRmM+LdsHajNJeKaDD6Fyt5pQeuiNtHSpZY2WEguGabv3sdFe+p5hc/YZEbd++fiEaVoELogac6Df/KX99IlPlhIsXcWYtVyqI8U4rFs87qzaOj+q81GEjLC7tW9sSNA6wf8z+gxJZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 06:29:44 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 06:29:43 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: wei.fang@nxp.com, andrew@lunn.ch, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH] net: fec: free fec queue when fec_probe() fails or fec_drv_remove()
Date: Thu, 23 May 2024 14:29:20 +0800
Message-Id: <20240523062920.2472432-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a7a143-0c82-4954-8d2a-08dc7af1bbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|376005|1800799015|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5772QFlw3NfqB3LueSvuS5+f4WGkldkT3podJdFjI5M+5yvUrbo/8mnVRYFS?=
 =?us-ascii?Q?j9kiEQc+zD/L12vrkAprgBJb43TPfZGcLGKOjfDNcY1OLUIDga/qCFiRdnPp?=
 =?us-ascii?Q?k9HT18k5YIbUwSxvnUeHTH+p1ArrBobsVbYS73MdJYCWHMUtuADjy7K53naQ?=
 =?us-ascii?Q?ljbW1T/ClxgtlIQ12EJx3yHQVoyIAuK8PNoG7ltHyLHVPIqXk8B00mj4sENt?=
 =?us-ascii?Q?zdhZgHt7scx21rFzloTpjv4hA8eQh2fch284hKWa2EZVJymzoP68XcpEM/RD?=
 =?us-ascii?Q?vOBwNEXrVvQqLuxS1Wi8vTDUq/Em8TkIvT32CesxDExxrCvrlus31r/gcdmp?=
 =?us-ascii?Q?a0PSg8FF0I4SUM/21VHzlIYCjEiNjeKszF9PUIMv/HlzNjH5tPxc1TbF93lR?=
 =?us-ascii?Q?7G4F9GXkpbzaZGW3TaaIZDCOz8gmQsimHezuC27nKvf7BwXOLK3hjNNJaaoR?=
 =?us-ascii?Q?QpNbzgVbzfn9o9Hbrh7G3h9VkZyirv2gZnaSkLydEIWxIrt73xxz/LD4qx38?=
 =?us-ascii?Q?SBtf9Wfxd9H9OMrc+khVDts3w8bYe4e00HuWkrEh/oy54gNdbBVsVB3dztkz?=
 =?us-ascii?Q?+5NSosbMPRUPbTnEnvGc1BAgAnXhv2lXpUu/KCF4z2HdKX9gWLCTkEESl3WD?=
 =?us-ascii?Q?xV0aQruUKfeH+f9PabTVk+2hnv4RvEQZUe5QbGeQagUrVJNTRBvqNE30zjS+?=
 =?us-ascii?Q?kf6uy4lDJd46xlGYG6q05ULwpusheXdzBEXWj5bc1GrdGbMSHDUYHjYHLvf8?=
 =?us-ascii?Q?tilS93qElzxnSCMl8ELIuXMRYzxLZlsZHjSUSVHfRWXaUtbomxZN32eeGov+?=
 =?us-ascii?Q?jigerD5Sr8X9tNwnZbNEhTNh/iVxMbxPfEeqMHPgb9IIBp2iVnxCMsRakYu8?=
 =?us-ascii?Q?s4hWBym+W0os0ne2p2iJK4/Pl4IaQeKDWLBrddHYkDsMRVgZSKDFY5SIMOPO?=
 =?us-ascii?Q?3VVQ+vNnv/4dOxLBD8WQtHeKZyB16ka3OM/nEtvrKBCpkyVjJs63TCvsBaGe?=
 =?us-ascii?Q?v5TKbJJsPA8lW4KwiJ6AAdTB2mNDTtuhzOrgZpcDUYwzQJm2wNDgLcTFwf3h?=
 =?us-ascii?Q?HZGmTaot1tDBSI1hTnaDIFxS2B2HFPi4njFKOmj5h12Fp3ewMg7ZSRRcP7pz?=
 =?us-ascii?Q?iFxSORbkBwlByF8vaB9A9uvOP6CkuZLcOOznfs8iEVBDUCQPbU1kjtLoL0V9?=
 =?us-ascii?Q?Sihyhgiyi1r2pW84B8TcdzSB7Z6rReFuVdkBxaK2LdiB7FHHVVTwbcV/ERhi?=
 =?us-ascii?Q?zX7AfAztjwdcW7nxvLwBuBbfGSAYZOouz7ibEbUAD+CcRjMjXLuzLoW+H2Pd?=
 =?us-ascii?Q?GDPdfuG52jD+xjqPyTMBjsDfJYQeNtLOvWsMUFNOb0V8Vg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?u5SwILrVGWIy1a/c4OUQtp34Ffksg+zpklfTOoZjDNkofihuLzyMBGncrEol?=
 =?us-ascii?Q?7aAH5Of5nOOwsk1m2KsmEJk6m3V5fBd4k6skQbiWvYF1kgvh0e8BRwr6p3vc?=
 =?us-ascii?Q?7MJlE1KwN3tWHVjY+VwB7+DvUr84hsuMxctn4qcRI84GeNKSZh6y7uz17JHr?=
 =?us-ascii?Q?4o7WEUWeqZpKflm7EQ62fwZCNRr+FMq9Ec1g4CWIZMOPRLES9/X8xr2u0jB6?=
 =?us-ascii?Q?wF4l+x/weJgtjyGbZTIvkqzqgASPh+8hm55bbPWEicl70KdKVrV/uslsUIhb?=
 =?us-ascii?Q?ESDX7i5hofJmT+UlWTkCF0qNlqZ8RI1nQetF6huoM2zHFZlQlVn6FGgQVC61?=
 =?us-ascii?Q?ACfvbNL9o0hsDOrhtVKI5qNgSjdO2desM1xpHIBp5XDfYWaS9QX6Y3M0/UZF?=
 =?us-ascii?Q?IjETGQtkJf+gr6i/H6eba5Udjvnra3cU4/6qsEPjt1OhlEKGAA2giQCIJ4hQ?=
 =?us-ascii?Q?o68SILnYEF9oECg3r5rmaP7OiAaT4ZfgjkedGt77Mb34OL9t6rTRjog+BW33?=
 =?us-ascii?Q?ullgRo4ISQLSNfz9EqyywHx47e4/IjpBL5GFvNnxzEBZOtGEti70DyW7WOtr?=
 =?us-ascii?Q?tiOWp51ce5Ym7V5mfz1X1ZhG/YkFgpvrTDx0qFDNqiXON4XNczK9FFQ1oWBw?=
 =?us-ascii?Q?gkQNaM9JxYOp58Zy3XRE6FC0GES5ere/TjAUxoT9OjcSJo2JhnHwcWygbZ7W?=
 =?us-ascii?Q?0RB98cXNyV0eWjqCXC44IGM9YhdlT0JJI0IN+8OFM7lt7jSquiwSX6aihW7A?=
 =?us-ascii?Q?27p8QnN887UUswVfPrUnX219UnkvmOZ7xB/NOdbClJgB6Hfwse32hlXL/iC1?=
 =?us-ascii?Q?gHnTosuekS5XrwOihqWOt4IE1XI+lSnCnanMPXQxr5ZCq8tD70z0M+9NuDbc?=
 =?us-ascii?Q?jLnHZ5sGS9CKciAGFWDsdjfvCAfe2Yd3N1Eb5t+DZMx95dplwMrMsQDDBsYS?=
 =?us-ascii?Q?rPaTIbCfoEwt5g82plM9s1aO64oqt2VxZ3azmQtBJpZKmnBqBzGdIlo6RvED?=
 =?us-ascii?Q?9vBCz3uOUQYavToqsPMHhuVPHV7Rp502NMyGSAV9S5hcjNTslqTZE9KD9TwW?=
 =?us-ascii?Q?0qzu+glQ3izwJ1O52PgiJku3yr18CPAg5rYbaCDALsmaqZpBtB1T4DFXHEak?=
 =?us-ascii?Q?0MPQA1m7mnC1Bu84ZWlEO61ffUuYtCKWCzQd92h6JeviadLazb6NZ/q462XT?=
 =?us-ascii?Q?DY6iSLcW1crsQzK7n1gt4ZQ0G6AgWp2Osysz4Uu5JgtyWHCkQEAQIxihoR3e?=
 =?us-ascii?Q?TK3IdVOM89Ty8MIK2C74Bi1v+SDqUCNfoErjy0mJGFl6UEspdW4azKLGt5qj?=
 =?us-ascii?Q?/4jehxWfLsY8OOdGCC2yqPEcBPgfYBzEyGbstz7T3Zbqt6GiX5d4e26bacIZ?=
 =?us-ascii?Q?aJBx+PlnnGVK99IPMUA87JEvSEYFsuninh3xNffoPzcEZJNE8td05h5e8q9l?=
 =?us-ascii?Q?lnG2p0g0TkxvIbnNn874NgpZyGYfRHYJKbJ3yEusdwsyy555F6BPHiV+oE2J?=
 =?us-ascii?Q?h9x99/7clLGweEi4gvcO1fJoTqvrEFCS1XhtBZvBXs12QqU7TgcxtvCgdebH?=
 =?us-ascii?Q?ThXsiyLYgWxsCMNFPfiAQqhROcEAlhMmA1mkGIixhLpd5qtJV9k2WYVrHHtU?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a7a143-0c82-4954-8d2a-08dc7af1bbc1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:29:43.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3342SDn4WbrpDYEMEmqLwsrGC4HRKPkF6j+7TvjTH13nNA85X+kxpbTFZyI+YrKbemLXDJzwh6kHD8AusOp9fZ9k4WG+ZD8YIAgUKf7UyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
X-Proofpoint-GUID: YTUTjozT8bWWmDltCCZ-ZhjDg9UsEJiQ
X-Proofpoint-ORIG-GUID: YTUTjozT8bWWmDltCCZ-ZhjDg9UsEJiQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_03,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230041

commit 59d0f7465644 ("net: fec: init multi queue date structure")
allocates multiple queues, which should be cleaned up when fec_probe()
fails or fec_drv_remove(), otherwise a memory leak will occur.

unreferenced object 0xffffff8010350000 (size 8192):
  comm "kworker/u8:3", pid 39, jiffies 4294893562
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 50 06 8a c0 ff ff ff  .........P......
    e0 6f 06 8a c0 ff ff ff 00 50 06 8a c0 ff ff ff  .o.......P......
  backtrace (crc f1b8b79f):
    [<0000000057d2c6ae>] kmemleak_alloc+0x34/0x40
    [<000000003c413e60>] kmalloc_trace+0x2f8/0x460
    [<00000000663f64e6>] fec_probe+0x1364/0x3a04
    [<0000000024d7e427>] platform_probe+0xc4/0x198
    [<00000000293aa124>] really_probe+0x17c/0x4f0
    [<00000000dfd1e0f3>] __driver_probe_device+0x158/0x2c4

Fixes: 59d0f7465644 ("net: fec: init multi queue date structure")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
v1 -> v2
 - Add fec_enet_free_queue() in fec_drv_remove()

 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a72d8a2eb0b3..775029af6042 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4524,6 +4524,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_enet_free_queue(ndev);
 failed_init:
 	fec_ptp_stop(pdev);
 failed_reset:
@@ -4587,6 +4588,7 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	fec_enet_free_queue(ndev);
 	free_netdev(ndev);
 }
 
-- 
2.25.1


