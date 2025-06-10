Return-Path: <netdev+bounces-196393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60648AD471A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CB83A6677
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2903E26E705;
	Tue, 10 Jun 2025 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="nkq5m1U3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD52D5401
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599705; cv=none; b=hFSk0CUI2KGoX4GPxxXOJ8zPshaHXaTp20a1V6LQmLXA86H3/YH4UyTUYtYfYhXp+ewh577QStx1W/oRetdlMv3gFwFqEUvu4qK7PtNtPe+e29GPJydVJp4Ic4hP8Bpx0kksFieSmG1AvxkLC5IkTUHpXkID1TzPo29UvIFvFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599705; c=relaxed/simple;
	bh=jM17vFW3kW+WET6Ch4H8YCZ0fSNhcbjdrwSf4X+6vCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/VJYtd4ltyBbEltlpXFcmAqdVDeOHjag9OhsrzS8gpaXGlW8VkGFq2cjdKItW3hkAUbMztYLl59PJ2GRGqoQ3S6s64ng6IK0XlovWedTQspClUcjmZqOuRBXdqW9Wu+IJQt7KSr2h02UITsHCFC/lpO2UgHzCQx4G11yLl9+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=nkq5m1U3; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 55AMnvJR021918;
	Wed, 11 Jun 2025 00:36:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=cvvvyRD8r4TxcqfxWlv0dsqPHQyAxa1aFFuQB6ytzFQ=; b=nkq5m1U3jeMU
	8i8EeHzW0r/82av6ABEJ/vEE/S3Ir9LS7B1fApwiiHIdRF8qIR6YYBXHheEgfAIT
	RjvetYUifWxmFEUzVL1LuHAJstnvGTPgLoTMbDnmsxausGaQ26n1qSnSttlJmdqt
	jjfgtiCoYAfAbO+iBdgem6nvSG1JP5XMy4YsgaqZ+nhEPxe1A+HpcoeXIdYfda7E
	IWn4kFSttyyuB50u8mFN+FOtFJ8X5X+2QCzBLISApVslZulsS0LejZLJs0N5NW/3
	xRfn9hf8Qglzq2KlmH3DmPnTxNTF9N3qJzsda+R66o+MA7oMHJLNh/+kzW4MMOcU
	9W7Z/gocjQ==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 475h7m97re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 00:36:02 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 55AHwnA8009315;
	Tue, 10 Jun 2025 19:36:01 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 474gs8xj5t-1;
	Tue, 10 Jun 2025 19:36:01 -0400
Received: from [172.19.0.43] (unknown [172.19.0.43])
	by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 9230B63629;
	Tue, 10 Jun 2025 23:36:00 +0000 (GMT)
Message-ID: <f7c398f4-ea06-495c-b310-cae3c731cb4b@akamai.com>
Date: Tue, 10 Jun 2025 19:36:00 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netlink: Fix wraparounds of sk->sk_rmem_alloc
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com
References: <20250609161244.3591029-1-jbaron@akamai.com>
 <20250610160946.10b5fb7d@kernel.org>
Content-Language: en-US
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <20250610160946.10b5fb7d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_11,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100195
X-Proofpoint-ORIG-GUID: raqfYNMOkTi5ieM6bQ3ncjzWwkC02L54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE5NSBTYWx0ZWRfX5wvPHjuc991E
 5BZnp4G2tXWbSCBNjApNU33AcEB/cFethtb9mSPsEoTIVUJl5gkG8+PGBFldZV4steTnLxyKZTF
 hO+nTblCAQSzUnHmE1GosA/vNV7JqhH16Z/r7szlWSHqlPpQbBGmWLg1Z9tcM5jOvBtwDhe7oHx
 Ssk9xBRMieY+T9qwGEZnZjYcyzq4i0OQSWZOej2WFCUs1G4HQKMCaIZlW9mPjSgGQiQ1AQiWsXS
 XsYm4mI6h5FfN7BSbToL24ugvNNeBfaxXgWmoD16n6znUxqQhsRUyCFqkUBCHb+OsYnaMu2J7CX
 dCvCXw+U+zcYvsCpWlgd9zT88L4ItNzUv7jcg1kHFJuPllR9RC3lZKMbZr25zS8KR44v+URPv7b
 fwoLv3BBquXcG6gw+oBnAQjlJKFmevrnVXIb7+Ir0w4habZYJD1sQPUtWmG+NuFvidEpirPi
X-Authority-Analysis: v=2.4 cv=bt9MBFai c=1 sm=1 tr=0 ts=6848c162 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Sl0ZkJ6P1igRQq4LizkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: raqfYNMOkTi5ieM6bQ3ncjzWwkC02L54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_11,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=848
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100195



On 6/10/25 7:09 PM, Jakub Kicinski wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> On Mon,  9 Jun 2025 12:12:44 -0400 Jason Baron wrote:
>> As noted in that fix, if there are multiple threads writing to a
>> netlink socket it's possible to slightly exceed rcvbuf value. But as
>> noted this avoids an expensive 'atomic_add_return()' for the common
>> case. I've confirmed that with the fix the modified program from
>> SOCK_DIAG(7) can no longer fill memory and the sk->sk_rcvbuf limit
>> is enforced.
> 
> Looks good in general, could you add a Fixes tag?

Sure I can add this for v2.

> A few coding style nit picks..
> 
>> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
>> index e8972a857e51..607e5d72de39 100644
>> --- a/net/netlink/af_netlink.c
>> +++ b/net/netlink/af_netlink.c
>> @@ -1213,11 +1213,15 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
>>   		      long *timeo, struct sock *ssk)
>>   {
>>   	struct netlink_sock *nlk;
>> +	unsigned int rmem, rcvbuf, size;
> 
> Please try to short variable declaration lines longest to shortest
> 

ok sure, will fix for v2.

>>   	nlk = nlk_sk(sk);
>> +	rmem = atomic_read(&sk->sk_rmem_alloc);
>> +	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
>> +	size = skb->truesize;
> 
> I don't see a reason to store skb->truesize to a temp variable, is
> there one?


I only stored skb->truesize to 'size' in the first bit of the patch 
where skb->truesize is not re-read and used a 2nd time. The other cases 
I did use skb->truesize. So if you'd prefer skb->truesize twice even in 
this first case, let me know and I can update it.

> 
> Actually rcvbuf gets re-read every time, we probably don't need a temp
> for it either. Just rmem to shorten the lines.
> 
>> -	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
>> -	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
>> +	if (((rmem + size) > rcvbuf) ||
> 
> too many brackets:
> 
> 	if (rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf) ||
>

So the local variables function to type cast sk->sk_rmem_alloc and 
sk->sk_rcvbuf to 'unsigned int' instead of their native type of 'int'. I 
did that so that the comparison was all among the same types and didn't 
have messy explicit casts to avoid potential compiler warnings. It 
seemed more consistent with the style of the below patch I referenced in 
the commit:

5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")


Thanks,

-Jason

> would be just fine.
> 
> Similar comments apply to other conditions.

