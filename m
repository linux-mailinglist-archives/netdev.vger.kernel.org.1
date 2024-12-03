Return-Path: <netdev+bounces-148295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126019E10CD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90551635CC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FA95A7AA;
	Tue,  3 Dec 2024 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QEehivrn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA692A8D0;
	Tue,  3 Dec 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189857; cv=none; b=cGLiVHy3Y/iwAGaNZDtVWYW2d2B9S/nZy4bqNCynFxKyIh4ZjRXEAi6G5kpwTXtyhDjD4vQlU2gp1vzmBxQ4ElM26uApvWXD3DS03rqYsbjWdMjIk482McdD61kpyRW5E0KB8lA9fP4kaCNu9AKZvQnmwiuUDqfnXvEtlrU2YFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189857; c=relaxed/simple;
	bh=KvuUWvtZzcGRoFiwHZn+yzfmeEcZFfzxZucwdSWIYAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dxBt3vszKjZhHR8MfHW/TUnitP+cZZ0GaXg0egNZSb2D+zKwvsJTSQEadKGfstjIWGfo4zgDY+B+vcAq4XzSqeVfIX1pCb5G6sx0kH9sX1XuHyMMSkcjkBChthOrFVRfvZxK4Ms0sAvGJmbOUZEjOQ1eVeMy6pwuQ2uTL3RgFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QEehivrn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2II5MR004750;
	Tue, 3 Dec 2024 01:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ttPRFtlh9tOm7IOEYokU/ryAJRa/3UU0IUWzaxKLJ
	SQ=; b=QEehivrnURJqyrDvVDIMAh6yElks0ywkq3H3AtcIVLD01Oa6AVqqT5Egh
	FVqTjANHGDy7PchCoy4W9ikUGysL8XBvzsNMmOnr9EnXGayNPImIDijtQOh80lVc
	eB5tkBAoHLOonG2HILtuj6wsm4RrLZmVwcgEODqCLZWD7J6tEY6vSUxFXhl2saJm
	ekSjHFhjDriDrjn6a28vfK+n/itJ4Ez6Jud4kbsHlmK+7od21EPzvK9/OevoSodH
	GL5GIt3A86e9oCanYqPy5mbBtkW8GzSrJSRHecBzcJQ5f2vZMbjMVTjhU216KrHG
	RXpdBeNJyeIl8mhEdAfkFeLL1B/WQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4hun5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 01:37:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3194Gx029465;
	Tue, 3 Dec 2024 01:37:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ddybj12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 01:37:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B31bTdp27984612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 01:37:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE17A5805A;
	Tue,  3 Dec 2024 01:37:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3CCC58051;
	Tue,  3 Dec 2024 01:37:28 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.255.118])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 01:37:28 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net v7 0/3] vsock/test: fix wrong setsockopt() parameters
Date: Mon,  2 Dec 2024 19:37:06 -0600
Message-Id: <20241203013709.232045-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6T1AEGEvCiWmjrj4M_soyXgm4Iypfx17
X-Proofpoint-ORIG-GUID: 6T1AEGEvCiWmjrj4M_soyXgm4Iypfx17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412030011

Parameters were created using wrong C types, which caused them to be of
wrong size on some architectures, causing problems.

The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
didn't show it. After the fix, all tests pass on s390.
Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
a similar problem, which turned out to be true, hence, the second patch.

Changes for v7:
- Rebase on top of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
- Add the "net" tags to the subjects
Changes for v6:
- rework the patch #3 to avoid creating a new file for new functions,
and exclude vsock_perf from calling the new functions.
- add "Reviewed-by:" to the patch #2.
Changes for v5:
- in the patch #2 replace the introduced uint64_t with unsigned long long
to match documentation
- add a patch #3 that verifies every setsockopt() call.
Changes for v4:
- add "Reviewed-by:" to the first patch, and add a second patch fixing
SO_VM_SOCKETS_* calls, which depends on the first one (hence, it's now
a patch series.)
Changes for v3:
- fix the same problem in vsock_perf and update commit message
Changes for v2:
- add "Fixes:" lines to the commit message

Konstantin Shkolnyy (3):
  vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
  vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
  vsock/test: verify socket options after setting them

 tools/testing/vsock/control.c             |   9 +-
 tools/testing/vsock/msg_zerocopy_common.c |  10 --
 tools/testing/vsock/msg_zerocopy_common.h |   1 -
 tools/testing/vsock/util.c                | 144 ++++++++++++++++++++++
 tools/testing/vsock/util.h                |   7 ++
 tools/testing/vsock/vsock_perf.c          |  20 ++-
 tools/testing/vsock/vsock_test.c          |  73 +++++------
 tools/testing/vsock/vsock_test_zerocopy.c |   2 +-
 tools/testing/vsock/vsock_uring_test.c    |   2 +-
 9 files changed, 204 insertions(+), 64 deletions(-)

-- 
2.34.1


