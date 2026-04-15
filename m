Return-Path: <netdev+bounces-278643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id igxJDskQ32mBOQAAu9opvQ
	(envelope-from <netdev+bounces-278643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:15:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1040031D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F7C300D30B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 04:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F003264C4;
	Wed, 15 Apr 2026 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KqKudZ3I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1140DFCB;
	Wed, 15 Apr 2026 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776226469; cv=none; b=SIiYBS2wF5cnG90ABSpwzW44iEB9NA3HQ0E7vis6bQl7/IyjSFa0l6KOXUvRXfIouTVowVqJd8hiIqrW6+0jJU+hWTURoDJc3WBBYYIRKAKl1QI3WRJ2RO2Xq2SVm0NE9sabkD95MnIHuHzb9ttMAH35cWO5jKKX+nOrp/JQOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776226469; c=relaxed/simple;
	bh=t61rgIDLlTy5J7V6+PacS/C1vg1XRLE74hWnDzh1O8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ith047HAfzpx35BPKjdeQnqIiObylXS0y9gLTaJVzynTipJ8fiHdAfn7+LZEe6vk60AWPG38oz6wrSAEFE1oLVQny2D1XH2cv9fvGT4QcCaWbtEGc7V4Tn/3XJS3hN5UNcc9CIiX7G1pNr47klETTr9LnNpZEvwcTTAJIW/g7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KqKudZ3I; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ELkjh44043025;
	Wed, 15 Apr 2026 04:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=z+uGjOz/K2bKKzJrpvV77wqUuie0Yh0+TDwv1BGHozA=; b=KqKu
	dZ3IsoBF8pN5HyuX2X7DxQe1onhjyL/eKudfSAFXXw6YAoglnbcq5atTQTXlH5rM
	322EFT2yhlh3P435txZ/Wz5LbZX7owhJeX3OHrdu60DOT0VG6D7OyylZYgrAuJh5
	YZHIlKsH8shm9U7WieGIMIYr3kolmIBnI04J2wdeTQx6bflVY/wMYCI1mIZCiccS
	LGUdGEjSWY/efbXLUHQ+dnqDAbL2/A8oV9pTKlDws9PASfccaxEQjVeX3SPfiJzx
	o2QOMshRoY9PFEXo3E6TDmk3YLKac+ejkild5jBwEsqZnk4lVdFHkUJlFx2bHbju
	xGG+Lj+7goaxvIqbIA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4dh85vectn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 04:12:02 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 15 Apr 2026 04:11:53 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <alexei.starovoitov@gmail.com>
CC: <ameryhung@gmail.com>, <andrii@kernel.org>, <ast@kernel.org>,
        <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <clm@meta.com>,
        <daniel@iogearbox.net>, <eddyz87@gmail.com>, <ihor.solodrai@linux.dev>,
        <kernel-team@meta.com>, <linux-open-source@crowdstrike.com>,
        <martin.lau@kernel.org>, <memxor@gmail.com>, <netdev@vger.kernel.org>,
        <slava.imameev@crowdstrike.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in local storage
Date: Wed, 15 Apr 2026 14:11:50 +1000
Message-ID: <20260415041150.60473-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <ydbdk5fj3mbjoninyt5lcg5czcrcgghk6ownothijy667zn6h3@eczgskgj43iw>
References: <ydbdk5fj3mbjoninyt5lcg5czcrcgghk6ownothijy667zn6h3@eczgskgj43iw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH013.crowdstrike.sys (10.100.11.83) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=LMZWhpW9 c=1 sm=1 tr=0 ts=69df1012 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=o72gW7uVigxhCowoDf4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAzNSBTYWx0ZWRfXx+eDEf62lDdj
 RUKkD9RctDetIm2wPRB+TDc4Eu9lhvyMtRkoCtywDTVAcFHre5PXv/ngAy07VRVjwTL1YoQeSG2
 yepEE3cPynKNGjHIAZuJRmQw/McSQ3GKgnjZR/FZtPH1BKpz5FyHh+zNtHS6xTOnSLoTFcFKSrZ
 sCgLZo4jldP8T6cNL3E6l9o6HvZ/AmBFw7zKguDp+l51TXpPnbi94xNp4m91qSPpVEHG2xrPRNk
 l20q7NuWcK0xRTQRfPHRO2tUdgNAzF1PG/mxTTaJkHPjT2NMSocYL45hmAsmxHkrAE/kSszi9jQ
 7ESVc76UER/jAhTrpVZ2S9xSM5cQGaqw3V/KteOF5CONIAU+nZ+xLrcsmoWThdRLpMv3ZomAUMv
 KfL5T9M6RZnDfwx3eiH3IxpiYmkzHV6EiveFPabsORjt2RtKpyymWVLNVm+WCvlkw9O29SbePdy
 k6UPbUjMC8OZafB0SPw==
X-Proofpoint-GUID: wXJeCFlbJ8nw-sOHS2drrxIdozr37DIQ
X-Proofpoint-ORIG-GUID: wXJeCFlbJ8nw-sOHS2drrxIdozr37DIQ
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11759
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150035
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278643-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,meta.com,iogearbox.net,linux.dev,crowdstrike.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[17];
	REDIRECTOR_URL(0.00)[urldefense.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,urldefense.com:url]
X-Rspamd-Queue-Id: 77B1040031D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 19:27:00 -0700 Alexei Starovoitov wrote:
> On Mon, Apr 13, 2026 at 01:48:29PM +1000, Slava Imameev wrote:
> > On Fri, 10 Apr 2026 21:39:00 -0700 Alexei Starovoitov wrote:
> > > >
> > > >
> > > > This allows value sizes up to ~65KB. Before this patch, socket and
> > > > inode storage used bpf_map_kzalloc() (backed by regular kmalloc)
> > > > which could handle those large sizes. After this patch, any
> > > > elem_size above KMALLOC_MAX_CACHE_SIZE will silently fail: the map
> > > > creation succeeds via bpf_local_storage_map_alloc_check() but every
> > > > element allocation returns NULL.
> > > >
> > > > Should BPF_LOCAL_STORAGE_MAX_VALUE_SIZE be updated to use
> > > > KMALLOC_MAX_CACHE_SIZE instead of KMALLOC_MAX_SIZE now that all
> > > > storage types go through kmalloc_nolock()?
> > > >
> > > > Slava Imameev raised the same concern for task storage in
> > > > https://urldefense.com/v3/__https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!ytFHcGR6fq4YVQZ74Z_LwJ5IKsEaF2vnY03x8-IS51cQyN3SkHYa-6G_vUxk2lW7xvWMNEfSArwyIGXuxeEhe62whEC8AyDpmA$
> > >
> > > Right. Let's update it, but I don't think it's a regression.
> > > On a loaded system kmalloc_large() rarely succeeds for order 2+.
> > > That's why kmalloc_nolock() doesn't attempt to bridge that gap.
> > > One or two contiguous physical pages is the best one can expect.
> > > In early bpf days we picked KMALLOC_MAX_SIZE assuming that
> > > it's a realistic max for kmalloc().
> > > It turned out to be wishful thinking.
> > > kmalloc_large concept should really be removed.
> > > It deceives users into thinking that it's usable.
> >
> > In defense of supporting 8KB-64KB allocations for local
> > storage, we can consider BPF_MAP_TYPE_HASH with BPF_F_NO_PREALLOC
> > as providing similar functionality to replace the missing 8KB-64KB
> > local storage allocation support. However, these map entry
> > allocations can also fail with similar probability since they
> > depend on the same underlying allocator.
> 
> I really hope that 64kb task local storage is not your production code.
> Severs easily have 50k threads. Sometimes more.
> 64k * 50k = 3 Gbytes of memory wasted.
> You need to redesign it from ground up.

This was a research project to replace LRU maps with task
storage. We implemented a garbage collector using a BPF task
iterator to release inactive task allocations. While iterating
over tens of thousands of tasks might be questionable, this was a
proof of concept that, when combined with other measures, could
potentially keep memory pressure in the tens of MBs.

8KB would be sufficient for 99.9% of our allocations, but
sometimes we need 12KB or more. The alternative to task storage
could be BPF_MAP_TYPE_HASH with BPF_F_NO_PREALLOC and a garbage
collector, as we want to reduce dependency on preallocated LRU
maps.

