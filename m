Return-Path: <netdev+bounces-299483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dfq8MKALMGrFMQUAu9opvQ
	(envelope-from <netdev+bounces-299483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:26:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80068687232
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:26:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=GN4eQdbK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299483-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299483-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E051302BEF1
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DFB3F7A9A;
	Mon, 15 Jun 2026 14:24:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC303EF0CD;
	Mon, 15 Jun 2026 14:24:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533460; cv=none; b=twwrODX8v5J9guhqAHuxFZfI+1L/J9Nj9oe4nvUZdvyU8QnC014hQrRbi7LVtGocrfyHGVWdbiZ9YRn2hOmeVH75NO9E0owM7TF/0UxJYidd8kB6BEJ7gG1F1DjmFVnyFAnJko80zrkGy4nEkjiL0IkE87xeNqtTkhdaiddXeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533460; c=relaxed/simple;
	bh=kiIsMDo+qCR+gsHM8Iu+H9cpLnLwOVAQRINXxJNClUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr1rpyoatFwkAoamUApySHKN38voLD93ggjjX03mxYjZBYcNPlVLfbBT7jFlcqx5NngqdjG8vhMouXPbX6shz0d/H7E260eh4/kehH1Peyi71+UspLtS9vjaW873ltNXdRf7QZgJqUPefE3VSzzYyeQ862LVkEsXMQSYcrKi7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GN4eQdbK; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCmR1c2516332;
	Mon, 15 Jun 2026 14:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kiIsMDo+qCR+gsHM8
	Iu+H9cpLnLwOVAQRINXxJNClUY=; b=GN4eQdbKdswwSls6TmhN7tpRUObzW/956
	FamR+im5/GrFejoOBThGVMmsMUCTKKCpk12PteeH6Sj+r5kdpRIr2UeYoI5LZz07
	4lwZj0Uk1GkmtZu1VrOvbOCs8R9KfKuvRxEX6tC2HAsMjqLaTMnA3j1FP8OblpGi
	L1JWXiPgTS51lP+jx/4oujUNzbrvC7nSiB2W22a9V9CXFf1w98Hgfvq5/oj90lWv
	dUYlx5AXCCl8/aKSBPVnPXfJd6LMwgVbvXiz67SCX04uAd90NYQfG8UHSagshnI/
	o1UFrrFeresp91jJVazVGMhX0SBUMrVIBikkZwHjPOYF7O2Rogfsg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg0kae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 14:24:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FEJgaq014403;
	Mon, 15 Jun 2026 14:24:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1gxwnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 14:24:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FEOCmO26280516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 14:24:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACBFB58067;
	Mon, 15 Jun 2026 14:24:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A88A55804B;
	Mon, 15 Jun 2026 14:24:10 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 14:24:10 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: mst@redhat.com
Cc: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sgarzare@redhat.com, shuangyu@yunyoo.cc, stefanha@redhat.com,
        virtualization@lists.linux.dev,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: vhost: fix vhost_get_avail_idx for a non empty ring
Date: Mon, 15 Jun 2026 16:24:08 +0200
Message-ID: <20260615142408.64169-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfX4kOKOUsdn62Q
 /00GYZASuleTVtIXkuDbgwDV+7nlTSxdLhmfjXnEDOwZphkeDsc5yNcqeYOjo0AQY4CUKdPRaNk
 v59IksHTAY5najYc84fr6Zys+ciMo94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfXxGYz/ntpzeEW
 VQ0IpQMPtCIG0fa+inikduA5QDgfsJQ5qhKQ4Kmik6MQWgbSBWWV5hoY+zPWdOwYeWfO7xg6yYh
 rkASTGzuEePJ1NF48p+ZRcx9GBXw0tVPFwHnirO8CfmTlo4JRwzbB8Wu7PNQdp42r8YdPtIud0j
 MVt29Aty2bQDOFZ7PgmyzrJVd6zankDgEtEImfRryU1Y96gCs2HODtDhdqkX8DK+AyPS+jJ/8ko
 VUMgUTD7d9ng/rUY0HXLoV0/ofAtMuKpoasRTW5Tm+j8OrL7cKz+Q16k7HFKQEe4aYu2uIfwJhT
 TnS5RNi6WL9G68VKw/jgs68qV4ETCurGbaUXMg9bBUZ/wGSAemiQ/A9oZz2kJ230FKyj5SULK14
 3Zl7YYWOezdl13PO0b1+aZXaOQCg1WFTXCVbPX+X49a3quUsqi+1yJS1jcfxN/g+0B4LTns9XdR
 2+4FI9fsa5Z9Wov215A==
X-Proofpoint-GUID: JCecQl8GbpHgCG0Czo7MCieaqFs7ZQJ_
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a300b0d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=q_tXsGYBvXEQEe6gApwA:9
X-Proofpoint-ORIG-GUID: JCecQl8GbpHgCG0Czo7MCieaqFs7ZQJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150150
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299483-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:eperezma@redhat.com,m:jasowang@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:shuangyu@yunyoo.cc,m:stefanha@redhat.com,m:virtualization@lists.linux.dev,m:borntraeger@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[borntraeger@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[borntraeger@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80068687232

Late feedback, but this patch massively improves our uperf latency/bandwidth
and cpu consumption significantly for s390. Improvements are all over
the place, streaming, transactional (100 byte/2000 byte). Nice fix.


Christian

