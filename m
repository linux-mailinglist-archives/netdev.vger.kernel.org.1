Return-Path: <netdev+bounces-222813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF9DB563B6
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 01:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41621B23D75
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 23:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA32C0F76;
	Sat, 13 Sep 2025 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="tOV+nw/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56552C08AF;
	Sat, 13 Sep 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805300; cv=none; b=DfzL8WMbSV4S8mvznKz2M1QMSvfAv1OO+CyhiVVgik5yNnG0xEQXrim0++zI5Nfe/Fe/QpVMSujm23DcIK+MXADLXsb52Eod+hsyKQqpLgsRdQ4eji1UmwG3OpmypF9IUqknQmhFMmL0MmwsVeCsAiQkildUG1uCzjT7v8M5/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805300; c=relaxed/simple;
	bh=+X0K9xXdiMhcaEkHVTC+tVGGKcvuzFs/78YZvn5FjyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwCSNhY7/fSk33sDalWxaz14PTN+fqD5sao0TjdQ0K6SvebmzZvcHEc9R/rGVWmPoz9ZzuSYXyHAtXPQIXY4buCLx3ws+lhOEC1ShxeXqbhbSC8Q654F36vVI5TSMjC1CwAtwwbJpE/GZF+5JnOJdDXcupVFhhHvhTsS0JGcfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=tOV+nw/1; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757805289;
	bh=+X0K9xXdiMhcaEkHVTC+tVGGKcvuzFs/78YZvn5FjyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tOV+nw/1UJhrDKxJST+XdYNNyzVTehWOnvxKaWp9fLnE6zALZJr62OSWXUs4M6Hgg
	 nuv006MBvkwnvAumZIzgH+OT2FKywU8cteYu/rAcL5GXxnNXncy2h9+sajtUQXORgp
	 9YXWDIs8XUWtub5430bQ/olj/jUgPVZGGR9+1mnH5mCjDf6a0O9e1D2r4RcPPw97Ec
	 ef3uIH2Lihpqjot9aITUHmbv0nlC43LL1j4TcqH4e/SeDp+lLV9BbJlNOoIbMJb1VB
	 kV8ggn6rqKBTWOVAZycuqZc280nW15ywckUF+QfprunwDx8pYay3EteaoGwacn5xa5
	 i0bvR9WIaFWsw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2C19B60128;
	Sat, 13 Sep 2025 23:14:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 7B4FC201010;
	Sat, 13 Sep 2025 23:14:33 +0000 (UTC)
Message-ID: <9211971b-a392-4568-b147-d7e97c69ca54@fiberby.net>
Date: Sat, 13 Sep 2025 23:14:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/13] tools: ynl-gen: only validate nested
 array payload
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Sabrina Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911200508.79341-1-ast@fiberby.net>
 <20250911200508.79341-9-ast@fiberby.net> <20250912172742.3a41b81e@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250912172742.3a41b81e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/25 12:27 AM, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 20:05:01 +0000 Asbjørn Sloth Tønnesen wrote:
>> +int ynl_attr_validate_payload(struct ynl_parse_arg *yarg,
>> +			      const struct nlattr *attr, unsigned int type)
>> +{
>> +	return __ynl_attr_validate(yarg, attr, type);
>> +}
> 
> Why not expose __ynl_attr_validate() to the callers?
> I don't think the _payload() suffix is crystal clear, we're still
> validating attr, _payload() makes it sound like we're validating
> what's inside attr?

I didn't wanna call __ynl_attr_validate() directly, as the only __ynl_*
function in ynl-priv.h is __ynl_attr_put_overflow(), and that is only
used in other static functions within that file. I agree, that _payload()
might not be the best given that we currently don't look deeper than
validating that the length a bit, so maybe _length() would have been
better.

In v4, I have changed it to just expose __ynl_attr_validate() in
ynl-priv.h, and changed ynl_attr_validate() to an inline function.

