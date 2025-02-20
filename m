Return-Path: <netdev+bounces-168305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB391A3E70F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA31B7A772C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C22139D4;
	Thu, 20 Feb 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RaxGLlPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1D1EA7ED;
	Thu, 20 Feb 2025 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088604; cv=none; b=OBsdKhv09G7ndTav0WsuMIuULdzw9Gmb9wq+S0Ajs4T9jnt5RTdCYNqZrVo2P2uudlbNoj1lBuaBHYov7CRw8/Qc1+jx3HbE4qZO9FJR4fJw/0Q8oCWwaQYP9MxRVolzoTlUGdU/S5BUxIm6VvwGYpIYUbJMa4a74GBi8GmUh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088604; c=relaxed/simple;
	bh=NgXi3k8EurFo9t3HtW8WwmdbHh4JVvPvXucxX0SnMVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCOqBUauX5p1TgkKxdJW4Sw/LOAhp4w9znFi4BN0DlKr/Szk1Dr7qDSgqSUzmwNoHqpZwkcDNlHmdJQwmcjTx/UvsOpFWywf/9YyviNSi6WLgZEVZyqXkm+NQ4tyyBfAT7vUEhw/mXdYcNRGibgx0ud1Wh0HZkQZLx8P3l81b4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RaxGLlPJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1dH5013262;
	Thu, 20 Feb 2025 21:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GV/4q+R7qAkeiX0geZwC46YFoAro9g
	Zl3LVIu0Cwaxc=; b=RaxGLlPJ4Cq+aiQbGc2OlWta4xV5y7SNkHjHZo9s1pvygA
	C8dnh9sQ2EM55LnmuZQ+iAvNkviKntkpPS1NYAHHywN0jmgN7MOoJRIWlYOYymJZ
	Cw3EassRc6of89Q8afP0PdCkf7yYIiiG+Nx+wFdM/cbIJEqNKedtTEzbBk6pPbsh
	eglz/lrKbf1JzJt6/xOQhmJK+1sI5NV27W+lcW3Kdfjm3ifJ+cjpM6g+dxslA6zm
	mLU84dhE9rQiqvZq10n9g9kfzK4ue3fxfc8B6z4F9A86u/H8jYzGZ5xiSYDDJeKU
	xyFRAR0v8CR4OOvFCpedDpEx+3IHrJqoUVyZfeww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wreae4kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:56:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51KLmDNL008578;
	Thu, 20 Feb 2025 21:56:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wreae4kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:56:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLEIKW029288;
	Thu, 20 Feb 2025 21:56:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024mftk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:56:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KLuL4D27656712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 21:56:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3DE15805D;
	Thu, 20 Feb 2025 21:56:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A24355805A;
	Thu, 20 Feb 2025 21:56:22 +0000 (GMT)
Received: from localhost (unknown [9.61.179.202])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 21:56:22 +0000 (GMT)
Date: Thu, 20 Feb 2025 15:56:22 -0600
From: Nick Child <nnac123@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Dave Marquardt <davemarq@linux.ibm.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, nick.child@ibm.com,
        pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 2/3] hexdump: Use for_each macro in
 print_hex_dump
Message-ID: <Z7elBmfBp0CGmgGh@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
 <20250219211102.225324-3-nnac123@linux.ibm.com>
 <875xl5y50q.fsf@linux.ibm.com>
 <4c424cb6-3c2e-47a2-aa75-98fb20d805c9@linux.ibm.com>
 <20250220214118.72f4c2bf@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220214118.72f4c2bf@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JniFXsgpCCpkec6pJE0dFecIKd4B5LHa
X-Proofpoint-GUID: 2iRBNcs4j-01Oq4AIzxOUVSxTM-wM9Tq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=632 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200143

On Thu, Feb 20, 2025 at 09:41:18PM +0000, David Laight wrote:
> On Thu, 20 Feb 2025 09:49:04 -0600
> Nick Child <nnac123@linux.ibm.com> wrote:
> > On 2/19/25 3:54 PM, Dave Marquardt wrote:
> > > Nick Child <nnac123@linux.ibm.com> writes:
> > >  
> > >> diff --git a/lib/hexdump.c b/lib/hexdump.c
> > >> index c3db7c3a7643..181b82dfe40d 100644
> > >> --- a/lib/hexdump.c
> > >> +++ b/lib/hexdump.c
> > >> @@ -263,19 +263,14 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
> > >>   		    const void *buf, size_t len, bool ascii)
> > >>   {
> > >> -	for (i = 0; i < len; i += rowsize) {
> > >> -		linelen = min(remaining, rowsize);
> > >> -		remaining -= rowsize;
> > >> -
> > >> -		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> > >> -				   linebuf, sizeof(linebuf), ascii);
> > >> -
> > >> +	for_each_line_in_hex_dump(i, rowsize, linebuf, sizeof(linebuf),
> > >> +				  groupsize, buf, len) {  
> > > Several callers of print_hex_dump pass true for the ascii parameter,
> > > which gets passed along to hex_dump_to_buffer. But you ignore it in
> > > for_each_line_in_hex_dump and always use false:
> > >
> > > + #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, groupsize, \
> > > +				   buf, len) \
> > > +	for ((i) = 0;							\
> > > +	     (i) < (len) &&						\
> > > +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> > > +				(len) - (i), (rowsize), (groupsize),	\
> > > +				(linebuf), (linebuflen), false);	\
> > > +	     (i) += (rowsize) == 32 ? 32 : 16				\
> > > +	    )
> > >
> > > Is this behavior change intended?
> > >
> > > -Dave  
> > 
> > Yes, for simplicity, I wanted to limit the number of parameters that the 
> > macro had.
> > 
> > Since the function does not do any printing, the user can do ascii 
> > conversion on their own
> > 
> > or even easier just ensure a \NULL term and print the string with the %s 
> > format specifier.
> 
> That just isn't the same.
> The hexdump code 'sanitises' the string for you.
> 

I see now, I forgot about print_hex_dump's use of
for_each_line_in_hexdump in my response the morning. Yes the
ascii argument needs to be respected and this patch forces
false, this is an oversight on my end, thanks for pointing it out.

I will address this issue in the next version by passing the ascii
argument into the for_each loop. Will wait a few weeks before sending
this time.

- Nick

