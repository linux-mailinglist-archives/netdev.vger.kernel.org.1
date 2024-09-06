Return-Path: <netdev+bounces-126122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818796FE88
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84CA284489
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6415B0F8;
	Fri,  6 Sep 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="OvUvdNWI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9715B546;
	Fri,  6 Sep 2024 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665926; cv=none; b=RghKBBl0dgCimyyyfzfEsYk2xaWpdnsUD+Oe29ALZP7fGhHXbneVRcA9yC3Imfklwm5BVgUpwFpA65lm5vJujuWW/Nan27F7PfWnevcrDpcG1rkOSpyGwAqh64PzZGs2U+uEfHpLHDQVpE2+pby6RGndc663CS9vZ37AnQWi4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665926; c=relaxed/simple;
	bh=Ekkdq5gLv9Vi/s9zwnhxna+9KYd14k5UvdxW80ID0GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUDqMMgoPyocz2VgXE8BJuBy65EVmY00dubjrUxT5O5WEQhEJuwzexrIhCtMeNviY2B6X/gVM44sXsV1Xc/A6hei44008NTUUjkjqM7/p2mqp+9Av4mxROx9xS4fZoP4Ws+h6LXYPEGDiUM+iEh4WgeKbciHOamct/YIYMt/HSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=OvUvdNWI; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486Dujg1018852;
	Sat, 7 Sep 2024 00:17:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=Sa8FsJ1g0jNIiY7XT136rfT0smOpE9h3wS97TK9K/3k=; b=OvUvdNWI5lO5
	vZPpXhVorhahY+LdpjJnP2PoXGEFESXYkn3WF30fLbC27XPtUTvXM6rbkoIlDYPs
	P+OIHwuyjg5LonLvDXwLQnaTqJgRrEqmi3ZWKQvCC8PUeXDUalyJUMrLJqibOu7s
	Mc32uY01wj0gdy3wHvOXUw5jhkHWd8WvEgK7uClhT2uw11RVJfoumlz6gPvio1vE
	7/jtWqDxjz5+5L7tvitypTPlvmrk5iiV3eG0QtAhLAZksM/P0szNSjEqmPWGE/e8
	7Vpp18YxpqTmeJVqbh82A9CrN61VmG8GTw+sWM5unf0NACx2KENR6qglDSe84/xU
	4HZSbyZAKg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 41fhymrg31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Sep 2024 00:17:03 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 486JcKxj010010;
	Fri, 6 Sep 2024 19:17:01 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 41fj2pxxk4-1;
	Fri, 06 Sep 2024 19:17:01 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com [172.27.97.51])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 7D43E3407C;
	Fri,  6 Sep 2024 23:16:59 +0000 (GMT)
Message-ID: <2d4bc830-0759-41c1-ad83-10413150152f@akamai.com>
Date: Fri, 6 Sep 2024 16:16:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240823033444.1257321-1-johunt@akamai.com>
 <20240823033444.1257321-2-johunt@akamai.com>
 <CANn89iJ7uOFshDP_VE=OSKqkw_2=9iuRpHNUV_kzHhP-Xh2icg@mail.gmail.com>
Content-Language: en-US
From: Josh Hunt <johunt@akamai.com>
In-Reply-To: <CANn89iJ7uOFshDP_VE=OSKqkw_2=9iuRpHNUV_kzHhP-Xh2icg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_07,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=987 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409060172
X-Proofpoint-GUID: YaCRuc33yKehw2lXVBpGy2RH7jytVl7O
X-Proofpoint-ORIG-GUID: YaCRuc33yKehw2lXVBpGy2RH7jytVl7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_08,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 mlxlogscore=790 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060173

On 8/22/24 11:55 PM, Eric Dumazet wrote:
> On Fri, Aug 23, 2024 at 5:34 AM Josh Hunt <johunt@akamai.com> wrote:
>>
>> There have been multiple occassions where we have crashed in this path
>> because packets_out suggested there were packets on the write or retransmit
>> queues, but in fact there weren't leading to a NULL skb being dereferenced.
>> While we should fix that root cause we should also just make sure the skb
>> is not NULL before dereferencing it. Also add a warn once here to capture
>> some information if/when the problem case is hit again.
>>
>> Signed-off-by: Josh Hunt <johunt@akamai.com>
> 
> Hi Josh
> 
> We do not want a patch series of one patch, with the stack trace in
> the cover letter.
> Please send a standalone patch, with all the information in its changelog.
> 
> 1) Add Neal Cardwell in the CC list.

Sending v2 now with Neal included.

> 
> 2) Are you using TCP_REPAIR by any chance ?
> 

No, we're not using TCP_REPAIR on these machines.

> 3) Please double check your kernel has these fixes.
> 
> commit 1f85e6267caca44b30c54711652b0726fadbb131    tcp: do not send
> empty skb from tcp_write_xmit()
> commit 0c175da7b0378445f5ef53904247cfbfb87e0b78     tcp: prohibit
> TCP_REPAIR_OPTIONS if data was already sent
> 

We have the first commit, but not the second.

Josh

