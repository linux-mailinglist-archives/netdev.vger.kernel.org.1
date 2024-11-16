Return-Path: <netdev+bounces-145556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CE29CFD73
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53E9B21B6B
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B5191F7C;
	Sat, 16 Nov 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="UntmjAAj"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059194C8F;
	Sat, 16 Nov 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749126; cv=none; b=S3lJM87W3nCGuG376Lo/Z+8XB0wxWRd+0vY4Fc0sYijfVAvQIqGWoBHpHFWmzp8R0eXEq6n8K70NjXSw7hkzYZysR2buK+SkVEdnWDbUrfH3IgJAnjlmg9OSWn3UHz6HyfWIovlNm6vzhW4Z+YyyM6oa+fZAo2gmQppmGwwScis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749126; c=relaxed/simple;
	bh=Zk1O9SUr1w34Gb7epIOzlc9m2eqC/jwsnWdOWs97jTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHoinpFHwQAkMfMZJV8mAESvcafSI+r2b6bXzhGn7O3U2U+wTF7kATZFTLBZ2EIHorQVvm+2gOCd2K1RnTANfgP9mj0d67I60+IrrKUHc4ezKYSMptsRdo9ubS+5UNQ1D6nXRgIl4TLao6v2SJuwPNDPjG3MvNbWtyZ+l2Lh7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=UntmjAAj; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tCF38-00AKCl-Qn; Sat, 16 Nov 2024 10:25:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=xVQ7NElMWJv2muZgQTJ/fGMoxQ9I1cEMsg3js05cbQM=; b=UntmjAAj/s8OVVjhQdjCHmGnTa
	KsduCeN6XnUcn/2Jv1hYKJ2Kud6YUl33f3jtzz0tQ3i/g/Q24hycj1HV28eUqhik9L118uRhuhHiq
	jBH0YZLRR6HqBD1q4+utGTaCy4PDzckHsGV/Z5BvKUbHAMCIpzpIPv3zSlR0+PtmNP+I1hqihjy4i
	UU+iXTFzh9iOuhOa/WODf0e5DMqxXuoGFvUKA9JKCfWE8Rbx0PymmiXlSWr8EUh6JHD++UusmD04G
	SuSSK4ZTYu8cjbG+ZlT7BwyePtMcDd078Z6/4ULRF9iVvcyWt5tDLdZCJ/uctJX/xGlPWpCPqZH5l
	W4pYdgog==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tCF36-0000rQ-G9; Sat, 16 Nov 2024 10:25:00 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tCF33-00GPSH-Ma; Sat, 16 Nov 2024 10:24:57 +0100
Message-ID: <368a3808-f774-4aaa-9658-bf19db891f8f@rbox.co>
Date: Sat, 16 Nov 2024 10:24:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/4] llc: Improve setsockopt() handling of
 malformed user input
To: David Wei <dw@davidwei.uk>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>
References: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
 <20241115-sockptr-copy-fixes-v2-2-9b1254c18b7a@rbox.co>
 <84e5987e-ff03-4fab-a042-679f76f341e9@davidwei.uk>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <84e5987e-ff03-4fab-a042-679f76f341e9@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/24 01:59, David Wei wrote:
> On 2024-11-15 05:21, Michal Luczaj wrote:
>> copy_from_sockptr()'s non-zero result represents the number of bytes that
>> could not be copied. Turn that into EFAULT.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>>  net/llc/af_llc.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
>> index 4eb52add7103b0f83d6fe7318abf1d1af533d254..711c8a7a423f1cf1b03e684a6e23c8eefbab830f 100644
>> --- a/net/llc/af_llc.c
>> +++ b/net/llc/af_llc.c
>> @@ -1096,12 +1096,12 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
>>  	int rc = -EINVAL;
>>  
>>  	lock_sock(sk);
>> -	if (unlikely(level != SOL_LLC || optlen != sizeof(int)))
>> +	if (unlikely(level != SOL_LLC || optlen != sizeof(opt)))
>>  		goto out;
>> -	rc = copy_from_sockptr(&opt, optval, sizeof(opt));
>> -	if (rc)
>> +	if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
>> +		rc = -EFAULT;
>>  		goto out;
>> -	rc = -EINVAL;
>> +	}
>>  	switch (optname) {
>>  	case LLC_OPT_RETRY:
>>  		if (opt > LLC_OPT_MAX_RETRY)
>>
> 
> Can copy_from_sockptr() be deprecated here in favour of
> copy_safe_from_sockptr()?

Yeah, good point. I'll wait a bit and send v3.

Thanks!


