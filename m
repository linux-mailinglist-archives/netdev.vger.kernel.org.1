Return-Path: <netdev+bounces-301034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z+yXKBsROWoNmQcAu9opvQ
	(envelope-from <netdev+bounces-301034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E61726AEC5A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:40:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JY89DMa6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301034-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301034-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73CC6302925A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C26372073;
	Mon, 22 Jun 2026 10:39:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5E371D14
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:39:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124791; cv=none; b=iHWgJkGqfyZWa+Y+UWpC3Vt6d+bqW9e3wQtYi510ZOKqUhmCybREJ0MafrFeaweJCY/fV2JfugKD5j9ael7J0uAe6UkRLuvSpE3mz33iE5qMmrDMoBuMNhs6PpEymLPa6kQjRN+ZZfkFyJ2kLy2L/iGhA3upvtXZAVs4wRv6/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124791; c=relaxed/simple;
	bh=l7GE8ppv7syndesvKvd8fs/IZ33+/HRctLy+inIPAT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgXCfuCjejJjXxdWqB3pjWU/AG+s/NwL+/hME4RTLMWVRfmd+9SfJ7WcK4BC5sjRCY5bm4B0L8CR+18nCfRvKDM/LIRKL0JVrQdyTylsWrzzVIgzyos7SAcLB2wqNIeHB6aLzZbp7+48ZxpnjZv967PbUkMkzqJ9CSrFqgXsdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY89DMa6; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c07680fdd12so473517166b.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782124789; x=1782729589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SK/Fc7QLqT//mHxJWtHX0hIYStHzfhddF03i10bvQiw=;
        b=JY89DMa6VRJYVtaRoQPLvOUSrOWr+nIdErGXVPff36KZW4ZSdOxBjmb/U/eGDzWa4T
         54kghMeuQmfJ1ZwLyFcRGCkGLu0ocU+EdDbzRcsU8CQ/cnZ0QoOGNgiOKFdsIvQwsS3s
         3GAQeWYufnmLJpC4lg7alUhvM4WQS8jlUcjxaTIi5CYly8GsIfxQ8posFqvJ+tukKEgF
         328HRQ9tk6sk73pnOC8vUEOjDbfO8SWThppG3jboVR3bBVv7RypqrTC7HYXXrMUsuIdU
         i2wlD13bUatwwSP4rGf4V3mvQEuEexO5tvC6NaT3ruMKgnyV596eVezT281QDCvi/uR9
         vvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124789; x=1782729589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK/Fc7QLqT//mHxJWtHX0hIYStHzfhddF03i10bvQiw=;
        b=D87+4pv2gsIeAV28Hf5B48BuAJub6ZgUbtoAmNXulysaWdNMcmZi7jj6WcOGB9xtJp
         QSQzX6vJIsCQHB3V8qpi2A1vVK3QRZxhKYIUNpB4SYHfzaKOQNKHIaTrwajaM18WfjKO
         Yux8g8fnmAwoZFUbpEx5WMeToerFGWDPeQtKpqy9MZp120JV5+oqWqruqynZxRXpBvys
         yBw/fCQ2gqrleW6Mzyh30Gy2XtBE9Vxpgbww8KqPE70XppbZJa0bNiFBmongaZCJo+9h
         aq928IBgbnDomXRvIu/FbRN1K/9SY88TNGDGKAktmlRasYOT2MrMuxHNZC1IGRytCSRg
         VZ2Q==
X-Gm-Message-State: AOJu0YzKEmnN1b1oxkUaWSOF+22jjIa9PT+DhxP2ytPXN/o541+C3pfo
	nyuRfdActgpbQ1Sd8AcXIb8AogfQDmtbZM0+WBh1MIDjdAFzNCirEMVk
X-Gm-Gg: AfdE7ckX/HvwEz2rICwWhpIdyaTMTUrOrzlRoF6RrUNePFnHT59u55+9OD9wScCdJud
	TdiF6AF680FIP6tZf+ZaZQLExCSdbeD/CetYEmL/JvS1GCkKJW36pJ5KU44zRONL+EsIXQSnCek
	brn+b4s9ca+lSdxxNYu+ZlU+X7H9PXmEDqGynNdXSrOLA7u2Nig9CzB9XTTBadkhjBCflTLUX7t
	7cSvfD7HlBKSxkDkLF5gr/3+giS6LoqVMyBZ9BGYVFoYo5YSz0srgmP7X44+6VoXE1lG6Z2zoY6
	PovFXKmwO9bQVtj7DjI5c6ptz4HEqPqK4naF6a5shXX8iMLneWwKl52ROlKkpUsQMRKRgdw/OqU
	mxDdY9I0z0btlRTZNg5npYp53KG1EJJf/U86HMPJrd0xCuH0bXPSX6Q6N2nulx2zhNp9LYtv+uf
	TDJ1nsrSA4UdcVqo/sytbY268+WrY6DrHV1ZdXuoxpYyKPxkRJCAzwsRk=
X-Received: by 2002:a17:907:3f99:b0:bec:2ad0:cba5 with SMTP id a640c23a62f3a-c0b744a6dd6mr649220966b.29.1782124788696;
        Mon, 22 Jun 2026 03:39:48 -0700 (PDT)
Received: from ?IPV6:2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4? ([2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c61617677sm344922066b.60.2026.06.22.03.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 03:39:48 -0700 (PDT)
Message-ID: <e07eeab3-9cb2-4cdd-9831-0851c278ac43@gmail.com>
Date: Mon, 22 Jun 2026 11:39:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "ip help" output is an error
To: David Laight <david.laight.linux@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
 <20260621082105.1196ef72@phoenix.local> <20260622084925.6f3dfc4f@pumpkin>
Content-Language: en-US
From: Dmitri Seletski <drjoms@gmail.com>
In-Reply-To: <20260622084925.6f3dfc4f@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,networkplumber.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:stephen@networkplumber.org,m:netdev@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[drjoms@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[drjoms@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E61726AEC5A

Hello David,(sorry for duplicate, I keep on forgetting to turn off HTML)

Yes, user could do the redirection, but it's less convenient and 
counterintuitive. IMHO, it's just wrong.

Once user has done "ip help" - IMHO, exit code should be 0. Because user 
did run a command and it correctly executed with a reasonable 
results(provided help text).

And if exit code is 0 - then it reasonably stands that output data is 
standard output and not an error.


"it do exit(0) is likely cause new scripts to fail on old systems." - do 
I understand correctly, concern is that existing scripts that depend on 
current behavior will fail?

First of all, I am guessing that there are not many scripts that depend 
on "ip help".

Second of all, if there are such scripts and we follow this logic - do 
we ever patch anything? Since any script out there can depend on broken 
behavior that will be patched?

Third of all, people who wrote such scripts, should have reported bug 
here in the first place. But it's neither here nor there.


Do I fail to see a bigger picture here? Cause I feel silly talking in 
this mailing list.(I submitted a change for this issue about half a day ago)

Kind Regards

Dmitri Seletski


On 6/22/26 08:49, David Laight wrote:
> On Sun, 21 Jun 2026 08:21:05 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
>
>> On Sat, 20 Jun 2026 10:36:31 +0100
>> Dmitri Seletski <drjoms@gmail.com> wrote:
>>
>>> Hello iproute2 maintainers,
>>>
>>> I am reporting an inconsistency regarding the exit status of the ip help
>>> command.
>>>
>>> Current Behavior:
>>> When running ip help, the command prints the help documentation to
>>> stdout, but exits with a non-zero status (error). This causes issues in
>>> shell scripts that rely on exit codes for control flow.
>>>
>>> Steps to reproduce:
>>> bash
>>>
>>> # This returns "FAIL" because the exit code is non-zero
>>> if ip help > /dev/null; then
>>>       echo "SUCCESS"
>>> else
>>>       echo "FAIL"
>>> fi
>>>
>>> Expected Behavior:
>>> Since the command successfully performs the requested task (displaying
>>> help information) and does not encounter a system error, it should
>>> return an exit code of 0.
>>>
>>> Context:
>>> This behavior breaks standard Bash logic for automation. For example:
>>> ip help && echo "This will not execute"
>>>
>>> "ip help |grep br" - this will bring no result.
>>>
>>> Current version tested: iproute2-6.19.0
>>>
>>> Thank you for your time and for maintaining this tool.
>>>
>>> Regards,
>>> Dmitri Seletski
>>>
>>>    
>> Yes iproute2 doesn't do a great job of handling error codes
>> with usage vs help. Its a bug and no one has bothered to fix it.
>>
> The version I've got does write(2, "Usage...", 972); exit(-1);
> Changing it to do write(1, ...) is likely to break scripts, and making
> it do exit(0) is likely cause new scripts to fail on old systems.
>
> The 'grep' works fine if you redirect stderr to stdout.
>
> The exit(-1) is a bug; the parameter is only 8 bits and the high bit
> is expected to be used to indicate abnormal termination (eg by a signal).
> That should probably be changed to exit(1), there doesn't seem to be
> a standard way to differentiate between command line errors and
> operational ones.
>
> 	David
>

