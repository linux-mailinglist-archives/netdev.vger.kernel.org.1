Return-Path: <netdev+bounces-145102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A549C9633
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D99281047
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE41B21A0;
	Thu, 14 Nov 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OlUtC1IW"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8395674E
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627407; cv=none; b=kEeZv5t3MxdXg8I8+TIQg4r5hWE2OE1Y195TN2SvbTX65HlLiJKLuLEm5pWEWlGZxdUE2mQ1TcXe7fx7bFOKR/VeMTEEPKNjsqVnW9wCER/k10rUOLaOXA85ulRM87kA/tNuIPNWUpu5X9cTD2bPebtsiYE/paLPGOvQfUxkG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627407; c=relaxed/simple;
	bh=kbJLT/qMDdSWDsoUBhaua+4Cy3c5O1rs5oyoM6SanBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d21IqAm/yH0MiXJX/tbMnyTTfO16gjNSMrY0dcir6YbUHtUFmE9XdYLlXukBjgzzUlvAVhO3UYL6YFwqL6iFfDy/TRAoB+ck7zE/4c05jrzwXRXgZZzHWV7JSzJnuLPiLMvsDeUNYtBTZ+R9bpupOqAlrSC+P3YV0n1pxf3snzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OlUtC1IW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBjOE-005zIs-Us; Fri, 15 Nov 2024 00:36:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=xpYonVJg0vhVI01Htvc+fv0/qPa7fqTcqhpYqG6MZ8g=; b=OlUtC1IWxs5O8wcfhR0IZ31KFD
	S4o/4FeBmchL5NT0zUVwIfbTklMD4wYnBfreyBpPB62fscYb6knX57dLrp3WoY7G0Y2Og1whSIk2J
	xxxjQGwveCvt2sky+rbrraAEYVp7N22uCEyybsVoPtYt0TkqxodJShUA5pZmRHvIByxuISI7X6Ijk
	FxtxHBmihaIiqlXMHS0AWioqn0uMv4aOkXD4b07hSb27YhQ1Mi3RS5UzfO6WYTytbrXvsiqZjTRzr
	mM+hb5FPNr35qKEgUn53sOZ3Mwe40Nd/5P9RdiSQxSS1K9atACNvOkJxmu4SSdFqmMSIByNVISHv5
	JrV7h+ig==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBjOE-00064z-Iz; Fri, 15 Nov 2024 00:36:42 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBjO8-00B7Cw-V9; Fri, 15 Nov 2024 00:36:37 +0100
Message-ID: <535b4ef7-3cfb-4816-bd7e-c0fa8725c7f8@rbox.co>
Date: Fri, 15 Nov 2024 00:36:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Make copy_safe_from_sockptr() match
 documentation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20241111-sockptr-copy-ret-fix-v1-1-a520083a93fb@rbox.co>
 <20241113192924.4f931147@kernel.org>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <20241113192924.4f931147@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 04:29, Jakub Kicinski wrote:
> On Mon, 11 Nov 2024 00:17:34 +0100 Michal Luczaj wrote:
>> copy_safe_from_sockptr()
>>   return copy_from_sockptr()
>>     return copy_from_sockptr_offset()
>>       return copy_from_user()
>>
>> copy_from_user() does not return an error on fault. Instead, it returns a
>> number of bytes that were not copied. Have it handled.
>>
>> Fixes: 6309863b31dd ("net: add copy_safe_from_sockptr() helper")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> Patch has a side effect: it un-breaks garbage input handling of
>> nfc_llcp_setsockopt() and mISDN's data_sock_setsockopt().
> 
> I'll move this to the commit message, it's important.
> 
> Are you planning to scan callers of copy_from_sockptr() ?
> I looked at 3 callers who save the return value, 2 of them are buggy :S

Sure, I took a look:
https://lore.kernel.org/netdev/20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co/
Have I missed anything?

Thanks,
Michal


