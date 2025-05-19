Return-Path: <netdev+bounces-191402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7086BABB6DD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84422166A8D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7419B269885;
	Mon, 19 May 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ODJS0YEF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB008269816
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642451; cv=none; b=ff/Zzt5OSruKinT9T2U1pAOYc2ekSNTe0BBIaijlvMODkJnG2UboEUEsA0ktKwKzOBUbkFH+Qm3NSPV5JPxB+H3lX7SP3ibB34UI91XZwNzOYvWL/OEQUKsYMQTU6DiJN3wye0bjEB/ZJycO1indW4yum2HaQNUHaRUoZHpqGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642451; c=relaxed/simple;
	bh=gOxGbgsmHnpUiFwbKFSxvd8f+QgEK8bVgQCYIy6oO9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shvaZ6Vm3Ghnul+oNk38M1mCQbNDp/fTphpDEYrdjD6vn+SyIxK8qcOFdUrmnYOHFUlWMvqLDIzHB/Ina+0RzdxEy8QdJ6BpNmWmL/aiFxTkaQH1mHj4DvB8qkoOrSMyHJR/gZCtQAZNRBere+rR0FKf0wX+l74d+GqEk9U19Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ODJS0YEF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J4XwNe014019;
	Mon, 19 May 2025 08:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YN5Qo4FM2hzPhRWkUYDd20g4MjCJ6G
	0NO1Nkb5aQDuI=; b=ODJS0YEFzOAnSHyqTA9eKhtMVutBmx1YKe5vlpc/t7Aw3R
	OCBpQhwlcmO+HTQtuhQwnPYd3zkcNWQUN71MGVFYLQZ+iwPctF9nWoUlR9G2yBqx
	RRsF6Rytg/VXAFPvY5QzChx6mDOa95F1eeyA+FvIqOst1L8VKgg7vw5/cpGOo8pN
	M4rGFlm6fHHiAH0wWEnXBHDy6t/SV1KopRHRHJiadM8uK4RML3/9Jd7LBAkH38xI
	U+4LYSiFsf+tbSNsg4E706UDTj/MVHagF4eFY+Q0ar5tFSIbci0Pc02K55Itf97+
	mS6VYU1F4GGR5Pfe4JnqJEM9I8pHd8+0gtVbrFCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qcrjbrt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 08:07:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54J7aIro018242;
	Mon, 19 May 2025 08:07:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qcrjbrsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 08:07:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54J5gZfb013858;
	Mon, 19 May 2025 08:07:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q4st5uyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 08:07:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54J872JO50266578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:07:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C844200FD;
	Mon, 19 May 2025 08:07:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05D65200F9;
	Mon, 19 May 2025 08:07:01 +0000 (GMT)
Received: from osiris (unknown [9.111.14.133])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 May 2025 08:07:00 +0000 (GMT)
Date: Mon, 19 May 2025 10:06:59 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org
Subject: Re: [PATCH v5 7/7] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250519080659.11601Ae4-hca@linux.ibm.com>
References: <20250513-xattrat-syscall-v5-7-22bb9c6c767f@kernel.org>
 <202505181900.UGh2tVRs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505181900.UGh2tVRs-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 26Z1pXX-huwZjBsBkHZ0El21nYUFp4WM
X-Proofpoint-ORIG-GUID: oahDWnkTyrngXNhvLQcVRFS-MU8VkbKm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA3NiBTYWx0ZWRfXzvz0jPcv3AtG Tlpps7yuyoUsKaYiE4vBdmi79kkM+BjIHIwJXSgtu9IJV7k+TRKIRBWo22tTI57JvFfGOVwn7/5 NtT+9RT1bkp4yFo6iAMhM0CXHPQ+MXfCmhMkYA5kHxD3YdT1Uj+sIlOic80Twej7TchmoOvEEhQ
 d89bgpZu/Cyh/AJWhssj7VpA7+UAarB6DB4z4Ik+lDVcmLDQt5/42UyVjTzIeXQdZrQe1+II0JN Jwjq/I3028b1b3fYmDJQcdS1xbXyCnwBPuLVKQZa2pQCttHRL2dU46QkKYHhqoXdSXMqh7rJPzc lgl7ybJYEWXb8YlA6YeQsXtYEHgOHYWAWm8w4OSwF70xJEk+Zl490uVqctlonvxPjpoAWUAvqfz
 /RsS/9w9tRhG8n6wqLmhUEYkessvjHe/imJzKtag6UYwu+b2PJLZaYd7mYm7xXgpd/lFYYgr
X-Authority-Analysis: v=2.4 cv=RZKQC0tv c=1 sm=1 tr=0 ts=682ae6ab cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8
 a=Xka33dLGCC5fpbZpyycA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190076

On Sun, May 18, 2025 at 07:26:00PM +0800, kernel test robot wrote:
> Hi Andrey,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 0d8d44db295ccad20052d6301ef49ff01fb8ae2d]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Albershteyn/fs-split-fileattr-related-helpers-into-separate-file/20250513-172128
> base:   0d8d44db295ccad20052d6301ef49ff01fb8ae2d
> patch link:    https://lore.kernel.org/r/20250513-xattrat-syscall-v5-7-22bb9c6c767f%40kernel.org
> patch subject: [PATCH v5 7/7] fs: introduce file_getattr and file_setattr syscalls
> config: s390-randconfig-r112-20250518 (https://download.01.org/0day-ci/archive/20250518/202505181900.UGh2tVRs-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 8.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20250518/202505181900.UGh2tVRs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505181900.UGh2tVRs-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> fs/file_attr.c:362:1: sparse: sparse: Using plain integer as NULL pointer
> >> fs/file_attr.c:362:1: sparse: sparse: Using plain integer as NULL pointer
> >> fs/file_attr.c:362:1: sparse: sparse: Using plain integer as NULL pointer
> >> fs/file_attr.c:362:1: sparse: sparse: Using plain integer as NULL pointer
>    fs/file_attr.c:416:1: sparse: sparse: Using plain integer as NULL pointer
>    fs/file_attr.c:416:1: sparse: sparse: Using plain integer as NULL pointer
>    fs/file_attr.c:416:1: sparse: sparse: Using plain integer as NULL pointer
>    fs/file_attr.c:416:1: sparse: sparse: Using plain integer as NULL pointer
> 
> vim +362 fs/file_attr.c
> 
>    361	
>  > 362	SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
>    363			struct fsxattr __user *, ufsx, size_t, usize,
>    364			unsigned int, at_flags)
>    365	{

Please ignore the warning. There is nothing to fix; this is a warning which
happens only with CONFIG_COMPAT and Al's "SC_DELOUSE" macro, which is used for
compat syscalls. Sparse cannot handle that.

