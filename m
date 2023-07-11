Return-Path: <netdev+bounces-16889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA8A74F568
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C31B1C20FDF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72018C13;
	Tue, 11 Jul 2023 16:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0818AFE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:33:06 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422110CB;
	Tue, 11 Jul 2023 09:32:55 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BG3O1f022902;
	Tue, 11 Jul 2023 16:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=+4V1nFRqwTelDtAcI310e7e7t3xc9C8kzlyU277DNxs=;
 b=ymbOEdbzGq63lkQ0RO+iBGkUQEcS4UO/lxjF5K2PqFLto+ysV4TEsKigi8pkSD+0XbV3
 XL1VOnexhj0u4/lo6XBn/xKbWSCP26vhMmRAizm8IRK0RiyBmzMxWVgii4+mt2saQDoe
 WQkfBM6MOBixvv4+SnNsom8ajpTprr/jzywgI6bM0UJ9nti/578BpsbF+a3T3kS3400U
 qjrAwqeuyDNTIGrKLmM9yjvATi3gM7M2TcV35rsN6hK23qmhlVJ+Q2GA+3HbmZr/Ok6j
 74UXMpMsv5v2yolmJdhg0gscYbkGqAGt8XqOJSHUbr49tqGPzkT/fCW47BE+ftkelpr9 sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud5e6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jul 2023 16:32:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGUtBm007087;
	Tue, 11 Jul 2023 16:32:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx854cdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jul 2023 16:32:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BGQBXP019529;
	Tue, 11 Jul 2023 16:32:02 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rpx854c4h-4;
	Tue, 11 Jul 2023 16:32:02 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-hyperv@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        kasan-dev@googlegroups.com, Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-scsi@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        John Stultz <jstultz@google.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>, Liam Mark <lmark@codeaurora.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Shailend Chand <shailend@google.com>,
        linux-rdma@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-btrfs@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-sgx@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/24] use vmalloc_array and vcalloc
Date: Tue, 11 Jul 2023 12:31:45 -0400
Message-Id: <168909306205.1197987.4062725942946508296.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=801
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110148
X-Proofpoint-ORIG-GUID: VdiqWRAD5JOoA45uglvHtoSxe29wDWJY
X-Proofpoint-GUID: VdiqWRAD5JOoA45uglvHtoSxe29wDWJY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 27 Jun 2023 16:43:15 +0200, Julia Lawall wrote:

> The functions vmalloc_array and vcalloc were introduced in
> 
> commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions")
> 
> but are not used much yet.  This series introduces uses of
> these functions, to protect against multiplication overflows.
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[07/24] scsi: fnic: use vmalloc_array and vcalloc
        https://git.kernel.org/mkp/scsi/c/b34c7dcaf311
[24/24] scsi: qla2xxx: use vmalloc_array and vcalloc
        https://git.kernel.org/mkp/scsi/c/04d91b783acf

-- 
Martin K. Petersen	Oracle Linux Engineering

