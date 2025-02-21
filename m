Return-Path: <netdev+bounces-168627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368DCA3FD94
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE97162480
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAE12505CE;
	Fri, 21 Feb 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hXIN3Z5O"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C31E9B31;
	Fri, 21 Feb 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159479; cv=none; b=SqkTxrUimJC90bVmm1fizEz/CzHdoRv8ij6Q+RyL9oreC7u1Ce7DYAkPeqRC0ziCGKU9jzhX7qAzF43EAXn7d6x5COKDO+b+9RL3xdr2lxh3qcKSIpHEG5orTfBySu0BDuJz4AlgB2k0T+Ie9jLA6r+Gi7+v4f9Xl/9LIjZMDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159479; c=relaxed/simple;
	bh=wIc0LcJDOs1i48hZA97m2pwA+nhyQVyiw2aP2OkNwEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL7Lv+HEZGCpItVEZy1HTYPqGXmMAc4gr3Nh6W6tcDKA5Tw0nwfEMCAKBA/yN4EoBIPQs/ANBeRMT2efoUK/xijoxvLivkhXbjheL+ufXR0hV72Sx5SyN93KMSjvxAmhyhP+nsUZs+vFNprdVdtn+ouylJ0WmmD9O2GPY5yyG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hXIN3Z5O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LB9LDm001350;
	Fri, 21 Feb 2025 17:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=669DWXN4P39AfzDosqBdxQgy1+JPQG
	AZQsinsyWix10=; b=hXIN3Z5OQhdJBooRXXuRybv72DWfi0kzbRw3tBKXSmyexI
	l/1r0sxqOHQLqTM7omTY0IpqkOHdxY9kMV1dcyuZHujcnmRXWLS8IcmNiki0JXrn
	O85p/x2//JuwQPxAFmbt5hz8VGJ1d1dTlkb3hKMKP59lM0gs5fOvtWwOUvJ0lJXs
	IboyORKLziWRIJBm2//6Kj9re4WKeEszYUzJj74W4WJAWbDFBTkqAhX0rd0Y4IrS
	A+xmuesKCPEQ5DV7VY7qjS7ITCk0lFKlrYqFIl15gZg2ZPzrgeSlkTm6RdMo52Qs
	HbEH0SatpHGDzAWJooa67Cuw3rzyegxO3ousRgdg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xdhaw01a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 17:37:49 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51LHbmpr032575;
	Fri, 21 Feb 2025 17:37:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xdhaw016-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 17:37:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LFZSUF002348;
	Fri, 21 Feb 2025 17:37:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xh906-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 17:37:48 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LHblr828836508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 17:37:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5379858059;
	Fri, 21 Feb 2025 17:37:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 327565804B;
	Fri, 21 Feb 2025 17:37:47 +0000 (GMT)
Received: from localhost (unknown [9.61.179.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 17:37:47 +0000 (GMT)
Date: Fri, 21 Feb 2025 11:37:46 -0600
From: Nick Child <nnac123@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
        nick.child@ibm.com, pmladek@suse.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 1/3] hexdump: Implement macro for converting
 large buffers
Message-ID: <Z7i56s7jwc_y0cIz@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
 <20250219211102.225324-2-nnac123@linux.ibm.com>
 <20250220220050.61aa504d@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220220050.61aa504d@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5xECC4AGJpgVrmjDK2pr7w7ca8IzgKH_
X-Proofpoint-ORIG-GUID: UX1jSzdChIvbnXu7-wKNUaqVzIJJz7xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=927 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210122

Hi David,

On Thu, Feb 20, 2025 at 10:00:50PM +0000, David Laight wrote:
> On Wed, 19 Feb 2025 15:11:00 -0600
> Nick Child <nnac123@linux.ibm.com> wrote:
> 
> > ---
> >  include/linux/printk.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 4217a9f412b2..12e51b1cdca5 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > +				   buf, len) \
> > +	for ((i) = 0;							\
> > +	     (i) < (len) &&						\
> > +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> > +				(len) - (i), (rowsize), (groupsize),	\
> > +				(linebuf), (linebuflen), false);	\
> 
> You can avoid the compiler actually checking the function result
> it you try a bit harder - see below.
> 

This was an extra precaution against infinite loops, breaking when
hex_dump_to_buffer returns 0 when len is 0. Technically this won't happen
since we check i < len first, and increment i by at least 16 (though
your proposal removes the latter assertion). 

My other thought was to check for error case by checking if
the return value was > linebuflen. But I actually prefer the behavior
of continuing with the truncated result.

I think I prefer it how it is rather than completely ignoring it.
Open to other opinons though.

> > +	     (i) += (rowsize) == 32 ? 32 : 16				\
> > +	    )
> 
> If you are doing this as a #define you really shouldn't evaluate the
> arguments more than once.
> I'd also not add more code that relies on the perverse and pointless
> code that enforces rowsize of 16 or 32.
> Maybe document it, but there is no point changing the stride without
> doing the equivalent change to the rowsize passed to hex_dump_to_buffer.
> 

The equivalent conditonal exists in hex_dump_to_buffer so doing it
again seemed unnecessary. I understand your recent patch [1] is trying
to replace the rowsize is 16 or 32 rule with rowsize is a power of 2
and multiple of groupsize. I suppose the most straightforward and
flexible thing the for_each loop can do is to just assume rowsize is
valid.

> You could do:
> #define for_each_line_in_hex_dump(buf_offset, rowsize, linebuf, linebuflen, groupsize, buf, len, ascii) \
> for (unsigned int _offset = 0, _rowsize = (rowsize), _len = (len); \
> 	((offset) = _offset) < _len && (hex_dump_to_buffer((const char *)(buf) + _offset, _len - _offset, \
> 		_rowsize, (groupsize), (linebuf), (linebuflen), (ascii)), 1); \
> 	_offset += _rowsize )
> 
> (Assuming I've not mistyped it.)
> 

Trying to understand the reasoning for declaring new tmp variables;
Is this to prevent the values from changing in the body of the loop?
I tried to avoid declaring new vars in this design because I thought it
would recive pushback due to possible name collision and variable
declaration inside for loop initializer.
I suppose both implementations come with tradeoffs.

> As soon as 'ascii' gets replaced by 'flags' you'll need to pass it through.
> 

Yes, if hex_dump_to_buffer becomes a wrapper around a new function
(which accepts flag arg), I think there is an opportunity for a lot
of confusion to clear up. Old behaviour of hex_dump_to_buffer will be
respected but the underlying function will be more flexible.

Appreciate the review!
- Nick

[1] - https://lore.kernel.org/lkml/20250216201901.161781-1-david.laight.linux@gmail.com/

