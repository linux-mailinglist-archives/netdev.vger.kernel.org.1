Return-Path: <netdev+bounces-243423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B91C9FE64
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F85E30062D5
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9D5343D7D;
	Wed,  3 Dec 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="q41PqCVO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D503342146
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777845; cv=none; b=C7aK5yM/7+aMvG+HNA7KbZFp+j1F7vhrW+gmDQQ/Y0hDNBBPZbvQ9MUl40XDFt25ng5OzjZItYFkhus5D4PHh2sYX6zNgf6nmanPOFlpYOKRRFR4Mq129ir8MqyvUhsGyCH2zQht+I5qA7ECSLlQJbOAKr/8K02ZaY9cVjuyf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777845; c=relaxed/simple;
	bh=7KkKG378b9JRT4tvDmQ33QUe8ZhTeAld66ZSp25iBfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhbGs0Fc0LS3rpgaFvoHk7dkU+Ht51pXebudXfnkzl2HqU3RKVycCZ6F0uZncLhyrJNCACT6puy9Yy/XG2S8XQpCSLR+it/8wt5Nn9CpeE5+4UclKmT9aOulWGHsiQ3sKm9eLTJW9rDx2fwauzgaDdNasIay85LargKgKwNvs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=q41PqCVO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3FX3gP3744841;
	Wed, 3 Dec 2025 08:03:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=775/ur+2F/qbl+aiP52Hbr40OQpK7M+56CdVzCXg/yo=; b=q41PqCVO1SiG
	8d3DnVo/hMi5MIumHoLfWugBsYDTUDF5P+aArAcuzqP4G9cepuFLcFYm3tk+kg3M
	gGgRGk6X4lrD9gurd+Smefo9KJRGC5HOm8udItpbh7RCetqzPb5XiXQkGzL2a/oJ
	7lUhvq7xqmcc4BLOIj/DR85cQWq4OkIBEGrQvnpA/mwbr4ceOaxhW6Yl8SuICSrp
	WnS3/XxDfl7qJotmR+IzjbBlLWwyF8XNBwtybukG5DZ1kE4mO3/QPkDJobRrdGCV
	R0rArpdyAsOzyo1Z5kxJFox7N4oFSalcRWKRmwatTUItxe/9aBphOoXq/YWBvhnL
	1UiEbNO3hQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4atf69un7q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 03 Dec 2025 08:03:46 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 3 Dec 2025 16:03:44 +0000
From: Chris Mason <clm@meta.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Chris Mason <clm@meta.com>, Simon Horman <horms@kernel.org>,
        "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
        <jasowang@redhat.com>, <pabeni@redhat.com>,
        <virtualization@lists.linux.dev>, <parav@nvidia.com>,
        <shshitrit@nvidia.com>, <yohadt@nvidia.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <jgg@ziepe.ca>,
        <kevin.tian@intel.com>, <kuba@kernel.org>, <andrew+netdev@lunn.ch>,
        <edumazet@google.com>
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Wed, 3 Dec 2025 08:02:48 -0800
Message-ID: <20251203160252.516141-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203083305-mutt-send-email-mst@kernel.org>
References:
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEyNyBTYWx0ZWRfX/wRHnxwjtw0/
 pJx0R2uGJAylMH7GIJ9/s860XWCwysrp5A547tHfUecO2eYJWd/S+fp6YOKHKUX+tt7dbHWOIWf
 2CFTz1Z32bR6BL/9uaO+jWdmaFDft6aOiuBxd7iGrb+NInQJ8wEmvJ0rZA0lJAdlF3e2a0CBqgm
 cH0+6EZQeJRxs6rVkzb2+pn6EQUmpg+Nqoq4LAHvCJc1LBp/BiEdAgD8ArIHpOZ+who0Lipwc04
 mOZXVWpXMyb+766AjGx0L2a4/VIAw7xEkG+tSMDb+qVdxQWRRfaG2yK2NuTvfpg6GXuj6o08Ncl
 3VwP3USbN+4TgT6wGXpzDohmX78CEFqYFt1BQZXl/dyQ9AbNBa7XBS5kQ8WP4rjya+TGtpMwUpz
 0MoL5qatpvwafx061uQWp+j4bUCAvA==
X-Proofpoint-GUID: DHimFOAyM1mpklZCE5b7PZFA_n2XuQNQ
X-Authority-Analysis: v=2.4 cv=IrYTsb/g c=1 sm=1 tr=0 ts=69305f62 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=9R54UkLUAAAA:8 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=NvQyTCM08Br6FijgrkcA:9 a=5hNPEnYuNAgA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: DHimFOAyM1mpklZCE5b7PZFA_n2XuQNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-11-27_02,2025-10-01_01

On Wed, 3 Dec 2025 08:33:53 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Dec 02, 2025 at 03:55:39PM +0000, Simon Horman wrote:
> > On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
> > 
> > ...
> > 
> > > @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> > >  		mask->tos = l3_mask->tos;
> > >  		key->tos = l3_val->tos;
> > >  	}
> > > +
> > > +	if (l3_mask->proto) {
> > > +		mask->protocol = l3_mask->proto;
> > > +		key->protocol = l3_val->proto;
> > > +	}
> > >  }
> > 
> > Hi Daniel,
> > 
> > Claude Code with review-prompts flags an issue here,
> > which I can't convince myself is not the case.
> > 
> > If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
> > as does this function, then all is well.
> > 
> > However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
> > flows, in which case accessing .proto will overrun the mask and key which
> > are actually struct ethtool_tcpip4_spec.
> > 
> > https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196#patch-10
> 
> 
> Oh I didn't know about this one. Is there any data on how does it work?
> Which model/prompt/etc?

I'm not actually sure if the netdev usage is written up somewhere?

The automation is running claude, but (hopefully) there's nothing specific to
claude in the prompts, it's just what I've been developing against.

The prompts are:

https://github.com/masoncl/review-prompts

Jakub also wired up semcode indexing, which isn't required but does
make it easier for claude to find code:

https://github.com/facebookexperimental/semcode

I'm still working on docs and easy setup for semcode and the review prompts,
but please feel free to send questions.

-chris

