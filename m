Return-Path: <netdev+bounces-148545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D629E2114
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5572856AC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4241F706B;
	Tue,  3 Dec 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kgiv7uJQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC59D1F7540;
	Tue,  3 Dec 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238446; cv=none; b=CWVtGCz876mwbkk0czyUwrpW4dCEbeL7YvNBlbB7pOQ0TcbHa1W4rgmji8nX+7K3z3A6ziv24f5VBbMjWptekC/sOA38NRbOq1c51r+6JhsZQtKXmZzU+fNaC7irZLF+aBeQ7rimhFn3U5r+TBkrQVdQbINeqVEeSoYeMTGsYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238446; c=relaxed/simple;
	bh=xXBcRnIrgD8fUS7wJkQhYHbIlIYiSrOXiVG5OTk4puw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dpcdIVIpTIBg/VWitNjyACzo4cwfYu0WoiuhvRfRyU066A+a/IHYLv5qZadboYzJSPJP642ej8klDiymAtKStROAketf+H1vskTlGvomUdA9sEzEoPEFP1cEJkznx+61mOztWpxUAexdbF4RvgriWKYrDouz5WgbrGdb7JDzpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kgiv7uJQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3CqjqX006057;
	Tue, 3 Dec 2024 15:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EBeg1vG5lRLRHAXtCgvc7vaKkuAzgvRHDGs4CzG1w
	IQ=; b=Kgiv7uJQUAYKj3wSbowUMbFpmN1o67PQNcjGZfLEerNl7VttPiarqBFJh
	5berVvKUG8Is0aBPKtzwbDhoGGTGJZEzpLGluGuJzaxvkNJmR5YH5g8zLS4nm3ND
	+bzMfJQ4jz0dv3EYtlDJDE8F7kRtM24H9i+nWOdSwYQJQubFuu9gUjH3sXG868Km
	FwCpPmcnLr3TuVktToo4FBXVmHXlKw9OhI81/jw0QB/IQ+DioW/cTig+N+s+ZP9Z
	Iz2j6Wkvw0xQsIayRzYN6XCkRjh2vMOeY4KKYd1PFv7RkacP+A4jqwRUoUByqZKP
	R5yH8I1jyqNnTS6CmnpLGT6P7xYXg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437te9377n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 15:07:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3CuJbx017943;
	Tue, 3 Dec 2024 15:07:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1s9dy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 15:07:12 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B3F7Bpr30999152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 15:07:11 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4BA65805D;
	Tue,  3 Dec 2024 15:07:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FB1858055;
	Tue,  3 Dec 2024 15:07:11 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 15:07:11 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        pabeni@redhat.com, AVKrasnov@sberdevices.ru, mst@redhat.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net v8 0/3] vsock/test: fix wrong setsockopt() parameters
Date: Tue,  3 Dec 2024 09:06:53 -0600
Message-Id: <20241203150656.287028-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YwUmdkGzaDqznwyC0CZJ4YEwt5aVopW4
X-Proofpoint-ORIG-GUID: YwUmdkGzaDqznwyC0CZJ4YEwt5aVopW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030127

Parameters were created using wrong C types, which caused them to be of
wrong size on some architectures, causing problems.

The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
didn't show it. After the fix, all tests pass on s390.
Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
a similar problem, which turned out to be true, hence, the second patch.

Changes for v8:
- Fix whitespace warnings from "checkpatch.pl --strict"
- Add maintainers to Cc:
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
 tools/testing/vsock/util.c                | 142 ++++++++++++++++++++++
 tools/testing/vsock/util.h                |   7 ++
 tools/testing/vsock/vsock_perf.c          |  20 ++-
 tools/testing/vsock/vsock_test.c          |  75 ++++++------
 tools/testing/vsock/vsock_test_zerocopy.c |   2 +-
 tools/testing/vsock/vsock_uring_test.c    |   2 +-
 9 files changed, 204 insertions(+), 64 deletions(-)

-- 
2.34.1


