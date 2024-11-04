Return-Path: <netdev+bounces-141472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258909BB114
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F6F2836E3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AB1B0F1D;
	Mon,  4 Nov 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QdLo9AKC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24018BBB4;
	Mon,  4 Nov 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716130; cv=none; b=nUKpdAFnnjS3+elkgWZrEyeUoAmXwl8AxIN9fEHZLs9BQiIIaizp9Y0pc8F2vsMNv/ROFH7SmfS0BiAFbq1cV5BOdf4XsfdyXwnS73kS53ZmSRUv0qGfKPtOL2mDO4lZT0bYNYzPB3uoN2vIeelYiNlovOQ1N7HMxfgaNpjhqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716130; c=relaxed/simple;
	bh=5yCUb9iEmqAl5JeozlTqbQUOQU1E4HhX0nD32s37cyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFN8FwqE9F5dgk2LyBqLgxZHt9E9NCEFq6uB8ZpcbMB3CqMRoEAKdtXc7wMURTW5WTCeQ6bKfmMrfN9/ud7aG4u4UtgFLZoClBUTrQng9MYmLYuWybUZey9x6LqKxZpGT5iaBDGVd6H3f03vEYfDKMufHcXv2MqWtWh4vduB4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QdLo9AKC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4006aq012703;
	Mon, 4 Nov 2024 02:28:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Biy9dbFu5WQ7Ep/SXsojLCxxQ
	f75VUN+dr2jor6u15I=; b=QdLo9AKC3CGtw07o2K3cFVfoCyVYNNT2drJm3+2Tz
	xA8PJ0jPbs2LAosq5rrSqqcJEQvdFivly3vS2+JXGLFG8SnWT/N52iUAfTxRM/sb
	HVlhPgQqKmZaULVg+oO87rvA9Ec69AZhUqJsvflyr//3oMiTqbt5IvJXaqQdL4u3
	R1+soildg9zgBwRsowNi85RpWuDqeXB0pX/gxVcAOFIIF+ipn5c+cPGhALrzGPlm
	xPr298a4JFywVBrY6TFMMZla3oS8qk+ZJLqVnFe/ULYP8PNUtTRdLYlPQ8M+qVMx
	cT5owj0Pv4qZSsFqCGc+DPr9ndErP2h+SSKsF5Z6Uhd5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42p4u69jv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 02:28:29 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Nov 2024 02:28:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 4 Nov 2024 02:28:28 -0800
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id E25353F706D;
	Mon,  4 Nov 2024 02:28:23 -0800 (PST)
Date: Mon, 4 Nov 2024 15:58:22 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <jerinj@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.comi>, <jiri@resnulli.us>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 2/3] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20241104102822.GA1011185@hyd1403.caveonetworks.com>
References: <20241029035739.1981839-1-lcherian@marvell.com>
 <20241029035739.1981839-3-lcherian@marvell.com>
 <20241103115310.61154a0d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241103115310.61154a0d@kernel.org>
X-Proofpoint-ORIG-GUID: iolFY7MA4iBNNeHGsH4ckbATTMXMYz3F
X-Proofpoint-GUID: iolFY7MA4iBNNeHGsH4ckbATTMXMYz3F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Hi Jakub,

On 2024-11-04 at 01:23:10, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 29 Oct 2024 09:27:38 +0530 Linu Cherian wrote:
> > +	struct npc_install_flow_rsp rsp = { 0 };
> 
> @rsp is reused in the loop, either it doesn't have to be inited at all,
> or it has to be inited before every use

Ack. It doesnt have to be inited. Will remove.

> 
> > +	struct npc_mcam *mcam = &rvu->hw->mcam;
> > +	struct rvu_npc_mcam_rule *rule;
> > +	int blkaddr;
> > +
> > +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> > +	if (blkaddr < 0)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&mcam->lock);
> > +	list_for_each_entry(rule, &mcam->mcam_rules, list) {
> > +		if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, rule->entry))
> > +			continue;
> > +		if (!rule->default_rule)
> > +			continue;
> > +		if (enable && !rule->has_cntr) { /* Alloc and map new counter */
> > +			__rvu_mcam_add_counter_to_rule(rvu, rule->owner,
> > +						       rule, &rsp);
> > +			if (rsp.counter < 0) {
> > +				dev_err(rvu->dev, "%s: Err to allocate cntr for default rule (err=%d)\n",
> > +					__func__, rsp.counter);
> > +				break;
> 
> shouldn't you "unwind" in this case? We'll leave the counter enabled
> for some rules and disabled for others


Wanted to keep a best effort approach here, will make it clear in the documentation.

> 
> > +			}
> > +			npc_map_mcam_entry_and_cntr(rvu, mcam, blkaddr,
> > +						    rule->entry, rsp.counter);
> > +		}
> > +
> > +		if (enable && rule->has_cntr) /* Reset counter before use */ {
> > +			rvu_write64(rvu, blkaddr,
> > +				    NPC_AF_MATCH_STATX(rule->cntr), 0x0);
> > +			continue;
> 
> so setting to enabled while already enabled resets the value?
> If so that's neither documented, nor.. usual.


Will move this code under,  if (enable && !rule->has_cntr) case.
Infact, all enablement happens only from devlink control, hence the
above if check is really not required and can be confusing. 

> 
> > +		}
> > +
> > +		if (!enable && rule->has_cntr) /* Free and unmap counter */ {
> > +			__rvu_mcam_remove_counter_from_rule(rvu, rule->owner,
> > +							    rule);
> > +		}
> 
> unnecesary parenthesis

Ack.


Thanks,
Linu Cherian.

