Return-Path: <netdev+bounces-232500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D31E6C06097
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B71D189FBDA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC7332B994;
	Fri, 24 Oct 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="s5KqXpOe"
X-Original-To: netdev@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57534319600
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305170; cv=none; b=gA0AEnpKTUrWXpQjMIVp4rfXMrfpGAUimslhDbA3jIsJwtvFtf+GjfHbYsMzfdYP3pH1ErRucIH9iR7o8DGgb4iG8j8fQg/0HA7akhLGkM26+qaWE+igAyqIpofoHd8xjGojdrEnMIdWOXTqPxYuBynPwzl2ek18mv2FRtI7kTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305170; c=relaxed/simple;
	bh=AgYdT7YB2xxwLbJHg3/succLrKYoP/PPcqdqImF3crU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lir1B+Ne2lnQa1SU1QwXmdLb25yO+fAl9ZC42ENqHrQ82yEhTf7F5HHAciIwXqm098oIUTkfdCz/jQX5AWPUyMQ+mbwzzjQL/iPSicVHVlKjxfT7eAIYevk2Dv+1ssiYHyJdU1DuWveTaNI4llib+kwl+B+uA55P+0MWWY7+eNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=s5KqXpOe; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id CEpyvaSACeNqiCFuIv42uv; Fri, 24 Oct 2025 11:24:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id CFu9vPG1MEQP9CFu9vIQjr; Fri, 24 Oct 2025 11:24:21 +0000
X-Authority-Analysis: v=2.4 cv=MpNS63ae c=1 sm=1 tr=0 ts=68fb61ed
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4oHATN8Nx7vVUZJYxp75bA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7T7KSl7uo7wA:10
 a=ejCFXqOAJi88KBG5-skA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PYq2fPB27ReF2cDwOstKi/I5IpH5649wXvX+ugiEd8M=; b=s5KqXpOeJHb5Dr0aEkqViGiPzg
	FQ+rJy88GCviZlxTWIyxFn0xaTPsHJ6pauvVftWGuc1a6ygfq8aOAguhbOD6Ltw2FM+fEtrvpQiR4
	CHBPCrWD7LQK45LyEVpSCEKbgTzlrqBsIKYCxOWI6POPRqb9jicribi6irlSoe9ns8mEdQnxYaLlR
	3g91QUKBEdmlXiFiXImqFFyTwFUw6AvkzO8Vbg9sEfBuG6Y//zKUxbZtub8XqH+auukrkX2kc4Yuu
	fvQdw51LqtwcL20gogfx/ehMRFZ7yttL7mF097A1DI3J9Gn9ayRhKz7b3hrW2Y0lGhyDUK7B6Blip
	jvia2CzQ==;
Received: from [185.134.146.81] (port=60908 helo=[10.35.193.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vCFu8-00000000imq-29tU;
	Fri, 24 Oct 2025 06:24:20 -0500
Message-ID: <949f472c-baca-4c2f-af23-7ba76fff1ddc@embeddedor.com>
Date: Fri, 24 Oct 2025 12:24:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aPdx4iPK4-KIhjFq@kspp> <20251023172518.3f370477@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251023172518.3f370477@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.134.146.81
X-Source-L: No
X-Exim-ID: 1vCFu8-00000000imq-29tU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.35.193.44]) [185.134.146.81]:60908
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE3a1a1yMYLbphz7FVG2V/o/w089nBnyiFYJ54JU6LQ3Z5fSdr+odyU1ZgZjW4wD7A/mCfjVHdFbmqU6kbFkfPEjkxdW7Fm0y3w/dEOnnnekj5/w+M2A
 dlL4DJrKGWdeuPo9+Nns/SXTseoiGQQqUw4OTr2lIN4tKGlrdHKlLxR/ej618TVmtA16ajaZe39tg4QYLGPw2QXb0tafaD1GN54=



On 10/24/25 01:25, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 12:43:30 +0100 Gustavo A. R. Silva wrote:
>>   struct ip_options_data {
>> -	struct ip_options_rcu	opt;
>> -	char			data[40];
>> +	TRAILING_OVERLAP(struct ip_options_rcu, opt, opt.__data,
>> +			 char			data[40];
>> +	);
>>   };
> 
> Is there a way to reserve space for flexible length array on the stack
> without resorting to any magic macros? This struct has total of 5 users.

Not that I know of. That's the reason why we had to implement macros like
TRAILING_OVERLAP(), DEFINE_FLEX(), DEFINE_RAW_FLEX().

Regarding these three macros, the simplest and least intrusive one to use is
actually TRAILING_OVERLAP(), when the flex-array member is not annotated with
the counted_by attribute (otherwise, DEFINE_FLEX() would be preferred).

Of course, the most straightforward alternative is to use fixed-size arrays
if flex arrays are not actually needed.

Thanks
-Gustavo


