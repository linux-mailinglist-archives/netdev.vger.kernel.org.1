Return-Path: <netdev+bounces-249380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5331D17D1F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5E5F3005330
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844453876D3;
	Tue, 13 Jan 2026 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Bdlht57X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5203803FC;
	Tue, 13 Jan 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298361; cv=none; b=PCjePIL0fnz6R+QoKkSd1aCP/sDv+G8ZsfgCW43kb6ShyXC8TVpOoCPs2QDZx7x2q/1xANOdEFyNmJhWHosehKtjLCY8rbnvxNiYnqf97wf+w1yRKp/b64Wgdv1lAFmkRYq0XFiX+4HBvy1HUoyzps/kz202KcYepdw8PreXfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298361; c=relaxed/simple;
	bh=L2EW+eJQXUSb9tVFbo6zup7BZbL2v5WDs86QTGrhoVk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxVE3Bz2VJWQEKPKtwTUvzOwQQaxBp73+lvvuKTJAi2o0NyPxk7fP7wnGyldMEE4ZI5RFHX89v1KtMfM1E3AVVo8DnjgVaXLxsrmDrGR3BZy15HXx2j/IVu5fC5rZ8qZ8/w47HsV6g6YRfbdPQLM1Als1hP3oAmDyN0QEor/d6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Bdlht57X; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q7oG2460628;
	Tue, 13 Jan 2026 01:58:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=iUN3kYlwdBY1v/KQFXEvixo6V
	wwiWv/u4PddNSZAsHk=; b=Bdlht57XJ5i/2bk1d1FT+gwCpP0DwsucpYNY/eAFw
	y6STz+WKGlf/PemlnCtA3ldd/3AkYp3M23w0LcDXD/wyTADeo6Kf6TLlkhD2MHJZ
	Yam6Lxl3EYCRiU3tw6FWg6PvCWX0JwWwsF4i6CM+RFM9he2LVICx+CkWkR6ipSob
	GqAzK1fvUjmRTD3n99Ptvyfjl+HttENqWJx2mjgDazeXzqeAEm0a9jVRuCChJpkL
	j5ZCHkbgXqTPNimR0LwT3m1a63i2kJ126E9GrusWKUsmbRM47pQWJ6cKOJnOd7ST
	aCkzkQS/Uc2tTRRqTtPvJkehurJ/iLY1k/R9cXLUw5Mfw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bmvfkbbvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 01:58:56 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 01:58:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 01:58:56 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 15A333F7096;
	Tue, 13 Jan 2026 01:58:52 -0800 (PST)
Date: Tue, 13 Jan 2026 15:28:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 05/13] octeontx2-af: npc: cn20k: Allocate
 default MCAM indexes
Message-ID: <aWYXWxxpOpTJ2W0y@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
 <20260109054828.1822307-6-rkannoth@marvell.com>
 <20260110145223.368bd5ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110145223.368bd5ea@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MyBTYWx0ZWRfX6XdjiWkSBp5+
 nl3tpxKqRpYS2KoJFBdSCYGDYWnRRjkrG+B69JfbF+JrornrUBrj7dHg9gQ57jGQ/xTOasGIRzX
 dAkEeMPGVdPNYjAm/O9lkwyiVqr5WGjOm2/SFAjANpkZHer0lAt4DiXmyKBuXDQtLVXCt6pdF13
 PdqTVQklSVQNUCoEQU+o3MNg/SazWdMnjD+7x1UgWpzbPizblaPLWXAOBXXlSB06NVo1oTlJ9Fe
 RLL21lu0qrgkl4IRsxWxa6c69PU4mHxqFTsEhyv3kaq5bRF5DQZZXYjhEIn67x8lwxibnHLEmGk
 hEYRuO3KOI8ARfv2hnMthixJi1K+WzP7iTgo4S5gaDSQ8hbX6WyNmuauKEHK5Rnqxuaf3FXXix3
 USXaJh/Sk58xoQ9VfTXfGgf+yfAxcGrxPyvFMEF9RrQfAWTqOUnpOVc3s/vms+4hhdWJ79xpgiX
 lRIfebvg/P+LO1ptKGQ==
X-Proofpoint-GUID: 2aOu8Rwdfq5FAZJehyiw_DW5CbiKXZY5
X-Proofpoint-ORIG-GUID: 2aOu8Rwdfq5FAZJehyiw_DW5CbiKXZY5
X-Authority-Analysis: v=2.4 cv=AZe83nXG c=1 sm=1 tr=0 ts=69661760 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=p2A5eun0up9gqvjACSkA:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

On 2026-01-11 at 04:22:23, Jakub Kicinski (kuba@kernel.org) wrote:
> On Fri, 9 Jan 2026 11:18:20 +0530 Ratheesh Kannoth wrote:
> > Reserving MCAM entries in the AF driver for installing default MCAM
> > entries is not an efficient allocation method, as it results in
> > significant wastage of entries. This patch allocates MCAM indexes for
> > promiscuous, multicast, broadcast, and unicast traffic in descending
> > order of indexes (from lower to higher priority) when the NIX LF is
> > attached to the PF/VF.
>
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:115 Enum value 'NPC_DFT_RULE_MAX_ID' not described in enum 'npc_dft_rule_id'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:115 Enum value 'NPC_DFT_RULE_MAX_ID' not described in enum 'npc_dft_rule_id'
ACK.
>
> You can use the
>
> 	/* private: */
Thanks
>
> comment/label to mark off "misc" enum entries that don't need a doc

