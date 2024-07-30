Return-Path: <netdev+bounces-114453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1C1942A32
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E751F25B2C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D631AAE32;
	Wed, 31 Jul 2024 09:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C221A8C06
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417421; cv=none; b=F8iiaqhAS1l6TKILqBjQnpSsYmdSd6sF4hvP0PQGSmgscFiLO8Bass+uq6SKxXiophPv3HSDO0I0adjUoZMQsHEq6X3R6jGKt5embU4XH9F3giAPPu6RbmN1AecRcA9t+vnHmnIlEwpqcJ/vPXhM5qnJJH/lNY1mxamU4hgGI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417421; c=relaxed/simple;
	bh=8pe7bMqvwyxniR00yf0UDCmwaivCv9A2LElfGIRgcDQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Egwr2Xa1czKe7jcB0Zv30Y0Mmk/EvzdkBOhafYTlG6Qjpl5cOnI145Bij9SXmyM6rZV3ONXJD+Z9uVDFGngfpNaZ/JbXh52MD33ng2ryWgFwz2KMXYeIWJMJiskonjLQlqyH7hcb0HUZkybmdZxxJrumsYGHpJLJSDvF1asggPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B67967D052;
	Wed, 31 Jul 2024 09:16:52 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-7-chopps@chopps.org> <ZqJT4llwpzag1TUr@hog>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 06/17] xfrm: add mode_cbs module
 functionality
Date: Tue, 30 Jul 2024 17:29:06 -0400
In-reply-to: <ZqJT4llwpzag1TUr@hog>
Message-ID: <m28qxhapkr.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2024-07-14, 16:22:34 -0400, Christian Hopps wrote:
>> +struct xfrm_mode_cbs {
>
> It would be nice to add kdoc for the whole thing.

Ok, I'll move the inline comments to a kdoc. FWIW, all the other structs in this header, including the main `xfrm_state` struct use the same inline comment documentation style I copied.

>> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>> index 7cee9c0a2cdc..6ff05604f973 100644
>> --- a/net/xfrm/xfrm_input.c
>> +++ b/net/xfrm/xfrm_input.c
>> @@ -494,6 +497,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>>
>>  		family = x->props.family;
>>
>> +		/* An encap_type of -3 indicates reconstructed inner packet */
>
> And I think it's time to document all the encap_types above the
> function (and in particular, how xfrm_inner_mode_input/encap_type=-3
> pair together), and/or define some constants. Also, is -2 used
> anywhere (I only see -1 and -3)? If not, then why -3?

At the time this was added ISTR that there was some belief that -2 was used perhaps in an upcoming patch, so I picked -3. I can't find a -2 use case though so I will switch to -2 instead.

Re documentation: I think the inline comments where encap_type is used is sufficient documentation for the 2 negative values. There's a lot going on in this function and someone wishing to change (or understand) something is going to have to walk the code and use cases regardless of a bit of extra verbiage on the encap_value beyond what's already there. Fully documenting how xfrm_input works (in all it's use cases) seems beyond the scope of this patch to me.

Thanks,
Chris.

