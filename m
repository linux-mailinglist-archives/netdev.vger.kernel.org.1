Return-Path: <netdev+bounces-38730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682737BC489
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AA31C20937
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 04:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB71FAB;
	Sat,  7 Oct 2023 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A31C0F
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 04:02:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE6BF;
	Fri,  6 Oct 2023 21:02:05 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S2Wk73GQWzVlZk;
	Sat,  7 Oct 2023 11:58:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 12:02:02 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH iproute2-next 2/2] rdma: Add support to dump SRQ resource in raw format
Date: Sat, 7 Oct 2023 11:58:55 +0800
Message-ID: <20231007035855.2273364-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231007035855.2273364-1-huangjunxian6@hisilicon.com>
References: <20231007035855.2273364-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: wenglianfa <wenglianfa@huawei.com>

Add support to dump SRQ resource in raw format.

This patch relies on the corresponding kernel commit aebf8145e11a
("RDMA/core: Add support to dump SRQ resource in RAW format")

Example:
$ rdma res show srq -r
dev hns3 149000...

$ rdma res show srq -j -r
[{"ifindex":0,"ifname":"hns3","data":[149,0,0,...]}]

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
---
 rdma/res-srq.c | 17 ++++++++++++++++-
 rdma/res.h     |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/rdma/res-srq.c b/rdma/res-srq.c
index 186ae281..d2581a3f 100644
--- a/rdma/res-srq.c
+++ b/rdma/res-srq.c
@@ -162,6 +162,20 @@ out:
 	return -EINVAL;
 }
 
+static int res_srq_line_raw(struct rd *rd, const char *name, int idx,
+			    struct nlattr **nla_line)
+{
+	if (!nla_line[RDMA_NLDEV_ATTR_RES_RAW])
+		return MNL_CB_ERROR;
+
+	open_json_object(NULL);
+	print_dev(rd, idx, name);
+	print_raw_data(rd, nla_line);
+	newline(rd);
+
+	return MNL_CB_OK;
+}
+
 static int res_srq_line(struct rd *rd, const char *name, int idx,
 			struct nlattr **nla_line)
 {
@@ -276,7 +290,8 @@ int res_srq_parse_cb(const struct nlmsghdr *nlh, void *data)
 		if (ret != MNL_CB_OK)
 			break;
 
-		ret = res_srq_line(rd, name, idx, nla_line);
+		ret = (rd->show_raw) ? res_srq_line_raw(rd, name, idx, nla_line) :
+		       res_srq_line(rd, name, idx, nla_line);
 		if (ret != MNL_CB_OK)
 			break;
 	}
diff --git a/rdma/res.h b/rdma/res.h
index 70e51acd..e880c28b 100644
--- a/rdma/res.h
+++ b/rdma/res.h
@@ -39,6 +39,8 @@ static inline uint32_t res_get_command(uint32_t command, struct rd *rd)
 		return RDMA_NLDEV_CMD_RES_CQ_GET_RAW;
 	case RDMA_NLDEV_CMD_RES_MR_GET:
 		return RDMA_NLDEV_CMD_RES_MR_GET_RAW;
+	case RDMA_NLDEV_CMD_RES_SRQ_GET:
+		return RDMA_NLDEV_CMD_RES_SRQ_GET_RAW;
 	default:
 		return command;
 	}
-- 
2.30.0


