Return-Path: <netdev+bounces-45805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04437DFB16
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 20:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A66281C1B
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE62137F;
	Thu,  2 Nov 2023 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qfvbDDc8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kNlbJx2p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ABD1BDD1
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 19:47:51 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAC2FB
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 12:47:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JLC3t021977;
	Thu, 2 Nov 2023 19:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=YpKK3URU/ubliQxGBTqfidnvNoIRxVuPicVBDM9ssng=;
 b=qfvbDDc8uSOn4w1qzTI11be/V8U/wrIxAeVWFZVZJApSo+NyvBIgqCNnM9WdLm00gVcg
 psMbD/Jwi+vB6jgZmi4jhErSxwnNGguzRK0C2AIwyRFmjCG3OJnSW9Fv6DPZmL7Gy7A1
 JMHdE6PP44m95fxaC1OIEGJaafSt6eHY7wUdJfIYNZtatea8UnsuZKmkR9oiFtBuOqSB
 Bb3majL+Cta3RVSvBSalL8v6SUQ3i+OCHj95OayV2BgokJWhnq/0JFZOr+xUlRuY9POj
 3JJiri/y1lK1KBhME6pVWe/GATb1Z+fdDNX0Z3G6C1/gYPGseE3+5Z7DYKh9zV3l1OAQ 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7c2p6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Nov 2023 19:47:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2IZE8k020308;
	Thu, 2 Nov 2023 19:47:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrfasbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Nov 2023 19:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHwOVF73Fnhlf2OLGydlLmo4AaD3AfjFrIEhkxbsFrnnuAF0zG5s+JEQfkY7PXfNBo2B0Jjt/ZebwlHK3CxCugMERRnkdB+vQReD8JnVINY7Wt+5hPni93w3zfynHsbQKzi5ypHXZxpliiqYUYANKv2Ni/l2b7zujJE0Pvbab6xTJ4xt2J+C8NAdz48VsCCdVgWm94SUCKORMNWhwmfNvpQC9T/GBSLyCuWk2IlJS61QKqDzMNifMIxg+C6j2o+yvY/yjhSyRJjtOEO97Iz5KFbg8ctNemzR2iaC0ZqMQ4YXq6DTZPooPnQj9GTPCPtjKZpY03WQgvBdRZubaQ6L1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpKK3URU/ubliQxGBTqfidnvNoIRxVuPicVBDM9ssng=;
 b=l3NpDF3Ri49h2yUYpJQKie+4CTC/7ludbkGWVXacBfFoYyZCVDXlUlPcJp+uX/jMsxnD1IH4yQldnMyrbiGzSIJpLNU5SNQtDUtgPPVTfnkSzIB5jxa0N3AhSUISREdghyngc2z4dPO7E/7D+eXuSXwMOjJBOqoFJl8lkHvd3yGwGCTkpdQSyG7CGJhOebN/qShGR2PTeygwPapNXpf79p4a3ai59ryFXOkk3nuJS4NknOUq951HdvCJvGHZW3fRJsbtnNAwdzs/YSWKQPhWaxX9+BuZLBZXgTsrIyY/pYtE8hzb5nHJ0ZOyGp/x5NzlqZXCVNFcNZ1+egN8258eVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpKK3URU/ubliQxGBTqfidnvNoIRxVuPicVBDM9ssng=;
 b=kNlbJx2pQJKkU6kIiEA90BRaG+WpZfORoxo8FHJA6KgWJ8TXUCVw8X6U3eTtz0Yzhnh/uy0fMR510HYKE1oQN1Aczl1eT2/ettQqFn7cUgU+8UEUnWTubvhkobvpzpQ/92TjES32tQGZit7jD36YA1F/lsTlunDr/GDyfiIodQw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6048.namprd10.prod.outlook.com (2603:10b6:930:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 19:47:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 19:47:37 +0000
Date: Thu, 2 Nov 2023 15:47:33 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, lorenzo@kernel.org
Subject: Re: [PATCH net] nfsd: regenerate user space parsers after ynl-gen
 changes
Message-ID: <ZUP81f/bQ7yjt4W/@tissot.1015granger.net>
References: <20231102185227.2604416-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102185227.2604416-1-kuba@kernel.org>
X-ClientProxiedBy: MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3be875-872f-439c-c8d4-08dbdbdc9097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FjxbOMkiQW9FWEuWJa2BasA+mtJAfGzSIEDSzV9xaOEDncIOAC+9ug0j05oE0r1QF/9Thn6UWpqcP8y+i/cIZC77h/jWcrxOtswLRw50ZDY5vqWgOlSHmj4pz+Y6fDSOONsNEgE4epp/9agKuTNJo8u3eMXK7jXIOFm6jMn2Lu3GvA3Z3KJtXWEW/sW/PUYHnegvPhqo1vqQFNpnaBV93riDxLlwQlGeZXzwR3Z4OQ1mDctbwjFC/4HPpf8XhwRkTauIYkU6RcFH6ZRRq17NL1JUBX6e/rc1NZUMa/jUJRTPALRujFHCA0iSLuhkypUdsKSQfNaDX34+ssMzknPfhw4nYZzsr1YqWmeN5kc3mbmfpb06G5epQrVETyG9L/yfUTY/kJisOJB0GyO0I3XaN4S7okfxwgbSizhEjzLactqbb9GWa8at+Oj6cK7jHDlSIp/B98kzZDWBxK0T9vOQMNslZupkVrYkO7fYZLWLk3e7ArFoCyleLHWc/iAo3LFr4GUGz0P4PoCFEBryONTvVthA2gz8fRDArjPPnu3LGNvPf8TIrtoIwboU0ewyObww
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6916009)(44832011)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(8676002)(8936002)(5660300002)(2906002)(83380400001)(6486002)(478600001)(86362001)(6506007)(6512007)(9686003)(38100700002)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V2INjsCmiVeGJiXpKRTK4JysOljNyIyWawxyQ2Ty/mA/P8UYfn3w6fg02CXN?=
 =?us-ascii?Q?t7P+hnoc8nEk5VvDEfMGm8rwqJBQ9bPfNDlY1vSwTDlHjKdOL1t0hS+0iGa5?=
 =?us-ascii?Q?BR6N2x3TqBSdsk6s796wmRllNtwQqj2LL402rBNqgDMXXuBYw9PmeecJLUns?=
 =?us-ascii?Q?yYnkUs+xAdXxWEqTCNVZcVNs5eGB7oFVe9pNdh1fj1e/GvDq77lVypNBjAVd?=
 =?us-ascii?Q?oPrlSzqiR2wT5SelPlrH6vnR5ZBKwJtUKHSvn+HrQBBKXWNxtMnG3cFfx7jV?=
 =?us-ascii?Q?oTUay83V+qrspcaBg01tGSrvcde7Iln5Zr0xh+a12tdWvCV8y1p+PeEPhBRK?=
 =?us-ascii?Q?aZbQKvpIYNmR6n9s2MyzfKRn0pyJyWFjv+RHnfWK3HiqONDodV2aWq5yI5pj?=
 =?us-ascii?Q?W4JsI0CoBedQ0WfTzS2zUemaCb1PnxrGrYrFQrNgB8kzDsjpANpRy27eyGEU?=
 =?us-ascii?Q?eNc6ll9PlKlgHxkwVl7LCKtQX2ydeKoOn1hxkwYj0ehaljL+BWzcDulvRr94?=
 =?us-ascii?Q?0vK8hHnHZj7sUjgFd+kr1BuM9I134e3KG0OxaEFh0Y2AS/kkB0xNZwRg0dKg?=
 =?us-ascii?Q?AAFzlA194gSLSHYdgY6STK/TIDVp2LbAmI2IRuO0zZC/fm5GMlXRiwAMejrR?=
 =?us-ascii?Q?g9B+gOm5dA7PsXID3d4ztzTSJxDz/DGbiyBUStKRfIgGeLajz6kAtpH8esJB?=
 =?us-ascii?Q?ENiBMxris6/yphBPIo2gq3GvrL5aC8bj4IwDDCSLi/cMvudU2EgzMRPStNlO?=
 =?us-ascii?Q?FToWbv725Rk4ccCIgiB0AkbdOkDRhc9e0zLQFckJiybxceX7Co56y0Zh8vwv?=
 =?us-ascii?Q?xZ5Is0/dYdwTgw2ZFo4heGfrXXrm9+8QxGbLgM6vnZEaIpyPr0jdLFhD7A6+?=
 =?us-ascii?Q?kZCPHHljhzhwE5L+UuHPRS1hfeLutSlL+iN88yEVp3ejJGx79bDGXzI0hTtJ?=
 =?us-ascii?Q?mZ8Z2PB1btMXMs8GXBLI0t4fYdxcFtN0fsDE7GWhw0nRXO7o9J0cO3Bm9Kxc?=
 =?us-ascii?Q?oriYonHX41yzXd3th37zoiPZCLot58qKqtVommCYwfCIm+LtmlkkzcTWFa+u?=
 =?us-ascii?Q?YSLt+LutjECK0+DaGabFv2U+EjjI1A4xrKWgolaJhLw5f6kkwN5sM3iBe5AI?=
 =?us-ascii?Q?6ZKAgODDfF+GYix9b5GatDoSOOGjmLJtQDBxDv6islSGd5S6nPuBWeFd0xG/?=
 =?us-ascii?Q?IxNjgXRPg/anopmXEGLEJAKvKt9SUGby59jj2uX6WUCUBYLWQIiWEJ5C4Tqy?=
 =?us-ascii?Q?mFkh8xuUUCSJ+TmSDRSvjv8sePyxqDRb6mKQ+yiXNWRZ6UEQqYDwt6iHb49q?=
 =?us-ascii?Q?/7WfripKtmuOX1gyFpXFl0D9BLCkyMEVLiAzOWl7MG3nHAnn38I3u2vTFZNS?=
 =?us-ascii?Q?3dWegnzroVdarbjZtjaDVkP3LssFErDZX5SBazTA4/EKncaRE6VxGx1eZUSO?=
 =?us-ascii?Q?dnX/wpS9rxuUPB+gbJvNE3vnjPTSqiQ6K5swIk0yzqp4N+OnKQk8jG3bNA9B?=
 =?us-ascii?Q?BRogu2hEJ4HveH7K/S04KHHRUVqVnYKmS1l0k0Ehib53EUkxU3/IKqM+JO7b?=
 =?us-ascii?Q?DR7+rIjuGo1iUBU4zpRvsx3paYYoyzR1LtMwyxH1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9UfXGm2HXN7Oq/+NzlXq1MuDF7sJDfh16UZ2NEjtKALVDpXpaQ5ka/pz9alNmJr9BeD7woAKE5CBL4IURBVKk/gOYLIsczD89ReE7P7QHpxAGy4r1SMwj8kTz9GPuKaroGO05bsIkqIfm5nuU6F81XMIvii3oSe/oPWp1XAZmIDcJ6XmBS2Ig8S1fzIK6nVwiOsBS5GWogp8LTmJ0nnJULvXrgozjbd6DxO21G8caTHUcuVaICrYzX4HisNKZ+VJb+PY9S/rouJU1g9NTmwMfDrCXjWDNewcResQXn8PQ4BG/0giFF6UcbK5SCE9Bl2+lV/lHLgjQOgPczLoRMeimhGT8vlxa3FNjtp3BE2AjQIQPemwin4smN89ZhG7d2fhhdMoP2WODmoimimfcTfv3JnOLf/JQxtIzulfdvc3KQAMO8TQYOi1M4R4nzn3WlzAFexvtPcpj2Jf+O3BYPNP3DBMRxqYmbjDvIXMnEBNbAtX9mZNVhGxR32dwAzRFi32FUGA+ZDRctqOp9oDU6lKKEhBAeItFyprXxie8vXma0FBnR6NeJQ/Q3mflkA3rp+mCiXS3XUM1e7W7XL2FBehgYtyko09o3q+z/IPVy7cOsEGGStu5HUslDRgqVr7hKeoF9JD16sGFkumrMT+UfiWANEHZr3C56hGxWUJo6WiYhgKDykETsDM6n1gw0/QnCwnufi3zEf05s+YIsxi2ijR5ftnX8wQENakda6HRSKQoAsa5U2qo+9YpBqV91n6fRIDL1fc8skKMrDhGNA2Z2c0A2w3HAkNwSl1JKT+UprpGd5xHJ+EPwhosrtfsGiN9tgIJVGujDWiJzFU8IH/mRjaKSLVf5iwUUGcr5SrhaqNtRyhI8pDjUuqGVGNGqL/Bk9+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3be875-872f-439c-c8d4-08dbdbdc9097
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 19:47:37.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Arl1p/jNMrdRZwEqEqCb4ULktOHRbu2Gq2eI3JIwlkzLLKzrxbnfDEZzfH5C5jRfTM1wQAQFDmOJ9PQpMnds/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020161
X-Proofpoint-GUID: gO5HJQ3DRTqkE6rVu4DN21JsYhA9l2SN
X-Proofpoint-ORIG-GUID: gO5HJQ3DRTqkE6rVu4DN21JsYhA9l2SN

On Thu, Nov 02, 2023 at 11:52:27AM -0700, Jakub Kicinski wrote:
> Commit 8cea95b0bd79 ("tools: ynl-gen: handle do ops with no input attrs")
> added support for some of the previously-skipped ops in nfsd.
> Regenerate the user space parsers to fill them in.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: chuck.lever@oracle.com
> CC: lorenzo@kernel.org

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  include/uapi/linux/nfsd_netlink.h   |   6 +-
>  tools/net/ynl/generated/nfsd-user.c | 120 ++++++++++++++++++++++++++--
>  tools/net/ynl/generated/nfsd-user.h |  44 ++++++++--
>  3 files changed, 156 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
> index c8ae72466ee6..3cd044edee5d 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -3,8 +3,8 @@
>  /*	Documentation/netlink/specs/nfsd.yaml */
>  /* YNL-GEN uapi header */
>  
> -#ifndef _UAPI_LINUX_NFSD_H
> -#define _UAPI_LINUX_NFSD_H
> +#ifndef _UAPI_LINUX_NFSD_NETLINK_H
> +#define _UAPI_LINUX_NFSD_NETLINK_H
>  
>  #define NFSD_FAMILY_NAME	"nfsd"
>  #define NFSD_FAMILY_VERSION	1
> @@ -36,4 +36,4 @@ enum {
>  	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
>  };
>  
> -#endif /* _UAPI_LINUX_NFSD_H */
> +#endif /* _UAPI_LINUX_NFSD_NETLINK_H */
> diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
> index fec6828680ce..360b6448c6e9 100644
> --- a/tools/net/ynl/generated/nfsd-user.c
> +++ b/tools/net/ynl/generated/nfsd-user.c
> @@ -50,9 +50,116 @@ struct ynl_policy_nest nfsd_rpc_status_nest = {
>  /* Common nested types */
>  /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
>  /* NFSD_CMD_RPC_STATUS_GET - dump */
> -void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp)
> +int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nlh, void *data)
>  {
> -	struct nfsd_rpc_status_get_list *next = rsp;
> +	struct nfsd_rpc_status_get_rsp_dump *dst;
> +	struct ynl_parse_arg *yarg = data;
> +	unsigned int n_compound_ops = 0;
> +	const struct nlattr *attr;
> +	int i;
> +
> +	dst = yarg->data;
> +
> +	if (dst->compound_ops)
> +		return ynl_error_parse(yarg, "attribute already present (rpc-status.compound-ops)");
> +
> +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> +		unsigned int type = mnl_attr_get_type(attr);
> +
> +		if (type == NFSD_A_RPC_STATUS_XID) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.xid = 1;
> +			dst->xid = mnl_attr_get_u32(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_FLAGS) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.flags = 1;
> +			dst->flags = mnl_attr_get_u32(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_PROG) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.prog = 1;
> +			dst->prog = mnl_attr_get_u32(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_VERSION) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.version = 1;
> +			dst->version = mnl_attr_get_u8(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_PROC) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.proc = 1;
> +			dst->proc = mnl_attr_get_u32(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_SERVICE_TIME) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.service_time = 1;
> +			dst->service_time = mnl_attr_get_u64(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_SADDR4) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.saddr4 = 1;
> +			dst->saddr4 = mnl_attr_get_u32(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_DADDR4) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.daddr4 = 1;
> +			dst->daddr4 = mnl_attr_get_u32(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_SADDR6) {
> +			unsigned int len;
> +
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +
> +			len = mnl_attr_get_payload_len(attr);
> +			dst->_present.saddr6_len = len;
> +			dst->saddr6 = malloc(len);
> +			memcpy(dst->saddr6, mnl_attr_get_payload(attr), len);
> +		} else if (type == NFSD_A_RPC_STATUS_DADDR6) {
> +			unsigned int len;
> +
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +
> +			len = mnl_attr_get_payload_len(attr);
> +			dst->_present.daddr6_len = len;
> +			dst->daddr6 = malloc(len);
> +			memcpy(dst->daddr6, mnl_attr_get_payload(attr), len);
> +		} else if (type == NFSD_A_RPC_STATUS_SPORT) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.sport = 1;
> +			dst->sport = mnl_attr_get_u16(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_DPORT) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.dport = 1;
> +			dst->dport = mnl_attr_get_u16(attr);
> +		} else if (type == NFSD_A_RPC_STATUS_COMPOUND_OPS) {
> +			n_compound_ops++;
> +		}
> +	}
> +
> +	if (n_compound_ops) {
> +		dst->compound_ops = calloc(n_compound_ops, sizeof(*dst->compound_ops));
> +		dst->n_compound_ops = n_compound_ops;
> +		i = 0;
> +		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> +			if (mnl_attr_get_type(attr) == NFSD_A_RPC_STATUS_COMPOUND_OPS) {
> +				dst->compound_ops[i] = mnl_attr_get_u32(attr);
> +				i++;
> +			}
> +		}
> +	}
> +
> +	return MNL_CB_OK;
> +}
> +
> +void
> +nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp)
> +{
> +	struct nfsd_rpc_status_get_rsp_list *next = rsp;
>  
>  	while ((void *)next != YNL_LIST_END) {
>  		rsp = next;
> @@ -65,15 +172,16 @@ void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp)
>  	}
>  }
>  
> -struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys)
> +struct nfsd_rpc_status_get_rsp_list *
> +nfsd_rpc_status_get_dump(struct ynl_sock *ys)
>  {
>  	struct ynl_dump_state yds = {};
>  	struct nlmsghdr *nlh;
>  	int err;
>  
>  	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct nfsd_rpc_status_get_list);
> -	yds.cb = nfsd_rpc_status_get_rsp_parse;
> +	yds.alloc_sz = sizeof(struct nfsd_rpc_status_get_rsp_list);
> +	yds.cb = nfsd_rpc_status_get_rsp_dump_parse;
>  	yds.rsp_cmd = NFSD_CMD_RPC_STATUS_GET;
>  	yds.rsp_policy = &nfsd_rpc_status_nest;
>  
> @@ -86,7 +194,7 @@ struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys)
>  	return yds.first;
>  
>  free_list:
> -	nfsd_rpc_status_get_list_free(yds.first);
> +	nfsd_rpc_status_get_rsp_list_free(yds.first);
>  	return NULL;
>  }
>  
> diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
> index b6b69501031a..989c6e209ced 100644
> --- a/tools/net/ynl/generated/nfsd-user.h
> +++ b/tools/net/ynl/generated/nfsd-user.h
> @@ -21,13 +21,47 @@ const char *nfsd_op_str(int op);
>  /* Common nested types */
>  /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
>  /* NFSD_CMD_RPC_STATUS_GET - dump */
> -struct nfsd_rpc_status_get_list {
> -	struct nfsd_rpc_status_get_list *next;
> -	struct nfsd_rpc_status_get_rsp obj __attribute__ ((aligned (8)));
> +struct nfsd_rpc_status_get_rsp_dump {
> +	struct {
> +		__u32 xid:1;
> +		__u32 flags:1;
> +		__u32 prog:1;
> +		__u32 version:1;
> +		__u32 proc:1;
> +		__u32 service_time:1;
> +		__u32 saddr4:1;
> +		__u32 daddr4:1;
> +		__u32 saddr6_len;
> +		__u32 daddr6_len;
> +		__u32 sport:1;
> +		__u32 dport:1;
> +	} _present;
> +
> +	__u32 xid /* big-endian */;
> +	__u32 flags;
> +	__u32 prog;
> +	__u8 version;
> +	__u32 proc;
> +	__s64 service_time;
> +	__u32 saddr4 /* big-endian */;
> +	__u32 daddr4 /* big-endian */;
> +	void *saddr6;
> +	void *daddr6;
> +	__u16 sport /* big-endian */;
> +	__u16 dport /* big-endian */;
> +	unsigned int n_compound_ops;
> +	__u32 *compound_ops;
>  };
>  
> -void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp);
> +struct nfsd_rpc_status_get_rsp_list {
> +	struct nfsd_rpc_status_get_rsp_list *next;
> +	struct nfsd_rpc_status_get_rsp_dump obj __attribute__((aligned(8)));
> +};
>  
> -struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys);
> +void
> +nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp);
> +
> +struct nfsd_rpc_status_get_rsp_list *
> +nfsd_rpc_status_get_dump(struct ynl_sock *ys);
>  
>  #endif /* _LINUX_NFSD_GEN_H */
> -- 
> 2.41.0
> 

-- 
Chuck Lever

