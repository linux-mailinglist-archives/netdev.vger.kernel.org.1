Return-Path: <netdev+bounces-139952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB84F9B4C8E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A421282898
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE73191F6C;
	Tue, 29 Oct 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CYbIgjsG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5510F9;
	Tue, 29 Oct 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213407; cv=none; b=UqFFS3VYYMrhhtmKQg+6UQIDC2kmbP89ExdynSFYqqsMq0ShASwRLj2hNvzeafVTncqxOXomgp5btSAROegCJ1bA/JFre/xq4/yQHXUJxhUddF2wecw+VdGqdU9EIHi5ut/xY8frB9NkdL/6cSj4cB3jjARLxzq9d6Kh3wA7PiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213407; c=relaxed/simple;
	bh=2k4cNoC0Yt3oGGSTj+0MFs58TqVQZupKEkfrWb3TrZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bux/BOijjHycNJwY1CQrc+6Aloh/1kly7CP4IZLkgyPe88uFp5sx8igLhIe5qHYtybUeC5kh52dEHMEBOy9tS0qxklfoqDAFBS+uC+UTsZ1Ej2I1SjFL/WUrfAZ04w5Sy0YYixjrSXCkAPWY4TlO9nQ9R7VxaU/aSMbj60wtZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CYbIgjsG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCEx5O020847;
	Tue, 29 Oct 2024 14:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LGK46D4yZoUGlWOLYSoeV90M1yByksROdFffs258M
	Q8=; b=CYbIgjsGMomX3h5pErjzD1cu92vxjukQ0Q76HJa3OZyd4D2JW8IScZ5uh
	zPaXlI+T8TUisTZTVI1XsT9AsEGTA0r1h6nC1rXwBZ5wERCSTPe9JJidUYO/uFKE
	zCtk7b5aHP5dP2DcASFPmNQXIRzau4wAks2XPgtw9jhKOjktiaGiooFNvjRZj3wH
	Z3yYX+WawyzoAjbU74I38Q84JYLqXIYQg2DGu1Z7jy4xmLzn7ogHIC8ACS91IPB4
	7n34afT/oSF4PMvBNWNgYknjUoxOekBLAffTPlr/HqDn0hcJqOBbdLegh9QdY6Z7
	B3ydS4gTGmVJU9KHBh6NOxS8I73UQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jyhbgpns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:49:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TDSIpo028193;
	Tue, 29 Oct 2024 14:49:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hb4xuk92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:49:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49TEnv5544499328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:49:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84F4258062;
	Tue, 29 Oct 2024 14:49:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EA4658058;
	Tue, 29 Oct 2024 14:49:57 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Oct 2024 14:49:57 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 0/2] vsock/test: fix wrong setsockopt() parameters
Date: Tue, 29 Oct 2024 09:49:52 -0500
Message-Id: <20241029144954.285279-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VzJyLPUuHR2m0CDfgw2UWRbZ0X2H0lwo
X-Proofpoint-ORIG-GUID: VzJyLPUuHR2m0CDfgw2UWRbZ0X2H0lwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=751 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290110

Parameters were created using wrong C types, which caused them to be of
wrong size on some architectures, causing problems.

The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
didn't show it. After the fix, all tests pass on s390.
Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
a similar problem, which turned out to be true, hence, the second patch.

Changes for v4:
- add "Reviewed-by:" to the first patch, and add a second patch fixing
SO_VM_SOCKETS_* calls, which depends on the first one (hence, it's now
a patch series.)
Changes for v3:
- fix the same problem in vsock_perf and update commit message
Changes for v2:
- add "Fixes:" lines to the commit message

Konstantin Shkolnyy (2):
  vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
  vsock/test: fix parameter types in SO_VM_SOCKETS_* calls

 tools/testing/vsock/vsock_perf.c |  8 ++++----
 tools/testing/vsock/vsock_test.c | 23 ++++++++++++++++-------
 2 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.34.1


