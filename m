Return-Path: <netdev+bounces-135742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843E999F08F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339CE1F2741B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F31D5171;
	Tue, 15 Oct 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I09r6oNo"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8F1B3954
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004483; cv=none; b=Q+KuK2m5DA2A67+VvQczw1i3W7Vcq91V6X95zrteA22emjufZMsXNTKaX1M/Pn864WGWNh9An43CJwPrkkBRlEfw5+l2gVDyqinR0DGFlhCkdvGzf9xXpcpz5OkV80C3E3CwzABBQdgy7FBiZmsg5rNfJK+iVqAczn0jN73w7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004483; c=relaxed/simple;
	bh=W2Z36YzS+zQ/JkX6qpIhdQwCMzbvPd4PV0t9AnGn05o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiAKLCUnyoc+sRF37PqnRVErhPwwB7aa2fZKH21v0Xu+7L9CPmccQM2QKdWZVgmI/reFMW5gyBnrYDOWPuurf745Sei/7PudnQox2s1SapcKnSSLeA9xzrN7ROPMhCFZP4PB7WE7nk3jyrruSlGfY9GScJJuAsmBUtbb1xybBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I09r6oNo; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7934306e-08f9-478a-a218-1b03dbfa8a3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729004478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvlH85oQ6iOL/O80idNbdKO+XjWHdxu9R9dMVnNAk/A=;
	b=I09r6oNoSZ0c2o94+JEcE5mrZH4TCEO6dCSVJd+rxHSuv4UvXWSxN4cMWOW4uhTDZkOxax
	M4qQNQ426H7cxx28hLk2u4rrTlj7SnQJkiuzgtI9u2mMRlXLyDM+h3K0HjbW0Gq+1xE6bO
	do1hORC3ST16amyfcbRCC7dUa9ST6Fk=
Date: Tue, 15 Oct 2024 16:01:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, arkadiusz.kubalewski@intel.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
 <2ec44c11-8387-4c38-97f4-a1fbcb5e1a4e@linux.dev>
 <Zw6Cg1giDaFwVCio@nanopsycho.orion>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <Zw6Cg1giDaFwVCio@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/10/2024 15:56, Jiri Pirko wrote:
> Tue, Oct 15, 2024 at 04:50:41PM CEST, vadim.fedorenko@linux.dev wrote:
>> On 15/10/2024 15:26, Jakub Kicinski wrote:
>>> On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:
>>>> +    type: enum
>>>> +    name: clock-quality-level
>>>> +    doc: |
>>>> +      level of quality of a clock device. This mainly applies when
>>>> +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>>>> +      The current list is defined according to the table 11-7 contained
>>>> +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>>>> +      by other ITU-T defined clock qualities, or different ones defined
>>>> +      by another standardization body (for those, please use
>>>> +      different prefix).
>>>
>>> uAPI extensibility aside - doesn't this belong to clock info?
>>> I'm slightly worried we're stuffing this attr into DPLL because
>>> we have netlink for DPLL but no good way to extend clock info.
>>
>> There is a work going on by Maciek Machnikowski about extending clock
>> info. But the progress is kinda slow..
> 
> Do you have some info about this? A list of attrs at least would help.

The mailing list conversation started in this thread:
https://lore.kernel.org/netdev/20240813125602.155827-1-maciek@machnikowski.net/

But the idea was presented back at the latest Netdevconf:
https://netdevconf.org/0x18/sessions/tutorial/introduction-to-ptp-on-linux-apis.html

>>
>>>> +    entries:
>>>> +      -
>>>> +        name: itu-opt1-prc
>>>> +        value: 1
>>>> +      -
>>>> +        name: itu-opt1-ssu-a
>>>> +      -
>>>> +        name: itu-opt1-ssu-b
>>>> +      -
>>>> +        name: itu-opt1-eec1
>>>> +      -
>>>> +        name: itu-opt1-prtc
>>>> +      -
>>>> +        name: itu-opt1-eprtc
>>>> +      -
>>>> +        name: itu-opt1-eeec
>>>> +      -
>>>> +        name: itu-opt1-eprc
>>>> +    render-max: true
>>>
>>> Why render max? Just to align with other unnecessary max defines in
>>> the file?
>>


