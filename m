Return-Path: <netdev+bounces-33279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43B79D48D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA1C281E34
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13018B1E;
	Tue, 12 Sep 2023 15:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6AA31
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:14:32 +0000 (UTC)
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587812E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:14:32 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.17.1.22/8.17.1.22) with ESMTP id 38CCNJsg024362;
	Tue, 12 Sep 2023 15:32:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=jan2016.eng; bh=Yy7J6FfBHcAMmcbuO0
	fAomlqUlzxIeM96fI1Ys+xQRk=; b=Hj1olO3NP0hIVYsOa3+4UxJprbqL4a5NuX
	j8Px/a8AP49D+r3BlrvUcYRICPfyFUIrj/cuVa+a2XQeiF8IVmJy1nihUg8HNJTX
	/0xk+r+jJPECA+QD+qCeje3fgooytZkAR0Fxuha26p1lGEre4/NcTI+iSDdQ+E0L
	uZxgCnGFsLiPwZvRAs1y7MixhC/F3EagGJk1eZ63PWnbeb1lAPKfe5oBEO8q2nHX
	B1t0JX3CfPn3qqB6fLvsYKDKDe/i3SSICDpanC5SL0TrviWtMSojmPWmh7FW6/ol
	lqcBQt7eZGiFlpvXdgnBBt/Ui6zWIUKhfmeY/nLvzuDYMw/WaPyg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 3t0g858tqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 15:32:31 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 38CCWRFR010133;
	Tue, 12 Sep 2023 10:32:30 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 3t0m1xgjw7-1;
	Tue, 12 Sep 2023 10:32:29 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.122.140])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 2A5D2627C9;
	Tue, 12 Sep 2023 14:32:19 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [net-next 0/2] export SO_REUSEADDR and SO_REUSEPORT via sock_diag
Date: Tue, 12 Sep 2023 10:31:47 -0400
Message-Id: <cover.1694523876.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=669 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120121
X-Proofpoint-ORIG-GUID: KoGTMVIFN04Q5IM-B0S6sGtAnQyjloHk
X-Proofpoint-GUID: KoGTMVIFN04Q5IM-B0S6sGtAnQyjloHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=617 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309120121

Hi,

We've found it useful to have SO_REUSEADDR and SO_REUSEPORT
available to understand when apps cannot bind() to specific
ports. I think this would be nice to have available as part
of monitoring tools as well. I can add this to 'ss' if this
series is accepted.

Thanks,

-Jason

Jason Baron (2):
  inet_diag: export SO_REUSEADDR and SO_REUSEPORT sockopts
  sock: add SO_REUSEADDR values to include/uapi/linux/socket.h

 drivers/block/drbd/drbd_receiver.c |  6 +++---
 drivers/scsi/iscsi_tcp.c           |  2 +-
 fs/ocfs2/cluster/tcp.c             |  2 +-
 include/linux/inet_diag.h          |  2 ++
 include/net/sock.h                 | 11 -----------
 include/uapi/linux/inet_diag.h     |  7 +++++++
 include/uapi/linux/socket.h        | 11 +++++++++++
 net/core/sock.c                    |  4 ++--
 net/ipv4/af_inet.c                 |  2 +-
 net/ipv4/inet_connection_sock.c    |  4 ++--
 net/ipv4/inet_diag.c               |  7 +++++++
 net/ipv4/tcp.c                     |  6 +++---
 net/ipv6/af_inet6.c                |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c    |  2 +-
 net/rds/tcp_listen.c               |  2 +-
 net/sunrpc/svcsock.c               |  2 +-
 16 files changed, 44 insertions(+), 28 deletions(-)

-- 
2.25.1


