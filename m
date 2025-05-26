Return-Path: <netdev+bounces-193397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F38AC3C77
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A6B17554B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278181A2622;
	Mon, 26 May 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FzCA+JDg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634ABA2D;
	Mon, 26 May 2025 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250933; cv=none; b=r97M7P/KYrjjIps6UQWdumjPhJ77ZqeIOSYroIKNA4QVb17eLH93QZFxHdl9gjNc/Md6nDISvXIFrqIWC4bn6NGYjsxZFnnuAQSFqWR2Fd7j9cTo1keWPQ6jF+0/wncS6p4IFhot9VD4hx1DDWKEek9TOoaHrda5XaS/2o+vlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250933; c=relaxed/simple;
	bh=RcV0qtMVDeWuRTQZCyCWKIuHoaHolysHZXhbzn702yk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qacSzr1X93sGqAWC6aJdxDe16fghGcTxtbQEjiMH8sUPgEIS9R2FPQVi9D6nD4AlNAmhb/Byk+9FJNZikLxD/3PEQOahomn5cPp9IDTaqAlenPGybOBh9jwwDn7BeOtaReK9aTZ0AdYx7a5wQw6tFtEKxnHZ/pYJUcKwI73occY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FzCA+JDg; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q1D5PU028926;
	Mon, 26 May 2025 02:15:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=77kYee0Z5IdZcMXbAYyH3uUjY
	FG8JhyjDjN8zCwtD1Y=; b=FzCA+JDgKQj2rBQeRhpjpbcSOXdr2I1s/Hf9acqHr
	SQRhfCPzZQ7LGjgZaRCdDJ0iT2iCZFDzW6At4pGaEHL5Tc3K27LgD5cYhYSJLSMa
	kGn1CBPoGxKugPVRISmW6cVxh+uGkryZ9keOr0ISVtODwyeGuXC9bwfJap/AAqZ3
	w2EL8WKK6dQM7NYzQpkMXAmgi3PZkT2oNmiTDXoAIJ1bNM32xRmzqzPYgUB0WPK6
	F5xWF1aBukcY+Q9qQiuS2KbErxVxTlIEygDoYVOfoemld8ZldWFyDAQZC0gBTr4h
	6R5BNh61vXaNC7wCbLF/subf9hAI017eTpY+yizhB3s4w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebgr00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 02:15:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 02:15:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 02:15:12 -0700
Received: from 928cf0ec7572 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 68F3E3F7063;
	Mon, 26 May 2025 02:15:06 -0700 (PDT)
Date: Mon, 26 May 2025 09:15:04 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Sai Krishna <saikrishnag@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <morbo@google.com>,
        <justinstitt@google.com>, <llvm@lists.linux.dev>, <horms@kernel.org>
Subject: Re: [net-next PATCH v3 2/2] octeontx2-af: fix compiler warnings
 flagged by Sparse
Message-ID: <aDQxGAxAMRrYHk2-@928cf0ec7572>
References: <20250311182631.3224812-1-saikrishnag@marvell.com>
 <20250311182631.3224812-3-saikrishnag@marvell.com>
 <3bc07f4f-73b4-4d34-98cb-79e84d9f1493@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3bc07f4f-73b4-4d34-98cb-79e84d9f1493@lunn.ch>
X-Proofpoint-ORIG-GUID: -waQTk1gsQhSsnxd1mu0NI2cXCZZEcZP
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68343122 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=jtlm59152YgxJQHRqcEA:9 a=CjuIK1q_8ugA:10 a=quENcT-jsP8hFS3YNsuE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA3OCBTYWx0ZWRfX+uLKSgjLSQhW xoiiOdMvntTlrX7H/j3S24IFPf+9jOlxCXqYt9JN+6/rKGpKcPYnlv3uK1SC8pj+4yBBAvoOqwE 6Eb6asdmCqo6xuQRIbtq5tfUCLChk/F/aTaO3ZVYVNk1GYOZS8A3X9MjcrkFtwyC3J6tEU0kuT6
 gdzzRQ3yG94gDbQeoYkcA2oUuHLfd78QYLUftzykcdo32aEfyuSMVqg+DohXvvCXFN4L23EnEXC XIYtfo7M+2YSH/tF5/+v6qPT+hLBkg6ZoBazwP0f4L0VIZO5toEjv0F3Kcw45uWqFvQkcSUk0QL 5qzBRfsO4B8Gi1XmGuj8NLIh6m9FU8k6Vy5atqx5yvYRwfAiFJyvqmM+uQiw2VIhVUloNDwmcXn
 xtYIt71PW5Y2gFVmruy6WwJaLivtdohQa3Xkx1JLBSrIJBVPPDgLrBLWFp1fCGoWXpmn6h2L
X-Proofpoint-GUID: -waQTk1gsQhSsnxd1mu0NI2cXCZZEcZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_05,2025-05-22_01,2025-03-28_01

On 2025-03-11 at 21:32:12, Andrew Lunn (andrew@lunn.ch) wrote:
> On Tue, Mar 11, 2025 at 11:56:31PM +0530, Sai Krishna wrote:
> > Sparse flagged a number of warnings while typecasting iomem
> > type to required data type.
>  
> > For example, fwdata is just a shared memory data structure used
> > between firmware and kernel, thus remapping and typecasting
> > to required data type may not cause issue.
> 
> This is generally wrong. __iomem is there for a reason. If you are
> removing it, it suggests what you do next with the pointer is wrong.
> 
>     Andrew
Hi Andrew,

Sorry for delay in response. To provide some information, firmware sets
aside some DDR memory region for firmware and kernel communication.
Kernel ioremaps that space and typecasts to fwdata structure and uses it.
Agree that ioremap is for io device's csr space but since we know that it
is not really a register space but DDR we are ioremapping, typecasting
and using it. We assumed __force is there for these kind of exceptions.
Please suggest how to proceed with this. memcpy_fromio can done for fwdata
but this fwdata is NOT read only once structure, firmware keeps updating it in
cases like link speed changes and ethtool eeprom info changes. So everytime
we have to ioremap, memcpy_fromio and iounmap which we want to avoid.

Thanks.
Sundeep
> 
> ---
> pw-bot: cr

