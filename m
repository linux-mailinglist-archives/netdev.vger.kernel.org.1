Return-Path: <netdev+bounces-168633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7B8A3FF10
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D08418904EE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4599250BE9;
	Fri, 21 Feb 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tZsY028A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895F1D7E50;
	Fri, 21 Feb 2025 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163871; cv=none; b=CeA2Hh+nchK1UjT1AncRAhPNFxMBQ5Eri+6SCG39B5SmM06JqS2umSGFFPNM1tAA4/y/HEordfyAGKwpN/3thnKrH/jZ/xhEa/iXy7r637Y/Tm+6AlSEBGLRakJ0y9aygVtkWdpwZdpEqMTZ3pP1ZypJkiSY21YzfuEzLf4B1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163871; c=relaxed/simple;
	bh=LodTY/332Fl0l4DFbxlso3z+UePgU5j/5ZLkT5bhTlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USCrTTFyEDXpBDqkvlvwSB6wqmAKc5onWDN/qkGB4WVhabYYKmWvWxa9b9Sy9/0TxBMS1sKps9K1smdQGQaP+hGBMgMcaMRKeSJbse32ruSLT3ieKQbf9HdAPo/N+mDsFPi4Y9V3PT6+4o7f6CN7iJ6yBkREiIdiLV2lHC+RmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tZsY028A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMdxC011285;
	Fri, 21 Feb 2025 18:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6DvnguiOhPBQ5H10XYNeLZ2kDHi226
	rXlvIDNRqU+WA=; b=tZsY028A7ATbpn4bMc41SzQ27AqaPpGZA10DKEk+Bv8WEQ
	JBe8kNVkW9RxuUQO66XSwah5Sd9wyvRrxVYe67sv1W1PiY10m9vUtrVkE5ac2wEd
	OB6q7kutiDl2uvJZiYQJT2B/iFmsh9ELrIV44mKeljZbPsoMXfpVgX8pOmy29NkA
	wyDxmssH0yQ/Pz7AUeXIwhvivRdS9DOLT16OQqfb4b9jgi/nY0FWti6v1ayxofBC
	yd+iFM/BkqHaRxwbmCt9LwhwNUiW28xkUGv0hAAwvqgIFqACsXH8c91XsRn7KUxg
	rRXt6R/RxqAly1QpKwJCnBZxy7ATLh3TEDB0VUyA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xdhawawv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 18:51:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51LIp1aV006490;
	Fri, 21 Feb 2025 18:51:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xdhawaws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 18:51:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIeFE6002336;
	Fri, 21 Feb 2025 18:51:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xhk6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 18:51:00 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LIoxB932506522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 18:50:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB9655805E;
	Fri, 21 Feb 2025 18:50:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A78275805A;
	Fri, 21 Feb 2025 18:50:59 +0000 (GMT)
Received: from localhost (unknown [9.61.179.202])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 18:50:59 +0000 (GMT)
Date: Fri, 21 Feb 2025 12:50:59 -0600
From: Nick Child <nnac123@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
        nick.child@ibm.com, pmladek@suse.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 1/3] hexdump: Implement macro for converting
 large buffers
Message-ID: <Z7jLE-GKWPPn-cBT@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
 <20250219211102.225324-2-nnac123@linux.ibm.com>
 <20250220220050.61aa504d@pumpkin>
 <Z7i56s7jwc_y0cIz@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
 <20250221180435.4bbf8c8f@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221180435.4bbf8c8f@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0nfw2xw5-eDdb3k506j578CAqn5DICbs
X-Proofpoint-ORIG-GUID: Bam3hKZSnKKtACOhGfV-xk9y4bnMqWGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=981 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210128

On Fri, Feb 21, 2025 at 06:04:35PM +0000, David Laight wrote:
> On Fri, 21 Feb 2025 11:37:46 -0600
> Nick Child <nnac123@linux.ibm.com> wrote:
> > On Thu, Feb 20, 2025 at 10:00:50PM +0000, David Laight wrote:
> > > You could do:
> > > #define for_each_line_in_hex_dump(buf_offset, rowsize, linebuf, linebuflen, groupsize, buf, len, ascii) \
> > > for (unsigned int _offset = 0, _rowsize = (rowsize), _len = (len); \
> > > 	((offset) = _offset) < _len && (hex_dump_to_buffer((const char *)(buf) + _offset, _len - _offset, \
>           ^ needs to be buf_offset.
> 
> > > 		_rowsize, (groupsize), (linebuf), (linebuflen), (ascii)), 1); \
> > > 	_offset += _rowsize )
> > > 
> > > (Assuming I've not mistyped it.)
> > >   
> >
> > Trying to understand the reasoning for declaring new tmp variables;
> > Is this to prevent the values from changing in the body of the loop?
>
> No, it is to prevent side-effects happening more than once.
> Think about what would happen if someone passed 'foo -= 4' for len.
>

If we are protecting against those cases then linebuf, linebuflen,
groupsize and ascii should also be stored into tmp variables since they
are referenced in the loop conditional every iteration.
At which point the loop becomes too messy IMO.
Are any other for_each implementations taking these precautions?

Not trying to come off dismissive, I genuinely appreciate all the
insight, trying to learn more for next time.

> > I tried to avoid declaring new vars in this design because I thought it
> > would recive pushback due to possible name collision and variable
> > declaration inside for loop initializer.
>
> The c std level got upped recently to allow declarations inside loops.
> Usually for a 'loop iterator' - but I think you needed that to be
> exposed outsize the loop.
> (Otherwise you don't need _offset and buf_offset.
>

As in decrementing _len and increasing a _buf var rather than tracking
offset?
I don't really care for exposing the offset, during design I figured
some caller may make use of it but I think it is worth removing to reduce
the number of arguments.

Thanks again,
Nick

