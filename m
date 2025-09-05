Return-Path: <netdev+bounces-220305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32468B455B2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2BD5A853D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C638F342C94;
	Fri,  5 Sep 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hayVNcaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1034166C;
	Fri,  5 Sep 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070303; cv=none; b=XG5xZoRwmaQLhMwmOukSs5EfSQnrzSbP1xs/chIHqXARmTVjaK8dd4N+0MA7KO7zFRA1KqcbsvlB3QPAvdzJvvk+xskMoDo6NIvhwVOn0vDnPyoCgPc9PKb1ghs1MM1lDl8YhQLGM90IBnKlooPsi9xS2wZTeooIE9LxqqbRmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070303; c=relaxed/simple;
	bh=z94UH18wEDTWuKbXydUnW9LoB+6yMEbgmCQLR68OqnY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5WSfxIH3MgSLXkDP5RvnCCmHFeWQoPZTMaQsl+jP3Pbl7ovnVTNvkrwAsgcATYG9wvjPAU4+lzb+VYeqwirIZK/okLvapdA0bp6/bx5hh7YSGBawEZvmXLp448ov64MGDBI1gPd5iChnULirWT8ZoYIUOP/B+L4m2r+pwnDG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hayVNcaJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Gvudu029451;
	Fri, 5 Sep 2025 04:04:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	2iOvuXzHrhkIoaofGS46Rn+lBRShu3PnRtqUUYUkhI=; b=hayVNcaJVPB1FPRxn
	s0AjQBkT9fQPwJSyLj6kM2eT/fPTWma57co+IYqddMgYJ5d3YI6BnGc7obhHAsuJ
	88Iho1Y+p7edTyxXylzJJ/LmTo4DMX7pbu3DdKH7nmlWsjrrVlyi0+w9K5eK71uX
	WHKbTWZ+jyReTL0fO2YiVGeSm1/uL7MM5UHzR5aRZdmtFxF5vMLlLNcwGyvnPu+o
	Anwac3RYH5xfgMWd+NupO5fvwDbQPqs5H0RGquJgKLc9yppqOwpOKnIaHdk+55mE
	9Vfa26pLW4iimSps6bNf0ph3w0IVevcFgdyrJj33m+S7MwppitQTzWzemG1d0h9M
	I6RbQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48yerk9wh3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 04:04:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 5 Sep 2025 04:04:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 5 Sep 2025 04:04:41 -0700
Received: from naveenm-PowerEdge-T630 (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id 2F6EE3F7104;
	Fri,  5 Sep 2025 04:04:30 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:34:30 +0530
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <horms@kernel.org>, <corbet@lwn.net>, <andrew@lunn.ch>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] docs: networking: clarify expectation of
 persistent stats
Message-ID: <aLrDvpAsVq4vTytH@naveenm-PowerEdge-T630>
References: <20250825134755.3468861-1-naveenm@marvell.com>
 <20250826174457.56705b46@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826174457.56705b46@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2NyBTYWx0ZWRfX8owaW6XsXbmz iCxUxMWzFq/FsC4cBuTKze3Sl/MUBbI8ATPpa4JKvtsSoc4oMAkxQ3dT2VuJg9JV33ZyV0VOssj rk4H3BQVHi3HUQPDCrAx2ICCH0QQCnadT7QeJEU0Wwee12nPVHiTgIVUr23pj7NKfvs2a5YGEVf
 EWkXawH2I6vQrETOu8mNFpIDXioPQyywuDFPe1fNFTkkdxKGggwoLNoQBirjEN42nDK+RR5JRJj BpRluJf7Qkr2qYh/pEw6MxVn4VNSnoUwNYoveCh9dPDNXFmvm/VysjsPPo0OeiyOkne0+JyoEAV fSkO1lnFSyDovEsrbpSu/ktAB0EADLANK4YZ0kqmRilwNMjL52BjBAfBUV/9hU0/lhoSkhaEuqR hAObYZvC
X-Authority-Analysis: v=2.4 cv=JL47s9Kb c=1 sm=1 tr=0 ts=68bac3c4 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=SfNP0LW7rUpxNmXbRPgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: 0WeGHb-qpZOFV9vkSHIGbsjOjNyHYN_e
X-Proofpoint-ORIG-GUID: 0WeGHb-qpZOFV9vkSHIGbsjOjNyHYN_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01

On 2025-08-27 at 06:14:57, Jakub Kicinski (kuba@kernel.org) wrote:
> On Mon, 25 Aug 2025 19:17:55 +0530 Naveen Mamindlapalli wrote:
> > -Statistics must persist across routine operations like bringing the interface
> > -down and up.
> > +Statistics are expected to persist across routine operations like bringing the
> 
> Please don't weaken the requirement. The requirements is what it is.
Ack on not weakening the requirement.
> 
> > +interface down and up. This includes both standard interface statistics and
> > +driver-defined statistics reported via `ethtool -S`.
> 
> Rest of the paragraph looks good, but I think the preferred form of
> quotations is double back ticks? Most of this doc doesn't comply but
> let's stick to double when adding new stuff.
Ack.
> 
> > +However, this behavior is not always strictly followed, and some drivers do
> > +reset these counters to zero when the device is closed and reopened. This can
> > +lead to misinterpretation of network behavior by monitoring tools, such as
> > +SNMP, that expect monotonically increasing counters.
> > +
> > +Driver authors are expected to preserve statistics across interface down/up
> > +cycles to ensure consistent reporting and better integration with monitoring
> > +tools that consume these statistics.
> 
> This feels like too many words. How about:
> 
> Note that the following legacy drivers do not comply with this requirement
> and cannot be fixed without breaking existing users:
>  - driver1
>  - driver2
>  ...
I don’t have a definitive list of non-compliant drivers. Would you prefer to add
a brief note stating that some drivers may not comply, without naming them explicitly?

Regards,
Naveen
> -- 
> pw-bot: cr
> 

