Return-Path: <netdev+bounces-168786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780BA40B12
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 19:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A7917E5EB
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 18:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6EF20CCCC;
	Sat, 22 Feb 2025 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dDEtRWaU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D770830;
	Sat, 22 Feb 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740250756; cv=none; b=GcjA7mOuVM9WLhHxxHZ7esS7710JqLINTqO8HZxIs9UT9eW0F6W0YWtC3YKg1KVJ/wYejlcE0iMjZJ3gyAddepdrY3K6SHXgVzIKZ//YRJGA1/MHxhgiJ0ZDlkqJ1x3X/rEglnv6SuduiGi+QCgp4Csn/G9Qcz8ZOHpa75NMUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740250756; c=relaxed/simple;
	bh=a1n8mbonW/ltuhbkEhLcRvyUAwIM2wIPwysaaxQHI2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksx6LP40Yjq9u9V9kZ/n1drmhKJ8KNgE6xYsPM6CPqZ3I68mi26QHlLge2Z6sZutcc3ADubmgC50G1tbnHduI/r1NK/yVy8fEWrhwoU8GS+r2AOr8EcGUxk4tZR8Exxc/CyKTP180bC92EEkiLlDeCChlm8o4M/1z32li/Mms44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dDEtRWaU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M52SrI013794;
	Sat, 22 Feb 2025 18:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6k21L+G3uHD1bwvHi+nq+IxpQx8pcs
	NP5Fah9ageCUA=; b=dDEtRWaU+HcgOPNc9lS47gho4o9SHmWVP0c8dIZqhaGN1I
	7k4uQs3LOmCwOgj/0lpjGEqwJ4O1QlU6CgETGIvweSByWQ3TeS/+CDonxS6uyiOt
	ahLs789skK4HfLP7ByflMOKU+G4sfaxmBEhj8vUdP8+9kycx/cS6PIjvOotIGs8H
	KvLS5XhldPewo+P7qju/OAHkYtqioRsDIS3nkAXJUXTApTTkj5zgSFy96P9YAe3e
	/wru9Su64rP+wsr3KKXcqG43Kxgx/bNUoz7nlJOlawtn4aFFlNegflmWyzviSbua
	+psEHWkuEoSexP8wId+zP85domwZZhHvVM8r2bNw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y82xj62h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 18:58:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51MIt3R8003088;
	Sat, 22 Feb 2025 18:58:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y82xj62f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 18:58:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51MH3HFi002330;
	Sat, 22 Feb 2025 18:58:49 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xpjr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 18:58:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51MIwmul24117930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 18:58:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7F635805A;
	Sat, 22 Feb 2025 18:58:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3C5F5803F;
	Sat, 22 Feb 2025 18:58:48 +0000 (GMT)
Received: from localhost (unknown [9.61.179.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Feb 2025 18:58:48 +0000 (GMT)
Date: Sat, 22 Feb 2025 12:58:48 -0600
From: Nick Child <nnac123@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
        nick.child@ibm.com, pmladek@suse.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 1/3] hexdump: Implement macro for converting
 large buffers
Message-ID: <Z7oeaHxXnwrlA_d9@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
 <20250219211102.225324-2-nnac123@linux.ibm.com>
 <20250220220050.61aa504d@pumpkin>
 <Z7i56s7jwc_y0cIz@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
 <20250221180435.4bbf8c8f@pumpkin>
 <Z7jLE-GKWPPn-cBT@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
 <20250221221815.53455e22@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221221815.53455e22@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LwrSWcezto44dGm5tATOZCL_FqxAnFBf
X-Proofpoint-GUID: oQyAzNcx0SsPvFagp-60dWbHcn75LF3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502220147

On Fri, Feb 21, 2025 at 10:18:15PM +0000, David Laight wrote:
> On Fri, 21 Feb 2025 12:50:59 -0600
> Nick Child <nnac123@linux.ibm.com> wrote:
> 
> > On Fri, Feb 21, 2025 at 06:04:35PM +0000, David Laight wrote:
> > > On Fri, 21 Feb 2025 11:37:46 -0600
> > > Nick Child <nnac123@linux.ibm.com> wrote:  
> > > > On Thu, Feb 20, 2025 at 10:00:50PM +0000, David Laight wrote:  
> > > > > You could do:
> > > > > #define for_each_line_in_hex_dump(buf_offset, rowsize, linebuf, linebuflen, groupsize, buf, len, ascii) \
> > > > > for (unsigned int _offset = 0, _rowsize = (rowsize), _len = (len); \
> > > > > 	((offset) = _offset) < _len && (hex_dump_to_buffer((const char *)(buf) + _offset, _len - _offset, \  
> > >           ^ needs to be buf_offset.
> > >   
> > > > > 		_rowsize, (groupsize), (linebuf), (linebuflen), (ascii)), 1); \
> > > > > 	_offset += _rowsize )
> > > > > 
> > > > > (Assuming I've not mistyped it.)
> > > > >     
> > > >
> > > > Trying to understand the reasoning for declaring new tmp variables;
> > > > Is this to prevent the values from changing in the body of the loop?  
> > >
> > > No, it is to prevent side-effects happening more than once.
> > > Think about what would happen if someone passed 'foo -= 4' for len.
> > >  
> > 
> > If we are protecting against those cases then linebuf, linebuflen,
> > groupsize and ascii should also be stored into tmp variables since they
> > are referenced in the loop conditional every iteration.
> > At which point the loop becomes too messy IMO.
> > Are any other for_each implementations taking these precautions?
> 
> No, it only matters if they appear in the text expansion of the #define
> more than once.

But the operation is still executed more than once when the variable
appears in the loop conditional. This still sounds like the same type
of unexpected behaviour. For example, when I set groupsize = 1 then
invoke for_each_line_in_hex_dump with groupsize *= 2 I get:
[    4.688870][  T145] HD: 0100 0302 0504 0706 0908 0b0a 0d0c 0f0e
[    4.688949][  T145] HD: 13121110 17161514 1b1a1918 1f1e1d1c
[    4.688969][  T145] HD: 2726252423222120 2f2e2d2c2b2a2928
[    4.688983][  T145] HD: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
Similarly if I run with buf: buf += 8:
[    5.019031][  T149] HD: 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16 17
[    5.019057][  T149] HD: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
[    5.019069][  T149] HD: 38 39 3a 3b 3c 3d 3e 3f 98 1a 6a 95 de e6 9a 71
[    5.019081][  T149] HD: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

The operations are getting executed more than once. Should this be
classified as expected behaviour just because those vars are technically
only expanded once in the macro?

> > Not trying to come off dismissive, I genuinely appreciate all the
> > insight, trying to learn more for next time.
> > 
> > > > I tried to avoid declaring new vars in this design because I thought it
> > > > would recive pushback due to possible name collision and variable
> > > > declaration inside for loop initializer.  
> > >
> > > The c std level got upped recently to allow declarations inside loops.
> > > Usually for a 'loop iterator' - but I think you needed that to be
> > > exposed outsize the loop.
> > > (Otherwise you don't need _offset and buf_offset.
> > >  
> > 
> > As in decrementing _len and increasing a _buf var rather than tracking
> > offset?
> > I don't really care for exposing the offset, during design I figured
> > some caller may make use of it but I think it is worth removing to reduce
> > the number of arguments.
> 
> Except the loop body needs it - so it needs to be a caller-defined name,
> even if they don't declare the variable.
> 
> 	David
> 
> > 
> > Thanks again,
> > Nick
> 

