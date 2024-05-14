Return-Path: <netdev+bounces-96431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF58C5C37
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA9282763
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFED181324;
	Tue, 14 May 2024 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qwmGicfG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4715180A97
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718140; cv=none; b=AAEKVnt5l8vhofugAKb0sao/B5c9wr8rjxQsWO8b0PlHKziMdnqkakbN/C0o1EUIcJAh7thyuT4HZ0wxm5SEZ9KhnThzoHm7IB/9c2dcWzJTpjjDRes4sN7arG/2dIyZ9w5EtZwdtndIblRwM4BMmRTN2AQ0LAlrzYz03MqSNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718140; c=relaxed/simple;
	bh=biGBh/1rp5nHAReHPW8tU6OocHoznmRNUXffJZP2F3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dGIxduwm8TjrkuQzKVvhsDs0BWbkzisdniG3y86j+P+6zEf1r8sHN9ka/x/tU6TUqi4ghOde4pURhUHi3eAkqTsbaQ1fjTOw5V8VXkPPKuxpv9Uy9MK93dG1SzUceQsXBjXHMOQfj9I6aFg40MTdqR2fJdzyvWujQzqtIAZHpOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qwmGicfG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EJcptD029003;
	Tue, 14 May 2024 20:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0FqgahBiv+WORr4PJPQxt7siGRxXm49Po1/1+V0+izk=;
 b=qwmGicfG7FBSnm+0QhBw3V+6pulHDvKuQIm0Xq1nL7y4jyLCiSVhWYAafD6GU+I9skXk
 g+2HGgtZkXvXSOQ8uJPJgRp0expxY85J5UiSjKXAi8aLjyhlG/fefmjRuhn7bHojww/U
 /I+2lRM72WEWPwjjt6bDy54tPyBPfcR4Lhm+Pj3wX9Ad5wu6WWsgQBQesBP8Mhi3xfJV
 F6wu5CyMw3qXYBZE4M6EFmAdS2h8hfeeRh88PUu2VBxf0dUQsL7MR4C+wbeKag6k4aqb
 kAHcr0/EJDFoKXuBrqoz0IA4a/4rsZaBLr5Nfg1T6mnkpS4xt1kKgilpPsVupk4yGQS+ /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4e9u82t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:14 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EKMDo9028550;
	Tue, 14 May 2024 20:22:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4e9u82t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHevNf018765;
	Tue, 14 May 2024 20:22:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0tfp2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EKM9Mn56230258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 20:22:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 128E958052;
	Tue, 14 May 2024 20:22:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5A0558056;
	Tue, 14 May 2024 20:22:08 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.196])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 20:22:08 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
        horms@kernel.org
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        rob.thomas@ibm.com, Thinh Tran <thinhtr@linux.ibm.com>
Subject: [PATCH iwl-net V3,0/2] Fix repeated EEH reports in MSI domain
Date: Tue, 14 May 2024 15:21:39 -0500
Message-Id: <20240514202141.408-1-thinhtr@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RV9OVvwSCVNWloe5RjFtBkDx2vUKHFkd
X-Proofpoint-ORIG-GUID: IerCNVXHAkK8sAWOr5_hhSHhDKqUQ30d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=822 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140145

The patch fixes an issue where repeated EEH reports with a single error
on the bus of Intel X710 4-port 10G Base-T adapter in the MSI domain
causes the device to be permanently disabled.  It fully resets and
restarts the device when handling the PCI EEH error.

v3: moved text commit messages from the cover letter to appropriate
    patches.
v2: fixed typos and split into two commits

Thinh Tran (2):
  i40e: fractoring out i40e_suspend/i40e_resume
  i40e: Fully suspend and resume IO operations in EEH case

 drivers/net/ethernet/intel/i40e/i40e_main.c | 257 +++++++++++---------
 1 file changed, 140 insertions(+), 117 deletions(-)

-- 
2.25.1


