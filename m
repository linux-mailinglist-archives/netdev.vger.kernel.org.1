Return-Path: <netdev+bounces-111855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBDE9339C4
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E021F21F63
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495629445;
	Wed, 17 Jul 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1JoRNOf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5A1BF37
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208133; cv=none; b=fY3el+/FiYZe78IKrNwBtDPALlLo5wdje7NXhXvioaXvhhr0z/7a4n4g6VWpJRQ5bnvBn8oYe4Qv6qZU+LpYRssBGfmK5NLl8hnlBOEfuy3HJ1bDOVrtC0owYZo2keg/ySeKEmuZPgoIRAgtY5QpK3tY/ZoahBC5eg/+6IaQ1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208133; c=relaxed/simple;
	bh=QCyvROuyf6IsO6luuzrD7JhPr+G0eruFBKhtd/KIkic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDmaRIO7I7sE0g3vhtd2BJllINRWj3gKhfsrTlnd/u+wOUTGoshmcZVVRLyMw84XTDZJ84Do6t25o8ZP/qHsu3v/bXxIN2iDb3FCPugzNNj3Hdzv5NSKfgCoxneFyxAXaPNuY6Le5UBIG7GpYNqGj4dfjz+TdbzR7iys/8NaigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1JoRNOf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H90EU7010148;
	Wed, 17 Jul 2024 09:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=x
	tgV+JkwmPAKdFZH1cGdpE/nStqeTjeTAjYcwqhz+jQ=; b=e1JoRNOfMK1rT16ly
	5p6AyMWz5fUL5VjnHdKur/8pTW9MrPnriPMD7vCUF6tiEbvUepjkWmdnASVkikIl
	Peg4V3bASVKNBIr4HJBbQCJnrYhYKW9QsP+1/Kcd0i6L01ovwsqxrysnhnDgBAfo
	xykFFaf+Jsndn1rQ4I/+bPO9iKU7CpYuxKUCk6/6kW05VqKCc/OP6uw7I1Q8d0+r
	7OKP67HYMZ5CSjLtYDMcJIXnRj1gC5dQhmChsBND2KWaXMeH7VOAm6izB203ENl5
	+Cr9vzac+cyB+a+LIy85J5A88EPOIJNcSp57P3j72ZUiBqmhEv6TEZ9s4BjBDeED
	8sGLw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e7uhre1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 09:22:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46H5UPhn009586;
	Wed, 17 Jul 2024 09:22:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmkfjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 09:22:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46H9M0Y154919598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:22:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD78F20043;
	Wed, 17 Jul 2024 09:22:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE7BD20040;
	Wed, 17 Jul 2024 09:22:00 +0000 (GMT)
Received: from [9.171.28.104] (unknown [9.171.28.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jul 2024 09:22:00 +0000 (GMT)
Message-ID: <678590f7-a550-42b7-b8a0-a40eb3313030@linux.ibm.com>
Date: Wed, 17 Jul 2024 11:22:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: drop special comment style
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240716134822.028c84bbd92f.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240716134822.028c84bbd92f.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pH-O6hEhQL8WJEwI4uLqFy_qk9gth0tU
X-Proofpoint-ORIG-GUID: pH-O6hEhQL8WJEwI4uLqFy_qk9gth0tU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_05,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=582 phishscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170067



On 16.07.24 22:48, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As we just discussed (in the room at netdevconf), drop the
> requirement for special comment style for netdev.
> 
> For checkpatch, the general check accepts both right now,
> so simply drop the special request there as well.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  Documentation/process/maintainer-netdev.rst | 17 -----------------
>  scripts/checkpatch.pl                       | 10 ----------
>  2 files changed, 27 deletions(-)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 5e1fcfad1c4c..5a411c52b466 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst


I guess you should also remove the section in 

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 7e768c65aa92..3ccda9f42cfa 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -629,18 +629,6 @@ The preferred style for long (multi-line) comments is:
         * with beginning and ending almost-blank lines.
         */

-For files in net/ and drivers/net/ the preferred style for long (multi-line)
-comments is a little different.
-
-.. code-block:: c
-
-       /* The preferred comment style for files in net/ and drivers/net
-        * looks like this.
-        *
-        * It is nearly the same as the generally preferred comment style,
-        * but there is no initial almost-blank line.
-        */
-
 It's also important to comment data, whether they are basic types or derived
 types.  To this end, use just one data declaration per line (no commas for
 multiple data declarations).  This leaves you room for a small comment on each


