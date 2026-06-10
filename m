Return-Path: <netdev+bounces-297430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cqaMKsroKGoGNQMAu9opvQ
	(envelope-from <netdev+bounces-297430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:32:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38875665C13
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:32:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=cetLptX2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297430-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297430-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CB7830342AD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7CB370AD9;
	Wed, 10 Jun 2026 04:32:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFA298CAF;
	Wed, 10 Jun 2026 04:32:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065928; cv=none; b=m7QFipDfY2MUuntvDMpaRrJ4+/KpEwqCGUb2TmWCb/ktlvOqWYeOMEd94GmFNFoDVpIWD+hhfS5NWU/hL5YOBUVeFAFyj9eczFKCfm4KAqv3zdwvjXq6IluRgICIL1MyaxvR74J/ChWR6HkXivztTXPP9nmNiVRFqDeAJCurIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065928; c=relaxed/simple;
	bh=Np3ryJQDZQoPrw99URy9VdyaWs8jtMq9QO0SJ8K5bGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0dwcEXVeOGy+A9e3C/uDhASp3imHCKhdS7VmZnwXusgDqF+m5Fi9KF4KRH83F0IzrQIc4Hk6Zyigr3Q4J2x9QWKHdrtp6JfiWPrxN4XwSlBcbHuIBKQBPrGuLqi2GOWWd00bpylP2kyBQgRSIpVYmsaJZtA3YQbc4JA4GEP/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cetLptX2; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1vG7C2132475;
	Tue, 9 Jun 2026 21:31:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=7kJ1PP2W4Zycj6ZOsIpZZktrX
	6iXjwbao/jX121eaM4=; b=cetLptX2cQ4GGr3w1sX8Wa6LtNLyKmZaYj2w9x5uU
	xtqF3waUmZs/cZfuvoQSSLP3Cft1OKiQs678Bmhp9uUYc9QpQG2og8S74bDw+ILP
	DT30ejMXwo8w2rrzqrDN948eN/MHJ5T1mM15iXI5pc7COcvKHpjkP92WdAVe1lxt
	A6xjbVoHdtzRM1YF0Li0vaMMhfy17e2XCRbnhco+MiSpUscPsARQGofLFSCKU3Sn
	JhN3o6sNmGwvwlgGzHhW/vLXW78XHLXQmtYH1o2jE107qhXaNTYR7f/+9ndp/O0W
	mAIxUoZanjcw34kNodu5urN3DhCOH+0LqEIsRRWdjpgNg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eps391pgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 21:31:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 21:31:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 21:31:57 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7BC9A3F708D;
	Tue,  9 Jun 2026 21:31:53 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:01:52 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 6/9] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <aijouNVBvUYTUZRA@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-7-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=KKlqylFo c=1 sm=1 tr=0 ts=6a28e8bd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=5IvDXcuzzZJvPDbM8RkA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: E7asuJz3iNOQl-Vzi-obkWS8e9rcwBNk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAzOSBTYWx0ZWRfX4dlQ4aA+RJwa
 gjCB637XMiXkRrDVhhBhv9Rlle7sBHNyEbVd5lhqeDnTgRNvJCj4dUn5cd8cerNz1IjJS3OceIc
 iwf5coSY+H9rR4Ug2J8kFWfLi4Q9+SmV331kQjkczpYk5aoJwBkdxFJHmFeGExZrwTXp5kCXtuU
 EdAd0FbPvSFErS77VGWb99qLcacbCA1olcfiZTZ00TEF8AgmMEoU3Flk+DR3UT1bvXBiAmL00N5
 lFrImrcrpa/sYGfGuOdnriPcsMyeBf7mTe48lhT+1abhyvCit7zvWILl9nV451YsscvIBaLmBrT
 VbKeWNyGtm6FW/47zkNXK3Uh4KpQ2jjH1eIHjWDkigLmd/QFlYkA52RCwZFP00W+nUOHTHB1m/e
 dPDzY6iG6MtDWMqr+6mqmWsjKMK+UeeGNxKVDPejHtRS1X/90DFePJ5CkAwmYTARLOGT0dg11tW
 9ijnk45ySkk9pwyjtlw==
X-Proofpoint-GUID: E7asuJz3iNOQl-Vzi-obkWS8e9rcwBNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297430-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:from_mime,rkannoth-OptiPlex-7090:mid];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38875665C13

On 2026-06-09 at 09:34:50, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add NIX_LF_DONT_FREE_DFT_IDXS so the PF can send NIX LF free during hw
> reinit or teardown without the AF freeing CN20K default NPC rule indexes
> while the driver still owns that state (otx2_init_hw_resources and
> otx2_free_hw_resources).
>
> On CN20K, allocate default NPC rules from NIX LF alloc before
> nix_interface_init, roll back with npc_cn20k_dft_rules_free on failure,
> and free from NIX LF free when the new flag is not set. Tighten
> rvu_mbox_handler_nix_lf_alloc error handling: use a single rc, propagate
> qmem_alloc and other errors, and set -ENOMEM only when kcalloc fails
> (remove the blanket -ENOMEM at the free_mem path).
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says:
>
>> -	if (err)
>> +	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
>> +	if (rc)
>>  		goto free_mem;
>>
>>  	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
>> -	if (!pfvf->rq_bmap)
>> +	if (!pfvf->rq_bmap) {
>> +		rc = -ENOMEM;
>>  		goto free_mem;
>> +	}
>This is a pre-existing issue, but does this code allow a memory leak if a VF
>sends consecutive allocation requests?
>Looking at rvu_mbox_handler_nix_lf_alloc(), the AF driver handles the NIX LF
>allocation by allocating DMA memory via qmem_alloc() and heap memory via
>kcalloc(). It appears to directly overwrite the context pointers (such as
>pfvf->rq_ctx and pfvf->rq_bmap) without checking if they are already
>allocated.
>If a misbehaving VF sends this allocation message multiple times sequentially
>without an intervening NIX_LF_FREE message, could the previously allocated
>memory be silently overwritten and leaked?
>It looks like a similar pattern might also exist for NPA LF allocations in
>rvu_mbox_handler_npa_lf_alloc() where pfvf->aura_ctx and pfvf->pool_ctx are
>allocated in a similar manner.

This is a pre-existing issue, will post a patch to "net" tree post merge of this series.

