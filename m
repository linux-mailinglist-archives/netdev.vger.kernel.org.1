Return-Path: <netdev+bounces-192184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893BABECC4
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8923B19CD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565C23504C;
	Wed, 21 May 2025 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="U3PA9w87"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F8235049;
	Wed, 21 May 2025 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811212; cv=none; b=KtD/iue6XnxtTx90RzoJ8mMNAuc15CYhTaJMjEFbKqc5A3RH2Iu9iYiF6e9LLLSPrRVk1hBsfeGjekEFpbdZ7fdp8Ll27XdWM9dLPp7QT0Hc44EDHlPgXRH8FraO/Tr10QHamW+erNaB3NnPmwce5d4FPkmaLJx3qXEsoicuU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811212; c=relaxed/simple;
	bh=y+EqpJywUMH9nHGD6s9CiK+qnZyK9vnfU8hT14XBxxs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl0gVdAiaN7jKnTZrqODk+FC8fh5FtysLRD0qbEyJmusjOK7RMG1EXc+QCKbLr+HhTb/WHLGMOlFXM04IdSXL9rfcopK7tPyFJ/MeCiIaW+K/0Hpw0i1zGHCGbQq3XqcTzALwkxvHV/lZoXuTvL/aJDg0dxeFQX9i6dcbJyHUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=U3PA9w87; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNkISX015649;
	Wed, 21 May 2025 00:06:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=P8/ITfuQzWsLicHCkKnjp1NaO
	TkPX9FT0tQbKECukXg=; b=U3PA9w87VighZgQ2Eyu7VtItKdloDjeOA+dP4Don6
	beAelgGYfgsCE4vIjjvZiXARxnUnUH0rol9FAFafPJJr/d6l741mAPgq7CqKzbdF
	ABDqvoQMTDrpJ+X4eBalIDPeVhGrRnd01psBrsZP//Z/PrQAE8cFe9slbxtqm9+j
	QuQ7CNtMfMz/yp98y1VSOFnTLJu5fBPizcbLzoZ6YtLDFb3owXWwv/ugrZQCouI5
	jRq4G6MFwakzdfhOX3N6J7HjJJIt9skAVYiQ3GmtmPF4fM9+8t38xiRFKGL0QlRV
	QJP+Qli3C2Q8k2mkdVnXFLSvS1nLcrm/3UIs2ZopJtuzw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3purnqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 00:06:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 21 May 2025 00:06:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 May 2025 00:06:38 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id B01243F70B3;
	Wed, 21 May 2025 00:06:34 -0700 (PDT)
Date: Wed, 21 May 2025 12:36:33 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next] octeontx2-pf: QOS: Perform cache sync on send queue
 teardown
Message-ID: <aC17efTkxDQ5+h1P@test-OptiPlex-Tower-Plus-7010>
References: <20250520092248.1102707-1-hkelam@marvell.com>
 <20250520170615.GO365796@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250520170615.GO365796@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682d7b7f cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=t23tOx8119NCeN4cTkAA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: PVwdN8hdBB8HBBQh2nnlqKgbtslK1qdU
X-Proofpoint-GUID: PVwdN8hdBB8HBBQh2nnlqKgbtslK1qdU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA2OCBTYWx0ZWRfXyFLO16LhMdPj 4QvyK1wwECkcehZbXFitX5LN4mv9Ia6VcmdOFqNm3a0ZYp+CH2QB0FvQxL/Vx7A0CRk9h1n/UFa LYlTsOD8eJQMvShXSAD+WPT2HOrGao67azz0PIdS5KWLz7m+qGIvGzSzUdSIaXNN8yJPwuWYMmS
 eJAawmc7xox8MwHBZ87KBzM8jBhbVvdApZifSiPB1OizzSaCYvYKIA1J/kaw4G0NWSp9QeDlvqJ /Haomni4zofly+vUlCYIXJlFyIMT+UO3XSK/OcbXuoXyAej4gjGH8uXbcDxdNd5+WRDproNnwk0 mmkdZgXKiBpZwzt6dKNTD83vJmxC+qhQNYpPKcesdo+rMiViENmYUvCgKrKbBlCPwVUqnwj6iL+
 uPa1hkTVOzFI+V+PcMNdjyUcnuFfbbUYgufoFCokEV1xsZa0BNMmE4jjyLqaJ1mhYgQyFYk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01

On 2025-05-20 at 22:36:15, Simon Horman (horms@kernel.org) wrote:
> On Tue, May 20, 2025 at 02:52:48PM +0530, Hariprasad Kelam wrote:
> > QOS is designed to create a new send queue whenever  a class
> > is created, ensuring proper shaping and scheduling. However,
> > when multiple send queues are created and deleted in a loop,
> > SMMU errors are observed.
> > 
> > This patch addresses the issue by performing an data cache sync
> > during the teardown of QOS send queues.
> > 
> > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> 
> Hi Hariprasad,
> 
> This feels like a fix and if so:
> * Warrants a Fixes tag
> * Should also be targeted at net rather than net-next if it fixes a problem
>   present in net
> 
   Ack, will post to net 

