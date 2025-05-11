Return-Path: <netdev+bounces-189523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14277AB2857
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 15:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C97E7A7D72
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15932563;
	Sun, 11 May 2025 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F2AA7YgZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16608645
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746969329; cv=none; b=Q1UUXiTXU3wlhBsph99PO99zTHGgaK2d9ImPEXbLlENAwxwjHgQsy7RZgD4pE446b3il23q6uImXB0nGJgAKN/Udmt7fRst8I4Q8YPMeYWvuW34p8JR26FNUBAEQdyfAaxLekwBjanluSEDzSSI+TTUTeqS4T5/UyYRSJgIKG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746969329; c=relaxed/simple;
	bh=HW9QsWpB/7TVd0Ecxhhwq21y8h/vjnzXp6m8O5wHSbg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SELvEKVQhzDZcwCbE+YypluBvYN4XBVOmEXq3KiU0piqN35A3yh27E7cEXNa9gZtlN9cNXBL02Z0F7m2VRxAaCylQgynkAcCyKZGVJrR8EFlbreQAFyLcq2gYz3Hc3XIfeEvNLGcIsH+D207LYOYPOKeaBJI36W30RWq9onX4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F2AA7YgZ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BCPnpx016796;
	Sun, 11 May 2025 06:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=EV+YoAS4TPRGuR5zAUpqnijyE
	tIFm38Oh/O8G3bKxfo=; b=F2AA7YgZYunwhso0LMk6VVrCsXcP7iLGGzyewU2nd
	Nmc5Qmn6Oer08jAJlj2siATDDpcExeW/rvCOMzXZHDEVgJZh+eYzIlpkJBSU/QwN
	SXth3VUsRE9xfbAVpwEvJUEX9UQbZhWOhK0c+/1t/b5A9I67usEZlBtwyx95/raD
	QMmVKRK6Uk3AzMzKwvrIjXFjhROAWuNxWeeJoPJbW6t9Uovc3OEpDeZ81id+66CN
	jvZwcmIzWRPkyDcSjPPTkDi2qf+xqqHbWNbZM53eXLCPVoBkLYT6kCRHE8M/2MKH
	pYPkdVWPVk39Uh4EQ0kUBky1oK4b6yNpAE/+7Jflt3+rQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ju2b82my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 06:15:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 May 2025 06:15:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 11 May 2025 06:15:18 -0700
Received: from effaecf3b85e (unknown [10.193.77.206])
	by maili.marvell.com (Postfix) with SMTP id 4E4933F70AA;
	Sun, 11 May 2025 06:15:14 -0700 (PDT)
Date: Sun, 11 May 2025 13:15:12 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>
Subject: Re: [net PATCH 0/2] octeontx2-pf: Do not detect MACSEC block based
 on silicon
Message-ID: <aCCi4JcJtzh1bfP-@effaecf3b85e>
References: <1746938403-6667-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1746938403-6667-1-git-send-email-sbhatta@marvell.com>
X-Proofpoint-ORIG-GUID: 1MnX4oiohrl9jIBw3nSlDsfcsq-3we7-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDEzNyBTYWx0ZWRfX/tCgisnuqj/4 gr9Z7IvtQNpTCXKLwWgw4r88r5WHRa8sz/+Kq1PtFVIx2fvvyBOjMuI4MIhpBdcWL8PWfSGPQhn R6HImXfuz6L6REeyTwieNKAdgMAIq00AGhWHJytXBaHxvALvWBAyMnfJTiYQRy9oiMR2+Xx35Q3
 KyHWzhmi95A0qB9JnS1O4kk8KQ6gdN60LxPHRbg7IZq60l2V2uoWdxkdvOrd1P8Pou8m0Kvdt1a QLVlupRcs153IHX0pgZpsnPy8kgV06OoRXIr4yorcrcbB7RbyQQMZXOUxbvjZFCtEmuUXRoG68Z PKobsTYt4HptyUHD57jvwtwRcRN1ZTgEkb3b2T3Z4FfvcODSRv7pZEb5KiJmi7PsRHBgSPJ9eO7
 vPHNKAyfend+8C40eRfkhqZC6QODGLJOXzVx3ojPO8TywcGqueCTkQtJBXRipe4pH4gYpKx3
X-Authority-Analysis: v=2.4 cv=DY0XqutW c=1 sm=1 tr=0 ts=6820a2e7 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=vmxRQB8E3U4Xl0pZ:21 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=XeB7T_0v8dNxmgJPA3EA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: 1MnX4oiohrl9jIBw3nSlDsfcsq-3we7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_05,2025-05-09_01,2025-02-21_01

Hi,

Please igonre this series. Wrong prefix in subject. Will correct and
send v2.

Thanks,
Sundeep

On 2025-05-11 at 04:40:01, Subbaraya Sundeep (sbhatta@marvell.com) wrote:
> Out of various silicon variants of CN10K series some have hardware
> MACSEC block for offloading MACSEC operations and some do not.
> AF driver already has the information of whether MACSEC is present
> or not on running silicon. Hence fetch that information from
> AF via mailbox message.
> 
> Subbaraya Sundeep (2):
>   octeontx2-af: Add MACSEC capability flag
>   octeontx2-pf: macsec: Get MACSEC capability flag from AF
> 
>  drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |  2 ++
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  3 ++
>  .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 37 ++++++++++++++++++++++
>  .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  4 +--
>  .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  2 ++
>  5 files changed, 45 insertions(+), 3 deletions(-)
> 
> -- 
> 2.7.4
> 

