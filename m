Return-Path: <netdev+bounces-169430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14F1A43DB5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28463BD67B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85F267B7B;
	Tue, 25 Feb 2025 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aDNjx0O6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188D267AF6;
	Tue, 25 Feb 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482941; cv=none; b=Ko9CmGeb8vAZbINqnmBR8rj954n9DNyM3g02/1E89e5BFMBevH7akPdffjbGgBxsnYGpDIZEUBokzS2C9ptdOsOUs3mn3GWS04TCu9Va+bf3SNEIaINTmEU+O7me/bqyRgstwCe8jyeTh1OnohxvpOMIv4VrXa8cdbmyfpRuHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482941; c=relaxed/simple;
	bh=4sgbNAfckysK5yUpsHXkpcHylYnfBrrpT1xYb428eDc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2YQBuc+ZlIDHapx6UEXd0RuR6bl9NcwT85n4cxFuNJvss1TbygJU6EgA5jKsvrGLSRmK5THiBm7zMX8crj98qJC0CIf14d64UuEydX+pVXZMKIeQU9Uq0GJ/Y47PASqxQ11WiKDUbg1WDdB0v67zcwcLx4Tbz2W4wxLX1NRvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aDNjx0O6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8Dmgu009109;
	Tue, 25 Feb 2025 11:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AH6XyKMQKy1L5/1/4qcQ3Dq5
	+Ibr/w74DoNERr7pYSI=; b=aDNjx0O6kRUrZmxs1FJNFDwlArHvEk4P1kDlXtSl
	+TwgnKsIULHWmVIlIBfrmBYQUDcILJ8a2LCogStr90Np0sZgk9Em7NfA1P9jX/li
	gC3CuPC0+JKmfDAWoEly+Gy5Ga85wX/6mSInUc6XaH7fvLWsaU+5aFj9rdIwPktc
	BgTvgYPBVAi9gvfL/xEZMnJsn46DCWy0eUTuHAoA5n/zI06TlEXpWEOjTn0noRTP
	WBmKG7D/o3u3cHVqORlaUf5+NpVcP9lHr8HtS5iKmSat+bOaJV9AaHae4Sf4/rLR
	gEqsuxsN3jDL170vvn+wdhEAw0kmzEUxiOUoFHRMC8j4ng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6y6rp38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 11:28:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51PBSW8O029297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 11:28:32 GMT
Received: from PHILBER.na.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 03:28:27 -0800
Date: Tue, 25 Feb 2025 12:28:24 +0100
From: Peter Hilber <quic_philber@quicinc.com>
To: Simon Horman <horms@kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio
 =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, David Woodhouse
	<dwmw2@infradead.org>,
        "Ridoux, Julien" <ridouxj@amazon.com>, Marc Zyngier
	<maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Parav Pandit <parav@nvidia.com>,
        "Matias
 Ezequiel Vara Larsen" <mvaralar@redhat.com>,
        Cornelia Huck
	<cohuck@redhat.com>, <virtio-dev@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 2/4] virtio_rtc: Add PTP clocks
Message-ID: <vhlhes7wepjrtfo6qsnw5tmtvw6pdt2tfi4woqdejlit5ruczj@4cs2yvffhx74>
References: <20250219193306.1045-1-quic_philber@quicinc.com>
 <20250219193306.1045-3-quic_philber@quicinc.com>
 <20250224175618.GG1615191@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224175618.GG1615191@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HaD8-URwhEOYl4JEkmXZIwXbLt2o3JAj
X-Proofpoint-GUID: HaD8-URwhEOYl4JEkmXZIwXbLt2o3JAj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=537 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250081

On Mon, Feb 24, 2025 at 05:56:18PM +0000, Simon Horman wrote:
> On Wed, Feb 19, 2025 at 08:32:57PM +0100, Peter Hilber wrote:
> 
> ...
> 
> > +/**
> > + * viortc_ptp_gettimex64() - PTP clock gettimex64 op
> > + *
> 
> Hi Peter,
> 
> Tooling recognises this as a kernel doc, and complains
> that there is no documentation present for the function's
> parameters: ptp, ts, and sts.
> 
> Flagged by W=1 builds.
> 

Thanks, I will change the offending documentation to non kernel-doc. I
was not aware that these warnings are always considered a problem.

Peter

> > + * Context: Process context.
> > + */
> > +static int viortc_ptp_gettimex64(struct ptp_clock_info *ptp,
> > +				 struct timespec64 *ts,
> > +				 struct ptp_system_timestamp *sts)
> 
> ...

