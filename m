Return-Path: <netdev+bounces-36842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD107B1FAC
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 532CBB20BBB
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3862138BDA;
	Thu, 28 Sep 2023 14:34:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE8374DE
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 14:34:49 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769D1A2;
	Thu, 28 Sep 2023 07:34:38 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEFctO019597;
	Thu, 28 Sep 2023 14:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 mime-version : content-type : content-transfer-encoding : message-id :
 references : in-reply-to : to : cc; s=pp1;
 bh=AxLHOCfwZq1yaEcsQcqn30s7rdkwThpStSXAEBBR5+w=;
 b=c4vVMavjnzUg7uXkxEw9j8X5YKObSGVhZB25Qc222cms5dm8JdOlZnLw7sE8FmkK5Di1
 DWlpo91XQNS6RxQ51Fl949lVHjaNfcg9mVN0Gq5sV713osuiQ3gs2WbOR+u9QTKMM3J7
 VbL6rpnk/ENYSA3P0+yV7pFmppK433bStWDVOHu/SYkmvXtnEnjYJLTC5wgfk8YMOiDh
 1Uiwviof5YQdJ4RsBA1PFMLUyXTQVp7Cjg9x+bPNCzOMmok9rH7tCJxjph20Okq1frHW
 hIlWEoYJeRIeN1L5AlCVmCRyP9qBSrhJDBpfwvbuNRcP6evGDMKYAmNpJsTLKz6wW0I3 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td60b1pcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 14:33:56 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SEGRiZ025830;
	Thu, 28 Sep 2023 14:33:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td60b1p4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 14:33:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDOfXB011019;
	Thu, 28 Sep 2023 14:32:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukvvyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 14:32:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SEWaWH44434134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Sep 2023 14:32:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0056620040;
	Thu, 28 Sep 2023 14:32:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F8C72004B;
	Thu, 28 Sep 2023 14:32:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Sep 2023 14:32:35 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 28 Sep 2023 16:31:38 +0200
Subject: [PATCH v13 4/6] iommu/s390: Disable deferred flush for ISM devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-dma_iommu-v13-4-9e5fc4dacc36@linux.ibm.com>
References: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
In-Reply-To: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
To: Joerg Roedel <joro@8bytes.org>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=4EW5zbWKqjPzkUqegKI2Yeog/8HweYqPrQukpdjyOwE=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJF+5LnfojctDCjx/MGw3SeaI4mv7zw38/Lj/Ft2hT08
 KPgZsF3HaUsDGIcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAExk0ySG/7knFN/l/d2oN9tW
 y+XYi2crtrr9zPBYuv/Eh2RWduF/2lkM/6zq5gQ/+ig7X39J+I8frwM1Wuo7/85sC4pev3gX147
 sRywA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2U2UG3UnIiNUBnMFjWrLfZLWHavysYlp
X-Proofpoint-GUID: IhblBT0oRjTFr6P_9LXOPH21qGgLJ4sL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ISM devices are virtual PCI devices used for cross-LPAR communication.
Unlike real PCI devices ISM devices do not use the hardware IOMMU but
inspects IOMMU translation tables directly on IOTLB flush (s390 RPCIT
instruction).

ISM devices keep their DMA allocations static and only very rarely DMA
unmap at all. For each IOTLB flush that occurs after unmap the ISM
devices will however inspect the area of the IOVA space indicated by the
flush. This means that for the global IOTLB flushes used by the flush
queue mechanism the entire IOVA space would be inspected. In principle
this would be fine, albeit potentially unnecessarily slow, it turns out
however that ISM devices are sensitive to seeing IOVA addresses that are
currently in use in the IOVA range being flushed. Seeing such in-use
IOVA addresses will cause the ISM device to enter an error state and
become unusable.

Fix this by claiming IOMMU_CAP_DEFERRED_FLUSH only for non-ISM devices.
This makes sure IOTLB flushes only cover IOVAs that have been unmapped
and also restricts the range of the IOTLB flush potentially reducing
latency spikes.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index bb9e48c82644..5b5ba1cd5f00 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -315,11 +315,13 @@ static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
 
 static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
 	case IOMMU_CAP_DEFERRED_FLUSH:
-		return true;
+		return zdev->pft != PCI_FUNC_TYPE_ISM;
 	default:
 		return false;
 	}

-- 
2.39.2


