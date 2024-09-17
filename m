Return-Path: <netdev+bounces-128650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8672E97AAC2
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 06:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2682FB21632
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 04:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07483288B1;
	Tue, 17 Sep 2024 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZHsU5p3M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78B26296;
	Tue, 17 Sep 2024 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726547923; cv=none; b=p0Wwpumw5YSkNVuxK8PM7G2wqzE8Mc2jEDNij0cmGaLx3bWULbOGE4KSjD6Bi+PsjtPUXv1u9tpxx6EvBEFWnXUXE06kAgRk9g79/6LWcePrQmthdTokjnxxGfQUgHQwYV154jq6b6rQ1HMwEoAMOj02WHgQ07CWzgkDsA7l/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726547923; c=relaxed/simple;
	bh=wlsUYedSURiC957dnNgWgfebGh3oEz8R7ha2seOQkak=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTJgCVzWnsjA4omaIwS0QqDAuD/JBxhcndnvADAOjh+QldfmYqCH7v7yzu7K98SWMQoIxZPEGomp8CsLUV5krNBOw3ge14JKIe0v2Xmc5r/Eqy1c6T7lOq7w/7rpxTbuJpVl9SI5ClEfwoDi4q3luqqGOu40CTpzFk/JqieJXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZHsU5p3M; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H23gB6009258;
	Mon, 16 Sep 2024 21:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=u9skj8jWVqLMZxZlN0eWm4055
	nBFSkp0Ez0u2F1WHeo=; b=ZHsU5p3MEOSj+VautCDgLV0Yjct3LoOMoD8ilZQ3s
	rt5qd7lA5KNA2rO9qfb7k4pImZhDbo4mlYMeIjKc+RzM493jE5BJkcTNpmx+c97n
	VFDfLvg+xxJ3VUVtVIMdQEI6qPVlQI+v0en640acnjDkknEskoz64Z4jd69IziW6
	R5ZwcJN54+mUSXzsCsuePKxJCinOTLI3CyxWcs9nuHpnMUk7XVKrgWZEu0cKAhrs
	Gse/KLTcN46QzpTT+xp2vB3wHkJShDV7kkWE69h7QRCvrYIFkenzRAeuVj3sjeeg
	1vO8WcOXi2OTRVVXtp9FJPEqx1gb+KoEv4hh5W1iRx1tw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41na0g0qvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 21:38:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Sep 2024 21:38:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Sep 2024 21:38:31 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 7AC163F7079;
	Mon, 16 Sep 2024 21:38:27 -0700 (PDT)
Date: Tue, 17 Sep 2024 10:08:26 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 1/2] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20240917043826.GA720400@hyd1403.caveonetworks.com>
References: <20240912161450.164402-1-lcherian@marvell.com>
 <20240912161450.164402-2-lcherian@marvell.com>
 <20240914081317.GA8319@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240914081317.GA8319@kernel.org>
X-Proofpoint-ORIG-GUID: KSlcxGjwWcDFEJy1VjLyVGEgdwAHQDLk
X-Proofpoint-GUID: KSlcxGjwWcDFEJy1VjLyVGEgdwAHQDLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Simon,

On 2024-09-14 at 13:43:17, Simon Horman (horms@kernel.org) wrote:
> On Thu, Sep 12, 2024 at 09:44:49PM +0530, Linu Cherian wrote:
> > Add devlink knobs to enable/disable counters on NPC
> > default rule entries.
> > 
> > Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
> > for better code reuse, which assumes necessary locks are taken at
> > higher level.
> > 
> > Sample command to enable default rule counters:
> > devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime
> > 
> > Sample command to read the counter:
> > cat /sys/kernel/debug/cn10k/npc/mcam_rules
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> > Changelog from v1:
> > Removed wrong mutex_unlock invocations.
> 
> Hi Linu,
> 
> This patch seems to be doing two things:
> 
> 1) Refactoring some functions to have locking and non-locking variants.
>    By LoC this is appears the bulk of the code changed in this patch.
>    It also appears to be straightforward.
> 
> 2) Adding devlink knobs
> 
>    As this is a user-facing change it probably requires a deeper review
>    than 1)
> 
> I would suggest, that for review, it would be very nice to split
> 1) and 2) into separate patches. Maybe including a note in the patch
> for 1) that the refactor will be used in the following patch for 2).
>

Ack. Will split into two while reposting.

> As for the code changes themselves, I did look over them,
> and I didn't see any problems.


Linu Cherian.

