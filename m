Return-Path: <netdev+bounces-176595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C43A6AFB3
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4679E1892082
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF3722A4E5;
	Thu, 20 Mar 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0LCjV9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB961E5205;
	Thu, 20 Mar 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505263; cv=none; b=O1ZtwqFzNE9N9Z0ECDbuAARn2Y2cf0w5GcHiOt7fNvWrQd7GDS9R1J8koI4cAMtJ4A+CfchUnJlvrco9E8ov3WR2gWwrVuNhCrCUmVF5fOvAkeOmakr7fB6VL5jXT6k+6gI3PulLlNihr21pdYA6aU8v4epAoTQgaPHJyNwZTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505263; c=relaxed/simple;
	bh=rDnOAA4lucrldV/uOPZAcMt+11QMeVvynKOYtUfZiVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYt0AalbpmelyfNCC/LQjcbqomedZToB6B7gPt5svKos9qoT/w0kdxIQ3mtVAcUgWFP7e8gW01K7Nd1WUpQT75mXkdfwoep3La9IJu6AsVyk7M+m4q/9ZzqFkFu1FTHsoW0RQox9me7r5uy3mGE5dr0Bh1/qwhCX1OuGCLSz1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0LCjV9m; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6ff2adbba3fso10914507b3.2;
        Thu, 20 Mar 2025 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742505260; x=1743110060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vR0a3RR/t05HfQIX2qz1HHcu0hel3X1oYKiWEBUqDO8=;
        b=d0LCjV9mj5PvVbrFuiWIklOvo8xwGWBqVKCpbu5dpgET880kwDmv1b8DX8w5Yj54iJ
         RiqF6gvGmSs0aunJmv+GnzVTMzkTrwu8U6ef9AAwsM9eLgeA2rDixGrXBfkIuS7z7VAi
         vqOkRM/+JwVTn6nqjLNEQSGOoRQEFEbjtnu7HY8aPy+XqfYsSxHnYPFuBwV/q/acQihH
         I2v0VttbyQL12qU7bJmOpCLRz2Ja9Txf9DT3Pg9H3TFA+/NXB41aJyvjDCjTuHh16g1a
         wmAPOqk4qCgMq8BKjJ+omSovDRpBXikWc51mCeySKHbMlh2UO2a+RzJM37JGI+6DjjV4
         rOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742505260; x=1743110060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vR0a3RR/t05HfQIX2qz1HHcu0hel3X1oYKiWEBUqDO8=;
        b=A/K478fsGPUONrU6hdEXfLZoo2rIqqzSkh3+hDDUurkCOfXnP61ER2paj18imfuD0O
         5Ix8x4jeo/yj541ptRCrST7pAOXg0Pw+y9yuxe1I0KtPpst5uXujvNPlOPghgZaM/N3d
         w0hXw3JFaE4nd5fPx0YHjI4zrtWJ5I5RCIfcV7RXcVSK5fIwfwDIgOT42lNJMMXQMYbS
         Hs4MGtCOD9PJ446wNuVhYl7EP5pUF4gWRhwu+iGzw3Gz9uZdvpr/C8fjcnhvkJYyYg1c
         b4HeoGKjHKO0gQWqYweUB8QuydWC5Ps+/OWBpciYo0PmnHOQcubSAgkWGvJA8W/7FTMu
         kYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgFLyxp9Exs78+Kpj+wQh3/mW2sbPnUMwb48aIlZamxwJOJKzxFs6H91e21g8f0PxcCG8LjqvO@vger.kernel.org, AJvYcCWoXsiQ+oMq0FQxrMYs8BAAoCnKWQcG0JX+u+w9JoUy7LbfqeOxEL/Qnie3wVS4uWtkUAepoaxYvfS1fD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3F/jEnMLi8kLnaFqTjgoct4Hs/l4ZyJFjy7NT4jhtDPG8fcN
	CueagAwZ+8FBRBmHqNjQKX8jHFo8hzkiIp3yGIC67HSnzUv4DFcy
X-Gm-Gg: ASbGnct5JGYIFNwb369KGfBIDxEFEaLwioUFaFajHUk744phrQPZ5DdkXhR3Wxfpc52
	DQB9z9xUbDlhStbrs/lRTv4xvkkA9KUSMY13wPGMTBBT+FG4EUaL0wtj7NrRLdqYxvy8X4FOrHe
	HE8lkqV5UrXl8tiHOWPxNHA0nF8FE2dN7+D4JJkwfQaV8tCKt9Bx1VHUbuxbBQc9TWGpT7BEi3S
	ShtaSDoJ5LHBVyMQ5oaytP3xuhJRbbgI9Md6xv4vEut9aRb55XV9tasaO1IMLVmB9U99fcYfhPA
	8GnwbKy/2SR1BOkxG10kjvou6JEwzGBCluLscKSQEMYCxt+0xsdJWTswWgJB7q3U04EgS4ebB0S
	GTg==
X-Google-Smtp-Source: AGHT+IE3vy33qwuh10B1jPT96uPQFPJ0L0/5fq+sJdaJhhmDghj5RFArk99tKxN3tnEQGZjxTVWlEg==
X-Received: by 2002:a05:690c:3806:b0:6fb:9b19:ab49 with SMTP id 00721157ae682-700babfd37amr13100057b3.6.1742505260028;
        Thu, 20 Mar 2025 14:14:20 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba8c6b86sm980607b3.121.2025.03.20.14.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 14:14:19 -0700 (PDT)
Message-ID: <52b437bc-3f0e-4a5e-ae18-aea6576eb1ad@gmail.com>
Date: Thu, 20 Mar 2025 17:14:19 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 0/3] Add support for mdb offload failure
 notification
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <039a0673-6254-45a0-b511-69d2a15aa96d@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <039a0673-6254-45a0-b511-69d2a15aa96d@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/2025 2:17 AM, Nikolay Aleksandrov wrote:
> On 3/19/25 00:42, Joseph Huang wrote:
>> Currently the bridge does not provide real-time feedback to user space
>> on whether or not an attempt to offload an mdb entry was successful.
>>
>> This patch set adds support to notify user space about successful and
>> failed offload attempts, and the behavior is controlled by a new knob
>> mdb_notify_on_flag_change:
>>
>> 0 - the bridge will not notify user space about MDB flag change
>> 1 - the bridge will notify user space about flag change if either
>>      MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
>> 2 - the bridge will notify user space about flag change only if
>>      MDB_PG_FLAGS_OFFLOAD_FAILED has changed
>>
>> The default value is 0.
>>
>> A break-down of the patches in the series:
>>
>> Patch 1 adds offload failed flag to indicate that the offload attempt
>> has failed. The flag is reflected in netlink mdb entry flags.
>>
>> Patch 2 adds the knob mdb_notify_on_flag_change, and notify user space
>> accordingly in br_switchdev_mdb_complete() when the result is known.
>>
>> Patch 3 adds netlink interface to manipulate mdb_notify_on_flag_change
>> knob.
>>
>> This patch set was inspired by the patch series "Add support for route
>> offload failure notifications" discussed here:
>> https://lore.kernel.org/all/20210207082258.3872086-1-idosch@idosch.org/
>>
>> Joseph Huang (3):
>>    net: bridge: mcast: Add offload failed mdb flag
>>    net: bridge: mcast: Notify on offload flag change
>>    net: bridge: Add notify on flag change netlink i/f
>>
>>   include/uapi/linux/if_bridge.h |  9 +++++----
>>   include/uapi/linux/if_link.h   | 14 ++++++++++++++
>>   net/bridge/br_mdb.c            | 30 +++++++++++++++++++++++++-----
>>   net/bridge/br_multicast.c      | 25 +++++++++++++++++++++++++
>>   net/bridge/br_netlink.c        | 21 +++++++++++++++++++++
>>   net/bridge/br_private.h        | 26 +++++++++++++++++++++-----
>>   net/bridge/br_switchdev.c      | 31 ++++++++++++++++++++++++++-----
>>   7 files changed, 137 insertions(+), 19 deletions(-)
>>
> 
> Hi,
> Could you please share more about the motivation - why do you need this and
> what will be using it? 

Hi Nik,

The API for a user space application to join a multicast group is 
write-only (and really best-efforts only), meaning that after an 
application calls setsockopt(), the application has no way to know 
whether the operation actually succeeded or not. Normally for soft 
bridges this is not an issue; however for switchdev-backed bridges, due 
to limited hardware resources, the failure rate is meaningfully higher.

With this patch set, the user space application will now get a 
notification about a failed attempt to join a multicast group. The user 
space application can then have the opportunity to mitigate the failure 
[1][2].

> Also why do you need an option with 3 different modes
> instead of just an on/off switch for these notifications?
> 
> Thanks,
>   Nik
> 

Some user space application might be interested in both successful and 
failed offload attempts (for example the application might want to keep 
an mdb database which is perfectly in sync with the hardware), while 
some other user space application might only be interested in failed 
attempts (so that it can retry the operation or choose a different group 
for example).

This knob is modeled after fib_notify_on_flag_change knob on route 
offload failure notification (see 
https://lore.kernel.org/all/20210207082258.3872086-4-idosch@idosch.org/). 
The rationale is that "Separate value (read: 2) is added for such 
notifications because there are less of them, so they do not impact 
performance and some users will find them more important."

Thanks,
Joseph

--

[1] 
https://datatracker.ietf.org/doc/draft-ietf-pim-zeroconf-mcast-addr-alloc-ps/, 
section 2, the last paragraph
[2] 
https://datatracker.ietf.org/doc/draft-ietf-pim-ipv6-zeroconf-assignment/, 
section 2.1, the first paragraph

