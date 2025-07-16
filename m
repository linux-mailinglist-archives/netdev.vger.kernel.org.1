Return-Path: <netdev+bounces-207585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D54BB07F36
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4501AA5AD2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98826529A;
	Wed, 16 Jul 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lYX+mONq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65444A11;
	Wed, 16 Jul 2025 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699708; cv=none; b=F8E/XCdvls68y6YoKk6kYX7d9EXfqUrSinThPbNf+vvRYicy1a481PqHeYOtzRZOLNNaUnd0yHaVvkqNZqhliJMWsbn97ceMxWIwKhDblfV7tdpIRiPKiRkOTwEP1e+M1C+v/jyr6+zIdF2qVXVCNjl5RCcew7k9pUv18cVFCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699708; c=relaxed/simple;
	bh=16cOYaLTWUv5flwdnb8fd0dKCXcCDUJJ8SZVwCa217Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=Cg685nJBTCMkVYndY2F+jxW4D+3SA8okXA/tICHaSEzlokIc7L7oQ8Keb7zq7m73SjYnYi9pB2ZSL95Pfm2ncxHk0Dm8zGHVKN3+nhNhAylV0F3e1rcSDPu0bMGzANNZqU05C6LpjFpITb8/dSL06EZzGn6YUKBn9Ot9BQbevpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lYX+mONq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GIJsFe019585;
	Wed, 16 Jul 2025 21:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Mut158230U+m2kTnExwafiIfEzNI
	IV6rfk9jG8LI7Y4=; b=lYX+mONquo1SKht3fkEFIOkrVwBKod72muqcpLlS6qYh
	6RcFFEu1zlJx+k0aP1znyINpHm5L+WtsFPps7q/TAXqVIZ62/tMPwvxIJ5eM7qxQ
	t0k1GLYVJ4bKBe+7tyToFnccrUqAS1ALaELrGNyWelw5crvIDkhHbLXiLYHRrGkb
	RXb/8Py0rbE7V/n70VEWWos/qssLuUevpi/0gjOkN4sss8GkuxDcvRgctGB3LWYw
	Z9v9b2KprzQzS/kBP23951f3zmg7i55NflJyQKd/dHiLwsqL0iwefzZUjZG9aUcD
	+xOLrwnlpRCI8vucgrvRsuXqcxDrhk/4mFysM8RPAg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47xh900p6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 21:01:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56GKsp3v003981;
	Wed, 16 Jul 2025 21:01:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47xh900p6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 21:01:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHc5uj031902;
	Wed, 16 Jul 2025 21:01:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21u9g90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 21:01:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GL1agp30474976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 21:01:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E74A58065;
	Wed, 16 Jul 2025 21:01:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 095B05805D;
	Wed, 16 Jul 2025 21:01:35 +0000 (GMT)
Received: from [9.61.118.124] (unknown [9.61.118.124])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 21:01:34 +0000 (GMT)
Message-ID: <780b1ce5-dc05-4fd7-8a1c-15b283de0e69@linux.ibm.com>
Date: Wed, 16 Jul 2025 16:01:28 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: sam@mendozajonas.com, peter@pjd.dev, delphine_cc_chiu@wiwynn.com,
        Paul Fertser <fercerpav@gmail.com>, davem@davemloft.net,
        Jakub Kicinski <kuba@kernel.org>, Potin Lai <potin.lai.pt@gmail.com>,
        pabeni@redhat.com
From: Eddie James <eajames@linux.ibm.com>
Subject: NCSI incorrect response type to command
Cc: netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        eajames@linux.ibm.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pbhKnUizILKPIExUUOJsqXmhcSatQyZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE4NyBTYWx0ZWRfXyQlPN1yS/4+4 qAUsAxUQDQDxr0wvJUQBGfgGq32r6mI6/Y+5/WSST5YDB/xZDYRtL/WnjyvrFvVKqZoL99hSmU8 zmPO518gtLcKB+LevwYrWZeO5D1RAcUt9yPBJqbavlnZZEUx8ArcvbcVnWi0iE/2jQaOgw34Tp6
 SokQUB6ehQv5RN5xQtqzY7X93ArUk5X+8O0bC8XnLUwZtdmCTeV/YfWgCukGxztb0C7Hjt2mIAo Ie/kU7U1UaVq1JQrkRgr1+ZzI/OOAENeoqYftY4aRn+wodNtwMA5iPb05hS/djDaxtnPNiNVhvH KXH75oQwPDfWT38IX930WPvNF06GuOAliHRKyz7YvnxhBN+Qhd57c5+eOlmxQ9bTmMHEMHFxk7V
 9Aw7Wdnb6DbfNvH8LBCGHormNWJe/sjjsP2IPSd3ZzZAa2o1kRc1bSFUDwCr2CimwGzNoyME
X-Proofpoint-GUID: CEU1fuxyGsu19UydhB8TUvR-p1uudJOr
X-Authority-Analysis: v=2.4 cv=C43pyRP+ c=1 sm=1 tr=0 ts=68781332 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=SdooGX4x0a49zq6R3TUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_04,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160187

Hello all,

I am trying to debug an NCSI issue where the driver ends up with

 > eth0: NCSI: No channel found to configure!

during boot and I cannot ping the system. This is AST2600 BMC using 
ftgmac100 in NCSI mode to an Intel I210. By adding some debug prints I 
found that this happens because the response to the CIS command on 
channel 0 never returns or returns the wrong response type. As seen 
below, after CIS (packet type 0x0) is sent, a GLS (get link state, 0x8a) 
response is seen. Unfortunately I did not print the sequence number. The 
BMC gets a few correct responses (though NCSI state machine cannot 
handle them since CIS didn't respond) and then no more responses to any 
commands, so no channel is found. Has anyone seen similar or have any 
suggestions for further debug?

Thanks,

Eddie


[   21.186332] systemd[1]: Started Network Configuration.
[   21.201977] 8021q: adding VLAN 0 to HW filter on device eth0
[   21.209910] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x200 pkg:0
[   21.219708] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x2
[   21.229468] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x2
[   21.230140] ftgmac100 1e670000.ethernet eth0: NCSI: Handler for 
packet type 0x82 returned -19
[   21.237713] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x2
[   21.255476] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x2
[   21.263680] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x2
[   21.271935] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x2
[   21.280170] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x2
[   21.288441] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x2
[   21.345826] systemd[1]: Starting Wait for Network to be Configured...
[   22.314495] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x202 pkg:0
[   22.323088] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x1
[   22.331929] ftgmac100 1e670000.ethernet eth0: NCSI: Handler for 
packet type 0x81 success
[   22.341190] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x203 pkg:0
[   22.363321] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x206 pkg:0
[   22.372049] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x0
[   22.380844] ftgmac100 1e670000.ethernet eth0: NCSI: Handler for 
packet type 0x8a returned -19
[   22.394122] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x208 pkg:0
[   22.402856] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x15
[   22.412073] ftgmac100 1e670000.ethernet eth0: NCSI: Handler for 
packet type 0x95 returned -19
[   22.422259] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x209 pkg:0
[   22.430986] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x16
[   22.440141] ftgmac100 1e670000.ethernet eth0: NCSI: Handler for 
packet type 0x96 returned -19
[   22.449987] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x20a pkg:0
[   22.458684] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0xa
[   22.468979] ftgmac100 1e670000.ethernet eth0: NCSI: Handler for 
packet type 0x8a returned -19
[   22.480251] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x206 pkg:0
[   22.490479] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x0
[   23.514450] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x208 pkg:0
[   23.523040] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x15
[   23.988455] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x50
[   23.997826] ftgmac100 1e670000.ethernet eth0: NCSI: Handler for 
packet type 0xd0 success
[   24.554418] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x209 pkg:0
[   24.564436] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x16
[   25.594426] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x20a pkg:0
[   25.603126] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0xa
[   26.634449] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x206 pkg:0
[   26.643134] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x0
[   27.674640] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x208 pkg:0
[   27.683312] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x15
[   28.714443] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x209 pkg:0
[   28.724744] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0x16
[   29.754439] ftgmac100 1e670000.ethernet eth0: NCSI: Probe channel 
state:0x20a pkg:0
[   29.763047] ftgmac100 1e670000.ethernet eth0: NCSI: Command for 
packet type 0xa



