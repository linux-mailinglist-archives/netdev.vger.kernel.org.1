Return-Path: <netdev+bounces-199735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF29AE19C5
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13194A31F5
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5AB28A1E0;
	Fri, 20 Jun 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hzHYwl9j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4F289E1C
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418103; cv=none; b=PTkp5zIT2O+s1RriFsLsX307g24DEC+h+Uj0BHV9D+ROW+r5osHV6HNZZ5VECJPWcc6RTrXAsaeLORf05SksabGppeaRYYM5ciU9p7+CxmEElWM4i9+GfjuLkq/Baq8LC19jpAkufs3nR34A1Jr8iH3VpOt7csrKF72yig509rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418103; c=relaxed/simple;
	bh=zdmaomFgU4G7QNh7IIgSVz26uCYbXFUPHrKeccw9Xdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPWg1m3EF8QhvfTiVAtf3gXZ3KZbEBcvKZKoRBYJFLC+38XUE/j2Ewpty1lUo544lEn0fp+8dI1Mwsxpisaf08cLICzKV/RYq0ddHI/0mSH/IPrWNy8IDwqjBQiYqk76HikFU8BLnQcjX1cX5q77QDDexwV6he2j3cvSaILrUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hzHYwl9j; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K3TjaW015666;
	Fri, 20 Jun 2025 04:14:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YQ6vpw/omVQKI7gnm2O9T6g4T
	vDIxTaSkQ9WHYuaxUo=; b=hzHYwl9jA7zNls4BfILaEk3RcMJc0z3yRbAg/5sQ/
	TfKMIrOF0Vm8r8ImDTkDJapYRJWKVsn34R5tDSu6xyE4/zNByrH2wQwgyKLkERlA
	bkrn1KgmDO3IwTehmpkUAliuFtts7G6hDs0iTP5Ev1g8uO0VAMeuuP3l3UWK2uap
	ft8uG04YXk+5zY7OyN3IwnIQRsDWMep0goERg7fQL2csUlP54niV0BGWJYSbY0Gf
	jscoKuLtA4pfGftNV6u6q7T6wHZAuPH5PLfjr4UAEApAG6hHwRPjtqs8CqPCpLtd
	T1vvhK7qndUp8Hy94k+t4pvoqF6i0ZOfFlFFiK4YouxIg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cyshgswv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 04:14:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 04:14:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 04:14:49 -0700
Received: from 48c69cc54dda (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 5CCE15B692D;
	Fri, 20 Jun 2025 04:14:45 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:14:43 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <saikrishnag@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH] octeontx2-af: Fix rvu_mbox_init return path
Message-ID: <aFVCoxgAnfH1aQ4x@48c69cc54dda>
References: <1750255036-23802-1-git-send-email-sbhatta@marvell.com>
 <20250618194301.GA1699@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250618194301.GA1699@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=TuzmhCXh c=1 sm=1 tr=0 ts=685542aa cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=WlsQ4hfZpjk1E2LVT-EA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4MiBTYWx0ZWRfXxFp9R3Jkg/x5 7St0HZ2WmyuUQ1Qj+rtGSeU0kaeE2OfxpYaEZEYGh0mTFIUvRmQiAMcIam+bft+Fg6ZWlYVZ303 LaUyMhGAvHY/a+Ie2Iq2F9U1rJlgKvBxs3/d+/83s6TvjAig0mhGPzsc6OWMiWb/321fjvXh8o4
 ILFR5i28Xafu50Fxal+VVgV8isXXv5yHN2U/xaRFKoaVZwzl6eT0CKW2KFf7fMyobGukUDnwqrI F0Bl5cnuq0zPuJSFnq4FGItIMua8IIh/M/cQb9bYLuq1ljrLuhFHuQPJ8uM+ljmP+jihrYwLwK6 v2dYVjrZ/RY8AHJssix8Dbv+EDXR2WOganDJ6+RcWQVTDleMqX9lk49NWTTpKfdDZqCmDqhv55N
 fwKYesB+vHOSy+4vZYFrg71ppaC70+//JApCOi/TBgYoAs/HbhefBezlTBdF8QfOPWhRXIRH
X-Proofpoint-ORIG-GUID: -R6FalgjXkEqXZYDd2krt6_waVN0Dhu1
X-Proofpoint-GUID: -R6FalgjXkEqXZYDd2krt6_waVN0Dhu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_04,2025-06-18_03,2025-03-28_01

On 2025-06-18 at 19:43:01, Simon Horman (horms@kernel.org) wrote:
> On Wed, Jun 18, 2025 at 07:27:16PM +0530, Subbaraya Sundeep wrote:
> > rvu_mbox_init function makes use of error path for
> > freeing memory which are local to the function in
> > both success and failure conditions. This is unusual hence
> > fix it by returning zero on success. With new cn20k code this
> > is freeing valid memory in success case also.
> > 
> > Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Although I don't think the problem is introduced by this patch
> with it applied Smatch notices that the following code, around line 2528,
> which jumps to free_regions does so with err uninitialised. This is a
> problem because the jump will result in the function returning err.

Thanks Simon for review. I will send fix for Smatch error in
separate patch later.

Sundeep
> 
> 	switch (type) {
> 	case TYPE_AFPF
> 	...
> 	default:
> 
> 		goto free_regions;
> 	}
> 
> ...

