Return-Path: <netdev+bounces-167037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4B7A3873C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C388216B76F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339921CA17;
	Mon, 17 Feb 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fMYzlZeB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A2153BE4;
	Mon, 17 Feb 2025 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804986; cv=none; b=aN5S9M+0uuSVcBbERR8WyJC7x2UwUxtgaujV8Fdwd/j81SrJmCsUuGHA8IzQevlX0bztALYqs9pka4/t9pl+JjmNkSJ5P1Ecolaf6F4LP4XaCrSh/pX5qQvZS45RblvcFVThQlmHmP1sb6H6BqU+aEXPcBWcbkWwvOOZtnq5l9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804986; c=relaxed/simple;
	bh=J8Q+ouyUGMJmAIQWvjqhkuaXP2nvzroCE42M6Pt219k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDYJ0g+zlPiDY8SpBI0AmrFVHgmgqAsd5nPgKdNp9nLZmGKMrGu5coTHdX84UFoJNrTyDX3sGSTptMnNzwsGzqripxRvMCVJm44TCD0w3dzS1x98QWxV7mW67DWF0q9bvMNqCLaPiiKkhsACXzdKb5+o2ZpnN2v0xYnqRfdt/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fMYzlZeB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H5POVp000551;
	Mon, 17 Feb 2025 15:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rsGbBDyvPWvIey+H276PvvAAydIWC3
	3Gz/fReaevlwQ=; b=fMYzlZeB6XhR/l/RGfD95AAgjY82DvsfdN5W3L8JCQPI1G
	F3X0kn/wPRHDArHIsynunCkhsdo8FZQHXAaqu4WfbVmZePmSIQAHEIZZLExMTAmJ
	heVvPGLCyVTIyVO4KHSs/ZU828s9MikeCZEpS31B67w4QkDL27eRpNs0gxpUkkAF
	75PQQo+CHGi4w21BQjwMDeSH8+RetcbKCxLK8qYShLvz9rsq0xmKRxtl22wfFIxk
	5sZgBYtJdtlhuf/XwHFCsxzK1eIsFjq6JlxEXN5G2u+nBJzs7qJp/a65cvb/5Bnl
	1OQxkibEiNRlb3vaQPHh/aYqk9WxPWkF35a4kFgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7ttm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 15:09:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51HF9dwQ025781;
	Mon, 17 Feb 2025 15:09:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7ttku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 15:09:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HDUAnl032326;
	Mon, 17 Feb 2025 15:09:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u6rkphs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 15:09:38 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HF9YtM17760608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 15:09:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6979558063;
	Mon, 17 Feb 2025 15:09:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 563A458056;
	Mon, 17 Feb 2025 15:09:34 +0000 (GMT)
Received: from localhost (unknown [9.61.91.157])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Feb 2025 15:09:34 +0000 (GMT)
Date: Mon, 17 Feb 2025 09:09:34 -0600
From: Nick Child <nnac123@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
        nick.child@ibm.com, jacob.e.keller@intel.com
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large buffers
Message-ID: <Z7NRLmcWJFNkyHGN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
 <20250214162436.241359-2-nnac123@linux.ibm.com>
 <20250215163612.GR1615191@kernel.org>
 <20250215174039.20fbbc42@pumpkin>
 <20250215174635.3640fb28@pumpkin>
 <20250216093204.GZ1615191@kernel.org>
 <20250216112430.29c725c5@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216112430.29c725c5@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mAASe0gVh-_z6flf8QwL2q88tVmvwtbu
X-Proofpoint-ORIG-GUID: YBrXGj0-RBG-NJDkjB0Pja_eQ5z7wPAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 mlxlogscore=400
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170126

Thank you David and Simon for testing and review!

On Sun, Feb 16, 2025 at 11:24:30AM +0000, David Laight wrote:
> 
> I just changed the prototypes (include/linux/printk.h) to make both
> rowsize and groupsize 'unsigned int'.
> The same change in lib/hexdump.c + changing the local 'i, linelen, remaining'
> to unsigned int and it all compiled.
> 
> FWIW that hexdump code is pretty horrid (especially if groupsize != 1).
> 

Given this discussion and my own head-scratching, I think I will take a
closer look at hex_dump_to_buffer.

I was trying to avoid editing this function due the number of callers it
has across the kernel. But I think we can get away with keeping the
API (but change args to uint's) and editing the body of the function
to always iterate byte-by-byte, addding space chars where necessary. At the
cost of a few more cycles, this will allow for more dynamic values
for rowsize and groupsize and shorten the code up a bit. This would also
address the "Side question" in my cover letter. Will send a v3
regardless if I can figure that out or not.

The return value of hex_dump_to_buffer on error still irks me a bit but
I don't think that can easily be changed.

Thanks again!

