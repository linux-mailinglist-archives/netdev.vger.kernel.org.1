Return-Path: <netdev+bounces-289803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMuiAERiDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:27:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E5F588EFB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D1D307DFCF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5401934DCC8;
	Wed, 20 May 2026 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="gYAL9/80"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D624F369D56
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261781; cv=none; b=B7CQEXBaJc+K6socS9IUnokIjf2qCGYIZVOhegbeSU64kd7a45H7LHP/OrL+SAXIRM5lB2W1+yLRVJu3M4IMKSnc+hXAifgdpYypGC/pFhzHY+k7UDIX7+E6MlLujdZvganBHqh2t1O79CJEpgmBgyzcstwsBygUyBhj51xYCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261781; c=relaxed/simple;
	bh=y0jcLSwtJI2Japs52LRtCy+PtQOeLK5jVUJPsCYdyTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiWpRoICXUtg2AO7vumwpG79bdteCNGcAQC02DNQW42xzszkDonoL8EGnmlgHAHVW5iR2AdUc6F4JKoB5TzP+5W0/++E9czO9/99hyNvRBEtiHZW65qFfBXOcokH6wDWXU5nrEu41758jzUBWDoFRwJD5YK0hVLKvj+/Oi5fXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=gYAL9/80; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7670826bso339253f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779261777; x=1779866577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zuRDqarJdWS7JEf2bJHF7uFUerb4dfY2s042IFgbB1c=;
        b=gYAL9/803BPT1wDlYJkSJuW4e4galuYRriDWX+rdxP9zAtqMpZPb4R0+IWFnQU0DpN
         cuGviGQYKgcbFZlNuyZcnxhm//bgg7ouFzU5ypuSYQWCeoV3obdf6tKcXlWkRt09k6MD
         MuqDELsLJpMFUlTuU62nm6j8n0K7NKSpPwkkFGEVe1vbpblk0WIG7y/wdGL+/SVFRnpD
         YXREJD/SGknpEdsCygerK66RmOQkUaT/KW+zXo1lHHmXL4gt1H/PPchscQSCsr+O56f2
         1hoimUtJEDZdcaFQxQTWeYlxhs6TYDgCdBDk0QH80LWQKohsa9deHfBriA952afp5TsA
         bkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261777; x=1779866577;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuRDqarJdWS7JEf2bJHF7uFUerb4dfY2s042IFgbB1c=;
        b=EJbJ2fbWYl0oVSjod5FjrPJLIOnNij7TKc0x2XcYS8DvPcNTVUEXvNraBMknaAwGc9
         GxxuY9TFNFlweJMgwgRkvX0m5tgSxenNiU53ThvGpCDu47hFGbuOd8enUAPCM+9yCRzf
         +WrZr8ZEc2gWZ9yDm5ivgHU7BE1+gftIASLefn5r4NDQXhGwIg5VqJopJ/PVFPWUqJ2I
         KWgbaDjkjjM9mkvltIBZZH5GqEUl7soFxuIqTrgdLfB16/JFVuQjv+DwcFCjSM3qmZqJ
         I221OtqWdU77N0IxHEyDgHVvUSm9EBrOWIMDkbeeLLfmIHmqrVZKlZyRNnzH5Q5UUM1W
         E8jA==
X-Gm-Message-State: AOJu0Yz4kg2zEa8hK27XYJglkDTWqyN8VXa4IQoF2PGABbb3QZPdRkDZ
	V4OkQYtfAzgzWIFfFDJ5YhxsCcKYdwrjqipwfn6f9b6yYcN6lULFFtStdya7oOUNQ7A=
X-Gm-Gg: Acq92OFbrYddMIzBoL8XoPl333A/fkaHuF6FEnykYBHhp5OoRtYX/HgyRldrMq2OjZO
	LABfqQRp26513xkQsXkCYm+8ipphW6Bin0p5ifguVJVe/ttEb3nPkI9MzWlmgwNRzu59BS93J1p
	83U3tVj1N5XU5NHd44FOnblaR0PEWuXUypUh0f1skOIniEQ4SMQPigCOo5rymsG82YrS3i+jKOz
	tqpivylEKqQgagxAnSa/BbDeUjY+1HOtpQ1etM0vebG+AS3IOLdZFZ/Yrvfn4RQ/lATenorffnO
	qLjqEJfVQNM/rMUQx/w/SBvY38sZlrppsp3+tCKYH+i5VAwCepnhZ/dAY0nZ5IwJfNSBov2kBk0
	r5YDi4Di5ZaizO/EXt0lObjqOkxUzuXGa8O+DMR46ai0f0CJLYk/nChbPylov0E7oj1tRIMYnyx
	sIVv3wf4WaM71Ybegkm8Cus2JHWVmF1Si6lYSjW+UXLvvjjpN40PFkVS1ontvanII=
X-Received: by 2002:a05:600c:4513:b0:48a:5501:799a with SMTP id 5b1f17b1804b1-48fe664c27cmr173624035e9.5.1779261777104;
        Wed, 20 May 2026 00:22:57 -0700 (PDT)
Received: from [172.31.99.185] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm412983955e9.7.2026.05.20.00.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:22:56 -0700 (PDT)
Message-ID: <c53e7ba3-d3c1-43a0-b38a-25b42091f9b8@6wind.com>
Date: Wed, 20 May 2026 09:22:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4 devconf
 netlink notifications
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-3-fmancera@suse.de> <20260513193544.47970cb8@kernel.org>
 <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
 <20260514162429.366b94c9@kernel.org>
 <f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
 <20260515181623.5a44140e@kernel.org>
 <f5cae72f-93c7-41d7-b7db-2b60281afb72@suse.de>
 <20260518142346.4c0903de@kernel.org>
 <54f7f213-9783-42c0-8ae8-51a6b65b7b5d@redhat.com>
 <b8b89071-6f17-4f6a-8a06-101056f780fd@6wind.com>
 <f2cd87f0-e173-4af7-9bc8-3a1f38c58c06@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <f2cd87f0-e173-4af7-9bc8-3a1f38c58c06@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-289803-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:replyto,6wind.com:mid,6wind.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58E5F588EFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 19/05/2026 à 23:27, Fernando Fernandez Mancera a écrit :
> On 5/19/26 3:45 PM, Nicolas Dichtel wrote:
>> Le 19/05/2026 à 09:17, Paolo Abeni a écrit :
>>> On 5/18/26 11:23 PM, Jakub Kicinski wrote:
>>>> On Sat, 16 May 2026 09:02:27 +0200 Fernando Fernandez Mancera wrote:
>>>>>>> Oh sorry, I should have clarified it. ip netconf only shows/query them
>>>>>>> but it cannot set them AFAICS.
>>>>>>>
>>>>>>> Usage: ip netconf show [ dev STRING ]
>>>>>>
>>>>>> Oh, fun. anyway, you gotta find a better way. Or just give up on the
>>>>>> selftest, the YNL hack is too ugly to live
>>>>>>    
>>>>>
>>>>> Fair, let me see what I can do. Otherwise, Paolo as you requested the
>>>>> selftest, would it be acceptable for you to drop it given the situation?
>>>>> I looking for alternatives anyway :-)
>>>>
>>>> Maybe extend iproute2 ?
>>>
>>> Ideally I think extending iproute2 would be the better solution.
>>> @Fernando: perhaps you could update the self-test accordingly, adding an
>>> explicit check for the iproute subcommand. If `ip netconf set` is not
>>> available skip the test, so that iproute2 patches could land later.
>>>
>>> Does the above look feasible?
>> FWIW, netconf != devconf.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
>> include/uapi/linux/ip.h#n156
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
>> include/uapi/linux/netconf.h
>>
>> The devconf API exposes all sysctl of an interface via RTM_NEWLINK /
>> IFLA_AF_SPEC / IFLA_INET_CONF. There is no event when a sysctl changes.
>> These sysctl can be set via RTM_SETLINK.
>>
>> The netconf API (RTM_NEWNETCONF) is a notification mechanism used to notify
>> users when a sysctl changes. It handles sysctl from interfaces but also from the
>> 'all' and the 'default' entries. RTM_GETNETCONF is also supported, but not
>> RTM_SETNETCONF.
>>
>> 'ip netconf' uses the netconf API.
>>
> 
> 
> I think we can reword this to.. "extend iproute2 to support setting devconf
> values"? If the naming or implementation on iproute2 is not clear now, we can
Yes.

Nicolas

