Return-Path: <netdev+bounces-223645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E6B59D08
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7EB481D85
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFBA31FEEB;
	Tue, 16 Sep 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwEgc+uK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F031FED7
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038723; cv=none; b=KV0psaoMsLeD9PiLXvdeIktQYYKVJvbWD9aQ4w0a5dlWLpzi4hNGx/cPFudw6aPMssmec/72QVI8t6ikkPxD3mXZTQPmyy0Hsbd6SZVBiqRpWcaeynlJcL4dWvrtHxxaeYiXFyqF8fYFgufeFLOyReo4nUb8FC/HA/MPEoplwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038723; c=relaxed/simple;
	bh=oHRXTI+7kTCylfEAVG8J0Jcuvb/SZi6In82M6iQbx9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UExPDq2i0SmuaFR5nk/EV8YrVjIKVxwZK1bfomGkrHEr0MO/QKpto5gqYbLER0xUXIKY7hQZCE4k2BT8jiHm2rXPm/7dxznsvyuYaP+Z+w3W/XfDSyKfkild5iAxfs3J1b5U9C+H0HcZxEtnDao2wijiC6eBuE981olhxeONMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwEgc+uK; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-89336854730so86093739f.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038718; x=1758643518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONqPQabgnBykEY79xtJLoW2kJlD0fAbuF5tH/LZZvY4=;
        b=hwEgc+uKOOASdYm3rdlJMDo+4JxrEy/5/hTSdaHXnYVBPOuu9gEf5HkJBNUAaH4XPa
         zbPwydVC7oLmrskyLzIGYzD4bQXqE0Tszn6EjN+ys3R0k+A4ge0YFgRoGo55ai/0FiZX
         060rBblEnf2j6p1DN3zzLezZ42d4Eee2/weEq/wmxEKBE3u3ai//2Nl++XTflXaKmWId
         lhWOblrnzfDot7yo8kKPY6S5tXbWgqThEO3sTBhxi+jII6hBEzpQnPF+QsaYXnquNAp7
         uK6SgIkr7BjKD6P2uBzjIwjOhqFSgzJi3K6doG+0mGHpBQOr49SJphWPHMQv1VkDHuK3
         CatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038718; x=1758643518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONqPQabgnBykEY79xtJLoW2kJlD0fAbuF5tH/LZZvY4=;
        b=QEf05tRFpxjcStT3b8x+ILgsvj7vHMPqTkZfjmy0ADKKnPikYZS1yD+PPxLIE7NR+U
         eMJMVgFeOQ1MaYPqC0z9GPVkW8LMqDCwPImdv2GuZi+AzFxA0m1MbJVg6Au35LC0etuS
         BnFc34JnKq/999wm864dKiRYDCX0ss2kDAOwWrGL4ywceSQw0GNMQvZfHmif/I32EcUs
         h4Q1lG/iU9C+qVk4xHycQk27c/HtQGigiAnlGoHVTVtDaX3/hYscNSB4VgLquJ2O3iPw
         2a9qoHxnozgPdwQb+RVFG/N2YanrPbGGJJderCv4ZTIbYIUyJOpeNXBh5SH2JZs4Sdkg
         Cv3Q==
X-Gm-Message-State: AOJu0YyF4yKgaJlyQ4xbpuXgNQYeBrrMom3YjMpvFlzhMXAmmkjBfxEW
	LXwCJ+x3BCpeJCPqlz+OYkc2dP/5PISbY3e+uR+uSBtC+GPDkdKDtOlS6o7BeA==
X-Gm-Gg: ASbGnctlKW+v2deWM1Si9yZJae+OeiKsLIo3UnTWqQ7ObtFQLwVUvE7Jnt1YwnHH9lP
	RH29Na0vV8s6UoQg4ha5nCE19JK86I3FcuZ6w5Wbq8ovc9nwGznq7jYDJNuJkSnLhNghwN5qlxI
	EUEdiqS4KDzSgZd4jVyycaclhh8aOJ3niNHqfA6jaB8Hd8Yc58NYiiesZEVu9cqJgAkCHx/sjAo
	+pV/evEP5txgfOKGlNsypiZF5zyUy8pU4kO85PnMijRiWU904o2oBKi017uLrQAVeHsOvm4lBNQ
	Q0rmEAuqnNvRUkbMVpf2T9FX815hT+gs1feA/KFw+USga+GpzRKOrKXPyOa59wC99mS3XZ4invs
	VfW5OKBViDNtPyhQfe4jc7NNGnPJSQlikjNnBsj5Da+TD/nc1HO8vkhjNPRvoJ2X39fl0vKCpUY
	0Ia3KRh5YN
X-Google-Smtp-Source: AGHT+IFN3Gv+m9V0IfxaNnbV2KeWRy35X0A7U0enN8GwLniXySfimLqM3kZXWktP3rUws49tZfN/Rw==
X-Received: by 2002:a05:6e02:1567:b0:424:57d:1a53 with SMTP id e9e14a558f8ab-424057d1b5amr60694005ab.7.1758038718269;
        Tue, 16 Sep 2025 09:05:18 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:a4da:effc:65ff:6899? ([2601:282:1e02:1040:a4da:effc:65ff:6899])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-511f309b695sm6009326173.58.2025.09.16.09.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 09:05:17 -0700 (PDT)
Message-ID: <7d03fa72-b6ca-4f98-9f48-634ea45a0cc8@gmail.com>
Date: Tue, 16 Sep 2025 10:05:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 1/2] scripts: Add uapi header import script
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
 <20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
 <20250916074155.48794eae@hermes.local>
 <20250916180100.5f9db66d@kmaincent-XPS-13-7390>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250916180100.5f9db66d@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:01 AM, Kory Maincent wrote:
> On Tue, 16 Sep 2025 07:41:55 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
>> On Tue, 09 Sep 2025 15:21:42 +0200
>> Kory Maincent <kory.maincent@bootlin.com> wrote:
>>
>>> Add a script to automate importing Linux UAPI headers from kernel source.
>>> The script handles dependency resolution and creates a commit with proper
>>> attribution, similar to the ethtool project approach.
>>>
>>> Usage:
>>>     $ LINUX_GIT="$LINUX_PATH" iproute2-import-uapi [commit]
>>>
>>> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>>> ---  
>>
>> Script I use is much simpler.
> 
> The aim of my patch was to add a standard way of updating the uAPI header.
> Indeed I supposed you maintainers, already have a script for that but for
> developers that add support for new features they don't have such scripts.
> People even may do it manually, even if I hope that's not the case.
> We can see that the git commit messages on include/uapi/ are not
> really consistent. 
> 
> IMHO using the same script as ethtool was natural.
> The final decision is your call but I think we should have a standard script
> whatever it is.
> 
> Regards,

There are separate needs.

I sync include/uapi for iproute2-next based on net-next. rdma and vdpa
have separate -next trees which is why they have their own include/uapi
directories. This script makes this part much easier for me hence why I
merged it.

Stephen will ensure all uapi headers match the kernel release meaning
Linus' tree.

