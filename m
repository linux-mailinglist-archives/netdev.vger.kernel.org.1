Return-Path: <netdev+bounces-43259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F47D1ED9
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 20:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAA41C20935
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72CC1CF9B;
	Sat, 21 Oct 2023 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLN9p6Pt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XVLodqva"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFD014018
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 18:01:23 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B9B3
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:01:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39LF1bTH020904;
	Sat, 21 Oct 2023 18:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=FYxukkWAEc45ShKk87ZTHMxPZO+tOSpZ9M8fCjn8ByY=;
 b=jLN9p6PtuKdhjMd6vxh0gRH/mNPxojzzy7gc/xH9OPzkx9yczOWRqt7xZV33xKLhmRMd
 QoMh8T+jpp1e3XAqnxvbEVc9Y6nmGz4myG1vYggyZ0+oP+8xnvVnT4hWoo8NrCViyLFK
 G5FRI3Y6uStKMNu/qMFJK6X/l9Ay0dv9MlAxjT+G6dybJNtUM9a3T8LIPiLIFRaKMxAZ
 ZWid9+uy/jCQKSzUvXVEhwCmHZp1z87pOy/ccUsT6PFqJCMBCi7c+//r0HC4OYdPLnlq
 7JvEJxAZS4hjpaUQUVOF754BVWI5V0SVaWwRSe3X15fitiWz27d5VzJO75daUbdiEvby QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52drss9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Oct 2023 18:01:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39LFsVsW018914;
	Sat, 21 Oct 2023 18:01:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv532r86s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Oct 2023 18:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRDEIQaker3FUUrZvXUR0PdJDV0f2xk6z3CPxSxYY3ZF1kjLP9SXML/Q8rkSDDi5c2opvpp+2zHc9YSIhYJ8zzBsyEkN2k5H1WwGs+E82uj+X0Ft7gr+c59T9BzgctBHtnnRZQXpAqWkU2RVG/POMUIeF7NewTkzktbvaPAmdyJfPVufXH//5MN5wwvppIfgd1CdLLj+vMWgqEnoKZNXLk1BkLThR7H/TAg7U3eWQPk09q/AOFkPHx2J5H5vlKoq84quhqK5ShUwTTRxmMXbuvxcQv4px9VrXW1rfcU4/qSA5QT1pqvnFW528r5NEBhsQL3UbUIMpHM0Yvqt+zaMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iURNDbYiJ5XkFoSBJA2roUI8KmGQMuNWlw0S4uN7oM=;
 b=KeLfjtPtAQwXx4E5FHfahxBOGuG21B579DaRydTHOmjO9858bNVKC7muIl2x8GnlDl1F2YxNlh3W+C/LRlBk6/dM6jhjOlAv7iraJ2rdbCEKaVSM6DH0biv+HZWJpCKbmG0srdzcn3uVfpN9xcHkp06vmFK/tl447BNGR4tsds6a6w+8Vq9kyBk7ZdMRG1LHlN2FnFjiiC9m+htHp1Q7YYvVTNcCM/GuDACFeVfxEB8wVbpeCzpbcDGHyFg7hUlzcBNzpq7/f7jxVmfaE2nRR4G/sKyC4eSjUvDN0j6y6UGCTCp1IToPf4DG03GY8HE7LdG8xuvvVToBs7zLlflA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iURNDbYiJ5XkFoSBJA2roUI8KmGQMuNWlw0S4uN7oM=;
 b=XVLodqvaXUU3ffflNHWkITzcT7PmNOp3DIOte6Ix1PKQFpoSPgzLR2BRVRT22ztl27YlBUifV+oI70CQ9f6jmp9w2NbOo1slAbsyq31sLRGD62rZTgbplNjsDwQO0kAPfhD5swoUHdLXS9LpAGOXzR39C93yMLqrgtWaeA7vyVw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7635.namprd10.prod.outlook.com (2603:10b6:806:379::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Sat, 21 Oct
 2023 18:01:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 18:01:06 +0000
Date: Sat, 21 Oct 2023 14:01:04 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Moritz =?iso-8859-1?Q?Wanzenb=F6ck?= <moritz.wanzenboeck@linbit.com>
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH] net/handshake: fix file ref count in
 handshake_nl_accept_doit()
Message-ID: <ZTQR4J9ECvvwvZgM@tissot.1015granger.net>
References: <20231019125847.276443-1-moritz.wanzenboeck@linbit.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019125847.276443-1-moritz.wanzenboeck@linbit.com>
X-ClientProxiedBy: CH0PR03CA0412.namprd03.prod.outlook.com
 (2603:10b6:610:11b::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef76932-353b-4471-63ae-08dbd25fb29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZqKVNBDdQYY6sNi33EYnFFbWUPmO23YUuIsizXH6AiFSYSnT3oJQ2m41CR2YT0kLYHM4osh5nSDiwfdkFHambbGoNFnyct+oXebSOH/2gbH+sMzN5gCKjG/088ngnquVdP9Z+26mZw+4Xm7nePxz3hJt9Wy/5QIbxbwm/jd1Lv0DC/wQYR62pkY9Ip81zTT7Sfw266r7uvyAPIcLDUvgeKj4rE7gUzk5xVenbfp+VkM+HtSIPRzvJ4YhiC2UbeBJ5WQIXEiZ7CLJOh+yQd73MMFAsnsnKiBz7LJKXMS4KbZBJ/qfSm82NyGvNmROb7qWigJ6mgXaDAeU9o/rEiUkz9RSYpxstbW/c1bIhZGpVlIaFowAk3u2kEI/ywqAhG6GpRrligRA+wvFEQUt4w+tBah6KsZfkJBkdCIpRLtqdPQoEhDeKpqr+FyPwgP3QGl4oICDLjYrVHCoR/v9BCde0BFfShX+783IZXg77aautaDjQoADLFX2uv5oqmD+zn1wUggZymgJaAsKVV/SIzpLSCqqGcilKbArFi7deZcnUW9Gj7fk/lkoaE2SQHuPcPJQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6916009)(316002)(6486002)(66946007)(478600001)(66476007)(66556008)(41300700001)(5660300002)(6512007)(6506007)(8936002)(8676002)(4326008)(86362001)(83380400001)(9686003)(44832011)(38100700002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?QEzyiRq409FKCMblk4tfPoTu5nHnaJVL1BQ5kmgYgaYqnq0uZlOghaOFtf?=
 =?iso-8859-1?Q?MWtYKi6XzrFj9tHKKba9KTITO5CGdILFEwlji1R/KXAM3oDy7oSOsJMaQR?=
 =?iso-8859-1?Q?KAnlg67ZkfPLepOZk6vEvH1PosPCqb3qUkf9mnrmf3skDet8GbFPny8SlG?=
 =?iso-8859-1?Q?ZHf6zWmLIgxVjjvywBj2j6Lxsi3ZEUdW5KYOtV+ktJ8NW6n5OJ1atJY9wB?=
 =?iso-8859-1?Q?2wxFQK7Jp56qQ3dHpkSmKBihrXgPeJuszF+2lf0dLj+2QOsynMnB/w2aci?=
 =?iso-8859-1?Q?Ho2HVmDjkEwFCyStw9qnsYkN7/W7SkRd0AuvKsfKMe5E48nqFkmiOwg5Q5?=
 =?iso-8859-1?Q?dzd9DBFCW7dCbo2iuQ8rfM+xKbQttcjLwglD7DTU6n5tXwpk0+W3i3GtTM?=
 =?iso-8859-1?Q?uBbI+uTSqs0g63WlmQTRnF0pAgOZUn649LfSC2BESbmRmjtXSqFMCLRxBM?=
 =?iso-8859-1?Q?VuuyJZ5qI2bZLQSriBEWQSZ3kGLbavMkBHzYaqzjr3zy8WyXWg0WBa0YrO?=
 =?iso-8859-1?Q?SbR0A/PE1MeAIfR7CKhKBY+QLahWR/FMNIkN6svkH2cXhYl5ugO7dVt703?=
 =?iso-8859-1?Q?Y3VqRkuxt3frO2EzDTlubU90ez0oCM8SwG0EbVcsdRmgHgeSNE3dnUanxa?=
 =?iso-8859-1?Q?c8RKDfz9yinAMWzG81ZHTGaSTTMBhZvOrTAEZc9LOQrxZOp3MpLAv4zN44?=
 =?iso-8859-1?Q?buQTs/r3uu48T7glA67HeUMF44Z0tTbXpH9B2Arw930vP3ZpxPzMO/jpJL?=
 =?iso-8859-1?Q?CPdeopg92AUt4GEEdMyyCm72sOvjjSw0ZrnFsW7yH7CCYYIlTYIv7/H6Jl?=
 =?iso-8859-1?Q?dnbw8+r6U/in75/6qYJ+z8Hdohjw2iYjv3f8NPEQTLity/rnDg6BmFSLmV?=
 =?iso-8859-1?Q?let+FDYLnfDrmnATHsi6lKJU27c9PBPVfT7jF7AywuXmBzRD+CdLzesD2w?=
 =?iso-8859-1?Q?EYuFJK9kZCc5kCrO/xcMGu0H8Xs65EOJcc4FFZ8eY+m+/tIGGEXR6wulSa?=
 =?iso-8859-1?Q?6P4EzDtVQOMj8OOvQ8GpngyXjRGUVNAqqpkELPiwGsN/RC7fFnQ2sl/CH/?=
 =?iso-8859-1?Q?+F5ocr/oCI68BFgabvJiTwE6az+jmCspE1sSLLclR60qOJ0EOkrUbvV84/?=
 =?iso-8859-1?Q?a9iB4H/K6AyX5ePZrC6chDqtQdJH1SD7uO8bw7WJU02Bop6hgmIU6o60bs?=
 =?iso-8859-1?Q?u/5nW1XLDzUc5SI6rh2Fo/jjYR5QZHqd0Rie1k3VBoCVAgaGfHXYrBLGRM?=
 =?iso-8859-1?Q?dYMRoQL/HfhzsaKxpeg0wmC79bUSQ08HvG6j/2iJAIhnYad+Q8RxZRc+ZJ?=
 =?iso-8859-1?Q?6FeQTk2+a2ExeKQd2b2kz6dhkUn56VIvZdPko7SIM4ewG2swpRWM2aeV7g?=
 =?iso-8859-1?Q?pJdrrrbXIxfCYn3LHETtyCDcLTe22mke03TWFeGKxqK3q1let/C4hBymd4?=
 =?iso-8859-1?Q?o1egwd69HHSEcCYBFE1hbf7Jjr/ED/W84Dv8Vej4j4dBdkqNa7c8wPmifl?=
 =?iso-8859-1?Q?DrIuzbHdjNekAXosiiSppZS5dsgqWbx3nmg0VVZYD8ldQwcJo95DCnFjq9?=
 =?iso-8859-1?Q?fRlfLIZbFAMN9/XdsTJ/QGMGzLFd9m0junr9MDNv7stAn2PWxb3iyCGIX5?=
 =?iso-8859-1?Q?DKD9Ky4utMHzoVofxPLGXoI9tOiVPw+HcJmgf1jIbAxIYmePHb/VcAGg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HBoE09M7nLBTGU/j8wKTUyK2AKNroIweX5n69naNQmBF8aBW1kIsX2gX5geOIjflAHz4O+wjsEP5ngUcKV3BJqxqVjf+bK3+uhIbnLXu34ZGFrp9+TPVOqHsFczW46Zgz7Jww6jMTiwwB4UVJVN/8UQFW7c3hzXAyTO7Bb+oxev6+h5yMYMHe8D2AWjPgvT3KhMh9dKtPpUdAAqumE7e7LeeGfRkZSS0Ai+sNTezZU6TbPluF1Asm1y6cobUOqtYrL7V4KBK3PMKr8+sOYKnlGKiY2Ri7sTlSGA8I2Trp9mW2CjDidhPKl0GrYeEYA949RGP9hsbalnWaOK6w+1bfup3AMmr/E7ExAM9Ty5GDDEdzfnlyXWxCY5bmJwzKHfrwRpQAdYZ6lZG9DTNrpC4EjPJIVkVE85/2TwSdlbVhsS4t6SBEuyvqMCJkiEgJeVpERPWX8iq/k2y+OTwXo1wFPFUAe9/lkdJB3lYVfl1TVS/SuCC4y1zD4CsqhqDjT5uaEQPxly93M058ZkQ6Y2qx3K6edxvimFfwx9kWag3adPsmx+waq1QQAvYUr1jSiQW0Gf2LUHoc+eRFgJVDFqTONGmqf9oMB03PWjYeIdTg6YC5xO404/9qv4VJdVp6RzfEq3L9VF5cxAyDqVi2dhsN4qSgiJz6R8kEeDYsmmHYZOCKmZdOSBQftHyRqCCtFKH6S+kJRa9EU7MB9m/BBeJ5PNJheAHiKhU9ZV6PYtNpsSss602qspd6lQwV11Td3bQpcnbj7MJbOFyNgOBF9kbLjZHLpwhkGF8Ax21sPHQxe8eMvlY3pZ1MJdw3rlGhI7ZWPke616UAHAhBhKLMAWTow==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef76932-353b-4471-63ae-08dbd25fb29e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 18:01:06.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2w+gwDMnB5o7N5kro0GULtrXbuQFFEwec6sygylSJMz0V0vbfW2+66NBMTO9aM/TDhaUJ5xxwucvGKJI69L15A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210165
X-Proofpoint-ORIG-GUID: zpzHzhjTj-hW6ecy2pmusor33Kt4bYiD
X-Proofpoint-GUID: zpzHzhjTj-hW6ecy2pmusor33Kt4bYiD

On Thu, Oct 19, 2023 at 02:58:47PM +0200, Moritz Wanzenböck wrote:
> If req->hr_proto->hp_accept() fail, we call fput() twice:
> Once in the error path, but also a second time because sock->file
> is at that point already associated with the file descriptor. Once
> the task exits, as it would probably do after receiving an error
> reading from netlink, the fd is closed, calling fput() a second time.
> 
> To fix, we move installing the file after the error path for the
> hp_accept() call. In the case of errors we simply put the unused fd.
> In case of success we can use fd_install() to link the sock->file
> to the reserved fd.
> 
> Fixes: 7ea9c1ec66bc ("net/handshake: Fix handshake_dup() ref counting")
> Signed-off-by: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>
> ---
>  net/handshake/netlink.c | 30 +++++-------------------------
>  1 file changed, 5 insertions(+), 25 deletions(-)
> 
> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
> index 64a0046dd611..89637e732866 100644
> --- a/net/handshake/netlink.c
> +++ b/net/handshake/netlink.c
> @@ -87,29 +87,6 @@ struct nlmsghdr *handshake_genl_put(struct sk_buff *msg,
>  }
>  EXPORT_SYMBOL(handshake_genl_put);
>  
> -/*
> - * dup() a kernel socket for use as a user space file descriptor
> - * in the current process. The kernel socket must have an
> - * instatiated struct file.
> - *
> - * Implicit argument: "current()"
> - */
> -static int handshake_dup(struct socket *sock)
> -{
> -	struct file *file;
> -	int newfd;
> -
> -	file = get_file(sock->file);
> -	newfd = get_unused_fd_flags(O_CLOEXEC);
> -	if (newfd < 0) {
> -		fput(file);
> -		return newfd;
> -	}
> -
> -	fd_install(newfd, file);
> -	return newfd;
> -}
> -

The point of the handshake_dup() helper was to underscore the
similarities between dup(2) and handshake ACCEPT. That similarity
gets fainter over time.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


>  int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct net *net = sock_net(skb->sk);
> @@ -133,17 +110,20 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto out_status;
>  
>  	sock = req->hr_sk->sk_socket;
> -	fd = handshake_dup(sock);
> +	fd = get_unused_fd_flags(O_CLOEXEC);
>  	if (fd < 0) {
>  		err = fd;
>  		goto out_complete;
>  	}
> +
>  	err = req->hr_proto->hp_accept(req, info, fd);
>  	if (err) {
> -		fput(sock->file);
> +		put_unused_fd(fd);
>  		goto out_complete;
>  	}
>  
> +	fd_install(fd, get_file(sock->file));
> +
>  	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
>  	return 0;
>  
> -- 
> 2.41.0
> 
> 

-- 
Chuck Lever

