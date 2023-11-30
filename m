Return-Path: <netdev+bounces-52512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0F7FEFA1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC73B20DB1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF33B2B1;
	Thu, 30 Nov 2023 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GP6zozQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E681B10D9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:59:24 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU8N5k6009367;
	Thu, 30 Nov 2023 04:59:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=kwIq0vHm4oTM/M7v6rYyes9XUY3JqyOQwmRqCYaqDWQ=;
 b=GP6zozQ9Ut7wCpe8El/XhfemLlZxP+nXs0AOuJPN78SNbsG9cbzws8TMpzzvqRYTI/Tv
 5SlB36YhqwkMS3q9xUFETVRYksKBcWj9++bGZ4HSl5MWof0dvXxtwoldXXQcJSKVabAA
 ocMxAPlQy7/wQloaYG58bU4/JdB9u8KyaFkl2AnW3m3cFuxEDbTSCmHxjnXxoLDtj9vJ
 TPzRLl6dp2bqRBd7XA1wr4NNPnd8QvgfGNPmTXE06g4iqZFpj/XXaIzz1sYI/TMt4i1b
 SbYcs3FF8NaO06YDkXSBtJchxve/uQzn5qJbJn2rmXPTLxW1VUwP4fA5JSIxdMW8nJ0X Ew== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uppu094uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 04:59:17 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 30 Nov
 2023 04:59:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 30 Nov 2023 04:59:16 -0800
Received: from [10.9.8.90] (OBi302.marvell.com [10.9.8.90])
	by maili.marvell.com (Postfix) with ESMTP id F19753F705E;
	Thu, 30 Nov 2023 04:59:14 -0800 (PST)
Message-ID: <262161b7-9ba9-a68c-845e-2373f58293be@marvell.com>
Date: Thu, 30 Nov 2023 13:59:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
To: Jakub Kicinski <kuba@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Netdev
	<netdev@vger.kernel.org>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
 <20231127145945.0d8120fb@kernel.org>
 <9852ab3e-52ce-d55a-8227-c22f6294c61a@marvell.com>
 <20231128130951.577af80b@kernel.org>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <20231128130951.577af80b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pekD__fYOQT6pss-tJf7WBLow4S7M9ke
X-Proofpoint-ORIG-GUID: pekD__fYOQT6pss-tJf7WBLow4S7M9ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_11,2023-11-30_01,2023-05-22_02



On 11/28/2023 10:09 PM, Jakub Kicinski wrote:
> 
> For Rx under load larger rings are sometimes useful to avoid drops.
> But your Tx rings are larger than Rx, which is a bit odd.

Agree. Just looked into the history, and it looks like this size was chosen
since the very first commit of this driver.

> I was going to say that with BQL enabled you're very unlikely to ever
> use much of the 4k Tx ring, anyway. But you don't have BQL support :S
> 
> My free advice is to recheck you really need these sizes and implement
> BQL :)

Thanks for the hint, will consider this.

Regards
  Igor

