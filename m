Return-Path: <netdev+bounces-189134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F5AB093F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8891C062F7
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 04:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8285922DFA4;
	Fri,  9 May 2025 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HqCvL0bI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A13322E
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765550; cv=none; b=GltUzVcXGRAIz28WRR7v+9kwtMiKdHCI7tIyQORlV4buHJconQNeh7zkqPJudPvjjUjyzIfXfx9ZM6z2rOq6Laz6Us/wMWaNj5EhouiXnRdiHoP8xhU6KdbfoyyD58vFBggDc+EptUk5mzSnVpOZFYiZgkYBGnG8nJB3k9m4zMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765550; c=relaxed/simple;
	bh=QZFvDgkUvmLldGSWuy/vcBIHE/Al4bNz0J/V8/anpOc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE07JB17WVYACUmv/riBRztO2P0Guzt6yCFTYMYkCzfUHo+WYcxSJLoM54LHXSxl/weUXJbngjnpP3fevquPobZKE+stc7x7y9IlFCSLg01ECMyfpuk/RssNADWHKhzuhmkNtyd4hKJgUYPcbSJePYi8hod0W6csCURlYc1D0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HqCvL0bI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5492iaar031007;
	Thu, 8 May 2025 21:38:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=U1Z8zb6AsUv6pJEiZmb68fCSw
	2RlNTFie/wckJvW6ME=; b=HqCvL0bITxQ+rtm1qvrxjEa7PHMiTo3RBv5uUKwuC
	akMqKvSNkZd0oxRM4CpyO+SL9NAe+9ji4upzs/0jGz799seFP9msi2fZ+O7DggBl
	md4KhuAu84ufW1kKR6G23OBzQhToL+vrH1KNpCtF4qzH4GZhPQmr9cwDfBqGdOMp
	SGk9H8pmaRsobmwBM6QTntX3GtdN3gdsruGD1voiSKF0vHbccqCjkSpZUzCEbyH+
	nlhtVj7K02XoQISizBX5d1X2B7kdn1AQEhz7a6Q48aWWlHokefEePeJLKwN5NyJZ
	jclwXvG8eec++VmygCl22Kqolq0NNzIS+pg5QBuOGUPew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46h96c06q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 21:38:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 21:38:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 21:38:46 -0700
Received: from ce1afb5360f2 (unknown [10.193.77.153])
	by maili.marvell.com (Postfix) with SMTP id 950D53F7050;
	Thu,  8 May 2025 21:38:42 -0700 (PDT)
Date: Fri, 9 May 2025 04:38:40 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-pf: Do not reallocate all ntuple filters
Message-ID: <aB2G0MdH-NEMteKr@ce1afb5360f2>
References: <1746637976-10328-1-git-send-email-sbhatta@marvell.com>
 <20250508185731.GO3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250508185731.GO3339421@horms.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA0MiBTYWx0ZWRfXx1vkOeO3fRng gLtGLGDphvFUI+zY8J3aHm9S/tXKKxE71qPEJqtuwfSQ5aH9JZ57zHQovYa1GMB/Q/tf3JdEdt0 VgnqW2uPztS0TuUS0IJxYTwhXUTM95SX0mUBfYb6Fyb/tqUP0oYT6kzIxA3onjSSKxk9wQQ2Mm5
 MnXyIcyJYE6rKKKbxVtR6fQsePDX3/+9ff7o+ChZ0nxuD/AU/+BbvC2KLYcTEZwhL6OmBDRUMPE h47Htl6e6C9+Vgm9KRDwbIaXtBK+k9Psn5czQK23gy/30jHbD6OhKM1OrVdF3/eTZm10gB6pZYH 20oQHR8iEHcOn5g10RGDxYtlhthrkL0A10C1yd4ss3mgJdjSk6qarFdVCNCqw9iyRWCpPSSgK2Y
 iBg8JYmFUzjQVWzk6oqG6RoozF5VmlVUEWSNTucFf7nCfZ3iLY28jOtN2ZNCFN6Y0Z3LXGoO
X-Proofpoint-GUID: F4ItJidzsCrBMVE3uOuAhesRpfT_I6RD
X-Proofpoint-ORIG-GUID: F4ItJidzsCrBMVE3uOuAhesRpfT_I6RD
X-Authority-Analysis: v=2.4 cv=dpXbC0g4 c=1 sm=1 tr=0 ts=681d86d7 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=AALDOkYYfIM4LSDXbRQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_01,2025-05-08_04,2025-02-21_01

Hi Simon,

On 2025-05-08 at 18:57:31, Simon Horman (horms@kernel.org) wrote:
> On Wed, May 07, 2025 at 10:42:56PM +0530, Subbaraya Sundeep wrote:
> > If ntuple filters count is modified followed by
> > unicast filters count using devlink then the ntuple count
> > set by user is ignored and all the ntuple filters are
> > being reallocated. Fix this by storing the ntuple count
> > set by user using devlink.
> > 
> > Fixes: 39c469188b6d ("octeontx2-pf: Add ucast filter count configurability via devlink.")
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Hi Subbaraya,
> 
> I am wondering if this is more of a but fix or more of a cleanup.
> 
> If it is a bug then I think an explanation of how it manifests is
> warranted, and the patch should be targeted at net. If not, the Fixes tag
> should be dropped, and the patch should be targeted at net-next.
These patches target net indeed. My bad I missed net prefix in subject. 
I will send v2 with net prefix.

Thanks,
Sundeep
> 
> ...

