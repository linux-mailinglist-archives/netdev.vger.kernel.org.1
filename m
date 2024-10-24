Return-Path: <netdev+bounces-138555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF99AE16E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA731F215C3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9001AC8B9;
	Thu, 24 Oct 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cHDzvuAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17201714A8;
	Thu, 24 Oct 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763453; cv=none; b=iVXeWPd/FcpdY05UORd/CjfZ+sBDSWQPiERVhR7LNnV+/BFYs/fFzzR0jOJ0LYosfEfNYkmL97Y6mfZkCTITqJvsZe3jrgdykmo8gJ5YB9U4q0XMrHOEh1kp1/XF8t0HrbsC0voUGzMenMHcglXVXWhObaAkw/dRfOMTZ0xj23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763453; c=relaxed/simple;
	bh=7PnC/bzAJv09hKYFG1gCCxbubL2DESAPjL+u3s4AA4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1TiwOPNssGqhsULQh1QgHt2qkEISG7nTKk1ADSTT3l1Sf3YzrKDDVjLy7x4aezG1mwlFpevi8lYLNzjMb9xku6ver34kJuC2DpHgZ54jj2BrPy9Jh2Yv/4eFWILQcKdTpAZGsgcFNkxpq6AXljvMPB9ANRTkWWDwts0kjBif4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cHDzvuAQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O9b7s2013503;
	Thu, 24 Oct 2024 02:50:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=A/hKWr3ZUoVw7sNpauvlnIdwf
	d4CNjfdvbnhswSDgik=; b=cHDzvuAQI5EnS05FMrOQ5Fr5lELEs2yhlONkLyC5K
	ZjfompY7bhH6cxsrd85nA9GGGPUyIsUHjmqS5HxCq5KHVdb83Zn1UO9oPqUCP0b1
	fgPOq4nr1DjcfQk0UKAWJ+DMXRN8uTGXIoBOovOr9xAVelDAFtGRiwtYyVt2KTOd
	aI1kQ3Hy74+XEeAKLeMxT4oQWWiFLup8MxemphHZs2zHUR76WRSYMA3EveZghU4U
	dNjZNWwQNhYSJcwE7SQyEERoVkN8z+eyx2KlKxT6+alO2oqaMOZCvtI3tlJCWNVB
	y4BLsOgHsKI+WwoFuuMJvAoMCECQpM7kcwq0RBdoa/okg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42fkrf017e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 02:50:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 02:50:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 02:50:27 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id C78713F7092;
	Thu, 24 Oct 2024 02:50:23 -0700 (PDT)
Date: Thu, 24 Oct 2024 15:20:22 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <jerinj@marvell.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v3 net-next 2/2] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20241024095022.GB954957@hyd1403.caveonetworks.com>
References: <20241017084244.1654907-1-lcherian@marvell.com>
 <20241017084244.1654907-3-lcherian@marvell.com>
 <20241018120159.GJ1697@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018120159.GJ1697@kernel.org>
X-Proofpoint-ORIG-GUID: yZoQFiOdiAFYs-d0SG9DPHDbgTcKKGCQ
X-Proofpoint-GUID: yZoQFiOdiAFYs-d0SG9DPHDbgTcKKGCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Hi Simon,

On 2024-10-18 at 17:31:59, Simon Horman (horms@kernel.org) wrote:
> + Jiri
> 
> On Thu, Oct 17, 2024 at 02:12:44PM +0530, Linu Cherian wrote:
> > Add devlink knobs to enable/disable counters on NPC
> > default rule entries.
> > 
> > Sample command to enable default rule counters:
> > devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime
> > 
> > Sample command to read the counter:
> > cat /sys/kernel/debug/cn10k/npc/mcam_rules
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> > Changelog from v2:
> > Moved out the refactoring into separate patch. 
> > 
> >  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
> >  .../marvell/octeontx2/af/rvu_devlink.c        | 32 +++++++++++++
> >  .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 45 +++++++++++++++++++
> >  3 files changed, 79 insertions(+)
> 
> Hi Linu,
> 
> This looks like a good approach to me.
> However I think you also also need to add documentation for npc_def_rule_cntr
> to Documentation/networking/devlink/octeontx2.rst
> 
> Likewise, octeontx2.rst seems to be missing documentation for the existing
> AF parameters npc_mcam_high_zone_percent and nix_maxlf. I did not see
> if there are any more undocumented parameters for octeontx2 but I'd
> appreciate if you could do so.

Sure. Will add the documentation.

Thanks.


