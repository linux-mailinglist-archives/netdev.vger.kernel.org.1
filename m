Return-Path: <netdev+bounces-198139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A3ADB5E4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C5117427D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65233265286;
	Mon, 16 Jun 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dTUPR73E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8C263C9B;
	Mon, 16 Jun 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089115; cv=none; b=ge9zHnHjRXzsrpHAJ0SKikvpCelqQqrqICnORy7G2OjqAfBWBrPnMMb4YJrtsPVeTA4wXp862ZL0xL9DxLSnofEe/yLTNC7EXA7m2f93KYlwyotxezROOr/WyW6vTAJxVX6K7b0AiMkasrCxKetl8C82XqUgCOCLYryyLX1LWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089115; c=relaxed/simple;
	bh=YseFtmXDi554Cdo4z4Avx8hpjypNZzIQz2GGROAIBGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dM+4qW4gqaw4GPVc6nQ/1+dZuYWz59i/5GtmZbWElm4colwklFsoD/p6G5YG7MTc/DLcdJQLbBrtE0LV/a/yn3jxq7Sqi9di2JpF9HfOzmEo2VrJhmgB5m8d+tQbLhACQn45pXX4OMEF168ewaQB57XvrN4b4Pe67boJJ7cwEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dTUPR73E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCMGum028058;
	Mon, 16 Jun 2025 15:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZXAqwNs+BmvglevjdpdzR5FyKl5vU3
	UcJ4tKtauv7+Q=; b=dTUPR73EZstATk5Xe8x5JyOiaRDnUUwd1TmddGhB8x4OfL
	yEwE0RNXvWq07vm/ZfgR1gwvNBLsd5X2o565ym48KOz5XiZmludx3pC9xQWzzv5k
	yZKblAiuITH/m12bsz9bhwXuBf3SjlLuWwQLdJtJ/Sh81seFp0vEDXZuLi/lsY+f
	XcxMK2gDrhsoYPlUUhtFsHlFPjIQqY7TOTFB1zkylwFhd6REs1uj8uPW18SR8aPk
	5zhCvY0kDevN4G7eZdKvMkeYK+oo5A86t8nUwK14hVw9dxwdymqRDPnKI1xkBuC9
	FNF17lvZPo3OEcf9x0vL0o8eio8UuO14zHPoky2Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r1thc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 15:51:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GFkXBu006511;
	Mon, 16 Jun 2025 15:51:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r1thc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 15:51:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GDgiSw025751;
	Mon, 16 Jun 2025 15:51:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5mxtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 15:51:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GFpftI13959696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 15:51:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 561B258054;
	Mon, 16 Jun 2025 15:51:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB9B55803F;
	Mon, 16 Jun 2025 15:51:40 +0000 (GMT)
Received: from d.ibm.com (unknown [9.61.172.143])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Jun 2025 15:51:40 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Joe Damato <joe@dama.to>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2] Fixed typo in netdevsim documentation
In-Reply-To: <aFA2c96O-VFXms3G@MacBook-Air.local> (Joe Damato's message of
	"Mon, 16 Jun 2025 18:21:23 +0300")
References: <20250613-netdevsim-typo-fix-v2-1-d4e90aff3f2f@linux.ibm.com>
	<aFA1seeltkOQROVn@MacBook-Air.local>
	<aFA2c96O-VFXms3G@MacBook-Air.local>
Date: Mon, 16 Jun 2025 10:51:40 -0500
Message-ID: <87msa77khf.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LJ9S5Ezd8eSu0Hxm2EG1ge3DWyKJLeGx
X-Proofpoint-ORIG-GUID: pGRXzdVMEzl4AROrX2vT8ZluptUBpSQq
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=68503d8f cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=E2WpO-MOJeG5IbnZ2i8A:9 a=q1B5Xg1zIbEA:10 a=5xguyzxG5YgA:10
 a=uq99_h5TRGwA:10 a=WT8JI4QBAcwA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwMiBTYWx0ZWRfX4RmzJQPuPaSB wRaqGa1pcT9eAr3VON9dOVixUsZBrZbKTtWQjfiQo95NtilCfDHTqhM45JsKhgpQdsNp1EaRvld PPUzQT546ZOM+MyCAjIqmfpKQikZ5cKA7kKIIzJfnQ2woD6UwPBIrO1y9gwEkJB/7EGsGKrBwN5
 iFyLaRuNfOmcVqijYyHijv+sxI3IKI3lcCb8dPwRecLpnJ/e2XyghPix/YSCOGsn8ZmTLc8Hg9q 7wE/DBTDPOeUCjHIT84rau9nOjXx1xwun4jegOlmqENnYim3D5KswxeTB0ckdtlb8NY5kwOyR/5 UnsLXzHhtdxWk6OwrL2Byd+JB6yiGCsbHcgX2sUr6yDPKpbCH+YC3cLRt9qFk41Lvw3pFyHUQxH
 rGfnOXl6hZ0lwAO8wwCds51oXGvvm4uI9eg7VY4sGpixO+/XSJmRJ3EpFpI7MvT31vZU3/lL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=645 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160102

Joe Damato <joe@dama.to> writes:

> On Mon, Jun 16, 2025 at 06:18:09PM +0300, Joe Damato wrote:
>> On Fri, Jun 13, 2025 at 11:02:23AM -0500, Dave Marquardt wrote:
>> > Fixed a typographical error in "Rate objects" section
>> > 
>> > Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
>> > ---
>> > - Fixed typographical error in "Rate objects" section
>> > - Spell checked netdevsim.rst and found no additional errors
>> > -
>> > ---
>> >  Documentation/networking/devlink/netdevsim.rst | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> For future reference, since Breno gave a Reviewed-by for the last patch [1],
>> you could have included his tag since there were no substantive changes.
>> 
>> In any case:
>> 
>> Reviewed-by: Joe Damato <joe@dama.to>
>
> On second thought... this should target net-next (not net) and should also CC Breno.
>
> Have a look at:
>
>   https://www.kernel.org/doc/html/v5.16/process/submitting-patches.html
>
>   and
>
>   https://www.kernel.org/doc/html/v5.16/networking/netdev-FAQ.html

Thanks. I'll send another update shortly.

-Dave

