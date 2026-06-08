Return-Path: <netdev+bounces-296461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YdsyERyXJmoPZQIAu9opvQ
	(envelope-from <netdev+bounces-296461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:19:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4461654F9A
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:19:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=UV5EEmLM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296461-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296461-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6F123044592
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C13C3C9EFB;
	Mon,  8 Jun 2026 10:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E622385D61;
	Mon,  8 Jun 2026 10:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912810; cv=none; b=WyMwBlu6X7EtOGZgzEH6hmAKRdPG0lkB/DTrDV1rp/OD4g/8XzXmJgie254ZixX/fSFf08qS5+Zv16j7QxAd0UEkNjREH8l0ULR7ko3SVgb4XUH0RERiueB+i89GjODNtNi2gl4FmydEWGJOiPjUtwQ3N1+lcQDvRQJhx8RDyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912810; c=relaxed/simple;
	bh=+8XfG6k1tXnXQyksouw2wdiv9qe1TAlzvlG7+q25o10=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kGbr/an7D5H0eQdMeDanKQcspJKblp0fbPk2BNjcNUhe23lhnb5bKGkWBPrsA/ye2AMDvQnnwWAiZqn9x+N5g1Y3XCvgBoQ9ZrOEi8O3Dy46sBv2MvFOTtYJcyLLpxV+/S+dhr2FkaAjRsdhzi6J23gqiSUUHhdDjzlcbjSpt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UV5EEmLM; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6589JnGc2817660;
	Mon, 8 Jun 2026 10:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=65j6K3TwLBQrNRKhondLRsIzcSz2
	RghwB/4ES/qifHs=; b=UV5EEmLMDZHqmVT5rQDQxkhbNcFX77CbFN73v9mxnO/1
	DtzDJlfofNoiZyIIwbLymoAy7mhzJQPutxptqfjwUCPH2XOsfnDDv7AOR6+htIad
	Pnm9DPspSzefLg1+K7Jwnz07Shb+h3ddVc4bd/eMQbypjn0frh7vhc0jq4LknXAb
	hKjPXDvLy7NBkG2eoTQHzASRSJ///hCJscoxFgns0XVIXZeG5zL9GvyFXzswKwj8
	9m1wFt/ipiJoz5aacMY406rMi5vGREE4RQGrWlwx2vhnXcVPms2/hpRf3gg7oynH
	a+sIOh1D9fAAn5pSaDEnlCuMjUA6h5c2zeT8SRAbxA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23pq1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 10:00:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589ndU1010122;
	Mon, 8 Jun 2026 10:00:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vvv9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 10:00:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658A02eu61473074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 10:00:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C31F258068;
	Mon,  8 Jun 2026 10:00:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D455806D;
	Mon,  8 Jun 2026 10:00:01 +0000 (GMT)
Received: from [9.123.9.7] (unknown [9.123.9.7])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 10:00:01 +0000 (GMT)
Message-ID: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
Date: Mon, 8 Jun 2026 15:30:00 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org, venkat88@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Yeswanth Krishna <yeswanth@linux.ibm.com>
Subject: [BUG] kernel BUG in team driver: buffer overflow in team_add_slave()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a2692a4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=qBxafnndnmzGIJbaEr4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EeGipkoIuz3k5KIeLN3h9n4452L9zIqE
X-Proofpoint-GUID: EeGipkoIuz3k5KIeLN3h9n4452L9zIqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4OSBTYWx0ZWRfX0ddjqY7emiR9
 DZZvPaoV2dNPCtRetacd+xFFzYlp9m9rnMcyx/VN1m3NCQl/1Zrd7KL1g6uSwpJ21F6ZtP/8KDS
 +qOwCC8mCzF6eFgD0FQiuLDqvGu9z9pPZsp21H2MeYORSRjsbHHZFQnpEBBeht39wuDiIbM0vfM
 RrbHxa6mMn8KzpYem4GLTq/+DCWlzrpT72sea+XbZXdB9Z0lZRti16FF0GaxfIRsBd8333qsgFr
 qhS/i8TEaNFfGAUcSkOfgaW5ILdBWS9GjkRrdo+Uc3uoeYqRFFHMjHK86GCRAuz9BwDwOrJoaDF
 RDQfq3WEhAJp00LNaAWc6CcE3VLwQG8+qfnTtmvet/ainqvzSnmxgi+kbmBsMYVBZSJAK6KRYEt
 lvBx/t30de8nQ/oI/4Goi6SJYo9NgP8FOUQ0UaQ4MKNq+IpYbsDPM1chgpeI1UQAlYBoPKyWSfd
 VJ/2v2sxlcGsONNJKvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:venkat88@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296461-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yeswanth@linux.ibm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:from_mime,linux.ibm.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeswanth@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4461654F9A

Hi Team ,

I encountered a kernel crash while running selftests on kernel 7.1.0-rc6
on a POWER10 system. The crash occurs when adding a slave device to a
team interface, triggered by FORTIFY_SOURCE detecting a buffer overflow.

**System Information:**
- Kernel: 7.1.0-rc6-160099.42-default+ (commit d548c6f4301b)
- Architecture: powerpc64le (ppc64le)
- Hardware: IBM POWER10 (9043-MRX), pSeries
- Config: CONFIG_FORTIFY_SOURCE=y

**Crash Location:**

[ 3492.897824][T77143] kernel BUG at lib/string_helpers.c:1044!
[ 3492.898057][T77143] NIP [c000000000ac1120] __fortify_panic+0x18/0x28
[ 3492.898096][T77143] [c00000000efdb350] [c00800000b857a18] 
team_add_slave+0xc60/0xcc0 [team]


**Call Trace:**

__fortify_panic+0x18/0x28
team_add_slave+0xc60/0xcc0 [team]
do_set_master+0x19c/0x240
do_setlink.isra.0+0x388/0x1450
rtnl_newlink+0xac8/0x1030
rtnetlink_rcv_msg+0x450/0x530
netlink_rcv_skb+0x74/0x1b0
rtnetlink_rcv+0x24/0x40
netlink_unicast+0x2e0/0x430
netlink_sendmsg+0x210/0x580
____sys_sendmsg+0x30c/0x470
___sys_sendmsg+0x94/0xf0
__sys_sendmsg+0x84/0x100
system_call_exception+0x154/0x2b0

**Reproducer:**
The crash is 100% reproducible via selftests:
```bash
cd tools/testing/selftests
make -C drivers/net/team run_tests

Please add below reported-by tag:
yeswanth <yeswanth@linux.ibm.com>


Thanks,
Yeswanth Krishna


