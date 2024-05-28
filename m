Return-Path: <netdev+bounces-98428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356148D1649
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582151C21D68
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58022E3E5;
	Tue, 28 May 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="s99MCZ+D"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB217E8FB
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885181; cv=fail; b=dw8O28FC7eSFJjbM8udAai3uk8Lw1leuTWdALLQN/4RZkC0OdLufFBFZyFS7EfcNuEb2onlGz2QrCCPNLZ5yqYxhxzxKqmiGg/7diRO0PaIEBcBAyn1ZS4maJgks1ImanuMk2oORQMxYnu+FqHq6GcmCc/wc0kh6O6nQJ2QpkCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885181; c=relaxed/simple;
	bh=ohwh5ah9sXF6G8l/ewzsguL64O9UktK3C/H7RhdhdAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jz2zWayNOsJeoPbnJSV5JHoVOr4qkXnk3eIbE1R5xP2rjZTdEvY2z9uLgxx1usmlYg7TfmNsyTQLc0307vQSxDc9Z43iwcdMVyayvW462qTffBexEqHINnGEtDO8sry/Kv+pWb/TI9YLLOSrm/3hN+piuGyG1mozplL8D5Qc8QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=s99MCZ+D; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RMxVNK001836;
	Tue, 28 May 2024 01:32:43 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ycqpym1tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 01:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPrbwz77GmOhcZcMBxyf24GC97G8WCg/UIgVgXfCjusydb12gFXGZCDs+A4C2ok6JjC5qlJl3znt2YE3nbkhKZy01DIKM7b0AlwMh27nuH8i72f62wbcCFnnaTWbEBYvV0JNQxKAocsThNw7+V/LfDEtCTOtjDPxQf0XeymjaqDCkz+ECOJZ08kbQM6ZkWBtCkRrKQbId7+T4N7tzvdVDa3vnQCDd2oEYFvV5ev/ZtzUxgZw/z33QXbN3sBZJ6bK9Nnu03sueBPOOAAnSsrw4Er5Ipyhcbu6e02L/X9VfpdDZ2sMP6iXxYNVs6PIl9JSEUpyAvevLptYdyvfK4DF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfut32F1bUoqc9MI6NbaYewQQ3AkmSWMa4bERrb6ZS8=;
 b=iUa4Dm8l8DBC13O5yosJi005PtU+hoCfj/+fRuTMo83dfoK+7Q2w31RmqjQvHjxOpL4cypO1eRn3sEdtexyA3pUl+VEJmFkYJqGRJz9QdXauiVXSoYdRtE1Sik4hi5dXBhHXKLCLAFKA72azgjzyb64z8rv8ZjylPP95w+oPWn0QHLJfwIwtBQu1pG/HuhjJbub4cDRPn+zmFKFsA7/S5wekW6T0LANAvyERN6QADSNcPOugcq/THNm1jIpS4PvdkM7LwVqyAVuQhdHAQKe3kZVZu/pxdmqYpz8TZKz6fvJybgiVm47xqH8LFnWY9c8zifskyVYOoJ1rrYWzOT1OhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfut32F1bUoqc9MI6NbaYewQQ3AkmSWMa4bERrb6ZS8=;
 b=s99MCZ+DnhsR5zNoRXh2enyKFi92OgS9NCr4QnPvB3vHpVkRI5FZBv7Hmmv3vrCcWBjQQzkCQknDnApL1Wfbr2pH4h/7655fdnasmYZiuQRUzwMds8bpsDRkDHmJkbONGzn2tZneTCM2dSsljPenGA2O3cgrQVSX+0rqN0BrOcg=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by MW4PR18MB5232.namprd18.prod.outlook.com (2603:10b6:303:1b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 08:32:40 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Tue, 28 May 2024
 08:32:39 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Heng Qi <hengqi@linux.alibaba.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?iso-8859-1?Q?Eugenio_P=E9rez?=
	<eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net 2/2] virtio_net: fix missing lock protection on
 control_buf access
Thread-Topic: [PATCH net 2/2] virtio_net: fix missing lock protection on
 control_buf access
Thread-Index: AQHasNmZaBBL5V2Fu0GzqSyJI9Fung==
Date: Tue, 28 May 2024 08:32:39 +0000
Message-ID: 
 <PH0PR18MB4474628EC0E1A9A4FAA4E59EDEF12@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-3-hengqi@linux.alibaba.com>
In-Reply-To: <20240528075226.94255-3-hengqi@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|MW4PR18MB5232:EE_
x-ms-office365-filtering-correlation-id: 3544b29e-502a-4b74-a9ca-08dc7ef0bc2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?tWUk5jV+lQsNHoIbSS3XCDMyRIw0lKJEsbdQIPyhwtJO83AF5K2JYDUlsg?=
 =?iso-8859-1?Q?X38+BYxA78O0ywi9qMn/a8mYtz0Lko19dRA2xWO7H6L+v54Oyxfi6muODr?=
 =?iso-8859-1?Q?HGEBW5CMEhmesL78cUCcC1X45og6vogVTJaLQ1VGwukp3tiJLKH96eyvag?=
 =?iso-8859-1?Q?x0Cas6N0CTGEw6rV2/P4aZCYL7gVEjj0jjoQ3jZtKizn2uJduOjZYcdKGk?=
 =?iso-8859-1?Q?k93ZfoTvs5homyolvFskozrahRHt/DfCZeDjaJo6U5zvI92F7wtpQVCibs?=
 =?iso-8859-1?Q?ZwWS74b7XsXh6BsGTylpMmX2LfyL3OVKGYUWQqhKXK1pqXWoXZmChP2y0C?=
 =?iso-8859-1?Q?fH6iUmlJGODyGuIs8Xq6INfzfHuhIHjfR7h9+/ftO2pEOAorGhKtWY5+qJ?=
 =?iso-8859-1?Q?DLbZQxHcex0ml/DAsa4dYWyEMoHIVnDveqc23df/ZDDkqzVLLLLV+NTGpg?=
 =?iso-8859-1?Q?j3fmF+w16EbfLvgWk7n9YiFLhRJMOZFsGL/J9P2zsbUOgkPHapP90PvhuX?=
 =?iso-8859-1?Q?O/PPM/ChPrIHp+E/diEOs3+/YH0tpHJGUr4iQrUDYAhE6D/GlS7foJAHW0?=
 =?iso-8859-1?Q?8SWs5SoIpLB3Jg55qBgrcrDXRupFIhXcVu7E/SJdIieSOCNM60dIKh/E6T?=
 =?iso-8859-1?Q?Vsc9QfxBSPRTEI4zqOgA19kkWyWzppnxfVgnRhFe9WZ1cWQibJw+K6SQO6?=
 =?iso-8859-1?Q?o7AxiJUhv9LWeSOP12+PcqtXFEsZzPpW7Cj5vbgXb3lFfg3sClvQVBP4Mt?=
 =?iso-8859-1?Q?Kyt5iu7yXNENIRu+hRuHU61tfhHBRBq6ISV51GfAVrtRoqGzWZW4obokho?=
 =?iso-8859-1?Q?/c/6cOAYvUZtXf3NnFbpnAFfJhJa1DSyxy903biDJsd3cy/Vla50lbZMxy?=
 =?iso-8859-1?Q?HvwIX8KmpfLG5Bo1K8KNaoDIyN6tV2PyW/QyNLbQFX9AARZ+TTW39l0Qf5?=
 =?iso-8859-1?Q?Lwxt1Poxci7YDotnnYE10PGOwCmDDAkf8PXNKi6m+SXlGwktkejd4aY6FH?=
 =?iso-8859-1?Q?uxUgMXLCGLIxrCk7t5l97MZNGoUQevLjtkivx7l1AcfhE1axqf/Ma2vXy3?=
 =?iso-8859-1?Q?waV/lzEEQv4idQmx3C8h7I5YHlpEoGyEmHIUEQtSycPFEb9mS4OqpElAk7?=
 =?iso-8859-1?Q?eyFuCqOFVp5VRpApNHN4rFz5zQl5KouJDVe+nKY+3ZBEYvRaZ2k2SZjaEX?=
 =?iso-8859-1?Q?67nOn1yOaVZVUFcUl7GYLdfMzonz+rKYZbgrvO6xNgrY9OgxJx1pNuAU6h?=
 =?iso-8859-1?Q?tG3un9Ks30xG6v/XI4EtvFCGUpdRPsAgMm5HCQNlqK4ZFjdEzgwgGojsmL?=
 =?iso-8859-1?Q?Lo1wxl29NYNo3iktQouAWuRNbCwEUrtOU4lP+RT3Sukg08OutH9/XahnY1?=
 =?iso-8859-1?Q?irn334UzZ9mrDbRET/jPXeWiYJrOCXvQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Qmv883b5o2FlcdKNrLxsLrjRVW3MSF20jNkNHqyq9Pzd5o1+GVNtY9vo7q?=
 =?iso-8859-1?Q?7G05vxwdlymjIFJq0PWWkCU/VjOJCA4N6FDVacbTJjzuHWekQGCSJS3mf0?=
 =?iso-8859-1?Q?01ZhSsCajTfUchfEDJozq9V6CIuAb1b3TllhPc+Amljao86U6lOeXNqnz9?=
 =?iso-8859-1?Q?WsuQzt2LbJK9/GXZT8Gu65GpWej7UEg2gIGx6NP4qrnwBDfJdKEVj7pLhf?=
 =?iso-8859-1?Q?ER848r7PXAqIJrEIvo46kxyS1NmOC9CBxfd8I5EPxzujmbEyua+J3tLu7q?=
 =?iso-8859-1?Q?STSH2+m/Sz/UOjFWuzUGOWgZXRqx0D6LUDO7xxcmKhxCIoo5UYngB+cWF6?=
 =?iso-8859-1?Q?rLwLG0ADklDptZokZ/oUVxyoHH0PErz2eQwAKuhKzvJzVyDE3a8Ogt98RF?=
 =?iso-8859-1?Q?Y1Lo1VQqnuf0WKkszua6dOXvCvMXJ5oW3bxT4+Ql03c/b1j0cdETMed1CP?=
 =?iso-8859-1?Q?c+x7BmtlJBOoLN/LXHwZ9mtTmoAF1vREnk28zn7G2l2rU/jZrqlFmnFEaQ?=
 =?iso-8859-1?Q?IkTFfKoZl+f7b7S5+TdAeKwgzhevQbhRL0DL5CbyR4LhjI9wQQeQmlh4JM?=
 =?iso-8859-1?Q?dySZU4dhW73ctYgodfvzOyBxI1UXYN87jBKCENi7rXqZNSXDSdt/UvEkQQ?=
 =?iso-8859-1?Q?V2/IpDKgZaR6W6U2wAe5jwrhY9qnohAnNbRS3RC7CeNEmXNXfriSWDI6ar?=
 =?iso-8859-1?Q?2PY7QjOa5LUTlCoCh1DGYtA27hVoVnQUjxP8cuKgM8sgXwpvau/NMD4rLA?=
 =?iso-8859-1?Q?YKDy9dxOjQ88wdnSMGiDc/+j9myU9gKkgqHFwscyXlZKz+Fc0YdbDtluJN?=
 =?iso-8859-1?Q?ovZi5UVWR0os8UYT2LexwwGIZSRDU2zw2x8tN6cY636dueYDvaAJO1WXYu?=
 =?iso-8859-1?Q?2Gy7ARntvIRt6WTd1FrIvpKNWTF1idvu9Vw5Ppn1b4w8UoY3tR0grVnxhL?=
 =?iso-8859-1?Q?OMKr8+aRyTPapxlnq0ldbV7XywUDDQA97js6RgfVMOF9P3teqph8PfAL6Z?=
 =?iso-8859-1?Q?wL5FOnYwyF+jHjkn32vNkqhik8e++NDiCC928e8Yx8LccrvG61E7iXxjOc?=
 =?iso-8859-1?Q?GxuoER4sY4UV5epHmLHMQClQrHfUhtqC/lVVobs97SAFIofoitWi59cC7m?=
 =?iso-8859-1?Q?KE3ayDS/5/D3r+DfKJCc4nhUOYvEN9HpjQIuizd1nRJn6vJdf6dmb8sM/5?=
 =?iso-8859-1?Q?eIp8MvVxvcFrp6XEs1kPBqrfmSRoRwCDWhio+cCl0pPs6CjmR47GhzD/hN?=
 =?iso-8859-1?Q?sz9Kq0ixeAM+ays9qIucSXznqDHKhU0b6klXKC2GWLMEK0hFYXJJJkNMQO?=
 =?iso-8859-1?Q?Bpn/Y+42PVodNoj2daRWTxI65WRPcnktzgzK4VWm/ozgENLJw/cWhWrBWa?=
 =?iso-8859-1?Q?efDsvk0Kh3JdeaY0PI02/VwI3pQ34MBerg4ty1kh/GF+lsz0slgZENlKE8?=
 =?iso-8859-1?Q?2V1WxoVL+lu/0G85pGBa4079CkorsPdumwMN8ABxMIC5NSLXtMghXtF6zX?=
 =?iso-8859-1?Q?5uECcf5kvn4DVjlJJTE4NWkb/C5A34GbOQzNOfmsoT8FnyT98TW35yIKds?=
 =?iso-8859-1?Q?ec9EHdSdk6Lha3uzqA1C1Keb2L2KuyDgrTTN3Zc3KiiTNAwx0U21CU0ngb?=
 =?iso-8859-1?Q?5H84gnnpNkyJs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3544b29e-502a-4b74-a9ca-08dc7ef0bc2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 08:32:39.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SF0dLrcvt2LSkMjsZ7SIE7ojj9SV+d09xrIsNwnbjIw0oqKVGpbGVQBH3S2Eg7KXzMb5MEOg0CcDZd9A2NxTcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5232
X-Proofpoint-GUID: xQnfZtKBGQlwVejPibco18SOVkjR1P0m
X-Proofpoint-ORIG-GUID: xQnfZtKBGQlwVejPibco18SOVkjR1P0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-27_01,2024-05-17_01



> Refactored the handling of control_buf to be within the cvq_lock critical
> section, mitigating race conditions between reading device responses and
> new command submissions.
>=20
> Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> 6b0512a628e0..3d8407d9e3d2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct
> virtnet_info *vi, u8 class, u8 cmd  {
>  	struct scatterlist *sgs[5], hdr, stat;
>  	u32 out_num =3D 0, tmp, in_num =3D 0;
> +	bool ret;
>  	int err;
>=20
>  	/* Caller should know better */
> @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct
> virtnet_info *vi, u8 class, u8 cmd
>  	}
>=20
>  unlock:
> +	ret =3D vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>  	mutex_unlock(&vi->cvq_lock);
> -	return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> +	return ret;
>  }
>=20
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 c=
md,
> --
> 2.32.0.3.g01195cf9f
>=20
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

